using System.Text.Json;
using OcpMcp.Monitoring;

var runner = new TestRunner();
string root = Path.Combine(Path.GetTempPath(), "mcp-ocp-monitor-tests-" + Guid.NewGuid().ToString("N"));
Directory.CreateDirectory(root);
try
{
    runner.Test("missing session attestation fails closed", () =>
    {
        MonitorView view = new MonitorReader().Read(root);
        runner.Equal(false, view.SessionVerified);
        runner.Equal("SESSION_FILE_MISSING", view.ErrorCode);
    });

    runner.Test("malformed session attestation fails closed", () =>
    {
        string dir = MonitorDir(root, "bad-session");
        File.WriteAllText(Path.Combine(dir, "session.json"), "{ not-json");
        MonitorView view = new MonitorReader().Read(Path.GetDirectoryName(dir)!);
        runner.Equal(false, view.SessionVerified);
        runner.Equal("SESSION_JSON_INVALID", view.ErrorCode);
    });

    runner.Test("unsupported session schema does not become active", () =>
    {
        string testRoot = Path.Combine(root, "old-session");
        string dir = MonitorDir(testRoot);
        WriteSession(dir, schemaVersion: 99, state: "ACTIVE");
        MonitorView view = new MonitorReader().Read(testRoot);
        runner.Equal(false, view.SessionVerified);
        runner.Equal("SESSION_SCHEMA_UNSUPPORTED", view.ErrorCode);
    });

    runner.Test("inactive EP session is not reported as active", () =>
    {
        string testRoot = Path.Combine(root, "inactive");
        string dir = MonitorDir(testRoot);
        WriteSession(dir, state: "CLOSED");
        MonitorView view = new MonitorReader().Read(testRoot);
        runner.Equal(true, view.SessionVerified);
        runner.Equal(false, view.SessionActive);
        runner.Equal("Sesión EP inactiva", view.SessionStatus);
    });

    runner.Test("active EP session without server state waits without fake readiness", () =>
    {
        string testRoot = Path.Combine(root, "waiting");
        string dir = MonitorDir(testRoot);
        WriteSession(dir, state: "ACTIVE");
        MonitorView view = new MonitorReader().Read(testRoot);
        runner.Equal(true, view.SessionVerified);
        runner.Equal(true, view.SessionActive);
        runner.Equal(false, view.StateAvailable);
        runner.Equal("Servidor no iniciado", view.StateStatus);
    });

    runner.Test("invalid state schema fails closed", () =>
    {
        string testRoot = Path.Combine(root, "bad-state");
        string dir = MonitorDir(testRoot);
        WriteSession(dir, state: "ACTIVE");
        File.WriteAllText(Path.Combine(dir, "state.json"), "{\"schemaVersion\":1}");
        MonitorView view = new MonitorReader().Read(testRoot);
        runner.Equal(false, view.StateAvailable);
        runner.Equal("STATE_JSON_INVALID", view.ErrorCode);
    });

    runner.Test("verified snapshot and recent sanitized event are readable", () =>
    {
        string testRoot = Path.Combine(root, "valid");
        string dir = MonitorDir(testRoot);
        WriteSession(dir, state: "ACTIVE");
        var snapshot = Snapshot();
        File.WriteAllText(Path.Combine(dir, "state.json"), JsonSerializer.Serialize(snapshot, JsonOptions()));
        var evt = new MonitorEvent(1, "e1", DateTimeOffset.UtcNow, "SINK_READ_SUCCESS",
            "sink_principle", "success", 12, null);
        File.WriteAllText(Path.Combine(dir, "events.jsonl"), JsonSerializer.Serialize(evt, JsonOptions()) + Environment.NewLine);
        MonitorView view = new MonitorReader().Read(testRoot);
        runner.Equal(true, view.StateAvailable);
        runner.Equal("v388", view.State!.Sources.DugVersion);
        runner.Equal(1, view.Events.Count);
        runner.Equal("SINK_READ_SUCCESS", view.Events[0].EventType);
    });

    runner.Test("malformed events while waiting for server fail closed without throwing", () =>
    {
        string testRoot = Path.Combine(root, "bad-waiting-events");
        string dir = MonitorDir(testRoot);
        WriteSession(dir, state: "ACTIVE");
        File.WriteAllText(Path.Combine(dir, "events.jsonl"), "{ bad-event");
        MonitorView view = new MonitorReader().Read(testRoot);
        runner.Equal(false, view.StateAvailable);
        runner.Equal("EVENTS_JSON_INVALID", view.ErrorCode);
    });

    runner.Test("oversized event projection is rejected before parsing", () =>
    {
        string testRoot = Path.Combine(root, "large-events");
        string dir = MonitorDir(testRoot);
        WriteSession(dir, state: "ACTIVE");
        File.WriteAllText(Path.Combine(dir, "events.jsonl"), new string('x', 256 * 1024 + 1));
        MonitorView view = new MonitorReader().Read(testRoot);
        runner.Equal(false, view.StateAvailable);
        runner.Equal("EVENTS_JSON_INVALID", view.ErrorCode);
    });

    runner.Test("writer creates monitor projection under explicitly supplied existing root", () =>
    {
        string testRoot = Path.Combine(root, "writer");
        Directory.CreateDirectory(testRoot);
        var writer = new MonitorProjectionWriter(testRoot);
        runner.Equal(true, writer.TryWriteState(Snapshot()));
        runner.Equal(true, File.Exists(Path.Combine(testRoot, "monitor", "state.json")));
        var evt = new MonitorEvent(1, "e2", DateTimeOffset.UtcNow, "TOOL_FAILED",
            "sink_principle", "error", 4, "SOURCE_NOT_VERIFIED");
        runner.Equal(true, writer.TryAppendEvent(evt));
        runner.Equal(1, File.ReadLines(Path.Combine(testRoot, "monitor", "events.jsonl")).Count());
    });

    runner.Test("invalid data root returns unavailable rather than throwing", () =>
    {
        MonitorView view = new MonitorReader().Read(Path.Combine(root, "not-created"));
        runner.Equal(false, view.SessionVerified);
    });
}
finally
{
    try { Directory.Delete(root, recursive: true); } catch { }
}
return runner.Finish();

