#requires -Version 5.1
# Starts and verifies the OBS Virtual Camera, then refreshes Chrome camera enumeration.
# Does not reboot Windows, change Chrome security flags, or close Chrome without consent.

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$desktop = [Environment]::GetFolderPath('Desktop')
if ([string]::IsNullOrWhiteSpace($desktop)) { $desktop = Join-Path $env:USERPROFILE 'Desktop' }
$workRoot = Join-Path $desktop 'Entorno Persistente'
$logRoot = Join-Path $workRoot 'logs'
New-Item -ItemType Directory -Path $logRoot -Force | Out-Null
$script:LogPath = Join-Path $logRoot ('obs-chrome-' + (Get-Date -Format 'yyyy-MM-dd_HH-mm-ss') + '.log')

function Write-Log {
    param([Parameter(Mandatory = $true)][string]$Message)
    $line = '{0} | {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fffK'), $Message
    Add-Content -LiteralPath $script:LogPath -Value $line -Encoding UTF8
    Write-Host $line
}

function Invoke-NativeCaptured {
    param(
        [Parameter(Mandatory = $true)][string]$Executable,
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [Parameter(Mandatory = $true)][string]$Label
    )
    $lines = @(& $Executable @Arguments 2>&1)
    $code = $LASTEXITCODE
    foreach ($entry in $lines) {
        $safe = [regex]::Replace([string]$entry, '(?i)(gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,})', '[REDACTED]')
        Write-Log ($Label + ' | ' + $safe)
    }
    return [int]$code
}

function Find-ObsExecutable {
    $candidates = @()
    if ($env:ProgramFiles) { $candidates += (Join-Path $env:ProgramFiles 'obs-studio\bin\64bit\obs64.exe') }
    $pf86 = [Environment]::GetEnvironmentVariable('ProgramFiles(x86)')
    if ($pf86) { $candidates += (Join-Path $pf86 'obs-studio\bin\64bit\obs64.exe') }
    if ($env:LOCALAPPDATA) { $candidates += (Join-Path $env:LOCALAPPDATA 'Programs\obs-studio\bin\64bit\obs64.exe') }
    $candidates = @($candidates | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Leaf) })
    $cmd = Get-Command obs64.exe -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) { $candidates += $cmd.Source }
    return ($candidates | Select-Object -First 1)
}

function Test-VirtualCameraLog {
    param([datetime]$NotBefore)
    $folder = Join-Path $env:APPDATA 'obs-studio\logs'
    $latest = Get-ChildItem -LiteralPath $folder -Filter '*.txt' -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $latest -or $latest.LastWriteTime -lt $NotBefore.AddSeconds(-2)) { return $false }
    $lines = @(Get-Content -LiteralPath $latest.FullName -ErrorAction SilentlyContinue)
    $startIndex = -1
    $stopIndex = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match 'Starting Virtual Camera output to Program|Virtual Camera Start') { $startIndex = $i }
        if ($lines[$i] -match 'Stopping Virtual Camera|Virtual Camera Stop') { $stopIndex = $i }
    }
    return ($startIndex -ge 0 -and $startIndex -gt $stopIndex)
}

function Find-ChromeExecutable {
    $cmd = Get-Command chrome.exe -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) { return $cmd.Source }
    $candidates = @()
    if ($env:ProgramFiles) { $candidates += (Join-Path $env:ProgramFiles 'Google\Chrome\Application\chrome.exe') }
    $pf86 = [Environment]::GetEnvironmentVariable('ProgramFiles(x86)')
    if ($pf86) { $candidates += (Join-Path $pf86 'Google\Chrome\Application\chrome.exe') }
    if ($env:LOCALAPPDATA) { $candidates += (Join-Path $env:LOCALAPPDATA 'Google\Chrome\Application\chrome.exe') }
    $candidates = @($candidates | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Leaf) })
    return ($candidates | Select-Object -First 1)
}

