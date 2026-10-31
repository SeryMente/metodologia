using Microsoft.Data.Sqlite;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Text.Json;

namespace OcpMcp.Security;

public sealed class KeyVault(SqliteStore store)
{
    public string CurrentSid()
    {
        using var identity=WindowsIdentity.GetCurrent();
        return identity.User?.Value??throw new InvalidOperationException("WINDOWS_SID_UNAVAILABLE");
    }

    public (string InstallationId,string? OperatorSid,int HmacKeyVersion) ReadInstallation(SqliteConnection c,SqliteTransaction? tx=null) =>
        SqliteStore.GetInstallation(c,tx)??throw new InvalidOperationException("INSTALLATION_NOT_INITIALIZED");

    public void ProvisionOperator()
    {
        EnsureInteractiveConsole();
        using var c=store.Open();
        var installation=ReadInstallation(c);
        string sid=CurrentSid();
        if(!string.IsNullOrWhiteSpace(installation.OperatorSid))
        {
            if(installation.OperatorSid!=sid)throw new UnauthorizedAccessException("OPERATOR_ALREADY_PROVISIONED_FOR_ANOTHER_SID");
            using var exists=c.CreateCommand();
            exists.CommandText="SELECT COUNT(*) FROM key_store WHERE purpose='hmac-authority' AND key_version=$v AND status='ACTIVE';";
            exists.Parameters.AddWithValue("$v",installation.HmacKeyVersion);
            if(Convert.ToInt32(exists.ExecuteScalar())==1)
            {
                Console.WriteLine("OPERATOR_ALREADY_PROVISIONED_FOR_THIS_SID; no keys changed.");
                return;
            }
        }

        Console.WriteLine("OCP MCP — Registro local de operador");
        Console.WriteLine($"Cuenta Windows: {WindowsIdentity.GetCurrent().Name}");
        Console.WriteLine($"SID: {sid}");
        Console.WriteLine("Esta acción registra la raíz local de autorización. No activa MCP-NORMATIVO.");
        Console.Write($"Escriba exactamente REGISTER {sid} para confirmar: ");
        if(!string.Equals(Console.ReadLine(),$"REGISTER {sid}",StringComparison.Ordinal))
            throw new InvalidOperationException("OPERATOR_PROVISIONING_NOT_CONFIRMED");

        byte[] hmacKey=RandomNumberGenerator.GetBytes(32);
        try
        {
            int version=installation.HmacKeyVersion;
            byte[] wrapped=CryptoBox.ProtectKey(hmacKey,CryptoBox.BuildEntropy(installation.InstallationId,"hmac-authority",sid,version.ToString()));
            using var tx=c.BeginTransaction(deferred:false);
            using(var update=c.CreateCommand())
            {
                update.Transaction=tx;
                update.CommandText="UPDATE installation SET operator_sid=$sid WHERE installation_id=$id AND (operator_sid IS NULL OR operator_sid=$sid);";
                update.Parameters.AddWithValue("$sid",sid);update.Parameters.AddWithValue("$id",installation.InstallationId);
                if(update.ExecuteNonQuery()!=1)throw new UnauthorizedAccessException("OPERATOR_SID_BINDING_FAILED");
            }
            UpsertKey(c,tx,"hmac-authority","HMAC-SHA256",version,wrapped);
            EnsureEd25519Key(c,tx,installation.InstallationId,sid);
            tx.Commit();
        }
        finally{CryptographicOperations.ZeroMemory(hmacKey);}
        Console.WriteLine("OPERATOR_PROVISIONED");
    }

    public byte[] LoadHmacKey(SqliteConnection c,SqliteTransaction? tx=null)
    {
        var i=ReadInstallation(c,tx);
        string sid=CurrentSid();
        if(i.OperatorSid is null||i.OperatorSid!=sid)throw new UnauthorizedAccessException("OPERATOR_TRUST_ROOT_NOT_PROVISIONED_FOR_CURRENT_SID");
        byte[] wrapped=LoadWrapped(c,tx,"hmac-authority",i.HmacKeyVersion);
        return CryptoBox.UnprotectKey(wrapped,CryptoBox.BuildEntropy(i.InstallationId,"hmac-authority",sid,i.HmacKeyVersion.ToString()));
    }

