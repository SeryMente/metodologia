using System.Diagnostics;
using System.Text.Json;
using OcpMcp.Monitoring;
namespace OcpMcp;

public sealed record SinkSuccessEvent(
    string EventId, string EventType, string OccurredAtUtc, string PrincipleId,
    string SourceCommit, string SourceGitBlobSha, string SourceSha256, string PrincipleTextSha256);

public sealed class McpServer(
    IPrincipleSource source,
    Action<SinkSuccessEvent>? onSuccess = null,
    Action<MonitorEvent>? onMonitorEvent = null)
{
    private const string ProtocolVersion = "2025-11-25";
    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);
    private static readonly HashSet<string> SupportedProtocolVersions = new(StringComparer.Ordinal)
    { "2025-11-25", "2025-06-18", "2025-03-26", "2024-11-05" };

    public async Task RunAsync(TextReader input, TextWriter output, CancellationToken cancellationToken)
    {
        bool initializeResponded = false, initialized = false;
        while (!cancellationToken.IsCancellationRequested)
        {
            string? line = await input.ReadLineAsync(cancellationToken);
            if (line is null) return;
            if (string.IsNullOrWhiteSpace(line)) continue;
            JsonDocument request;
            try { request = JsonDocument.Parse(line); }
            catch (JsonException)
            {
                await WriteAsync(output, new { jsonrpc = "2.0", id = (object?)null, error = new { code = -32700, message = "Parse error" } }, cancellationToken);
                continue;
            }
            using (request)
            {
                JsonElement root = request.RootElement;
                if (root.ValueKind != JsonValueKind.Object)
                {
                    await WriteErrorAsync(output, default, -32600, "Invalid Request", cancellationToken);
                    continue;
                }
                if (!root.TryGetProperty("jsonrpc", out JsonElement version) || version.ValueKind != JsonValueKind.String ||
                    version.GetString() != "2.0" || !root.TryGetProperty("method", out JsonElement methodElement) ||
                    methodElement.ValueKind != JsonValueKind.String)
                {
                    await WriteErrorAsync(output, root.TryGetProperty("id", out JsonElement badId) ? badId : default,
                        -32600, "Invalid Request", cancellationToken);
                    continue;
                }
                string method = methodElement.GetString()!;
                bool hasId = root.TryGetProperty("id", out JsonElement id);
                if (method == "notifications/initialized")
                {
                    if (initializeResponded)
                    {
                        initialized = true;
                        EmitMonitorEvent("MCP_INITIALIZED", null, "success", null, null);
                    }
                    continue;
                }
                if (method == "notifications/cancelled") continue;
                if (!hasId) continue;
                if (!initialized && method is not ("initialize" or "ping"))
                {
                    await WriteErrorAsync(output, id, -32002, "Server not initialized", cancellationToken);
                    continue;
                }
                try
                {
                    object result = method switch
                    {
                        "initialize" => Initialize(root),
                        "ping" => new { },
                        "tools/list" => ListTools(),
                        "tools/call" => CallTool(root),
                        _ => throw new RpcException(-32601, "Method not found")
                    };
                    await WriteResultAsync(output, id, result, cancellationToken);
                    if (method == "initialize") initializeResponded = true;
                }
                catch (RpcException ex)
                {
                    await WriteErrorAsync(output, id, ex.Code, ex.Message, cancellationToken);
                }
            }
        }
    }

    private static object Initialize(JsonElement request)
    {
        if (!request.TryGetProperty("params", out JsonElement p) || p.ValueKind != JsonValueKind.Object ||
            !p.TryGetProperty("protocolVersion", out JsonElement v) || v.ValueKind != JsonValueKind.String ||
            !p.TryGetProperty("capabilities", out JsonElement capabilities) || capabilities.ValueKind != JsonValueKind.Object ||
            !p.TryGetProperty("clientInfo", out JsonElement clientInfo) || clientInfo.ValueKind != JsonValueKind.Object ||
            !clientInfo.TryGetProperty("name", out JsonElement clientName) || clientName.ValueKind != JsonValueKind.String ||
            !clientInfo.TryGetProperty("version", out JsonElement clientVersion) || clientVersion.ValueKind != JsonValueKind.String)
            throw new RpcException(-32602, "Invalid initialize params");
        string requested = v.GetString()!;
        string negotiated = SupportedProtocolVersions.Contains(requested) ? requested : ProtocolVersion;
        return new
        {
            protocolVersion = negotiated,
            capabilities = new { tools = new { listChanged = false } },
            serverInfo = new { name = "mcp-ocp-sink-pilot", version = "0.1.0" },
            instructions = "Servidor local MCP-OCP por STDIO. Solo expone SINK:P004. MCP-NORMATIVO permanece DESACTIVADO."
        };
    }

    private static object ListTools() => new
    {
        tools = new[]
        {
            new
            {
                name = "sink_principle",
                description = "Resuelve el texto desarrollado de un principio desde el DUG fijado. En este piloto solo se admite P004 (SINK:P004).",
                inputSchema = new
                {
                    type = "object",
                    properties = new { principle_id = new { type = "string", @enum = new[] { "P004" } } },
                    required = new[] { "principle_id" },
                    additionalProperties = false
                }
            }
        }
    };

    private object CallTool(JsonElement request)
    {
        if (!request.TryGetProperty("params", out JsonElement p) || p.ValueKind != JsonValueKind.Object ||
            !p.TryGetProperty("name", out JsonElement nameElement) || nameElement.ValueKind != JsonValueKind.String)
            return FailedTool("INVALID_TOOL_CALL", null);
        if (nameElement.GetString() != "sink_principle")
            return FailedTool("UNKNOWN_TOOL", null);
        if (!p.TryGetProperty("arguments", out JsonElement args) || args.ValueKind != JsonValueKind.Object ||
            args.EnumerateObject().Count() != 1 || !args.TryGetProperty("principle_id", out JsonElement idElement) ||
            idElement.ValueKind != JsonValueKind.String)
            return FailedTool("INVALID_PRINCIPLE_ID", "sink_principle");
        if (idElement.GetString() != "P004")
            return FailedTool("PILOT_ONLY_SUPPORTS_P004", "sink_principle");

        var stopwatch = Stopwatch.StartNew();
        EmitMonitorEvent("TOOL_STARTED", "sink_principle", null, null, null);
        SinkP004Result result;
        try { result = source.ReadP004(); }
        catch (Exception ex)
        {
            stopwatch.Stop();
            EmitMonitorEvent("TOOL_FAILED", "sink_principle", "error", stopwatch.ElapsedMilliseconds, "SOURCE_NOT_VERIFIED");
            return ToolError("SOURCE_NOT_VERIFIED:" + ex.GetType().Name);
        }
        stopwatch.Stop();
        var evt = new SinkSuccessEvent(Guid.NewGuid().ToString("N"), "SINK_READ_SUCCESS",
            DateTimeOffset.UtcNow.ToString("O"), result.PrincipleId, result.CommitId, result.GitBlobSha,
            result.SourceSha256, result.PrincipleTextSha256);
        try { onSuccess?.Invoke(evt); } catch { }
        EmitMonitorEvent("SINK_READ_SUCCESS", "sink_principle", "success", stopwatch.ElapsedMilliseconds, null);
        return new { content = new[] { new { type = "text", text = JsonSerializer.Serialize(result, JsonOptions) } }, isError = false };
    }

    private object FailedTool(string reasonCode, string? tool)
    {
        EmitMonitorEvent("TOOL_FAILED", tool, "error", null, reasonCode);
        return ToolError(reasonCode);
    }

    private void EmitMonitorEvent(string type, string? tool, string? outcome, long? durationMs, string? reasonCode)
    {
        if (onMonitorEvent is null) return;
        try
        {
            onMonitorEvent(new MonitorEvent(1, Guid.NewGuid().ToString("N"), DateTimeOffset.UtcNow,
                type, tool, outcome, durationMs, reasonCode));
        }
        catch { }
    }

    private static object ToolError(string message) => new
    {
        content = new[] { new { type = "text", text = message } },
        isError = true
    };

    private static Task WriteResultAsync(TextWriter output, JsonElement id, object result, CancellationToken token) =>
        WriteAsync(output, new { jsonrpc = "2.0", id = JsonSerializer.Deserialize<object>(id.GetRawText()), result }, token);

    private static Task WriteErrorAsync(TextWriter output, JsonElement id, int code, string message, CancellationToken token) =>
        WriteAsync(output, new { jsonrpc = "2.0",
            id = id.ValueKind == JsonValueKind.Undefined ? null : JsonSerializer.Deserialize<object>(id.GetRawText()),
            error = new { code, message } }, token);

    private static async Task WriteAsync(TextWriter output, object value, CancellationToken token)
    {
        await output.WriteLineAsync(JsonSerializer.Serialize(value).AsMemory(), token);
        await output.FlushAsync(token);
    }

    private sealed class RpcException(int code, string message) : Exception(message)
    { public int Code { get; } = code; }
}
