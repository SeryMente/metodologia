[CmdletBinding()]
param([string]$WorkRoot)
# Windows PowerShell 5.1; ASCII-only. Chrome is intentionally never touched.
Set-StrictMode -Version 2.0
$ErrorActionPreference='Stop'
[Net.ServicePointManager]::SecurityProtocol=[Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$script:RunId=Get-Date -Format 'yyyyMMdd-HHmmss'
$script:LogPath=$null
$script:RunMutex=$null
$script:RunMutexOwned=$false
$script:RunMutexAbandoned=$false
$script:GitPath=$null
$script:OriginalGhToken=[Environment]::GetEnvironmentVariable('GH_TOKEN','Process')
$script:OriginalGitTerminalPrompt=[Environment]::GetEnvironmentVariable('GIT_TERMINAL_PROMPT','Process')
$script:OriginalGitConfig=@{}
foreach ($n in @('GIT_CONFIG_COUNT','GIT_CONFIG_KEY_0','GIT_CONFIG_VALUE_0','GIT_CONFIG_KEY_1','GIT_CONFIG_VALUE_1')) {
    $script:OriginalGitConfig[$n]=[Environment]::GetEnvironmentVariable($n,'Process')
}
function Write-Log([string]$Message) {
    $safeMessage=[regex]::Replace($Message,'(?i)(gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,})','[REDACTED]')
    $line='{0} | {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fffK'),$safeMessage
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
    # Never import the elevated account's user PATH; only machine and Fila4 locations are eligible.
    $env:Path=@($env:Path,[Environment]::GetEnvironmentVariable('Path','Machine'),
        (Join-Path $env:ProgramFiles 'Git\cmd'),(Join-Path $env:ProgramFiles 'nodejs'),(Join-Path $env:ProgramFiles 'GitHub CLI'),
        (Join-Path $env:LOCALAPPDATA 'Programs\Git'),(Join-Path $env:LOCALAPPDATA 'Programs\Git\cmd'),
        (Join-Path $env:LOCALAPPDATA 'Programs\nodejs'),(Join-Path $env:LOCALAPPDATA 'Programs\GitHub CLI'),
        (Join-Path $env:LOCALAPPDATA 'Microsoft\WinGet\Links'),(Join-Path $env:APPDATA 'npm')) -join ';'
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
function Invoke-GitHubApi {
    param([Parameter(Mandatory=$true)][string]$Path)
    $secret=[Environment]::GetEnvironmentVariable('GH_TOKEN','Process')
    if ([string]::IsNullOrWhiteSpace($secret)) { throw 'GITHUB_TOKEN_MISSING' }
    $headers=@{
        Authorization=('Bearer '+$secret)
        Accept='application/vnd.github+json'
        'X-GitHub-Api-Version'='2026-03-10'
        'User-Agent'='EP-bootstrap'
    }
    try { return Invoke-RestMethod -Method Get -Uri ('https://api.github.com'+$Path) -Headers $headers -TimeoutSec 30 -ErrorAction Stop }
    finally { $headers=$null; $secret=$null }
}
function Ensure-GitHubAccess {
    Write-Host ''
    Write-Host 'A new GitHub token is required for this run; any stored credential is ignored.'
    Write-Host 'Copy a PAT authorized for ALL required repositories, including private GDP and KHORA.'
    Write-Host 'For a fine-grained PAT: select these repositories and grant Contents: Read-only plus Metadata: Read-only.'
    Write-Host 'Do not paste the token into this console. Copy it to the clipboard; it will be read silently and not logged.'
    [void](Read-Host 'After copying the updated token, press Enter')
    $token=''
    try {
        $token=[string](Get-Clipboard -Raw -ErrorAction Stop)
        $token=$token.Trim()
        if ($token -notmatch '^(gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,})$') {
            throw 'CLIPBOARD_TOKEN_NOT_RECOGNIZED: copy a valid GitHub PAT (ghp_... or github_pat_...) and retry.'
        }
        $env:GH_TOKEN=$token
        $tokenKind=if ($token.StartsWith('github_pat_')) { 'FINE_GRAINED' } else { 'CLASSIC_OR_OTHER' }
        $env:GIT_TERMINAL_PROMPT='0'

        $auth=Invoke-GitHubApi -Path '/user'
        $account=[string]$auth.login
        if ([string]::IsNullOrWhiteSpace($account)) { throw 'GITHUB_TOKEN_REJECTED_BY_API: login missing.' }

        $targets=@('SeryMente/metodologia','SeryMente/otrogranprograma','SeryMente/GDP','SeryMente/signal-interpreter','SeryMente/khora')
        foreach ($repo in $targets) {
            $probe=Invoke-GitHubApi -Path ('/repos/'+$repo+'/git/ref/heads/main')
            if ([string]$probe.ref -ne 'refs/heads/main') {
                throw "PAT_CONTENTS_READ_FAILED: $repo; expected refs/heads/main."
            }
        }

        # Git transport uses only process-level configuration; no token is written to a config file.
        $basic=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes(($account+':'+$token)))
        $token=$null
        $env:GIT_CONFIG_COUNT='1'
        $env:GIT_CONFIG_KEY_0='http.extraHeader'
        $env:GIT_CONFIG_VALUE_0='AUTHORIZATION: basic '+$basic
        $basic=$null
        Write-Log ('GITHUB_TOKEN=VERIFIED | ACCOUNT='+$account+' | TYPE='+$tokenKind+' | API_CONTENTS_READ=VERIFIED_FOR_ALL_REPOSITORIES | GIT_AUTH=EPHEMERAL_HTTP_EXTRAHEADER')
    } finally {
        $token=$null
        $basic=$null
        try {
            $clipboardAfter=[string](Get-Clipboard -Raw -ErrorAction Stop)
            if ($clipboardAfter.Trim() -match '^(gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,})$') {
                Set-Clipboard -Value '' -ErrorAction SilentlyContinue
            }
        } catch {}
    }
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
function Resolve-Node {
    Refresh-Path
    $x=Get-Command node.exe -ErrorAction SilentlyContinue
    if ($x -and $x.Source) { return $x.Source }
    $candidates=@()
    if ($env:ProgramFiles) { $candidates += (Join-Path $env:ProgramFiles 'nodejs\node.exe') }
    if ($env:LOCALAPPDATA) { $candidates += (Join-Path $env:LOCALAPPDATA 'Programs\nodejs\node.exe') }
    foreach ($p in $candidates) { if ($p -and (Test-Path -LiteralPath $p -PathType Leaf)) { return $p } }
    return $null
}
function Ensure-HostToolchain {
    $git=Resolve-Git
    if (-not $git) {
        $wg=Find-Winget
        if (-not $wg) { throw 'GIT_NOT_FOUND_AND_WINGET_UNAVAILABLE' }
        $install=Invoke-NativeCaptured -Executable $wg -Arguments @('install','--id','Git.Git','-e','--source','winget','--accept-source-agreements','--accept-package-agreements','--silent') -Label 'INSTALL_GIT'
        $deadline=(Get-Date).AddSeconds(60)
        do { $git=Resolve-Git; if (-not $git) { Start-Sleep -Milliseconds 500 } } while (-not $git -and (Get-Date) -lt $deadline)
        if (-not $git) { throw "GIT_INSTALL_NOT_VERIFIED: exit=$($install.ExitCode)" }
    }
    $gitVersion=Invoke-NativeCaptured -Executable $git -Arguments @('--version') -Label 'GIT_VERSION'
    if ($gitVersion.ExitCode -ne 0) { throw 'GIT_VERSION_CHECK_FAILED' }
    $script:GitPath=$git
    $env:Path="$(Split-Path -Parent $git);$env:Path"

    $node=Resolve-Node
    $npx=Resolve-Npx
    $needsInstall=$false
    if (-not $node -or -not $npx) {
        $needsInstall=$true
    } else {
        $versionResult=Invoke-NativeCaptured -Executable $node -Arguments @('--version') -Label 'NODE_VERSION_CHECK'
        if ($versionResult.ExitCode -ne 0) { $needsInstall=$true }
        else {
            $versionText=($versionResult.Lines -join '').Trim().TrimStart('v')
            try { if ([version]$versionText -lt [version]'22.12.0') { $needsInstall=$true } } catch { $needsInstall=$true }
        }
    }
    if ($needsInstall) {
        $wg=Find-Winget
        if (-not $wg) { throw 'NODE_NPX_NOT_READY_AND_WINGET_UNAVAILABLE' }
        $install=Invoke-NativeCaptured -Executable $wg -Arguments @('install','--id','OpenJS.NodeJS.LTS','-e','--source','winget','--accept-source-agreements','--accept-package-agreements','--silent') -Label 'INSTALL_NODE_LTS'
        $env:Path="$env:ProgramFiles\nodejs;$env:LOCALAPPDATA\Programs\nodejs;$env:APPDATA\npm;$env:Path"
        $deadline=(Get-Date).AddSeconds(60)
        do {
            $node=Resolve-Node
            $npx=Resolve-Npx
            if (-not $node -or -not $npx) { Start-Sleep -Milliseconds 500 }
        } while ((-not $node -or -not $npx) -and (Get-Date) -lt $deadline)
        if (-not $node -or -not $npx) { throw "NODE_NPX_INSTALL_NOT_VERIFIED: exit=$($install.ExitCode)" }
    }
    $env:Path="$env:ProgramFiles\nodejs;$env:LOCALAPPDATA\Programs\nodejs;$env:APPDATA\npm;$env:Path"
    $nodeVersion=Invoke-NativeCaptured -Executable $node -Arguments @('--version') -Label 'NODE_VERSION'
    $versionText=($nodeVersion.Lines -join '').Trim().TrimStart('v')
    try { $parsedNodeVersion=[version]$versionText } catch { throw "NODE_VERSION_INVALID: $versionText" }
    if ($nodeVersion.ExitCode -ne 0 -or $parsedNodeVersion -lt [version]'22.12.0') { throw "NODE_TOO_OLD_OR_INVALID: $versionText; minimum 22.12.0" }

    $npmCmd=Join-Path (Split-Path -Parent $node) 'npm.cmd'
    if (-not (Test-Path -LiteralPath $npmCmd -PathType Leaf)) {
        $npm=Get-Command npm.cmd -ErrorAction SilentlyContinue
        if ($npm -and $npm.Source) { $npmCmd=$npm.Source }
    }
    if (-not (Test-Path -LiteralPath $npmCmd -PathType Leaf)) { throw 'NPM_CMD_NOT_FOUND' }
    $npmVersion=Invoke-NativeCaptured -Executable $npmCmd -Arguments @('--version') -Label 'NPM_VERSION'
    if ($npmVersion.ExitCode -ne 0) { throw 'NODE_NPM_VERSION_CHECK_FAILED' }
    $script:NpxCmd=$npx
    Write-Log 'HOST_TOOLCHAIN=GIT_NODE_NPM_NPX_VERIFIED'
}
function Normalize-Origin([string]$Value) {
    $v=$Value.Trim() -replace '^git@github\.com:','https://github.com/' -replace '^ssh://git@github\.com/','https://github.com/' -replace '\.git$',''
    return $v.TrimEnd('/').ToLowerInvariant()
}
function Sync-Repo([string]$Repo,[string]$Destination) {
    $expected=('https://github.com/'+$Repo).ToLowerInvariant()
    if ((Test-Path -LiteralPath $Destination) -and -not (Test-Path -LiteralPath (Join-Path $Destination '.git'))) {
        $leftovers=@(Get-ChildItem -LiteralPath $Destination -Force -ErrorAction Stop)
        if ($leftovers.Count -eq 0) {
            Remove-Item -LiteralPath $Destination -Force
            Write-Log ('EMPTY_FAILED_CLONE_DIR_REMOVED='+$Destination)
        } else {
            throw "DESTINATION_EXISTS_NOT_GIT: $Destination; non-empty directory preserved to protect local data."
        }
    }
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
        $cloneUrl=$expected + '.git'
        $cloneArguments=@('clone','--',$cloneUrl,$Destination)
        Write-Log ('CLONE_ARGUMENTS_VERIFIED | '+$Repo+' | URL='+$cloneUrl+' | DESTINATION='+$Destination)
        $r=Invoke-NativeCaptured -Executable $script:GitPath -Arguments $cloneArguments -Label ('CLONE '+$Repo)
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
function Test-ObsModuleRegistration([string]$ModulePath,[string]$View) {
    if (-not (Test-Path -LiteralPath $ModulePath -PathType Leaf)) { return $false }
    $reg=Join-Path $env:SystemRoot 'System32\reg.exe'
    $key='HKLM\SOFTWARE\Classes\CLSID\{A3FCE0F5-3493-419F-958A-ABA1250EC20B}\InprocServer32'
    $r=Invoke-NativeCaptured -Executable $reg -Arguments @('query',$key,'/ve',('/reg:'+$View)) -Quiet
    if ($r.ExitCode -ne 0) { return $false }
    $actual=$r.Lines -join [Environment]::NewLine
    $expected=[System.IO.Path]::GetFullPath($ModulePath)
    return ($actual.IndexOf($expected,[StringComparison]::OrdinalIgnoreCase) -ge 0)
}
function Get-FrameServerValue([string]$RegistryPath) {
    try {
        $item=Get-ItemProperty -LiteralPath $RegistryPath -Name 'EnableFrameServerMode' -ErrorAction Stop
        return [int]$item.EnableFrameServerMode
    } catch { return -1 }
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
    if (-not [Environment]::Is64BitOperatingSystem) { throw 'OBS_VIRTUAL_CAMERA_REQUIRES_64BIT_WINDOWS' }
    $root=Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $obs))
    $dll64=Join-Path $root 'data\obs-plugins\win-dshow\obs-virtualcam-module64.dll'
    $dll32=Join-Path $root 'data\obs-plugins\win-dshow\obs-virtualcam-module32.dll'
    if (-not (Test-Path -LiteralPath $dll64 -PathType Leaf)) { throw ('OBS_VIRTUALCAM_MODULE64_MISSING='+$dll64) }
    $hasDll32=Test-Path -LiteralPath $dll32 -PathType Leaf
    if (-not $hasDll32) { Write-Log 'OBS_VCAM_MODULE32=NOT_PRESENT | 64-bit Chrome compatibility will be validated separately.' }

    $reg64Ok=Test-ObsModuleRegistration -ModulePath $dll64 -View '64'
    $reg32Ok=$true
    if ($hasDll32) { $reg32Ok=Test-ObsModuleRegistration -ModulePath $dll32 -View '32' }

    $os=Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
    $enableFrameServerMode=([int]$os.BuildNumber -ge 22621)
    $frameServerPaths=@(
        'HKLM:\SOFTWARE\Microsoft\Windows Media Foundation\Platform',
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows Media Foundation\Platform'
    )
    $frameServerNeedsChange=$false
    if ($enableFrameServerMode) {
        foreach ($rp in $frameServerPaths) {
            if ((Get-FrameServerValue $rp) -ne 1) { $frameServerNeedsChange=$true }
        }
    }

    if (-not $reg64Ok -or ($hasDll32 -and -not $reg32Ok) -or $frameServerNeedsChange) {
        # Elevate only the token-free camera-registration command. Use EncodedCommand
        # so no mutable helper script is executed from the user's writable TEMP folder.
        $module64Literal="'" + $dll64.Replace("'","''") + "'"
        $module32Literal="'" + $(if ($hasDll32) { $dll32.Replace("'","''") } else { '' }) + "'"
        $frameServerLiteral=if ($enableFrameServerMode) { '$true' } else { '$false' }
        $adminCode=@'
$ErrorActionPreference='Stop'
$Module64=__MODULE64__
$Module32=__MODULE32__
$EnableFrameServerMode=__ENABLE__
try {
    $reg64=Join-Path $env:SystemRoot 'System32\regsvr32.exe'
    if (-not (Test-Path -LiteralPath $Module64 -PathType Leaf)) { exit 21 }
    & $reg64 /s /i $Module64
    if ($LASTEXITCODE -ne 0) { exit 64 }
    if ($Module32 -and (Test-Path -LiteralPath $Module32 -PathType Leaf)) {
        $reg32=Join-Path $env:SystemRoot 'SysWOW64\regsvr32.exe'
        if (-not (Test-Path -LiteralPath $reg32 -PathType Leaf)) { exit 32 }
        & $reg32 /s /i $Module32
        if ($LASTEXITCODE -ne 0) { exit 33 }
    }
    if ($EnableFrameServerMode) {
        $paths=@(
            'HKLM:\SOFTWARE\Microsoft\Windows Media Foundation\Platform',
            'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows Media Foundation\Platform'
        )
        foreach ($p in $paths) {
            if (-not (Test-Path -LiteralPath $p)) { New-Item -Path $p -Force | Out-Null }
            New-ItemProperty -LiteralPath $p -Name 'EnableFrameServerMode' -PropertyType DWord -Value 1 -Force | Out-Null
            $v=Get-ItemProperty -LiteralPath $p -Name 'EnableFrameServerMode' -ErrorAction Stop
            if ([int]$v.EnableFrameServerMode -ne 1) { exit 65 }
        }
    }
    exit 0
} catch { exit 66 }
'@
        $adminCode=$adminCode.Replace('__MODULE64__',$module64Literal).Replace('__MODULE32__',$module32Literal).Replace('__ENABLE__',$frameServerLiteral)
        $encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($adminCode))
        $ps64=Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
        $argsLine='-NoProfile -ExecutionPolicy Bypass -EncodedCommand '+$encoded
        $elevated=Start-Process -FilePath $ps64 -ArgumentList $argsLine -Verb RunAs -Wait -PassThru -ErrorAction Stop
        if ($elevated.ExitCode -ne 0) { throw ('OBS_VCAM_ELEVATED_SETUP_FAILED: exit='+$elevated.ExitCode+'; approve the Windows elevation prompt and retry if it was declined.') }
    }

    if (-not (Test-ObsModuleRegistration -ModulePath $dll64 -View '64')) { throw 'OBS_VCAM_REGISTRATION_64BIT_NOT_VERIFIED' }
    Write-Log 'OBS_VCAM_REGISTRATION_64BIT=VERIFIED'
    if ($hasDll32) {
        if (-not (Test-ObsModuleRegistration -ModulePath $dll32 -View '32')) { throw 'OBS_VCAM_REGISTRATION_32BIT_NOT_VERIFIED' }
        Write-Log 'OBS_VCAM_REGISTRATION_32BIT=VERIFIED'
    }
    $frameServerChanged=$enableFrameServerMode -and $frameServerNeedsChange
    if ($enableFrameServerMode) {
        foreach ($rp in $frameServerPaths) {
            if ((Get-FrameServerValue $rp) -ne 1) { throw ('WINDOWS_MEDIA_FOUNDATION_FRAME_SERVER_NOT_ENABLED='+$rp) }
        }
        Write-Log 'WINDOWS_MEDIA_FOUNDATION_FRAME_SERVER=ENABLED_BOTH_REGISTRY_VIEWS'
        if ($frameServerChanged) {
            Write-Log 'CAMERA_RESTART_MAY_BE_REQUIRED=TRUE | Frame Server settings changed; no Windows restart was issued (reboot budget=0).'
        } else {
            Write-Log 'CAMERA_FRAME_SERVER_SETTINGS=ALREADY_ENABLED'
        }
    } else {
        Write-Log ('WINDOWS_MEDIA_FOUNDATION_FRAME_SERVER=NOT_REQUIRED_FOR_BUILD_'+$os.BuildNumber)
    }

    $active=$false
    foreach ($p in @(Get-CimInstance Win32_Process -Filter "name='obs64.exe'" -ErrorAction SilentlyContinue)) {
        if (Test-ObsLog $p.CreationDate) { $active=$true; break }
    }
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
    if (Test-Path -LiteralPath $pnputil) {
        $scan=Invoke-NativeCaptured -Executable $pnputil -Arguments @('/scan-devices') -Label 'PNP_RESCAN'
        if ($scan.ExitCode -ne 0) { Write-Log ('PNP_RESCAN_EXIT='+$scan.ExitCode) }
    }
    $gp=Get-Command Get-PnpDevice -ErrorAction SilentlyContinue
    if ($gp) {
        $devices=@(Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.FriendlyName -match '(?i)OBS.*Virtual Camera|Virtual Camera.*OBS' })
        if ($devices.Count -gt 0) {
            foreach ($d in $devices) { Write-Log ('OBS_PNP_DEVICE='+$d.FriendlyName+' | STATUS='+$d.Status) }
        } else {
            Write-Log 'OBS_PNP_DEVICE=NOT_LISTED_BY_GET_PNPDEVICE | non-fatal; OBS uses a registered virtual capture filter, not necessarily a PnP node.'
        }
    }
    Write-Log 'CHROME_CAMERA_PREREQUISITES=VERIFIED | 64-bit capture filter registered and OBS virtual output active; Chrome itself remains untouched and is not browser-probed.'
}
# Resolve the authorized data profile by Windows profile/SID, never by the elevated process's Desktop.
$currentIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent().Name
if ($currentIdentity -notmatch '(?i)(^|\\)mantenimientorci$') { throw "WRONG_EXECUTION_IDENTITY: expected elevated MantenimientoRCI, got $currentIdentity" }
$principal=[System.Security.Principal.WindowsPrincipal]::new([System.Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) { throw 'MANTENIMIENTORCI_NOT_ELEVATED' }
$profiles=@(Get-CimInstance Win32_UserProfile -ErrorAction Stop | Where-Object {
    $profile=$_
    if ($profile.Special -or [string]::IsNullOrWhiteSpace([string]$profile.LocalPath) -or [string]::IsNullOrWhiteSpace([string]$profile.SID)) { return $false }
    $account=''
    try { $account=([System.Security.Principal.SecurityIdentifier]::new([string]$profile.SID)).Translate([System.Security.Principal.NTAccount]).Value } catch {}
    if ($account -match '(?i)(^|\\)fila4$') { return $true }
    return ((Split-Path -Leaf ([string]$profile.LocalPath)) -match '(?i)^fila4([._-].*)?$')
})
if ($profiles.Count -ne 1) { throw "FILA4_PROFILE_NOT_UNIQUE: matches=$($profiles.Count); no profile files were created." }
$script:Fila4Sid=[string]$profiles[0].SID
$script:Fila4ProfileRoot=[System.IO.Path]::GetFullPath([string]$profiles[0].LocalPath).TrimEnd('\')
if (-not (Test-Path -LiteralPath $script:Fila4ProfileRoot -PathType Container)) { throw 'FILA4_PROFILE_DIRECTORY_MISSING' }
$driveRoot=[System.IO.Path]::GetPathRoot($script:Fila4ProfileRoot)
$homePath='\' + $script:Fila4ProfileRoot.Substring($driveRoot.Length).TrimStart('\')
$desktop=Join-Path $script:Fila4ProfileRoot 'Desktop'
$desktopKey='Registry::HKEY_USERS\'+$script:Fila4Sid+'\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
$userEnvKey='Registry::HKEY_USERS\'+$script:Fila4Sid+'\Environment'
if (Test-Path -LiteralPath $desktopKey) {
    $shellFolders=Get-ItemProperty -LiteralPath $desktopKey -ErrorAction Stop
    $desktopRaw=[string]$shellFolders.Desktop
    if (-not [string]::IsNullOrWhiteSpace($desktopRaw)) {
        $desktopResolved=$desktopRaw.Replace('%USERPROFILE%',$script:Fila4ProfileRoot).Replace('%userprofile%',$script:Fila4ProfileRoot)
        $desktopResolved=$desktopResolved.Replace('%HOMEDRIVE%',$driveRoot.TrimEnd('\')).Replace('%homedrive%',$driveRoot.TrimEnd('\'))
        $desktopResolved=$desktopResolved.Replace('%HOMEPATH%',$homePath).Replace('%homepath%',$homePath)
        if (Test-Path -LiteralPath $userEnvKey) {
            $userVars=Get-ItemProperty -LiteralPath $userEnvKey -ErrorAction SilentlyContinue
            if ($null -ne $userVars) {
                foreach ($property in $userVars.PSObject.Properties) {
                    if ($property.Name -notmatch '^PS' -and $property.Value -is [string]) {
                        $desktopResolved=$desktopResolved.Replace('%'+$property.Name+'%',[string]$property.Value)
                        $desktopResolved=$desktopResolved.Replace('%'+$property.Name.ToLowerInvariant()+'%',[string]$property.Value)
                    }
                }
            }
        }
        if ($desktopResolved -match '%[^%]+%') { throw "FILA4_DESKTOP_ENVIRONMENT_UNRESOLVED: $desktopRaw" }
        if (-not [System.IO.Path]::IsPathRooted($desktopResolved)) { throw 'FILA4_DESKTOP_NOT_ABSOLUTE' }
        $desktop=[System.IO.Path]::GetFullPath($desktopResolved)
    }
}
$fila4Prefix=$script:Fila4ProfileRoot.TrimEnd('\')+'\'
if (-not $desktop.StartsWith($fila4Prefix,[System.StringComparison]::OrdinalIgnoreCase)) { throw "FILA4_DESKTOP_OUTSIDE_PROFILE_TREE: $desktop" }
if (-not (Test-Path -LiteralPath $desktop -PathType Container)) { New-Item -ItemType Directory -Path $desktop -Force | Out-Null }
$localAppData=Join-Path $script:Fila4ProfileRoot 'AppData\Local'
$appData=Join-Path $script:Fila4ProfileRoot 'AppData\Roaming'
$tempRoot=Join-Path $localAppData 'Temp'
foreach ($path in @($localAppData,$appData,$tempRoot)) { if (-not (Test-Path -LiteralPath $path -PathType Container)) { New-Item -ItemType Directory -Path $path -Force | Out-Null } }
# Child tools, caches, configuration, and TEMP are isolated to the Fila4 profile.
$env:USERPROFILE=$script:Fila4ProfileRoot
$env:HOME=$script:Fila4ProfileRoot
$env:HOMEDRIVE=$driveRoot.TrimEnd('\')
$env:HOMEPATH=$homePath
$env:LOCALAPPDATA=$localAppData
$env:APPDATA=$appData
$env:TEMP=$tempRoot
$env:TMP=$tempRoot
$machinePath=[Environment]::GetEnvironmentVariable('Path','Machine')
$pathParts=@($machinePath,(Join-Path $env:ProgramFiles 'Git\cmd'),(Join-Path $env:ProgramFiles 'nodejs'),(Join-Path $env:ProgramFiles 'GitHub CLI'),
    (Join-Path $localAppData 'Programs\Git'),(Join-Path $localAppData 'Programs\Git\cmd'),(Join-Path $localAppData 'Programs\nodejs'),
    (Join-Path $localAppData 'Programs\GitHub CLI'),(Join-Path $localAppData 'Microsoft\WinGet\Links'),(Join-Path $appData 'npm'))
$env:Path=($pathParts | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) } | Select-Object -Unique) -join ';'
if ([string]::IsNullOrWhiteSpace($WorkRoot)) { $WorkRoot=Join-Path $desktop 'EP' }
$WorkRoot=[System.IO.Path]::GetFullPath($WorkRoot)
if (-not $WorkRoot.StartsWith($fila4Prefix,[System.StringComparison]::OrdinalIgnoreCase)) { throw "WORK_ROOT_OUTSIDE_FILA4_PROFILE: $WorkRoot" }
$script:Fila4WorkRoot=$WorkRoot
$env:GH_CONFIG_DIR=Join-Path $WorkRoot 'config\gh'
$env:GIT_CONFIG_GLOBAL=Join-Path $WorkRoot 'config\gitconfig'
$env:NPM_CONFIG_CACHE=Join-Path $WorkRoot 'cache\npm'
$env:XDG_CONFIG_HOME=Join-Path $WorkRoot 'config\xdg-config'
$env:XDG_DATA_HOME=Join-Path $WorkRoot 'config\xdg-data'
foreach ($path in @((Join-Path $WorkRoot 'config'),$env:GH_CONFIG_DIR,$env:NPM_CONFIG_CACHE,$env:XDG_CONFIG_HOME,$env:XDG_DATA_HOME)) {
    if (-not (Test-Path -LiteralPath $path -PathType Container)) { New-Item -ItemType Directory -Path $path -Force | Out-Null }
}

# Serialize main bootstrap runs because they share repository, OBS, and RDC state.
$mutexName='Local\EntornoPersistenteBootstrap'
$script:RunMutex=[System.Threading.Mutex]::new($false,$mutexName)
try {
    $script:RunMutexOwned=$script:RunMutex.WaitOne(0)
} catch [System.Threading.AbandonedMutexException] {
    $script:RunMutexOwned=$true
    $script:RunMutexAbandoned=$true
}
if (-not $script:RunMutexOwned) {
    Write-Host 'BOOTSTRAP_SKIPPED=ANOTHER_INSTANCE_ACTIVE | No shared files, OBS, or RDC state changed.'
    $script:RunMutex.Dispose()
    $script:RunMutex=$null
    return
}

New-Item -ItemType Directory -Path (Join-Path $WorkRoot 'logs') -Force | Out-Null
$script:LogPath=Join-Path $WorkRoot ('logs\bootstrap-'+$script:RunId+'.log')
if ($script:RunMutexAbandoned) { Write-Log 'BOOTSTRAP_MUTEX=RECOVERED_ABANDONED_PREVIOUS_RUN' } else { Write-Log 'BOOTSTRAP_MUTEX=ACQUIRED' }
Write-Log ('FILA4_PROFILE_ROOT='+$script:Fila4ProfileRoot)
Write-Log ('FILA4_DESKTOP='+$desktop)
Write-Log ('WORKSPACE_ROOT='+$WorkRoot)
$computer=Get-CimInstance Win32_ComputerSystem; $os=Get-CimInstance Win32_OperatingSystem; $dns=[System.Net.Dns]::GetHostName(); $name=[string]$computer.Name
Write-Log ('SESSION_START | HOST='+$name+' | DNS='+$dns+' | User='+$env:USERNAME)
Write-Log ('OS='+$os.Caption+' | BUILD='+$os.BuildNumber+' | PowerShell='+$PSVersionTable.PSVersion)
Write-Log 'REBOOT_BUDGET=0 | no reboot/shutdown/reset/BIOS/UEFI/firmware/offline repair.'
Write-Log 'CHROME_POLICY=DO_NOT_LAUNCH/STOP/INSPECT/CONFIGURE/EDIT.'
$events=Join-Path $WorkRoot ('EVENTOS-'+(Get-Date -Format 'yyyy-MM')+'.md')
if (-not (Test-Path -LiteralPath $events)) { [System.IO.File]::WriteAllText($events,('# EP bootstrap events'+[Environment]::NewLine),(New-Object System.Text.UTF8Encoding($false))) }
Add-Content -LiteralPath $events -Value ('- '+(Get-Date -Format 'yyyy-MM-dd HH:mm:ssK')+' | BOOTSTRAP_START | user='+$env:USERNAME+' | reboot_budget=0') -Encoding UTF8
try {
    Ensure-GitHubAccess
    Ensure-HostToolchain
    Write-Log 'LEGACY_PREPARE_REMOVED=HOST_TOOLCHAIN_VERIFIED | No prior Desktop methodology checkout is inspected or modified.'

    $script:GitPath=Resolve-Git
    if (-not $script:GitPath) { throw 'GIT_NOT_FOUND_AFTER_BASE_PREPARE' }
    Write-Log 'GIT_AUTH=EPHEMERAL_HTTPS_EXTRAHEADER | no token is written to a Git config file.'
    $repos=@(
        @{Name='metodologia';Repo='SeryMente/metodologia'},
        @{Name='otro-gran-programa';Repo='SeryMente/otrogranprograma'},
        @{Name='gestor-de-procesos';Repo='SeryMente/GDP'},
        @{Name='signal-interpreter-source';Repo='SeryMente/signal-interpreter'},
        @{Name='khora';Repo='SeryMente/khora'}
    )
    foreach ($item in $repos) {
        try { $probe=Invoke-GitHubApi -Path ('/repos/'+$item.Repo) }
        catch { throw "REPOSITORY_METADATA_ACCESS_FAILED: $($item.Repo); verify token repository selection and organization approval." }
        if ([string]$probe.full_name -ine [string]$item.Repo) { throw "REPOSITORY_METADATA_ACCESS_FAILED: unexpected repository identity for $($item.Repo)." }
        $url='https://github.com/'+$item.Repo+'.git'
        $transport=Invoke-NativeCaptured -Executable $script:GitPath -Arguments @('ls-remote','--exit-code',$url,'refs/heads/main') -Quiet
        if ($transport.ExitCode -ne 0 -or -not (($transport.Lines -join ' ') -match 'refs/heads/main')) {
            foreach ($line in $transport.Lines) {
                $safeLine=[regex]::Replace([string]$line,'(?i)(gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,})','[REDACTED]')
                $safeLine=[regex]::Replace($safeLine,'(?i)AUTHORIZATION:\s*basic\s+\S+','AUTHORIZATION: basic [REDACTED]')
                Write-Log ('GIT_READ_DIAGNOSTIC | '+$item.Repo+' | '+$safeLine)
            }
            throw "GIT_CONTENTS_ACCESS_FAILED: $($item.Repo); inspect GIT_READ_DIAGNOSTIC above. Token API access passed; this is the Git HTTPS transport result."
        }
        Write-Log ('TOKEN_GIT_READ=VERIFIED | '+$item.Repo)
    }
    Write-Log 'REPOSITORY_API_AND_GIT_READ=VERIFIED_FOR_ALL_REPOSITORIES'
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

    # The PAT is no longer needed; do not pass it to the RDC child process.
    Remove-Item Env:GH_TOKEN,Env:GIT_TERMINAL_PROMPT,Env:GIT_CONFIG_COUNT,Env:GIT_CONFIG_KEY_0,Env:GIT_CONFIG_VALUE_0,Env:GIT_CONFIG_KEY_1,Env:GIT_CONFIG_VALUE_1 -ErrorAction SilentlyContinue
    Write-Log 'OBS_CAMERA_PHASE=BEGIN | after repository synchronization/token cleanup; before RDC.'
    try { Ensure-ObsCamera; Write-Log 'OBS_CAMERA=VERIFIED | OS camera registration and OBS virtual output checks passed.' } catch { Write-Log ('OBS_CAMERA=BLOCKED_OR_FAILED | '+$_.Exception.Message) }
    Write-Log 'CHROME=NOT_TOUCHED | no Chrome process or settings are accessed.'

    Write-Log 'RDC_START=FOREGROUND | keep this terminal open.'
    $npx=Resolve-Npx; if (-not $npx) { throw 'NPX_CMD_NOT_FOUND_AFTER_BASE_PREPARE' }
    $old=$ErrorActionPreference
    try { $ErrorActionPreference='Continue'; & $npx '@wonderwhy-er/desktop-commander@latest' 'remote'; $rc=$LASTEXITCODE } finally { $ErrorActionPreference=$old }
    Write-Log ('RDC_EXIT='+$rc)
    if ($rc -ne 0) { throw "RDC_REMOTE_FAILED: exit=$rc" }
}
catch { Write-Log ('FATAL_ERROR='+$_.Exception.Message); Write-Log ('LOG_PATH='+$script:LogPath); throw }
finally {
    if ($null -ne $script:OriginalGhToken) { [Environment]::SetEnvironmentVariable('GH_TOKEN',$script:OriginalGhToken,'Process') } else { Remove-Item Env:GH_TOKEN -ErrorAction SilentlyContinue }
    if ($null -ne $script:OriginalGitTerminalPrompt) { [Environment]::SetEnvironmentVariable('GIT_TERMINAL_PROMPT',$script:OriginalGitTerminalPrompt,'Process') } else { Remove-Item Env:GIT_TERMINAL_PROMPT -ErrorAction SilentlyContinue }
    foreach ($n in $script:OriginalGitConfig.Keys) {
        if ($null -ne $script:OriginalGitConfig[$n]) { [Environment]::SetEnvironmentVariable($n,[string]$script:OriginalGitConfig[$n],'Process') }
        else { Remove-Item ('Env:'+$n) -ErrorAction SilentlyContinue }
    }
    if ($script:RunMutexOwned -and $script:RunMutex) {
        try { $script:RunMutex.ReleaseMutex(); Write-Log 'BOOTSTRAP_MUTEX=RELEASED' } catch { Write-Host 'BOOTSTRAP_MUTEX_RELEASE_WARNING' }
        try { $script:RunMutex.Dispose() } catch {}
        $script:RunMutex=$null
        $script:RunMutexOwned=$false
    }
}