    public void AuthorizeRequest(string requestId)
    {
        EnsureInteractiveConsole();
        using var c=store.Open();
        var i=ReadInstallation(c);
        string sid=CurrentSid();
        if(i.OperatorSid is null||sid!=i.OperatorSid)throw new UnauthorizedAccessException("OPERATOR_SID_NOT_AUTHORIZED");
        string payload,hash,status,expiry;
        using(var q=c.CreateCommand())
        {
            q.CommandText="SELECT payload_json,payload_sha256,status,expires_at_utc FROM operation_requests WHERE request_id=$id;";
            q.Parameters.AddWithValue("$id",requestId);
            using var rd=q.ExecuteReader();
            if(!rd.Read())throw new InvalidOperationException("REQUEST_NOT_FOUND");
            payload=rd.GetString(0);hash=rd.GetString(1);status=rd.GetString(2);expiry=rd.GetString(3);
        }
        DateTimeOffset expires=DateTimeOffset.Parse(expiry);
        if(status!="PENDING_OPERATOR_APPROVAL"||expires<=DateTimeOffset.UtcNow)throw new InvalidOperationException("REQUEST_NOT_AUTHORIZABLE");
        using var doc=JsonDocument.Parse(payload);
        var root=doc.RootElement;
        string expectedSid=root.GetProperty("operator_sid").GetString()??"";
        int keyVersion=root.GetProperty("key_version").GetInt32();
        string nonce=root.GetProperty("nonce").GetString()??throw new InvalidDataException("NONCE_MISSING");
        if(expectedSid!=sid||keyVersion!=i.HmacKeyVersion)throw new UnauthorizedAccessException("REQUEST_IDENTITY_OR_KEY_VERSION_MISMATCH");
        Console.WriteLine("OCP MCP — Autorización local de operación protegida");
        Console.WriteLine($"Operación: {root.GetProperty("operation_type").GetString()}");
        Console.WriteLine($"Objetivo: {root.GetProperty("target_type").GetString()} / {root.GetProperty("target_id").GetString()}");
        Console.WriteLine($"Ciclo: {(root.TryGetProperty("cycle_id",out var cyc)?cyc.ToString():"null")}");
        Console.WriteLine($"Parámetros: {root.GetProperty("parameters_json").GetString()}");
        Console.WriteLine($"SID operador: {sid}");
        Console.WriteLine($"Payload SHA-256: {hash}");
        Console.WriteLine($"Vence: {expires:O}");
        Console.Write($"Confirme escribiendo APPROVE {hash[..12]}: ");
        if(!string.Equals(Console.ReadLine(),$"APPROVE {hash[..12]}",StringComparison.Ordinal))
            throw new InvalidOperationException("OPERATOR_DECLINED_OR_CONFIRMATION_INVALID");

        byte[] key=LoadHmacKey(c);
        byte[] mac;
        try{mac=CryptoBox.Hmac(key,Encoding.UTF8.GetBytes(payload));}
        finally{CryptographicOperations.ZeroMemory(key);}
        string nonceHash=Convert.ToHexStringLower(SHA256.HashData(Convert.FromBase64String(nonce)));
        using var tx=c.BeginTransaction(deferred:false);
        using(var insert=c.CreateCommand())
        {
            insert.Transaction=tx;
            insert.CommandText="""
                INSERT INTO authorization_grants(grant_id,request_id,operator_sid,key_version,nonce_hash,payload_sha256,mac,status,approved_at_utc,expires_at_utc)
                VALUES($grant,$request,$sid,$version,$nonce,$hash,$mac,'APPROVED',$now,$expiry);
                """;
            insert.Parameters.AddWithValue("$grant",Guid.NewGuid().ToString("N"));insert.Parameters.AddWithValue("$request",requestId);
            insert.Parameters.AddWithValue("$sid",sid);insert.Parameters.AddWithValue("$version",keyVersion);insert.Parameters.AddWithValue("$nonce",nonceHash);
            insert.Parameters.AddWithValue("$hash",hash);insert.Parameters.AddWithValue("$mac",mac);
            insert.Parameters.AddWithValue("$now",DateTimeOffset.UtcNow.ToString("O"));insert.Parameters.AddWithValue("$expiry",expiry);
            insert.ExecuteNonQuery();
        }
        using(var update=c.CreateCommand())
        {
            update.Transaction=tx;update.CommandText="UPDATE operation_requests SET status='AUTHORIZED' WHERE request_id=$id AND status='PENDING_OPERATOR_APPROVAL';";
            update.Parameters.AddWithValue("$id",requestId);
            if(update.ExecuteNonQuery()!=1)throw new InvalidOperationException("REQUEST_STATE_RACE");
        }
        EventChain.Append(c,tx,root.TryGetProperty("cycle_id",out var cycle)&&cycle.ValueKind==JsonValueKind.String?cycle.GetString():null,
            root.GetProperty("attempt_id").GetString(),"OPERATOR_AUTHORIZATION_GRANTED","OPERATOR",sid,new{request_id=requestId,payload_sha256=hash,nonce_sha256=nonceHash,expires_at_utc=expiry});
        tx.Commit();
        Console.WriteLine($"GRANT_APPROVED request_id={requestId}");
    }

