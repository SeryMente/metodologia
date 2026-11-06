using Microsoft.Data.Sqlite;
using OcpMcp.Security;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

namespace OcpMcp.Services;

internal sealed class PprRecoveryMap
{
    public int MapVersion { get; set; } = 1;
    public List<PprKeyStoreMaterial> KeyStore { get; set; } = [];
    public List<PprDekMaterial> CanonicalSourceDeks { get; set; } = [];
    public List<PprDekMaterial> SnapshotDeks { get; set; } = [];
}

internal sealed class PprKeyStoreMaterial
{
    public string KeyId { get; set; } = "";
    public string Purpose { get; set; } = "";
    public string KeyType { get; set; } = "";
    public int KeyVersion { get; set; }
    public string Status { get; set; } = "";
    public byte[] Secret { get; set; } = [];
}

internal sealed class PprDekMaterial
{
    public string ObjectId { get; set; } = "";
    public string DekId { get; set; } = "";
    public byte[] Secret { get; set; } = [];
}

public sealed class PortableRecoveryService(SqliteStore store)
{
    private sealed record PprSwapState(string TargetPath, string RollbackDb, string RollbackWal, string RollbackShm, bool MovedDb, bool MovedWal, bool MovedShm, string PackageId);

    private static readonly JsonSerializerOptions MapJson = new() { PropertyNameCaseInsensitive = false };
    private readonly KeyVault _vault = new(store);

    public string ExportInteractive(string outputPath)
    {
        PprFormat.RequireInteractiveConsole();
        byte[] passphrase = PprFormat.ReadPassphraseTwice();
        try { return ExportCore(outputPath, passphrase); }
        finally { CryptographicOperations.ZeroMemory(passphrase); }
    }

    internal string ExportForTests(string outputPath, byte[] passphraseUtf8) =>
        ExportCore(outputPath, passphraseUtf8);

    public void RestoreInteractive(string packagePath)
    {
        PprFormat.RequireInteractiveConsole();
        PprArchive archive = PprFormat.ReadArchive(Path.GetFullPath(packagePath));
        byte[] passphrase = [];
        try
        {
            string prefix = archive.Manifest.PackageId[..8];
            Console.WriteLine("Portable Recovery Package v1");
            Console.WriteLine($"Package: {archive.Manifest.PackageId}");
            Console.WriteLine($"Installation: {archive.Manifest.InstallationId}");
            Console.WriteLine($"SID de origen: {archive.Manifest.SourceOperatorSid}");
            Console.WriteLine($"SID de destino: {_vault.CurrentSid()}");
            Console.WriteLine("La restauración sustituirá la base MCP-OCP del directorio de datos actual.");
            Console.Write($"Confirme escribiendo exactamente RESTORE {prefix}: ");
            if (!string.Equals(Console.ReadLine(), $"RESTORE {prefix}", StringComparison.Ordinal))
                throw new InvalidOperationException("PPR_RESTORE_NOT_CONFIRMED");
            passphrase = PprFormat.ReadPassphraseOnce("Recovery phrase (entrada oculta): ");
            RestoreCore(archive, passphrase);
        }
        finally
        {
            if (passphrase.Length > 0) CryptographicOperations.ZeroMemory(passphrase);
            ClearArchive(archive);
        }
    }

    internal void RestoreForTests(string packagePath, byte[] passphraseUtf8, string? destinationSidForTests = null)
    {
        PprArchive archive = PprFormat.ReadArchive(Path.GetFullPath(packagePath));
        try { RestoreCore(archive, passphraseUtf8, destinationSidForTests); }
        finally { ClearArchive(archive); }
    }

