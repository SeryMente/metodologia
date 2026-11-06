$ErrorActionPreference = 'Continue'
Register-EngineEvent -SourceIdentifier PowerShell.OnError -Action {
    Write-Host ("[ENGINE ERROR] " + $Event.SourceEventArgs.Message) -ForegroundColor Red
} | Out-Null

$script:Passed = 0
$script:Failed = 0
function Assert-True([string]$Name,[bool]$Condition,[string]$Detail="") {
    if($Condition){$script:Passed++;Write-Output "PASS $Name $Detail"}
    else{$script:Failed++;Write-Output "FAIL $Name $Detail"}
}
function Send-Mcp([System.Diagnostics.Process]$Process,[object]$Message) {
    $line=$Message|ConvertTo-Json -Depth 20 -Compress
    $Process.StandardInput.WriteLine($line)
    $Process.StandardInput.Flush()
    $response=$Process.StandardOutput.ReadLine()
    if([string]::IsNullOrWhiteSpace($response)){throw "MCP_EMPTY_RESPONSE for $($Message.method)"}
    return ($response|ConvertFrom-Json)
}
function Get-GitBytes([string]$Repo,[string]$Blob) {
    $p=[System.Diagnostics.Process]::new()
    $p.StartInfo=[System.Diagnostics.ProcessStartInfo]::new()
    $p.StartInfo.FileName="git"
    $p.StartInfo.Arguments="cat-file blob $Blob"
    $p.StartInfo.WorkingDirectory=$Repo
    $p.StartInfo.UseShellExecute=$false
    $p.StartInfo.RedirectStandardOutput=$true
    $p.StartInfo.RedirectStandardError=$true
    if(-not $p.Start()){throw "git cat-file start failed"}
    $ms=[System.IO.MemoryStream]::new()
    $copy=$p.StandardOutput.BaseStream.CopyToAsync($ms)
    $stderr=$p.StandardError.ReadToEnd()
    [void]$copy.GetAwaiter().GetResult()
    $p.WaitForExit()
    if($p.ExitCode -ne 0){throw "git cat-file failed: $stderr"}
    return ,$ms.ToArray()
}