    public void RevokeRequest(string requestId)
    {
        EnsureInteractiveConsole();
        using var c=store.Open();
        var i=ReadInstallation(c);
        string sid=CurrentSid();
        if(i.OperatorSid is null||i.OperatorSid!=sid)throw new UnauthorizedAccessException("OPERATOR_SID_NOT_AUTHORIZED");
        using var tx=c.BeginTransaction(deferred:false);
        using(var cmd=c.CreateCommand())
        {
            cmd.Transaction=tx;
            cmd.CommandText="UPDATE authorization_grants SET status='REVOKED',revoked_at_utc=$utc WHERE request_id=$id AND status='APPROVED' AND consumed_at_utc IS NULL;";
            cmd.Parameters.AddWithValue("$utc",DateTimeOffset.UtcNow.ToString("O"));cmd.Parameters.AddWithValue("$id",requestId);
            if(cmd.ExecuteNonQuery()!=1)throw new InvalidOperationException("GRANT_NOT_REVOCABLE");
        }
        using(var cmd=c.CreateCommand())
        {
            cmd.Transaction=tx;cmd.CommandText="UPDATE operation_requests SET status='REVOKED' WHERE request_id=$id AND status='AUTHORIZED';";
            cmd.Parameters.AddWithValue("$id",requestId);cmd.ExecuteNonQuery();
        }
        EventChain.Append(c,tx,null,null,"OPERATOR_AUTHORIZATION_REVOKED","OPERATOR",sid,new{request_id=requestId});
        tx.Commit();
    }

    public void RotateHmacKey()
    {
        EnsureInteractiveConsole();
        using var c=store.Open();
        var i=ReadInstallation(c);
        string sid=CurrentSid();
        if(i.OperatorSid is null||i.OperatorSid!=sid)throw new UnauthorizedAccessException("OPERATOR_SID_NOT_AUTHORIZED");
        int next=i.HmacKeyVersion+1;
        Console.WriteLine($"Rotar clave HMAC de versión {i.HmacKeyVersion} a {next}; todos los grants pendientes serán invalidados.");
        Console.Write($"Escriba exactamente ROTATE {sid}: ");
        if(!string.Equals(Console.ReadLine(),$"ROTATE {sid}",StringComparison.Ordinal))throw new InvalidOperationException("KEY_ROTATION_NOT_CONFIRMED");
        byte[] key=RandomNumberGenerator.GetBytes(32);
        try
        {
            byte[] wrapped=CryptoBox.ProtectKey(key,CryptoBox.BuildEntropy(i.InstallationId,"hmac-authority",sid,next.ToString()));
            using var tx=c.BeginTransaction(deferred:false);
            using(var cmd=c.CreateCommand())
            {
                cmd.Transaction=tx;cmd.CommandText="UPDATE key_store SET status='RETIRED' WHERE purpose='hmac-authority' AND status='ACTIVE';";
                cmd.ExecuteNonQuery();
            }
            UpsertKey(c,tx,"hmac-authority","HMAC-SHA256",next,wrapped);
            using(var cmd=c.CreateCommand())
            {
                cmd.Transaction=tx;cmd.CommandText="UPDATE installation SET hmac_key_version=$version WHERE installation_id=$id AND operator_sid=$sid;";
                cmd.Parameters.AddWithValue("$version",next);cmd.Parameters.AddWithValue("$id",i.InstallationId);cmd.Parameters.AddWithValue("$sid",sid);
                if(cmd.ExecuteNonQuery()!=1)throw new InvalidOperationException("KEY_VERSION_UPDATE_FAILED");
            }
            using(var cmd=c.CreateCommand())
            {
                cmd.Transaction=tx;cmd.CommandText="UPDATE authorization_grants SET status='REVOKED',revoked_at_utc=$utc WHERE status='APPROVED' AND consumed_at_utc IS NULL;";
                cmd.Parameters.AddWithValue("$utc",DateTimeOffset.UtcNow.ToString("O"));cmd.ExecuteNonQuery();
            }
            using(var cmd=c.CreateCommand())
            {
                cmd.Transaction=tx;cmd.CommandText="UPDATE operation_requests SET status='REVOKED' WHERE status='AUTHORIZED';";
                cmd.ExecuteNonQuery();
            }
            EventChain.Append(c,tx,null,null,"HMAC_KEY_ROTATED","OPERATOR",sid,new{old_version=i.HmacKeyVersion,new_version=next});
            tx.Commit();
        }
        finally{CryptographicOperations.ZeroMemory(key);}
        Console.WriteLine($"HMAC_KEY_ROTATED version={next}");
    }

