using System.Text;
using System.Text.Json;

namespace OcpMcp.Monitoring;

/// <summary>
/// Optional, best-effort projection writer. The caller must receive the protected
/// data root from EP explicitly; this class never chooses or creates a data root.
/// </summary>
public sealed class MonitorProjectionWriter
{
    private const long MaxEventsBytes = 256 * 1024;
    private const int MaxEventsLines = 400;
    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);
    private readonly string _monitorDirectory;
    private readonly object _gate = new();

    public MonitorProjectionWriter(string dataRoot)
    {
        if (string.IsNullOrWhiteSpace(dataRoot))
            throw new ArgumentException("MONITOR_DATA_ROOT_REQUIRED", nameof(dataRoot));

        string root = Path.GetFullPath(dataRoot);
        if (!Directory.Exists(root))
            throw new DirectoryNotFoundException("MONITOR_DATA_ROOT_NOT_FOUND");

        _monitorDirectory = Path.Combine(root, "monitor");
    }

    public string MonitorDirectory => _monitorDirectory;

    public bool TryWriteState(MonitorServerSnapshot snapshot)
    {
        try
        {
            Directory.CreateDirectory(_monitorDirectory);
            string target = Path.Combine(_monitorDirectory, "state.json");
            string temp = target + "." + Guid.NewGuid().ToString("N") + ".tmp";
            try
            {
                string json = JsonSerializer.Serialize(snapshot, JsonOptions);
                File.WriteAllText(temp, json, new UTF8Encoding(false));
                File.Move(temp, target, true);
                return true;
            }
            finally
            {
                try { if (File.Exists(temp)) File.Delete(temp); } catch { }
            }
        }
        catch
        {
            return false;
        }
    }

    public bool TryAppendEvent(MonitorEvent item)
    {
        try
        {
            Directory.CreateDirectory(_monitorDirectory);
            string target = Path.Combine(_monitorDirectory, "events.jsonl");
            string json = JsonSerializer.Serialize(item, JsonOptions) + Environment.NewLine;
            byte[] bytes = Encoding.UTF8.GetBytes(json);

            lock (_gate)
            {
                if (File.Exists(target) && new FileInfo(target).Length + bytes.Length > MaxEventsBytes)
                    RotateRecentEvents(target);

                using var stream = new FileStream(target, FileMode.Append, FileAccess.Write, FileShare.Read);
                stream.Write(bytes, 0, bytes.Length);
                stream.Flush(true);
            }
            return true;
        }
        catch
        {
            return false;
        }
    }

    private static void RotateRecentEvents(string target)
    {
        if (new FileInfo(target).Length > MaxEventsBytes * 4)
            throw new InvalidDataException("EVENTS_PROJECTION_TOO_LARGE");
        string[] lines = File.ReadAllLines(target, Encoding.UTF8);
        string[] tail = lines.TakeLast(MaxEventsLines / 2).ToArray();
        string temp = target + "." + Guid.NewGuid().ToString("N") + ".tmp";
        try
        {
            File.WriteAllLines(temp, tail, new UTF8Encoding(false));
            File.Move(temp, target, true);
        }
        finally
        {
            try { if (File.Exists(temp)) File.Delete(temp); } catch { }
        }
    }
}
