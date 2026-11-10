using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

namespace OcpMcp;

public interface IPrincipleSource
{
    SinkP004Result ReadP004();
}

public sealed record SinkP004Result(
    string PrincipleId, string Title, string NormativeText, string ContentMarkdown,
    string HumanAnchor, string Microdescriptor, string PreponderanceCategory,
    double PreponderanceDecimal, string Repository, string RefName, string CommitId,
    string CanonicalPath, string GitBlobSha, string SourceSha256,
    string PrincipleTextSha256, string DugVersion, string DugSignature,
    string DugEvent, string MetacanonVersion, string GowVersion,
    string GowArrId, string GowArrTitle, string GowArrContentMarkdown, string McpNormativeStatus);

public sealed class DugSourceReader : IPrincipleSource
{
    private const string GovDataOpen = "<script id=\"gov-data\" type=\"application/json\">";
    private readonly string _repoRoot;
    private readonly SourcePin _pin;

    public DugSourceReader(string repoRoot, SourcePin? pin = null)
    {
        _repoRoot = Path.GetFullPath(repoRoot);
        _pin = pin ?? SourcePin.Current;
    }

    public SinkP004Result ReadP004()
    {
        string sourcePath = Path.GetFullPath(Path.Combine(_repoRoot, _pin.CanonicalPath));
        string rootPrefix = _repoRoot.EndsWith(Path.DirectorySeparatorChar)
            ? _repoRoot : _repoRoot + Path.DirectorySeparatorChar;
        if (!sourcePath.StartsWith(rootPrefix, StringComparison.OrdinalIgnoreCase))
            throw new InvalidDataException("SOURCE_PATH_OUTSIDE_REPOSITORY");
        if (!File.Exists(sourcePath))
            throw new FileNotFoundException("PINNED_DUG_SOURCE_NOT_FOUND", sourcePath);

        byte[] bytes = File.ReadAllBytes(sourcePath);
        string gitBlobSha = ComputeGitBlobSha(bytes);
        if (!FixedEquals(gitBlobSha, _pin.GitBlobSha))
            throw new CryptographicException("DUG_GIT_BLOB_PIN_MISMATCH");

        string html;
        try { html = new UTF8Encoding(false, true).GetString(bytes); }
        catch (DecoderFallbackException) { throw new InvalidDataException("DUG_SOURCE_NOT_UTF8"); }

        int open = html.IndexOf(GovDataOpen, StringComparison.Ordinal);
        if (open < 0 || html.IndexOf(GovDataOpen, open + GovDataOpen.Length, StringComparison.Ordinal) >= 0)
            throw new InvalidDataException("DUG_GOV_DATA_BLOCK_MISSING_OR_AMBIGUOUS");
        int jsonStart = open + GovDataOpen.Length;
        int close = html.IndexOf("</script>", jsonStart, StringComparison.Ordinal);
        if (close < 0) throw new InvalidDataException("DUG_GOV_DATA_BLOCK_UNTERMINATED");

        using JsonDocument dug = JsonDocument.Parse(html[jsonStart..close]);
        JsonElement root = dug.RootElement;
        JsonElement[] arrMatches = root.GetProperty("glossary").GetProperty("sections")
            .EnumerateArray()
            .Where(x => x.TryGetProperty("id", out JsonElement id) && id.GetString() == "gow-sec-14")
            .ToArray();
        if (arrMatches.Length != 1) throw new InvalidDataException("GOW_ARR_MISSING_OR_AMBIGUOUS");
        JsonElement arr = arrMatches[0];
        string arrTitle = RequiredString(arr, "title");
        string arrContent = RequiredString(arr, "content_markdown");
        if (arrTitle != "§ARR · Vocabulario de entrada para ChatGPT" ||
            !arrContent.Contains("<a id=\"gow-arranque-chatgpt\"></a>", StringComparison.Ordinal) ||
            !arrContent.Contains("### Función de entrada", StringComparison.Ordinal))
            throw new InvalidDataException("GOW_ARR_CONTRACT_MISMATCH");

        JsonElement[] normativeTerms = root.GetProperty("glossary").GetProperty("terms")
            .EnumerateArray()
            .Where(x => x.TryGetProperty("id", out JsonElement id) && id.GetString() == "gow-mcp-normativo")
            .ToArray();
        if (normativeTerms.Length != 1)
            throw new InvalidDataException("MCP_NORMATIVE_STATUS_TERM_MISSING_OR_AMBIGUOUS");
        string normativeDefinition = RequiredString(normativeTerms[0], "definition");
        if (!normativeDefinition.Contains("DESACTIVADO", StringComparison.Ordinal) ||
            !normativeDefinition.Contains("no debe afirmarse ni simularse su ejecución", StringComparison.Ordinal))
            throw new InvalidDataException("MCP_NORMATIVE_NOT_CONFIRMED_DISABLED");
        const string normativeStatus = "DESACTIVADO";

        JsonElement document = root.GetProperty("document");
        Require(document.GetProperty("version").GetString(), _pin.DugVersion, "DUG_VERSION_MISMATCH");
        Require(document.GetProperty("signature").GetString(), _pin.DugSignature, "DUG_SIGNATURE_MISMATCH");
        Require(document.GetProperty("event").GetString(), _pin.DugEvent, "DUG_EVENT_MISMATCH");
        Require(document.GetProperty("canonical_source").GetString(),
            $"{_pin.Repository}/{_pin.RefName}:{_pin.CanonicalPath}", "DUG_CANONICAL_SOURCE_MISMATCH");
        Require(document.GetProperty("metacanon_version").GetString(), _pin.MetacanonVersion, "METACANON_VERSION_MISMATCH");
        Require(document.GetProperty("gow_version").GetString(), _pin.GowVersion, "GOW_VERSION_MISMATCH");
        JsonElement principlesElement = root.GetProperty("principles");
        if (document.GetProperty("principles").GetInt32() != 43 ||
            principlesElement.ValueKind != JsonValueKind.Array || principlesElement.GetArrayLength() != 43)
            throw new InvalidDataException("DUG_PRINCIPLE_COUNT_MISMATCH");
        var principleIds = new HashSet<string>(StringComparer.Ordinal);
        foreach (JsonElement principle in principlesElement.EnumerateArray())
        {
            string principleId = RequiredString(principle, "id");
            if (!principleIds.Add(principleId))
                throw new InvalidDataException("DUG_PRINCIPLE_ID_DUPLICATE");
        }

        JsonElement[] matches = principlesElement.EnumerateArray()
            .Where(p => p.TryGetProperty("id", out JsonElement id) && id.GetString() == "P004")
            .ToArray();
        if (matches.Length != 1) throw new InvalidDataException("P004_MISSING_OR_AMBIGUOUS");
        JsonElement p004 = matches[0];

        string title = RequiredString(p004, "title");
        string normativeText = RequiredString(p004, "normative_text");
        string contentMarkdown = RequiredString(p004, "content_markdown");
        string anchor = RequiredString(p004, "human_anchor");
        string microdescriptor = RequiredString(p004, "microdescriptor");
        int mdpWordCount = microdescriptor.Split((char[]?)null, StringSplitOptions.RemoveEmptyEntries).Length;
        if (title != "Principio de No-Simulación 🔒" || anchor != "#P004" ||
            contentMarkdown != "> " + normativeText ||
            microdescriptor != "Exigir hechos verificables; activarlo ante afirmaciones sobre capacidades, datos, acciones o certezas." ||
            mdpWordCount is < 11 or > 16)
            throw new InvalidDataException("P004_CONTRACT_MISMATCH");

        JsonElement preponderance = p004.GetProperty("preponderance");
        string category = RequiredString(preponderance, "category");
        double decimalValue = preponderance.GetProperty("decimal").GetDouble();



        return new SinkP004Result(
            "P004", title, normativeText, contentMarkdown, anchor, microdescriptor,
            category, decimalValue, _pin.Repository, _pin.RefName, _pin.CommitId,
            _pin.CanonicalPath, gitBlobSha,
            Convert.ToHexStringLower(SHA256.HashData(bytes)),
            Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(normativeText))),
            _pin.DugVersion, _pin.DugSignature, _pin.DugEvent,
            _pin.MetacanonVersion, _pin.GowVersion, "gow-sec-14", arrTitle, arrContent, normativeStatus);
    }

    public static string ComputeGitBlobSha(byte[] content)
    {
        byte[] header = Encoding.ASCII.GetBytes($"blob {content.Length}\0");
        byte[] payload = new byte[header.Length + content.Length];
        Buffer.BlockCopy(header, 0, payload, 0, header.Length);
        Buffer.BlockCopy(content, 0, payload, header.Length, content.Length);
        return Convert.ToHexStringLower(SHA1.HashData(payload));
    }

    private static string RequiredString(JsonElement parent, string property)
    {
        if (!parent.TryGetProperty(property, out JsonElement value) ||
            value.ValueKind != JsonValueKind.String ||
            string.IsNullOrWhiteSpace(value.GetString()))
            throw new InvalidDataException($"DUG_REQUIRED_FIELD_MISSING:{property}");
        return value.GetString()!;
    }

    private static void Require(string? actual, string expected, string code)
    {
        if (!FixedEquals(actual ?? string.Empty, expected))
            throw new InvalidDataException(code);
    }

    private static bool FixedEquals(string left, string right)
    {
        byte[] a = Encoding.UTF8.GetBytes(left);
        byte[] b = Encoding.UTF8.GetBytes(right);
        return a.Length == b.Length && CryptographicOperations.FixedTimeEquals(a, b);
    }
}
