using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Windows;
using System.Windows.Threading;
using OcpMcp.Monitoring;

namespace OcpMcp.Panel;

public partial class MainWindow : Window, INotifyPropertyChanged
{
    private readonly MonitorReader _reader = new();
    private readonly string? _dataRoot;
    private FileSystemWatcher? _watcher;
    private Process? _serverProcess;
    private DateTimeOffset? _attachedProcessStartedAtUtc;
    private bool _sessionActive;
    private int _refreshQueued;

    public event PropertyChangedEventHandler? PropertyChanged;
    public ObservableCollection<RecentEventRow> RecentEvents { get; } = new();

    public string SoftwareVersion { get; private set; } = "MCP-OCP 1.0.0";
    public string SessionDuration { get; private set; } = "Duración no disponible";
    public string OverallStatus { get; private set; } = "SESIÓN NO VERIFICADA";
    public string OverallDetail { get; private set; } = "La atestación EP no está disponible.";
    public string StatusGlyph { get; private set; } = "!";
    public string SessionStatus { get; private set; } = "NO VERIFICADA";
    public string SessionStage { get; private set; } = "No verificada";
    public string ProtectionSummary { get; private set; } = "Protección no atestada por EP";
    public string ProcessStage { get; private set; } = "Esperando servidor";
    public string ProcessDetail { get; private set; } = "Sin proceso identificado";
    public string ProtocolStage { get; private set; } = "No iniciado";
    public string ProtocolDetail { get; private set; } = "STDIO pendiente";
    public string SourcesStage { get; private set; } = "No verificadas";
    public string SourcesDetail { get; private set; } = "Sin snapshot válido";
    public string ReadinessStage { get; private set; } = "No disponible";
    public string ReadinessDetail { get; private set; } = "No se ha acreditado readiness";
    public string ProcessHealth { get; private set; } = "Desconocido";
    public string ProcessHealthDetail { get; private set; } = "Sin snapshot de proceso";
    public string SourcesHealth { get; private set; } = "Desconocidas";
    public string DugPin { get; private set; } = "Sin pin verificado";
    public string OperatorHealth { get; private set; } = "Desconocido";
    public string OperatorDetail { get; private set; } = "Sin estado de operador";
    public string RootHealth { get; private set; } = "Desconocido";
    public string CurrentActivity { get; private set; } = "Sin operaciones en curso";
    public string ActivityDetail { get; private set; } = "No se ha registrado actividad";
    public string ActivityCounts { get; private set; } = "Sin muestras";
    public string RecentEventsEmpty { get; private set; } = "Sin actividad registrada";
    public string AttentionTitle { get; private set; } = "Requiere revisión";
    public string AttentionDetail { get; private set; } = "La sesión o la proyección no está verificada.";

    public MainWindow()
    {
        InitializeComponent();
        _dataRoot = GetOption(Environment.GetCommandLineArgs().Skip(1).ToArray(), "--data-root");
        DataContext = this;
        Loaded += (_, _) => { RefreshView(); StartWatching(); };
        Closing += OnClosing;
    }

    private void StartWatching()
    {
        if (string.IsNullOrWhiteSpace(_dataRoot)) return;
        try
        {
            string monitorPath = Path.Combine(Path.GetFullPath(_dataRoot), "monitor");
            if (!Directory.Exists(monitorPath)) return;

            _watcher = new FileSystemWatcher(monitorPath)
            {
                IncludeSubdirectories = false,
                NotifyFilter = NotifyFilters.FileName | NotifyFilters.LastWrite | NotifyFilters.Size,
                Filter = "*",
                EnableRaisingEvents = true
            };
            FileSystemEventHandler changed = (_, _) => QueueRefresh();
            RenamedEventHandler renamed = (_, _) => QueueRefresh();
            _watcher.Changed += changed;
            _watcher.Created += changed;
            _watcher.Deleted += changed;
            _watcher.Renamed += renamed;
        }
        catch
        {
            OverallStatus = "OBSERVABILIDAD NO DISPONIBLE";
            OverallDetail = "No se pudo observar el root de monitor.";
            AttentionTitle = "Proyección inaccesible";
            AttentionDetail = "Revisar el acceso al root protegido; el panel no elevará permisos.";
            NotifyAll();
        }
    }