    private string ExportCore(string outputPath, byte[] passphraseUtf8)
    {
        EnsureWindows();
        if (passphraseUtf8.Length < 16) throw new ArgumentException("PPR_PASSPHRASE_TOO_SHORT");
        if (!File.Exists(store.DatabasePath))
            throw new FileNotFoundException("OCP_MCP_DATABASE_NOT_FOUND", store.DatabasePath);

        string fullOutput = Path.GetFullPath(outputPath);
        if (!string.Equals(Path.GetExtension(fullOutput), ".ocprecovery", StringComparison.OrdinalIgnoreCase))
            throw new ArgumentException("PPR_OUTPUT_EXTENSION_MUST_BE_OCPRECOVERY");
        if (File.Exists(fullOutput)) throw new IOException("PPR_OUTPUT_ALREADY_EXISTS");
        Directory.CreateDirectory(Path.GetDirectoryName(fullOutput) ?? throw new InvalidDataException("PPR_OUTPUT_DIRECTORY_INVALID"));

        string tempId = Guid.NewGuid().ToString("N");
        string snapshotPath = Path.Combine(Path.GetTempPath(), $"ocpmcp-ppr-{tempId}.sqlite");
        string packageStage = fullOutput + "." + tempId + ".tmp";
        byte[] databaseBytes = [];
        byte[] mapBytes = [];
        byte[] pmk = [];
        byte[] kek = [];
        byte[] salt = [];
        byte[] snapshotBlob = [];
        byte[] envelopeBlob = [];
        byte[] mapBlob = [];
        PprRecoveryMap? map = null;
        try
        {
            CreateConsistentSnapshot(snapshotPath);
            string installationId;
            string sourceSid;
            using (var snapshot = OpenDatabase(snapshotPath, readOnly: true))
            {
                VerifyDatabase(snapshot);
                var installation = ReadInstallation(snapshot);
                installationId = installation.InstallationId;
                sourceSid = installation.OperatorSid ?? throw new CryptographicException("PPR_SOURCE_INSTALLATION_UNPROVISIONED");
                if (!string.Equals(sourceSid, _vault.CurrentSid(), StringComparison.Ordinal))
                    throw new UnauthorizedAccessException("PPR_SOURCE_OPERATOR_SID_MISMATCH");
                map = CaptureRecoveryMap(snapshot, installationId, sourceSid);
                VerifyReceipts(snapshot);
                var chain = EventChain.VerifyAll(snapshot);
                if (!chain.Valid) throw new CryptographicException("PPR_SOURCE_EVENT_CHAIN_INVALID");
            }

            databaseBytes = File.ReadAllBytes(snapshotPath);
            string databaseSha = PprFormat.Sha256(databaseBytes);
            salt = RandomNumberGenerator.GetBytes(PprFormat.SaltBytes);
            pmk = RandomNumberGenerator.GetBytes(PprFormat.KeyBytes);
            kek = PprFormat.DeriveKey(passphraseUtf8, salt);
            mapBytes = JsonSerializer.SerializeToUtf8Bytes(map, MapJson);

            string packageId = Guid.NewGuid().ToString("D");
            snapshotBlob = PprFormat.EncryptFramed(databaseBytes, pmk,
                PprFormat.SnapshotAad(packageId, installationId, databaseSha));
            envelopeBlob = PprFormat.EncryptFramed(pmk, kek,
                PprFormat.EnvelopeAad(packageId, installationId));
            mapBlob = PprFormat.EncryptFramed(mapBytes, pmk,
                PprFormat.RecoveryMapAad(packageId, installationId, databaseSha));

            var manifest = new PprManifest
            {
                PackageId = packageId,
                CreatedAtUtc = DateTimeOffset.UtcNow.ToString("O"),
                InstallationId = installationId,
                SourceOperatorSid = sourceSid,
                SchemaVersion = ReadSchemaVersionFromSnapshot(snapshotPath),
                AppVersion = typeof(PortableRecoveryService).Assembly.GetName().Version?.ToString() ?? "0.1.0",
                DatabaseSha256 = databaseSha,
                Kdf = new PprKdf { SaltBase64 = Convert.ToBase64String(salt) },
                Artifacts = new PprArtifacts
                {
                    Snapshot = PprFormat.DescribeArtifact(snapshotBlob),
                    Envelope = PprFormat.DescribeArtifact(envelopeBlob),
                    RecoveryMap = PprFormat.DescribeArtifact(mapBlob)
                }
            };
            PprFormat.ValidateManifest(manifest);
            PprFormat.WriteArchive(packageStage, manifest, snapshotBlob, envelopeBlob, mapBlob);
            VerifyStagedPackage(packageStage, passphraseUtf8, manifest);

            File.Move(packageStage, fullOutput, false);
            using var final = File.OpenRead(fullOutput);
            string finalHash = Convert.ToHexStringLower(SHA256.HashData(final));
            Console.WriteLine($"PPR_EXPORT_VERIFIED package_id={packageId} bytes={new FileInfo(fullOutput).Length} sha256={finalHash}");
            return packageId;
        }
        finally
        {
            TryDelete(snapshotPath);
            TryDelete(snapshotPath + "-wal");
            TryDelete(snapshotPath + "-shm");
            TryDelete(packageStage);
            ZeroMap(map);
            Zero(databaseBytes, mapBytes, pmk, kek, salt, snapshotBlob, envelopeBlob, mapBlob);
        }
    }

    private void VerifyStagedPackage(string path, byte[] passphrase, PprManifest expected)
    {
        PprArchive archive = PprFormat.ReadArchive(path);
        byte[] salt = [];
        byte[] kek = [];
        byte[] pmk = [];
        byte[] database = [];
        byte[] mapBytes = [];
        PprRecoveryMap? map = null;
        try
        {
            if (archive.Manifest.PackageId != expected.PackageId ||
                archive.Manifest.InstallationId != expected.InstallationId ||
                archive.Manifest.DatabaseSha256 != expected.DatabaseSha256)
                throw new InvalidDataException("PPR_STAGED_MANIFEST_MISMATCH");
            salt = Convert.FromBase64String(archive.Manifest.Kdf.SaltBase64);
            kek = PprFormat.DeriveKey(passphrase, salt);
            pmk = PprFormat.DecryptFramed(archive.Envelope, kek,
                PprFormat.EnvelopeAad(expected.PackageId, expected.InstallationId), PprFormat.KeyBytes);
            database = PprFormat.DecryptFramed(archive.Snapshot, pmk,
                PprFormat.SnapshotAad(expected.PackageId, expected.InstallationId, expected.DatabaseSha256));
            if (!string.Equals(PprFormat.Sha256(database), expected.DatabaseSha256, StringComparison.Ordinal))
                throw new CryptographicException("PPR_STAGED_DATABASE_HASH_MISMATCH");
            mapBytes = PprFormat.DecryptFramed(archive.RecoveryMap, pmk,
                PprFormat.RecoveryMapAad(expected.PackageId, expected.InstallationId, expected.DatabaseSha256));
            map = JsonSerializer.Deserialize<PprRecoveryMap>(mapBytes, MapJson)
                ?? throw new InvalidDataException("PPR_RECOVERY_MAP_INVALID");
            if (map.MapVersion != 1 || map.KeyStore.Count == 0)
                throw new InvalidDataException("PPR_RECOVERY_MAP_INCOMPLETE");
        }
        finally
        {
            ZeroMap(map);
            ClearArchive(archive);
            Zero(salt, kek, pmk, database, mapBytes);
        }
    }

