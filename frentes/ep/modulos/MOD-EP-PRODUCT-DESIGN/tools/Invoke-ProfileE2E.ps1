[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$PayloadFile,
    [Parameter(Mandatory=$true)][string]$ProfileDirectory,
    [Parameter(Mandatory=$true)][string]$WorkspaceRoot,
    [Parameter(Mandatory=$true)][string]$OutputDirectory,
    [string]$TerminalId = 'TESTMODE-PD'
)
$ErrorActionPreference = 'Stop'
$wrapper = Join-Path $PSScriptRoot 'Invoke-ProductDesignStore.ps1'
$encoding = New-Object System.Text.UTF8Encoding($false)
$commandsPath = Join-Path $OutputDirectory 'rdc-commands.jsonl'
$resultsPath = Join-Path $OutputDirectory 'profiles-e2e-results.json'

function Get-Sha256Text {
    param([string]$Text)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        return ([BitConverter]::ToString($sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Text)))).Replace('-', '')
    } finally { $sha.Dispose() }
}
function Add-JsonLine {
    param([string]$Path, [object]$Value)
    [System.IO.File]::AppendAllText($Path, (ConvertTo-Json -InputObject $Value -Depth 40 -Compress) + [Environment]::NewLine, $encoding)
}
function Write-JsonFile {
    param([string]$Path, [object]$Value)
    [System.IO.File]::WriteAllText($Path, (ConvertTo-Json -InputObject $Value -Depth 40), $encoding)
}
function Invoke-Store {
    param([string]$Operation, [string]$Agent, [object]$Payload)
    $payloadJson = ConvertTo-Json -InputObject $Payload -Depth 40 -Compress
    $payloadHash = Get-Sha256Text -Text $payloadJson
    $commandText = '& "' + $wrapper + '" -Operation ' + $Operation + ' -WorkspaceRoot "' + $WorkspaceRoot + '" -TerminalId ' + $TerminalId + ' -TimeoutSeconds 30 -TestMode -PayloadJson <sha256:' + $payloadHash + '>'
    $started = [DateTime]::UtcNow
    try {
        $output = & $wrapper -Operation $Operation -WorkspaceRoot $WorkspaceRoot -TerminalId $TerminalId -TimeoutSeconds 30 -TestMode -PayloadJson $payloadJson
        $raw = (@($output) -join [Environment]::NewLine).Trim()
        if ([string]::IsNullOrWhiteSpace($raw)) { throw "EMPTY_WRAPPER_OUTPUT:$($Operation)" }
        $result = $raw | ConvertFrom-Json -ErrorAction Stop
        if ($result.ok -ne $true) { throw "STORE_OPERATION_NOT_OK:$($Operation):$($result.error)" }
        Add-JsonLine $commandsPath ([pscustomobject]@{
            timestamp_utc=$started.ToString('o'); channel='RDC'; kind='Invoke-ProductDesignStore'
            agent=$Agent; operation=$Operation; command=$commandText; payload_sha256=$payloadHash
            status='PASS'; output=$result
        })
        return $result
    } catch {
        Add-JsonLine $commandsPath ([pscustomobject]@{
            timestamp_utc=$started.ToString('o'); channel='RDC'; kind='Invoke-ProductDesignStore'
            agent=$Agent; operation=$Operation; command=$commandText; payload_sha256=$payloadHash
            status='FAIL'; error=$_.Exception.Message
        })
        throw
    }
}