try {
    $OcpRoot=Split-Path -Parent $PSScriptRoot
    $RepoRoot=(Resolve-Path (Join-Path $OcpRoot "..\..")).Path
    $Exe=Join-Path $OcpRoot "artifacts\publish\0.1.0\OcpMcp.exe"
    if(-not (Test-Path $Exe)){throw "Published executable missing"}
    $usageOutput=& $Exe 2>&1
    $usageExit=$LASTEXITCODE
    $usageText=$usageOutput -join " "
    Assert-True "PPR_CLI_COMMANDS_AVAILABLE" ($usageExit -eq 64 -and $usageText.Contains("portable-export --output") -and $usageText.Contains("portable-restore --package")) "exit=$usageExit"
    $buildManifestPath=Join-Path $OcpRoot "artifacts\publish\0.1.0\build-manifest.json"
    $buildManifest=Get-Content -Raw $buildManifestPath|ConvertFrom-Json
    Assert-True "MANIFEST_ENTRYPOINT_ARGS" ($buildManifest.entrypoint -eq "OcpMcp.exe" -and $buildManifest.args.Count -eq 1 -and $buildManifest.args[0] -eq "serve")
    $componentOk=$true
    foreach($component in $buildManifest.components){
        $componentPath=Join-Path (Split-Path $buildManifestPath -Parent) $component.path
        if(-not (Test-Path $componentPath)){$componentOk=$false;break}
        $componentHash=(Get-FileHash -Algorithm SHA256 $componentPath).Hash.ToLowerInvariant()
        if($componentHash -ne $component.sha256){$componentOk=$false;break}
    }
    Assert-True "MANIFEST_COMPONENT_HASHES" $componentOk

    $env:OCPMCP_TEST_MODE="1"
    $env:OCPMCP_TEST_DATA_ROOT="C:\Temp\OcpMcpBuild\SmokeData"
    if(Test-Path $env:OCPMCP_TEST_DATA_ROOT){Remove-Item -LiteralPath $env:OCPMCP_TEST_DATA_ROOT -Recurse -Force}
    $notReadyRaw=& $Exe diagnose --json
    $notReadyExit=$LASTEXITCODE
    $notReady=$notReadyRaw|ConvertFrom-Json
    Assert-True "DIAGNOSE_NOT_READY_CODE_2" ($notReady.status -eq "NOT_READY" -and $notReadyExit -eq 2) "exit=$notReadyExit"

    # A piped confirmation must never register the local operator trust root.
    $sid=[System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
    $pipeOutput=("REGISTER "+$sid) | & $Exe provision-operator 2>&1
    $pipeExit=$LASTEXITCODE
    Assert-True "OPERATOR_APPROVAL_REQUIRES_INTERACTIVE_CONSOLE" ($pipeExit -eq 2 -and ($pipeOutput -join " ") -match "INTERACTIVE_OPERATOR_CONSOLE_REQUIRED") "exit=$pipeExit"

    & $Exe import-sources --repo-root $RepoRoot
    Assert-True "SOURCE_IMPORT_EXIT" ($LASTEXITCODE -eq 0) "exit=$LASTEXITCODE"

    $db=Join-Path $env:OCPMCP_TEST_DATA_ROOT "data\ocp-mcp.sqlite"
    Assert-True "SQLITE_CREATED" (Test-Path $db)
    $degradedRaw=& $Exe diagnose --json
    $degradedExit=$LASTEXITCODE
    $degraded=$degradedRaw|ConvertFrom-Json
    Assert-True "DIAGNOSE_DEGRADED_CODE_1" ($degraded.status -eq "DEGRADED" -and $degradedExit -eq 1) "exit=$degradedExit"

    $manifest=Get-Content -Raw (Join-Path $OcpRoot "resources\initial-sources.manifest.json")|ConvertFrom-Json
    $source=$manifest.sources|Where-Object source_id -eq "metodologia.dug.canonical"|Select-Object -First 1
    $clear=Get-GitBytes -Repo $RepoRoot -Blob $source.git_blob_sha
    $probe=$clear[0..([Math]::Min(63,$clear.Length-1))]
    $dbBytes=[System.IO.File]::ReadAllBytes($db)
    $latin1=[System.Text.Encoding]::GetEncoding(28591)
    $found=$latin1.GetString($dbBytes).Contains($latin1.GetString($probe))
    Assert-True "CANONICAL_SOURCE_NOT_PLAINTEXT_IN_SQLITE" (-not $found)

    $psi=[System.Diagnostics.ProcessStartInfo]::new()
    $psi.FileName=$Exe
    $psi.Arguments="serve"
    $psi.UseShellExecute=$false
    $psi.CreateNoWindow=$true
    $psi.RedirectStandardInput=$true
    $psi.RedirectStandardOutput=$true
    $psi.RedirectStandardError=$true
    $psi.Environment["OCPMCP_TEST_DATA_ROOT"]=$env:OCPMCP_TEST_DATA_ROOT
    $proc=[System.Diagnostics.Process]::new()
    $proc.StartInfo=$psi
    if(-not $proc.Start()){throw "Could not start OCP MCP stdio server"}
    Start-Sleep -Milliseconds 700

    $init=Send-Mcp $proc @{jsonrpc="2.0";id=1;method="initialize";params=@{protocolVersion="2025-06-18";capabilities=@{};clientInfo=@{name="OCP-MCP-Smoke";version="1"}}}
    Assert-True "STDIO_INITIALIZE" ($init.result.serverInfo.name -eq "ocp-mcp") "server=$($init.result.serverInfo.name)"
    $proc.StandardInput.WriteLine('{"jsonrpc":"2.0","method":"notifications/initialized"}')
    $proc.StandardInput.Flush()

    $tools=Send-Mcp $proc @{jsonrpc="2.0";id=2;method="tools/list";params=@{}}
    $names=@($tools.result.tools|ForEach-Object name)
    Assert-True "MCP_TOOLS_LIST" ($names -contains "get_health" -and $names -contains "prepare_operation" -and $names -contains "get_principle_catalog" -and $names -notcontains "read_canonical_source") ("count="+$names.Count)

    $health=Send-Mcp $proc @{jsonrpc="2.0";id=3;method="tools/call";params=@{name="get_health";arguments=@{}}}
    $healthData=$health.result.content[0].text|ConvertFrom-Json
    Assert-True "HEALTH_READY" ($healthData.status -eq "READY" -and $healthData.code -eq 0) ("status="+$healthData.status)
    Assert-True "HEALTH_REPORTS_NORMATIVE_BLOCK" ($healthData.normative_engine -eq "DESACTIVADO" -and $healthData.principle_selection_readiness -eq "BLOCKED_OCPMSP" -and $healthData.missing_principle_metadata.Count -eq 4)

    $sources=Send-Mcp $proc @{jsonrpc="2.0";id=4;method="tools/call";params=@{name="list_canonical_sources";arguments=@{}}}
    $sourceData=$sources.result.content[0].text|ConvertFrom-Json
    Assert-True "CANONICAL_SOURCES_LIST" ($sourceData.count -ge 2) ("count="+$sourceData.count)

    $catalog=Send-Mcp $proc @{jsonrpc="2.0";id=5;method="tools/call";params=@{name="get_principle_catalog";arguments=@{}}}
    $catalogData=$catalog.result.content[0].text|ConvertFrom-Json
    $expectedCnp=@("P001","P004","P005","P038","P043")
    $actualCnp=@($catalogData.cnp_members|Sort-Object)
    $cnpMatch=(@(Compare-Object $expectedCnp $actualCnp).Count -eq 0)
    Assert-True "CANONICAL_43_PRINCIPLE_CATALOG" ($catalogData.declared_count -eq 43 -and $catalogData.principles.Count -eq 43)
    Assert-True "CANONICAL_CNP_MEMBERS" $cnpMatch
    Assert-True "PRINCIPLE_METADATA_FAIL_CLOSED" ($catalogData.metadata_complete -eq $false -and $catalogData.missing_metadata.Count -eq 4)
    Assert-True "NORMATIVE_TEXT_NOT_EXPOSED_VIA_CATALOG" ($catalogData.normative_text_disclosure -eq "WITHHELD_UNTIL_GOVERNED_RELEASE" -and -not ($catalogData.principles[0].PSObject.Properties.Name -contains "normative_text"))

    $prepare=Send-Mcp $proc @{jsonrpc="2.0";id=6;method="tools/call";params=@{name="prepare_operation";arguments=@{operation_type="OPEN_CYCLE";parameters=@{project_ref="smoke-test";conversation_ref="isolated"}}}}
    $pending=$prepare.result.content[0].text|ConvertFrom-Json
    Assert-True "PREPARE_REQUEST_PENDING" ($pending.status -eq "PENDING_OPERATOR_APPROVAL" -and -not [string]::IsNullOrWhiteSpace($pending.request_id))

    $execute=Send-Mcp $proc @{jsonrpc="2.0";id=7;method="tools/call";params=@{name="execute_operation";arguments=@{request_id=$pending.request_id}}}
    $symbolic=$execute.error.data.symbolic_code
    Assert-True "WRITE_BLOCKED_WITHOUT_GRANT" ($symbolic -eq "AUTHORIZATION_UNAVAILABLE") "error=$symbolic"

    $status=Send-Mcp $proc @{jsonrpc="2.0";id=8;method="tools/call";params=@{name="get_operation_status";arguments=@{request_id=$pending.request_id}}}
    $statusData=$status.result.content[0].text|ConvertFrom-Json
    Assert-True "PENDING_STATUS_READABLE" ($statusData.status -eq "PENDING_OPERATOR_APPROVAL")

    $cycleId=$pending.summary.cycle_id
    $events=Send-Mcp $proc @{jsonrpc="2.0";id=9;method="tools/call";params=@{name="list_cycle_events";arguments=@{cycle_id=$cycleId;limit=20}}}
    $eventsData=$events.result.content[0].text|ConvertFrom-Json
    Assert-True "EVENT_CHAIN_VERIFIED" ($eventsData.chain_valid -eq $true -and $eventsData.count -ge 1) ("verified_through="+$eventsData.verified_through_sequence)

    $telemetry=Send-Mcp $proc @{jsonrpc="2.0";id=10;method="tools/call";params=@{name="list_telemetry_events";arguments=@{limit=20}}}
    $telemetryData=$telemetry.result.content[0].text|ConvertFrom-Json
    Assert-True "LOCAL_TELEMETRY_READABLE" ($telemetryData.delivery -eq "LOCAL_ONLY" -and $telemetryData.count -gt 0)

    $proc.StandardInput.Close()
    if(-not $proc.WaitForExit(10000)){ $proc.Kill(); throw "Server did not exit on stdio EOF" }
    Assert-True "STDIO_EOF_SHUTDOWN" ($proc.ExitCode -eq 0) "exit=$($proc.ExitCode)"
    $stderr=$proc.StandardError.ReadToEnd()
    if($stderr -match "STARTUP_BACKUP_FAILED"){Assert-True "STARTUP_BACKUP" $false $stderr}
    else{Assert-True "STARTUP_BACKUP" $true}
    $backupFolder=Join-Path $env:OCPMCP_TEST_DATA_ROOT "backups"
    $backupFiles=@(Get-ChildItem -LiteralPath $backupFolder -Filter "*.ocpbak" -ErrorAction SilentlyContinue)
    Assert-True "BACKUP_PATH_AND_PACKAGE" ($backupFiles.Count -ge 1) ("count="+$backupFiles.Count)
    Assert-True "BACKUP_NOT_NESTED_IN_DATA" (-not (Test-Path (Join-Path $env:OCPMCP_TEST_DATA_ROOT "data\backups")))

    $preUpdateOutput=& $Exe backup --reason pre-update
    $preUpdateExit=$LASTEXITCODE
    $preUpdate=$preUpdateOutput|ConvertFrom-Json
    Assert-True "PRE_UPDATE_BACKUP" ($preUpdateExit -eq 0 -and $preUpdate.status -eq "VERIFIED") "exit=$preUpdateExit"
    $restoreOutput=& $Exe restore --backup-id $preUpdate.backup_id
    $restoreExit=$LASTEXITCODE
    $restoreResult=$restoreOutput|ConvertFrom-Json
    Assert-True "BACKUP_RESTORE" ($restoreExit -eq 0 -and $restoreResult.status -eq "RESTORED") "exit=$restoreExit"
    $afterRestoreRaw=& $Exe diagnose --json
    $afterRestoreExit=$LASTEXITCODE
    $afterRestore=$afterRestoreRaw|ConvertFrom-Json
    Assert-True "READINESS_AFTER_RESTORE" ($afterRestore.status -eq "READY" -and $afterRestoreExit -eq 0) "exit=$afterRestoreExit"
}
catch {
    $script:Failed++
    Write-Output ("FAIL SMOKE_EXCEPTION " + $_.Exception.Message)
}
finally {
    if($proc -and -not $proc.HasExited){$proc.Kill()}
    $env:OCPMCP_TEST_DATA_ROOT=$null
    $env:OCPMCP_TEST_MODE=$null
}
Write-Output "TEST_SUMMARY PASS=$script:Passed FAIL=$script:Failed"
if($script:Failed -gt 0){exit 1}else{exit 0}
