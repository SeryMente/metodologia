[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$OutputDirectory,
    [Parameter(Mandatory=$true)][string]$StopSignal,
    [ValidateRange(60,7200)][int]$MaxSeconds = 1800
)

$ErrorActionPreference = 'Stop'
# The three execution roots are fixed for this approved Product Design TestMode run.
$Roots = @(
    'C:\Users\fila4\Desktop\SeryMente\Metodologia-EP-RETOMA-20261114\frentes\ep\modulos\MOD-EP-PRODUCT-DESIGN',
    'C:\Users\fila4\Desktop\SeryMente\Metodologia\frentes\ep\modulos\MOD-EP-BMAD\data\Fila4\bmad-opencode-smoke',
    (Join-Path $env:TEMP '_ep_product_design_synthetic\PD-E2E-20261115')
)
[System.IO.Directory]::CreateDirectory($OutputDirectory) | Out-Null
$eventsPath = Join-Path $OutputDirectory 'memlog-events.jsonl'
$beforePath = Join-Path $OutputDirectory 'memlog-snapshot-before.json'
$afterPath = Join-Path $OutputDirectory 'memlog-snapshot-after.json'
$readyPath = Join-Path $OutputDirectory 'memlog-watcher-ready.json'
$summaryPath = Join-Path $OutputDirectory 'memlog-audit-summary.json'
$encoding = New-Object System.Text.UTF8Encoding($false)

function Write-JsonFile {
    param([string]$Path, [object]$Value)
    $json = ConvertTo-Json -InputObject $Value -Depth 12
    [System.IO.File]::WriteAllText($Path, $json, $encoding)
}

function Get-MemlogSnapshot {
    param([string[]]$SnapshotRoots)
    $files = New-Object System.Collections.ArrayList
    $errors = New-Object System.Collections.ArrayList
    foreach ($root in $SnapshotRoots) {
        if (-not (Test-Path -LiteralPath $root -PathType Container)) {
            [void]$errors.Add("ROOT_NOT_FOUND:$root")
            continue
        }
        $scanErrors = @()
        $found = @(Get-ChildItem -LiteralPath $root -Filter '*.memlog.md' -File -Recurse -Force -ErrorAction SilentlyContinue -ErrorVariable +scanErrors)
        foreach ($scanError in $scanErrors) {
            [void]$errors.Add("SCAN_ERROR:${root}:$($scanError.Exception.Message)")
        }
        foreach ($file in $found) {
            try {
                $hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256 -ErrorAction Stop).Hash
                [void]$files.Add([pscustomobject]@{
                    path = $file.FullName
                    length = [long]$file.Length
                    sha256 = $hash
                    last_write_utc = $file.LastWriteTimeUtc.ToString('o')
                })
            } catch {
                [void]$errors.Add("HASH_ERROR:$($file.FullName):$($_.Exception.Message)")
            }
        }
    }
    return [pscustomobject]@{
        created_at_utc = [DateTime]::UtcNow.ToString('o')
        roots = @($SnapshotRoots)
        complete = ($errors.Count -eq 0)
        file_count = $files.Count
        files = @($files)
        errors = @($errors)
    }
}

if (Test-Path -LiteralPath $eventsPath) {
    Remove-Item -LiteralPath $eventsPath -Force
}

$watchers = New-Object System.Collections.ArrayList
$subscriptions = New-Object System.Collections.ArrayList
$rootIndex = 0
foreach ($root in $Roots) {
    if (-not (Test-Path -LiteralPath $root -PathType Container)) {
        throw "MEMLOG_WATCH_ROOT_NOT_FOUND:$root"
    }
    $watcher = [System.IO.FileSystemWatcher]::new($root, '*.memlog.md')
    $watcher.IncludeSubdirectories = $true
    $watcher.NotifyFilter = [System.IO.NotifyFilters]::FileName -bor
        [System.IO.NotifyFilters]::DirectoryName -bor
        [System.IO.NotifyFilters]::LastWrite -bor
        [System.IO.NotifyFilters]::CreationTime -bor
        [System.IO.NotifyFilters]::Size
    $watcher.InternalBufferSize = 32768
    $watcher.EnableRaisingEvents = $true
    [void]$watchers.Add($watcher)

    foreach ($eventName in @('Created','Changed','Deleted','Renamed','Error')) {
        $sourceId = "PD-MEMLOG-$rootIndex-$eventName"
        Register-ObjectEvent -InputObject $watcher -EventName $eventName -SourceIdentifier $sourceId | Out-Null
        [void]$subscriptions.Add($sourceId)
    }
    $rootIndex++
}

# Watchers are enabled before the baseline snapshot; events during snapshotting are retained.
$before = Get-MemlogSnapshot -SnapshotRoots $Roots
Write-JsonFile -Path $beforePath -Value $before
$started = [DateTime]::UtcNow
Write-JsonFile -Path $readyPath -Value ([pscustomobject]@{
    ready = $true
    pid = $PID
    started_at_utc = $started.ToString('o')
    roots = @($Roots)
    watcher_count = $watchers.Count
    filter = '*.memlog.md'
    include_subdirectories = $true
    events = @('Created','Changed','Deleted','Renamed','Error')
    snapshot_before = $beforePath
})
Write-Output "MEMLOG_WATCHER_READY=PASS;PID=$PID;ROOTS=$($watchers.Count)"