    private void RestoreCore(PprArchive archive, byte[] passphraseUtf8, string? destinationSidOverride = null)
    {
        EnsureWindows();
        if (passphraseUtf8.Length < 16) throw new ArgumentException("PPR_PASSPHRASE_TOO_SHORT");
        if (archive.Manifest.SchemaVersion != SqliteStore.CurrentSchemaVersion)
            throw new InvalidDataException("PPR_SCHEMA_VERSION_UNSUPPORTED");

        string destinationSid = destinationSidOverride ?? _vault.CurrentSid();
        if (string.IsNullOrWhiteSpace(destinationSid))
            throw new UnauthorizedAccessException("PPR_DESTINATION_SID_UNAVAILABLE");
        byte[] salt = [];
        byte[] kek = [];
        byte[] pmk = [];
        byte[] databaseBytes = [];
        byte[] mapBytes = [];
        PprRecoveryMap? map = null;
        PprSwapState? swapState = null;
        string stagePath = store.DatabasePath + ".ppr-" + Guid.NewGuid().ToString("N") + ".tmp";
        try
        {
            salt = Convert.FromBase64String(archive.Manifest.Kdf.SaltBase64);
            kek = PprFormat.DeriveKey(passphraseUtf8, salt);
            pmk = PprFormat.DecryptFramed(archive.Envelope, kek,
                PprFormat.EnvelopeAad(archive.Manifest.PackageId, archive.Manifest.InstallationId), PprFormat.KeyBytes);
            databaseBytes = PprFormat.DecryptFramed(archive.Snapshot, pmk,
                PprFormat.SnapshotAad(archive.Manifest.PackageId, archive.Manifest.InstallationId, archive.Manifest.DatabaseSha256));
            if (!string.Equals(PprFormat.Sha256(databaseBytes), archive.Manifest.DatabaseSha256, StringComparison.Ordinal))
                throw new CryptographicException("PPR_DATABASE_HASH_MISMATCH");
            mapBytes = PprFormat.DecryptFramed(archive.RecoveryMap, pmk,
                PprFormat.RecoveryMapAad(archive.Manifest.PackageId, archive.Manifest.InstallationId, archive.Manifest.DatabaseSha256));
            map = JsonSerializer.Deserialize<PprRecoveryMap>(mapBytes, MapJson)
                ?? throw new InvalidDataException("PPR_RECOVERY_MAP_INVALID");
            if (map.MapVersion != 1) throw new InvalidDataException("PPR_RECOVERY_MAP_VERSION_UNSUPPORTED");

            Directory.CreateDirectory(Path.GetDirectoryName(store.DatabasePath)!);
            File.WriteAllBytes(stagePath, databaseBytes);
            string sourceSid;
            using (var connection = OpenDatabase(stagePath, readOnly: false))
            {
                ConfigureStagingDatabase(connection);
                VerifyDatabase(connection);
                var installed = ReadInstallation(connection);
                string installationId = installed.InstallationId;
                sourceSid = installed.OperatorSid ?? throw new CryptographicException("PPR_SOURCE_INSTALLATION_UNPROVISIONED");
                if (installationId != archive.Manifest.InstallationId || sourceSid != archive.Manifest.SourceOperatorSid)
                    throw new CryptographicException("PPR_INSTALLATION_OR_SOURCE_SID_MISMATCH");
                ApplyRecoveryMap(connection, map, installationId, sourceSid, destinationSid, archive.Manifest);
                VerifyDatabase(connection);
                VerifyRewrappedKeyMaterial(connection, installationId, destinationSid);
                VerifyReceipts(connection);
                var chain = EventChain.VerifyAll(connection);
                if (!chain.Valid) throw new CryptographicException("PPR_RESTORED_EVENT_CHAIN_INVALID");
            }

            swapState = ReplaceDatabaseAtomically(stagePath, store.DatabasePath, archive.Manifest.PackageId);
            using (var restored = OpenDatabase(store.DatabasePath, readOnly: true))
            {
                VerifyDatabase(restored);
                var installation = ReadInstallation(restored);
                if (installation.OperatorSid != destinationSid || installation.InstallationId != archive.Manifest.InstallationId)
                    throw new CryptographicException("PPR_RESTORED_IDENTITY_MISMATCH");
                VerifyReceipts(restored);
                var chain = EventChain.VerifyAll(restored);
                if (!chain.Valid) throw new CryptographicException("PPR_RESTORED_EVENT_CHAIN_INVALID");
            }
            Console.WriteLine($"PPR_RESTORE_VERIFIED package_id={archive.Manifest.PackageId} installation_id={archive.Manifest.InstallationId} destination_sid={destinationSid}");
            if (swapState is not null && swapState.MovedDb)
                Console.WriteLine("PPR_ROLLBACK_DATABASE_PRESERVED=" + swapState.RollbackDb);
            swapState = null;
        }
        catch
        {
            if (swapState is not null) RollbackDatabaseSwap(swapState);
            TryDelete(stagePath);
            TryDelete(stagePath + "-wal");
            TryDelete(stagePath + "-shm");
            throw;
        }
        finally
        {
            ZeroMap(map);
            Zero(salt, kek, pmk, databaseBytes, mapBytes);
        }
    }

