using System.Globalization;
using System.Text.Json;

namespace OcpMcp.Monitoring;

/// <summary>Read-only, fail-closed parser for EP attestation and MCP projections.</summary>
public sealed class MonitorReader
{
    private static readonly JsonDocumentOptions JsonOptions = new() { CommentHandling = JsonCommentHandling.Disallow, AllowTrailingCommas = false };

    public MonitorView Read(string dataRoot)
    {
        if (string.IsNullOrWhiteSpace(dataRoot))
            return Unavailable("DATA_ROOT_NOT_CONFIGURED");

        string monitorDirectory;
        try { monitorDirectory = Path.Combine(Path.GetFullPath(dataRoot), "monitor"); }
        catch { return Unavailable("DATA_ROOT_INVALID"); }

        string sessionPath = Path.Combine(monitorDirectory, "session.json");
        if (!File.Exists(sessionPath))
            return new(false, false, false, "Sesión no verificada", null, false, "Esperando atestación EP", null, Array.Empty<MonitorEvent>(), "SESSION_FILE_MISSING");

        SessionAttestation? session;
        try { session = ReadSession(sessionPath); }
        catch { return Unavailable("SESSION_JSON_INVALID"); }

        if (session is null || session.SchemaVersion != 1)
            return Unavailable("SESSION_SCHEMA_UNSUPPORTED");

        bool active = string.Equals(session.SessionState, "ACTIVE", StringComparison.OrdinalIgnoreCase);
        if (!active)
            return new(true, true, false, "Sesión EP inactiva", session, false, "Servidor no disponible", null, Array.Empty<MonitorEvent>(), null);

        string statePath = Path.Combine(monitorDirectory, "state.json");
        if (!File.Exists(statePath))
        {
            try
            {
                return new(true, true, true, "Sesión activa · esperando servidor MCP", session,
                    false, "Servidor no iniciado", null, ReadEvents(monitorDirectory), null);
            }
            catch
            {
                return new(true, true, true, "Sesión activa · proyección no disponible", session,
                    false, "Estado no disponible / requiere revisión", null, Array.Empty<MonitorEvent>(), "EVENTS_JSON_INVALID");
            }
        }

        MonitorServerSnapshot? state;
        try { state = ReadState(statePath); }
        catch { return new(true, true, true, "Sesión activa · proyección no disponible", session, false, "Estado no disponible / requiere revisión", null, Array.Empty<MonitorEvent>(), "STATE_JSON_INVALID"); }

        if (state is null || state.SchemaVersion != 1)
            return new(true, true, true, "Sesión activa · proyección no disponible", session, false, "Estado no disponible / requiere revisión", null, Array.Empty<MonitorEvent>(), "STATE_SCHEMA_UNSUPPORTED");

        IReadOnlyList<MonitorEvent> events;
        try { events = ReadEvents(monitorDirectory); }
        catch { return new(true, true, true, "Sesión activa · proyección no disponible", session, false, "Estado no disponible / requiere revisión", null, Array.Empty<MonitorEvent>(), "EVENTS_JSON_INVALID"); }

        return new(true, true, true, "Sesión activa", session, true, "Proyección disponible", state, events, null);
    }

    private static SessionAttestation? ReadSession(string path)
    {
        using JsonDocument doc = JsonDocument.Parse(File.ReadAllText(path), JsonOptions);
        JsonElement root = doc.RootElement;
        return new SessionAttestation(
            RequiredInt(root, "schemaVersion"),
            RequiredString(root, "sessionState"),
            RequiredDate(root, "sessionStartedAtUtc"),
            RequiredString(root, "protectionState"),
            RequiredDate(root, "protectionCheckedAtUtc"));
    }