function Drain-MemlogEvents {
    foreach ($sourceId in $subscriptions) {
        while ($true) {
            $pending = Get-Event -SourceIdentifier $sourceId -ErrorAction SilentlyContinue | Select-Object -First 1
            if (-not $pending) { break }
            $args = $pending.SourceEventArgs
            $entry = [ordered]@{
                event_id = $pending.EventIdentifier
                occurred_at_utc = $pending.TimeGenerated.ToUniversalTime().ToString('o')
                source = $sourceId
                event = ($sourceId -split '-')[-1]
                path = $null
                old_path = $null
                error = $null
            }
            if ($args -is [System.IO.RenamedEventArgs]) {
                $entry.path = $args.FullPath
                $entry.old_path = $args.OldFullPath
            } elseif ($args -is [System.IO.FileSystemEventArgs]) {
                $entry.path = $args.FullPath
            } elseif ($args -is [System.IO.ErrorEventArgs]) {
                $entry.error = $args.GetException().ToString()
            }
            $line = ConvertTo-Json -InputObject ([pscustomobject]$entry) -Compress -Depth 6
            [System.IO.File]::AppendAllText($eventsPath, $line + [Environment]::NewLine, $encoding)
            Remove-Event -EventIdentifier $pending.EventIdentifier -ErrorAction SilentlyContinue
        }
    }
}

$deadline = [DateTime]::UtcNow.AddSeconds($MaxSeconds)
while ((-not (Test-Path -LiteralPath $StopSignal)) -and ([DateTime]::UtcNow -lt $deadline)) {
    Drain-MemlogEvents
    Start-Sleep -Milliseconds 100
}
Start-Sleep -Milliseconds 500
Drain-MemlogEvents
$stopped = [DateTime]::UtcNow

foreach ($watcher in $watchers) {
    $watcher.EnableRaisingEvents = $false
    $watcher.Dispose()
}
foreach ($sourceId in $subscriptions) {
    Unregister-Event -SourceIdentifier $sourceId -ErrorAction SilentlyContinue
}
Get-Event | Where-Object {$_.SourceIdentifier -like 'PD-MEMLOG-*'} | Remove-Event -ErrorAction SilentlyContinue

$after = Get-MemlogSnapshot -SnapshotRoots $Roots
Write-JsonFile -Path $afterPath -Value $after

$beforeMap = @{}
$afterMap = @{}
foreach ($file in $before.files) { $beforeMap[$file.path.ToLowerInvariant()] = "$($file.length)|$($file.sha256)" }
foreach ($file in $after.files) { $afterMap[$file.path.ToLowerInvariant()] = "$($file.length)|$($file.sha256)" }
$allKeys = @($beforeMap.Keys) + @($afterMap.Keys) | Sort-Object -Unique
$differences = New-Object System.Collections.ArrayList
foreach ($key in $allKeys) {
    $left = if ($beforeMap.ContainsKey($key)) { $beforeMap[$key] } else { $null }
    $right = if ($afterMap.ContainsKey($key)) { $afterMap[$key] } else { $null }
    if ($left -ne $right) {
        [void]$differences.Add([pscustomobject]@{path=$key;before=$left;after=$right})
    }
}
$eventLines = @()
if (Test-Path -LiteralPath $eventsPath) {
    $eventLines = @(Get-Content -LiteralPath $eventsPath -ErrorAction SilentlyContinue)
}
$eventCount = $eventLines.Count
$errorEventCount = 0
foreach ($line in $eventLines) {
    try {
        $record = $line | ConvertFrom-Json
        if ($record.event -eq 'Error') { $errorEventCount++ }
    } catch { $errorEventCount++ }
}
$pass = ($before.complete -and $after.complete -and
         $watchers.Count -eq $Roots.Count -and
         $eventCount -eq 0 -and $errorEventCount -eq 0 -and
         $differences.Count -eq 0)
$summary = [pscustomobject]@{
    status = $(if ($pass) {'PASS'} else {'NO_VERIFICADO'})
    started_at_utc = $started.ToString('o')
    stopped_at_utc = $stopped.ToString('o')
    watcher_count = $watchers.Count
    roots = @($Roots)
    filter = '*.memlog.md'
    events = $eventCount
    watcher_errors = $errorEventCount
    before_files = $before.file_count
    after_files = $after.file_count
    snapshot_differences = @($differences)
    snapshot_before_complete = $before.complete
    snapshot_after_complete = $after.complete
    before_path = $beforePath
    after_path = $afterPath
    events_path = $eventsPath
}
Write-JsonFile -Path $summaryPath -Value $summary
Write-Output "MEMLOG_AUDIT=$($summary.status);EVENTS=$eventCount;SNAPSHOT_DIFFS=$($differences.Count);WATCHER_ERRORS=$errorEventCount"
