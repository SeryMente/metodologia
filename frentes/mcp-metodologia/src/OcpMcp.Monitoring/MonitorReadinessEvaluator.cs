namespace OcpMcp.Monitoring;

public sealed record MonitorReadinessResult(bool Ready, string ReasonCode);

/// <summary>
/// Composes EP attestation with the MCP snapshot. No server-side field may
/// substitute for EP's explicit volume-protection attestation.
/// </summary>
public static class MonitorReadinessEvaluator
{
    public static MonitorReadinessResult Evaluate(
        SessionAttestation? session,
        MonitorServerSnapshot? state,
        bool processIdentityVerified,
        DateTimeOffset? nowUtc = null)
    {
        DateTimeOffset now = nowUtc ?? DateTimeOffset.UtcNow;

        if (session is null || session.SchemaVersion != 1)
            return Blocked("SESSION_NOT_VERIFIED");
        if (!session.SessionState.Equals("ACTIVE", StringComparison.OrdinalIgnoreCase))
            return Blocked("SESSION_NOT_ACTIVE");
        if (!session.ProtectionState.Equals("Protection On", StringComparison.OrdinalIgnoreCase))
            return Blocked("EP_PROTECTION_NOT_ON");
        if (session.SessionStartedAtUtc > now.AddMinutes(1) ||
            session.ProtectionCheckedAtUtc > now.AddMinutes(1))
            return Blocked("EP_ATTESTATION_TIME_INVALID");

        if (state is null || state.SchemaVersion != 1)
            return Blocked("SERVER_STATE_NOT_VERIFIED");
        if (!processIdentityVerified)
            return Blocked("SERVER_PROCESS_NOT_VERIFIED");
        if (!state.Server.Lifecycle.Equals("RUNNING", StringComparison.OrdinalIgnoreCase))
            return Blocked("SERVER_NOT_RUNNING");
        if (!state.Protocol.State.Equals("INITIALIZED", StringComparison.OrdinalIgnoreCase))
            return Blocked("PROTOCOL_NOT_INITIALIZED");
        if (!state.Sources.Imported)
            return Blocked("SOURCES_NOT_IMPORTED");
        if (!state.Sources.Integrity.Equals("VERIFIED", StringComparison.OrdinalIgnoreCase))
            return Blocked("SOURCES_INTEGRITY_NOT_VERIFIED");
        if (!state.Sources.Current)
            return Blocked("SOURCES_NOT_CURRENT");
        if (!state.Operator.Provisioned)
            return Blocked("OPERATOR_NOT_PROVISIONED");
        if (!state.DataRoot.Configured || !state.DataRoot.ReadWriteAvailable)
            return Blocked("DATA_ROOT_NOT_AVAILABLE");
        if (!state.Readiness.Ready)
            return Blocked(string.IsNullOrWhiteSpace(state.Readiness.ReasonCode)
                ? "SERVER_NOT_READY" : state.Readiness.ReasonCode);

        return new(true, "READY");
    }

    private static MonitorReadinessResult Blocked(string reason) => new(false, reason);
}
