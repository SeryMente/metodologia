using Microsoft.Data.Sqlite;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

namespace OcpMcp.Security;

public sealed record EventResult(long Sequence, string EventId, string EventHash);

public static class EventChain
{
    public static EventResult Append(SqliteConnection connection, SqliteTransaction tx, string? cycleId, string? attemptId,
        string eventType, string actorType, string actorRef, object payload)
    {
        string payloadJson = CanonicalJson.Serialize(payload);
        string payloadHash = Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(payloadJson)));
        string previous = "";
        using (var prev = connection.CreateCommand())
        {
            prev.Transaction = tx;
            prev.CommandText = "SELECT event_hash FROM events ORDER BY event_sequence DESC LIMIT 1;";
            previous = Convert.ToString(prev.ExecuteScalar()) ?? "";
        }
        string eventId = Guid.NewGuid().ToString("N");
        string utc = DateTimeOffset.UtcNow.ToString("O");
        string canonical = CanonicalJson.Serialize(new {
            event_id=eventId, cycle_id=cycleId, attempt_id=attemptId, event_type=eventType,
            actor_type=actorType, actor_ref=actorRef, payload_sha256=payloadHash,
            previous_event_hash=previous, created_at_utc=utc
        });
        string eventHash = Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(canonical)));
        using var command = connection.CreateCommand();
        command.Transaction = tx;
        command.CommandText = """
            INSERT INTO events(event_id,cycle_id,attempt_id,event_type,actor_type,actor_ref,payload_json,payload_sha256,previous_event_hash,event_hash,created_at_utc)
            VALUES($id,$cycle,$attempt,$type,$actor,$actorRef,$payload,$payloadHash,$previous,$hash,$utc);
            """;
        command.Parameters.AddWithValue("$id", eventId);
        command.Parameters.AddWithValue("$cycle", (object?)cycleId ?? DBNull.Value);
        command.Parameters.AddWithValue("$attempt", (object?)attemptId ?? DBNull.Value);
        command.Parameters.AddWithValue("$type", eventType);
        command.Parameters.AddWithValue("$actor", actorType);
        command.Parameters.AddWithValue("$actorRef", actorRef);
        command.Parameters.AddWithValue("$payload", payloadJson);
        command.Parameters.AddWithValue("$payloadHash", payloadHash);
        command.Parameters.AddWithValue("$previous", previous);
        command.Parameters.AddWithValue("$hash", eventHash);
        command.Parameters.AddWithValue("$utc", utc);
        command.ExecuteNonQuery();

        using var telemetry = connection.CreateCommand();
        telemetry.Transaction = tx;
        string telemetryPayload = CanonicalJson.Serialize(new { payload_sha256=payloadHash, outcome="RECORDED" });
        telemetry.CommandText = """
            INSERT INTO telemetry_events(event_id,cycle_id,attempt_id,event_type,source,payload_redacted_json,payload_sha256,status,occurred_at_utc)
            VALUES($id,$cycle,$attempt,$type,'local',$payload,$hash,'RECORDED',$utc);
            """;
        telemetry.Parameters.AddWithValue("$id", Guid.NewGuid().ToString("N"));
        telemetry.Parameters.AddWithValue("$cycle", (object?)cycleId ?? DBNull.Value);
        telemetry.Parameters.AddWithValue("$attempt", (object?)attemptId ?? DBNull.Value);
        telemetry.Parameters.AddWithValue("$type", eventType);
        telemetry.Parameters.AddWithValue("$payload", telemetryPayload);
        telemetry.Parameters.AddWithValue("$hash", Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(telemetryPayload))));
        telemetry.Parameters.AddWithValue("$utc", utc);
        telemetry.ExecuteNonQuery();
        using var seq = connection.CreateCommand();
        seq.Transaction = tx;
        seq.CommandText = "SELECT event_sequence FROM events WHERE event_id=$id;";
        seq.Parameters.AddWithValue("$id",eventId);
        return new EventResult(Convert.ToInt64(seq.ExecuteScalar()), eventId, eventHash);
    }

    public static (bool Valid,long VerifiedThrough,string? Error) VerifyAll(SqliteConnection connection)
    {
        var rows=new List<(long Sequence,string EventId,string? CycleId,string? AttemptId,string Type,string ActorType,string ActorRef,string PayloadJson,string PayloadHash,string Previous,string EventHash,string Created)>();
        using(var command=connection.CreateCommand())
        {
            command.CommandText="SELECT event_sequence,event_id,cycle_id,attempt_id,event_type,actor_type,actor_ref,payload_json,payload_sha256,COALESCE(previous_event_hash,''),event_hash,created_at_utc FROM events ORDER BY event_sequence;";
            using var reader=command.ExecuteReader();
            while(reader.Read()) rows.Add((
                reader.GetInt64(0),reader.GetString(1),reader.IsDBNull(2)?null:reader.GetString(2),
                reader.IsDBNull(3)?null:reader.GetString(3),reader.GetString(4),reader.GetString(5),
                reader.GetString(6),reader.GetString(7),reader.GetString(8),reader.GetString(9),
                reader.GetString(10),reader.GetString(11)));
        }
        string previous="";
        long verified=0;
        foreach(var row in rows)
        {
            string actualPayloadHash=Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(row.PayloadJson)));
            if(!string.Equals(actualPayloadHash,row.PayloadHash,StringComparison.Ordinal))
                return(false,verified,$"PAYLOAD_HASH_MISMATCH:{row.Sequence}");
            if(!string.Equals(row.Previous,previous,StringComparison.Ordinal))
                return(false,verified,$"PREVIOUS_HASH_MISMATCH:{row.Sequence}");
            string canonical=CanonicalJson.Serialize(new {
                event_id=row.EventId,cycle_id=row.CycleId,attempt_id=row.AttemptId,event_type=row.Type,
                actor_type=row.ActorType,actor_ref=row.ActorRef,payload_sha256=row.PayloadHash,
                previous_event_hash=row.Previous,created_at_utc=row.Created
            });
            string actual=Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(canonical)));
            if(!string.Equals(actual,row.EventHash,StringComparison.Ordinal))
                return(false,verified,$"EVENT_HASH_MISMATCH:{row.Sequence}");
            previous=row.EventHash;
            verified=row.Sequence;
        }
        return(true,verified,null);
    }

}

