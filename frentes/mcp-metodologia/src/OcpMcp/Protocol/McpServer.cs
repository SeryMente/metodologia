using Microsoft.Data.Sqlite;
using OcpMcp.Security;
using OcpMcp.Services;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace OcpMcp.Protocol;

public sealed class McpServer(SqliteStore store, OperationService operations)
{
    private const string ProtocolVersion="2025-06-18";

    public async Task RunAsync(CancellationToken cancellationToken)
    {
        string? line;
        while(!cancellationToken.IsCancellationRequested && (line=await Console.In.ReadLineAsync(cancellationToken)) is not null)
        {
            if(string.IsNullOrWhiteSpace(line))continue;
            JsonDocument? message=null;
            try
            {
                message=JsonDocument.Parse(line);
                JsonElement root=message.RootElement;
                string? method=root.TryGetProperty("method",out var m)?m.GetString():null;
                if(method is null) { await WriteError(root,"-32600","Invalid Request",cancellationToken);continue; }
                if(method=="notifications/initialized" || method=="notifications/cancelled")continue;
                if(!root.TryGetProperty("id",out var id))continue;
                try
                {
                    object? result=method switch
                    {
                        "initialize"=>Initialize(root),
                        "ping"=>new{},
                        "tools/list"=>ListTools(),
                        "tools/call"=>CallTool(root),
                        _=>throw new McpException(-32601,"Method not found")
                    };
                    await WriteResult(id,result,cancellationToken);
                }
                catch(McpException ex){await WriteError(root,ex.Code.ToString(),ex.Message,cancellationToken);}
                catch(UnauthorizedAccessException ex){await WriteError(root,ex.Message,"Protected operation denied.",cancellationToken);}
                catch(InvalidOperationException ex){await WriteError(root,"OPERATION_FAILED",ex.Message,cancellationToken);}
                catch(InvalidDataException ex){await WriteError(root,"INVALID_DATA",ex.Message,cancellationToken);}
                catch(CryptographicException ex){await WriteError(root,"INTEGRITY_FAILURE",ex.Message,cancellationToken);}
                catch(Exception ex)
                {
                    Console.Error.WriteLine($"MCP_REQUEST_ERROR type={ex.GetType().Name} message={Sanitize(ex.Message)}");
                    await WriteError(root,"INTERNAL_ERROR","Internal operation failed; see local redacted diagnostics.",cancellationToken);
                }
            }
            catch(JsonException){await WriteRawError("{\"jsonrpc\":\"2.0\",\"id\":null,\"error\":{\"code\":-32700,\"message\":\"Parse error\"}}",cancellationToken);}
            finally{message?.Dispose();}
        }
    }

    private object Initialize(JsonElement root)
    {
        string requested=root.TryGetProperty("params",out var p)&&p.TryGetProperty("protocolVersion",out var v)?v.GetString()??ProtocolVersion:ProtocolVersion;
        string negotiated=requested=="2025-06-18"||requested=="2025-03-26"?requested:ProtocolVersion;
        return new {
            protocolVersion=negotiated,
            capabilities=new {tools=new {listChanged=false}},
            serverInfo=new {name="ocp-mcp",version="0.1.0"},
            instructions="Servidor local de Metodología. MCP-NORMATIVO permanece DESACTIVADO. Lectura disponible; las escrituras requieren autorización explícita local."
        };
    }