    private static MonitorServerSnapshot? ReadState(string path)
    {
        using JsonDocument doc = JsonDocument.Parse(File.ReadAllText(path), JsonOptions);
        JsonElement root = doc.RootElement;

        JsonElement server = RequiredObject(root, "server");
        JsonElement protocol = RequiredObject(root, "protocol");
        JsonElement sources = RequiredObject(root, "sources");
        JsonElement op = RequiredObject(root, "operator");
        JsonElement dataRoot = RequiredObject(root, "dataRoot");
        JsonElement readiness = RequiredObject(root, "readiness");
        JsonElement activity = RequiredObject(root, "activity");

        return new MonitorServerSnapshot(
            RequiredInt(root, "schemaVersion"),
            RequiredDate(root, "updatedAtUtc"),
            new ServerProcessState(
                RequiredString(server, "lifecycle"),
                RequiredInt(server, "processId"),
                RequiredDate(server, "processStartedAtUtc"),
                RequiredString(server, "softwareVersion"),
                RequiredString(server, "transport")),
            new ProtocolState(RequiredString(protocol, "state")),
            new SourceReadiness(
                RequiredBool(sources, "imported"),
                RequiredString(sources, "integrity"),
                RequiredBool(sources, "current"),
                RequiredString(sources, "dugVersion"),
                RequiredString(sources, "dugSignature"),
                RequiredString(sources, "verification")),
            new OperatorReadiness(RequiredBool(op, "provisioned"), RequiredString(op, "state")),
            new DataRootReadiness(RequiredBool(dataRoot, "configured"), RequiredBool(dataRoot, "readWriteAvailable")),
            new ServerReadiness(RequiredBool(readiness, "ready"), RequiredString(readiness, "reasonCode")),
            new ServerActivity(
                OptionalString(activity, "currentTool"),
                OptionalDate(activity, "currentStartedAtUtc"),
                OptionalDate(activity, "lastEventAtUtc"),
                RequiredInt(activity, "successCount"),
                RequiredInt(activity, "errorCount")));
    }

    private const long MaxEventsBytes = 256 * 1024;

    private static IReadOnlyList<MonitorEvent> ReadEvents(string directory)
    {
        string path = Path.Combine(directory, "events.jsonl");
        if (!File.Exists(path)) return Array.Empty<MonitorEvent>();
        if (new FileInfo(path).Length > MaxEventsBytes)
            throw new InvalidDataException("EVENTS_PROJECTION_TOO_LARGE");

        var events = new List<MonitorEvent>();
        foreach (string line in File.ReadLines(path).TakeLast(50))
        {
            if (string.IsNullOrWhiteSpace(line)) continue;
            using JsonDocument doc = JsonDocument.Parse(line, JsonOptions);
            JsonElement root = doc.RootElement;
            events.Add(new MonitorEvent(
                RequiredInt(root, "schemaVersion"),
                RequiredString(root, "eventId"),
                RequiredDate(root, "timestampUtc"),
                RequiredString(root, "eventType"),
                OptionalString(root, "tool"),
                OptionalString(root, "outcome"),
                OptionalLong(root, "durationMs"),
                OptionalString(root, "reasonCode")));
        }
        return events.OrderByDescending(x => x.TimestampUtc).ToArray();
    }

    private static int RequiredInt(JsonElement e, string name) =>
        e.TryGetProperty(name, out JsonElement v) && v.TryGetInt32(out int n) ? n : throw new InvalidDataException("FIELD_INVALID:" + name);

    private static long? OptionalLong(JsonElement e, string name) =>
        e.TryGetProperty(name, out JsonElement v) && v.ValueKind == JsonValueKind.Number && v.TryGetInt64(out long n) ? n : null;

    private static bool RequiredBool(JsonElement e, string name) =>
        e.TryGetProperty(name, out JsonElement v) && (v.ValueKind is JsonValueKind.True or JsonValueKind.False) ? v.GetBoolean() : throw new InvalidDataException("FIELD_INVALID:" + name);

    private static string RequiredString(JsonElement e, string name) =>
        e.TryGetProperty(name, out JsonElement v) && v.ValueKind == JsonValueKind.String && !string.IsNullOrWhiteSpace(v.GetString())
            ? v.GetString()! : throw new InvalidDataException("FIELD_INVALID:" + name);

    private static string? OptionalString(JsonElement e, string name) =>
        e.TryGetProperty(name, out JsonElement v) && v.ValueKind == JsonValueKind.String ? v.GetString() : null;

    private static DateTimeOffset RequiredDate(JsonElement e, string name) =>
        DateTimeOffset.TryParse(RequiredString(e, name), CultureInfo.InvariantCulture, DateTimeStyles.AssumeUniversal, out DateTimeOffset value)
            ? value : throw new InvalidDataException("DATETIME_INVALID:" + name);

    private static DateTimeOffset? OptionalDate(JsonElement e, string name) =>
        e.TryGetProperty(name, out JsonElement v) && v.ValueKind == JsonValueKind.String &&
        DateTimeOffset.TryParse(v.GetString(), CultureInfo.InvariantCulture, DateTimeStyles.AssumeUniversal, out DateTimeOffset value) ? value : null;

    private static JsonElement RequiredObject(JsonElement e, string name) =>
        e.TryGetProperty(name, out JsonElement value) && value.ValueKind == JsonValueKind.Object ? value : throw new InvalidDataException("OBJECT_INVALID:" + name);

    private static MonitorView Unavailable(string code) =>
        new(false, false, false, "Sesión no verificada", null, false, "Estado no disponible / requiere revisión", null, Array.Empty<MonitorEvent>(), code);
}
