using Microsoft.Data.Sqlite;
using OcpMcp;
using OcpMcp.Security;
using OcpMcp.Services;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Text.Json;

var passed=0;
var failed=0;
void Check(string name,bool value)
{
    if(value){passed++;Console.WriteLine($"PASS {name}");}
    else{failed++;Console.WriteLine($"FAIL {name}");}
}

try
{
    // AES-256-GCM with DPAPI CurrentUser key wrapping.
    byte[] clear=Encoding.UTF8.GetBytes("OCP MCP AES-256-GCM + DPAPI CurrentUser test payload.");
    string installationId=Guid.NewGuid().ToString("N");
    string objectId=Guid.NewGuid().ToString("N");
    var encrypted=CryptoBox.Encrypt(clear,installationId,"snapshot",objectId);
    byte[] restored=CryptoBox.Decrypt(encrypted,installationId,"snapshot",objectId);
    Check("AES_GCM_DPAPI_ROUNDTRIP",CryptographicOperations.FixedTimeEquals(clear,restored));
    CryptographicOperations.ZeroMemory(restored);
    byte[] badTag=(byte[])encrypted.Tag.Clone();
    badTag[0]^=0x01;
    bool tagRejected=false;
    try{_ = CryptoBox.Decrypt(encrypted with {Tag=badTag},installationId,"snapshot",objectId);}
    catch(CryptographicException){tagRejected=true;}
    Check("AES_GCM_TAMPER_REJECTED",tagRejected);

    // Ed25519 and HMAC integrity.
    var pair=ReceiptSigner.Generate();
    byte[] signedPayload=Encoding.UTF8.GetBytes("{\"operation_id\":\"unit\",\"result_sha256\":\"abc\"}");
    byte[] signature=ReceiptSigner.Sign(pair.PrivateKey,signedPayload);
    Check("ED25519_SIGNATURE_VALID",ReceiptSigner.Verify(pair.PublicKey,signedPayload,signature));
    signedPayload[0]^=0x01;
    Check("ED25519_TAMPER_REJECTED",!ReceiptSigner.Verify(pair.PublicKey,signedPayload,signature));
    CryptographicOperations.ZeroMemory(pair.PrivateKey);

    byte[] hmacKey=RandomNumberGenerator.GetBytes(32);
    byte[] payload=Encoding.UTF8.GetBytes("canonical grant payload");
    byte[] mac=CryptoBox.Hmac(hmacKey,payload);
    Check("HMAC_VALID",CryptoBox.FixedEquals(mac,CryptoBox.Hmac(hmacKey,payload)));
    payload[0]^=0x01;
    Check("HMAC_PAYLOAD_TAMPER_REJECTED",!CryptoBox.FixedEquals(mac,CryptoBox.Hmac(hmacKey,payload)));
    CryptographicOperations.ZeroMemory(hmacKey);

    string tempRoot=Path.Combine(Path.GetTempPath(),"OcpMcpUnit-"+Guid.NewGuid().ToString("N"));
    var store=new SqliteStore(tempRoot);
    store.Initialize();
    string unitRepoRoot=Environment.GetEnvironmentVariable("OCPMCP_UNIT_REPO_ROOT")??throw new InvalidOperationException("UNIT_REPO_ROOT_NOT_SET");
    new SourceImporter(store).Import(unitRepoRoot);
    string eventTempRoot=tempRoot+"-events";
    var eventStore=new SqliteStore(eventTempRoot);
    eventStore.Initialize();
    using(var connection=eventStore.Open())
    {
        using(var tx=connection.BeginTransaction(deferred:false))
        {
            EventChain.Append(connection,tx,"unit-cycle","unit-attempt","UNIT_EVENT","TEST","unit-test",new{value="persisted"});
            tx.Commit();
        }
        var verification=EventChain.VerifyAll(connection);
        Check("EVENT_CHAIN_VALID",verification.Valid&&verification.VerifiedThrough==1);
        using(var tx=connection.BeginTransaction(deferred:false))
        {
            EventChain.Append(connection,tx,"unit-cycle","rollback-attempt","SHOULD_ROLL_BACK","TEST","unit-test",new{value="transient"});
        }
        verification=EventChain.VerifyAll(connection);
        Check("SQLITE_TRANSACTION_ROLLBACK",verification.Valid&&verification.VerifiedThrough==1);
        bool appendOnly=false;
        try
        {
            using var update=connection.CreateCommand();
            update.CommandText="UPDATE events SET event_type='ALTERED' WHERE event_sequence=1;";
            update.ExecuteNonQuery();
        }
        catch(SqliteException){appendOnly=true;}
        Check("EVENTS_APPEND_ONLY_TRIGGER",appendOnly);
        using var count=connection.CreateCommand();
        count.CommandText="SELECT COUNT(*) FROM telemetry_events;";
        Check("LOCAL_TELEMETRY_WRITTEN",Convert.ToInt32(count.ExecuteScalar())==1);
    }

    var allNotApplicable=Enumerable.Range(1,PrincipleCatalog.ExpectedCount)
        .Select(i=>(PrincipleId:$"P{i:D3}",Classification:"NO_APLICA")).ToArray();
    var derivedCnp=PrincipleCatalog.DeriveBaseSelection(allNotApplicable);
    Check("CNP_ALWAYS_SELECTED_WHEN_NO_APLICA",derivedCnp.SequenceEqual(PrincipleCatalog.ExpectedCnp.Order(StringComparer.Ordinal),StringComparer.Ordinal));
    var oneApplicable=allNotApplicable.Select(x=>x.PrincipleId=="P010"?(x.PrincipleId,"APLICA"):x).ToArray();
    var derivedWithApplicable=PrincipleCatalog.DeriveBaseSelection(oneApplicable);
    Check("APLICA_ADDED_TO_BASE_SELECTION",derivedWithApplicable.Contains("P010",StringComparer.Ordinal)&&PrincipleCatalog.ExpectedCnp.All(x=>derivedWithApplicable.Contains(x,StringComparer.Ordinal)));
    bool missingClassificationRejected=false;
    try{PrincipleCatalog.DeriveBaseSelection(allNotApplicable.Take(42));}
    catch(InvalidOperationException ex) when(ex.Message=="CLASSIFICATIONS_INCOMPLETE"){missingClassificationRejected=true;}
    Check("INCOMPLETE_43_CLASSIFICATIONS_REJECTED",missingClassificationRejected);

    // Synthetic authorization fixtures exercise the trusted-grant verification and
    // execution path; the interactive operator approval remains a separate manual step.
    string sid;
    using(var identity=WindowsIdentity.GetCurrent()) sid=identity.User?.Value??throw new InvalidOperationException("WINDOWS_SID_UNAVAILABLE");
    using(var connection=store.Open())
    {
        var installation=SqliteStore.GetInstallation(connection)??throw new InvalidOperationException("INSTALLATION_NOT_INITIALIZED");
        byte[] authorityKey=RandomNumberGenerator.GetBytes(32);
        var signingPair=ReceiptSigner.Generate();
        try
        {
            byte[] wrappedAuthority=CryptoBox.ProtectKey(authorityKey,CryptoBox.BuildEntropy(installation.InstallationId,"hmac-authority",sid,"1"));
            byte[] wrappedSigning=CryptoBox.ProtectKey(signingPair.PrivateKey,CryptoBox.BuildEntropy(installation.InstallationId,"receipt-ed25519",sid,"1"));
            using var tx=connection.BeginTransaction(deferred:false);
            using(var bind=connection.CreateCommand())
            {
                bind.Transaction=tx;
                bind.CommandText="UPDATE installation SET operator_sid=$sid,hmac_key_version=1 WHERE installation_id=$id;";
                bind.Parameters.AddWithValue("$sid",sid);bind.Parameters.AddWithValue("$id",installation.InstallationId);
                bind.ExecuteNonQuery();
            }
            KeyVault.UpsertKey(connection,tx,"hmac-authority","HMAC-SHA256",1,wrappedAuthority);
            KeyVault.UpsertKey(connection,tx,"receipt-ed25519","Ed25519",1,wrappedSigning);
            using(var pub=connection.CreateCommand())
            {
                pub.Transaction=tx;
                pub.CommandText="INSERT INTO key_metadata(key_id,key_type,key_version,public_key,fingerprint_sha256,created_at_utc,status) VALUES('receipt-ed25519-v1','Ed25519',1,$pub,$fp,$utc,'ACTIVE');";
                pub.Parameters.AddWithValue("$pub",signingPair.PublicKey);
                pub.Parameters.AddWithValue("$fp",Convert.ToHexStringLower(SHA256.HashData(signingPair.PublicKey)));
                pub.Parameters.AddWithValue("$utc",DateTimeOffset.UtcNow.ToString("O"));
                pub.ExecuteNonQuery();
            }
            tx.Commit();
        }
        finally
        {
            CryptographicOperations.ZeroMemory(authorityKey);
            CryptographicOperations.ZeroMemory(signingPair.PrivateKey);
        }
    }

    var backupService=new BackupService(store);
    backupService.CreateBackup(["DAILY"]);
    var vault=new KeyVault(store);
    var operations=new OperationService(store,vault,new PrincipleCatalog(store));

    string SeedGrant(string requestId,bool validMac)
    {
        using var c=store.Open();
        string payloadJson,payloadHash,requestStatus;
        using(var query=c.CreateCommand())
        {
            query.CommandText="SELECT payload_json,payload_sha256,status FROM operation_requests WHERE request_id=$id;";
            query.Parameters.AddWithValue("$id",requestId);
            using var rd=query.ExecuteReader();
            if(!rd.Read())throw new InvalidOperationException("TEST_REQUEST_NOT_FOUND");
            payloadJson=rd.GetString(0);payloadHash=rd.GetString(1);requestStatus=rd.GetString(2);
        }
        if(requestStatus!="PENDING_OPERATOR_APPROVAL")throw new InvalidOperationException("TEST_REQUEST_NOT_PENDING");
        using var document=JsonDocument.Parse(payloadJson);
        var root=document.RootElement;
        string nonce=root.GetProperty("nonce").GetString()??throw new InvalidDataException("TEST_NONCE_MISSING");
        string expires=root.GetProperty("expires_at_utc").GetString()??throw new InvalidDataException("TEST_EXPIRY_MISSING");
        var inst=SqliteStore.GetInstallation(c)??throw new InvalidOperationException("TEST_INSTALLATION_MISSING");
        byte[] wrapped;
        using(var keyQuery=c.CreateCommand())
        {
            keyQuery.CommandText="SELECT wrapped_key FROM key_store WHERE purpose='hmac-authority' AND key_version=1 AND status='ACTIVE';";
            wrapped=(byte[]?)keyQuery.ExecuteScalar()??throw new InvalidOperationException("TEST_HMAC_KEY_MISSING");
        }
        byte[] authority=CryptoBox.UnprotectKey(wrapped,CryptoBox.BuildEntropy(inst.InstallationId,"hmac-authority",sid,"1"));
        byte[] mac;
        try
        {
            mac=CryptoBox.Hmac(authority,Encoding.UTF8.GetBytes(payloadJson));
            if(!validMac)mac[0]^=0x80;
        }
        finally{CryptographicOperations.ZeroMemory(authority);}
        string nonceHash=Convert.ToHexStringLower(SHA256.HashData(Convert.FromBase64String(nonce)));
        using var tx=c.BeginTransaction(deferred:false);
        using(var insert=c.CreateCommand())
        {
            insert.Transaction=tx;
            insert.CommandText="""
                INSERT INTO authorization_grants(grant_id,request_id,operator_sid,key_version,nonce_hash,payload_sha256,mac,status,approved_at_utc,expires_at_utc)
                VALUES($grant,$request,$sid,1,$nonce,$hash,$mac,'APPROVED',$now,$expires);
                """;
            insert.Parameters.AddWithValue("$grant",Guid.NewGuid().ToString("N"));
            insert.Parameters.AddWithValue("$request",requestId);
            insert.Parameters.AddWithValue("$sid",sid);
            insert.Parameters.AddWithValue("$nonce",nonceHash);
            insert.Parameters.AddWithValue("$hash",payloadHash);
            insert.Parameters.AddWithValue("$mac",mac);
            insert.Parameters.AddWithValue("$now",DateTimeOffset.UtcNow.ToString("O"));
            insert.Parameters.AddWithValue("$expires",expires);
            insert.ExecuteNonQuery();
        }
        using(var update=c.CreateCommand())
        {
            update.Transaction=tx;
            update.CommandText="UPDATE operation_requests SET status='AUTHORIZED' WHERE request_id=$id AND status='PENDING_OPERATOR_APPROVAL';";
            update.Parameters.AddWithValue("$id",requestId);
            if(update.ExecuteNonQuery()!=1)throw new InvalidOperationException("TEST_AUTHORIZATION_STATE_RACE");
        }
        tx.Commit();
        return payloadHash;
    }

    JsonDocument CreateRequest(string project)
    {
        using var parameters=JsonDocument.Parse(JsonSerializer.Serialize(new{project_ref=project,conversation_ref="isolated-unit-test"}));
        object prepared=operations.Prepare("OPEN_CYCLE",parameters.RootElement);
        return JsonDocument.Parse(JsonSerializer.Serialize(prepared));
    }

    using(var request=CreateRequest("protected-operation"))
    {
        string requestId=request.RootElement.GetProperty("request_id").GetString()!;
        string expectedHash=SeedGrant(requestId,true);
        object result=operations.Execute(requestId);
        using var resultDoc=JsonDocument.Parse(JsonSerializer.Serialize(result));
        string receiptId=resultDoc.RootElement.GetProperty("receipt_id").GetString()!;
        Check("PROTECTED_OPERATION_EXECUTED",resultDoc.RootElement.GetProperty("status").GetString()=="COMPLETED");
        Check("PROTECTED_OPERATION_INPUT_HASH_BOUND",resultDoc.RootElement.GetProperty("request_id").GetString()==requestId);

        using var c=store.Open();
        string grantStatus,requestStatus;
        using(var q=c.CreateCommand())
        {
            q.CommandText="SELECT status FROM authorization_grants WHERE request_id=$id;";
            q.Parameters.AddWithValue("$id",requestId);grantStatus=Convert.ToString(q.ExecuteScalar())!;
        }
        using(var q=c.CreateCommand())
        {
            q.CommandText="SELECT status FROM operation_requests WHERE request_id=$id;";
            q.Parameters.AddWithValue("$id",requestId);requestStatus=Convert.ToString(q.ExecuteScalar())!;
        }
        Check("GRANT_CONSUMED_ATOMICALLY",grantStatus=="CONSUMED"&&requestStatus=="COMPLETED");

        string receiptJson,receiptHash;byte[] receiptSignature,publicKey;
        using(var q=c.CreateCommand())
        {
            q.CommandText="SELECT receipt_json,payload_sha256,signature FROM receipts WHERE receipt_id=$id;";
            q.Parameters.AddWithValue("$id",receiptId);
            using var rd=q.ExecuteReader();
            if(!rd.Read())throw new InvalidOperationException("TEST_RECEIPT_NOT_FOUND");
            receiptJson=rd.GetString(0);receiptHash=rd.GetString(1);receiptSignature=(byte[])rd[2];
        }
        using(var q=c.CreateCommand())
        {
            q.CommandText="SELECT public_key FROM key_metadata WHERE key_id='receipt-ed25519-v1';";
            publicKey=(byte[])q.ExecuteScalar()!;
        }
        byte[] receiptBytes=Encoding.UTF8.GetBytes(receiptJson);
        Check("RECEIPT_HASH_VALID",Convert.ToHexStringLower(SHA256.HashData(receiptBytes))==receiptHash);
        Check("RECEIPT_ED25519_VALID",ReceiptSigner.Verify(publicKey,receiptBytes,receiptSignature));
        using var receiptDocument=JsonDocument.Parse(receiptJson);
        Check("RECEIPT_OPERATION_ID_BOUND",receiptDocument.RootElement.GetProperty("request_id").GetString()==requestId);
        Check("RECEIPT_PROVENANCE_HASH_BOUND",receiptDocument.RootElement.GetProperty("input_sha256").GetString()==expectedHash);

        object replay=operations.Execute(requestId);
        using var replayDoc=JsonDocument.Parse(JsonSerializer.Serialize(replay));
        Check("PROTECTED_OPERATION_IDEMPOTENT_REPLAY",replayDoc.RootElement.GetProperty("receipt_id").GetString()==receiptId);
        Check("REPLAY_REVERIFIES_RECEIPT_SIGNATURE",replayDoc.RootElement.GetProperty("signature_valid").GetBoolean());
        using(var corrupt=store.Open())
        {
            using var drop=corrupt.CreateCommand();
            drop.CommandText="DROP TRIGGER receipts_no_update;";
            drop.ExecuteNonQuery();
            using var alter=corrupt.CreateCommand();
            alter.CommandText="UPDATE receipts SET receipt_json=REPLACE(receipt_json,'COMMITTED','CORRUPTED') WHERE request_id=$id;";
            alter.Parameters.AddWithValue("$id",requestId);
            alter.ExecuteNonQuery();
        }
        bool replayTamperRejected=false;
        try{operations.Execute(requestId);}
        catch(CryptographicException){replayTamperRejected=true;}
        Check("TAMPERED_RECEIPT_REJECTED_ON_REPLAY",replayTamperRejected);
        using var verifyEvents=store.Open();
        var chain=EventChain.VerifyAll(verifyEvents);
        Check("PROTECTED_OPERATION_EVENT_CHAIN",chain.Valid);
    }

    using(var badRequest=CreateRequest("tampered-grant"))
    {
        string requestId=badRequest.RootElement.GetProperty("request_id").GetString()!;
        SeedGrant(requestId,false);
        bool rejected=false;
        try{operations.Execute(requestId);}
        catch(CryptographicException){rejected=true;}
        Check("TAMPERED_GRANT_REJECTED",rejected);
        using var c=store.Open();
        using var count=c.CreateCommand();
        count.CommandText="SELECT COUNT(*) FROM cycles;";
        Check("TAMPERED_GRANT_NO_SIDE_EFFECT",Convert.ToInt32(count.ExecuteScalar())==1);
    }

    // End-to-end fail-closed selection gate: all 43 classifications and CNP are present,
    // but the source has no approved structured applicability/activation/mandatory/dependency metadata.
    string blockedCycleId="blocked-selection-"+Guid.NewGuid().ToString("N");
    using(var seed=store.Open())
    using(var tx=seed.BeginTransaction(deferred:false))
    {
        using(var cycle=seed.CreateCommand())
        {
            cycle.Transaction=tx;
            cycle.CommandText="INSERT INTO cycles(cycle_id,project_ref,conversation_ref,state,operator_sid,created_at_utc,updated_at_utc) VALUES($id,'selection-gate-unit','isolated','CLASSIFIED',$sid,$now,$now);";
            cycle.Parameters.AddWithValue("$id",blockedCycleId);
            cycle.Parameters.AddWithValue("$sid",sid);
            cycle.Parameters.AddWithValue("$now",DateTimeOffset.UtcNow.ToString("O"));
            cycle.ExecuteNonQuery();
        }
        foreach(var item in allNotApplicable)
        {
            using var classification=seed.CreateCommand();
            classification.Transaction=tx;
            classification.CommandText="INSERT INTO classifications(cycle_id,principle_id,classification,justification,evidence_refs_json,created_at_utc) VALUES($cycle,$principle,'NO_APLICA','Synthetic fixture for fail-closed selection test','[]',$now);";
            classification.Parameters.AddWithValue("$cycle",blockedCycleId);
            classification.Parameters.AddWithValue("$principle",item.PrincipleId);
            classification.Parameters.AddWithValue("$now",DateTimeOffset.UtcNow.ToString("O"));
            classification.ExecuteNonQuery();
        }
        tx.Commit();
    }

    using(var parameters=JsonDocument.Parse(JsonSerializer.Serialize(new{cycle_id=blockedCycleId})))
    using(var prepared=JsonDocument.Parse(JsonSerializer.Serialize(operations.Prepare("SET_SELECTION",parameters.RootElement))))
    {
        string requestId=prepared.RootElement.GetProperty("request_id").GetString()!;
        SeedGrant(requestId,true);
        bool blocked=false;
        try{operations.Execute(requestId);}
        catch(InvalidOperationException ex) when(ex.Message.StartsWith("BLOCKED_OCPMSP:",StringComparison.Ordinal)){blocked=true;}
        Check("SELECTION_BLOCKED_WITHOUT_APPROVED_METADATA",blocked);
        using var c=store.Open();
        using var selectionCount=c.CreateCommand();
        selectionCount.CommandText="SELECT COUNT(*) FROM selections WHERE cycle_id=$cycle;";
        selectionCount.Parameters.AddWithValue("$cycle",blockedCycleId);
        Check("BLOCKED_SELECTION_HAS_NO_SIDE_EFFECT",Convert.ToInt32(selectionCount.ExecuteScalar())==0);
        using var grantStatus=c.CreateCommand();
        grantStatus.CommandText="SELECT status FROM authorization_grants WHERE request_id=$id;";
        grantStatus.Parameters.AddWithValue("$id",requestId);
        Check("BLOCKED_SELECTION_ROLLS_BACK_GRANT",Convert.ToString(grantStatus.ExecuteScalar())=="APPROVED");
    }

    using(var parameters=JsonDocument.Parse(JsonSerializer.Serialize(new{cycle_id=blockedCycleId})))
    using(var prepared=JsonDocument.Parse(JsonSerializer.Serialize(operations.Prepare("BUILD_SNAPSHOT",parameters.RootElement))))
    {
        string requestId=prepared.RootElement.GetProperty("request_id").GetString()!;
        SeedGrant(requestId,true);
        bool blocked=false;
        try{operations.Execute(requestId);}
        catch(InvalidOperationException ex) when(ex.Message.StartsWith("BLOCKED_OCPMSP:",StringComparison.Ordinal)){blocked=true;}
        Check("SNAPSHOT_BLOCKED_WITHOUT_GOVERNED_SELECTION",blocked);
        using var c=store.Open();
        using var snapshotCount=c.CreateCommand();
        snapshotCount.CommandText="SELECT COUNT(*) FROM snapshots WHERE cycle_id=$cycle;";
        snapshotCount.Parameters.AddWithValue("$cycle",blockedCycleId);
        Check("BLOCKED_SNAPSHOT_HAS_NO_SIDE_EFFECT",Convert.ToInt32(snapshotCount.ExecuteScalar())==0);
    }

    try{Directory.Delete(tempRoot,true);}catch{}
    try{Directory.Delete(eventTempRoot,true);}catch{}
}
catch(Exception ex)
{
    failed++;
    Console.Error.WriteLine($"FAIL UNIT_EXCEPTION {ex.GetType().Name}: {ex.Message}");
}
Console.WriteLine($"UNIT_SUMMARY PASS={passed} FAIL={failed}");
return failed==0?0:1;