if (-not (Test-Path -LiteralPath $PayloadFile -PathType Leaf)) { throw "PAYLOAD_FILE_NOT_FOUND:$PayloadFile" }
if (-not (Test-Path -LiteralPath $ProfileDirectory -PathType Container)) { throw "PROFILE_DIRECTORY_NOT_FOUND:$ProfileDirectory" }
[System.IO.Directory]::CreateDirectory($OutputDirectory) | Out-Null
[System.IO.Directory]::CreateDirectory($WorkspaceRoot) | Out-Null
$workspaceResolved = (Get-Item -LiteralPath $WorkspaceRoot -Force).FullName
$tempRoot = [System.IO.Path]::GetFullPath((Join-Path $env:TEMP '_ep_product_design_synthetic')).TrimEnd('\') + '\'
if (-not $workspaceResolved.StartsWith($tempRoot, [System.StringComparison]::OrdinalIgnoreCase)) { throw 'E2E_WORKSPACE_OUTSIDE_TESTMODE_ROOT' }
$rootItem = Get-Item -LiteralPath $workspaceResolved -Force
if (($rootItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'E2E_WORKSPACE_REPARSE_POINT_REJECTED' }
if (Test-Path -LiteralPath $commandsPath) { Remove-Item -LiteralPath $commandsPath -Force }

$payloadData = Get-Content -LiteralPath $PayloadFile -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop
$payloadFileHash = (Get-FileHash -LiteralPath $PayloadFile -Algorithm SHA256).Hash
$rdcInvocation = 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "' + $MyInvocation.MyCommand.Path + '" -PayloadFile "' + $PayloadFile + '" -ProfileDirectory "' + $ProfileDirectory + '" -WorkspaceRoot "' + $WorkspaceRoot + '" -OutputDirectory "' + $OutputDirectory + '" -TerminalId ' + $TerminalId
Add-JsonLine $commandsPath ([pscustomobject]@{
    timestamp_utc=[DateTime]::UtcNow.ToString('o'); channel='RDC'; kind='StartProcess'
    command=$rdcInvocation; payload_file_sha256=$payloadFileHash; workspace_root=$WorkspaceRoot
    test_mode=$true; status='STARTED'
})

$profileResults = New-Object System.Collections.ArrayList
$totalSessions = 0
foreach ($profile in $payloadData.sessions) {
    $profilePath = Join-Path $ProfileDirectory $profile.profile_file
    if (-not (Test-Path -LiteralPath $profilePath -PathType Leaf)) { throw "PROFILE_FILE_NOT_FOUND:$($profile.profile_file)" }
    $profileText = Get-Content -LiteralPath $profilePath -Raw -Encoding UTF8
    $profileHash = (Get-FileHash -LiteralPath $profilePath -Algorithm SHA256).Hash
    $commitMatch = [regex]::Match($profileText, '(?im)^\*\*Commit:\*\*\s*([a-f0-9]{40})')
    $sourceCommit = if ($commitMatch.Success) { $commitMatch.Groups[1].Value } else { $null }
    if ($profile.agent -eq 'Carson') {
        $brainEvidencePath = Join-Path $OutputDirectory 'brain-catalog-rdc.json'
        if (-not (Test-Path -LiteralPath $brainEvidencePath -PathType Leaf)) { throw 'CARSON_BMAD_DYNAMIC_CATALOG_EVIDENCE_MISSING' }
        $brain = Get-Content -LiteralPath $brainEvidencePath -Raw -Encoding UTF8 | ConvertFrom-Json
        if (-not $brain.validated -or $brain.package_version -ne '6.12.4') { throw 'CARSON_BMAD_CATALOG_NOT_VERIFIED' }
    }

    $profileRuns = New-Object System.Collections.ArrayList
    foreach ($run in $profile.modes) {
        $totalSessions++
        $profileTags = @('e2e-testmode', $profile.agent.ToLowerInvariant().Replace(' ', '-')) + @($run.tags)
        $initializePayload = @{
            topic=$payloadData.topic; goal=$payloadData.goal; agent=$profile.agent
            engine=$profile.engine; mode=$run.mode; maturity=$run.maturity
            tags=@($profileTags | Select-Object -Unique)
        }
        $initialized = Invoke-Store 'Initialize' $profile.agent $initializePayload
        $cyclePayload = @{
            project_id=$initialized.project_id; session_id=$initialized.session_id
            cycle_number=1; stage=$run.stage; mode=$run.mode; techniques=@($run.techniques)
            items=@($run.items); open_questions=@($run.open_questions); decisions=@($run.decisions)
            links_to_previous=@(); tags=@($profileTags | Select-Object -Unique)
            maturity=$run.maturity; session_status='completed'
        }
        $saved = Invoke-Store 'SaveCycle' $profile.agent $cyclePayload
        if (-not $saved.index_updated -or -not $saved.sha256) { throw "SAVE_CYCLE_NOT_INDEXED:$($profile.agent):$($run.mode)" }
        $shown = Invoke-Store 'ShowSession' $profile.agent @{session_id=$initialized.session_id}
        $readBackCycle = @($shown.cycles | Where-Object {$_.version_id -eq $saved.version_id})
        if ($readBackCycle.Count -ne 1) { throw "SHOWSESSION_VERSION_NOT_UNIQUE:$($profile.agent):$($run.mode)" }
        $cycle = $readBackCycle[0]
        $readBackSha = $cycle.integrity.sha256
        if ($readBackSha -ne $saved.sha256) { throw "READBACK_SHA_MISMATCH:$($profile.agent):$($run.mode)" }
        $expectedTexts = @($cyclePayload.items | ForEach-Object {$_.full_text})
        $actualTexts = @($cycle.items | ForEach-Object {$_.full_text})
        if (($expectedTexts.Count -ne $actualTexts.Count) -or (@(Compare-Object -ReferenceObject $expectedTexts -DifferenceObject $actualTexts).Count -ne 0)) {
            throw "READBACK_CONTENT_MISMATCH:$($profile.agent):$($run.mode)"
        }
        $verified = Invoke-Store 'Verify' $profile.agent @{}
        if (-not $verified.ok -or $verified.sqlite_integrity -ne 'ok' -or -not $verified.source_index_consistent -or $verified.pending_recovery) {
            throw "VERIFY_NOT_PASS:$($profile.agent):$($run.mode)"
        }
        [void]$profileRuns.Add([pscustomobject]@{
            mode=$run.mode; status='PASS'; project_id=$initialized.project_id; session_id=$initialized.session_id
            cycle_id=$saved.cycle_id; version_id=$saved.version_id; cycle_file=$saved.file
            cycle_sha256=$saved.sha256; readback_sha256=$readBackSha; readback_content_match=$true
            items=$actualTexts.Count; show_session_cycles=$shown.cycles.Count
            verify_sqlite_integrity=$verified.sqlite_integrity; verify_source_cycles=$verified.source_cycles
            verify_index_entries=$verified.index_entries
        })
    }
    $runPass = (@($profileRuns | Where-Object {$_.status -ne 'PASS'}).Count -eq 0)
    [void]$profileResults.Add([pscustomobject]@{
        agent=$profile.agent; engine=$profile.engine; profile_file=$profile.profile_file
        profile_sha256=$profileHash; declared_cis_source_commit=$sourceCommit
        source_type='local ChatGPT conversation profile; not a native CIS runtime'
        status=$(if ($runPass) {'PASS'} else {'FAIL'}); sessions=@($profileRuns)
    })
}

$allPass = (@($profileResults | Where-Object {$_.status -ne 'PASS'}).Count -eq 0)
$results = [pscustomobject]@{
    status=$(if ($allPass -and $totalSessions -eq 8) {'PASS'} else {'FAIL'})
    created_at_utc=[DateTime]::UtcNow.ToString('o'); test_mode=$true; production_enabled=$false
    terminal_id=$TerminalId; workspace_root=$WorkspaceRoot; payload_file_sha256=$payloadFileHash
    profile_count=$profileResults.Count; session_count=$totalSessions; profiles=@($profileResults)
    memlog_audit='PENDING_WATCHER_STOP_AND_SNAPSHOT'; rdc_command_log=$commandsPath
}
Write-JsonFile $resultsPath $results
Write-Output "PROFILE_E2E=$($results.status);PROFILES=$($profileResults.Count);SESSIONS=$totalSessions;TESTMODE=True;MEMLOG=PENDING_WATCHER"