try {
    Write-Log ('START | Computer=' + $env:COMPUTERNAME + ' | User=' + $env:USERNAME)
    Write-Log ('LOG=' + $script:LogPath)

    # Locate or install OBS.
    $obs = Find-ObsExecutable
    if (-not $obs) {
        $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
        if (-not $winget) { $winget = Get-Command winget -ErrorAction SilentlyContinue }
        if (-not $winget) { throw 'OBS is not installed and winget is unavailable. Install OBS Studio, then rerun this script.' }
        Write-Log 'OBS not found; attempting to install OBS Studio from winget.'
        $installCode = Invoke-NativeCaptured -Executable $winget.Source -Arguments @(
            'install', '--id', 'OBSProject.OBSStudio', '-e', '--source', 'winget',
            '--accept-source-agreements', '--accept-package-agreements', '--silent'
        ) -Label 'WINGET-OBS'
        $deadline = (Get-Date).AddSeconds(90)
        do {
            Start-Sleep -Milliseconds 750
            $obs = Find-ObsExecutable
        } while (-not $obs -and (Get-Date) -lt $deadline)
        if (-not $obs) { throw "OBS install could not be verified (winget exit=$installCode)." }
    }
    Write-Log ('OBS_EXE=' + $obs)

    # Confirm OBS Virtual Camera components and register the 64-bit DirectShow component if missing.
    $obsRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $obs))
    $vc64 = Join-Path $obsRoot 'data\obs-plugins\win-dshow\obs-virtualcam-module64.dll'
    if (-not (Test-Path -LiteralPath $vc64 -PathType Leaf)) {
        throw ('OBS Virtual Camera module was not found: ' + $vc64 + '. Repair OBS Studio using its installer.')
    }
    Write-Log 'OBS_VIRTUALCAM_MODULE64=FOUND'

    $clsid64 = 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{A3FCE0F5-3493-419F-958A-ABA1250EC20B}'
    if (-not (Test-Path -LiteralPath $clsid64)) {
        $regsvr64 = Join-Path $env:SystemRoot 'System32\regsvr32.exe'
        Write-Log '64-bit DirectShow registration is missing; UAC elevation will be requested for registration only.'
        try {
            $regArgs = '/s /i "' + $vc64 + '"'
            $regProc = Start-Process -FilePath $regsvr64 -ArgumentList $regArgs -Verb RunAs -Wait -PassThru
            Start-Sleep -Milliseconds 500
        }
        catch {
            throw ('Could not register OBS Virtual Camera x64. Accept UAC if prompted, then retry. ' + $_.Exception.Message)
        }
        if (-not (Test-Path -LiteralPath $clsid64)) {
            throw 'OBS Virtual Camera x64 registration was not verified. Chrome security settings were not changed and Windows was not rebooted.'
        }
        Write-Log 'OBS_VIRTUALCAM_REGISTRATION64=VERIFIED'
    }
    else {
        Write-Log 'OBS_VIRTUALCAM_REGISTRATION64=ALREADY_PRESENT'
    }

    # Start the Virtual Camera without forcibly terminating any existing OBS instance.
    $existing = @(Get-CimInstance Win32_Process -Filter "name='obs64.exe'" -ErrorAction SilentlyContinue)
    $verifiedAlready = $false
    foreach ($p in $existing) {
        if ($p.CommandLine -match '--startvirtualcam' -and (Test-VirtualCameraLog -NotBefore $p.CreationDate)) {
            $verifiedAlready = $true
            break
        }
    }

    if ($verifiedAlready) {
        Write-Log 'OBS_VIRTUAL_CAMERA=ALREADY_ACTIVE_VERIFIED'
    }
    else {
        $startTime = Get-Date
        # Leave the OBS window visible so its preview can be inspected.
        $obsProc = Start-Process -FilePath $obs -ArgumentList @('--startvirtualcam', '--multi') -WorkingDirectory (Split-Path -Parent $obs) -PassThru
        Write-Log ('OBS_PID=' + $obsProc.Id)
        $deadline = (Get-Date).AddSeconds(35)
        $ready = $false
        while ((Get-Date) -lt $deadline) {
            Start-Sleep -Milliseconds 500
            if (Test-VirtualCameraLog -NotBefore $startTime) { $ready = $true; break }
        }
        if (-not $ready) {
            throw 'OBS did not confirm the Virtual Camera start in its recent log. Check the OBS Controls dock and press Start Virtual Camera.'
        }
        Write-Log 'OBS_VIRTUAL_CAMERA=START_CONFIRMED_IN_RECENT_LOG'
    }

    # Report whether Windows currently exposes a device whose name matches OBS.
    $pnpCmd = Get-Command Get-PnpDevice -ErrorAction SilentlyContinue
    $obsPnP = @()
    if ($pnpCmd) {
        $obsPnP = @(Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.FriendlyName -match 'OBS.*Virtual Camera|Virtual Camera.*OBS' })
    }
    else {
        Write-Log 'PNP_CAMERA_CHECK=UNAVAILABLE | Get-PnpDevice cmdlet was not found.'
    }
    if ($obsPnP.Count -gt 0) {
        foreach ($dev in $obsPnP) { Write-Log ('PNP_CAMERA=' + $dev.FriendlyName + ' | Status=' + $dev.Status) }
    }
    else {
        Write-Log 'PNP_CAMERA=NOT_CONFIRMED | Verify whether OBS Virtual Camera appears in Chrome camera settings.'
    }

    # Open Windows camera privacy settings (does not change the setting) and Chrome camera settings.
    try {
        Start-Process 'ms-settings:privacy-webcam' | Out-Null
        Write-Log 'WINDOWS_CAMERA_PRIVACY_SETTINGS=OPENED'
    }
    catch {
        Write-Log ('WARNING | Could not open Windows camera privacy settings: ' + $_.Exception.Message)
    }

    $chrome = Find-ChromeExecutable
    if (-not $chrome) {
        Write-Log 'CHROME=NOT_FOUND | OBS Virtual Camera was started, but chrome.exe was not found automatically.'
    }
    else {
        Write-Log ('CHROME_EXE=' + $chrome)
        $chromeProcesses = @(Get-Process chrome -ErrorAction SilentlyContinue)
        if ($chromeProcesses.Count -gt 0) {
            Write-Host ''
            Write-Host 'Chrome is already open. Restarting it can refresh its camera device list.'
            Write-Host 'The restart normally restores tabs, but unsaved form text may be lost.'
            $answer = Read-Host 'Restart Chrome now? Type S to confirm or N to keep the current session open'
            if ($answer -match '(?i)^(s|si|y|yes)$') {
                Start-Process -FilePath $chrome -ArgumentList @('--new-window', 'chrome://restart') | Out-Null
                Start-Sleep -Seconds 4
                Start-Process -FilePath $chrome -ArgumentList @('--new-window', 'chrome://settings/content/camera') | Out-Null
                Write-Log 'CHROME_RESTART=REQUESTED | Camera settings opened after restart request.'
            }
            else {
                Start-Process -FilePath $chrome -ArgumentList @('chrome://settings/content/camera') | Out-Null
                Write-Log 'CHROME_RESTART=NOT_REQUESTED | Camera settings opened to refresh enumeration.'
            }
        }
        else {
            Start-Process -FilePath $chrome -ArgumentList @('--new-window', 'chrome://settings/content/camera') | Out-Null
            Write-Log 'CHROME=STARTED_WITH_CAMERA_SETTINGS'
        }
    }

    Write-Host ''
    Write-Host 'MANUAL VERIFICATION:'
    Write-Host '1. In Windows Settings > Privacy & security > Camera, enable camera access and desktop-app access if policy permits.'
    Write-Host '2. In Chrome > chrome://settings/content/camera, select OBS Virtual Camera and allow camera access for the trusted site.'
    Write-Host '3. Confirm the OBS preview shows video. If it is black, add a Video Capture Device source and select the physical webcam.'
    Write-Host '4. Do not disable Chrome security protections or allow camera access for untrusted sites.'
    Write-Log 'END | Windows was not rebooted and Chrome security flags were not changed.'
    Write-Log ('LOG=' + $script:LogPath)
}
catch {
    Write-Log ('FATAL_ERROR | ' + $_.Exception.Message)
    Write-Log ('LOG=' + $script:LogPath)
    throw
}