    private void RefreshView()
    {
        MonitorView view = _reader.Read(_dataRoot ?? string.Empty);
        _sessionActive = view.SessionVerified && view.SessionActive;
        SessionStatus = view.SessionStatus;
        SessionStage = view.SessionVerified ? (view.SessionActive ? "Activa" : "Inactiva") : "No verificada";

        if (view.Session is not null)
        {
            ProtectionSummary = $"EP: {view.Session.ProtectionState} · verificada {view.Session.ProtectionCheckedAtUtc.ToLocalTime():g}";
            TimeSpan duration = DateTimeOffset.UtcNow - view.Session.SessionStartedAtUtc;
            SessionDuration = duration >= TimeSpan.Zero
                ? $"Duración {FormatDuration(duration)}"
                : "Fecha de inicio no válida";
        }
        else
        {
            ProtectionSummary = "Protección no atestada por EP";
            SessionDuration = "Duración no disponible";
        }

        if (!view.SessionVerified)
        {
            OverallStatus = "SESIÓN NO VERIFICADA";
            OverallDetail = "El panel no asume que EP esté activa. Verificar session.json.";
            StatusGlyph = "!";
            AttentionTitle = "Sesión no verificada";
            AttentionDetail = view.ErrorCode ?? "La atestación EP está ausente o inválida.";
            SetStageDefaults();
            return;
        }

        if (!view.SessionActive)
        {
            OverallStatus = "SESIÓN INACTIVA";
            OverallDetail = "EP no declara una sesión activa.";
            StatusGlyph = "×";
            AttentionTitle = "Sesión cerrada";
            AttentionDetail = "EP controla el cierre de este panel.";
            DetachProcess();
            SetStageDefaults();
            return;
        }

        if (!view.StateAvailable || view.State is null)
        {
            OverallStatus = "ESPERANDO SERVIDOR";
            OverallDetail = "La sesión EP está activa; el cliente MCP aún no ha publicado un snapshot del servidor.";
            StatusGlyph = "…";
            AttentionTitle = "Esperando servidor MCP";
            AttentionDetail = "El panel no inicia ni reinicia el proceso.";
            DetachProcess();
            ProcessStage = "No iniciado";
            ProcessDetail = "Sin proceso identificado";
            ProtocolStage = "Pendiente";
            SourcesStage = "Pendientes";
            ReadinessStage = "No disponible";
            ProcessHealth = "Esperando";
            ProcessHealthDetail = "Sin state.json";
            NotifyAll();
            return;
        }

        MonitorServerSnapshot state = view.State;
        SoftwareVersion = state.Server.SoftwareVersion;
        ProtocolStage = state.Protocol.State;
        ProtocolDetail = state.Server.Transport.ToUpperInvariant();
        ProcessStage = state.Server.Lifecycle;
        ProcessDetail = $"PID {state.Server.ProcessId}";
        SourcesStage = state.Sources.Imported &&
            state.Sources.Integrity.Equals("VERIFIED", StringComparison.OrdinalIgnoreCase) &&
            state.Sources.Current ? "Verificadas" : "No listas";
        SourcesDetail = $"{state.Sources.DugVersion} · {state.Sources.DugSignature} · {state.Sources.Integrity}";
        SourcesHealth = SourcesStage;
        DugPin = $"{state.Sources.DugVersion} / {state.Sources.DugSignature}";
        OperatorHealth = state.Operator.Provisioned ? "Provisionado" : state.Operator.State;
        OperatorDetail = state.Operator.Provisioned ? "Identidad configurada" : "No provisionado / desconocido";
        RootHealth = state.DataRoot.Configured && state.DataRoot.ReadWriteAvailable ? "Accesible" : "No verificado";

        CurrentActivity = string.IsNullOrWhiteSpace(state.Activity.CurrentTool)
            ? "Sin operaciones en curso" : state.Activity.CurrentTool!;
        ActivityDetail = state.Activity.CurrentStartedAtUtc is DateTimeOffset start
            ? $"Inicio {start.ToLocalTime():g}" : "No hay herramienta activa";
        ActivityCounts = $"Éxitos {state.Activity.SuccessCount} · Errores {state.Activity.ErrorCount}";

        RecentEvents.Clear();
        foreach (MonitorEvent evt in view.Events.Take(10))
            RecentEvents.Add(new RecentEventRow(
                evt.TimestampUtc.ToLocalTime().ToString("HH:mm:ss"),
                evt.Tool ?? evt.EventType,
                evt.Outcome ?? "—"));
        RecentEventsEmpty = RecentEvents.Count == 0 ? "Sin actividad registrada" : string.Empty;

        bool processVerified = AttachProcess(state.Server.ProcessId, state.Server.ProcessStartedAtUtc);
        MonitorReadinessResult evaluation = MonitorReadinessEvaluator.Evaluate(view.Session, state, processVerified);
        ReadinessStage = evaluation.Ready ? "READY" : "Bloqueado";
        ReadinessDetail = evaluation.ReasonCode;

        if (evaluation.Ready)
        {
            OverallStatus = "LISTO";
            OverallDetail = "Sesión EP activa y protección On atestada; proceso, protocolo, fuentes, operador y root cumplen los gates publicados.";
            StatusGlyph = "✓";
            AttentionTitle = "Sin atención requerida";
            AttentionDetail = "Readiness completa según la proyección del servidor y la atestación EP.";
        }
        else
        {
            OverallStatus = !processVerified ? "DETENIDO" :
                evaluation.ReasonCode == "EP_PROTECTION_NOT_ON" ? "BLOQUEADO" :
                state.Readiness.Ready ? "ATENCIÓN" : "BLOQUEADO";
            OverallDetail = $"Gate de readiness pendiente: {evaluation.ReasonCode}.";
            StatusGlyph = "!";
            AttentionTitle = "Gate pendiente";
            AttentionDetail = evaluation.ReasonCode;
        }

        NotifyAll();
    }

