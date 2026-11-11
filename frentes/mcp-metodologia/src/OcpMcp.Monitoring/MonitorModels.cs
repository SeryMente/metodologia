namespace OcpMcp.Monitoring;

public sealed record SessionAttestation(
    int SchemaVersion,
    string SessionState,
    DateTimeOffset SessionStartedAtUtc,
    string ProtectionState,
    DateTimeOffset ProtectionCheckedAtUtc);

public sealed record ServerProcessState(
    string Lifecycle,
    int ProcessId,
    DateTimeOffset ProcessStartedAtUtc,
    string SoftwareVersion,
    string Transport);

public sealed record ProtocolState(string State);

public sealed record SourceReadiness(
    bool Imported,
    string Integrity,
    bool Current,
    string DugVersion,
    string DugSignature,
    string Verification);

public sealed record OperatorReadiness(bool Provisioned, string State);

public sealed record DataRootReadiness(bool Configured, bool ReadWriteAvailable);

public sealed record ServerReadiness(bool Ready, string ReasonCode);

public sealed record ServerActivity(
    string? CurrentTool,
    DateTimeOffset? CurrentStartedAtUtc,
    DateTimeOffset? LastEventAtUtc,
    int SuccessCount,
    int ErrorCount);

public sealed record MonitorServerSnapshot(
    int SchemaVersion,
    DateTimeOffset UpdatedAtUtc,
    ServerProcessState Server,
    ProtocolState Protocol,
    SourceReadiness Sources,
    OperatorReadiness Operator,
    DataRootReadiness DataRoot,
    ServerReadiness Readiness,
    ServerActivity Activity);

public sealed record MonitorEvent(
    int SchemaVersion,
    string EventId,
    DateTimeOffset TimestampUtc,
    string EventType,
    string? Tool,
    string? Outcome,
    long? DurationMs,
    string? ReasonCode);

public sealed record MonitorView(
    bool SessionAvailable,
    bool SessionVerified,
    bool SessionActive,
    string SessionStatus,
    SessionAttestation? Session,
    bool StateAvailable,
    string StateStatus,
    MonitorServerSnapshot? State,
    IReadOnlyList<MonitorEvent> Events,
    string? ErrorCode);
