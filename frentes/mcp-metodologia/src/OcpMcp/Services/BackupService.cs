using Microsoft.Data.Sqlite;
using OcpMcp.Security;
using System.IO.Compression;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

namespace OcpMcp.Services;

public sealed class BackupService(SqliteStore store)
{
    private sealed record Header(int version,string backup_id,string installation_id,string owner_sid,string created_at_utc,string database_sha256,string algorithm,string dpapi_scope,string wrapped_dek,string nonce,string tag);
    private sealed record Existing(string Id,string Path,string Created,string Tags);

    public bool EnsureStartupBackup()
    {
        using var c=store.Open();
        var backups=ReadBackups(c);
        string week=CurrentIsoWeek();
        var daily=backups.Where(b=>Tags(b).Contains("DAILY")).OrderByDescending(b=>b.Created).FirstOrDefault();
        bool dailyDue=daily is null || DateTimeOffset.UtcNow-DateTimeOffset.Parse(daily.Created)>=TimeSpan.FromHours(24);
        bool weeklyDue=!backups.Any(b=>Tags(b).Contains("WEEKLY:"+week));
        if(!dailyDue&&!weeklyDue)return true;
        var tags=new List<string>();
        if(dailyDue)tags.Add("DAILY");
        if(weeklyDue)tags.Add("WEEKLY:"+week);
        CreateBackup(tags);
        return true;
    }

    public string CreatePreUpdateBackup()=>CreateBackup(["PRE_UPDATE"]);

    public bool IsDailyCurrent(SqliteConnection c,SqliteTransaction? tx=null)
    {
        using var cmd=c.CreateCommand();cmd.Transaction=tx;
        cmd.CommandText="SELECT created_at_utc FROM backup_points WHERE tags_json LIKE '%DAILY%' ORDER BY created_at_utc DESC LIMIT 1;";
        string? value=cmd.ExecuteScalar() as string;
        return value is not null && DateTimeOffset.UtcNow-DateTimeOffset.Parse(value)<TimeSpan.FromHours(24);
    }

