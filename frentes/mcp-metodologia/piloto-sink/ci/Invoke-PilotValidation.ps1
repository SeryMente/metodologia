$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$diagnosticRoot = if ($env:RUNNER_TEMP) { $env:RUNNER_TEMP } else { [System.IO.Path]::GetTempPath() }
$diagnosticDir = Join-Path $diagnosticRoot 'mcp-ocp-p004-pilot-diagnostics'
New-Item -ItemType Directory -Force -Path $diagnosticDir | Out-Null
$transcriptPath = Join-Path $diagnosticDir 'transcript.log'
Start-Transcript -Path $transcriptPath -Force | Out-Null

function Invoke-DotnetCaptured {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string[]]$Arguments
    )

    $logPath = Join-Path $diagnosticDir ($Name + '.log')
    Write-Host "=== dotnet $($Arguments -join ' ') ==="
    & dotnet @Arguments 2>&1 | Tee-Object -FilePath $logPath
    $exitCode = $LASTEXITCODE
    "EXIT_CODE=$exitCode" | Tee-Object -FilePath $logPath -Append
    if ($exitCode -ne 0) {
        throw "DOTNET_STEP_FAILED:${Name}:${exitCode}"
    }
}

try {
    Invoke-DotnetCaptured -Name 'dotnet-info' -Arguments @('--info')
    Invoke-DotnetCaptured -Name 'restore' -Arguments @('restore', 'tests/OcpMcp.Pilot.Tests/OcpMcp.Pilot.Tests.csproj')
    Invoke-DotnetCaptured -Name 'build-server' -Arguments @('build', 'src/OcpMcp/OcpMcp.csproj', '--configuration', 'Release', '--no-restore')
    Invoke-DotnetCaptured -Name 'build-tests' -Arguments @('build', 'tests/OcpMcp.Pilot.Tests/OcpMcp.Pilot.Tests.csproj', '--configuration', 'Release', '--no-restore')
    Invoke-DotnetCaptured -Name 'unit-contract-tests' -Arguments @('run', '--project', 'tests/OcpMcp.Pilot.Tests/OcpMcp.Pilot.Tests.csproj', '--configuration', 'Release', '--no-build')

    $assemblyPath = Join-Path (Get-Location).Path 'src/OcpMcp/bin/Release/net10.0/OcpMcp.dll'
    if (-not (Test-Path -LiteralPath $assemblyPath -PathType Leaf)) {
        throw "PILOT_ASSEMBLY_MISSING:$assemblyPath"
    }

    $processInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $processInfo.FileName = 'dotnet'
    $processInfo.WorkingDirectory = (Get-Location).Path
    $processInfo.UseShellExecute = $false
    $processInfo.RedirectStandardInput = $true
    $processInfo.RedirectStandardOutput = $true
    $processInfo.RedirectStandardError = $true
    $processInfo.ArgumentList.Add($assemblyPath)
    $processInfo.ArgumentList.Add('serve')
    $processInfo.ArgumentList.Add('--repo-root')
    $repositoryRoot = (Resolve-Path (Join-Path (Get-Location).Path '..\..')).Path
    $processInfo.ArgumentList.Add($repositoryRoot)

    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $processInfo
    if (-not $process.Start()) { throw 'PILOT_PROCESS_START_FAILED' }

    $stdoutTask = $process.StandardOutput.ReadToEndAsync()
    $stderrTask = $process.StandardError.ReadToEndAsync()

    $requests = @(
        '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-25","capabilities":{},"clientInfo":{"name":"mcp-ocp-ci-smoke","version":"1.0.0"}}}'
        '{"jsonrpc":"2.0","method":"notifications/initialized"}'
        '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}'
        '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"sink_principle","arguments":{"principle_id":"P004"}}}'
    )
    foreach ($request in $requests) { $process.StandardInput.WriteLine($request) }
    $process.StandardInput.Close()

    if (-not $process.WaitForExit(30000)) {
        $process.Kill($true)
        throw 'PILOT_STDIO_SMOKE_TIMEOUT'
    }

    $stdout = $stdoutTask.GetAwaiter().GetResult()
    $stderr = $stderrTask.GetAwaiter().GetResult()
    $stdoutPath = Join-Path $diagnosticDir 'stdio-stdout.jsonl'
    $stderrPath = Join-Path $diagnosticDir 'stdio-stderr.log'
    [System.IO.File]::WriteAllText($stdoutPath, $stdout, [System.Text.UTF8Encoding]::new($false))
    [System.IO.File]::WriteAllText($stderrPath, $stderr, [System.Text.UTF8Encoding]::new($false))

    if ($process.ExitCode -ne 0) { throw "PILOT_STDIO_EXIT_CODE:$($process.ExitCode)" }
    $responses = @(
        $stdout -split "\r?\n" |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
        ForEach-Object { ConvertFrom-Json -InputObject $_ -Depth 32 }
    )
    if ($responses.Count -ne 3) { throw "PILOT_STDIO_RESPONSE_COUNT:$($responses.Count)" }

    $initialize = $responses | Where-Object { $_.id -eq 1 } | Select-Object -First 1
    $discovery = $responses | Where-Object { $_.id -eq 2 } | Select-Object -First 1
    $call = $responses | Where-Object { $_.id -eq 3 } | Select-Object -First 1
    if (-not $initialize -or $initialize.result.protocolVersion -ne '2025-11-25') { throw 'PILOT_STDIO_INITIALIZE_FAILED' }
    if (-not $discovery -or $discovery.result.tools.Count -ne 1 -or $discovery.result.tools[0].name -ne 'sink_principle') { throw 'PILOT_STDIO_TOOL_DISCOVERY_FAILED' }
    if (-not $call -or $call.result.isError -ne $false -or $call.result.content.Count -ne 1) { throw 'PILOT_STDIO_SINK_CALL_FAILED' }

    $sinkResult = ConvertFrom-Json -InputObject $call.result.content[0].text -Depth 32
    $expectedText = 'No finjas capacidades, datos, resultados ni certezas, ni declares límites sin verificar con herramientas. Marca tu certeza y nombra los huecos sin rellenarlos. Precedencia absoluta sobre la exhaustividad y el buen trato.'
    if ($sinkResult.principleId -ne 'P004') { throw 'PILOT_STDIO_PRINCIPLE_ID_MISMATCH' }
    if ($sinkResult.normativeText -ne $expectedText) { throw 'PILOT_STDIO_NORMATIVE_TEXT_MISMATCH' }
    if ($sinkResult.dugVersion -ne 'v388' -or $sinkResult.dugSignature -ne 'NX-388m') { throw 'PILOT_STDIO_DUG_VERSION_MISMATCH' }
    if ($sinkResult.commitId -ne '3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c' -or $sinkResult.gitBlobSha -ne '4db0ebadfd1e48b2bdec9236ba7f344921e4a865') { throw 'PILOT_STDIO_DUG_PIN_MISMATCH' }
    if ($sinkResult.sourceSha256.Length -ne 64 -or $sinkResult.principleTextSha256.Length -ne 64) { throw 'PILOT_STDIO_SHA256_MISSING' }
    if (-not $stderr.Contains('"eventType":"SINK_READ_SUCCESS"')) { throw 'PILOT_STDIO_SUCCESS_EVENT_MISSING' }

    'PASS: real executable STDIO initialize/list/call/P004/EOF smoke' | Tee-Object -FilePath (Join-Path $diagnosticDir 'smoke-summary.log')
    'PILOT_CI_RESULT=PASS' | Tee-Object -FilePath (Join-Path $diagnosticDir 'result.txt')
}
catch {
    $message = $_ | Out-String
    $message | Tee-Object -FilePath (Join-Path $diagnosticDir 'failure.txt')
    'PILOT_CI_RESULT=FAIL' | Tee-Object -FilePath (Join-Path $diagnosticDir 'result.txt')
    throw
}
finally {
    Stop-Transcript | Out-Null
}
