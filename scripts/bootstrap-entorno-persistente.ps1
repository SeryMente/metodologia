[CmdletBinding()]
param([switch]$ObserverOnly,[string]$WorkRoot,[string]$TerminalId)
# Windows PowerShell 5.1; ASCII-only. Chrome is intentionally never touched.
Set-StrictMode -Version 2.0
$ErrorActionPreference='Stop'
$script:RunId=Get-Date -Format 'yyyyMMdd-HHmmss'
$script:LogPath=$null
$script:StopFile=$null
$script:GhPath=$null
$script:GitPath=$null
function Write-Log([string]$Message) {
    $line='{0} | {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fffK'),$Message
    if ($script:LogPath) { Add-Content -LiteralPath $script:LogPath -Value $line -Encoding UTF8 }
    Write-Host $line
}
function Invoke-NativeCaptured {
    param([Parameter(Mandatory=$true)][string]$Executable,[Parameter(Mandatory=$true)][string[]]$Arguments,[string]$Label='NATIVE',[switch]$Quiet)
    $old=$ErrorActionPreference
    try { $ErrorActionPreference='Continue'; $lines=@(& $Executable @Arguments 2>&1); $code=$LASTEXITCODE }
    finally { $ErrorActionPreference=$old }
    if (-not $Quiet) { foreach ($line in $lines) { Write-Log ($Label + ' | ' + [string]$line) } }
    return [pscustomobject]@{ ExitCode=[int]$code; Lines=@($lines | ForEach-Object { [string]$_ }) }
}
function Refresh-Path {
    $env:Path=@($env:Path,[Environment]::GetEnvironmentVariable('Path','Machine'),[Environment]::GetEnvironmentVariable('Path','User'),
        (Join-Path $env:ProgramFiles 'Git\cmd'),(Join-Path $env:ProgramFiles 'nodejs'),(Join-Path $env:ProgramFiles 'GitHub CLI'),
        (Join-Path $env:LOCALAPPDATA 'Programs\nodejs'),(Join-Path $env:LOCALAPPDATA 'Programs\GitHub CLI'),(Join-Path $env:APPDATA 'npm')) -join ';'
}
function Find-Winget {
    Refresh-Path
    $x=Get-Command winget.exe -ErrorAction SilentlyContinue
    if (-not $x) { $x=Get-Command winget -ErrorAction SilentlyContinue }
    if ($x -and $x.Source) { return $x.Source }
    $p=Join-Path $env:LOCALAPPDATA 'Microsoft\WindowsApps\winget.exe'
    if (Test-Path -LiteralPath $p -PathType Leaf) { return $p }
    return $null
}
function Find-Gh {
    Refresh-Path
    $x=Get-Command gh.exe -ErrorAction SilentlyContinue
    if (-not $x) { $x=Get-Command gh -ErrorAction SilentlyContinue }
    if ($x -and $x.Source) { return $x.Source }
    foreach ($p in @((Join-Path $env:ProgramFiles 'GitHub CLI\gh.exe'),(Join-Path $env:LOCALAPPDATA 'Programs\GitHub CLI\gh.exe'),(Join-Path $env:LOCALAPPDATA 'Microsoft\WinGet\Links\gh.exe'))) {
        if ($p -and (Test-Path -LiteralPath $p -PathType Leaf)) { return $p }
    }
    return $null
}
function Ensure-Gh {
    $gh=Find-Gh
    if (-not $gh) {
        $wg=Find-Winget
        if (-not $wg) { throw 'GITHUB_CLI_MISSING_AND_WINGET_UNAVAILABLE' }
        $r=Invoke-NativeCaptured -Executable $wg -Arguments @('install','--id','GitHub.cli','--exact','--source','winget','--scope','user','--accept-source-agreements','--accept-package-agreements','--silent') -Label 'INSTALL_GH'
        if ($r.ExitCode -ne 0) { $r=Invoke-NativeCaptured -Executable $wg -Arguments @('install','--id','GitHub.cli','--exact','--source','winget','--accept-source-agreements','--accept-package-agreements','--silent') -Label 'INSTALL_GH_DEFAULT' }
        $end=(Get-Date).AddSeconds(60)
        do { $gh=Find-Gh; if (-not $gh) { Start-Sleep -Milliseconds 500 } } while (-not $gh -and (Get-Date) -lt $end)
        if (-not $gh) { throw "GITHUB_CLI_INSTALL_NOT_VERIFIED: exit=$($r.ExitCode)" }
    }
    $script:GhPath=$gh
    $auth=Invoke-NativeCaptured -Executable $gh -Arguments @('auth','status','--hostname','github.com') -Quiet
    if ($auth.ExitCode -ne 0) { throw 'GITHUB_AUTH_REQUIRED: authenticate gh through a terminal-only, approved method; this bootstrap will not open a browser.' }
    Write-Log 'GITHUB_CLI_AND_AUTH=VERIFIED'
}
function Resolve-Git {
    Refresh-Path
    $x=Get-Command git.exe -ErrorAction SilentlyContinue
    if (-not $x) { $x=Get-Command git -ErrorAction SilentlyContinue }
    if ($x -and $x.Source) { return $x.Source }
    foreach ($p in @((Join-Path $env:ProgramFiles 'Git\cmd\git.exe'),'C:\Program Files (x86)\Git\cmd\git.exe',(Join-Path $env:LOCALAPPDATA 'Programs\Git\cmd\git.exe'))) { if ($p -and (Test-Path -LiteralPath $p -PathType Leaf)) { return $p } }
    return $null
}
function Resolve-Npx {
    Refresh-Path
    $x=Get-Command npx.cmd -ErrorAction SilentlyContinue
    if ($x -and $x.Source) { return $x.Source }
    foreach ($p in @((Join-Path $env:ProgramFiles 'nodejs\npx.cmd'),(Join-Path $env:LOCALAPPDATA 'Programs\nodejs\npx.cmd'))) { if ($p -and (Test-Path -LiteralPath $p -PathType Leaf)) { return $p } }
    return $null
}
function Normalize-Origin([string]$Value) {
    $v=$Value.Trim() -replace '^git@github\.com:','https://github.com/' -replace '^ssh://git@github\.com/','https://github.com/' -replace '\.git$',''
    return $v.TrimEnd('/').ToLowerInvariant()
}
function Sync-Repo([string]$Repo,[string]$Destination) {
    $expected=('https://github.com/'+$Repo).ToLowerInvariant()
    if (Test-Path -LiteralPath $Destination) {
        if (-not (Test-Path -LiteralPath (Join-Path $Destination '.git'))) { throw "DESTINATION_EXISTS_NOT_GIT: $Destination" }
        $o=Invoke-NativeCaptured -Executable $script:GitPath -Arguments @('-C',$Destination,'remote','get-url','origin') -Quiet
        if ($o.ExitCode -ne 0 -or (Normalize-Origin ($o.Lines -join '')) -ne $expected) { throw "REPOSITORY_ORIGIN_MISMATCH: $Destination" }
        $b=Invoke-NativeCaptured -Executable $script:GitPath -Arguments @('-C',$Destination,'branch','--show-current') -Quiet
        if ($b.ExitCode -ne 0 -or ($b.Lines -join '').Trim() -ne 'main') { throw "REPOSITORY_BRANCH_NOT_MAIN: $Destination" }
        $s=Invoke-NativeCaptured -Executable $script:GitPath -Arguments @('-C',$Destination,'status','--porcelain') -Quiet
        if ($s.ExitCode -ne 0) { throw "GIT_STATUS_FAILED: $Destination" }
        if (@($s.Lines | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }).Count -gt 0) { throw "LOCAL_CHANGES_PRESERVED: $Destination" }
        $r=Invoke-NativeCaptured -Executable $script:GitPath -Arguments @('-C',$Destination,'pull','--ff-only','origin','main') -Label ('PULL '+$Repo)
        if ($r.ExitCode -ne 0) { throw "GIT_PULL_FAILED: $Repo" }
    } else {
        New-Item -ItemType Directory -Path (Split-Path -Parent $Destination) -Force | Out-Null
        $r=Invoke-NativeCaptured -Executable $script:GhPath -Arguments @('repo','clone',$Repo,$Destination) -Label ('CLONE '+$Repo)
        if ($r.ExitCode -ne 0) { throw "GIT_CLONE_FAILED: $Repo" }
    }
    $b=Invoke-NativeCaptured -Executable $script:GitPath -Arguments @('-C',$Destination,'branch','--show-current') -Quiet
    $h=Invoke-NativeCaptured -Executable $script:GitPath -Arguments @('-C',$Destination,'rev-parse','HEAD') -Quiet
    if ($b.ExitCode -ne 0 -or ($b.Lines -join '').Trim() -ne 'main' -or $h.ExitCode -ne 0 -or ($h.Lines -join '').Trim() -notmatch '^[0-9a-fA-F]{40}$') { throw "REPOSITORY_POSTCHECK_FAILED: $Repo" }
    Write-Log ('REPOSITORY_READY='+$Repo+' | HEAD='+($h.Lines -join '').Trim()+' | PATH='+$Destination)
}
function Tree-Hashes([string]$Folder,[string]$Exclude) {
    $m=@{}
    foreach ($f in Get-ChildItem -LiteralPath $Folder -File -Recurse -Force) {
        if ($f.Name -eq $Exclude) { continue }
        $rel=$f.FullName.Substring($Folder.TrimEnd('\').Length).TrimStart('\').Replace('\','/')
        $m[$rel]=(Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256).Hash
    }
    return $m
}
function Export-SignalExtension([string]$SourceRepo,[string]$Destination) {
    $source=Join-Path $SourceRepo 'extension'; $markerName='.entorno-persistente-export.json'; $marker=Join-Path $Destination $markerName
    if (-not (Test-Path -LiteralPath (Join-Path $source 'manifest.json') -PathType Leaf)) { throw 'SIGNAL_EXTENSION_MANIFEST_MISSING' }
    if (Test-Path -LiteralPath $Destination) {
        if (-not (Test-Path -LiteralPath $marker -PathType Leaf)) { Write-Log 'SIGNAL_EXPORT_SKIPPED=unmanaged target preserved'; return }
        try {
            $old=Get-Content -LiteralPath $marker -Raw | ConvertFrom-Json; $now=Tree-Hashes $Destination $markerName; $expected=@{}
            foreach ($x in $old.files.PSObject.Properties) { $expected[$x.Name]=[string]$x.Value }
            $same=($now.Count -eq $expected.Count)
            if ($same) { foreach ($k in $expected.Keys) { if (-not $now.ContainsKey($k) -or $now[$k] -ne $expected[$k]) { $same=$false; break } } }
            if (-not $same) { Write-Log 'SIGNAL_EXPORT_SKIPPED=local changes preserved'; return }
        } catch { Write-Log 'SIGNAL_EXPORT_SKIPPED=invalid marker; destination preserved'; return }
        Remove-Item -LiteralPath $Destination -Recurse -Force
    }
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    foreach ($x in Get-ChildItem -LiteralPath $source -Force) {
        $to=Join-Path $Destination $x.Name
        if ($x.PSIsContainer) { Copy-Item -LiteralPath $x.FullName -Destination $to -Recurse -Force } else { Copy-Item -LiteralPath $x.FullName -Destination $to -Force }
    }
    $hashes=Tree-Hashes $Destination $markerName
    $head=Invoke-NativeCaptured -Executable $script:GitPath -Arguments @('-C',$SourceRepo,'rev-parse','HEAD') -Quiet
    $files=[ordered]@{}; foreach ($k in ($hashes.Keys | Sort-Object)) { $files[$k]=$hashes[$k] }
    $data=[ordered]@{ generated=$true; source='SeryMente/signal-interpreter/extension'; sourceHead=($head.Lines -join '').Trim(); generatedAt=(Get-Date).ToString('o'); files=$files }
    [System.IO.File]::WriteAllText($marker,($data | ConvertTo-Json -Depth 8),(New-Object System.Text.UTF8Encoding($false)))
    if (-not (Test-Path -LiteralPath (Join-Path $Destination 'manifest.json') -PathType Leaf)) { throw 'SIGNAL_EXTENSION_ROOT_MANIFEST_FAILED' }
    Write-Log ('SIGNAL_EXTENSION_ROOT_MANIFEST=VERIFIED | '+$Destination)
}
function Find-Obs {
    $list=@()
    if ($env:ProgramFiles) { $list += (Join-Path $env:ProgramFiles 'obs-studio\bin\64bit\obs64.exe') }
    $pf=[Environment]::GetEnvironmentVariable('ProgramFiles(x86)'); if ($pf) { $list += (Join-Path $pf 'obs-studio\bin\64bit\obs64.exe') }
    if ($env:LOCALAPPDATA) { $list += (Join-Path $env:LOCALAPPDATA 'Programs\obs-studio\bin\64bit\obs64.exe') }
    $cmd=Get-Command obs64.exe -ErrorAction SilentlyContinue; if ($cmd -and $cmd.Source) { $list += $cmd.Source }
    foreach ($p in $list) { if ($p -and (Test-Path -LiteralPath $p -PathType Leaf)) { return $p } }
    return $null
}
function Test-ObsLog([datetime]$Since) {
    $dir=Join-Path $env:APPDATA 'obs-studio\logs'
    $file=Get-ChildItem -LiteralPath $dir -Filter '*.txt' -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $file -or $file.LastWriteTime -lt $Since.AddSeconds(-2)) { return $false }
    $lines=@(Get-Content -LiteralPath $file.FullName -ErrorAction SilentlyContinue); $started=-1; $stopped=-1
    for ($i=0;$i -lt $lines.Count;$i++) { if ($lines[$i] -match 'Starting Virtual Camera output to Program|Virtual Camera Start') { $started=$i }; if ($lines[$i] -match 'Stopping Virtual Camera|Virtual Camera Stop') { $stopped=$i } }
    return ($started -ge 0 -and $started -gt $stopped)
}
function Ensure-ObsCamera {
    $obs=Find-Obs
    if (-not $obs) {
        $wg=Find-Winget
        if (-not $wg) { throw 'OBS_NOT_FOUND_AND_WINGET_UNAVAILABLE' }
        $ins=Invoke-NativeCaptured -Executable $wg -Arguments @('install','--id','OBSProject.OBSStudio','--exact','--source','winget','--accept-source-agreements','--accept-package-agreements','--silent') -Label 'INSTALL_OBS'
        $end=(Get-Date).AddSeconds(90)
        do { Start-Sleep -Milliseconds 500; $obs=Find-Obs } while (-not $obs -and (Get-Date) -lt $end)
        if (-not $obs) { throw "OBS_INSTALL_NOT_VERIFIED: exit=$($ins.ExitCode)" }
    }
    $root=Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $obs))
    $dll=Join-Path $root 'data\obs-plugins\win-dshow\obs-virtualcam-module64.dll'
    if (-not (Test-Path -LiteralPath $dll -PathType Leaf)) { throw ('OBS_VIRTUALCAM_MODULE_MISSING='+$dll) }
    $clsid='Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{A3FCE0F5-3493-419F-958A-ABA1250EC20B}'
    if (-not (Test-Path -LiteralPath $clsid)) {
        $reg=Invoke-NativeCaptured -Executable (Join-Path $env:SystemRoot 'System32\regsvr32.exe') -Arguments @('/s','/i',$dll) -Label 'REGISTER_OBS_VCAM64'
        if ($reg.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $clsid)) { throw 'OBS_VCAM_REGISTRATION_REQUIRES_ADMIN_TERMINAL' }
    }
    $active=$false
    foreach ($p in @(Get-CimInstance Win32_Process -Filter "name='obs64.exe'" -ErrorAction SilentlyContinue)) { if (Test-ObsLog $p.CreationDate) { $active=$true; break } }
    if (-not $active) {
        $since=Get-Date
        $proc=Start-Process -FilePath $obs -ArgumentList @('--startvirtualcam','--minimize-to-tray','--multi') -WorkingDirectory (Split-Path -Parent $obs) -PassThru
        Write-Log ('OBS_PID='+$proc.Id)
        $end=(Get-Date).AddSeconds(35)
        while ((Get-Date) -lt $end) { Start-Sleep -Milliseconds 500; if (Test-ObsLog $since) { $active=$true; break } }
    }
    if (-not $active) { throw 'OBS_VIRTUAL_CAMERA_START_NOT_VERIFIED_IN_LOG' }
    Write-Log 'OBS_VIRTUAL_CAMERA=START_CONFIRMED'
    $pnputil=Join-Path $env:SystemRoot 'System32\pnputil.exe'
    if (Test-Path -LiteralPath $pnputil) { $scan=Invoke-NativeCaptured -Executable $pnputil -Arguments @('/scan-devices') -Label 'PNP_RESCAN'; if ($scan.ExitCode -ne 0) { Write-Log ('PNP_RESCAN_EXIT='+$scan.ExitCode) } }
    $gp=Get-Command Get-PnpDevice -ErrorAction SilentlyContinue
    if ($gp) {
        $devices=@(Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.FriendlyName -match '(?i)OBS.*Virtual Camera|Virtual Camera.*OBS' })
        if ($devices.Count -gt 0) { foreach ($d in $devices) { Write-Log ('OBS_PNP_DEVICE='+$d.FriendlyName+' | STATUS='+$d.Status) } } else { Write-Log 'OBS_PNP_DEVICE=NOT_LISTED_BY_GET_PNPDEVICE' }
    }
}
function Start-Observer([string]$ScriptPath,[string]$Root,[string]$PcId) {
    $found=@(Get-CimInstance Win32_Process -Filter "name='powershell.exe'" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -and $_.CommandLine -match [regex]::Escape($ScriptPath) -and $_.CommandLine -match 'ObserverOnly' })
    if ($found.Count -gt 0) { Write-Log 'OBSERVER=ALREADY_RUNNING'; return }
    $ps=Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
    $argsLine='-NoProfile -ExecutionPolicy Bypass -File "'+$ScriptPath+'" -ObserverOnly -WorkRoot "'+$Root+'" -TerminalId "'+$PcId+'"'
    $proc=Start-Process -FilePath $ps -ArgumentList $argsLine -PassThru
    Write-Log ('OBSERVER_PID='+$proc.Id)
}
if ($ObserverOnly) {
    if ([string]::IsNullOrWhiteSpace($WorkRoot) -or -not (Test-Path -LiteralPath $WorkRoot)) { throw 'OBSERVER_WORKROOT_INVALID' }
    $script:LogPath=Join-Path $WorkRoot 'logs\observer.log'; $script:StopFile=Join-Path $WorkRoot '.bootstrap-session.stop'; $perf=Join-Path $WorkRoot 'performance-events.log'
    while (-not (Test-Path -LiteralPath $script:StopFile)) {
        $now=Get-Date; $cpu='N/A'; $ram='N/A'; $disk='N/A'; $gpu='N/A (unsupported)'
        try { $x=@(Get-CimInstance Win32_Processor -ErrorAction Stop | ForEach-Object { $_.LoadPercentage }); if ($x.Count -gt 0) { $cpu='{0:N0}%' -f (($x | Measure-Object -Average).Average) } } catch { $cpu='UNAVAILABLE' }
        try { $x=Get-CimInstance Win32_OperatingSystem -ErrorAction Stop; if ([double]$x.TotalVisibleMemorySize -gt 0) { $v=100.0*([double]$x.TotalVisibleMemorySize-[double]$x.FreePhysicalMemory)/[double]$x.TotalVisibleMemorySize; $ram='{0:N1}% used; {1:N1} GB free' -f $v,([double]$x.FreePhysicalMemory/1MB) } } catch { $ram='UNAVAILABLE' }
        try { $x=Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'" -ErrorAction Stop; if ($x -and [double]$x.Size -gt 0) { $disk='{0:N1}% free; {1:N1} GB free' -f (100.0*[double]$x.FreeSpace/[double]$x.Size),([double]$x.FreeSpace/1GB) } } catch { $disk='UNAVAILABLE' }
        $cmd=Get-Command nvidia-smi.exe -ErrorAction SilentlyContinue
        if ($cmd) { $g=Invoke-NativeCaptured -Executable $cmd.Source -Arguments @('--query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu,power.draw','--format=csv,noheader,nounits') -Quiet; if ($g.ExitCode -eq 0 -and $g.Lines.Count -gt 0) { $gpu=$g.Lines -join '; ' } else { $gpu='UNAVAILABLE' } }
        $task='NOT_REGISTERED'; try { $t=Get-ScheduledTask -TaskName 'CyberCafe Performance Liberator' -ErrorAction Stop; $task=[string]$t.State } catch {}
        $beat='NO AGENT SAMPLE FOUND'; $age='N/A'
        if (Test-Path -LiteralPath $perf) { $samples=@(Get-Content -LiteralPath $perf -Tail 200 -ErrorAction SilentlyContinue | Where-Object { $_ -match '(?i)AGENT_SAMPLE|PERF_SAMPLE|METRICS_SAMPLE|HEARTBEAT' }); if ($samples.Count -gt 0) { $sec=[math]::Max(0,($now-(Get-Item -LiteralPath $perf).LastWriteTime).TotalSeconds); $age='{0:N0}s' -f $sec; if ($sec -le 30) { $beat='RECENT MARKER' } else { $beat='STALE STREAM' } } }
        Clear-Host
        Write-Host '=== CIBERCAFE PASTEUR OBSERVER / READ ONLY ==='
        Write-Host ('Time: '+$now.ToString('yyyy-MM-dd HH:mm:ss')); Write-Host ('Physical terminal: CIBERCAFE/'+$TerminalId); Write-Host ('Work root: '+$WorkRoot)
        Write-Host ('CPU: '+$cpu+' | RAM: '+$ram); Write-Host ('C: '+$disk+' | GPU: '+$gpu)
        Write-Host ('Agent task: '+$task+' | Heartbeat: '+$beat+' | Log age: '+$age); Write-Host ('Agent event source: '+$perf)
        Write-Host 'Actions: NONE | Reboot budget: 0 | Chrome: NOT TOUCHED'
        Start-Sleep -Seconds 10
    }
    exit 0
}

$desktop=[Environment]::GetFolderPath('Desktop')
if ([string]::IsNullOrWhiteSpace($desktop) -or -not (Test-Path -LiteralPath $desktop)) { $desktop=Join-Path $env:USERPROFILE 'Desktop' }
if (-not (Test-Path -LiteralPath $desktop)) { throw 'DESKTOP_PATH_NOT_FOUND' }
if ([string]::IsNullOrWhiteSpace($WorkRoot)) { $WorkRoot=Join-Path $desktop 'Entorno Persistente' }
New-Item -ItemType Directory -Path (Join-Path $WorkRoot 'logs') -Force | Out-Null
$script:LogPath=Join-Path $WorkRoot ('logs\bootstrap-'+$script:RunId+'.log'); $script:StopFile=Join-Path $WorkRoot '.bootstrap-session.stop'
$computer=Get-CimInstance Win32_ComputerSystem; $os=Get-CimInstance Win32_OperatingSystem; $dns=[System.Net.Dns]::GetHostName(); $name=[string]$computer.Name
$guess=if ($name -match '^(?i)PC-\d+$') { $name } elseif ($dns -match '^(?i)PC-\d+$') { $dns } else { '' }
if ([string]::IsNullOrWhiteSpace($TerminalId)) { if ($guess) { $TerminalId=$guess } else { $TerminalId=Read-Host 'Physical Pasteur terminal ID (PC-N); not RDC device ID' } }
if ($TerminalId -notmatch '^(?i)PC-\d+$') { throw 'TERMINAL_ID_INVALID: use the physical PC-N identity.' }
$TerminalId=$TerminalId.ToUpperInvariant()
Write-Log ('SESSION_START | CIBERCAFE/'+$TerminalId+' | DNS='+$dns+' | SystemName='+$name+' | User='+$env:USERNAME)
Write-Log ('OS='+$os.Caption+' | BUILD='+$os.BuildNumber+' | PowerShell='+$PSVersionTable.PSVersion)
Write-Log 'REBOOT_BUDGET=0 | no reboot/shutdown/reset/BIOS/UEFI/firmware/offline repair.'
Write-Log 'CHROME_POLICY=DO_NOT_LAUNCH/STOP/INSPECT/CONFIGURE/EDIT.'
$terminalRoot=Join-Path (Join-Path $WorkRoot 'CIBERCAFE') $TerminalId; New-Item -ItemType Directory -Path $terminalRoot -Force | Out-Null
$state=Join-Path $terminalRoot 'ESTADO.md'; $events=Join-Path $terminalRoot ('EVENTOS-'+(Get-Date -Format 'yyyy-MM')+'.md')
if (-not (Test-Path -LiteralPath $state)) {
    $stateText=@('# Terminal memory: CIBERCAFE/'+$TerminalId,'','- Physical identity: CIBERCAFE/'+$TerminalId,'- Windows system name: '+$name,'- DNS hostname: '+$dns,'- First observation: '+(Get-Date -Format 'yyyy-MM-dd HH:mm:ssK'),'- OS: '+$os.Caption+' build '+$os.BuildNumber,'- Reboot budget: 0','- RDC account/device ID are session identity; verify separately.','') -join [Environment]::NewLine
    [System.IO.File]::WriteAllText($state,$stateText,(New-Object System.Text.UTF8Encoding($false)))
}
Add-Content -LiteralPath $events -Value ('- '+(Get-Date -Format 'yyyy-MM-dd HH:mm:ssK')+' | BOOTSTRAP_START | user='+$env:USERNAME+' | reboot_budget=0') -Encoding UTF8
$storedDir=Join-Path $WorkRoot 'scripts'; New-Item -ItemType Directory -Path $storedDir -Force | Out-Null
$stored=Join-Path $storedDir 'bootstrap-entorno-persistente.ps1'
if ($PSCommandPath -and (Test-Path -LiteralPath $PSCommandPath)) { Copy-Item -LiteralPath $PSCommandPath -Destination $stored -Force }
$oldObservers=@(Get-CimInstance Win32_Process -Filter "name='powershell.exe'" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -and $_.CommandLine -match [regex]::Escape($stored) -and $_.CommandLine -match 'ObserverOnly' })
if ($oldObservers.Count -gt 0) {
    New-Item -ItemType File -Path $script:StopFile -Force | Out-Null; $end=(Get-Date).AddSeconds(8)
    do { Start-Sleep -Milliseconds 250; $oldObservers=@(Get-CimInstance Win32_Process -Filter "name='powershell.exe'" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -and $_.CommandLine -match [regex]::Escape($stored) -and $_.CommandLine -match 'ObserverOnly' }) } while ($oldObservers.Count -gt 0 -and (Get-Date) -lt $end)
    if ($oldObservers.Count -gt 0) { throw 'OLD_OBSERVER_DID_NOT_STOP; refusing duplicate observer.' }
}
Remove-Item -LiteralPath $script:StopFile -Force -ErrorAction SilentlyContinue

