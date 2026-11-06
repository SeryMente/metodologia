using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.Crypto.Parameters;
using System.Globalization;
using System.IO.Compression;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace OcpMcp.Services;

internal sealed class PprArchive
{
    public required PprManifest Manifest { get; init; }
    public required byte[] Snapshot { get; init; }
    public required byte[] Envelope { get; init; }
    public required byte[] RecoveryMap { get; init; }
}

internal sealed class PprManifest
{
    public string Format { get; set; } = PprFormat.FormatName;
    public int FormatVersion { get; set; } = 1;
    public string PackageId { get; set; } = "";
    public string CreatedAtUtc { get; set; } = "";
    public string InstallationId { get; set; } = "";
    public string SourceOperatorSid { get; set; } = "";
    public int SchemaVersion { get; set; }
    public string AppVersion { get; set; } = "0.1.0";
    public string DatabaseSha256 { get; set; } = "";
    public PprKdf Kdf { get; set; } = new();
    public PprAead Aead { get; set; } = new();
    public PprArtifacts Artifacts { get; set; } = new();
}

internal sealed class PprKdf
{
    public string Algorithm { get; set; } = "Argon2id";
    public int Version { get; set; } = 19;
    public string SaltBase64 { get; set; } = "";
    public int MemoryKib { get; set; } = 65536;
    public int Iterations { get; set; } = 3;
    public int Parallelism { get; set; } = 1;
    public int OutputBytes { get; set; } = 32;
}

internal sealed class PprAead
{
    public string Algorithm { get; set; } = "AES-256-GCM";
    public int KeyBytes { get; set; } = 32;
    public int NonceBytes { get; set; } = 12;
    public int TagBytes { get; set; } = 16;
    public string FramingMagic { get; set; } = "PPR1";
}

internal sealed class PprArtifacts
{
    [JsonPropertyName("snapshot.sqlite.enc")]
    public PprArtifact Snapshot { get; set; } = new();

    [JsonPropertyName("recovery-envelope.bin")]
    public PprArtifact Envelope { get; set; } = new();

    [JsonPropertyName("recovery-map.enc")]
    public PprArtifact RecoveryMap { get; set; } = new();
}

internal sealed class PprArtifact
{
    public long SizeBytes { get; set; }
    public string Sha256 { get; set; } = "";
}

