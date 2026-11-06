using Microsoft.Data.Sqlite;
using OcpMcp;
using OcpMcp.Security;
using OcpMcp.Services;
using System.IO.Compression;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Text.Json;

internal static class PortableRecoveryTests
{
    public static IReadOnlyList<(string Name, bool Passed)> Run()
    {
        var results = new List<(string Name, bool Passed)>();
        string root = Path.Combine(Path.GetTempPath(), "OcpMcpPpr-" + Guid.NewGuid().ToString("N"));
        string sourceRoot = Path.Combine(root, "source");
        string destinationRoot = Path.Combine(root, "destination");
        string failureRoot = Path.Combine(root, "failure");
        string packagePath = Path.Combine(root, "fixture.ocprecovery");
        string tamperedPath = Path.Combine(root, "tampered.ocprecovery");
        byte[] passphrase = Encoding.UTF8.GetBytes("PPR-Unit-Test-Recovery-2026!");
        string destinationSid = "S-1-5-21-909090909-808080808-707070707-1107";
        string installationId = "";
        string sourceId = "source-fixture-001";
        string snapshotId = "snapshot-fixture-001";
        string sourceText = "canonical source payload for portable recovery";
        string snapshotText = "snapshot payload for portable recovery";
        string authorizedRequestId = "request-authorized-fixture";
        string pendingRequestId = "request-pending-fixture";
        string consumedRequestId = "request-consumed-fixture";
        string receiptRequestId = "request-receipt-fixture";
        string receiptId = "receipt-fixture-001";
        string backupId = "backup-fixture-001";

        try
        {
            using var identity = WindowsIdentity.GetCurrent();
            string sourceSid = identity.User?.Value ?? throw new InvalidOperationException("PPR_TEST_WINDOWS_SID_UNAVAILABLE");
            var sourceStore = new SqliteStore(sourceRoot);
            sourceStore.Initialize();

            using (var connection = sourceStore.Open())
            {
                using var transaction = connection.BeginTransaction(deferred: false);
                var initial = SqliteStore.GetInstallation(connection, transaction)
                    ?? throw new InvalidOperationException("PPR_TEST_INSTALLATION_MISSING");
                installationId = initial.InstallationId;

                using (var bind = connection.CreateCommand())
                {
                    bind.Transaction = transaction;
                    bind.CommandText = "UPDATE installation SET operator_sid=$sid,hmac_key_version=1 WHERE installation_id=$id;";
                    bind.Parameters.AddWithValue("$sid", sourceSid);
                    bind.Parameters.AddWithValue("$id", installationId);
                    if (bind.ExecuteNonQuery() != 1) throw new InvalidOperationException("PPR_TEST_OPERATOR_BIND_FAILED");
                }

                byte[] hmacActive = RandomNumberGenerator.GetBytes(32);
                byte[] hmacRetired = RandomNumberGenerator.GetBytes(32);
                var signing = ReceiptSigner.Generate();
                try
                {
                    byte[] wrappedActive = CryptoBox.ProtectKey(hmacActive,
                        CryptoBox.BuildEntropy(installationId, "hmac-authority", sourceSid, "1"));
                    byte[] wrappedRetired = CryptoBox.ProtectKey(hmacRetired,
                        CryptoBox.BuildEntropy(installationId, "hmac-authority", sourceSid, "0"));
                    byte[] wrappedSigning = CryptoBox.ProtectKey(signing.PrivateKey,
                        CryptoBox.BuildEntropy(installationId, "receipt-ed25519", sourceSid, "1"));
                    KeyVault.UpsertKey(connection, transaction, "hmac-authority", "HMAC-SHA256", 1, wrappedActive);
                    KeyVault.UpsertKey(connection, transaction, "hmac-authority", "HMAC-SHA256", 0, wrappedRetired);
                    KeyVault.UpsertKey(connection, transaction, "receipt-ed25519", "Ed25519", 1, wrappedSigning);

                    using (var retired = connection.CreateCommand())
                    {
                        retired.Transaction = transaction;
                        retired.CommandText = "UPDATE key_store SET status='RETIRED' WHERE purpose='hmac-authority' AND key_version=0;";
                        retired.ExecuteNonQuery();
                    }

                    string fingerprint = Convert.ToHexStringLower(SHA256.HashData(signing.PublicKey));
                    using (var publicKey = connection.CreateCommand())
                    {
                        publicKey.Transaction = transaction;
                        publicKey.CommandText = "INSERT INTO key_metadata(key_id,key_type,key_version,public_key,fingerprint_sha256,created_at_utc,status) VALUES('receipt-ed25519-v1','Ed25519',1,$public,$fingerprint,$created,'ACTIVE');";
                        publicKey.Parameters.AddWithValue("$public", signing.PublicKey);
                        publicKey.Parameters.AddWithValue("$fingerprint", fingerprint);
                        publicKey.Parameters.AddWithValue("$created", DateTimeOffset.UtcNow.ToString("O"));
                        publicKey.ExecuteNonQuery();
                    }

                    const string cycleId = "ppr-cycle-fixture";
                    using (var cycle = connection.CreateCommand())
                    {
                        cycle.Transaction = transaction;
                        cycle.CommandText = "INSERT INTO cycles(cycle_id,project_ref,conversation_ref,state,operator_sid,created_at_utc,updated_at_utc) VALUES($id,'ppr-unit','ppr-unit','SNAPSHOTTED',$sid,$now,$now);";
                        cycle.Parameters.AddWithValue("$id", cycleId);
                        cycle.Parameters.AddWithValue("$sid", sourceSid);
                        cycle.Parameters.AddWithValue("$now", DateTimeOffset.UtcNow.ToString("O"));
                        cycle.ExecuteNonQuery();
                    }

                    var sourceEncrypted = CryptoBox.Encrypt(Encoding.UTF8.GetBytes(sourceText), installationId, "canonical-source", sourceId);
                    using (var source = connection.CreateCommand())
                    {
                        source.Transaction = transaction;
                        source.CommandText = """
                            INSERT INTO canonical_sources(source_id,repository_uri,canonical_path,ref_name,commit_id,git_blob_sha,content_sha256,captured_at_utc,verification_status,freshness_status,content_ciphertext,content_nonce,authentication_tag,wrapped_dek,dek_id,crypto_algorithm,crypto_version,dpapi_scope,key_version,aad_version,encrypted_at_utc)
                            VALUES($id,'https://example.invalid/ppr.git','README.md','main',$commit,$blob,$hash,$captured,'VERIFIED_AT_IMPORT','CURRENT',$cipher,$nonce,$tag,$wrapped,$dek,'AES-256-GCM',1,'CurrentUser',1,1,$encryptedAt);
                            """;
                        source.Parameters.AddWithValue("$id", sourceId);
                        source.Parameters.AddWithValue("$commit", new string('a', 40));
                        source.Parameters.AddWithValue("$blob", new string('b', 40));
                        source.Parameters.AddWithValue("$hash", sourceEncrypted.ContentSha256);
                        source.Parameters.AddWithValue("$captured", DateTimeOffset.UtcNow.ToString("O"));
                        source.Parameters.AddWithValue("$cipher", sourceEncrypted.Ciphertext);
                        source.Parameters.AddWithValue("$nonce", sourceEncrypted.Nonce);
                        source.Parameters.AddWithValue("$tag", sourceEncrypted.Tag);
                        source.Parameters.AddWithValue("$wrapped", sourceEncrypted.WrappedDek);
                        source.Parameters.AddWithValue("$dek", sourceEncrypted.DekId);
                        source.Parameters.AddWithValue("$encryptedAt", DateTimeOffset.UtcNow.ToString("O"));
                        source.ExecuteNonQuery();
                    }

                    var snapshotEncrypted = CryptoBox.Encrypt(Encoding.UTF8.GetBytes(snapshotText), installationId, "snapshot", snapshotId);
                    using (var snapshot = connection.CreateCommand())
                    {
                        snapshot.Transaction = transaction;
                        snapshot.CommandText = """
                            INSERT INTO snapshots(snapshot_id,cycle_id,operation_id,content_ciphertext,content_nonce,authentication_tag,wrapped_dek,dek_id,crypto_algorithm,crypto_version,dpapi_scope,key_version,aad_version,content_sha256,encrypted_at_utc,status)
                            VALUES($id,$cycle,$operation,$cipher,$nonce,$tag,$wrapped,$dek,'AES-256-GCM',1,'CurrentUser',1,1,$hash,$created,'BUILT');
                            """;
                        snapshot.Parameters.AddWithValue("$id", snapshotId);
                        snapshot.Parameters.AddWithValue("$cycle", cycleId);
                        snapshot.Parameters.AddWithValue("$operation", "ppr-operation-fixture");
                        snapshot.Parameters.AddWithValue("$cipher", snapshotEncrypted.Ciphertext);
                        snapshot.Parameters.AddWithValue("$nonce", snapshotEncrypted.Nonce);
                        snapshot.Parameters.AddWithValue("$tag", snapshotEncrypted.Tag);
                        snapshot.Parameters.AddWithValue("$wrapped", snapshotEncrypted.WrappedDek);
                        snapshot.Parameters.AddWithValue("$dek", snapshotEncrypted.DekId);
                        snapshot.Parameters.AddWithValue("$hash", snapshotEncrypted.ContentSha256);
                        snapshot.Parameters.AddWithValue("$created", DateTimeOffset.UtcNow.ToString("O"));
                        snapshot.ExecuteNonQuery();
                    }

                    SeedRequest(connection, transaction, sourceSid, authorizedRequestId, "AUTHORIZED", "fixture-authorized-nonce");
                    SeedRequest(connection, transaction, sourceSid, pendingRequestId, "PENDING_OPERATOR_APPROVAL", "fixture-pending-nonce");
                    SeedRequest(connection, transaction, sourceSid, consumedRequestId, "COMPLETED", "fixture-consumed-nonce");

                    using (var grants = connection.CreateCommand())
                    {
                        grants.Transaction = transaction;
                        grants.CommandText = """
                            INSERT INTO authorization_grants(grant_id,request_id,operator_sid,key_version,nonce_hash,payload_sha256,mac,status,approved_at_utc,expires_at_utc,consumed_at_utc,revoked_at_utc)
                            VALUES($grant,$request,$sid,1,$nonce,$hash,$mac,$status,$approved,$expires,$consumed,NULL);
                            """;
                        grants.Parameters.AddWithValue("$grant", Guid.NewGuid().ToString("N"));
                        grants.Parameters.AddWithValue("$request", authorizedRequestId);
                        grants.Parameters.AddWithValue("$sid", sourceSid);
                        grants.Parameters.AddWithValue("$nonce", new string('c', 64));
                        grants.Parameters.AddWithValue("$hash", new string('d', 64));
                        grants.Parameters.AddWithValue("$mac", new byte[32]);
                        grants.Parameters.AddWithValue("$status", "APPROVED");
                        grants.Parameters.AddWithValue("$approved", DateTimeOffset.UtcNow.ToString("O"));
                        grants.Parameters.AddWithValue("$expires", DateTimeOffset.UtcNow.AddHours(1).ToString("O"));
                        grants.Parameters.AddWithValue("$consumed", DBNull.Value);
                        grants.ExecuteNonQuery();
                    }
                    using (var grant = connection.CreateCommand())
                    {
                        grant.Transaction = transaction;
                        grant.CommandText = """
                            INSERT INTO authorization_grants(grant_id,request_id,operator_sid,key_version,nonce_hash,payload_sha256,mac,status,approved_at_utc,expires_at_utc,consumed_at_utc,revoked_at_utc)
                            VALUES($grant,$request,$sid,1,$nonce,$hash,$mac,'CONSUMED',$approved,$expires,$consumed,NULL);
                            """;
                        grant.Parameters.AddWithValue("$grant", Guid.NewGuid().ToString("N"));
                        grant.Parameters.AddWithValue("$request", consumedRequestId);
                        grant.Parameters.AddWithValue("$sid", sourceSid);
                        grant.Parameters.AddWithValue("$nonce", new string('e', 64));
                        grant.Parameters.AddWithValue("$hash", new string('f', 64));
                        grant.Parameters.AddWithValue("$mac", new byte[32]);
                        grant.Parameters.AddWithValue("$approved", DateTimeOffset.UtcNow.ToString("O"));
                        grant.Parameters.AddWithValue("$expires", DateTimeOffset.UtcNow.AddHours(1).ToString("O"));
                        grant.Parameters.AddWithValue("$consumed", DateTimeOffset.UtcNow.ToString("O"));
                        grant.ExecuteNonQuery();
                    }

                    string receiptJson = JsonSerializer.Serialize(new
                    {
                        request_id = receiptRequestId,
                        signing_public_key_sha256 = fingerprint,
                        status = "COMMITTED",
                        result_sha256 = new string('1', 64)
                    });
                    byte[] receiptBytes = Encoding.UTF8.GetBytes(receiptJson);
                    byte[] signature = ReceiptSigner.Sign(signing.PrivateKey, receiptBytes);
                    string receiptHash = Convert.ToHexStringLower(SHA256.HashData(receiptBytes));
                    using (var receipt = connection.CreateCommand())
                    {
                        receipt.Transaction = transaction;
                        receipt.CommandText = "INSERT INTO receipts(receipt_id,operation_id,request_id,cycle_id,attempt_id,receipt_json,payload_sha256,signature,signing_key_id,created_at_utc) VALUES($id,$operation,$request,$cycle,$attempt,$json,$hash,$signature,'receipt-ed25519-v1',$created);";
                        receipt.Parameters.AddWithValue("$id", receiptId);
                        receipt.Parameters.AddWithValue("$operation", "ppr-operation-receipt");
                        receipt.Parameters.AddWithValue("$request", receiptRequestId);
                        receipt.Parameters.AddWithValue("$cycle", DBNull.Value);
                        receipt.Parameters.AddWithValue("$attempt", "ppr-attempt");
                        receipt.Parameters.AddWithValue("$json", receiptJson);
                        receipt.Parameters.AddWithValue("$hash", receiptHash);
                        receipt.Parameters.AddWithValue("$signature", signature);
                        receipt.Parameters.AddWithValue("$created", DateTimeOffset.UtcNow.ToString("O"));
                        receipt.ExecuteNonQuery();
                    }

                    using (var backup = connection.CreateCommand())
                    {
                        backup.Transaction = transaction;
                        backup.CommandText = "INSERT INTO backup_points(backup_id,package_path,package_sha256,created_at_utc,tags_json,verification_status) VALUES($id,'C:\\source-host\\backups\\fixture.ocpbak',$hash,$created,'[\"DAILY\"]','VERIFIED');";
                        backup.Parameters.AddWithValue("$id", backupId);
                        backup.Parameters.AddWithValue("$hash", new string('2', 64));
                        backup.Parameters.AddWithValue("$created", DateTimeOffset.UtcNow.ToString("O"));
                        backup.ExecuteNonQuery();
                    }

                    EventChain.Append(connection, transaction, null, null, "PPR_TEST_SOURCE_EVENT", "TEST", "ppr-fixture", new { fixture = true });
                    transaction.Commit();

                    var sourceService = new PortableRecoveryService(sourceStore);
                    string exportedId = sourceService.ExportForTests(packagePath, passphrase);
                    Check(results, "PPR_EXPORT_PACKAGE_CREATED", File.Exists(packagePath) && exportedId.Length == 36);
                    var archive = PprFormat.ReadArchive(packagePath);
                    try
                    {
                        Check(results, "PPR_ARCHIVE_MANIFEST_AND_ARTIFACTS_VALID",
                            archive.Manifest.InstallationId == installationId &&
                            archive.Manifest.SourceOperatorSid == sourceSid &&
                            archive.Manifest.Artifacts.Snapshot.SizeBytes == archive.Snapshot.LongLength &&
                            archive.Manifest.Artifacts.Envelope.SizeBytes == archive.Envelope.LongLength &&
                            archive.Manifest.Artifacts.RecoveryMap.SizeBytes == archive.RecoveryMap.LongLength);

                        byte[] badTag = (byte[])archive.Envelope.Clone();
                        badTag[16] ^= 0x01;
                        bool tagRejected = false;
                        byte[] salt = Convert.FromBase64String(archive.Manifest.Kdf.SaltBase64);
                        byte[] kek = PprFormat.DeriveKey(passphrase, salt);
                        try
                        {
                            try { _ = PprFormat.DecryptFramed(badTag, kek, PprFormat.EnvelopeAad(archive.Manifest.PackageId, installationId), PprFormat.KeyBytes); }
                            catch (CryptographicException) { tagRejected = true; }
                        }
                        finally
                        {
                            CryptographicOperations.ZeroMemory(salt);
                            CryptographicOperations.ZeroMemory(kek);
                            CryptographicOperations.ZeroMemory(badTag);
                        }
                        Check(results, "PPR_AES_GCM_TAMPER_REJECTED", tagRejected);
                    }
                    finally
                    {
                        CryptographicOperations.ZeroMemory(archive.Snapshot);
                        CryptographicOperations.ZeroMemory(archive.Envelope);
                        CryptographicOperations.ZeroMemory(archive.RecoveryMap);
                    }

                    var failedStore = new SqliteStore(failureRoot);
                    failedStore.Initialize();
                    string wrongPhrase = "Wrong-PPR-Phrase-2026!";
                    bool wrongPassphraseRejected = false;
                    try { new PortableRecoveryService(failedStore).RestoreForTests(packagePath, Encoding.UTF8.GetBytes(wrongPhrase), destinationSid); }
                    catch (CryptographicException) { wrongPassphraseRejected = true; }
                    Check(results, "PPR_WRONG_PASSPHRASE_REJECTED", wrongPassphraseRejected);
                    using (var failedDb = failedStore.Open())
                    {
                        var oldInstallation = SqliteStore.GetInstallation(failedDb)!.Value;
                        Check(results, "PPR_WRONG_PASSPHRASE_PRESERVES_DESTINATION",
                            oldInstallation.OperatorSid is null && SqliteStore.ScalarText(failedDb, "SELECT COUNT(*) FROM key_store;") == "0");
                    }

                    var destinationStore = new SqliteStore(destinationRoot);
                    var destinationService = new PortableRecoveryService(destinationStore);
                    destinationService.RestoreForTests(packagePath, passphrase, destinationSid);

                    using (var restored = destinationStore.Open())
                    {
                        var destinationInstallation = SqliteStore.GetInstallation(restored)!.Value;
                        Check(results, "PPR_INSTALLATION_ID_PRESERVED", destinationInstallation.InstallationId == installationId);
                        Check(results, "PPR_OPERATOR_SID_REBOUND", destinationInstallation.OperatorSid == destinationSid);

                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT verification_status FROM backup_points WHERE backup_id=$id;";
                            query.Parameters.AddWithValue("$id", backupId);
                            Check(results, "PPR_BACKUP_POINTS_MARKED_SOURCE_ONLY", Convert.ToString(query.ExecuteScalar()) == "SOURCE_HOST_ONLY");
                        }
                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT status FROM authorization_grants WHERE request_id=$id;";
                            query.Parameters.AddWithValue("$id", authorizedRequestId);
                            Check(results, "PPR_APPROVED_UNCONSUMED_GRANT_REVOKED", Convert.ToString(query.ExecuteScalar()) == "REVOKED");
                        }
                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT status FROM operation_requests WHERE request_id=$id;";
                            query.Parameters.AddWithValue("$id", pendingRequestId);
                            Check(results, "PPR_PENDING_REQUEST_REVOKED", Convert.ToString(query.ExecuteScalar()) == "REVOKED");
                        }
                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT status FROM authorization_grants WHERE request_id=$id;";
                            query.Parameters.AddWithValue("$id", consumedRequestId);
                            Check(results, "PPR_CONSUMED_GRANT_PRESERVED", Convert.ToString(query.ExecuteScalar()) == "CONSUMED");
                        }
                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT purpose,key_version,wrapped_key FROM key_store WHERE purpose='hmac-authority' AND key_version=1;";
                            using var reader = query.ExecuteReader();
                            if (!reader.Read()) throw new InvalidOperationException("PPR_TEST_HMAC_KEY_MISSING_AFTER_RESTORE");
                            byte[] wrapped = (byte[])reader[2];
                            byte[] clear = CryptoBox.UnprotectKey(wrapped,
                                CryptoBox.BuildEntropy(installationId, "hmac-authority", destinationSid, "1"));
                            try { Check(results, "PPR_HMAC_KEY_REWRAPPED", clear.Length == 32); }
                            finally { CryptographicOperations.ZeroMemory(clear); }
                        }
                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT wrapped_key FROM key_store WHERE purpose='receipt-ed25519' AND key_version=1;";
                            byte[] wrapped = (byte[])query.ExecuteScalar()!;
                            byte[] clear = CryptoBox.UnprotectKey(wrapped,
                                CryptoBox.BuildEntropy(installationId, "receipt-ed25519", destinationSid, "1"));
                            try { Check(results, "PPR_ED25519_PRIVATE_KEY_REWRAPPED", clear.Length == 32); }
                            finally { CryptographicOperations.ZeroMemory(clear); }
                        }

                        byte[] publicKey;
                        string publicFingerprint;
                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT public_key,fingerprint_sha256 FROM key_metadata WHERE key_id='receipt-ed25519-v1';";
                            using var reader = query.ExecuteReader();
                            if (!reader.Read()) throw new InvalidOperationException("PPR_TEST_PUBLIC_KEY_MISSING");
                            publicKey = (byte[])reader[0];
                            publicFingerprint = reader.GetString(1);
                        }
                        string restoredReceiptJson;
                        byte[] receiptSignature;
                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT receipt_json,signature FROM receipts WHERE receipt_id=$id;";
                            query.Parameters.AddWithValue("$id", receiptId);
                            using var reader = query.ExecuteReader();
                            if (!reader.Read()) throw new InvalidOperationException("PPR_TEST_RECEIPT_MISSING");
                            restoredReceiptJson = reader.GetString(0);
                            receiptSignature = (byte[])reader[1];
                        }
                        byte[] restoredReceiptBytes = Encoding.UTF8.GetBytes(restoredReceiptJson);
                        try
                        {
                            using var receipt = JsonDocument.Parse(restoredReceiptBytes);
                            Check(results, "PPR_RECEIPT_HISTORY_SIGNATURE_PRESERVED",
                                receipt.RootElement.GetProperty("signing_public_key_sha256").GetString() == publicFingerprint &&
                                ReceiptSigner.Verify(publicKey, restoredReceiptBytes, receiptSignature));
                        }
                        finally
                        {
                            CryptographicOperations.ZeroMemory(publicKey);
                            CryptographicOperations.ZeroMemory(restoredReceiptBytes);
                        }

                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT content_ciphertext,content_nonce,authentication_tag,wrapped_dek,dek_id,content_sha256,crypto_version,key_version,aad_version FROM canonical_sources WHERE source_id=$id;";
                            query.Parameters.AddWithValue("$id", sourceId);
                            using var reader = query.ExecuteReader();
                            if (!reader.Read()) throw new InvalidOperationException("PPR_TEST_CANONICAL_SOURCE_MISSING");
                            var encrypted = new EncryptedValue((byte[])reader[0], (byte[])reader[1], (byte[])reader[2],
                                (byte[])reader[3], reader.GetString(4), reader.GetString(5), reader.GetInt32(6), reader.GetInt32(7), reader.GetInt32(8));
                            byte[] plain = CryptoBox.Decrypt(encrypted, installationId, "canonical-source", sourceId);
                            try { Check(results, "PPR_CANONICAL_SOURCE_DEK_READABLE", Encoding.UTF8.GetString(plain) == sourceText); }
                            finally { CryptographicOperations.ZeroMemory(plain); }
                        }

                        using (var query = restored.CreateCommand())
                        {
                            query.CommandText = "SELECT content_ciphertext,content_nonce,authentication_tag,wrapped_dek,dek_id,content_sha256,crypto_version,key_version,aad_version FROM snapshots WHERE snapshot_id=$id;";
                            query.Parameters.AddWithValue("$id", snapshotId);
                            using var reader = query.ExecuteReader();
                            if (!reader.Read()) throw new InvalidOperationException("PPR_TEST_SNAPSHOT_MISSING");
                            var encrypted = new EncryptedValue((byte[])reader[0], (byte[])reader[1], (byte[])reader[2],
                                (byte[])reader[3], reader.GetString(4), reader.GetString(5), reader.GetInt32(6), reader.GetInt32(7), reader.GetInt32(8));
                            byte[] plain = CryptoBox.Decrypt(encrypted, installationId, "snapshot", snapshotId);
                            try { Check(results, "PPR_SNAPSHOT_DEK_READABLE", Encoding.UTF8.GetString(plain) == snapshotText); }
                            finally { CryptographicOperations.ZeroMemory(plain); }
                        }

                        var chain = EventChain.VerifyAll(restored);
                        Check(results, "PPR_EVENT_CHAIN_PRESERVED_AND_EXTENDED", chain.Valid && chain.VerifiedThrough >= 2);
                        Check(results, "PPR_DATABASE_INTEGRITY_AFTER_RESTORE",
                            SqliteStore.ScalarText(restored, "PRAGMA integrity_check;") == "ok");
                    }
                }
                finally
                {
                    CryptographicOperations.ZeroMemory(hmacActive);
                    CryptographicOperations.ZeroMemory(hmacRetired);
                    CryptographicOperations.ZeroMemory(signing.PrivateKey);
                }
            }

            bool invalidManifestRejected = false;
            var invalidArchive = PprFormat.ReadArchive(packagePath);
            try
            {
                invalidArchive.Manifest.Kdf.MemoryKib = 1024;
                try { PprFormat.ValidateManifest(invalidArchive.Manifest); }
                catch (InvalidDataException) { invalidManifestRejected = true; }
            }
            finally
            {
                CryptographicOperations.ZeroMemory(invalidArchive.Snapshot);
                CryptographicOperations.ZeroMemory(invalidArchive.Envelope);
                CryptographicOperations.ZeroMemory(invalidArchive.RecoveryMap);
            }
            Check(results, "PPR_UNAPPROVED_KDF_PARAMETERS_REJECTED", invalidManifestRejected);
        }
        catch (Exception ex)
        {
            results.Add(("PPR_FIXTURE_EXCEPTION_" + ex.GetType().Name + "_" + ex.Message, false));
        }
        finally
        {
            CryptographicOperations.ZeroMemory(passphrase);
            try { if (Directory.Exists(root)) Directory.Delete(root, true); } catch { }
        }

        return results;
    }

    private static void SeedRequest(SqliteConnection connection, SqliteTransaction transaction,
        string sid, string requestId, string status, string nonce)
    {
        string now = DateTimeOffset.UtcNow.ToString("O");
        string payload = JsonSerializer.Serialize(new { operator_sid = sid, key_version = 1, nonce });
        string payloadHash = Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(payload)));
        using var command = connection.CreateCommand();
        command.Transaction = transaction;
        command.CommandText = """
            INSERT INTO operation_requests(request_id,operation_id,attempt_id,operation_type,target_type,target_id,cycle_id,parameters_json,payload_json,payload_sha256,expected_state,requested_effect,status,created_at_utc,expires_at_utc)
            VALUES($request,$operation,$attempt,'OPEN_CYCLE','cycle','ppr-fixture',NULL,'{}',$payload,$hash,'NONE','PPR test fixture',$status,$created,$expires);
            """;
        command.Parameters.AddWithValue("$request", requestId);
        command.Parameters.AddWithValue("$operation", Guid.NewGuid().ToString("N"));
        command.Parameters.AddWithValue("$attempt", Guid.NewGuid().ToString("N"));
        command.Parameters.AddWithValue("$payload", payload);
        command.Parameters.AddWithValue("$hash", payloadHash);
        command.Parameters.AddWithValue("$status", status);
        command.Parameters.AddWithValue("$created", now);
        command.Parameters.AddWithValue("$expires", DateTimeOffset.UtcNow.AddHours(1).ToString("O"));
        command.ExecuteNonQuery();
    }

    private static void Check(List<(string Name, bool Passed)> results, string name, bool passed) =>
        results.Add((name, passed));
}
