using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using OcpMcp;

var runner = new TestRunner();
string root = Path.Combine(Path.GetTempPath(), "mcp-ocp-p004-tests-" + Guid.NewGuid().ToString("N"));
Directory.CreateDirectory(Path.Combine(root, "gobernanza"));
string sourcePath = Path.Combine(root, "gobernanza", "METAPROMPT-CANONICO-SAMANTHA.html");
try
{
    byte[] bytes = Encoding.UTF8.GetBytes(FixtureHtml());
    File.WriteAllBytes(sourcePath, bytes);
    var pin = new SourcePin("SeryMente/metodologia", "main", "test-commit",
        "gobernanza/METAPROMPT-CANONICO-SAMANTHA.html",
        DugSourceReader.ComputeGitBlobSha(bytes), "v387", "NX-387m", "TEST-EVENT", "1.29", "2.18");
    var reader = new DugSourceReader(root, pin);

    runner.Test("P004 exact text and metadata", () =>
    {
        SinkP004Result r = reader.ReadP004();
        runner.Equal("P004", r.PrincipleId);
        runner.Equal("Principio de No-Simulación 🔒", r.Title);
        runner.Equal("No finjas capacidades, datos, resultados ni certezas, ni declares límites sin verificar con herramientas. Marca tu certeza y nombra los huecos sin rellenarlos. Precedencia absoluta sobre la exhaustividad y el buen trato.", r.NormativeText);
        runner.Equal("Exigir hechos verificables; activarlo ante afirmaciones sobre capacidades, datos, acciones o certezas.", r.Microdescriptor);
        runner.Equal("gow-sec-14", r.GowArrId);
        runner.Equal("NX-387m", r.DugSignature);
        runner.Equal("DESACTIVADO", r.McpNormativeStatus);
        runner.Equal(pin.GitBlobSha, r.GitBlobSha);
        runner.Equal(Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(r.NormativeText))), r.PrincipleTextSha256);
    });

    runner.Test("source pin rejects altered file", () =>
    {
        File.AppendAllText(sourcePath, "tampered");
        runner.Throws<CryptographicException>(() => reader.ReadP004());
        File.WriteAllBytes(sourcePath, bytes);
    });

    runner.Test("missing source fails closed", () =>
    {
        var missingReader = new DugSourceReader(Path.Combine(root, "missing"), pin);
        runner.Throws<FileNotFoundException>(() => missingReader.ReadP004());
    });

    runner.Test("altered P004 content fails even when blob hash is repinned", () =>
    {
        string alteredRoot = Path.Combine(root, "altered");
        Directory.CreateDirectory(Path.Combine(alteredRoot, "gobernanza"));
        byte[] altered = Encoding.UTF8.GetBytes(FixtureHtml(normativeText: "Texto normativo alterado."));
        File.WriteAllBytes(Path.Combine(alteredRoot, "gobernanza", "METAPROMPT-CANONICO-SAMANTHA.html"), altered);
        var repinned = pin with { GitBlobSha = DugSourceReader.ComputeGitBlobSha(altered) };
        runner.Throws<InvalidDataException>(() => new DugSourceReader(alteredRoot, repinned).ReadP004());
    });

    runner.Test("unauthorized source pin fails closed", () =>
    {
        var wrongPin = pin with { GitBlobSha = new string('0', 40) };
        runner.Throws<CryptographicException>(() => new DugSourceReader(root, wrongPin).ReadP004());
    });

    runner.Test("invalid DUG metadata fails closed", () =>
    {
        string badRoot = Path.Combine(root, "bad");
        Directory.CreateDirectory(Path.Combine(badRoot, "gobernanza"));
        byte[] bad = Encoding.UTF8.GetBytes(FixtureHtml(version: "v386"));
        File.WriteAllBytes(Path.Combine(badRoot, "gobernanza", "METAPROMPT-CANONICO-SAMANTHA.html"), bad);
        var badPin = pin with { GitBlobSha = DugSourceReader.ComputeGitBlobSha(bad) };
        runner.Throws<InvalidDataException>(() => new DugSourceReader(badRoot, badPin).ReadP004());
    });

    runner.Test("invalid identifier does not emit success event", async () =>
    {
        int events = 0;
        var server = new McpServer(reader, _ => events++);
        string input = Rpc("initialize", 1, new { protocolVersion = "2025-06-18" }) + "\n" +
            Rpc("tools/list", 2, new { }) + "\n" +
            Rpc("tools/call", 3, new { name = "sink_principle", arguments = new { principle_id = "P005" } }) + "\n" +
            Rpc("shutdown", 4, new { }) + "\n" +
            "{\"jsonrpc\":\"2.0\",\"method\":\"exit\"}\n";
        using var output = new StringWriter();
        await server.RunAsync(new StringReader(input), output, CancellationToken.None);
        string[] lines = output.ToString().Split('\n', StringSplitOptions.RemoveEmptyEntries);
        runner.Equal(4, lines.Length);
        using JsonDocument call = JsonDocument.Parse(lines[2]);
        runner.Equal(true, call.RootElement.GetProperty("result").GetProperty("isError").GetBoolean());
        runner.Equal(0, events);
    });

    runner.Test("initialize, discovery, P004, hashes, event and clean shutdown", async () =>
    {
        var events = new List<SinkSuccessEvent>();
        var server = new McpServer(reader, events.Add);
        string input = Rpc("initialize", 1, new { protocolVersion = "2025-06-18" }) + "\n" +
            Rpc("tools/list", 2, new { }) + "\n" +
            Rpc("tools/call", 3, new { name = "sink_principle", arguments = new { principle_id = "P004" } }) + "\n" +
            Rpc("shutdown", 4, new { }) + "\n" +
            "{\"jsonrpc\":\"2.0\",\"method\":\"exit\"}\n";
        using var output = new StringWriter();
        await server.RunAsync(new StringReader(input), output, CancellationToken.None);
        string[] lines = output.ToString().Split('\n', StringSplitOptions.RemoveEmptyEntries);
        runner.Equal(4, lines.Length);
        using JsonDocument init = JsonDocument.Parse(lines[0]);
        runner.Equal("2025-06-18", init.RootElement.GetProperty("result").GetProperty("protocolVersion").GetString());
        using JsonDocument list = JsonDocument.Parse(lines[1]);
        runner.Equal("sink_principle", list.RootElement.GetProperty("result").GetProperty("tools")[0].GetProperty("name").GetString());
        using JsonDocument call = JsonDocument.Parse(lines[2]);
        string payload = call.RootElement.GetProperty("result").GetProperty("content")[0].GetProperty("text").GetString()!;
        using JsonDocument result = JsonDocument.Parse(payload);
        runner.Equal("P004", result.RootElement.GetProperty("principleId").GetString());
        runner.Equal(pin.GitBlobSha, result.RootElement.GetProperty("gitBlobSha").GetString());
        runner.Equal(64, result.RootElement.GetProperty("sourceSha256").GetString()!.Length);
        runner.Equal(64, result.RootElement.GetProperty("principleTextSha256").GetString()!.Length);
        runner.Equal(1, events.Count);
        runner.Equal("SINK_READ_SUCCESS", events[0].EventType);
    });

    runner.Test("source failure emits no success event", async () =>
    {
        var missingReader = new DugSourceReader(Path.Combine(root, "missing"), pin);
        int events = 0;
        var server = new McpServer(missingReader, _ => events++);
        string input = Rpc("tools/call", 1, new { name = "sink_principle", arguments = new { principle_id = "P004" } }) + "\n";
        using var output = new StringWriter();
        await server.RunAsync(new StringReader(input), output, CancellationToken.None);
        using JsonDocument response = JsonDocument.Parse(output.ToString());
        runner.Equal(true, response.RootElement.GetProperty("result").GetProperty("isError").GetBoolean());
        runner.Equal(0, events);
    });
}
finally
{
    try { Directory.Delete(root, recursive: true); } catch { }
}

