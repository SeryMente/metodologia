using Microsoft.Data.Sqlite;
using OcpMcp;
using OcpMcp.Security;
using System.Security.Cryptography;
using System.Text;

var passed=0;
var failed=0;
void Check(string name,bool value)
{
    if(value){passed++;Console.WriteLine($"PASS {name}");}
    else{failed++;Console.WriteLine($"FAIL {name}");}
}

try
{
    byte[] clear=Encoding.UTF8.GetBytes("OCP MCP AES-256-GCM + DPAPI CurrentUser test payload.");
    string installationId=Guid.NewGuid().ToString("N");
    string objectId=Guid.NewGuid().ToString("N");
    var encrypted=CryptoBox.Encrypt(clear,installationId,"snapshot",objectId);
    byte[] restored=CryptoBox.Decrypt(encrypted,installationId,"snapshot",objectId);
    Check("AES_GCM_DPAPI_ROUNDTRIP",CryptographicOperations.FixedTimeEquals(clear,restored));
    CryptographicOperations.ZeroMemory(restored);
    byte[] badTag=(byte[])encrypted.Tag.Clone();
    badTag[0]^=0x01;
    var tampered=encrypted with {Tag=badTag};
    bool tagRejected=false;
    try{_ = CryptoBox.Decrypt(tampered,installationId,"snapshot",objectId);}
    catch(CryptographicException){tagRejected=true;}
    Check("AES_GCM_TAMPER_REJECTED",tagRejected);

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
    using(var connection=store.Open())
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
            // Intentionally dispose without commit.
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
    try{Directory.Delete(tempRoot,true);}catch{}
}
catch(Exception ex)
{
    failed++;
    Console.Error.WriteLine($"FAIL UNIT_EXCEPTION {ex.GetType().Name}: {ex.Message}");
}
Console.WriteLine($"UNIT_SUMMARY PASS={passed} FAIL={failed}");
return failed==0?0:1;
