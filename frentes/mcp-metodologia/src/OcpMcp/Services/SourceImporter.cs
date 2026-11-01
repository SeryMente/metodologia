using Microsoft.Data.Sqlite;
using OcpMcp.Security;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

namespace OcpMcp.Services;

public sealed class SourceImporter(SqliteStore store)
{
    private sealed record Manifest(int manifest_version, string repository, SourceEntry[] sources);
    private sealed record SourceEntry(string source_id,string canonical_path,string ref_name,string commit_id,string git_blob_sha,string content_sha256,string captured_at_utc,string verification_status,string freshness_status);

    public void Import(string repositoryRoot)
    {
        string manifestPath=Path.Combine(AppContext.BaseDirectory,"initial-sources.manifest.json");
        if(!File.Exists(manifestPath))
            manifestPath=Path.Combine(repositoryRoot,"frentes","mcp-metodologia","resources","initial-sources.manifest.json");
        if(!File.Exists(manifestPath)) throw new FileNotFoundException("INITIAL_SOURCES_MANIFEST_NOT_FOUND",manifestPath);
        var manifest=JsonSerializer.Deserialize<Manifest>(File.ReadAllText(manifestPath)) ?? throw new InvalidDataException("INVALID_SOURCE_MANIFEST");
        if(manifest.manifest_version!=1 || manifest.sources.Length==0) throw new InvalidDataException("INVALID_SOURCE_MANIFEST");
        using var connection=store.Open();
        using var tx=connection.BeginTransaction(deferred:false);
        foreach(var source in manifest.sources)
        {
            if(source.verification_status!="VERIFIED_AT_BUILD" || string.IsNullOrWhiteSpace(source.content_sha256))
                throw new InvalidDataException("SOURCE_MANIFEST_NOT_VERIFIED_AT_BUILD");
            string resolved=RunGit(repositoryRoot,["rev-parse",$"{source.commit_id}:{source.canonical_path}"]).Trim();
            if(!string.Equals(resolved,source.git_blob_sha,StringComparison.OrdinalIgnoreCase))
                throw new CryptographicException($"GIT_BLOB_SHA_MISMATCH:{source.source_id}");
            byte[] content=RunGitBinary(repositoryRoot,["cat-file","blob",source.git_blob_sha]);
            try
            {
                string hash=Convert.ToHexStringLower(SHA256.HashData(content));
                if(!string.Equals(hash,source.content_sha256,StringComparison.OrdinalIgnoreCase))
                    throw new CryptographicException($"CONTENT_SHA256_MISMATCH:{source.source_id}");
                using var existing=connection.CreateCommand();
                existing.Transaction=tx;
                existing.CommandText="SELECT commit_id,git_blob_sha,content_sha256 FROM canonical_sources WHERE source_id=$id;";
                existing.Parameters.AddWithValue("$id",source.source_id);
                using var reader=existing.ExecuteReader();
                if(reader.Read())
                {
                    bool same=reader.GetString(0)==source.commit_id && reader.GetString(1)==source.git_blob_sha && reader.GetString(2)==hash;
                    reader.Close();
                    if(!same) throw new InvalidOperationException($"SOURCE_ID_CONFLICT:{source.source_id}");
                    continue;
                }
                reader.Close();
                string installationId=SqliteStore.GetInstallation(connection,tx)?.InstallationId ?? throw new InvalidOperationException("INSTALLATION_NOT_INITIALIZED");
                var encrypted=CryptoBox.Encrypt(content,installationId,"canonical-source",source.source_id);
                using var insert=connection.CreateCommand();
                insert.Transaction=tx;
                insert.CommandText="""
                    INSERT INTO canonical_sources(source_id,repository_uri,canonical_path,ref_name,commit_id,git_blob_sha,content_sha256,captured_at_utc,verification_status,freshness_status,content_ciphertext,content_nonce,authentication_tag,wrapped_dek,dek_id,crypto_algorithm,crypto_version,dpapi_scope,key_version,aad_version,encrypted_at_utc)
                    VALUES($id,$repo,$path,$ref,$commit,$blob,$hash,$captured,'VERIFIED_AT_IMPORT',$fresh,$cipher,$nonce,$tag,$wrapped,$dek,'AES-256-GCM',1,'CurrentUser',1,1,$encryptedAt);
                    """;
                insert.Parameters.AddWithValue("$id",source.source_id);
                insert.Parameters.AddWithValue("$repo",manifest.repository);
                insert.Parameters.AddWithValue("$path",source.canonical_path);
                insert.Parameters.AddWithValue("$ref",source.ref_name);
                insert.Parameters.AddWithValue("$commit",source.commit_id);
                insert.Parameters.AddWithValue("$blob",source.git_blob_sha);
                insert.Parameters.AddWithValue("$hash",hash);
                insert.Parameters.AddWithValue("$captured",source.captured_at_utc);
                insert.Parameters.AddWithValue("$fresh",source.freshness_status);
                insert.Parameters.AddWithValue("$cipher",encrypted.Ciphertext);
                insert.Parameters.AddWithValue("$nonce",encrypted.Nonce);
                insert.Parameters.AddWithValue("$tag",encrypted.Tag);
                insert.Parameters.AddWithValue("$wrapped",encrypted.WrappedDek);
                insert.Parameters.AddWithValue("$dek",encrypted.DekId);
                insert.Parameters.AddWithValue("$encryptedAt",DateTimeOffset.UtcNow.ToString("O"));
                insert.ExecuteNonQuery();
                EventChain.Append(connection,tx,null,null,"CANONICAL_SOURCE_IMPORTED","SYSTEM",source.source_id,new{source.commit_id,source.git_blob_sha,content_sha256=hash});
                CryptographicOperations.ZeroMemory(content);
            }
            catch { CryptographicOperations.ZeroMemory(content); throw; }
        }
        tx.Commit();
    }

    private static string RunGit(string root,string[] args)
    {
        using var p=new Process();
        p.StartInfo=new ProcessStartInfo("git"){WorkingDirectory=root,UseShellExecute=false,RedirectStandardOutput=true,RedirectStandardError=true,CreateNoWindow=true};
        foreach(var a in args)p.StartInfo.ArgumentList.Add(a);
        p.Start();
        string stdout=p.StandardOutput.ReadToEnd();
        string stderr=p.StandardError.ReadToEnd();
        p.WaitForExit();
        if(p.ExitCode!=0)throw new InvalidOperationException("GIT_COMMAND_FAILED:"+stderr);
        return stdout;
    }

    private static byte[] RunGitBinary(string root,string[] args)
    {
        using var p=new Process();
        p.StartInfo=new ProcessStartInfo("git"){WorkingDirectory=root,UseShellExecute=false,RedirectStandardOutput=true,RedirectStandardError=true,CreateNoWindow=true};
        foreach(var a in args)p.StartInfo.ArgumentList.Add(a);
        p.Start();
        using var ms=new MemoryStream();
        var copy=p.StandardOutput.BaseStream.CopyToAsync(ms);
        string stderr=p.StandardError.ReadToEnd();
        copy.GetAwaiter().GetResult();
        p.WaitForExit();
        if(p.ExitCode!=0)throw new InvalidOperationException("GIT_BLOB_READ_FAILED:"+stderr);
        return ms.ToArray();
    }
}
