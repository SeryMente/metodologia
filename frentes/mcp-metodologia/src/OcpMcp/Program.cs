using System.Diagnostics;
using System.Text.Json;
using OcpMcp.Monitoring;

namespace OcpMcp;

internal static class Program
{
    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);

    public static async Task<int> Main(string[] args)
    {
        MonitorRuntime? monitor = null;
        try
        {
            if (args.Length == 0 || args[0] != "serve")
            {
                Console.Error.WriteLine("Usage: OcpMcp.exe serve [--repo-root <path>] [--monitor-root <EP-protected-path>]");
                return 64;
            }
            string? repoRoot = GetOption(args, "--repo-root");
            repoRoot = string.IsNullOrWhiteSpace(repoRoot) ? FindRepositoryRoot() : Path.GetFullPath(repoRoot);
            if (repoRoot is null) throw new DirectoryNotFoundException("METODOLOGIA_REPOSITORY_ROOT_NOT_FOUND");

            string? monitorRoot = GetOption(args, "--monitor-root");
            if (!string.IsNullOrWhiteSpace(monitorRoot))
            {
                try { monitor = new MonitorRuntime(Path.GetFullPath(monitorRoot)); }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"MCP_MONITOR_UNAVAILABLE:{ex.GetType().Name}");
                    monitor = null;
                }
            }

            var reader = new DugSourceReader(repoRoot);
            var server = new McpServer(reader,
                evt => Console.Error.WriteLine(JsonSerializer.Serialize(evt, JsonOptions)),
                monitor is null ? null : monitor.OnEvent);
            using var cts = new CancellationTokenSource();
            Console.CancelKeyPress += (_, e) => { e.Cancel = true; cts.Cancel(); };
            await server.RunAsync(Console.In, Console.Out, cts.Token);
            return 0;
        }
        catch (OperationCanceledException) { return 0; }
        catch (Exception ex)
        {
            Console.Error.WriteLine($"MCP_OCP_START_FAILED:{ex.GetType().Name}:{ex.Message}");
            return 2;
        }
        finally { monitor?.MarkStopped(); }
    }

    private static string? GetOption(string[] args, string name)
    {
        for (int i = 1; i < args.Length - 1; i++)
            if (args[i] == name) return args[i + 1];
        return null;
    }

    private static string? FindRepositoryRoot()
    {
        foreach (string start in new[] { Environment.CurrentDirectory, AppContext.BaseDirectory })
        {
            DirectoryInfo? current = new(Path.GetFullPath(start));
            while (current is not null)
            {
                if (File.Exists(Path.Combine(current.FullName, "gobernanza", "METAPROMPT-CANONICO-SAMANTHA.html")))
                    return current.FullName;
                current = current.Parent;
            }
        }
        return null;
    }

    private sealed class MonitorRuntime
    {
        private readonly object _gate = new();
        private readonly MonitorProjectionWriter _writer;
        private MonitorServerSnapshot _snapshot;

        public MonitorRuntime(string dataRoot)
        {
            _writer = new MonitorProjectionWriter(dataRoot);
            using Process process = Process.GetCurrentProcess();
            DateTimeOffset startedAt = process.StartTime.ToUniversalTime();
            string version = typeof(Program).Assembly.GetName().Version?.ToString() ?? "0.0.1";
            _snapshot = new MonitorServerSnapshot(1, DateTimeOffset.UtcNow,
                new ServerProcessState("RUNNING", process.Id, startedAt, version, "stdio"),
                new ProtocolState("NOT_INITIALIZED"),
                new SourceReadiness(false, "UNKNOWN", false, "v388", "NX-388m", "NOT_READ"),
                new OperatorReadiness(false, "UNKNOWN"),
                new DataRootReadiness(true, false),
                new ServerReadiness(false, "SOURCES_NOT_IMPORTED"),
                new ServerActivity(null, null, null, 0, 0));

            bool writable = _writer.TryWriteState(_snapshot);
            _snapshot = _snapshot with { UpdatedAtUtc = DateTimeOffset.UtcNow, DataRoot = new DataRootReadiness(true, writable) };
            _writer.TryWriteState(_snapshot);
            Append("PROCESS_STARTED", null, "success", null, null);
        }

        public void OnEvent(MonitorEvent item)
        {
            lock (_gate)
            {
                _writer.TryAppendEvent(item);
                ProtocolState protocol = _snapshot.Protocol;
                ServerActivity activity = _snapshot.Activity;
                if (item.EventType == "MCP_INITIALIZED")
                    protocol = new ProtocolState("INITIALIZED");
                if (item.EventType == "TOOL_STARTED")
                    activity = activity with { CurrentTool = item.Tool, CurrentStartedAtUtc = item.TimestampUtc, LastEventAtUtc = item.TimestampUtc };
                else if (item.EventType == "SINK_READ_SUCCESS")
                    activity = activity with { CurrentTool = null, CurrentStartedAtUtc = null, LastEventAtUtc = item.TimestampUtc, SuccessCount = activity.SuccessCount + 1 };
                else if (item.EventType == "TOOL_FAILED")
                    activity = activity with { CurrentTool = null, CurrentStartedAtUtc = null, LastEventAtUtc = item.TimestampUtc, ErrorCount = activity.ErrorCount + 1 };
                _snapshot = _snapshot with { UpdatedAtUtc = DateTimeOffset.UtcNow, Protocol = protocol, Activity = activity };
                _writer.TryWriteState(_snapshot);
            }
        }

        public void MarkStopped()
        {
            lock (_gate)
            {
                var stopped = new MonitorEvent(1, Guid.NewGuid().ToString("N"), DateTimeOffset.UtcNow,
                    "PROCESS_STOPPED", null, "success", null, null);
                _writer.TryAppendEvent(stopped);
                _snapshot = _snapshot with {
                    UpdatedAtUtc = DateTimeOffset.UtcNow,
                    Server = _snapshot.Server with { Lifecycle = "STOPPED" },
                    Protocol = new ProtocolState("DISCONNECTED"),
                    Activity = _snapshot.Activity with { CurrentTool = null, CurrentStartedAtUtc = null, LastEventAtUtc = stopped.TimestampUtc }
                };
                _writer.TryWriteState(_snapshot);
            }
        }

        private void Append(string type, string? tool, string? outcome, long? durationMs, string? reasonCode) =>
            _writer.TryAppendEvent(new MonitorEvent(1, Guid.NewGuid().ToString("N"), DateTimeOffset.UtcNow,
                type, tool, outcome, durationMs, reasonCode));
    }
}