    private object ListTools() => new {
        tools=new object[]
        {
            Tool("get_health","Read local server readiness without triggering normative validation.",new{type="object",properties=new{},additionalProperties=false}),
            Tool("list_canonical_sources","List verified source metadata; does not assert freshness against main.",new{type="object",properties=new{limit=new{type="integer",minimum=1,maximum=100}},additionalProperties=false}),
            Tool("read_canonical_source","Read a source only after DPAPI/AES-GCM and SHA-256 verification.",new{type="object",required=new[]{"source_id"},properties=new{source_id=new{type="string"}},additionalProperties=false}),
            Tool("get_cycle","Read a persisted work cycle.",new{type="object",required=new[]{"cycle_id"},properties=new{cycle_id=new{type="string"}},additionalProperties=false}),
            Tool("get_operation_status","Read an operation request status without revealing authorization material.",new{type="object",required=new[]{"request_id"},properties=new{request_id=new{type="string"}},additionalProperties=false}),
            Tool("get_receipt","Read and cryptographically verify a signed operation receipt.",new{type="object",required=new[]{"receipt_id"},properties=new{receipt_id=new{type="string"}},additionalProperties=false}),
            Tool("list_cycle_events","Read cycle events and their hash-chain links.",new{type="object",required=new[]{"cycle_id"},properties=new{cycle_id=new{type="string"},limit=new{type="integer",minimum=1,maximum=200}},additionalProperties=false}),
            Tool("list_telemetry_events","Read local redacted operational telemetry; no Sink delivery occurs.",new{type="object",properties=new{limit=new{type="integer",minimum=1,maximum=200}},additionalProperties=false}),
            Tool("prepare_operation","Create a pending protected operation request. This does not authorize or execute it.",new{type="object",required=new[]{"operation_type","parameters"},properties=new{operation_type=new{type="string",@enum=new[]{"OPEN_CYCLE","RECORD_CLASSIFICATION","SET_SELECTION","BUILD_SNAPSHOT","RELEASE_SNAPSHOT"}},parameters=new{type="object"}},additionalProperties=false}),
            Tool("execute_operation","Execute a request only when a locally approved, valid, unused grant exists.",new{type="object",required=new[]{"request_id"},properties=new{request_id=new{type="string"}},additionalProperties=false})
        }
    };

    private static object Tool(string name,string description,object schema)=>new{name,description,inputSchema=schema};

    private object CallTool(JsonElement root)
    {
        if(!root.TryGetProperty("params",out var p)||!p.TryGetProperty("name",out var nameEl))throw new McpException(-32602,"Invalid tool call");
        string name=nameEl.GetString()??"";
        JsonElement args=p.TryGetProperty("arguments",out var a)?a:JsonDocument.Parse("{}").RootElement;
        object result=name switch
        {
            "get_health"=>GetHealth(),
            "list_canonical_sources"=>ListSources(args),
            "read_canonical_source"=>ReadSource(args),
            "get_cycle"=>GetCycle(GetRequired(args,"cycle_id")),
            "get_operation_status"=>GetOperationStatus(GetRequired(args,"request_id")),
            "get_receipt"=>GetReceipt(GetRequired(args,"receipt_id")),
            "list_cycle_events"=>ListEvents(GetRequired(args,"cycle_id"),args.TryGetProperty("limit",out var limit)?Math.Clamp(limit.GetInt32(),1,200):100),
            "list_telemetry_events"=>ListTelemetry(args.TryGetProperty("limit",out var telemetryLimit)?Math.Clamp(telemetryLimit.GetInt32(),1,200):100),
            "prepare_operation"=>operations.Prepare(GetRequired(args,"operation_type"),args.GetProperty("parameters")),
            "execute_operation"=>operations.Execute(GetRequired(args,"request_id")),
            _=>throw new McpException(-32602,"Unknown tool")
        };
        return new {content=new[]{new{type="text",text=JsonSerializer.Serialize(result)}},isError=false};
    }

    private object GetHealth()
    {
        using var c=store.Open();
        string db=SqliteStore.ScalarText(c,"PRAGMA quick_check;");
        if(db!="ok")return new{status="NOT_READY",code=2,version="0.1.0",database=db,details="SQLite integrity check failed; normative engine not consulted."};
        var installation=SqliteStore.GetInstallation(c);
        bool operatorProvisioned=installation?.OperatorSid is not null;
        string backupStatus="NOT_YET_CHECKED";
        using(var q=c.CreateCommand())
        {
            q.CommandText="SELECT created_at_utc FROM backup_points WHERE tags_json LIKE '%DAILY%' ORDER BY created_at_utc DESC LIMIT 1;";
            var latest=q.ExecuteScalar() as string;
            if(latest is null)backupStatus="BACKUP_NOT_CREATED";
            else if(DateTimeOffset.UtcNow-DateTimeOffset.Parse(latest)>=TimeSpan.FromHours(24))backupStatus="DAILY_BACKUP_DUE";
            else backupStatus="CURRENT";
        }
        int code=backupStatus is "BACKUP_NOT_CREATED" or "DAILY_BACKUP_DUE"?1:0;
        return new{status=code==0?"READY":"DEGRADED",code,version="0.1.0",database="ok",operator_provisioned=operatorProvisioned,backup_status=backupStatus,
            normative_engine="DESACTIVADO",sink="OUT_OF_SCOPE",transport="stdio"};
    }