    public string CreateBackup(IReadOnlyCollection<string> tags)
    {
        string backupId=Guid.NewGuid().ToString("N");
        string backupDirectory=Path.GetFullPath(Path.Combine(Path.GetDirectoryName(store.DatabasePath)!,"..","backups"));
        Directory.CreateDirectory(backupDirectory);
        string stagingDb=Path.Combine(backupDirectory,$".{backupId}.db.tmp");
        string stagingPackage=Path.Combine(backupDirectory,$".{backupId}.ocpbak.tmp");
        string finalPackage=Path.Combine(backupDirectory,$"{backupId}.ocpbak");
        try
        {
            using(var source=store.Open())
            using(var target=new SqliteConnection(new SqliteConnectionStringBuilder{DataSource=stagingDb,Mode=SqliteOpenMode.ReadWriteCreate,Pooling=false}.ToString()))
            {
                target.Open();
                source.BackupDatabase(target);
                using var check=target.CreateCommand();check.CommandText="PRAGMA quick_check;";
                if(Convert.ToString(check.ExecuteScalar())!="ok")throw new InvalidDataException("BACKUP_DATABASE_QUICK_CHECK_FAILED");
            }
            byte[] database=File.ReadAllBytes(stagingDb);
            string databaseHash=Convert.ToHexStringLower(SHA256.HashData(database));
            string installationId,ownerSid;
            using(var c=store.Open())
            {
                var i=SqliteStore.GetInstallation(c)??throw new InvalidOperationException("INSTALLATION_NOT_INITIALIZED");
                installationId=i.InstallationId;
                ownerSid=i.OperatorSid??"UNPROVISIONED";
            }
            byte[] dek=RandomNumberGenerator.GetBytes(32);
            byte[] nonce=RandomNumberGenerator.GetBytes(12);
            byte[] cipher=new byte[database.Length],tag=new byte[16];
            try
            {
                byte[] aad=Encoding.UTF8.GetBytes($"OCPMCP|BACKUP|v1|{backupId}|{installationId}|{databaseHash}");
                using(var aes=new AesGcm(dek,16))aes.Encrypt(nonce,database,cipher,tag,aad);
                byte[] entropy=CryptoBox.BuildEntropy(installationId,"backup",backupId,"1");
                byte[] wrapped=CryptoBox.ProtectKey(dek,entropy);
                var header=new Header(1,backupId,installationId,ownerSid,DateTimeOffset.UtcNow.ToString("O"),databaseHash,"AES-256-GCM","CurrentUser",Convert.ToBase64String(wrapped),Convert.ToBase64String(nonce),Convert.ToBase64String(tag));
                byte[] headerBytes=Encoding.UTF8.GetBytes(JsonSerializer.Serialize(header));
                using(var fs=new FileStream(stagingPackage,FileMode.CreateNew,FileAccess.Write,FileShare.None,1024*1024,FileOptions.WriteThrough))
                using(var writer=new BinaryWriter(fs,Encoding.UTF8,true))
                {
                    writer.Write(headerBytes.Length);writer.Write(headerBytes);writer.Write(cipher);writer.Flush();fs.Flush(true);
                }
            }
            finally
            {
                CryptographicOperations.ZeroMemory(dek);
                CryptographicOperations.ZeroMemory(database);
                CryptographicOperations.ZeroMemory(cipher);
            }
            VerifyPackage(stagingPackage);
            File.Move(stagingPackage,finalPackage,false);
            string packageHash=Convert.ToHexStringLower(SHA256.HashData(File.ReadAllBytes(finalPackage)));
            string utc=DateTimeOffset.UtcNow.ToString("O");
            string tagsJson=JsonSerializer.Serialize(tags.Distinct(StringComparer.Ordinal).ToArray());
            using(var c=store.Open())
            using(var cmd=c.CreateCommand())
            {
                cmd.CommandText="INSERT INTO backup_points(backup_id,package_path,package_sha256,created_at_utc,tags_json,verification_status) VALUES($id,$path,$hash,$utc,$tags,'VERIFIED');";
                cmd.Parameters.AddWithValue("$id",backupId);cmd.Parameters.AddWithValue("$path",finalPackage);cmd.Parameters.AddWithValue("$hash",packageHash);cmd.Parameters.AddWithValue("$utc",utc);cmd.Parameters.AddWithValue("$tags",tagsJson);cmd.ExecuteNonQuery();
            }
            ApplyRetention();
            return backupId;
        }
        finally
        {
            TryDelete(stagingDb);TryDelete(stagingDb+"-wal");TryDelete(stagingDb+"-shm");
            TryDelete(stagingPackage);
        }
    }

    public void Restore(string backupId)
    {
        Existing item;
        using(var c=store.Open())
        {
            using var cmd=c.CreateCommand();cmd.CommandText="SELECT backup_id,package_path,created_at_utc,tags_json FROM backup_points WHERE backup_id=$id AND verification_status='VERIFIED';";
            cmd.Parameters.AddWithValue("$id",backupId);using var rd=cmd.ExecuteReader();
            if(!rd.Read())throw new InvalidOperationException("BACKUP_NOT_FOUND");
            item=new Existing(rd.GetString(0),rd.GetString(1),rd.GetString(2),rd.GetString(3));
        }
        byte[] database=DecryptPackage(item.Path);
        string target=store.DatabasePath;
        string temp=target+".restore.tmp";
        string rollback=target+".pre-restore-"+DateTimeOffset.UtcNow.ToString("yyyyMMddHHmmss");
        try
        {
            File.WriteAllBytes(temp,database);
            using(var verify=new SqliteConnection(new SqliteConnectionStringBuilder{DataSource=temp,Mode=SqliteOpenMode.ReadOnly,Pooling=false}.ToString()))
            {
                verify.Open();using var check=verify.CreateCommand();check.CommandText="PRAGMA integrity_check;";
                if(Convert.ToString(check.ExecuteScalar())!="ok")throw new InvalidDataException("RESTORE_INTEGRITY_CHECK_FAILED");
            }
            TryDelete(target+"-wal");TryDelete(target+"-shm");
            if(File.Exists(target))File.Move(target,rollback,false);
            File.Move(temp,target,false);
        }
        catch
        {
            TryDelete(temp);
            if(!File.Exists(target)&&File.Exists(rollback))File.Move(rollback,target);
            throw;
        }
        finally{CryptographicOperations.ZeroMemory(database);}
    }

