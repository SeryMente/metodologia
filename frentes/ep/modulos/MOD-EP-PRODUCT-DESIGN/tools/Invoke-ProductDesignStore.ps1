[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('Initialize','SaveCycle','Search','RebuildIndex','Verify','RestoreVersion','ListProjects','ShowSession')]
    [string]$Operation,
    [Parameter(Mandatory=$true)]
    [string]$WorkspaceRoot,
    [Parameter(Mandatory=$true)]
    [ValidatePattern('^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$')]
    [string]$TerminalId,
    [string]$PayloadJson = '{}',
    [ValidateRange(1,600)]
    [int]$TimeoutSeconds = 30,
    [switch]$TestMode
)

$ErrorActionPreference = 'Stop'
if ($PSVersionTable.PSVersion.Major -lt 5) {
    throw 'POWERSHELL_5_OR_NEWER_REQUIRED'
}
if ([string]::IsNullOrWhiteSpace($PayloadJson)) {
    throw 'PAYLOAD_JSON_REQUIRED'
}
try {
    $payloadObject = ConvertFrom-Json -InputObject $PayloadJson -ErrorAction Stop
} catch {
    throw "PAYLOAD_JSON_INVALID:$($_.Exception.Message)"
}
if ($null -eq $payloadObject -or $payloadObject -is [System.Array] -or $payloadObject -is [string]) {
    throw 'PAYLOAD_ROOT_MUST_BE_OBJECT'
}

$workspace = [System.IO.Path]::GetFullPath($WorkspaceRoot)
if (-not (Test-Path -LiteralPath $workspace -PathType Container)) {
    throw 'WORKSPACE_ROOT_MUST_ALREADY_EXIST'
}
$workspaceItem = Get-Item -LiteralPath $workspace -Force
if (($workspaceItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0) {
    throw 'WORKSPACE_ROOT_REPARSE_POINT_REJECTED'
}

if ($TestMode) {
    $syntheticRoots = @(
        [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot 'tests\_synthetic_workspace')),
        [System.IO.Path]::GetFullPath((Join-Path $env:TEMP '_ep_product_design_synthetic'))
    )
    $allowedSynthetic = $false
    foreach ($syntheticRoot in $syntheticRoots) {
        $prefix = $syntheticRoot.TrimEnd('\') + '\'
        if ($workspace.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase) -or
            $workspace.Equals($syntheticRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            $allowedSynthetic = $true
            break
        }
    }
    if (-not $allowedSynthetic) {
        throw 'TEST_MODE_WORKSPACE_OUTSIDE_SYNTHETIC_TEST_DIRECTORY'
    }
} else {
    # Production is deliberately closed until EP supplies a machine-verifiable preflight.
    throw 'EP_PROTECTED_WORKSPACE_VERIFIER_NOT_INTEGRATED_TP_02B_PENDING'
}

$enginePath = Join-Path $PSScriptRoot 'product_design_store.py'
if (-not (Test-Path -LiteralPath $enginePath -PathType Leaf)) {
    throw "ENGINE_NOT_FOUND:$enginePath"
}
$python = Get-Command 'py.exe' -ErrorAction SilentlyContinue
if (-not $python) {
    throw 'PYTHON_LAUNCHER_PY_EXE_NOT_FOUND'
}

function Quote-ProcessArgument([string]$Value) {
    $escaped = [regex]::Replace($Value, '(\\*)"', '$1$1\"')
    $escaped = [regex]::Replace($escaped, '(\\+)$', '$1$1')
    return '"' + $escaped + '"'
}

function ConvertTo-JsonAscii([object]$Value) {
    $json = ConvertTo-Json -InputObject $Value -Depth 40 -Compress
    $builder = New-Object System.Text.StringBuilder
    foreach ($character in $json.ToCharArray()) {
        $code = [int][char]$character
        if ($code -gt 127) {
            [void]$builder.Append(('\u' + $code.ToString('x4')))
        } else {
            [void]$builder.Append($character)
        }
    }
    return $builder.ToString()
}

# A UTF-8 file avoids code-page/control-character corruption in redirected stdin on Windows PowerShell 5.1.
$payloadPath = Join-Path $env:TEMP ('pd-payload-' + [guid]::NewGuid().ToString('N') + '.json')
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($payloadPath, $PayloadJson, $utf8NoBom)

$arguments = @(
    '-3', '-B', (Quote-ProcessArgument $enginePath),
    '--operation', (Quote-ProcessArgument $Operation),
    '--workspace-root', (Quote-ProcessArgument $workspace),
    '--terminal-id', (Quote-ProcessArgument $TerminalId),
    '--payload-file', (Quote-ProcessArgument $payloadPath)
)
if ($TestMode) {
    $arguments += '--test-mode'
}
$startInfo = New-Object System.Diagnostics.ProcessStartInfo
$startInfo.FileName = $python.Source
$startInfo.Arguments = ($arguments -join ' ')
$startInfo.WorkingDirectory = $PSScriptRoot
$startInfo.UseShellExecute = $false
$startInfo.CreateNoWindow = $true
$startInfo.RedirectStandardInput = $true
$startInfo.RedirectStandardOutput = $true
$startInfo.RedirectStandardError = $true
$startInfo.StandardOutputEncoding = New-Object System.Text.UTF8Encoding($false)
$startInfo.StandardErrorEncoding = New-Object System.Text.UTF8Encoding($false)

$process = New-Object System.Diagnostics.Process
$process.StartInfo = $startInfo
if (-not $process.Start()) {
    throw 'PYTHON_PROCESS_START_FAILED'
}
try {
    $process.StandardInput.Close()

    # Drain both pipes concurrently to prevent a full stderr buffer from blocking stdout.
    $stdoutTask = $process.StandardOutput.ReadToEndAsync()
    $stderrTask = $process.StandardError.ReadToEndAsync()
    $completed = $process.WaitForExit($TimeoutSeconds * 1000)
    if (-not $completed) {
        $taskkill = Join-Path $env:SystemRoot 'System32\taskkill.exe'
        if (Test-Path -LiteralPath $taskkill) {
            & $taskkill /PID $process.Id /T /F 2>$null | Out-Null
        }
        if (-not $process.HasExited) {
            try { $process.Kill() } catch {}
        }
        [void]$process.WaitForExit(5000)
        throw "PRODUCT_DESIGN_STORE_TIMEOUT:$($TimeoutSeconds)s"
    }
    $stdout = $stdoutTask.GetAwaiter().GetResult()
    $stderr = $stderrTask.GetAwaiter().GetResult()
    if ($process.ExitCode -ne 0) {
        throw "PRODUCT_DESIGN_STORE_FAILED:$($process.ExitCode):$stdout $stderr"
    }
    try {
        $result = $stdout.Trim() | ConvertFrom-Json -ErrorAction Stop
    } catch {
        throw "PRODUCT_DESIGN_STORE_INVALID_STDOUT:$stdout $stderr"
    }
    if (-not $result.ok) {
        throw "PRODUCT_DESIGN_STORE_REJECTED:$($result.error)"
    }
    if ($Operation -eq 'SaveCycle' -and -not $result.index_updated) {
        throw 'PRODUCT_DESIGN_STORE_INDEX_NOT_CONFIRMED'
    }
    # ASCII-escaped JSON is stable across PowerShell 5.1 console/OEM code pages.
    Write-Output (ConvertTo-JsonAscii -Value $result)
} finally {
    $process.Dispose()
    if (Test-Path -LiteralPath $payloadPath) {
        Remove-Item -LiteralPath $payloadPath -Force -ErrorAction SilentlyContinue
    }
}
