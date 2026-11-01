using Microsoft.Data.Sqlite;

namespace OcpMcp;

public sealed class SqliteStore
{
    public const int CurrentSchemaVersion = 1;
    public string DatabasePath { get; }

    public SqliteStore(string dataRoot)
    {
        var dataDirectory = Path.Combine(dataRoot, "data");
        Directory.CreateDirectory(dataDirectory);
        DatabasePath = Path.Combine(dataDirectory, "ocp-mcp.sqlite");
    }

    public SqliteConnection Open()
    {
        var builder = new SqliteConnectionStringBuilder
        {
            DataSource = DatabasePath,
            Mode = SqliteOpenMode.ReadWriteCreate,
            Cache = SqliteCacheMode.Shared,
            Pooling = false,
            ForeignKeys = true,
            DefaultTimeout = 10
        };
        var connection = new SqliteConnection(builder.ToString());
        connection.Open();
        using var command = connection.CreateCommand();
        command.CommandText = """
            PRAGMA journal_mode=WAL;
            PRAGMA synchronous=FULL;
            PRAGMA foreign_keys=ON;
            PRAGMA busy_timeout=10000;
            """;
        command.ExecuteNonQuery();
        return connection;
    }

    public void Initialize()
    {
        using var connection = Open();
        using var command = connection.CreateCommand();
        command.CommandText = """
            CREATE TABLE IF NOT EXISTS schema_meta (
                singleton INTEGER PRIMARY KEY CHECK(singleton=1),
                schema_version INTEGER NOT NULL,
                updated_at_utc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS installation (
                installation_id TEXT PRIMARY KEY,
                operator_sid TEXT NULL,
                hmac_key_version INTEGER NOT NULL DEFAULT 1,
                created_at_utc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS key_store (
                key_id TEXT PRIMARY KEY,
                purpose TEXT NOT NULL,
                key_type TEXT NOT NULL,
                key_version INTEGER NOT NULL,
                wrapped_key BLOB NOT NULL,
                created_at_utc TEXT NOT NULL,
                status TEXT NOT NULL,
                UNIQUE(purpose,key_version)
            );
            CREATE TABLE IF NOT EXISTS canonical_sources (
                source_id TEXT PRIMARY KEY,
                repository_uri TEXT NOT NULL,
                canonical_path TEXT NOT NULL,
                ref_name TEXT NOT NULL,
                commit_id TEXT NOT NULL,
                git_blob_sha TEXT NULL,
                content_sha256 TEXT NOT NULL,
                captured_at_utc TEXT NOT NULL,
                verification_status TEXT NOT NULL,
                freshness_status TEXT NOT NULL,
                content_ciphertext BLOB NOT NULL,
                content_nonce BLOB NOT NULL,
                authentication_tag BLOB NOT NULL,
                wrapped_dek BLOB NOT NULL,
                dek_id TEXT NOT NULL,
                crypto_algorithm TEXT NOT NULL,
                crypto_version INTEGER NOT NULL,
                dpapi_scope TEXT NOT NULL,
                key_version INTEGER NOT NULL,
                aad_version INTEGER NOT NULL,
                encrypted_at_utc TEXT NOT NULL,
                rotated_at_utc TEXT NULL,
                UNIQUE(repository_uri,canonical_path,commit_id)
            );
            CREATE TABLE IF NOT EXISTS cycles (
                cycle_id TEXT PRIMARY KEY,
                project_ref TEXT NULL,
                conversation_ref TEXT NULL,
                state TEXT NOT NULL,
                operator_sid TEXT NOT NULL,
                created_at_utc TEXT NOT NULL,
                updated_at_utc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS classifications (
                cycle_id TEXT NOT NULL,
                principle_id TEXT NOT NULL,
                classification TEXT NOT NULL CHECK(classification IN ('APLICA','NO_APLICA','INCIERTO')),
                justification TEXT NOT NULL,
                evidence_refs_json TEXT NOT NULL,
                created_at_utc TEXT NOT NULL,
                PRIMARY KEY(cycle_id,principle_id),
                FOREIGN KEY(cycle_id) REFERENCES cycles(cycle_id)
            );
            CREATE TABLE IF NOT EXISTS selections (
                cycle_id TEXT PRIMARY KEY,
                selection_sha256 TEXT NOT NULL,
                principle_ids_json TEXT NOT NULL,
                created_at_utc TEXT NOT NULL,
                FOREIGN KEY(cycle_id) REFERENCES cycles(cycle_id)
            );
            CREATE TABLE IF NOT EXISTS operation_requests (
                request_id TEXT PRIMARY KEY,
                operation_id TEXT NOT NULL UNIQUE,
                attempt_id TEXT NOT NULL,
                operation_type TEXT NOT NULL,
                target_type TEXT NOT NULL,
                target_id TEXT NOT NULL,
                cycle_id TEXT NULL,
                parameters_json TEXT NOT NULL,
                payload_json TEXT NOT NULL,
                payload_sha256 TEXT NOT NULL,
                expected_state TEXT NOT NULL,
                requested_effect TEXT NOT NULL,
                status TEXT NOT NULL,
                created_at_utc TEXT NOT NULL,
                expires_at_utc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS authorization_grants (
                grant_id TEXT PRIMARY KEY,
                request_id TEXT NOT NULL UNIQUE,
                operator_sid TEXT NOT NULL,
                key_version INTEGER NOT NULL,
                nonce_hash TEXT NOT NULL UNIQUE,
                payload_sha256 TEXT NOT NULL,
                mac BLOB NOT NULL,
                status TEXT NOT NULL,
                approved_at_utc TEXT NOT NULL,
                expires_at_utc TEXT NOT NULL,
                consumed_at_utc TEXT NULL,
                revoked_at_utc TEXT NULL,
                FOREIGN KEY(request_id) REFERENCES operation_requests(request_id)
            );
            CREATE TABLE IF NOT EXISTS snapshots (
                snapshot_id TEXT PRIMARY KEY,
                cycle_id TEXT NOT NULL,
                operation_id TEXT NOT NULL UNIQUE,
                content_ciphertext BLOB NOT NULL,
                content_nonce BLOB NOT NULL,
                authentication_tag BLOB NOT NULL,
                wrapped_dek BLOB NOT NULL,
                dek_id TEXT NOT NULL,
                crypto_algorithm TEXT NOT NULL,
                crypto_version INTEGER NOT NULL,
                dpapi_scope TEXT NOT NULL,
                key_version INTEGER NOT NULL,
                aad_version INTEGER NOT NULL,
                content_sha256 TEXT NOT NULL,
                encrypted_at_utc TEXT NOT NULL,
                status TEXT NOT NULL,
                FOREIGN KEY(cycle_id) REFERENCES cycles(cycle_id)
            );
            CREATE TABLE IF NOT EXISTS events (
                event_sequence INTEGER PRIMARY KEY AUTOINCREMENT,
                event_id TEXT NOT NULL UNIQUE,
                cycle_id TEXT NULL,
                attempt_id TEXT NULL,
                event_type TEXT NOT NULL,
                actor_type TEXT NOT NULL,
                actor_ref TEXT NOT NULL,
                payload_json TEXT NOT NULL,
                payload_sha256 TEXT NOT NULL,
                previous_event_hash TEXT NULL,
                event_hash TEXT NOT NULL,
                created_at_utc TEXT NOT NULL
            );
            CREATE INDEX IF NOT EXISTS ix_events_cycle_sequence ON events(cycle_id,event_sequence);
            CREATE TABLE IF NOT EXISTS telemetry_events (
                event_id TEXT PRIMARY KEY,
                cycle_id TEXT NULL,
                attempt_id TEXT NULL,
                event_type TEXT NOT NULL,
                source TEXT NOT NULL,
                payload_redacted_json TEXT NOT NULL,
                payload_sha256 TEXT NOT NULL,
                status TEXT NOT NULL,
                occurred_at_utc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS receipts (
                receipt_id TEXT PRIMARY KEY,
                operation_id TEXT NOT NULL UNIQUE,
                request_id TEXT NOT NULL UNIQUE,
                cycle_id TEXT NULL,
                attempt_id TEXT NOT NULL,
                receipt_json TEXT NOT NULL,
                payload_sha256 TEXT NOT NULL,
                signature BLOB NOT NULL,
                signing_key_id TEXT NOT NULL,
                created_at_utc TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS key_metadata (
                key_id TEXT PRIMARY KEY,
                key_type TEXT NOT NULL,
                key_version INTEGER NOT NULL,
                public_key BLOB NULL,
                fingerprint_sha256 TEXT NULL,
                created_at_utc TEXT NOT NULL,
                status TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS backup_points (
                backup_id TEXT PRIMARY KEY,
                package_path TEXT NOT NULL,
                package_sha256 TEXT NOT NULL,
                created_at_utc TEXT NOT NULL,
                tags_json TEXT NOT NULL,
                verification_status TEXT NOT NULL
            );
            CREATE TRIGGER IF NOT EXISTS events_no_update BEFORE UPDATE ON events
            BEGIN SELECT RAISE(ABORT,'EVENTS_APPEND_ONLY'); END;
            CREATE TRIGGER IF NOT EXISTS events_no_delete BEFORE DELETE ON events
            BEGIN SELECT RAISE(ABORT,'EVENTS_APPEND_ONLY'); END;
            CREATE TRIGGER IF NOT EXISTS receipts_no_update BEFORE UPDATE ON receipts
            BEGIN SELECT RAISE(ABORT,'RECEIPTS_IMMUTABLE'); END;
            CREATE TRIGGER IF NOT EXISTS receipts_no_delete BEFORE DELETE ON receipts
            BEGIN SELECT RAISE(ABORT,'RECEIPTS_IMMUTABLE'); END;
            """;
        command.ExecuteNonQuery();
        using var meta = connection.CreateCommand();
        meta.CommandText = "INSERT OR IGNORE INTO schema_meta(singleton,schema_version,updated_at_utc) VALUES(1,$v,$utc);";
        meta.Parameters.AddWithValue("$v", CurrentSchemaVersion);
        meta.Parameters.AddWithValue("$utc", DateTimeOffset.UtcNow.ToString("O"));
        meta.ExecuteNonQuery();
        using var count = connection.CreateCommand();
        count.CommandText = "SELECT COUNT(*) FROM installation;";
        if (Convert.ToInt32(count.ExecuteScalar()) == 0)
        {
            using var insert = connection.CreateCommand();
            insert.CommandText = "INSERT INTO installation(installation_id,operator_sid,hmac_key_version,created_at_utc) VALUES($id,NULL,1,$utc);";
            insert.Parameters.AddWithValue("$id", Guid.NewGuid().ToString("N"));
            insert.Parameters.AddWithValue("$utc", DateTimeOffset.UtcNow.ToString("O"));
            insert.ExecuteNonQuery();
        }
    }

    public static string ScalarText(SqliteConnection connection, string sql, SqliteTransaction? tx = null)
    {
        using var command = connection.CreateCommand();
        command.Transaction = tx;
        command.CommandText = sql;
        return Convert.ToString(command.ExecuteScalar(), System.Globalization.CultureInfo.InvariantCulture) ?? "";
    }

    public static (string InstallationId, string? OperatorSid, int HmacKeyVersion)? GetInstallation(SqliteConnection connection, SqliteTransaction? tx = null)
    {
        using var command = connection.CreateCommand();
        command.Transaction = tx;
        command.CommandText = "SELECT installation_id,operator_sid,hmac_key_version FROM installation LIMIT 1;";
        using var reader = command.ExecuteReader();
        if (!reader.Read()) return null;
        return (reader.GetString(0), reader.IsDBNull(1) ? null : reader.GetString(1), reader.GetInt32(2));
    }
}
