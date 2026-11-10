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
        "17a4da1d3906e2397ab4682ff46cc9a9f116f34d",
        "gobernanza/METAPROMPT-CANONICO-SAMANTHA.html",
        "c8d37d92aed7ff9d4fe94e7a9541e76ba5c88a2c",
        "v387",
        "NX-387m",
        "C-GOBERNANZA-IPZ-DIRECTORIO-CNP-20261110-01",
        "1.29",
        "2.18");
}
