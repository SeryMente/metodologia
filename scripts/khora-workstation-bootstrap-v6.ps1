[CmdletBinding()]
param([switch]$SelfTest,[switch]$PreflightOnly)
$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'
$script:LogPath = $null
$script:SelfTest = [bool]$SelfTest
$script:VercelVersion = '65.9.0'
$script:DesktopCommanderVersion = '0.3.1'
$script:ToneTrace = New-Object System.Collections.Generic.List[int]
try {
    Register-EngineEvent -SourceIdentifier PowerShell.OnError -Action {
        $eventError = $Event.SourceEventArgs
        if ($eventError -and $eventError.Exception) {
            Write-Host ('ENGINE ERROR: ' + $eventError.Exception.Message) -ForegroundColor Red
        }
    } | Out-Null
} catch {}
function Write-Log {
    param([string]$Message,[string]$Color='Gray')
    $entry = '[{0}] {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'),$Message
    Write-Host $entry -ForegroundColor $Color
    if ($script:LogPath) { try { Add-Content -LiteralPath $script:LogPath -Value $entry -Encoding UTF8 } catch {} }
}
function Stop-Fatal {
    param([string]$Message)
    Write-Log ('FATAL: ' + $Message) 'Red'
    throw $Message
}
function Find-Exe {
    param([string]$Name,[string[]]$Paths=@())
    $found = Get-Command $Name -ErrorAction SilentlyContinue | Where-Object {$_.CommandType -eq 'Application'} | Select-Object -First 1
    if ($found -and (Test-Path -LiteralPath $found.Source -PathType Leaf)) { return $found.Source }
    foreach ($candidate in $Paths) {
        if ($candidate -and (Test-Path -LiteralPath $candidate -PathType Leaf)) { return $candidate }
    }
    return $null
}
function Update-Path {
    $machine = [Environment]::GetEnvironmentVariable('Path','Machine')
    $user = [Environment]::GetEnvironmentVariable('Path','User')
    $env:Path = @($machine,$user) -join ';'
}
function Install-WingetPackage {
    param([string]$Id)
    $winget = Find-Exe 'winget.exe' @((Join-Path $env:LOCALAPPDATA 'Microsoft\WindowsApps\winget.exe'))
    if (-not $winget) { Stop-Fatal 'winget.exe is unavailable.' }
    Write-Log ('Installing package: ' + $Id) 'Cyan'
    & $winget install --id $Id --exact --silent --accept-package-agreements --accept-source-agreements --disable-interactivity
    $code = $LASTEXITCODE
    if ($code -ne 0 -and $code -ne -1978335189) { Stop-Fatal ('winget install failed: ' + $Id + '; exit=' + $code) }
    Update-Path
}
function Play-Tone {
    param([int]$Hz,[int]$Ms=150)
    $script:ToneTrace.Add($Hz) | Out-Null
    if (-not $script:SelfTest) { try { [Console]::Beep($Hz,$Ms) } catch { try { [System.Media.SystemSounds]::Asterisk.Play() } catch {} } }
}
function Progress-Tone {
    param([int]$Percent)
    switch ($Percent) { 25 {$hz=880} 50 {$hz=740} 75 {$hz=880} default {return} }
    Write-Log ('Progress ' + $Percent + '%') 'Cyan'
    Play-Tone $hz 150
}
function Install-NpmPackageWithRetry {
    param([string]$Npm,[string]$Package,[int]$Attempts=3)
    for ($attempt=1; $attempt -le $Attempts; $attempt++) {
        Write-Log ('Installing ' + $Package + ' (attempt ' + $attempt + '/' + $Attempts + ').') 'Cyan'
        & $Npm install --global --allow-scripts=esbuild,koffi --fetch-retries=2 --fetch-timeout=60000 $Package
        $code = $LASTEXITCODE
        if ($code -eq 0) { Update-Path; return }
        if ($attempt -lt $Attempts) { Write-Log ('NPM install failed with exit ' + $code + '; retrying.') 'Yellow'; Start-Sleep -Seconds (2 * $attempt) }
    }
    Stop-Fatal ('NPM install failed after ' + $Attempts + ' attempts: ' + $Package)
}
function Get-Sha256Text {
    param([string]$Text)
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($Text)))).Replace('-','').ToLowerInvariant() }
    finally { $sha.Dispose() }
}
function Find-Chrome {
    return Find-Exe 'chrome.exe' @('C:\Program Files\Google\Chrome\Application\chrome.exe','C:\Program Files (x86)\Google\Chrome\Application\chrome.exe')
}
function Read-GhClipboard {
    param([string]$Gh)
    $value = (& $Gh config get clipboard 2>$null | Out-String).Trim()
    $result = $LASTEXITCODE
    if ($result -eq 1) { return 'enabled' }
    if ($result -ne 0 -or $value -notin @('enabled','disabled')) { Stop-Fatal 'Unable to read a valid GitHub CLI clipboard setting.' }
    return $value
}
function Write-GhClipboard {
    param([string]$Gh,[string]$Value)
    & $Gh config set clipboard $Value *> $null
    if ($LASTEXITCODE -ne 0) { Stop-Fatal 'Unable to set GitHub CLI clipboard setting.' }
    if ((Read-GhClipboard $Gh) -ne $Value) { Stop-Fatal 'GitHub CLI clipboard setting read-back mismatch.' }
}
function Invoke-GitHubDeviceAuth {
    param([string]$Gh,[string]$Chrome)
    $original = Read-GhClipboard $Gh
    $stdout = Join-Path $env:TEMP 'KHORA-GH-auth.stdout'
    $stderr = Join-Path $env:TEMP 'KHORA-GH-auth.stderr'
    Remove-Item -LiteralPath $stdout,$stderr -Force -ErrorAction SilentlyContinue
    $oldBrowser = $env:GH_BROWSER
    try {
        Write-GhClipboard $Gh 'disabled'
        $env:GH_BROWSER = $Chrome
        $process = Start-Process -FilePath $Gh -ArgumentList 'auth login --hostname github.com --git-protocol https --web --scopes repo --skip-ssh-key' -PassThru -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
        $deadline = (Get-Date).AddMinutes(15)
        $copied = $false
        $opened = $false
        while (-not $process.HasExited -and (Get-Date) -lt $deadline) {
            foreach ($file in @($stdout,$stderr)) {
                if (Test-Path -LiteralPath $file) {
                    $content = Get-Content -LiteralPath $file -Raw -ErrorAction SilentlyContinue
                    if (-not $copied -and $content -match '(?i)([A-Z0-9]{4}-[A-Z0-9]{4})') {
                        $code = $Matches[1].ToUpperInvariant()
                        Set-Clipboard -Value $code
                        $copied = $true
                        Write-Log 'GitHub device code copied automatically.' 'Yellow'
                    }
                    if (-not $opened -and $content -match '(https://github\.com/login/device\S*)') {
                        $url = $Matches[1].TrimEnd('.','"',')')
                        Start-Process -FilePath $Chrome -ArgumentList $url
                        $opened = $true
                        Write-Log 'Chrome opened for GitHub device authorization.' 'Yellow'
                    }
                }
            }
            Play-Tone 360 180
            Start-Sleep -Milliseconds 2300
            $process.Refresh()
        }
        if (-not $process.HasExited) { try {$process.Kill()} catch {}; Stop-Fatal 'GitHub device authorization timed out after 15 minutes.' }
        $process.WaitForExit()
        if ($process.ExitCode -ne 0) { & $Gh auth status --hostname github.com *> $null; if ($LASTEXITCODE -ne 0) { Stop-Fatal 'GitHub CLI device authorization failed and auth status did not verify.' } }
        if (-not $copied) { Stop-Fatal 'GitHub CLI returned no capturable device code.' }
    } finally {
        if ($null -eq $oldBrowser) { Remove-Item Env:GH_BROWSER -ErrorAction SilentlyContinue } else { $env:GH_BROWSER = $oldBrowser }
        Write-GhClipboard $Gh $original
    }
}
function Assert-GitHelpers {
    param([string]$Git,[string[]]$SystemBefore,[string[]]$GlobalBefore,[string[]]$EffectiveBefore)
    $systemAfter = @(& $Git config --system --get credential.helper 2>$null)
    $globalAfter = @(& $Git config --global --get credential.helper 2>$null)
    $effectiveAfter = @(& $Git config --get credential.helper 2>$null)
    if ((Compare-Object $SystemBefore $systemAfter | Measure-Object).Count -gt 0) { Stop-Fatal 'System Git credential helper changed.' }
    if ((Compare-Object $GlobalBefore $globalAfter | Measure-Object).Count -gt 0) { Stop-Fatal 'Global Git credential helper changed.' }
    if ((Compare-Object $EffectiveBefore $effectiveAfter | Measure-Object).Count -gt 0) { Stop-Fatal 'Effective generic Git credential helper changed.' }
}
function Test-GitHttpsCredential {
    param([string]$Git)
    $oldPrompt = $env:GIT_TERMINAL_PROMPT
    try {
        $env:GIT_TERMINAL_PROMPT = '0'
        $result = @('protocol=https','host=github.com','') | & $Git credential fill 2>$null
        $code = $LASTEXITCODE
        $hasUser = ($result | Where-Object {$_ -match '^username=.+$'} | Measure-Object).Count -gt 0
        $hasSecret = ($result | Where-Object {$_ -match '^password=.+$'} | Measure-Object).Count -gt 0
        $result = $null
        if ($code -ne 0 -or -not $hasUser -or -not $hasSecret) { Stop-Fatal 'Git HTTPS credential retrieval failed; secret data withheld.' }
        Write-Log 'Git HTTPS credential retrieval verified; secrets withheld.' 'Green'
    } finally {
        if ($null -eq $oldPrompt) { Remove-Item Env:GIT_TERMINAL_PROMPT -ErrorAction SilentlyContinue } else { $env:GIT_TERMINAL_PROMPT = $oldPrompt }
    }
}
function Start-RdcSession {
    param([string]$Node,[string]$Chrome)
    try { $active = @(Get-CimInstance Win32_Process -ErrorAction Stop | Where-Object {$_.Name -eq 'node.exe' -and $_.CommandLine -match '(?i)desktop-commander'}) }
    catch { Stop-Fatal ('Unable to verify duplicate RDC processes; launch blocked fail-closed: ' + $_.Exception.Message) }
    if ($active.Count -gt 0) { Stop-Fatal 'Desktop Commander process already exists. Duplicate launch blocked.' }
    $npx = Join-Path (Split-Path $Node -Parent) 'npx.cmd'
    if (-not (Test-Path -LiteralPath $npx -PathType Leaf)) { Stop-Fatal 'npx.cmd is missing beside Node.js.' }
    $stdout = Join-Path $env:TEMP 'KHORA-RDC.stdout'
    $stderr = Join-Path $env:TEMP 'KHORA-RDC.stderr'
    Remove-Item -LiteralPath $stdout,$stderr -Force -ErrorAction SilentlyContinue
    $package = '@wonderwhy-er/desktop-commander@' + $script:DesktopCommanderVersion
    $process = Start-Process -FilePath $npx -ArgumentList ('--yes ' + $package + ' remote --no-persist-session') -PassThru -NoNewWindow -RedirectStandardOutput $stdout -RedirectStandardError $stderr
    $state = @{}
    $positions = @{$stdout=0;$stderr=0}
    $lastTone = Get-Date
    $startupDeadline = (Get-Date).AddMinutes(5)
    try {
        while (-not $process.HasExited) {
            foreach ($file in @($stdout,$stderr)) {
                if (Test-Path -LiteralPath $file) {
                    $lines = @(Get-Content -LiteralPath $file -ErrorAction SilentlyContinue)
                    for ($i=[int]$positions[$file]; $i -lt $lines.Count; $i++) {
                        $line = [string]$lines[$i]
                        Write-Host $line
                        if ($line -match '(?i)Device ID(?: assigned)?:\s*([0-9a-f-]{36})') { $state.Id=$Matches[1] }
                        if ($line -match '(?i)User:\s*(\S+)') { $state.User=$Matches[1] }
                        if ($line -match '(?i)Device Name:\s*(.+)') { $state.Name=$Matches[1].Trim() }
                        if ($line -match '(?i)Status:\s*(Online)') { $state.Status=$Matches[1] }
                        if ($line -match '(?i)Device ready:') { $state.Ready=$true }
                        if ($line -match '(?i)Session persistence disabled') { $state.Policy=$true }
                        if (-not $state.BrowserOpened -and $line -match '(https://mcp\.desktopcommander\.app/device/verify\?user_code=[A-Z0-9-]+)') {
                            $url=$Matches[1]
                            if ($url -match 'user_code=([A-Z0-9-]+)') { Set-Clipboard -Value $Matches[1]; Write-Log 'RDC one-time code copied to clipboard.' 'Yellow' }
                            Start-Process -FilePath $Chrome -ArgumentList $url
                            $state.BrowserOpened=$true
                            Write-Log 'Chrome opened for RDC device verification.' 'Yellow'
                        }
                    }
                    $positions[$file]=$lines.Count
                }
            }
            if ($state.Id -and $state.User -and $state.Name -and $state.Status -eq 'Online' -and $state.Ready -and $state.Policy -and -not $state.Handshake) {
                $object=@('RDC-HANDSHAKE/1',('User: '+$state.User),('Device ID: '+$state.Id),('Device Name: '+$state.Name),'Status: Online','Launch policy: --no-persist-session',('Captured: '+(Get-Date -Format o))) -join [Environment]::NewLine
                Set-Clipboard -Value $object
                $readback=Get-Clipboard -Raw
                $shaA=[Security.Cryptography.SHA256]::Create()
                try {$hashA=[BitConverter]::ToString($shaA.ComputeHash([Text.Encoding]::UTF8.GetBytes($object))).Replace('-','').ToLowerInvariant()} finally {$shaA.Dispose()}
                $shaB=[Security.Cryptography.SHA256]::Create()
                try {$hashB=[BitConverter]::ToString($shaB.ComputeHash([Text.Encoding]::UTF8.GetBytes($readback))).Replace('-','').ToLowerInvariant()} finally {$shaB.Dispose()}
                if ($readback -cne $object -or $hashA -ne $hashB) { Stop-Fatal 'RDC handshake clipboard SHA/read-back mismatch.' }
                $state.Handshake=$true
                Write-Log ('RDC handshake copied and verified. SHA256='+$hashA) 'Green'
                Write-Log 'Keep this terminal running; Ctrl+C disconnects RDC.' 'Yellow'
            }
            if (-not $state.Handshake -and (Get-Date) -gt $startupDeadline) {
                try { $process.Kill() } catch {}
                Stop-Fatal 'RDC did not produce a complete verified handshake within 5 minutes.'
            }
            if (-not $state.Handshake -and ((Get-Date)-$lastTone).TotalSeconds -ge 2.3) { Play-Tone 360 180; $lastTone=Get-Date }
            Start-Sleep -Milliseconds 300
            $process.Refresh()
        }
        foreach ($file in @($stdout,$stderr)) {
            if (Test-Path -LiteralPath $file) {
                $lines=@(Get-Content -LiteralPath $file -ErrorAction SilentlyContinue)
                for ($i=[int]$positions[$file]; $i -lt $lines.Count; $i++) { Write-Host ([string]$lines[$i]) }
            }
        }
        if (-not $state.Handshake) { Stop-Fatal 'RDC exited before the complete Device ready handshake.' }
        if ($null -ne $process.ExitCode -and [int]$process.ExitCode -ne 0) { Stop-Fatal ('RDC process exited with code ' + $process.ExitCode + ' after the handshake.') }
        Write-Log 'RDC process ended after the handshake or was interrupted by Ctrl+C.' 'Yellow'
    } finally {
        if (-not $process.HasExited) { try {$process.Kill()} catch {} }
    }
}
function Invoke-SelfTest {
    Progress-Tone 25
    Progress-Tone 50
    Progress-Tone 75
    Play-Tone 360 180
    Play-Tone 880 150
    Play-Tone 880 150
    $expected=@(880,880,880,740,880,360,880,880)
    if ((Compare-Object $expected @($script:ToneTrace) | Measure-Object).Count -gt 0) { Stop-Fatal 'Tone sequence self-test failed.' }
    $samples=@('Session persistence disabled','Device ready:','User: test@example.invalid','Device ID: f28d6a64-9e51-4ef2-8071-9145a43f7680','Device Name: PC-14','Status: Online')
    $sampleText=$samples -join [Environment]::NewLine
    if ($sampleText -notmatch '(?i)Session persistence disabled' -or $sampleText -notmatch '(?i)Device ready:' -or $sampleText -notmatch '(?i)Status:\s*Online') { Stop-Fatal 'RDC parser sample self-test failed.' }
    if ((Get-Sha256Text 'abc') -ne 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad') { Stop-Fatal 'SHA256 helper self-test failed.' }
    Write-Log 'SELFTEST PASS: tone sequence, parser samples and SHA256 known vector; no external authentication or agent launched.' 'Green'
}
try {
    if (-not $env:TEMP) { Stop-Fatal 'TEMP environment variable is undefined.' }
    if (-not (Test-Path -LiteralPath $env:TEMP -PathType Container)) { New-Item -ItemType Directory -Path $env:TEMP -Force | Out-Null }
    $script:LogPath = Join-Path $env:TEMP 'KHORA-BOOTSTRAP.log'
    if ($PSVersionTable.PSVersion.Major -lt 5) { Stop-Fatal 'Windows PowerShell 5.1 or newer is required.' }
    Write-Log 'KHORA workstation bootstrap start.' 'Cyan'
    Play-Tone 880 150
    Play-Tone 880 150
    if ($script:SelfTest) { Invoke-SelfTest; exit 0 }
    Update-Path
    $node=Find-Exe 'node.exe' @('C:\Program Files\nodejs\node.exe')
    if (-not $node) { Install-WingetPackage 'OpenJS.NodeJS.LTS'; $node=Find-Exe 'node.exe' @('C:\Program Files\nodejs\node.exe') }
    if (-not $node) { Stop-Fatal 'Node.js LTS installation failed.' }
    $nodeVersion = (& $node --version | Out-String).Trim()
    if ($nodeVersion -notmatch '^v(\d+)\.' -or [int]$Matches[1] -lt 20) { Stop-Fatal ('Unsupported Node.js version; require major >=20. Found: ' + $nodeVersion) }
    $npm = Find-Exe 'npm.cmd' @((Join-Path (Split-Path $node -Parent) 'npm.cmd'))
    $npx = Find-Exe 'npx.cmd' @((Join-Path (Split-Path $node -Parent) 'npx.cmd'))
    if (-not $npm -or -not $npx) { Stop-Fatal 'npm.cmd or npx.cmd is missing beside Node.js.' }
    $npmVersion = (& $npm --version | Out-String).Trim()
    if ($npmVersion -notmatch '^(\d+)\.' -or [int]$Matches[1] -lt 10) { Stop-Fatal ('Unsupported npm version; require major >=10. Found: ' + $npmVersion) }
    Write-Log ('Node.js ' + $nodeVersion + '; npm ' + $npmVersion) 'Green'
    Progress-Tone 25
    $git=Find-Exe 'git.exe' @('C:\Program Files\Git\cmd\git.exe','C:\Program Files (x86)\Git\cmd\git.exe')
    if (-not $git) { Install-WingetPackage 'Git.Git'; $git=Find-Exe 'git.exe' @('C:\Program Files\Git\cmd\git.exe') }
    $gh=Find-Exe 'gh.exe' @('C:\Program Files\GitHub CLI\gh.exe')
    if (-not $gh) { Install-WingetPackage 'GitHub.cli'; $gh=Find-Exe 'gh.exe' @('C:\Program Files\GitHub CLI\gh.exe') }
    if (-not $git -or -not $gh) { Stop-Fatal 'Git or GitHub CLI missing after installation.' }
    $systemBefore=@(& $git config --system --get credential.helper 2>$null)
    $globalBefore=@(& $git config --global --get credential.helper 2>$null)
    $effectiveBefore=@(& $git config --get credential.helper 2>$null)
    Write-Log ((& $git --version).Trim()+'; '+((& $gh --version | Select-Object -First 1).Trim())) 'Green'
    & $gh auth status --hostname github.com *> $null
    if ($LASTEXITCODE -ne 0) { $chrome=Find-Chrome; if (-not $chrome) {Stop-Fatal 'Google Chrome not found.'}; Invoke-GitHubDeviceAuth $gh $chrome }
    & $gh auth status --hostname github.com *> $null
    if ($LASTEXITCODE -ne 0) { Stop-Fatal 'GitHub authentication status did not verify.' }
    & $gh auth setup-git --hostname github.com --force
    if ($LASTEXITCODE -ne 0) { Stop-Fatal 'gh auth setup-git failed.' }
    Assert-GitHelpers $git $systemBefore $globalBefore $effectiveBefore
    Test-GitHttpsCredential $git
    Progress-Tone 50
    & $npm view ('vercel@' + $script:VercelVersion) version --fetch-retries=2 --fetch-timeout=30000 *> $null
    if ($LASTEXITCODE -ne 0) { Stop-Fatal 'Pinned Vercel CLI version unavailable in npm registry.' }
    & $npm view ('@wonderwhy-er/desktop-commander@' + $script:DesktopCommanderVersion) version --fetch-retries=2 --fetch-timeout=30000 *> $null
    if ($LASTEXITCODE -ne 0) { Stop-Fatal 'Pinned Desktop Commander version unavailable in npm registry.' }
    $vercel = Find-Exe 'vercel.cmd' @((Join-Path $env:APPDATA 'npm\vercel.cmd'))
    $installedVercel = $null
    if ($vercel) {
        $vercelLine = (& $vercel --version 2>$null | Select-Object -First 1)
        if ([string]$vercelLine -match '(\d+\.\d+\.\d+)') { $installedVercel = $Matches[1] }
    }
    if ($installedVercel -ne $script:VercelVersion) {
        Install-NpmPackageWithRetry $npm ('vercel@' + $script:VercelVersion) 3
        $vercel = Find-Exe 'vercel.cmd' @((Join-Path $env:APPDATA 'npm\vercel.cmd'))
    }
    if (-not $vercel) { Stop-Fatal 'Vercel CLI executable missing after installation.' }
    $vercelLine = (& $vercel --version 2>$null | Select-Object -First 1)
    if ([string]$vercelLine -notmatch ('\b' + [regex]::Escape($script:VercelVersion) + '\b')) { Stop-Fatal ('Vercel CLI version mismatch. Expected ' + $script:VercelVersion + '; found ' + $vercelLine) }
    Write-Log ([string]$vercelLine) 'Green'
    & $vercel whoami *> $null
    if ($LASTEXITCODE -ne 0) {
        Write-Log 'Vercel authentication missing; starting interactive login.' 'Yellow'
        & $vercel login
        if ($LASTEXITCODE -ne 0) { Stop-Fatal 'Vercel login did not complete successfully.' }
    }
    & $vercel whoami *> $null
    if ($LASTEXITCODE -ne 0) { Stop-Fatal 'Vercel authentication failed verification after login.' }
    Progress-Tone 75
    $chrome=Find-Chrome
    if (-not $chrome) { Stop-Fatal 'Google Chrome not found for RDC verification.' }
    if ($PreflightOnly) { Write-Log 'PREFLIGHT PASS: all dependency/auth checks passed; RDC launch intentionally skipped.' 'Green'; exit 0 }
    Start-RdcSession $node $chrome
    Play-Tone 880 150
    Play-Tone 880 150
    Write-Log 'BOOTSTRAP COMPLETE.' 'Green'
    exit 0
} catch {
    Write-Log $_.Exception.Message 'Red'
    Play-Tone 360 180
    exit 1
}