    private void CreateConsistentSnapshot(string snapshotPath)
    {
        TryDelete(snapshotPath);
        using var source = store.Open();
        using var target = new SqliteConnection(new SqliteConnectionStringBuilder
        {
            DataSource = snapshotPath,
            Mode = SqliteOpenMode.ReadWriteCreate,
            Pooling = false,
            ForeignKeys = true,
            DefaultTimeout = 30
        }.ToString());
        target.Open();
        ConfigureStagingDatabase(target);
        source.BackupDatabase(target);
        VerifyDatabase(target);
    }

    private static SqliteConnection OpenDatabase(string path, bool readOnly)
    {
        var builder = new SqliteConnectionStringBuilder
        {
            DataSource = path,
            Mode = readOnly ? SqliteOpenMode.ReadOnly : SqliteOpenMode.ReadWrite,
            Pooling = false,
            ForeignKeys = true,
            DefaultTimeout = 30
        };
        var connection = new SqliteConnection(builder.ToString());
        connection.Open();
        return connection;
    }

    private static void ConfigureStagingDatabase(SqliteConnection connection)
    {
        using var command = connection.CreateCommand();
        command.CommandText = "PRAGMA foreign_keys=ON; PRAGMA synchronous=FULL; PRAGMA journal_mode=DELETE;";
        command.ExecuteNonQuery();
    }

    private PprRecoveryMap CaptureRecoveryMap(SqliteConnection connection, string installationId, string sourceSid)
    {
        var map = new PprRecoveryMap();
        try
        {
        var keyIds = new HashSet<string>(StringComparer.Ordinal);
        using (var command = connection.CreateCommand())
        {
            command.CommandText = "SELECT key_id,purpose,key_type,key_version,wrapped_key,status FROM key_store ORDER BY key_id;";
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                string keyId = reader.GetString(0);
                string purpose = reader.GetString(1);
                string keyType = reader.GetString(2);
                int version = reader.GetInt32(3);
                byte[] wrapped = (byte[])reader[4];
                string status = reader.GetString(5);
                if (!keyIds.Add(keyId)) throw new InvalidDataException("PPR_DUPLICATE_KEY_STORE_ID");
                if (purpose is not ("hmac-authority" or "receipt-ed25519"))
                    throw new CryptographicException("PPR_UNSUPPORTED_KEY_PURPOSE");
                if (status is not ("ACTIVE" or "RETIRED"))
                    throw new CryptographicException("PPR_KEY_STATUS_UNSUPPORTED");
                if ((purpose == "hmac-authority" && keyType != "HMAC-SHA256") ||
                    (purpose == "receipt-ed25519" && keyType != "Ed25519"))
                    throw new CryptographicException("PPR_KEY_TYPE_MISMATCH");
                byte[] secret = CryptoBox.UnprotectKey(wrapped,
                    CryptoBox.BuildEntropy(installationId, purpose, sourceSid, version.ToString(System.Globalization.CultureInfo.InvariantCulture)));
                if (secret.Length != PprFormat.KeyBytes)
                {
                    CryptographicOperations.ZeroMemory(secret);
                    throw new CryptographicException("PPR_KEY_LENGTH_INVALID");
                }
                map.KeyStore.Add(new PprKeyStoreMaterial
                {
                    KeyId = keyId, Purpose = purpose, KeyType = keyType,
                    KeyVersion = version, Status = status, Secret = secret
                });
            }
        }
        if (map.KeyStore.Count == 0 ||
            !map.KeyStore.Any(x => x.Purpose == "hmac-authority" && x.Status == "ACTIVE") ||
            !map.KeyStore.Any(x => x.Purpose == "receipt-ed25519" && x.Status == "ACTIVE"))
            throw new CryptographicException("PPR_REQUIRED_KEY_MATERIAL_MISSING");

        using (var command = connection.CreateCommand())
        {
            command.CommandText = "SELECT source_id,dek_id,wrapped_dek,dpapi_scope FROM canonical_sources ORDER BY source_id;";
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                string sourceId = reader.GetString(0);
                string dekId = reader.GetString(1);
                byte[] wrapped = (byte[])reader[2];
                if (reader.GetString(3) != "CurrentUser")
                    throw new CryptographicException("PPR_CANONICAL_SOURCE_SCOPE_UNSUPPORTED");
                byte[] dek = CryptoBox.UnprotectKey(wrapped, CryptoBox.BuildEntropy(installationId, "canonical-source", sourceId, dekId));
                if (dek.Length != PprFormat.KeyBytes)
                {
                    CryptographicOperations.ZeroMemory(dek);
                    throw new CryptographicException("PPR_CANONICAL_SOURCE_DEK_LENGTH_INVALID");
                }
                map.CanonicalSourceDeks.Add(new PprDekMaterial { ObjectId = sourceId, DekId = dekId, Secret = dek });
            }
        }

