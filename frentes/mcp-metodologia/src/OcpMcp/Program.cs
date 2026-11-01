using OcpMcp.Protocol;
using OcpMcp.Security;
using OcpMcp.Services;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace OcpMcp;

internal static class Program
{
    private static readonly Guid FolderIdLocalAppData=new("F1B32785-6FBA-4FCF-9D55-7B8E7F157091");

    public static async Task<int> Main(string[] args)
    {
        try
        {
            string local=GetKnownFolder(FolderIdLocalAppData);
            bool testMode=Environment.GetEnvironmentVariable("OCPMCP_TEST_MODE")=="1";
            string? testRoot=Environment.GetEnvironmentVariable("OCPMCP_TEST_DATA_ROOT");
            string dataRoot=testMode && !string.IsNullOrWhiteSpace(testRoot)
                ? Path.GetFullPath(testRoot)
                : Path.Combine(local,"SeryMente","OCP MCP");
            var store=new SqliteStore(dataRoot);
            var vault=new KeyVault(store);

            if(args.Length==0) return PrintUsage();
            switch(args[0])
            {
                case "serve":
                    store.Initialize();
                    try { new BackupService(store).EnsureStartupBackup(); }
                    catch(Exception backupError) { Console.Error.WriteLine($"STARTUP_BACKUP_FAILED type={backupError.GetType().Name}"); }
                    var catalog=new PrincipleCatalog(store);
                    var ops=new OperationService(store,vault,catalog);
                    var server=new McpServer(store,ops,catalog);
                    using(var cts=new CancellationTokenSource())
                    {
                        Console.CancelKeyPress+=(s,e)=>{e.Cancel=true;cts.Cancel();};
                        await server.RunAsync(cts.Token);
                    }
                    return 0;

                case "diagnose":
                    return Diagnose(store);

                case "provision-operator":
                    store.Initialize();
                    vault.ProvisionOperator();
                    return 0;

                case "authorize":
                    store.Initialize();
                    string request=GetOption(args,"--request-id")??throw new ArgumentException("--request-id is required");
                    vault.AuthorizeRequest(request);
                    return 0;

                case "import-sources":
                    store.Initialize();
                    string repoRoot=GetOption(args,"--repo-root")??throw new ArgumentException("--repo-root is required");
                    new SourceImporter(store).Import(Path.GetFullPath(repoRoot));
                    Console.WriteLine("SOURCE_IMPORT_COMPLETED");
                    return 0;

                case "backup":
                    store.Initialize();
                    string reason=GetOption(args,"--reason")??"manual";
                    string backupId=reason=="pre-update"?new BackupService(store).CreatePreUpdateBackup():new BackupService(store).CreateBackup([reason.ToUpperInvariant()]);
                    Console.WriteLine(JsonSerializer.Serialize(new{backup_id=backupId,status="VERIFIED"}));
                    return 0;

                case "restore":
                    string restoreId=GetOption(args,"--backup-id")??throw new ArgumentException("--backup-id is required");
                    new BackupService(store).Restore(restoreId);
                    Console.WriteLine(JsonSerializer.Serialize(new{backup_id=restoreId,status="RESTORED"}));
                    return 0;

                case "revoke":
                    store.Initialize();
                    vault.RevokeRequest(GetOption(args,"--request-id")??throw new ArgumentException("--request-id is required"));
                    Console.WriteLine("GRANT_REVOKED");
                    return 0;

                case "rotate-hmac-key":
                    store.Initialize();
                    vault.RotateHmacKey();
                    return 0;

                default:return PrintUsage();
            }
        }
        catch(Exception ex)
        {
            Console.Error.WriteLine($"OCP_MCP_FATAL type={ex.GetType().Name} message={ex.Message}");
            return 2;
        }
    }

    private static int Diagnose(SqliteStore store)
    {
        if(!File.Exists(store.DatabasePath))
        {
            Console.WriteLine(JsonSerializer.Serialize(new{status="NOT_READY",code=2,version="0.1.0",reason="DATABASE_NOT_INITIALIZED"}));
            return 2;
        }
        try
        {
            using var c=store.Open();
            string integrity=SqliteStore.ScalarText(c,"PRAGMA quick_check;");
            if(integrity!="ok")
            {
                Console.WriteLine(JsonSerializer.Serialize(new{status="NOT_READY",code=2,version="0.1.0",database=integrity}));
                return 2;
            }
            string backup="NOT_YET_CREATED";
            using(var cmd=c.CreateCommand())
            {
                cmd.CommandText="SELECT created_at_utc FROM backup_points WHERE tags_json LIKE '%DAILY%' ORDER BY created_at_utc DESC LIMIT 1;";
                string? last=cmd.ExecuteScalar() as string;
                if(last is not null)backup=DateTimeOffset.UtcNow-DateTimeOffset.Parse(last)>=TimeSpan.FromHours(24)?"DAILY_BACKUP_DUE":"CURRENT";
            }
            int code=backup=="CURRENT"?0:1;
            Console.WriteLine(JsonSerializer.Serialize(new{status=code==0?"READY":"DEGRADED",code,version="0.1.0",database="ok",backup_status=backup,normative_engine="DESACTIVADO",sink="OUT_OF_SCOPE"}));
            return code;
        }
        catch(Exception ex)
        {
            Console.WriteLine(JsonSerializer.Serialize(new{status="NOT_READY",code=2,version="0.1.0",reason=ex.GetType().Name}));
            return 2;
        }
    }

    private static string? GetOption(string[] args,string name)
    {
        for(int i=1;i<args.Length-1;i++)if(args[i]==name)return args[i+1];
        return null;
    }

    private static int PrintUsage()
    {
        Console.Error.WriteLine("OcpMcp 0.1.0 commands: serve | diagnose --json | provision-operator | authorize --request-id <id> | import-sources --repo-root <path>");
        return 64;
    }

    private static string GetKnownFolder(Guid folderId)
    {
        int hr=SHGetKnownFolderPath(ref folderId,0,IntPtr.Zero,out IntPtr path);
        if(hr!=0)Marshal.ThrowExceptionForHR(hr);
        try
        {
            string value=Marshal.PtrToStringUni(path)??throw new InvalidOperationException("KNOWN_FOLDER_EMPTY");
            if(!Path.IsPathFullyQualified(value))throw new InvalidOperationException("KNOWN_FOLDER_NOT_ABSOLUTE");
            return Path.GetFullPath(value);
        }
        finally{Marshal.FreeCoTaskMem(path);}
    }

    [DllImport("shell32.dll",CharSet=CharSet.Unicode)]
    private static extern int SHGetKnownFolderPath(ref Guid rfid,uint dwFlags,IntPtr hToken,out IntPtr ppszPath);
}
