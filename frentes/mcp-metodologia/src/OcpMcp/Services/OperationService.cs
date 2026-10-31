using Microsoft.Data.Sqlite;
using OcpMcp.Security;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace OcpMcp.Services;

public sealed class OperationService(SqliteStore store, KeyVault vault)
{
    private static readonly HashSet<string> AllowedOperations = new(StringComparer.Ordinal)
    { "OPEN_CYCLE", "RECORD_CLASSIFICATION", "SET_SELECTION", "BUILD_SNAPSHOT", "RELEASE_SNAPSHOT" };

    public object Prepare(string operationType, JsonElement parameters)
    {
        if (!AllowedOperations.Contains(operationType)) throw new InvalidOperationException("OPERATION_NOT_ALLOWED");
        string requestId=Guid.NewGuid().ToString("N");
        string operationId=Guid.NewGuid().ToString("N");
        string attemptId=Guid.NewGuid().ToString("N");
        string targetId=GetTargetId(operationType,parameters);
        string? cycleId=GetOptionalString(parameters,"cycle_id");
        if(operationType=="OPEN_CYCLE") cycleId=targetId;
        string nonce=Convert.ToBase64String(RandomNumberGenerator.GetBytes(32));
        DateTimeOffset now=DateTimeOffset.UtcNow, expires=now.AddMinutes(10);
        string parametersJson=CanonicalJson.Serialize(JsonDocument.Parse(parameters.GetRawText()).RootElement);
        var payloadObject=new {
            schema_version=1,
            installation_id=GetInstallationId(),
            request_id=requestId,
            operation_id=operationId,
            attempt_id=attemptId,
            operation_type=operationType,
            target_type=operationType=="OPEN_CYCLE"?"cycle":operationType=="BUILD_SNAPSHOT"?"snapshot":operationType=="RELEASE_SNAPSHOT"?"snapshot":"cycle",
            target_id=targetId,
            cycle_id=cycleId,
            operator_sid=vault.CurrentSid(),
            parameters_sha256=Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(parametersJson))),
            parameters_json=parametersJson,
            expected_state="CURRENT",
            requested_effect=operationType,
            created_at_utc=now.ToString("O"),
            expires_at_utc=expires.ToString("O"),
            nonce,
            key_version=GetHmacVersion()
        };
        string payload=CanonicalJson.Serialize(payloadObject);
        string payloadHash=Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(payload)));
        using var connection=store.Open();
        using var tx=connection.BeginTransaction(deferred:false);
        using var cmd=connection.CreateCommand(); cmd.Transaction=tx;
        cmd.CommandText="""
            INSERT INTO operation_requests(request_id,operation_id,attempt_id,operation_type,target_type,target_id,cycle_id,parameters_json,payload_json,payload_sha256,expected_state,requested_effect,status,created_at_utc,expires_at_utc)
            VALUES($request,$operation,$attempt,$type,$targetType,$target,$cycle,$parameters,$payload,$hash,'CURRENT',$effect,'PENDING_OPERATOR_APPROVAL',$created,$expires);
            """;
        cmd.Parameters.AddWithValue("$request",requestId);
        cmd.Parameters.AddWithValue("$operation",operationId);
        cmd.Parameters.AddWithValue("$attempt",attemptId);
        cmd.Parameters.AddWithValue("$type",operationType);
        cmd.Parameters.AddWithValue("$targetType",payloadObject.target_type);
        cmd.Parameters.AddWithValue("$target",targetId);
        cmd.Parameters.AddWithValue("$cycle",(object?)cycleId??DBNull.Value);
        cmd.Parameters.AddWithValue("$parameters",parametersJson);
        cmd.Parameters.AddWithValue("$payload",payload);
        cmd.Parameters.AddWithValue("$hash",payloadHash);
        cmd.Parameters.AddWithValue("$effect",operationType);
        cmd.Parameters.AddWithValue("$created",now.ToString("O"));
        cmd.Parameters.AddWithValue("$expires",expires.ToString("O"));
        cmd.ExecuteNonQuery();
        EventChain.Append(connection,tx,cycleId,attemptId,"OPERATION_PREPARED","MODEL",requestId,new{operation_type=operationType,payload_sha256=payloadHash});
        tx.Commit();
        return new { request_id=requestId,operation_id=operationId,attempt_id=attemptId,payload_sha256=payloadHash,summary=payloadObject,expires_at_utc=expires.ToString("O"),status="PENDING_OPERATOR_APPROVAL" };
    }

    public object Execute(string requestId)
    {
        using var connection=store.Open();
        using var tx=connection.BeginTransaction(deferred:false);
        string? operationId=null, attemptId=null, operationType=null, cycleId=null, payload=null, payloadHash=null, parametersJson=null, targetId=null;
        string? requestStatus=null;
        using(var cmd=connection.CreateCommand())
        {
            cmd.Transaction=tx; cmd.CommandText="SELECT operation_id,attempt_id,operation_type,cycle_id,payload_json,payload_sha256,parameters_json,target_id,status FROM operation_requests WHERE request_id=$id;";
            cmd.Parameters.AddWithValue("$id",requestId);
            using var rd=cmd.ExecuteReader();
            if(!rd.Read()) throw new InvalidOperationException("REQUEST_NOT_FOUND");
            operationId=rd.GetString(0); attemptId=rd.GetString(1); operationType=rd.GetString(2);
            cycleId=rd.IsDBNull(3)?null:rd.GetString(3); payload=rd.GetString(4); payloadHash=rd.GetString(5);
            parametersJson=rd.GetString(6);targetId=rd.GetString(7);requestStatus=rd.GetString(8);
        }
        if(requestStatus=="COMPLETED")
        {
            object existing=GetReceiptForRequest(connection,tx,requestId);
            tx.Commit();
            return existing;
        }
        if(requestStatus!="AUTHORIZED") throw new UnauthorizedAccessException("AUTHORIZATION_UNAVAILABLE");
        if(!new BackupService(store).IsDailyCurrent(connection,tx)) throw new InvalidOperationException("DAILY_BACKUP_REQUIRED");
        ValidateGrant(connection,tx,requestId,payload!,payloadHash!);

        using(var check=connection.CreateCommand())
        {
            check.Transaction=tx;
            check.CommandText="SELECT COUNT(*) FROM authorization_grants WHERE request_id=$id AND status='APPROVED' AND expires_at_utc>$now AND revoked_at_utc IS NULL AND consumed_at_utc IS NULL;";
            check.Parameters.AddWithValue("$id",requestId);check.Parameters.AddWithValue("$now",DateTimeOffset.UtcNow.ToString("O"));
            if(Convert.ToInt32(check.ExecuteScalar())!=1)throw new UnauthorizedAccessException("AUTHORIZATION_INVALID_OR_CONSUMED");
        }

        using var parametersDoc=JsonDocument.Parse(parametersJson!);
        JsonElement parameters=parametersDoc.RootElement;
        string resultJson=ApplyOperation(connection,tx,operationType!,operationId!,targetId!,cycleId,parameters);
        string resultHash=Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(resultJson)));
        EventResult evt=EventChain.Append(connection,tx,cycleId,attemptId,"OPERATION_EXECUTED","OPERATOR",vault.CurrentSid(),new{operation_id=operationId,request_id=requestId,operation_type=operationType,result_sha256=resultHash});
        var receipt=ReceiptWriter.Insert(connection,tx,vault,operationId!,requestId,cycleId,attemptId!,operationType!,payloadHash!,resultHash,evt);

        using(var consume=connection.CreateCommand())
        {
            consume.Transaction=tx;
            consume.CommandText="UPDATE authorization_grants SET status='CONSUMED',consumed_at_utc=$utc WHERE request_id=$id AND status='APPROVED' AND consumed_at_utc IS NULL AND revoked_at_utc IS NULL AND expires_at_utc>$utc;";
            consume.Parameters.AddWithValue("$utc",DateTimeOffset.UtcNow.ToString("O"));consume.Parameters.AddWithValue("$id",requestId);
            if(consume.ExecuteNonQuery()!=1)throw new UnauthorizedAccessException("GRANT_CONSUMPTION_RACE");
        }
        using(var update=connection.CreateCommand())
        {
            update.Transaction=tx;update.CommandText="UPDATE operation_requests SET status='COMPLETED' WHERE request_id=$id AND status='AUTHORIZED';";
            update.Parameters.AddWithValue("$id",requestId);
            if(update.ExecuteNonQuery()!=1)throw new InvalidOperationException("REQUEST_STATE_RACE");
        }
        tx.Commit();
        return new {request_id=requestId,operation_id=operationId,operation_type=operationType,status="COMPLETED",result=JsonDocument.Parse(resultJson).RootElement.Clone(),receipt_id=receipt.ReceiptId,receipt_sha256=receipt.PayloadHash,event_sequence=evt.Sequence,event_hash=evt.EventHash};
    }

    private void ValidateGrant(SqliteConnection connection,SqliteTransaction tx,string requestId,string payload,string payloadHash)
    {
        using var cmd=connection.CreateCommand();cmd.Transaction=tx;
        cmd.CommandText="SELECT operator_sid,key_version,nonce_hash,payload_sha256,mac,expires_at_utc,status,revoked_at_utc,consumed_at_utc FROM authorization_grants WHERE request_id=$id;";
        cmd.Parameters.AddWithValue("$id",requestId);
        using var rd=cmd.ExecuteReader();
        if(!rd.Read())throw new UnauthorizedAccessException("AUTHORIZATION_NOT_FOUND");
        string sid=rd.GetString(0);int keyVersion=rd.GetInt32(1);string nonceHash=rd.GetString(2);string expectedHash=rd.GetString(3);byte[] mac=(byte[])rd[4];
        string expiry=rd.GetString(5);string status=rd.GetString(6);bool revoked=!rd.IsDBNull(7);bool consumed=!rd.IsDBNull(8);
        rd.Close();
        if(status!="APPROVED"||revoked||consumed||DateTimeOffset.Parse(expiry)<=DateTimeOffset.UtcNow)throw new UnauthorizedAccessException("AUTHORIZATION_EXPIRED_REVOKED_OR_CONSUMED");
        var installation=SqliteStore.GetInstallation(connection,tx)??throw new InvalidOperationException("INSTALLATION_NOT_INITIALIZED");
        if(installation.OperatorSid!=sid||vault.CurrentSid()!=sid||installation.HmacKeyVersion!=keyVersion)throw new UnauthorizedAccessException("AUTHORIZATION_IDENTITY_MISMATCH");
        string actualHash=Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(payload)));
        if(actualHash!=payloadHash||actualHash!=expectedHash)throw new CryptographicException("AUTHORIZATION_PAYLOAD_HASH_MISMATCH");
        using var doc=JsonDocument.Parse(payload);
        string nonce=doc.RootElement.GetProperty("nonce").GetString()??throw new CryptographicException("NONCE_MISSING");
        string actualNonce=Convert.ToHexStringLower(SHA256.HashData(Convert.FromBase64String(nonce)));
        if(actualNonce!=nonceHash)throw new CryptographicException("NONCE_BINDING_MISMATCH");
        byte[] key=vault.LoadHmacKey(connection,tx);
        byte[] expected;
        try{expected=CryptoBox.Hmac(key,Encoding.UTF8.GetBytes(payload));}
        finally{CryptographicOperations.ZeroMemory(key);}
        if(!CryptoBox.FixedEquals(expected,mac))throw new CryptographicException("HMAC_INVALID");
    }

    private string ApplyOperation(SqliteConnection connection,SqliteTransaction tx,string type,string operationId,string targetId,string? cycleId,JsonElement p)
    {
        string now=DateTimeOffset.UtcNow.ToString("O");
        switch(type)
        {
            case "OPEN_CYCLE":
                using(var c=connection.CreateCommand())
                {
                    c.Transaction=tx;c.CommandText="INSERT INTO cycles(cycle_id,project_ref,conversation_ref,state,operator_sid,created_at_utc,updated_at_utc) VALUES($id,$project,$conversation,'OPEN',$sid,$now,$now);";
                    c.Parameters.AddWithValue("$id",targetId);c.Parameters.AddWithValue("$project",GetString(p,"project_ref")??(object)DBNull.Value);
                    c.Parameters.AddWithValue("$conversation",GetString(p,"conversation_ref")??(object)DBNull.Value);
                    c.Parameters.AddWithValue("$sid",vault.CurrentSid());c.Parameters.AddWithValue("$now",now);c.ExecuteNonQuery();
                }
                return CanonicalJson.Serialize(new{cycle_id=targetId,state="OPEN",created_at_utc=now});
            case "RECORD_CLASSIFICATION":
                RequireCycle(connection,tx,cycleId);
                using(var c=connection.CreateCommand())
                {
                    c.Transaction=tx;c.CommandText="""
                        INSERT INTO classifications(cycle_id,principle_id,classification,justification,evidence_refs_json,created_at_utc)
                        VALUES($cycle,$principle,$classification,$justification,$evidence,$now)
                        ON CONFLICT(cycle_id,principle_id) DO UPDATE SET classification=excluded.classification,justification=excluded.justification,evidence_refs_json=excluded.evidence_refs_json,created_at_utc=excluded.created_at_utc;
                        UPDATE cycles SET state='CLASSIFIED',updated_at_utc=$now WHERE cycle_id=$cycle;
                        """;
                    c.Parameters.AddWithValue("$cycle",cycleId!);c.Parameters.AddWithValue("$principle",GetString(p,"principle_id")??throw new InvalidDataException("PRINCIPLE_ID_REQUIRED"));
                    string classification=GetString(p,"classification")??"";
                    if(!new[]{"APLICA","NO_APLICA","INCIERTO"}.Contains(classification))throw new InvalidDataException("CLASSIFICATION_INVALID");
                    c.Parameters.AddWithValue("$classification",classification);
                    c.Parameters.AddWithValue("$justification",GetString(p,"justification")??throw new InvalidDataException("JUSTIFICATION_REQUIRED"));
                    c.Parameters.AddWithValue("$evidence",GetRaw(p,"evidence_refs")??"[]");c.Parameters.AddWithValue("$now",now);c.ExecuteNonQuery();
                }
                return CanonicalJson.Serialize(new{cycle_id=cycleId,principle_id=GetString(p,"principle_id"),classification=GetString(p,"classification"),updated_at_utc=now});
            case "SET_SELECTION":
                RequireCycle(connection,tx,cycleId);
                var ids=p.GetProperty("principle_ids").EnumerateArray().Select(e=>e.GetString()??"").Distinct(StringComparer.Ordinal).Order(StringComparer.Ordinal).ToArray();
                if(ids.Length==0)throw new InvalidDataException("SELECTION_EMPTY");
                string idsJson=CanonicalJson.Serialize(ids);
                string selectionHash=Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(idsJson)));
                using(var c=connection.CreateCommand())
                {
                    c.Transaction=tx;c.CommandText="""
                        INSERT INTO selections(cycle_id,selection_sha256,principle_ids_json,created_at_utc)
                        VALUES($cycle,$hash,$ids,$now)
                        ON CONFLICT(cycle_id) DO UPDATE SET selection_sha256=excluded.selection_sha256,principle_ids_json=excluded.principle_ids_json,created_at_utc=excluded.created_at_utc;
                        UPDATE cycles SET state='SELECTED',updated_at_utc=$now WHERE cycle_id=$cycle;
                        """;
                    c.Parameters.AddWithValue("$cycle",cycleId!);c.Parameters.AddWithValue("$hash",selectionHash);c.Parameters.AddWithValue("$ids",idsJson);c.Parameters.AddWithValue("$now",now);c.ExecuteNonQuery();
                }
                return CanonicalJson.Serialize(new{cycle_id=cycleId,principle_ids=ids,selection_sha256=selectionHash,updated_at_utc=now});
            case "BUILD_SNAPSHOT":
                RequireCycle(connection,tx,cycleId);
                string snapshotId=targetId;
                byte[] clear=Encoding.UTF8.GetBytes(BuildSnapshotJson(connection,tx,cycleId!,snapshotId,now));
                try
                {
                    if(clear.Length>32*1024*1024)throw new InvalidDataException("SNAPSHOT_TOO_LARGE");
                    string installationId=SqliteStore.GetInstallation(connection,tx)!.Value.InstallationId;
                    var enc=CryptoBox.Encrypt(clear,installationId,"snapshot",snapshotId);
                    using var c=connection.CreateCommand();c.Transaction=tx;
                    c.CommandText="""
                        INSERT INTO snapshots(snapshot_id,cycle_id,operation_id,content_ciphertext,content_nonce,authentication_tag,wrapped_dek,dek_id,crypto_algorithm,crypto_version,dpapi_scope,key_version,aad_version,content_sha256,encrypted_at_utc,status)
                        VALUES($id,$cycle,$operation,$cipher,$nonce,$tag,$wrapped,$dek,'AES-256-GCM',1,'CurrentUser',1,1,$hash,$utc,'BUILT');
                        UPDATE cycles SET state='SNAPSHOT_BUILT',updated_at_utc=$utc WHERE cycle_id=$cycle;
                        """;
                    c.Parameters.AddWithValue("$id",snapshotId);c.Parameters.AddWithValue("$cycle",cycleId!);c.Parameters.AddWithValue("$operation",operationId);
                    c.Parameters.AddWithValue("$cipher",enc.Ciphertext);c.Parameters.AddWithValue("$nonce",enc.Nonce);c.Parameters.AddWithValue("$tag",enc.Tag);c.Parameters.AddWithValue("$wrapped",enc.WrappedDek);c.Parameters.AddWithValue("$dek",enc.DekId);c.Parameters.AddWithValue("$hash",enc.ContentSha256);c.Parameters.AddWithValue("$utc",now);c.ExecuteNonQuery();
                    return CanonicalJson.Serialize(new{snapshot_id=snapshotId,cycle_id=cycleId,content_sha256=enc.ContentSha256,size_bytes=clear.Length,status="BUILT"});
                }
                finally{CryptographicOperations.ZeroMemory(clear);}
            case "RELEASE_SNAPSHOT":
                using(var c=connection.CreateCommand())
                {
                    c.Transaction=tx;c.CommandText="UPDATE snapshots SET status='RELEASED' WHERE snapshot_id=$id AND status='BUILT';";
                    c.Parameters.AddWithValue("$id",targetId);
                    if(c.ExecuteNonQuery()!=1)throw new InvalidOperationException("SNAPSHOT_NOT_FOUND_OR_NOT_BUILT");
                    using var cycle=connection.CreateCommand();cycle.Transaction=tx;cycle.CommandText="UPDATE cycles SET state='RELEASED',updated_at_utc=$utc WHERE cycle_id=$cycle;";
                    cycle.Parameters.AddWithValue("$utc",now);cycle.Parameters.AddWithValue("$cycle",cycleId??throw new InvalidDataException("CYCLE_ID_REQUIRED"));cycle.ExecuteNonQuery();
                }
                return CanonicalJson.Serialize(new{snapshot_id=targetId,status="RELEASED",released_at_utc=now});
            default: throw new InvalidOperationException("OPERATION_NOT_IMPLEMENTED");
        }
    }

    private string BuildSnapshotJson(SqliteConnection c,SqliteTransaction tx,string cycleId,string snapshotId,string utc)
    {
        var classifications=new List<object>();
        using(var cmd=c.CreateCommand())
        {
            cmd.Transaction=tx;cmd.CommandText="SELECT principle_id,classification,justification,evidence_refs_json,created_at_utc FROM classifications WHERE cycle_id=$cycle ORDER BY principle_id;";
            cmd.Parameters.AddWithValue("$cycle",cycleId);using var rd=cmd.ExecuteReader();
            while(rd.Read())classifications.Add(new{principle_id=rd.GetString(0),classification=rd.GetString(1),justification=rd.GetString(2),evidence_refs=JsonDocument.Parse(rd.GetString(3)).RootElement.Clone(),created_at_utc=rd.GetString(4)});
        }
        object? selection=null;
        using(var cmd=c.CreateCommand())
        {
            cmd.Transaction=tx;cmd.CommandText="SELECT selection_sha256,principle_ids_json FROM selections WHERE cycle_id=$cycle;";
            cmd.Parameters.AddWithValue("$cycle",cycleId);using var rd=cmd.ExecuteReader();
            if(rd.Read())selection=new{selection_sha256=rd.GetString(0),principle_ids=JsonDocument.Parse(rd.GetString(1)).RootElement.Clone()};
        }
        var sources=new List<object>();
        using(var cmd=c.CreateCommand())
        {
            cmd.Transaction=tx;cmd.CommandText="SELECT source_id,canonical_path,commit_id,git_blob_sha,content_sha256,verification_status,freshness_status FROM canonical_sources ORDER BY source_id;";
            using var rd=cmd.ExecuteReader();while(rd.Read())sources.Add(new{source_id=rd.GetString(0),canonical_path=rd.GetString(1),commit_id=rd.GetString(2),git_blob_sha=rd.IsDBNull(3)?null:rd.GetString(3),content_sha256=rd.GetString(4),verification_status=rd.GetString(5),freshness_status=rd.GetString(6)});
        }
        return CanonicalJson.Serialize(new{snapshot_id=snapshotId,cycle_id=cycleId,created_at_utc=utc,classifications,selection,canonical_sources=sources});
    }

    private void RequireCycle(SqliteConnection c,SqliteTransaction tx,string? cycleId)
    {
        if(string.IsNullOrWhiteSpace(cycleId))throw new InvalidDataException("CYCLE_ID_REQUIRED");
        using var cmd=c.CreateCommand();cmd.Transaction=tx;cmd.CommandText="SELECT COUNT(*) FROM cycles WHERE cycle_id=$id;";
        cmd.Parameters.AddWithValue("$id",cycleId);if(Convert.ToInt32(cmd.ExecuteScalar())!=1)throw new InvalidOperationException("CYCLE_NOT_FOUND");
    }

    private string CurrentOperationId(SqliteConnection c,SqliteTransaction tx)
    {
        using var cmd=c.CreateCommand();cmd.Transaction=tx;cmd.CommandText="SELECT operation_id FROM operation_requests WHERE status='AUTHORIZED' ORDER BY created_at_utc DESC LIMIT 1;";
        return Convert.ToString(cmd.ExecuteScalar())??throw new InvalidOperationException("CURRENT_OPERATION_NOT_FOUND");
    }

    private object GetReceiptForRequest(SqliteConnection c,SqliteTransaction tx,string requestId)
    {
        using var cmd=c.CreateCommand();cmd.Transaction=tx;cmd.CommandText="SELECT receipt_id,receipt_json,payload_sha256,signature,signing_key_id FROM receipts WHERE request_id=$id;";
        cmd.Parameters.AddWithValue("$id",requestId);using var rd=cmd.ExecuteReader();
        if(!rd.Read())throw new InvalidOperationException("COMPLETED_REQUEST_WITHOUT_RECEIPT");
        return new{receipt_id=rd.GetString(0),receipt=JsonDocument.Parse(rd.GetString(1)).RootElement.Clone(),payload_sha256=rd.GetString(2),signature=Convert.ToBase64String((byte[])rd[3]),signing_key_id=rd.GetString(4),status="COMPLETED_IDEMPOTENT_REPLAY"};
    }

    private string GetInstallationId(){using var c=store.Open();return SqliteStore.GetInstallation(c)!.Value.InstallationId;}
    private int GetHmacVersion(){using var c=store.Open();return SqliteStore.GetInstallation(c)!.Value.HmacKeyVersion;}
    private static string GetTargetId(string type,JsonElement p) => type switch
    {
        "OPEN_CYCLE"=>Guid.NewGuid().ToString("N"),
        "BUILD_SNAPSHOT"=>Guid.NewGuid().ToString("N"),
        "RELEASE_SNAPSHOT"=>GetString(p,"snapshot_id")??throw new InvalidDataException("SNAPSHOT_ID_REQUIRED"),
        _=>GetString(p,"cycle_id")??throw new InvalidDataException("CYCLE_ID_REQUIRED")
    };
    private static string? GetString(JsonElement e,string name)=>e.TryGetProperty(name,out var v)&&v.ValueKind==JsonValueKind.String?v.GetString():null;
    private static string? GetOptionalString(JsonElement e,string name)=>GetString(e,name);
    private static string? GetRaw(JsonElement e,string name)=>e.TryGetProperty(name,out var v)?CanonicalJson.Serialize(v):null;
}
