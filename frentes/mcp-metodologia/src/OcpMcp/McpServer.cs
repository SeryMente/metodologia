using System.Text.Json;

namespace OcpMcp;

public sealed record SinkSuccessEvent(
    string EventId, string EventType, string OccurredAtUtc, string PrincipleId,
    string SourceCommit, string SourceGitBlobSha, string SourceSha256,
    string PrincipleTextSha256);

public sealed class McpServer(IPrincipleSource source, Action<SinkSuccessEvent>? onSuccess = null)
{
    private const string ProtocolVersion = "2025-06-18";

    public async Task RunAsync(TextReader input, TextWriter output, CancellationToken cancellationToken)
    {
        while (!cancellationToken.IsCancellationRequested)
        {
            string? line = await input.ReadLineAsync(cancellationToken);
            if (line is null) return;
            if (string.IsNullOrWhiteSpace(line)) continue;

            JsonDocument request;
            try { request = JsonDocument.Parse(line); }
            catch (JsonException)
            {
                await WriteAsync(output, new { jsonrpc = "2.0", id = (object?)null,
                    error = new { code = -32700, message = "Parse error" } }, cancellationToken);
                continue;
            }

            using (request)
            {
                JsonElement root = request.RootElement;
                if (root.ValueKind != JsonValueKind.Object ||
                    !root.TryGetProperty("jsonrpc", out JsonElement version) ||
                    version.ValueKind != JsonValueKind.String ||
                    version.GetString() != "2.0" ||
                    !root.TryGetProperty("method", out JsonElement methodElement) ||
                    methodElement.ValueKind != JsonValueKind.String)
                {
                    await WriteErrorAsync(output, root.TryGetProperty("id", out JsonElement badId) ? badId : default,
                        -32600, "Invalid Request", cancellationToken);
                    continue;
                }

                string method = methodElement.GetString()!;
                bool hasId = root.TryGetProperty("id", out JsonElement id);
                if (method == "exit") return;
                if (method is "notifications/initialized" or "notifications/cancelled") continue;
                if (!hasId) continue;

                try
                {
                    object result = method switch
                    {
                        "initialize" => Initialize(root),
                        "ping" => new { },
                        "tools/list" => ListTools(),
                        "tools/call" => CallTool(root),
                        "shutdown" => new { },
                        _ => throw new RpcException(-32601, "Method not found")
                    };
                    await WriteResultAsync(output, id, result, cancellationToken);
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
        string requested = request.TryGetProperty("params", out JsonElement p) &&
            p.ValueKind == JsonValueKind.Object &&
            p.TryGetProperty("protocolVersion", out JsonElement v) &&
            v.ValueKind == JsonValueKind.String ? v.GetString()! : ProtocolVersion;
        string negotiated = requested is "2025-06-18" or "2025-03-26" or "2024-11-05"
            ? requested : ProtocolVersion;
        return new
        {
            protocolVersion = negotiated,
            capabilities = new { tools = new { listChanged = false } },
            serverInfo = new { name = "mcp-ocp-sink-pilot", version = "0.0.1" },
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
        if (!request.TryGetProperty("params", out JsonElement p) ||
            p.ValueKind != JsonValueKind.Object ||
            !p.TryGetProperty("name", out JsonElement nameElement) ||
            nameElement.ValueKind != JsonValueKind.String)
            throw new RpcException(-32602, "Invalid tool call");
        if (nameElement.GetString() != "sink_principle")
            throw new RpcException(-32602, "Unknown tool");
        if (!p.TryGetProperty("arguments", out JsonElement args) ||
            args.ValueKind != JsonValueKind.Object ||
            !args.TryGetProperty("principle_id", out JsonElement idElement) ||
            idElement.ValueKind != JsonValueKind.String)
            return ToolError("INVALID_PRINCIPLE_ID");
        if (idElement.GetString() != "P004")
            return ToolError("PILOT_ONLY_SUPPORTS_P004");

        SinkP004Result result;
        try { result = source.ReadP004(); }
        catch (Exception ex)
        {
            return ToolError("SOURCE_NOT_VERIFIED:" + ex.GetType().Name);
        }

        var evt = new SinkSuccessEvent(
            Guid.NewGuid().ToString("N"), "SINK_READ_SUCCESS", DateTimeOffset.UtcNow.ToString("O"),
            result.PrincipleId, result.CommitId, result.GitBlobSha,
            result.SourceSha256, result.PrincipleTextSha256);
        onSuccess?.Invoke(evt);

        return new
        {
            content = new[] { new { type = "text", text = JsonSerializer.Serialize(result) } },
            isError = false
        };
    }

    private static object ToolError(string message) => new
    {
        content = new[] { new { type = "text", text = message } },
        isError = true
    };

    private static Task WriteResultAsync(TextWriter output, JsonElement id, object result, CancellationToken token) =>
        WriteAsync(output, new { jsonrpc = "2.0", id = JsonSerializer.Deserialize<object>(id.GetRawText()), result }, token);

    private static Task WriteErrorAsync(TextWriter output, JsonElement id, int code, string message, CancellationToken token) =>
        WriteAsync(output, new
        {
            jsonrpc = "2.0",
            id = id.ValueKind == JsonValueKind.Undefined ? null : JsonSerializer.Deserialize<object>(id.GetRawText()),
            error = new { code, message }
        }, token);

    private static async Task WriteAsync(TextWriter output, object value, CancellationToken token)
    {
        await output.WriteLineAsync(JsonSerializer.Serialize(value).AsMemory(), token);
        await output.FlushAsync(token);
    }

    private sealed class RpcException(int code, string message) : Exception(message)
    {
        public int Code { get; } = code;
    }
}