    private static byte[] DecryptPackage(string path)
    {
        using var stream=File.OpenRead(path);using var reader=new BinaryReader(stream,Encoding.UTF8,true);
        int size=reader.ReadInt32();if(size<2||size>128*1024)throw new InvalidDataException("BACKUP_HEADER_INVALID");
        var header=JsonSerializer.Deserialize<Header>(reader.ReadBytes(size))??throw new InvalidDataException("BACKUP_HEADER_INVALID");
        byte[] cipher=reader.ReadBytes(checked((int)(stream.Length-stream.Position)));
        byte[] dek=CryptoBox.UnprotectKey(Convert.FromBase64String(header.wrapped_dek),CryptoBox.BuildEntropy(header.installation_id,"backup",header.backup_id,"1"));
        byte[] plain=new byte[cipher.Length];
        try
        {
            byte[] aad=Encoding.UTF8.GetBytes($"OCPMCP|BACKUP|v1|{header.backup_id}|{header.installation_id}|{header.database_sha256}");
            using(var aes=new AesGcm(dek,16))aes.Decrypt(Convert.FromBase64String(header.nonce),cipher,Convert.FromBase64String(header.tag),plain,aad);
            if(Convert.ToHexStringLower(SHA256.HashData(plain))!=header.database_sha256)throw new CryptographicException("BACKUP_DATABASE_HASH_MISMATCH");
            return plain;
        }
        catch{CryptographicOperations.ZeroMemory(plain);throw;}
        finally{CryptographicOperations.ZeroMemory(dek);}
    }

    private static void VerifyPackage(string path)
    {
        // The source database passed PRAGMA quick_check before encryption.
        // DecryptPackage verifies GCM authentication and the database SHA-256.
        byte[] clear=DecryptPackage(path);
        CryptographicOperations.ZeroMemory(clear);
    }

    private void ApplyRetention()
    {
        using var c=store.Open();
        var all=ReadBackups(c);
        var keep=new HashSet<string>(StringComparer.Ordinal);
        foreach(var b in all.Where(x=>Tags(x).Contains("DAILY")).OrderByDescending(x=>x.Created).Take(7))keep.Add(b.Id);
        foreach(var b in all.Where(x=>Tags(x).Any(t=>t.StartsWith("WEEKLY:",StringComparison.Ordinal))).GroupBy(x=>Tags(x).First(t=>t.StartsWith("WEEKLY:",StringComparison.Ordinal))).Select(g=>g.OrderByDescending(x=>x.Created).First()).OrderByDescending(x=>x.Created).Take(4))keep.Add(b.Id);
        foreach(var b in all.Where(x=>Tags(x).Contains("PRE_UPDATE")||Tags(x).Contains("MANUAL")))keep.Add(b.Id);
        foreach(var b in all.Where(x=>!keep.Contains(x.Id)))
        {
            TryDelete(b.Path);
            using var cmd=c.CreateCommand();cmd.CommandText="DELETE FROM backup_points WHERE backup_id=$id;";
            cmd.Parameters.AddWithValue("$id",b.Id);cmd.ExecuteNonQuery();
        }
    }

    private static List<Existing> ReadBackups(SqliteConnection c)
    {
        var list=new List<Existing>();
        using var cmd=c.CreateCommand();cmd.CommandText="SELECT backup_id,package_path,created_at_utc,tags_json FROM backup_points WHERE verification_status='VERIFIED';";
        using var rd=cmd.ExecuteReader();while(rd.Read())list.Add(new Existing(rd.GetString(0),rd.GetString(1),rd.GetString(2),rd.GetString(3)));
        return list;
    }
    private static HashSet<string> Tags(Existing b)=>JsonSerializer.Deserialize<string[]>(b.Tags)?.ToHashSet(StringComparer.Ordinal)??new();
    private static string CurrentIsoWeek(){var now=DateTime.UtcNow;return $"{System.Globalization.ISOWeek.GetYear(now)}-W{System.Globalization.ISOWeek.GetWeekOfYear(now):D2}";}
    private static void TryDelete(string path){try{if(File.Exists(path))File.Delete(path);}catch{}}
}