    private void QueueRefresh()
    {
        if (Interlocked.Exchange(ref _refreshQueued, 1) != 0) return;
        Dispatcher.BeginInvoke(() =>
        {
            Interlocked.Exchange(ref _refreshQueued, 0);
            RefreshView();
        }, DispatcherPriority.Background);
    }

    private bool AttachProcess(int pid, DateTimeOffset startedAt)
    {
        if (_serverProcess is not null &&
            _attachedProcessStartedAtUtc == startedAt &&
            SafeHasNotExited(_serverProcess))
            return true;

        DetachProcess();
        try
        {
            Process process = Process.GetProcessById(pid);
            DateTimeOffset actualStart = process.StartTime.ToUniversalTime();
            if (process.HasExited || Math.Abs((actualStart - startedAt).TotalSeconds) > 2)
            {
                process.Dispose();
                ProcessStage = "Proceso distinto";
                ProcessHealth = "No verificado";
                return false;
            }

            process.EnableRaisingEvents = true;
            process.Exited += OnServerExited;
            _serverProcess = process;
            _attachedProcessStartedAtUtc = startedAt;
            return true;
        }
        catch
        {
            ProcessStage = "Desconectado";
            ProcessHealth = "No accesible";
            return false;
        }
    }

    private static bool SafeHasNotExited(Process process)
    {
        try { return !process.HasExited; }
        catch { return false; }
    }

    private void DetachProcess()
    {
        if (_serverProcess is null) return;
        try { _serverProcess.Exited -= OnServerExited; } catch { }
        _serverProcess.Dispose();
        _serverProcess = null;
        _attachedProcessStartedAtUtc = null;
    }

    private void OnServerExited(object? sender, EventArgs e) => QueueRefresh();

    private void OnClosing(object? sender, CancelEventArgs e)
    {
        if (_sessionActive)
        {
            e.Cancel = true;
            WindowState = WindowState.Minimized;
        }
        else
        {
            DetachProcess();
            _watcher?.Dispose();
        }
    }

    private void SetStageDefaults()
    {
        ProcessStage = "Desconocido";
        ProcessDetail = "Sin proceso identificado";
        ProtocolStage = "No iniciado";
        ProtocolDetail = "STDIO pendiente";
        SourcesStage = "No verificadas";
        SourcesDetail = "Sin snapshot válido";
        ReadinessStage = "No disponible";
        ReadinessDetail = "No se ha acreditado readiness";
        ProcessHealth = "Desconocido";
        ProcessHealthDetail = "Sin snapshot de proceso";
        SourcesHealth = "Desconocidas";
        DugPin = "Sin pin verificado";
        OperatorHealth = "Desconocido";
        OperatorDetail = "Sin estado de operador";
        RootHealth = "Desconocido";
        CurrentActivity = "Sin operaciones en curso";
        ActivityDetail = "No se ha registrado actividad";
        ActivityCounts = "Sin muestras";
        RecentEvents.Clear();
        RecentEventsEmpty = "Sin actividad registrada";
        NotifyAll();
    }

    private static string FormatDuration(TimeSpan duration)
    {
        int days = (int)duration.TotalDays;
        return days > 0
            ? $"{days} d {duration.Hours} h"
            : duration.TotalHours >= 1
                ? $"{(int)duration.TotalHours} h {duration.Minutes} min"
                : $"{duration.Minutes} min";
    }

    private static string? GetOption(string[] args, string name)
    {
        for (int i = 0; i < args.Length - 1; i++)
            if (string.Equals(args[i], name, StringComparison.OrdinalIgnoreCase))
                return args[i + 1];
        return null;
    }

    private void Set<T>(string propertyName, T value, Action<T> setter)
    {
        setter(value);
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    private void NotifyAll()
    {
        foreach (System.Reflection.PropertyInfo property in GetType().GetProperties())
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(property.Name));
    }
}

public sealed record RecentEventRow(string Time, string Summary, string Outcome);
