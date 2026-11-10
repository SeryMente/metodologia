using System.Text.Json;

namespace OcpMcp;

internal static class Program
{
    public static async Task<int> Main(string[] args)
    {
        try
        {
            if (args.Length == 0 || args[0] != "serve")
            {
                Console.Error.WriteLine("Usage: OcpMcp.exe serve [--repo-root <path>]");
                return 64;
            }

            string? repoRoot = GetOption(args, "--repo-root");
            repoRoot = string.IsNullOrWhiteSpace(repoRoot) ? FindRepositoryRoot() : Path.GetFullPath(repoRoot);
            if (repoRoot is null) throw new DirectoryNotFoundException("METODOLOGIA_REPOSITORY_ROOT_NOT_FOUND");

            var reader = new DugSourceReader(repoRoot);
            var server = new McpServer(reader, evt => Console.Error.WriteLine(JsonSerializer.Serialize(evt)));
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
}
