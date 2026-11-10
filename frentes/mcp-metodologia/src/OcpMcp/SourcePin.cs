namespace OcpMcp;

public sealed record SourcePin(
    string Repository,
    string RefName,
    string CommitId,
    string CanonicalPath,
    string GitBlobSha,
    string DugVersion,
    string DugSignature,
    string DugEvent,
    string MetacanonVersion,
    string GowVersion)
{
    public static SourcePin Current { get; } = new(
        "SeryMente/metodologia",
        "main",
        "3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c",
        "gobernanza/METAPROMPT-CANONICO-SAMANTHA.html",
        "4db0ebadfd1e48b2bdec9236ba7f344921e4a865",
        "v388",
        "NX-388m",
        "C-GOBERNANZA-ART027-SINK-LOCAL-RECONCILIACION-20261110-01",
        "1.29",
        "2.18");
}