internal static class PprFormat
{
    public const string FormatName = "OCPMCP-PORTABLE-RECOVERY";
    public const int KeyBytes = 32;
    public const int SaltBytes = 16;
    public const int NonceBytes = 12;
    public const int TagBytes = 16;
    public const int FrameHeaderBytes = 4 + NonceBytes + TagBytes;
    public const int MaxManifestBytes = 64 * 1024;
    public const long MaxArtifactBytes = 1_610_612_736L;
    private const long MaxPackageBytes = (MaxArtifactBytes * 3) + MaxManifestBytes + (1024 * 1024);
    private static readonly byte[] Magic = Encoding.ASCII.GetBytes("PPR1");
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower,
        PropertyNameCaseInsensitive = false,
        WriteIndented = true,
        MaxDepth = 32
    };

    public static string Sha256(byte[] bytes) =>
        Convert.ToHexStringLower(SHA256.HashData(bytes));

    public static PprArtifact DescribeArtifact(byte[] bytes) => new()
    {
        SizeBytes = bytes.LongLength,
        Sha256 = Sha256(bytes)
    };

    public static byte[] DeriveKey(byte[] passphraseUtf8, byte[] salt)
    {
        if (passphraseUtf8 is null || passphraseUtf8.Length < 16)
            throw new ArgumentException("PPR_PASSPHRASE_TOO_SHORT");
        if (salt is null || salt.Length != SaltBytes)
            throw new InvalidDataException("PPR_KDF_SALT_INVALID");

        var parameters = new Argon2Parameters.Builder(Argon2Parameters.Argon2id)
            .WithVersion(Argon2Parameters.Version13)
            .WithIterations(3)
            .WithMemoryAsKB(65536)
            .WithParallelism(1)
            .WithSalt(salt)
            .Build();

        var generator = new Argon2BytesGenerator();
        byte[] key = new byte[KeyBytes];
        try
        {
            generator.Init(parameters);
            generator.GenerateBytes(passphraseUtf8, key);
            return key;
        }
        catch
        {
            CryptographicOperations.ZeroMemory(key);
            throw;
        }
        finally
        {
            parameters.Clear();
        }
    }

    public static byte[] EncryptFramed(byte[] plaintext, byte[] key, byte[] aad)
    {
        if (key is null || key.Length != KeyBytes) throw new ArgumentException("PPR_AEAD_KEY_INVALID");
        byte[] nonce = RandomNumberGenerator.GetBytes(NonceBytes);
        byte[] tag = new byte[TagBytes];
        byte[] ciphertext = new byte[plaintext.Length];
        using (var aes = new AesGcm(key, TagBytes))
            aes.Encrypt(nonce, plaintext, ciphertext, tag, aad);

        byte[] framed = new byte[FrameHeaderBytes + ciphertext.Length];
        Magic.CopyTo(framed, 0);
        nonce.CopyTo(framed, 4);
        tag.CopyTo(framed, 4 + NonceBytes);
        ciphertext.CopyTo(framed, FrameHeaderBytes);
        CryptographicOperations.ZeroMemory(ciphertext);
        CryptographicOperations.ZeroMemory(nonce);
        CryptographicOperations.ZeroMemory(tag);
        return framed;
    }

    public static byte[] DecryptFramed(byte[] framed, byte[] key, byte[] aad, int? expectedPlaintextLength = null)
    {
        if (key is null || key.Length != KeyBytes) throw new ArgumentException("PPR_AEAD_KEY_INVALID");
        if (framed is null || framed.Length < FrameHeaderBytes + 1)
            throw new InvalidDataException("PPR_FRAME_TRUNCATED");
        if (!CryptographicOperations.FixedTimeEquals(framed.AsSpan(0, 4), Magic))
            throw new InvalidDataException("PPR_FRAME_MAGIC_INVALID");

        int ciphertextLength = framed.Length - FrameHeaderBytes;
        if (expectedPlaintextLength.HasValue && ciphertextLength != expectedPlaintextLength.Value)
            throw new InvalidDataException("PPR_FRAME_LENGTH_INVALID");

        byte[] nonce = framed.AsSpan(4, NonceBytes).ToArray();
        byte[] tag = framed.AsSpan(4 + NonceBytes, TagBytes).ToArray();
        byte[] ciphertext = framed.AsSpan(FrameHeaderBytes).ToArray();
        byte[] plaintext = new byte[ciphertextLength];
        try
        {
            using var aes = new AesGcm(key, TagBytes);
            aes.Decrypt(nonce, ciphertext, tag, plaintext, aad);
            return plaintext;
        }
        catch
        {
            CryptographicOperations.ZeroMemory(plaintext);
            throw;
        }
        finally
        {
            CryptographicOperations.ZeroMemory(nonce);
            CryptographicOperations.ZeroMemory(tag);
            CryptographicOperations.ZeroMemory(ciphertext);
        }
    }

    public static byte[] EnvelopeAad(string packageId, string installationId) =>
        Encoding.UTF8.GetBytes($"OCPMCP|PPR|ENVELOPE|v1|{packageId}|{installationId}");

    public static byte[] SnapshotAad(string packageId, string installationId, string databaseSha256) =>
        Encoding.UTF8.GetBytes($"OCPMCP|PPR|SNAPSHOT|v1|{packageId}|{installationId}|{databaseSha256}");

    public static byte[] RecoveryMapAad(string packageId, string installationId, string databaseSha256) =>
        Encoding.UTF8.GetBytes($"OCPMCP|PPR|KEYMAP|v1|{packageId}|{installationId}|{databaseSha256}");

    public static void ValidateManifest(PprManifest manifest)
    {
        ArgumentNullException.ThrowIfNull(manifest);
        if (manifest.Format != FormatName || manifest.FormatVersion != 1)
            throw new InvalidDataException("PPR_MANIFEST_FORMAT_UNSUPPORTED");
        if (!Guid.TryParseExact(manifest.PackageId, "D", out _))
            throw new InvalidDataException("PPR_MANIFEST_PACKAGE_ID_INVALID");
        if (!DateTimeOffset.TryParse(manifest.CreatedAtUtc, CultureInfo.InvariantCulture,
                DateTimeStyles.RoundtripKind, out _))
            throw new InvalidDataException("PPR_MANIFEST_DATE_INVALID");
        if (string.IsNullOrWhiteSpace(manifest.InstallationId) || manifest.InstallationId.Length > 128)
            throw new InvalidDataException("PPR_MANIFEST_INSTALLATION_ID_INVALID");
        if (string.IsNullOrWhiteSpace(manifest.SourceOperatorSid) ||
            manifest.SourceOperatorSid.Length > 184 ||
            !manifest.SourceOperatorSid.StartsWith("S-", StringComparison.Ordinal))
            throw new InvalidDataException("PPR_MANIFEST_SOURCE_SID_INVALID");
        if (manifest.SchemaVersion < 1 || manifest.SchemaVersion > 1000)
            throw new InvalidDataException("PPR_MANIFEST_SCHEMA_VERSION_INVALID");
        if (string.IsNullOrWhiteSpace(manifest.AppVersion) || manifest.AppVersion.Length > 64)
            throw new InvalidDataException("PPR_MANIFEST_APP_VERSION_INVALID");
        if (!IsSha256(manifest.DatabaseSha256))
            throw new InvalidDataException("PPR_MANIFEST_DATABASE_HASH_INVALID");

        if (manifest.Kdf is null || manifest.Kdf.Algorithm != "Argon2id" ||
            manifest.Kdf.Version != 19 || manifest.Kdf.MemoryKib != 65536 ||
            manifest.Kdf.Iterations != 3 || manifest.Kdf.Parallelism != 1 ||
            manifest.Kdf.OutputBytes != KeyBytes)
            throw new InvalidDataException("PPR_MANIFEST_KDF_UNSUPPORTED");
        byte[] salt;
        try { salt = Convert.FromBase64String(manifest.Kdf.SaltBase64); }
        catch (FormatException ex) { throw new InvalidDataException("PPR_MANIFEST_KDF_SALT_INVALID", ex); }
        try
        {
            if (salt.Length != SaltBytes) throw new InvalidDataException("PPR_MANIFEST_KDF_SALT_INVALID");
        }
        finally { CryptographicOperations.ZeroMemory(salt); }

        if (manifest.Aead is null || manifest.Aead.Algorithm != "AES-256-GCM" ||
            manifest.Aead.KeyBytes != KeyBytes || manifest.Aead.NonceBytes != NonceBytes ||
            manifest.Aead.TagBytes != TagBytes || manifest.Aead.FramingMagic != "PPR1")
            throw new InvalidDataException("PPR_MANIFEST_AEAD_UNSUPPORTED");

        if (manifest.Artifacts is null) throw new InvalidDataException("PPR_MANIFEST_ARTIFACTS_MISSING");
        ValidateArtifact(manifest.Artifacts.Snapshot, "snapshot");
        ValidateArtifact(manifest.Artifacts.Envelope, "envelope");
        ValidateArtifact(manifest.Artifacts.RecoveryMap, "recovery-map");
        if (manifest.Artifacts.Envelope.SizeBytes != FrameHeaderBytes + KeyBytes)
            throw new InvalidDataException("PPR_MANIFEST_ENVELOPE_SIZE_INVALID");
    }

    public static void WriteArchive(string path, PprManifest manifest, byte[] snapshot, byte[] envelope, byte[] recoveryMap)
    {
        ValidateManifest(manifest);
        VerifyArtifact(manifest.Artifacts.Snapshot, snapshot, "snapshot");
        VerifyArtifact(manifest.Artifacts.Envelope, envelope, "envelope");
        VerifyArtifact(manifest.Artifacts.RecoveryMap, recoveryMap, "recovery-map");

        byte[] manifestBytes = JsonSerializer.SerializeToUtf8Bytes(manifest, JsonOptions);
        if (manifestBytes.Length > MaxManifestBytes) throw new InvalidDataException("PPR_MANIFEST_TOO_LARGE");
        try
        {
            using var stream = new FileStream(path, FileMode.CreateNew, FileAccess.ReadWrite, FileShare.None,
                1024 * 64, FileOptions.WriteThrough);
            using (var zip = new ZipArchive(stream, ZipArchiveMode.Create, true, Encoding.UTF8))
            {
                WriteEntry(zip, "manifest.json", manifestBytes);
                WriteEntry(zip, "snapshot.sqlite.enc", snapshot);
                WriteEntry(zip, "recovery-envelope.bin", envelope);
                WriteEntry(zip, "recovery-map.enc", recoveryMap);
            }
            stream.Flush(true);
        }
        finally { CryptographicOperations.ZeroMemory(manifestBytes); }
    }

    public static PprArchive ReadArchive(string path)
    {
        var info = new FileInfo(path);
        if (!info.Exists) throw new FileNotFoundException("PPR_PACKAGE_NOT_FOUND", path);
        if (info.Length < 256 || info.Length > MaxPackageBytes)
            throw new InvalidDataException("PPR_PACKAGE_SIZE_INVALID");

        using var stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read, 1024 * 64, FileOptions.SequentialScan);
        using var zip = new ZipArchive(stream, ZipArchiveMode.Read, false, Encoding.UTF8);
        if (zip.Entries.Count != 4) throw new InvalidDataException("PPR_ARCHIVE_ENTRY_COUNT_INVALID");

        var expectedNames = new HashSet<string>(StringComparer.Ordinal)
        {
            "manifest.json", "snapshot.sqlite.enc", "recovery-envelope.bin", "recovery-map.enc"
        };
        var entries = new Dictionary<string, ZipArchiveEntry>(StringComparer.Ordinal);
        foreach (var entry in zip.Entries)
        {
            string name = entry.FullName;
            if (string.IsNullOrWhiteSpace(name) || name.Contains('/') || name.Contains('\\') ||
                name.Contains("..", StringComparison.Ordinal) || Path.IsPathRooted(name) ||
                entry.Name != name || entry.Name.EndsWith("/", StringComparison.Ordinal))
                throw new InvalidDataException("PPR_ARCHIVE_PATH_INVALID");
            if (!expectedNames.Contains(name) || !entries.TryAdd(name, entry))
                throw new InvalidDataException("PPR_ARCHIVE_ENTRY_UNEXPECTED_OR_DUPLICATE");
            if (entry.CompressedLength != entry.Length)
                throw new InvalidDataException("PPR_ARCHIVE_COMPRESSION_NOT_ALLOWED");
        }
        if (!entries.Keys.ToHashSet(StringComparer.Ordinal).SetEquals(expectedNames))
            throw new InvalidDataException("PPR_ARCHIVE_ENTRY_MISSING");

        byte[] manifestBytes = ReadEntry(entries["manifest.json"], MaxManifestBytes);
        PprManifest manifest;
        try
        {
            manifest = JsonSerializer.Deserialize<PprManifest>(manifestBytes, JsonOptions)
                ?? throw new InvalidDataException("PPR_MANIFEST_INVALID");
        }
        finally { CryptographicOperations.ZeroMemory(manifestBytes); }
        ValidateManifest(manifest);

        byte[] snapshot = [];
        byte[] envelope = [];
        byte[] recoveryMap = [];
        try
        {
            snapshot = ReadEntry(entries["snapshot.sqlite.enc"], MaxArtifactBytes);
            envelope = ReadEntry(entries["recovery-envelope.bin"], MaxArtifactBytes);
            recoveryMap = ReadEntry(entries["recovery-map.enc"], MaxArtifactBytes);
            VerifyArtifact(manifest.Artifacts.Snapshot, snapshot, "snapshot");
            VerifyArtifact(manifest.Artifacts.Envelope, envelope, "envelope");
            VerifyArtifact(manifest.Artifacts.RecoveryMap, recoveryMap, "recovery-map");
            return new PprArchive { Manifest = manifest, Snapshot = snapshot, Envelope = envelope, RecoveryMap = recoveryMap };
        }
        catch
        {
            Zero(snapshot, envelope, recoveryMap);
            throw;
        }
    }

    public static void RequireInteractiveConsole()
    {
        if (Console.IsInputRedirected || Console.IsOutputRedirected)
            throw new UnauthorizedAccessException("INTERACTIVE_OPERATOR_CONSOLE_REQUIRED");
    }

    public static byte[] ReadPassphraseTwice()
    {
        char[] first = ReadHidden("Recovery phrase (mínimo 16 caracteres): ");
        try
        {
            if (first.Length < 16) throw new ArgumentException("PPR_PASSPHRASE_TOO_SHORT");
            char[] second = ReadHidden("Repita la recovery phrase: ");
            try
            {
                if (!first.AsSpan().SequenceEqual(second))
                    throw new CryptographicException("PPR_PASSPHRASE_CONFIRMATION_MISMATCH");
                return EncodePassphrase(first);
            }
            finally { Array.Clear(second, 0, second.Length); }
        }
        finally { Array.Clear(first, 0, first.Length); }
    }

    public static byte[] ReadPassphraseOnce(string prompt)
    {
        char[] chars = ReadHidden(prompt);
        try
        {
            if (chars.Length < 16) throw new ArgumentException("PPR_PASSPHRASE_TOO_SHORT");
            return EncodePassphrase(chars);
        }
        finally { Array.Clear(chars, 0, chars.Length); }
    }

    private static byte[] EncodePassphrase(char[] chars)
    {
        byte[] bytes = new byte[Encoding.UTF8.GetByteCount(chars)];
        Encoding.UTF8.GetBytes(chars.AsSpan(), bytes.AsSpan());
        return bytes;
    }

    private static char[] ReadHidden(string prompt)
    {
        Console.Write(prompt);
        char[] buffer = new char[1024];
        int length = 0;
        try
        {
            while (true)
            {
                ConsoleKeyInfo key = Console.ReadKey(intercept: true);
                if (key.Key == ConsoleKey.Enter)
                {
                    Console.WriteLine();
                    char[] result = buffer.AsSpan(0, length).ToArray();
                    return result;
                }
                if (key.Key == ConsoleKey.Backspace)
                {
                    if (length > 0)
                    {
                        buffer[--length] = '\0';
                    }
                    continue;
                }
                if (char.IsControl(key.KeyChar)) continue;
                if (length >= buffer.Length) throw new ArgumentException("PPR_PASSPHRASE_TOO_LONG");
                buffer[length++] = key.KeyChar;
            }
        }
        finally
        {
            Array.Clear(buffer, 0, buffer.Length);
        }
    }

    private static void WriteEntry(ZipArchive archive, string name, byte[] bytes)
    {
        var entry = archive.CreateEntry(name, CompressionLevel.NoCompression);
        using var output = entry.Open();
        output.Write(bytes, 0, bytes.Length);
    }

    private static byte[] ReadEntry(ZipArchiveEntry entry, long maxBytes)
    {
        if (entry.Length < 1 || entry.Length > maxBytes)
            throw new InvalidDataException("PPR_ARCHIVE_ENTRY_SIZE_INVALID");
        byte[] bytes = new byte[checked((int)entry.Length)];
        using var input = entry.Open();
        int offset = 0;
        while (offset < bytes.Length)
        {
            int read = input.Read(bytes, offset, bytes.Length - offset);
            if (read == 0) throw new InvalidDataException("PPR_ARCHIVE_ENTRY_TRUNCATED");
            offset += read;
        }
        if (input.ReadByte() != -1) throw new InvalidDataException("PPR_ARCHIVE_ENTRY_LENGTH_MISMATCH");
        return bytes;
    }

    private static void VerifyArtifact(PprArtifact expected, byte[] actual, string name)
    {
        if (expected.SizeBytes != actual.LongLength)
            throw new InvalidDataException($"PPR_ARTIFACT_SIZE_MISMATCH:{name}");
        string hash = Sha256(actual);
        if (!CryptographicOperations.FixedTimeEquals(
                Convert.FromHexString(expected.Sha256), Convert.FromHexString(hash)))
            throw new CryptographicException($"PPR_ARTIFACT_HASH_MISMATCH:{name}");
    }

    private static void ValidateArtifact(PprArtifact artifact, string name)
    {
        if (artifact is null || artifact.SizeBytes < FrameHeaderBytes + 1 ||
            artifact.SizeBytes > MaxArtifactBytes || !IsSha256(artifact.Sha256))
            throw new InvalidDataException($"PPR_MANIFEST_ARTIFACT_INVALID:{name}");
    }

    private static bool IsSha256(string value) =>
        value is { Length: 64 } && value.All(c =>
            (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f'));

    private static void Zero(params byte[][] arrays)
    {
        foreach (byte[] array in arrays)
            if (array is { Length: > 0 }) CryptographicOperations.ZeroMemory(array);
    }
}