    private object ListSources(JsonElement args)
    {
        using var c=store.Open();using var cmd=c.CreateCommand();
        int limit=args.TryGetProperty("limit",out var l)?Math.Clamp(l.GetInt32(),1,100):100;
        cmd.CommandText="SELECT source_id,repository_uri,canonical_path,ref_name,commit_id,git_blob_sha,content_sha256,captured_at_utc,verification_status,freshness_status FROM canonical_sources ORDER BY source_id LIMIT $limit;";
        cmd.Parameters.AddWithValue("$limit",limit);
        using var rd=cmd.ExecuteReader();var items=new List<object>();
        while(rd.Read())items.Add(new{source_id=rd.GetString(0),repository_uri=rd.GetString(1),canonical_path=rd.GetString(2),ref_name=rd.GetString(3),commit_id=rd.GetString(4),git_blob_sha=rd.IsDBNull(5)?null:rd.GetString(5),content_sha256=rd.GetString(6),captured_at_utc=rd.GetString(7),verification_status=rd.GetString(8),freshness_status=rd.GetString(9)});
        return new{count=items.Count,sources=items};
    }

    private object ReadSource(JsonElement args)
    {
        string sourceId=GetRequired(args,"source_id");
        using var c=store.Open();var inst=SqliteStore.GetInstallation(c)??throw new InvalidOperationException("INSTALLATION_NOT_INITIALIZED");
        using var cmd=c.CreateCommand();
        cmd.CommandText="SELECT repository_uri,canonical_path,ref_name,commit_id,git_blob_sha,content_sha256,captured_at_utc,verification_status,freshness_status,content_ciphertext,content_nonce,authentication_tag,wrapped_dek,dek_id,crypto_version,key_version,aad_version FROM canonical_sources WHERE source_id=$id;";
        cmd.Parameters.AddWithValue("$id",sourceId);
        using var rd=cmd.ExecuteReader();if(!rd.Read())throw new InvalidOperationException("SOURCE_NOT_FOUND");
        var meta=new{repository_uri=rd.GetString(0),canonical_path=rd.GetString(1),ref_name=rd.GetString(2),commit_id=rd.GetString(3),git_blob_sha=rd.IsDBNull(4)?null:rd.GetString(4),content_sha256=rd.GetString(5),captured_at_utc=rd.GetString(6),verification_status=rd.GetString(7),freshness_status=rd.GetString(8)};
        var enc=new EncryptedValue((byte[])rd[9],(byte[])rd[10],(byte[])rd[11],(byte[])rd[12],rd.GetString(13),rd.GetString(5),rd.GetInt32(14),rd.GetInt32(15),rd.GetInt32(16));
        rd.Close();
        byte[] plaintext=CryptoBox.Decrypt(enc,inst.InstallationId,"canonical-source",sourceId);
        try{return new{source_id=sourceId,metadata=meta,content=Encoding.UTF8.GetString(plaintext)};}
        finally{CryptographicOperations.ZeroMemory(plaintext);}
    }