    public byte[] LoadSigningPrivateKey(SqliteConnection c,SqliteTransaction? tx=null)
    {
        var i=ReadInstallation(c,tx);
        if(i.OperatorSid is null||i.OperatorSid!=CurrentSid())throw new UnauthorizedAccessException("OPERATOR_SID_NOT_AUTHORIZED");
        byte[] wrapped=LoadWrapped(c,tx,"receipt-ed25519",1);
        return CryptoBox.UnprotectKey(wrapped,CryptoBox.BuildEntropy(i.InstallationId,"receipt-ed25519",i.OperatorSid,"1"));
    }

    public static void UpsertKey(SqliteConnection c,SqliteTransaction? tx,string purpose,string type,int version,byte[] wrapped)
    {
        using var cmd=c.CreateCommand();cmd.Transaction=tx;
        cmd.CommandText="""
            INSERT INTO key_store(key_id,purpose,key_type,key_version,wrapped_key,created_at_utc,status)
            VALUES($id,$purpose,$type,$version,$key,$utc,'ACTIVE')
            ON CONFLICT(purpose,key_version) DO UPDATE SET wrapped_key=excluded.wrapped_key,status='ACTIVE';
            """;
        cmd.Parameters.AddWithValue("$id",Guid.NewGuid().ToString("N"));cmd.Parameters.AddWithValue("$purpose",purpose);cmd.Parameters.AddWithValue("$type",type);
        cmd.Parameters.AddWithValue("$version",version);cmd.Parameters.AddWithValue("$key",wrapped);cmd.Parameters.AddWithValue("$utc",DateTimeOffset.UtcNow.ToString("O"));
        cmd.ExecuteNonQuery();
    }

    private static void EnsureEd25519Key(SqliteConnection c,SqliteTransaction tx,string installationId,string sid)
    {
        using var check=c.CreateCommand();check.Transaction=tx;check.CommandText="SELECT COUNT(*) FROM key_store WHERE purpose='receipt-ed25519' AND key_version=1;";
        if(Convert.ToInt32(check.ExecuteScalar())>0)return;
        var pair=ReceiptSigner.Generate();
        try
        {
            byte[] wrapped=CryptoBox.ProtectKey(pair.PrivateKey,CryptoBox.BuildEntropy(installationId,"receipt-ed25519",sid,"1"));
            UpsertKey(c,tx,"receipt-ed25519","Ed25519",1,wrapped);
            using var meta=c.CreateCommand();meta.Transaction=tx;
            meta.CommandText="INSERT OR REPLACE INTO key_metadata(key_id,key_type,key_version,public_key,fingerprint_sha256,created_at_utc,status) VALUES('receipt-ed25519-v1','Ed25519',1,$pub,$fp,$utc,'ACTIVE');";
            meta.Parameters.AddWithValue("$pub",pair.PublicKey);meta.Parameters.AddWithValue("$fp",Convert.ToHexStringLower(SHA256.HashData(pair.PublicKey)));
            meta.Parameters.AddWithValue("$utc",DateTimeOffset.UtcNow.ToString("O"));meta.ExecuteNonQuery();
        }
        finally{CryptographicOperations.ZeroMemory(pair.PrivateKey);}
    }

    private static void EnsureInteractiveConsole()
    {
        if (Console.IsInputRedirected || Console.IsOutputRedirected)
            throw new UnauthorizedAccessException("INTERACTIVE_OPERATOR_CONSOLE_REQUIRED");
    }

    private static byte[] LoadWrapped(SqliteConnection c,SqliteTransaction? tx,string purpose,int version)
    {
        using var cmd=c.CreateCommand();cmd.Transaction=tx;
        cmd.CommandText="SELECT wrapped_key FROM key_store WHERE purpose=$purpose AND key_version=$version AND status='ACTIVE';";
        cmd.Parameters.AddWithValue("$purpose",purpose);cmd.Parameters.AddWithValue("$version",version);
        return (byte[]?)cmd.ExecuteScalar()??throw new CryptographicException("KEY_MATERIAL_NOT_FOUND");
    }
}