static string MonitorDir(string root, string? child = null)
{
    string path = string.IsNullOrWhiteSpace(child) ? root : Path.Combine(root, child);
    string dir = Path.Combine(path, "monitor");
    Directory.CreateDirectory(dir);
    return dir;
}

static void WriteSession(string dir, int schemaVersion = 1, string state = "ACTIVE")
{
    var session = new SessionAttestation(schemaVersion, state, DateTimeOffset.UtcNow.AddMinutes(-2),
        "UNKNOWN", DateTimeOffset.UtcNow.AddMinutes(-1));
    File.WriteAllText(Path.Combine(dir, "session.json"), JsonSerializer.Serialize(session, JsonOptions()));
}

static MonitorServerSnapshot Snapshot() => new(
    1, DateTimeOffset.UtcNow,
    new ServerProcessState("RUNNING", Environment.ProcessId, DateTimeOffset.UtcNow.AddMinutes(-1), "1.0.0", "stdio"),
    new ProtocolState("INITIALIZED"),
    new SourceReadiness(false, "UNKNOWN", false, "v388", "NX-388m", "NOT_READ"),
    new OperatorReadiness(false, "UNKNOWN"),
    new DataRootReadiness(true, true),
    new ServerReadiness(false, "SOURCES_NOT_IMPORTED"),
    new ServerActivity(null, null, DateTimeOffset.UtcNow, 0, 0));

static JsonSerializerOptions JsonOptions() => new(JsonSerializerDefaults.Web);

sealed class TestRunner
{
    private int _passed;
    private int _failed;
    public void Test(string name, Action test)
    {
        try { test(); _passed++; Console.WriteLine("PASS " + name); }
        catch (Exception ex) { _failed++; Console.WriteLine("FAIL " + name + ": " + ex.GetType().Name + " " + ex.Message); }
    }
    public void Equal<T>(T expected, T actual)
    {
        if (!EqualityComparer<T>.Default.Equals(expected, actual))
            throw new InvalidOperationException($"Expected {expected}; actual {actual}");
    }
    public int Finish()
    {
        Console.WriteLine($"MONITOR_TEST_SUMMARY PASS={_passed} FAIL={_failed}");
        return _failed == 0 ? 0 : 1;
    }
}
