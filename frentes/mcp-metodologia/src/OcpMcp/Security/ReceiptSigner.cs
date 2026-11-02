using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Crypto.Signers;
using Org.BouncyCastle.Security;

namespace OcpMcp.Security;

public sealed record Ed25519Material(byte[] PrivateKey, byte[] PublicKey);

public static class ReceiptSigner
{
    public static Ed25519Material Generate()
    {
        var generator = new Ed25519KeyPairGenerator();
        generator.Init(new Ed25519KeyGenerationParameters(new SecureRandom()));
        AsymmetricCipherKeyPair pair = generator.GenerateKeyPair();
        return new Ed25519Material(
            ((Ed25519PrivateKeyParameters)pair.Private).GetEncoded(),
            ((Ed25519PublicKeyParameters)pair.Public).GetEncoded());
    }

    public static byte[] Sign(byte[] privateKey, byte[] data)
    {
        var signer = new Ed25519Signer();
        signer.Init(true, new Ed25519PrivateKeyParameters(privateKey, 0));
        signer.BlockUpdate(data, 0, data.Length);
        return signer.GenerateSignature();
    }

    public static bool Verify(byte[] publicKey, byte[] data, byte[] signature)
    {
        var signer = new Ed25519Signer();
        signer.Init(false, new Ed25519PublicKeyParameters(publicKey, 0));
        signer.BlockUpdate(data, 0, data.Length);
        return signer.VerifySignature(signature);
    }
}
