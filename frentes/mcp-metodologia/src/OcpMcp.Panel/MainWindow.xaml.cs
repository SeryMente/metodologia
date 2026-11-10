using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Runtime.CompilerServices;
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
    private bool _sessionActive;
    private MonitorServerSnapshot? _lastState;

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
            FileSystemEventHandler changed = (_, _) => Dispatcher.BeginInvoke(RefreshView, DispatcherPriority.Background);
            RenamedEventHandler renamed = (_, _) => Dispatcher.BeginInvoke(RefreshView, DispatcherPriority.Background);
            _watcher.Changed += changed;
            _watcher.Created += changed;
            _watcher.Deleted += changed;
            _watcher.Renamed += renamed;
        }
        catch
        {
            Set(nameof(OverallStatus), "OBSERVABILIDAD NO DISPONIBLE", v => OverallStatus = v);
            Set(nameof(OverallDetail), "No se pudo observar el root de monitor.", v => OverallDetail = v);
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
            ProtectionSummary = $"{view.Session.ProtectionState} · EP: {view.Session.ProtectionCheckedAtUtc.ToLocalTime():g}";
            SessionDuration = $"Desde {view.Session.SessionStartedAtUtc.ToLocalTime():g}";
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
            ProcessStage = "No iniciado";
            ProtocolStage = "Pendiente";
            SourcesStage = "Pendientes";
            ReadinessStage = "No disponible";
            ProcessHealth = "Esperando";
            ProcessHealthDetail = "Sin state.json";
            return;
        }

        MonitorServerSnapshot state = view.State;
        _lastState = state;
        SoftwareVersion = state.Server.SoftwareVersion;
        ProtocolStage = state.Protocol.State;
        ProtocolDetail = state.Server.Transport.ToUpperInvariant();
        ProcessStage = state.Server.Lifecycle;
        ProcessDetail = $"PID {state.Server.ProcessId}";
        ProcessHealth = state.Server.Lifecycle;
        ProcessHealthDetail = $"PID {state.Server.ProcessId} · {state.Server.ProcessStartedAtUtc.ToLocalTime():g}";
        SourcesStage = state.Sources.Imported && state.Sources.Integrity.Equals("VERIFIED", StringComparison.OrdinalIgnoreCase) && state.Sources.Current ? "Verificadas" : "No listas";
        SourcesDetail = $"{state.Sources.DugVersion} · {state.Sources.DugSignature} · {state.Sources.Integrity}";
        SourcesHealth = SourcesStage;
        DugPin = $"{state.Sources.DugVersion} / {state.Sources.DugSignature}";
        OperatorHealth = state.Operator.Provisioned ? "Provisionado" : state.Operator.State;
        OperatorDetail = state.Operator.Provisioned ? "Identidad configurada" : "No provisionado / desconocido";
        RootHealth = state.DataRoot.Configured && state.DataRoot.ReadWriteAvailable ? "Accesible" : "No verificado";
        ReadinessStage = state.Readiness.Ready ? "READY" : "Bloqueado";
        ReadinessDetail = state.Readiness.ReasonCode;

        CurrentActivity = string.IsNullOrWhiteSpace(state.Activity.CurrentTool) ? "Sin operaciones en curso" : state.Activity.CurrentTool!;
        ActivityDetail = state.Activity.CurrentStartedAtUtc is DateTimeOffset start
            ? $"Inicio {start.ToLocalTime():g}" : "No hay herramienta activa";
        ActivityCounts = $"Éxitos {state.Activity.SuccessCount} · Errores {state.Activity.ErrorCount}";

        RecentEvents.Clear();
        foreach (MonitorEvent evt in view.Events.Take(10))
            RecentEvents.Add(new RecentEventRow(evt.TimestampUtc.ToLocalTime().ToString("HH:mm:ss"), evt.Tool ?? evt.EventType, evt.Outcome ?? "—"));
        RecentEventsEmpty = RecentEvents.Count == 0 ? "Sin actividad registrada" : string.Empty;

        bool ready = state.Readiness.Ready &&
            state.Sources.Imported &&
            state.Sources.Current &&
            state.Sources.Integrity.Equals("VERIFIED", StringComparison.OrdinalIgnoreCase) &&
            state.Operator.Provisioned &&
            state.DataRoot.Configured &&
            state.DataRoot.ReadWriteAvailable;
        if (ready)
        {
            OverallStatus = "LISTO";
            OverallDetail = "Sesión EP activa; proceso, protocolo, fuentes, operador y root cumplen los gates publicados.";
            StatusGlyph = "✓";
            AttentionTitle = "Sin atención requerida";
            AttentionDetail = "Readiness completa según la proyección del servidor y la atestación EP.";
        }
        else
        {
            OverallStatus = state.Readiness.Ready ? "ATENCIÓN" : "BLOQUEADO";
            OverallDetail = $"Servidor {state.Server.Lifecycle}; protocolo {state.Protocol.State}; readiness {state.Readiness.ReasonCode}.";
            StatusGlyph = "!";
            AttentionTitle = "Gate pendiente";
            AttentionDetail = state.Readiness.ReasonCode;
        }

        AttachProcess(state.Server.ProcessId, state.Server.ProcessStartedAtUtc);
        NotifyAll();
    }

    private void AttachProcess(int pid, DateTimeOffset startedAt)
    {
        if (_serverProcess is not null && _serverProcess.Id == pid) return;
        DetachProcess();
        try
        {
            Process p = Process.GetProcessById(pid);
            DateTimeOffset actualStart = p.StartTime.ToUniversalTime();
            if (Math.Abs((actualStart - startedAt).TotalSeconds) > 2)
            {
                p.Dispose();
                ProcessStage = "Proceso distinto";
                ProcessHealth = "No verificado";
                return;
            }
            p.EnableRaisingEvents = true;
            p.Exited += (_, _) => Dispatcher.BeginInvoke(RefreshView, DispatcherPriority.Background);
            _serverProcess = p;
        }
        catch
        {
            ProcessStage = "Desconectado";
            ProcessHealth = "No accesible";
        }
    }

    private void DetachProcess()
    {
        if (_serverProcess is null) return;
        try { _serverProcess.Exited -= OnServerExited; } catch { }
        _serverProcess.Dispose();
        _serverProcess = null;
    }

    private void OnServerExited(object? sender, EventArgs e) => Dispatcher.BeginInvoke(RefreshView, DispatcherPriority.Background);

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
