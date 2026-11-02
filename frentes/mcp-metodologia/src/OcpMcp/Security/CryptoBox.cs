using System.Security.Cryptography;
using System.Text;

namespace OcpMcp.Security;

public sealed record EncryptedValue(byte[] Ciphertext, byte[] Nonce, byte[] Tag, byte[] WrappedDek, string DekId, string ContentSha256, int CryptoVersion = 1, int KeyVersion = 1, int AadVersion = 1);

public static class CryptoBox
{
    public static byte[] ProtectKey(byte[] key, byte[] entropy) =>
        ProtectedData.Protect(key, entropy, DataProtectionScope.CurrentUser);

    public static byte[] UnprotectKey(byte[] wrapped, byte[] entropy) =>
        ProtectedData.Unprotect(wrapped, entropy, DataProtectionScope.CurrentUser);

    public static EncryptedValue Encrypt(byte[] plaintext, string installationId, string objectType, string objectId, int contentVersion = 1, int keyVersion = 1)
    {
        byte[] dek = RandomNumberGenerator.GetBytes(32);
        byte[] nonce = RandomNumberGenerator.GetBytes(12);
        byte[] ciphertext = new byte[plaintext.Length];
        byte[] tag = new byte[16];
        string hash = Convert.ToHexStringLower(SHA256.HashData(plaintext));
        string dekId = Guid.NewGuid().ToString("N");
        byte[] aad = BuildAad(installationId, objectType, objectId, contentVersion, hash, dekId, 1, 1);
        try
        {
            using var aes = new AesGcm(dek, 16);
            aes.Encrypt(nonce, plaintext, ciphertext, tag, aad);
            byte[] entropy = BuildEntropy(installationId, objectType, objectId, dekId);
            byte[] wrapped = ProtectKey(dek, entropy);
            return new EncryptedValue(ciphertext, nonce, tag, wrapped, dekId, hash);
        }
        finally
        {
            CryptographicOperations.ZeroMemory(dek);
        }
    }

    public static byte[] Decrypt(EncryptedValue encrypted, string installationId, string objectType, string objectId, int contentVersion = 1)
    {
        byte[] entropy = BuildEntropy(installationId, objectType, objectId, encrypted.DekId);
        byte[] dek = UnprotectKey(encrypted.WrappedDek, entropy);
        byte[] plaintext = new byte[encrypted.Ciphertext.Length];
        byte[] aad = BuildAad(installationId, objectType, objectId, contentVersion, encrypted.ContentSha256, encrypted.DekId, encrypted.CryptoVersion, encrypted.AadVersion);
        try
        {
            using var aes = new AesGcm(dek, 16);
            aes.Decrypt(encrypted.Nonce, encrypted.Ciphertext, encrypted.Tag, plaintext, aad);
            string actual = Convert.ToHexStringLower(SHA256.HashData(plaintext));
            if (!CryptographicOperations.FixedTimeEquals(Convert.FromHexString(actual), Convert.FromHexString(encrypted.ContentSha256)))
                throw new CryptographicException("CONTENT_SHA256_MISMATCH");
            return plaintext;
        }
        catch
        {
            CryptographicOperations.ZeroMemory(plaintext);
            throw;
        }
        finally
        {
            CryptographicOperations.ZeroMemory(dek);
        }
    }

    public static byte[] BuildEntropy(string installationId, string objectType, string objectId, string dekId) =>
        SHA256.HashData(Encoding.UTF8.GetBytes($"OCPMCP|DPAPI|v1|{installationId}|{objectType}|{objectId}|{dekId}"));

    public static byte[] BuildAad(string installationId, string objectType, string objectId, int version, string hash, string dekId, int cryptoVersion, int aadVersion) =>
        Encoding.UTF8.GetBytes($"OCPMCP|AES-256-GCM|{aadVersion}|{installationId}|{objectType}|{objectId}|{version}|{hash}|{dekId}|{cryptoVersion}");

    public static byte[] Hmac(byte[] key, byte[] canonicalPayload) =>
        HMACSHA256.HashData(key, canonicalPayload);

    public static bool FixedEquals(byte[] a, byte[] b) =>
        a.Length == b.Length && CryptographicOperations.FixedTimeEquals(a, b);
}