try {
    Ensure-Gh
    $pin='14756d289f1ddc4c74c6736f5aa021121158541c'; $pinHash='19D254602AEAA17F08D9E4D09B20B665DC48588C46EB41F1C9E53F2EF62E0154'
    $url='https://raw.githubusercontent.com/SeryMente/metodologia/'+$pin+'/scripts/bootstrap-cibercafe-cli.ps1'; $file=Join-Path $env:TEMP 'bootstrap-cibercafe-cli-pinned.ps1'
    [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $file
    if ((Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash -ne $pinHash) { Remove-Item -LiteralPath $file -Force -ErrorAction SilentlyContinue; throw 'BASE_BOOTSTRAP_HASH_MISMATCH' }
    Write-Log 'BASE_BOOTSTRAP=PINNED_SHA256_VERIFIED'
    $ps=Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'; $old=$ErrorActionPreference
    try { $ErrorActionPreference='Continue'; $baseOutput=@(& $ps -NoProfile -ExecutionPolicy Bypass -File $file -PrepareOnly 2>&1); $baseCode=$LASTEXITCODE } finally { $ErrorActionPreference=$old }
    foreach ($line in $baseOutput) { Write-Log ('BASE_PREPARE | '+[string]$line) }
    if ($baseCode -ne 0) { throw "BASE_PREPARE_FAILED: exit=$baseCode" }

    $script:GitPath=Resolve-Git
    if (-not $script:GitPath) { throw 'GIT_NOT_FOUND_AFTER_BASE_PREPARE' }
    $setup=Invoke-NativeCaptured -Executable $script:GhPath -Arguments @('auth','setup-git') -Label 'GH_SETUP_GIT'
    if ($setup.ExitCode -ne 0) { throw 'GH_AUTH_SETUP_GIT_FAILED' }
    $repos=@(
        @{Name='metodologia';Repo='SeryMente/metodologia'},
        @{Name='otro-gran-programa';Repo='SeryMente/otrogranprograma'},
        @{Name='gestor-de-procesos';Repo='SeryMente/GDP'},
        @{Name='signal-interpreter-source';Repo='SeryMente/signal-interpreter'},
        @{Name='khora';Repo='SeryMente/khora'}
    )
    foreach ($item in $repos) {
        $probe=Invoke-NativeCaptured -Executable $script:GhPath -Arguments @('repo','view',$item.Repo,'--json','nameWithOwner,visibility') -Quiet
        if ($probe.ExitCode -ne 0) { throw "REPOSITORY_ACCESS_FAILED: $($item.Repo); fix repository permission before downloads." }
    }
    Write-Log 'REPOSITORY_ACCESS=VERIFIED'
    $failed=@()
    foreach ($item in $repos) {
        try { Sync-Repo $item.Repo (Join-Path $WorkRoot $item.Name) }
        catch { $failed+=$item.Repo; Write-Log ('REPOSITORY_ERROR | '+$item.Repo+' | '+$_.Exception.Message) }
    }
    if ($failed.Count -gt 0) { throw ('REPOSITORIES_INCOMPLETE=' + ($failed -join ',')) }

    $manifest=Join-Path (Join-Path $WorkRoot 'gestor-de-procesos') 'manifest.json'
    if (Test-Path -LiteralPath $manifest -PathType Leaf) { Write-Log 'GDP_MANIFEST_ROOT=VERIFIED' } else { Write-Log 'GDP_MANIFEST_ROOT=NOT_FOUND' }
    Export-SignalExtension (Join-Path $WorkRoot 'signal-interpreter-source') (Join-Path $WorkRoot 'signal-interpreter')
    $si=Join-Path (Join-Path $WorkRoot 'metodologia') 'SI-METACOGNITIVO.md'; $met=Join-Path (Join-Path $WorkRoot 'metodologia') 'METODOLOGIA.md'
    if (-not (Test-Path -LiteralPath $si -PathType Leaf) -or -not (Test-Path -LiteralPath $met -PathType Leaf)) { throw 'SI_OR_METHODOLOGY_MISSING' }
    if ([System.IO.File]::ReadAllText($si).Length -lt 1000 -or [System.IO.File]::ReadAllText($met).Length -lt 1000) { throw 'SI_OR_METHODOLOGY_INCOMPLETE' }
    Write-Log 'SI_AND_METHODOLOGY=LOCAL_FILES_VERIFIED'

    try { Ensure-ObsCamera } catch { Write-Log ('OBS_CAMERA=BLOCKED_OR_FAILED | '+$_.Exception.Message) }
    Write-Log 'CHROME=NOT_TOUCHED | no Chrome process or settings are accessed.'
    $task='NOT_REGISTERED'; try { $t=Get-ScheduledTask -TaskName 'CyberCafe Performance Liberator' -ErrorAction Stop; $task=[string]$t.State } catch {}
    Write-Log ('PERFORMANCE_TASK='+$task+' | state is not heartbeat proof.')
    $perf=Join-Path $WorkRoot 'performance-events.log'
    if (-not (Test-Path -LiteralPath $perf)) { [System.IO.File]::WriteAllText($perf,('# Agent-owned events; no second optimizer is created.'+[Environment]::NewLine),(New-Object System.Text.UTF8Encoding($false))) }
    Start-Observer -ScriptPath $stored -Root $WorkRoot -PcId $TerminalId

    Write-Log 'RDC_START=FOREGROUND | keep this terminal open.'
    $npx=Resolve-Npx; if (-not $npx) { throw 'NPX_CMD_NOT_FOUND_AFTER_BASE_PREPARE' }
    $old=$ErrorActionPreference
    try { $ErrorActionPreference='Continue'; & $npx '@wonderwhy-er/desktop-commander@latest' 'remote'; $rc=$LASTEXITCODE } finally { $ErrorActionPreference=$old }
    Write-Log ('RDC_EXIT='+$rc)
    if ($rc -ne 0) { throw "RDC_REMOTE_FAILED: exit=$rc" }
}
catch { Write-Log ('FATAL_ERROR='+$_.Exception.Message); Write-Log ('LOG_PATH='+$script:LogPath); throw }
finally { if ($script:StopFile) { New-Item -ItemType File -Path $script:StopFile -Force | Out-Null; Write-Log 'OBSERVER_STOP_SIGNAL=WRITTEN' } }