public static class CanonicalJson
{
    public static string Serialize<T>(T value)
    {
        JsonDocument doc = JsonDocument.Parse(JsonSerializer.Serialize(value, new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower }));
        using var stream = new MemoryStream();
        using (var writer = new Utf8JsonWriter(stream)) WriteElement(writer, doc.RootElement);
        return Encoding.UTF8.GetString(stream.ToArray());
    }

    private static void WriteElement(Utf8JsonWriter writer, JsonElement element)
    {
        switch (element.ValueKind)
        {
            case JsonValueKind.Object:
                writer.WriteStartObject();
                foreach (var property in element.EnumerateObject().OrderBy(p => p.Name, StringComparer.Ordinal))
                {
                    writer.WritePropertyName(property.Name);
                    WriteElement(writer, property.Value);
                }
                writer.WriteEndObject();
                break;
            case JsonValueKind.Array:
                writer.WriteStartArray();
                foreach (var item in element.EnumerateArray()) WriteElement(writer, item);
                writer.WriteEndArray();
                break;
            default: element.WriteTo(writer); break;
        }
    }
}

public static class ReceiptWriter
{
    public static (string ReceiptId, string PayloadHash) Insert(SqliteConnection connection, SqliteTransaction tx,
        KeyVault vault, string operationId, string requestId, string? cycleId, string attemptId,
        string operationType, string inputHash, string resultHash, EventResult evt)
    {
        string receiptId = Guid.NewGuid().ToString("N");
        string utc = DateTimeOffset.UtcNow.ToString("O");
        var publicKey = GetPublicKey(connection, tx);
        var receipt = new {
            receipt_id=receiptId, receipt_version=1, operation_id=operationId, request_id=requestId,
            operation_type=operationType, cycle_id=cycleId, attempt_id=attemptId,
            operator_sid=vault.ReadInstallation(connection,tx).OperatorSid,
            operation_outcome="COMMITTED", input_sha256=inputHash, result_sha256=resultHash,
            event_sequence=evt.Sequence, event_id=evt.EventId, event_chain_head_sha256=evt.EventHash,
            signing_key_id="receipt-ed25519-v1", signing_public_key_sha256=Convert.ToHexStringLower(SHA256.HashData(publicKey)),
            created_at_utc=utc
        };
        string json = CanonicalJson.Serialize(receipt);
        byte[] bytes = Encoding.UTF8.GetBytes(json);
        string hash = Convert.ToHexStringLower(SHA256.HashData(bytes));
        byte[] privateKey = vault.LoadSigningPrivateKey(connection,tx);
        byte[] signature;
        try { signature = ReceiptSigner.Sign(privateKey, bytes); }
        finally { CryptographicOperations.ZeroMemory(privateKey); }
        using var cmd = connection.CreateCommand();
        cmd.Transaction = tx;
        cmd.CommandText = """
            INSERT INTO receipts(receipt_id,operation_id,request_id,cycle_id,attempt_id,receipt_json,payload_sha256,signature,signing_key_id,created_at_utc)
            VALUES($id,$operation,$request,$cycle,$attempt,$json,$hash,$sig,'receipt-ed25519-v1',$utc);
            """;
        cmd.Parameters.AddWithValue("$id",receiptId);
        cmd.Parameters.AddWithValue("$operation",operationId);
        cmd.Parameters.AddWithValue("$request",requestId);
        cmd.Parameters.AddWithValue("$cycle",(object?)cycleId ?? DBNull.Value);
        cmd.Parameters.AddWithValue("$attempt",attemptId);
        cmd.Parameters.AddWithValue("$json",json);
        cmd.Parameters.AddWithValue("$hash",hash);
        cmd.Parameters.AddWithValue("$sig",signature);
        cmd.Parameters.AddWithValue("$utc",utc);
        cmd.ExecuteNonQuery();
        return (receiptId,hash);
    }

    private static byte[] GetPublicKey(SqliteConnection connection, SqliteTransaction tx)
    {
        using var command = connection.CreateCommand();
        command.Transaction=tx;
        command.CommandText="SELECT public_key FROM key_metadata WHERE key_id='receipt-ed25519-v1' AND status='ACTIVE';";
        return (byte[]?)command.ExecuteScalar() ?? throw new CryptographicException("RECEIPT_PUBLIC_KEY_NOT_FOUND");
    }
}