    private object GetCycle(string cycleId)
    {
        using var c=store.Open();
        object cycle;
        using(var cmd=c.CreateCommand())
        {
            cmd.CommandText="SELECT cycle_id,project_ref,conversation_ref,state,operator_sid,created_at_utc,updated_at_utc FROM cycles WHERE cycle_id=$id;";
            cmd.Parameters.AddWithValue("$id",cycleId);using var rd=cmd.ExecuteReader();
            if(!rd.Read())throw new InvalidOperationException("CYCLE_NOT_FOUND");
            cycle=new{cycle_id=rd.GetString(0),project_ref=rd.IsDBNull(1)?null:rd.GetString(1),conversation_ref=rd.IsDBNull(2)?null:rd.GetString(2),state=rd.GetString(3),operator_sid=rd.GetString(4),created_at_utc=rd.GetString(5),updated_at_utc=rd.GetString(6)};
        }
        var classifications=new List<object>();
        using(var cmd=c.CreateCommand())
        {
            cmd.CommandText="SELECT principle_id,classification,justification,evidence_refs_json,created_at_utc FROM classifications WHERE cycle_id=$id ORDER BY principle_id;";
            cmd.Parameters.AddWithValue("$id",cycleId);using var rd=cmd.ExecuteReader();
            while(rd.Read())classifications.Add(new{principle_id=rd.GetString(0),classification=rd.GetString(1),justification=rd.GetString(2),evidence_refs=JsonDocument.Parse(rd.GetString(3)).RootElement.Clone(),created_at_utc=rd.GetString(4)});
        }
        object? selection=null;
        using(var cmd=c.CreateCommand())
        {
            cmd.CommandText="SELECT selection_sha256,principle_ids_json,created_at_utc FROM selections WHERE cycle_id=$id;";
            cmd.Parameters.AddWithValue("$id",cycleId);using var rd=cmd.ExecuteReader();
            if(rd.Read())selection=new{selection_sha256=rd.GetString(0),principle_ids=JsonDocument.Parse(rd.GetString(1)).RootElement.Clone(),created_at_utc=rd.GetString(2)};
        }
        return new{cycle,classifications,selection};
    }

    private object GetOperationStatus(string requestId)
    {
        using var c=store.Open();using var cmd=c.CreateCommand();
        cmd.CommandText="SELECT request_id,operation_id,attempt_id,operation_type,target_type,target_id,cycle_id,payload_sha256,status,created_at_utc,expires_at_utc FROM operation_requests WHERE request_id=$id;";
        cmd.Parameters.AddWithValue("$id",requestId);using var rd=cmd.ExecuteReader();if(!rd.Read())throw new InvalidOperationException("REQUEST_NOT_FOUND");
        return new{request_id=rd.GetString(0),operation_id=rd.GetString(1),attempt_id=rd.GetString(2),operation_type=rd.GetString(3),target_type=rd.GetString(4),target_id=rd.GetString(5),cycle_id=rd.IsDBNull(6)?null:rd.GetString(6),payload_sha256=rd.GetString(7),status=rd.GetString(8),created_at_utc=rd.GetString(9),expires_at_utc=rd.GetString(10)};
    }

    private object GetReceipt(string receiptId)
    {
        using var c=store.Open();using var cmd=c.CreateCommand();
        cmd.CommandText="SELECT receipt_json,payload_sha256,signature,signing_key_id FROM receipts WHERE receipt_id=$id;";
        cmd.Parameters.AddWithValue("$id",receiptId);using var rd=cmd.ExecuteReader();if(!rd.Read())throw new InvalidOperationException("RECEIPT_NOT_FOUND");
        string json=rd.GetString(0),hash=rd.GetString(1);byte[] sig=(byte[])rd[2];string keyId=rd.GetString(3);rd.Close();
        using var pub=c.CreateCommand();pub.CommandText="SELECT public_key FROM key_metadata WHERE key_id=$id AND status='ACTIVE';";pub.Parameters.AddWithValue("$id",keyId);
        byte[] publicKey=(byte[]?)pub.ExecuteScalar()??throw new CryptographicException("RECEIPT_PUBLIC_KEY_NOT_FOUND");
        byte[] bytes=Encoding.UTF8.GetBytes(json);
        string actual=Convert.ToHexStringLower(SHA256.HashData(bytes));
        bool hashOk=actual==hash;
        bool signatureOk=hashOk&&ReceiptSigner.Verify(publicKey,bytes,sig);
        return new{receipt=JsonDocument.Parse(json).RootElement.Clone(),payload_sha256=hash,signature=Convert.ToBase64String(sig),signing_key_id=keyId,hash_valid=hashOk,signature_valid=signatureOk,public_key=Convert.ToBase64String(publicKey)};
    }