return runner.Finish();

static string Rpc(string method, int id, object parameters) =>
    JsonSerializer.Serialize(new { jsonrpc = "2.0", id, method, @params = parameters });

static string FixtureHtml(string version = "v387", string? normativeText = null)
{
    normativeText ??= "No finjas capacidades, datos, resultados ni certezas, ni declares límites sin verificar con herramientas. Marca tu certeza y nombra los huecos sin rellenarlos. Precedencia absoluta sobre la exhaustividad y el buen trato.";
    string json = JsonSerializer.Serialize(new
    {
        document = new
        {
            version, signature = "NX-387m", @event = "TEST-EVENT",
            canonical_source = "SeryMente/metodologia/main:gobernanza/METAPROMPT-CANONICO-SAMANTHA.html",
            metacanon_version = "1.29", gow_version = "2.18", principles = 43
        },
        authority = new
        {
            single_normative_document = true,
            human_content_precedes_machine_representation = true,
            machine_representation_is_derived = true,
            independent_machine_authority = false
        },
        sections = new[]
        {
            new { id = "samantha", content = "Principios universales [[P:P004]]." }
        },
        principle_inventory_policy = new
        {
            required_full_text_route = "Sink alias per principle",
            default_consult_before_application = true,
            deliberately_insufficient_for_full_application = true
        },
        principles = new[]
        {
            new { id = "P004", title = "Principio de No-Simulación 🔒",
                normative_text = normativeText,
                content_markdown = "> " + normativeText,
                human_anchor = "#P004",
                microdescriptor = "Exigir hechos verificables; activarlo ante afirmaciones sobre capacidades, datos, acciones o certezas.",
                preponderance = new { category = "A", @decimal = 0.8 } }
        },
        glossary = new
        {
            sections = new[]
            {
                new { id = "gow-sec-14", title = "§ARR · Vocabulario de entrada para ChatGPT",
                    content_markdown = "<a id=\"gow-arranque-chatgpt\"></a>\n### Función de entrada\nLee §ARR." }
            },
            terms = new[]
            {
                new { id = "gow-mcp-normativo", definition = "Mecanismo de verificación normativa automática del DUG. Su estado vigente está DESACTIVADO; no debe afirmarse ni simularse su ejecución." }
            }
        }
    });
    return "<html><script id=\"gov-data\" type=\"application/json\">" + json + "</script></html>";
}

sealed class TestRunner
{
    private int _passed;
    private int _failed;
    public void Test(string name, Action test)
    {
        try { test(); _passed++; Console.WriteLine("PASS " + name); }
        catch (Exception ex) { _failed++; Console.WriteLine("FAIL " + name + ": " + ex.GetType().Name + " " + ex.Message); }
    }
    public void Test(string name, Func<Task> test)
    {
        try { test().GetAwaiter().GetResult(); _passed++; Console.WriteLine("PASS " + name); }
        catch (Exception ex) { _failed++; Console.WriteLine("FAIL " + name + ": " + ex.GetType().Name + " " + ex.Message); }
    }
    public void Equal<T>(T expected, T actual)
    {
        if (!EqualityComparer<T>.Default.Equals(expected, actual))
            throw new InvalidOperationException($"Expected {expected}; actual {actual}");
    }
    public void Throws<T>(Action action) where T : Exception
    {
        try { action(); }
        catch (T) { return; }
        throw new InvalidOperationException("Expected exception " + typeof(T).Name);
    }
    public int Finish()
    {
        Console.WriteLine($"PILOT_TEST_SUMMARY PASS={_passed} FAIL={_failed}");
        return _failed == 0 ? 0 : 1;
    }
}