        using (var command = connection.CreateCommand())
        {
            command.CommandText = "SELECT snapshot_id,dek_id,wrapped_dek,dpapi_scope FROM snapshots ORDER BY snapshot_id;";
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                string snapshotId = reader.GetString(0);
                string dekId = reader.GetString(1);
                byte[] wrapped = (byte[])reader[2];
                if (reader.GetString(3) != "CurrentUser")
                    throw new CryptographicException("PPR_SNAPSHOT_SCOPE_UNSUPPORTED");
                byte[] dek = CryptoBox.UnprotectKey(wrapped, CryptoBox.BuildEntropy(installationId, "snapshot", snapshotId, dekId));
                if (dek.Length != PprFormat.KeyBytes)
                {
                    CryptographicOperations.ZeroMemory(dek);
                    throw new CryptographicException("PPR_SNAPSHOT_DEK_LENGTH_INVALID");
                }
                map.SnapshotDeks.Add(new PprDekMaterial { ObjectId = snapshotId, DekId = dekId, Secret = dek });
            }
        }
        return map;
        }
        catch
        {
            ZeroMap(map);
            throw;
        }
    }

    private void ApplyRecoveryMap(SqliteConnection connection, PprRecoveryMap map, string installationId,
        string sourceSid, string destinationSid, PprManifest manifest)
    {
        if (map.KeyStore.Count == 0) throw new InvalidDataException("PPR_RECOVERY_MAP_EMPTY");
        using var transaction = connection.BeginTransaction(deferred: false);
        var actualKeys = new Dictionary<string, (string Purpose, string Type, int Version, string Status)>(StringComparer.Ordinal);
        using (var command = connection.CreateCommand())
        {
            command.Transaction = transaction;
            command.CommandText = "SELECT key_id,purpose,key_type,key_version,status FROM key_store;";
            using var reader = command.ExecuteReader();
            while (reader.Read())
                actualKeys.Add(reader.GetString(0), (reader.GetString(1), reader.GetString(2), reader.GetInt32(3), reader.GetString(4)));
        }
        if (actualKeys.Count != map.KeyStore.Count) throw new CryptographicException("PPR_KEY_STORE_MAP_COUNT_MISMATCH");
        var seen = new HashSet<string>(StringComparer.Ordinal);
        foreach (var item in map.KeyStore)
        {
            if (!seen.Add(item.KeyId) || !actualKeys.TryGetValue(item.KeyId, out var actual) ||
                actual.Purpose != item.Purpose || actual.Type != item.KeyType ||
                actual.Version != item.KeyVersion || actual.Status != item.Status ||
                item.Secret.Length != PprFormat.KeyBytes ||
                item.Purpose is not ("hmac-authority" or "receipt-ed25519"))
                throw new CryptographicException("PPR_KEY_STORE_MAP_MISMATCH");
            byte[] entropy = CryptoBox.BuildEntropy(installationId, item.Purpose, destinationSid,
                item.KeyVersion.ToString(System.Globalization.CultureInfo.InvariantCulture));
            byte[] wrapped = CryptoBox.ProtectKey(item.Secret, entropy);
            using var update = connection.CreateCommand();
            update.Transaction = transaction;
            update.CommandText = "UPDATE key_store SET wrapped_key=$wrapped WHERE key_id=$id AND purpose=$purpose AND key_version=$version;";
            update.Parameters.AddWithValue("$wrapped", wrapped);
            update.Parameters.AddWithValue("$id", item.KeyId);
            update.Parameters.AddWithValue("$purpose", item.Purpose);
            update.Parameters.AddWithValue("$version", item.KeyVersion);
            if (update.ExecuteNonQuery() != 1) throw new InvalidOperationException("PPR_KEY_STORE_REWRAP_FAILED");
            Zero(entropy, wrapped);
        }

        RewrapDekRows(connection, transaction, installationId, map.CanonicalSourceDeks,
            "SELECT source_id,dek_id,dpapi_scope FROM canonical_sources ORDER BY source_id;",
            "UPDATE canonical_sources SET wrapped_dek=$wrapped,dpapi_scope='CurrentUser' WHERE source_id=$id AND dek_id=$dek;",
            "canonical-source");
        RewrapDekRows(connection, transaction, installationId, map.SnapshotDeks,
            "SELECT snapshot_id,dek_id,dpapi_scope FROM snapshots ORDER BY snapshot_id;",
            "UPDATE snapshots SET wrapped_dek=$wrapped,dpapi_scope='CurrentUser' WHERE snapshot_id=$id AND dek_id=$dek;",
            "snapshot");

        using (var update = connection.CreateCommand())
        {
            update.Transaction = transaction;
            update.CommandText = "UPDATE installation SET operator_sid=$destination WHERE installation_id=$id AND operator_sid=$source;";
            update.Parameters.AddWithValue("$destination", destinationSid);
            update.Parameters.AddWithValue("$id", installationId);
            update.Parameters.AddWithValue("$source", sourceSid);
            if (update.ExecuteNonQuery() != 1) throw new InvalidOperationException("PPR_OPERATOR_SID_REBIND_FAILED");
        }
        using (var revoke = connection.CreateCommand())
        {
            revoke.Transaction = transaction;
            revoke.CommandText = "UPDATE authorization_grants SET status='REVOKED',revoked_at_utc=$now WHERE operator_sid=$source AND status='APPROVED' AND consumed_at_utc IS NULL;";
            revoke.Parameters.AddWithValue("$now", DateTimeOffset.UtcNow.ToString("O"));
            revoke.Parameters.AddWithValue("$source", sourceSid);
            revoke.ExecuteNonQuery();
        }
        RevokePendingRequests(connection, transaction, sourceSid);
        using (var sourceOnly = connection.CreateCommand())
        {
            sourceOnly.Transaction = transaction;
            sourceOnly.CommandText = "UPDATE backup_points SET verification_status='SOURCE_HOST_ONLY';";
            sourceOnly.ExecuteNonQuery();
        }
        EventChain.Append(connection, transaction, null, null, "PORTABLE_RECOVERY_IMPORTED", "OPERATOR", destinationSid,
            new
            {
                package_id = manifest.PackageId,
                installation_id = installationId,
                source_operator_sid = sourceSid,
                destination_operator_sid = destinationSid,
                database_sha256 = manifest.DatabaseSha256,
                key_store_keys = map.KeyStore.Count,
                canonical_source_deks = map.CanonicalSourceDeks.Count,
                snapshot_deks = map.SnapshotDeks.Count
            });
        transaction.Commit();
    }

    private static void RewrapDekRows(SqliteConnection connection, SqliteTransaction transaction, string installationId,
        List<PprDekMaterial> materials, string selectSql, string updateSql, string objectType)
    {
        var actual = new Dictionary<string, (string DekId, string Scope)>(StringComparer.Ordinal);
        using (var query = connection.CreateCommand())
        {
            query.Transaction = transaction;
            query.CommandText = selectSql;
            using var reader = query.ExecuteReader();
            while (reader.Read()) actual.Add(reader.GetString(0), (reader.GetString(1), reader.GetString(2)));
        }
        if (actual.Count != materials.Count) throw new CryptographicException("PPR_DEK_MAP_COUNT_MISMATCH");
        var seen = new HashSet<string>(StringComparer.Ordinal);
        foreach (var item in materials)
        {
            if (!seen.Add(item.ObjectId) || !actual.TryGetValue(item.ObjectId, out var row) ||
                row.DekId != item.DekId || row.Scope != "CurrentUser" || item.Secret.Length != PprFormat.KeyBytes)
                throw new CryptographicException("PPR_DEK_MAP_MISMATCH");
            byte[] entropy = CryptoBox.BuildEntropy(installationId, objectType, item.ObjectId, item.DekId);
            byte[] wrapped = [];
            try
            {
                wrapped = CryptoBox.ProtectKey(item.Secret, entropy);
                using var update = connection.CreateCommand();
                update.Transaction = transaction;
                update.CommandText = updateSql;
                update.Parameters.AddWithValue("$wrapped", wrapped);
                update.Parameters.AddWithValue("$id", item.ObjectId);
                update.Parameters.AddWithValue("$dek", item.DekId);
                if (update.ExecuteNonQuery() != 1) throw new InvalidOperationException("PPR_DEK_REWRAP_FAILED");
            }
            finally { Zero(entropy, wrapped); }
        }
    }

    private static void RevokePendingRequests(SqliteConnection connection, SqliteTransaction transaction, string sourceSid)
    {
        var ids = new List<string>();
        using (var query = connection.CreateCommand())
        {
            query.Transaction = transaction;
            query.CommandText = "SELECT request_id,payload_json FROM operation_requests WHERE status IN ('PENDING_OPERATOR_APPROVAL','AUTHORIZED');";
            using var reader = query.ExecuteReader();
            while (reader.Read())
            {
                string requestId = reader.GetString(0);
                using var doc = JsonDocument.Parse(reader.GetString(1));
                string requestSid = doc.RootElement.TryGetProperty("operator_sid", out var sid)
                    ? sid.GetString() ?? "" : "";
                if (requestSid != sourceSid) throw new CryptographicException("PPR_PENDING_REQUEST_SID_MISMATCH");
                ids.Add(requestId);
            }
        }
        foreach (string requestId in ids)
        {
            using var update = connection.CreateCommand();
            update.Transaction = transaction;
            update.CommandText = "UPDATE operation_requests SET status='REVOKED' WHERE request_id=$id AND status IN ('PENDING_OPERATOR_APPROVAL','AUTHORIZED');";
            update.Parameters.AddWithValue("$id", requestId);
            if (update.ExecuteNonQuery() != 1) throw new InvalidOperationException("PPR_REQUEST_REVOCATION_FAILED");
        }
    }

    private static void VerifyRewrappedKeyMaterial(SqliteConnection connection, string installationId, string destinationSid)
    {
        using (var query = connection.CreateCommand())
        {
            query.CommandText = "SELECT purpose,key_version,wrapped_key FROM key_store;";
            using var reader = query.ExecuteReader();
            while (reader.Read())
            {
                string purpose = reader.GetString(0);
                int version = reader.GetInt32(1);
                byte[] wrapped = (byte[])reader[2];
                byte[] clear = CryptoBox.UnprotectKey(wrapped,
                    CryptoBox.BuildEntropy(installationId, purpose, destinationSid,
                        version.ToString(System.Globalization.CultureInfo.InvariantCulture)));
                try
                {
                    if (clear.Length != PprFormat.KeyBytes) throw new CryptographicException("PPR_REWRAPPED_KEY_INVALID");
                }
                finally { CryptographicOperations.ZeroMemory(clear); }
            }
        }
        VerifyDekTable(connection, installationId, "SELECT source_id,dek_id,wrapped_dek,dpapi_scope FROM canonical_sources;", "canonical-source");
        VerifyDekTable(connection, installationId, "SELECT snapshot_id,dek_id,wrapped_dek,dpapi_scope FROM snapshots;", "snapshot");
    }

    private static void VerifyDekTable(SqliteConnection connection, string installationId, string sql, string objectType)
    {
        using var query = connection.CreateCommand();
        query.CommandText = sql;
        using var reader = query.ExecuteReader();
        while (reader.Read())
        {
            string objectId = reader.GetString(0);
            string dekId = reader.GetString(1);
            byte[] wrapped = (byte[])reader[2];
            if (reader.GetString(3) != "CurrentUser") throw new CryptographicException("PPR_REWRAPPED_DEK_SCOPE_INVALID");
            byte[] clear = CryptoBox.UnprotectKey(wrapped, CryptoBox.BuildEntropy(installationId, objectType, objectId, dekId));
            try
            {
                if (clear.Length != PprFormat.KeyBytes) throw new CryptographicException("PPR_REWRAPPED_DEK_INVALID");
            }
            finally { CryptographicOperations.ZeroMemory(clear); }
        }
    }

    private static void VerifyReceipts(SqliteConnection connection)
    {
        byte[] publicKey;
        string fingerprint;
        using (var key = connection.CreateCommand())
        {
            key.CommandText = "SELECT public_key,fingerprint_sha256 FROM key_metadata WHERE key_id='receipt-ed25519-v1' AND status='ACTIVE';";
            using var reader = key.ExecuteReader();
            if (!reader.Read()) throw new CryptographicException("PPR_RECEIPT_PUBLIC_KEY_MISSING");
            publicKey = (byte[])reader[0];
            fingerprint = reader.GetString(1);
        }
        try
        {
            string actualFingerprint = Convert.ToHexStringLower(SHA256.HashData(publicKey));
            if (actualFingerprint != fingerprint) throw new CryptographicException("PPR_RECEIPT_PUBLIC_KEY_FINGERPRINT_INVALID");
            using var command = connection.CreateCommand();
            command.CommandText = "SELECT request_id,receipt_json,payload_sha256,signature,signing_key_id FROM receipts ORDER BY created_at_utc,receipt_id;";
            using var receipts = command.ExecuteReader();
            while (receipts.Read())
            {
                string requestId = receipts.GetString(0);
                byte[] bytes = Encoding.UTF8.GetBytes(receipts.GetString(1));
                string hash = Convert.ToHexStringLower(SHA256.HashData(bytes));
                string storedHash = receipts.GetString(2);
                byte[] signature = (byte[])receipts[3];
                string keyId = receipts.GetString(4);
                try
                {
                    if (keyId != "receipt-ed25519-v1" || hash != storedHash)
                        throw new CryptographicException("PPR_RECEIPT_HASH_OR_KEY_ID_INVALID");
                    using var doc = JsonDocument.Parse(bytes);
                    string embeddedRequest = doc.RootElement.GetProperty("request_id").GetString() ?? "";
                    string embeddedFingerprint = doc.RootElement.GetProperty("signing_public_key_sha256").GetString() ?? "";
                    if (embeddedRequest != requestId || embeddedFingerprint != actualFingerprint)
                        throw new CryptographicException("PPR_RECEIPT_BINDING_INVALID");
                    if (!ReceiptSigner.Verify(publicKey, bytes, signature))
                        throw new CryptographicException("PPR_RECEIPT_SIGNATURE_INVALID");
                }
                finally { CryptographicOperations.ZeroMemory(bytes); }
            }
        }
        finally { CryptographicOperations.ZeroMemory(publicKey); }
    }

    private static void VerifyDatabase(SqliteConnection connection)
    {
        using (var quick = connection.CreateCommand())
        {
            quick.CommandText = "PRAGMA quick_check;";
            if (!string.Equals(Convert.ToString(quick.ExecuteScalar()), "ok", StringComparison.Ordinal))
                throw new InvalidDataException("PPR_SQLITE_QUICK_CHECK_FAILED");
        }
        using (var integrity = connection.CreateCommand())
        {
            integrity.CommandText = "PRAGMA integrity_check;";
            if (!string.Equals(Convert.ToString(integrity.ExecuteScalar()), "ok", StringComparison.Ordinal))
                throw new InvalidDataException("PPR_SQLITE_INTEGRITY_CHECK_FAILED");
        }
        using (var foreign = connection.CreateCommand())
        {
            foreign.CommandText = "PRAGMA foreign_key_check;";
            using var reader = foreign.ExecuteReader();
            if (reader.Read()) throw new InvalidDataException("PPR_SQLITE_FOREIGN_KEY_CHECK_FAILED");
        }
    }

    private static (string InstallationId, string? OperatorSid, int HmacKeyVersion) ReadInstallation(SqliteConnection connection)
    {
        var installation = SqliteStore.GetInstallation(connection)
            ?? throw new InvalidDataException("PPR_INSTALLATION_ROW_MISSING");
        using var command = connection.CreateCommand();
        command.CommandText = "SELECT schema_version FROM schema_meta WHERE singleton=1;";
        int version = Convert.ToInt32(command.ExecuteScalar());
        if (version != SqliteStore.CurrentSchemaVersion)
            throw new InvalidDataException("PPR_DATABASE_SCHEMA_VERSION_UNSUPPORTED");
        return installation;
    }

    private static int ReadSchemaVersionFromSnapshot(string path)
    {
        using var connection = OpenDatabase(path, true);
        using var command = connection.CreateCommand();
        command.CommandText = "SELECT schema_version FROM schema_meta WHERE singleton=1;";
        return Convert.ToInt32(command.ExecuteScalar());
    }

    private static PprSwapState ReplaceDatabaseAtomically(string stagePath, string targetPath, string packageId)
    {
        EnsureNoRunningServer();
        string directory = Path.GetDirectoryName(targetPath) ?? throw new InvalidDataException("PPR_TARGET_DIRECTORY_INVALID");
        Directory.CreateDirectory(directory);
        string rollbackBase = targetPath + ".pre-ppr-" + packageId.Replace("-", "");
        string rollbackDb = rollbackBase;
        string rollbackWal = rollbackBase + "-wal";
        string rollbackShm = rollbackBase + "-shm";
        string targetWal = targetPath + "-wal";
        string targetShm = targetPath + "-shm";
        bool movedDb = false, movedWal = false, movedShm = false, movedStage = false;
        try
        {
            if (File.Exists(targetPath))
            {
                using (var exclusiveProbe = new FileStream(targetPath, FileMode.Open, FileAccess.ReadWrite, FileShare.None))
                    exclusiveProbe.Flush();
                File.Move(targetPath, rollbackDb, false);
                movedDb = true;
            }
            if (File.Exists(targetWal)) { File.Move(targetWal, rollbackWal, false); movedWal = true; }
            if (File.Exists(targetShm)) { File.Move(targetShm, rollbackShm, false); movedShm = true; }
            File.Move(stagePath, targetPath, false);
            movedStage = true;
            using var verify = OpenDatabase(targetPath, true);
            VerifyDatabase(verify);
        }
        catch
        {
            if (movedStage) TryDelete(targetPath);
            if (movedShm && File.Exists(rollbackShm) && !File.Exists(targetShm)) File.Move(rollbackShm, targetShm, false);
            if (movedWal && File.Exists(rollbackWal) && !File.Exists(targetWal)) File.Move(rollbackWal, targetWal, false);
            if (movedDb && File.Exists(rollbackDb) && !File.Exists(targetPath)) File.Move(rollbackDb, targetPath, false);
            throw;
        }
        return new PprSwapState(targetPath, rollbackDb, rollbackWal, rollbackShm, movedDb, movedWal, movedShm, packageId);
    }

    private static void RollbackDatabaseSwap(PprSwapState state)
    {
        string failedDb = state.TargetPath + ".failed-ppr-" + state.PackageId.Replace("-", "");
        string failedWal = failedDb + "-wal";
        string failedShm = failedDb + "-shm";
        if (File.Exists(state.TargetPath)) File.Move(state.TargetPath, failedDb, false);
        if (File.Exists(state.TargetPath + "-wal")) File.Move(state.TargetPath + "-wal", failedWal, false);
        if (File.Exists(state.TargetPath + "-shm")) File.Move(state.TargetPath + "-shm", failedShm, false);
        if (state.MovedWal && File.Exists(state.RollbackWal)) File.Move(state.RollbackWal, state.TargetPath + "-wal", false);
        if (state.MovedShm && File.Exists(state.RollbackShm)) File.Move(state.RollbackShm, state.TargetPath + "-shm", false);
        if (state.MovedDb && File.Exists(state.RollbackDb)) File.Move(state.RollbackDb, state.TargetPath, false);
        if (state.MovedDb && File.Exists(state.TargetPath))
        {
            using var restored = OpenDatabase(state.TargetPath, readOnly: true);
            VerifyDatabase(restored);
        }
        Console.Error.WriteLine("PPR_POST_SWAP_VALIDATION_FAILED_ROLLBACK_RESTORED");
    }

    private static void EnsureNoRunningServer()
    {
        foreach (var process in Process.GetProcessesByName("OcpMcp"))
        {
            using (process)
            {
                if (process.Id != Environment.ProcessId)
                    throw new IOException("PPR_RESTORE_ABORT_SERVER_PROCESS_RUNNING");
            }
        }
    }

    private static void ClearArchive(PprArchive archive) =>
        Zero(archive.Snapshot, archive.Envelope, archive.RecoveryMap);

    private static void ZeroMap(PprRecoveryMap? map)
    {
        if (map is null) return;
        foreach (var item in map.KeyStore) Zero(item.Secret);
        foreach (var item in map.CanonicalSourceDeks) Zero(item.Secret);
        foreach (var item in map.SnapshotDeks) Zero(item.Secret);
    }

    private static void Zero(params byte[][] arrays)
    {
        foreach (byte[] array in arrays)
            if (array is { Length: > 0 }) CryptographicOperations.ZeroMemory(array);
    }

    private static void TryDelete(string path)
    {
        try { if (File.Exists(path)) File.Delete(path); } catch { }
    }

    private static void EnsureWindows()
    {
        if (!OperatingSystem.IsWindows()) throw new PlatformNotSupportedException("PPR_REQUIRES_WINDOWS_DPAPI");
    }
}