    private object ListEvents(string cycleId,int limit)
    {
        using var c=store.Open();
        var chain=EventChain.VerifyAll(c);
        using var cmd=c.CreateCommand();
        cmd.CommandText="SELECT event_sequence,event_id,attempt_id,event_type,actor_type,actor_ref,payload_sha256,previous_event_hash,event_hash,created_at_utc FROM events WHERE cycle_id=$cycle ORDER BY event_sequence LIMIT $limit;";
        cmd.Parameters.AddWithValue("$cycle",cycleId);cmd.Parameters.AddWithValue("$limit",limit);using var rd=cmd.ExecuteReader();var events=new List<object>();
        while(rd.Read())events.Add(new{sequence=rd.GetInt64(0),event_id=rd.GetString(1),attempt_id=rd.IsDBNull(2)?null:rd.GetString(2),event_type=rd.GetString(3),actor_type=rd.GetString(4),actor_ref=rd.GetString(5),payload_sha256=rd.GetString(6),previous_event_hash=rd.IsDBNull(7)?null:rd.GetString(7),event_hash=rd.GetString(8),created_at_utc=rd.GetString(9)});
        return new{cycle_id=cycleId,count=events.Count,events,chain_valid=chain.Valid,verified_through_sequence=chain.VerifiedThrough,chain_error=chain.Error};
    }

    private object ListTelemetry(int limit)
    {
        using var c=store.Open();using var cmd=c.CreateCommand();
        cmd.CommandText="SELECT event_id,cycle_id,attempt_id,event_type,source,payload_redacted_json,payload_sha256,status,occurred_at_utc FROM telemetry_events ORDER BY occurred_at_utc DESC LIMIT $limit;";
        cmd.Parameters.AddWithValue("$limit",limit);
        using var rd=cmd.ExecuteReader();var items=new List<object>();
        while(rd.Read())items.Add(new{event_id=rd.GetString(0),cycle_id=rd.IsDBNull(1)?null:rd.GetString(1),attempt_id=rd.IsDBNull(2)?null:rd.GetString(2),event_type=rd.GetString(3),source=rd.GetString(4),payload_redacted=JsonDocument.Parse(rd.GetString(5)).RootElement.Clone(),payload_sha256=rd.GetString(6),status=rd.GetString(7),occurred_at_utc=rd.GetString(8)});
        return new{count=items.Count,delivery="LOCAL_ONLY",sink="OUT_OF_SCOPE",events=items};
    }

    private static string GetRequired(JsonElement args,string key)=>args.TryGetProperty(key,out var v)&&v.ValueKind==JsonValueKind.String&&!string.IsNullOrWhiteSpace(v.GetString())?v.GetString()!:throw new McpException(-32602,$"{key} is required");
    private static string Sanitize(string input)=>input.Replace("\r"," ").Replace("\n"," ").Replace("\t"," ");

    private static async Task WriteResult(JsonElement id,object? result,CancellationToken ct)
    {
        var json=JsonSerializer.Serialize(new{jsonrpc="2.0",id,result},new JsonSerializerOptions{PropertyNamingPolicy=JsonNamingPolicy.CamelCase});
        await Console.Out.WriteLineAsync(json.AsMemory(),ct);await Console.Out.FlushAsync(ct);
    }

    private static async Task WriteError(JsonElement root,string code,string message,CancellationToken ct)
    {
        JsonElement id=root.TryGetProperty("id",out var value)?value:JsonDocument.Parse("null").RootElement;
        object numeric=int.TryParse(code,out int n)?n: -32000;
        var obj=new{jsonrpc="2.0",id,error=new{code=numeric,message,data=new{symbolic_code=code}}};
        await Console.Out.WriteLineAsync(JsonSerializer.Serialize(obj).AsMemory(),ct);await Console.Out.FlushAsync(ct);
    }
    private static async Task WriteRawError(string raw,CancellationToken ct){await Console.Out.WriteLineAsync(raw.AsMemory(),ct);await Console.Out.FlushAsync(ct);}
    private sealed class McpException(int code,string message):Exception(message){public int Code{get;}=code;}
}
