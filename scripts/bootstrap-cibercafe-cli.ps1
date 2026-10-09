[CmdletBinding()]
param(
    [switch]$StartOBSVirtualCamera,
    [switch]$PrepareOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$script:RepositoryUrl = 'https://github.com/SeryMente/metodologia.git'
$script:MinimumNodeVersion = [version]'22.12.0'

function Invoke-NativeCaptured {
    param(
        [Parameter(Mandatory = $true)][string]$Executable,
        [Parameter(Mandatory = $true)][string[]]$NativeArguments
    )
    $previousPreference = $ErrorActionPreference
    try {
        # PowerShell 5.1 can turn native stderr into NativeCommandError.
        $ErrorActionPreference = 'Continue'
        $lines = @(& $Executable @NativeArguments 2>&1)
        $exitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousPreference
    }
    [pscustomobject]@{
        ExitCode = [int]$exitCode
        Lines = @($lines | ForEach-Object { [string]$_ })
    }
}

function Show-NativeResult {
    param([string]$Label, [pscustomobject]$Result)
    Write-Output "$Label (exit=$($Result.ExitCode))"
    foreach ($line in $Result.Lines) {
        if (-not [string]::IsNullOrWhiteSpace($line)) {
            Write-Output "  $line"
        }
    }
}

function Normalize-RepositoryUrl {
    param([string]$Value)
    $normalized = $Value.Trim().TrimEnd('/')
    if ($normalized.EndsWith('.git', [System.StringComparison]::OrdinalIgnoreCase)) {
        $normalized = $normalized.Substring(0, $normalized.Length - 4)
    }
    $normalized.ToLowerInvariant()
}

function Resolve-GitPath {
    $cmd = Get-Command git.exe -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) { return $cmd.Source }
    $candidates = @(
        "$env:ProgramFiles\Git\cmd\git.exe",
        'C:\Program Files (x86)\Git\cmd\git.exe',
        "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe"
    )
    $found = $candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
    if ($found) { return $found }
    return $null
}

function Ensure-Git {
    $git = Resolve-GitPath
    if (-not $git) {
        $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
        if (-not $winget) { throw 'GIT_NOT_FOUND_AND_WINGET_UNAVAILABLE' }
        $install = Invoke-NativeCaptured -Executable $winget.Source -NativeArguments @(
            'install', '--id', 'Git.Git', '-e',
            '--source', 'winget',
            '--accept-source-agreements',
            '--accept-package-agreements',
            '--silent'
        )
        Show-NativeResult -Label 'INSTALL_GIT' -Result $install
        $deadline = (Get-Date).AddSeconds(45)
        do {
            $git = Resolve-GitPath
            if (-not $git) { Start-Sleep -Milliseconds 500 }
        } while (-not $git -and (Get-Date) -lt $deadline)
        if (-not $git) { throw "GIT_INSTALL_NOT_VERIFIED: winget exit=$($install.ExitCode)" }
    }
    $version = Invoke-NativeCaptured -Executable $git -NativeArguments @('--version')
    Show-NativeResult -Label 'GIT_VERSION' -Result $version
    if ($version.ExitCode -ne 0) { throw 'GIT_VERSION_CHECK_FAILED' }
    $script:GitPath = $git
    $env:Path = "$(Split-Path -Parent $git);$env:Path"
}

function Resolve-NodePath {
    $cmd = Get-Command node.exe -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) { return $cmd.Source }
    $candidates = @(
        "$env:ProgramFiles\nodejs\node.exe",
        "$env:LOCALAPPDATA\Programs\nodejs\node.exe"
    )
    return ($candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1)
}

function Resolve-NpxCmd {
    $cmd = Get-Command npx.cmd -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) { return $cmd.Source }
    $candidates = @(
        "$env:ProgramFiles\nodejs\npx.cmd",
        "$env:LOCALAPPDATA\Programs\nodejs\npx.cmd"
    )
    return ($candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1)
}

function Ensure-Node {
    $node = Resolve-NodePath
    $npx = Resolve-NpxCmd
    $needsInstall = $false
    if (-not $node -or -not $npx) {
        $needsInstall = $true
    }
    else {
        $versionResult = Invoke-NativeCaptured -Executable $node -NativeArguments @('--version')
        if ($versionResult.ExitCode -ne 0) { $needsInstall = $true }
        else {
            $versionText = ($versionResult.Lines -join '').Trim().TrimStart('v')
            try {
                if ([version]$versionText -lt $script:MinimumNodeVersion) { $needsInstall = $true }
            }
            catch { $needsInstall = $true }
        }
    }

    if ($needsInstall) {
        $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
        if (-not $winget) { throw 'NODE_NPX_NOT_READY_AND_WINGET_UNAVAILABLE' }
        $install = Invoke-NativeCaptured -Executable $winget.Source -NativeArguments @(
            'install', '--id', 'OpenJS.NodeJS.LTS', '-e',
            '--source', 'winget',
            '--accept-source-agreements',
            '--accept-package-agreements',
            '--silent'
        )
        Show-NativeResult -Label 'INSTALL_NODE_LTS' -Result $install
        $env:Path = "$env:ProgramFiles\nodejs;$env:LOCALAPPDATA\Programs\nodejs;$env:APPDATA\npm;$env:Path"
        $deadline = (Get-Date).AddSeconds(45)
        do {
            $node = Resolve-NodePath
            $npx = Resolve-NpxCmd
            if (-not $node -or -not $npx) { Start-Sleep -Milliseconds 500 }
        } while ((-not $node -or -not $npx) -and (Get-Date) -lt $deadline)
    }

    if (-not $node) { throw 'NODE_EXE_NOT_FOUND_AFTER_INSTALL' }
    if (-not $npx) { throw 'NPX_CMD_NOT_FOUND_AFTER_INSTALL' }

    $env:Path = "$env:ProgramFiles\nodejs;$env:LOCALAPPDATA\Programs\nodejs;$env:APPDATA\npm;$env:Path"
    $nodeVersion = Invoke-NativeCaptured -Executable $node -NativeArguments @('--version')
    $npmCmd = Join-Path (Split-Path -Parent $node) 'npm.cmd'
    if (-not (Test-Path -LiteralPath $npmCmd)) {
        $npmCommand = Get-Command npm.cmd -ErrorAction SilentlyContinue
        if ($npmCommand) { $npmCmd = $npmCommand.Source }
    }
    if (-not (Test-Path -LiteralPath $npmCmd)) { throw 'NPM_CMD_NOT_FOUND' }
    $npmVersion = Invoke-NativeCaptured -Executable $npmCmd -NativeArguments @('--version')
    Show-NativeResult -Label 'NODE_VERSION' -Result $nodeVersion
    Show-NativeResult -Label 'NPM_VERSION' -Result $npmVersion
    if ($nodeVersion.ExitCode -ne 0 -or $npmVersion.ExitCode -ne 0) {
        throw 'NODE_NPM_VERSION_CHECK_FAILED'
    }
    $versionText = ($nodeVersion.Lines -join '').Trim().TrimStart('v')
    if ([version]$versionText -lt $script:MinimumNodeVersion) {
        throw "NODE_TOO_OLD: found $versionText; minimum $($script:MinimumNodeVersion)"
    }
    $script:NpxCmd = $npx
}

function Sync-MethodologyRepository {
    $desktop = [Environment]::GetFolderPath('Desktop')
    if ([string]::IsNullOrWhiteSpace($desktop) -or -not (Test-Path -LiteralPath $desktop)) {
        throw 'DESKTOP_PATH_NOT_FOUND'
    }
    $target = Join-Path $desktop 'metodologia'
    $env:GIT_TERMINAL_PROMPT = '0'
    $env:GCM_INTERACTIVE = 'Never'

    if (Test-Path -LiteralPath $target) {
        if (-not (Test-Path -LiteralPath (Join-Path $target '.git'))) {
            throw "TARGET_EXISTS_BUT_IS_NOT_A_GIT_REPOSITORY: $target. Nothing was overwritten."
        }
        $origin = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
            '-C', $target, 'remote', 'get-url', 'origin'
        )
        if ($origin.ExitCode -ne 0) { throw 'GIT_ORIGIN_CHECK_FAILED' }
        $originUrl = ($origin.Lines -join '').Trim()
        if ((Normalize-RepositoryUrl $originUrl) -ne (Normalize-RepositoryUrl $script:RepositoryUrl)) {
            throw "ORIGIN_MISMATCH: $originUrl. Nothing was overwritten."
        }

        $branch = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
            '-C', $target, 'branch', '--show-current'
        )
        if ($branch.ExitCode -ne 0 -or ($branch.Lines -join '').Trim() -ne 'main') {
            throw 'BRANCH_NOT_MAIN: refusing to switch or overwrite an existing checkout.'
        }
        $status = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
            '-C', $target, 'status', '--porcelain'
        )
        if ($status.ExitCode -ne 0) { throw 'GIT_STATUS_CHECK_FAILED' }
        $dirty = @($status.Lines | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
        if ($dirty.Count -gt 0) { throw 'WORKTREE_NOT_CLEAN: refusing to overwrite local changes.' }

        $pull = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
            '-C', $target, 'pull', '--ff-only'
        )
        Show-NativeResult -Label 'UPDATE_METHODOLOGY' -Result $pull
        if ($pull.ExitCode -ne 0) { throw "GIT_PULL_FAILED: exit=$($pull.ExitCode)" }
    }
    else {
        $clone = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
            'clone', '--', $script:RepositoryUrl, $target
        )
        Show-NativeResult -Label 'CLONE_METHODOLOGY' -Result $clone
        if ($clone.ExitCode -ne 0) { throw "GIT_CLONE_FAILED: exit=$($clone.ExitCode)" }
    }

    $origin = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
        '-C', $target, 'remote', 'get-url', 'origin'
    )
    $branch = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
        '-C', $target, 'branch', '--show-current'
    )
    $head = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
        '-C', $target, 'rev-parse', 'HEAD'
    )
    $status = Invoke-NativeCaptured -Executable $script:GitPath -NativeArguments @(
        '-C', $target, 'status', '--porcelain'
    )
    foreach ($result in @($origin, $branch, $head, $status)) {
        if ($result.ExitCode -ne 0) { throw 'POST_SYNC_VERIFICATION_FAILED' }
    }
    $originUrl = ($origin.Lines -join '').Trim()
    $branchName = ($branch.Lines -join '').Trim()
    $headSha = ($head.Lines -join '').Trim()
    $dirty = @($status.Lines | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    if ((Normalize-RepositoryUrl $originUrl) -ne (Normalize-RepositoryUrl $script:RepositoryUrl)) {
        throw 'POST_SYNC_ORIGIN_MISMATCH'
    }
    if ($branchName -ne 'main') { throw 'POST_SYNC_BRANCH_MISMATCH' }
    if ($headSha -notmatch '^[0-9a-fA-F]{40}$') { throw 'POST_SYNC_HEAD_SHA_INVALID' }
    if ($dirty.Count -gt 0) { throw 'POST_SYNC_WORKTREE_NOT_CLEAN' }

    foreach ($required in @(
        'SI-METACOGNITIVO.md',
        'METODOLOGIA.md',
        'BOOTSTRAP-CONTEXTO-GLOBAL.md',
        'ESTADO-RDC-ACTIVO.md',
        'scripts\clone-public-repo-to-desktop.ps1',
        'scripts\bootstrap-cibercafe-cli.ps1',
        'ANEXO-PROCEDIMIENTO-ARRANQUE-CLI-WINDOWS-Y-CLONADO-REPOSITORIOS.md'
    )) {
        if (-not (Test-Path -LiteralPath (Join-Path $target $required))) {
            throw "REQUIRED_REPOSITORY_FILE_MISSING: $required"
        }
    }

    $canonicalRepo = $script:MethodologyPath
    if ([string]::IsNullOrWhiteSpace($canonicalRepo) -or -not (Test-Path -LiteralPath $canonicalRepo)) {
        throw 'METHODOLOGY_PATH_NOT_EXPORTED_FROM_SYNC'
    }
    $siText = [System.IO.File]::ReadAllText((Join-Path $canonicalRepo 'SI-METACOGNITIVO.md'))
    $methodText = [System.IO.File]::ReadAllText((Join-Path $canonicalRepo 'METODOLOGIA.md'))
    $siVersionMatch = [regex]::Match($siText, '(?m)^\*\*Versi.n:\*\*[ \t]*(.+)$')
    $siNameMatch = [regex]::Match($siText, '(?m)^\*\*Nombre de versi.n:\*\*[ \t]*(.+)$')
    $methodVersionMatch = [regex]::Match($methodText, '(?m)^- \*\*Versi.n:\*\*[ \t]*(.+)$')
    $methodNameMatch = [regex]::Match($methodText, '(?m)^- \*\*Nombre de versi.n:\*\*[ \t]*(.+)$')
    if (-not $siVersionMatch.Success -or -not $siNameMatch.Success -or
        -not $methodVersionMatch.Success -or -not $methodNameMatch.Success) {
        throw ("CANONICAL_VERSION_HEADERS_NOT_FOUND: SI_VERSION={0}; SI_NAME={1}; METHOD_VERSION={2}; METHOD_NAME={3}" -f $siVersionMatch.Success, $siNameMatch.Success, $methodVersionMatch.Success, $methodNameMatch.Success)
    }

    Write-Output "DESKTOP=$desktop"
    Write-Output "TARGET=$target"
    Write-Output "ORIGIN=$originUrl"
    Write-Output "BRANCH=$branchName"
    Write-Output "HEAD=$headSha"
    Write-Output "WORKTREE_CLEAN=True"
    Write-Output "SI_VERSION=$($siVersionMatch.Groups[1].Value.Trim())"
    Write-Output "SI_NAME=$($siNameMatch.Groups[1].Value.Trim())"
    Write-Output "METHODOLOGY_VERSION=$($methodVersionMatch.Groups[1].Value.Trim())"
    Write-Output "METHODOLOGY_NAME=$($methodNameMatch.Groups[1].Value.Trim())"
    $script:MethodologyPath = $target
}

function Start-OBSVirtualCamera {
    $obsCandidates = @(
        "$env:ProgramFiles\obs-studio\bin\64bit\obs64.exe",
        'C:\Program Files (x86)\obs-studio\bin\64bit\obs64.exe'
    )
    $obsCmd = Get-Command obs64.exe -ErrorAction SilentlyContinue
    if ($obsCmd -and $obsCmd.Source) { $obsCandidates += $obsCmd.Source }
    $obs = $obsCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1

    if (-not $obs) {
        $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
        if (-not $winget) { throw 'OBS_NOT_FOUND_AND_WINGET_UNAVAILABLE' }
        $install = Invoke-NativeCaptured -Executable $winget.Source -NativeArguments @(
            'install', '--id', 'OBSProject.OBSStudio', '-e',
            '--source', 'winget',
            '--accept-source-agreements',
            '--accept-package-agreements',
            '--silent'
        )
        Show-NativeResult -Label 'INSTALL_OBS' -Result $install
        $deadline = (Get-Date).AddSeconds(60)
        do {
            $obs = $obsCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
            if (-not $obs) { Start-Sleep -Milliseconds 500 }
        } while (-not $obs -and (Get-Date) -lt $deadline)
        if (-not $obs) { throw "OBS_INSTALL_NOT_VERIFIED: exit=$($install.ExitCode)" }
    }

    $vc64 = Join-Path (Split-Path -Parent (Split-Path -Parent $obs)) 'data\obs-plugins\win-dshow\obs-virtualcam-module64.dll'
    $vc32 = Join-Path (Split-Path -Parent (Split-Path -Parent $obs)) 'data\obs-plugins\win-dshow\obs-virtualcam-module32.dll'
    # Normal OBS install lives at <root>\bin\64bit\obs64.exe; compute from root.
    $obsRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $obs))
    $vc64 = Join-Path $obsRoot 'data\obs-plugins\win-dshow\obs-virtualcam-module64.dll'
    $vc32 = Join-Path $obsRoot 'data\obs-plugins\win-dshow\obs-virtualcam-module32.dll'
    if (-not (Test-Path -LiteralPath $vc64)) { throw "OBS_VCAM64_DLL_MISSING: $vc64" }
    if (-not (Test-Path -LiteralPath $vc32)) { throw "OBS_VCAM32_DLL_MISSING: $vc32" }

    $clsid64 = 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{A3FCE0F5-3493-419F-958A-ABA1250EC20B}'
    $clsid32 = 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\WOW6432Node\CLSID\{A3FCE0F5-3493-419F-958A-ABA1250EC20B}'
    if (-not (Test-Path $clsid64)) {
        $reg64 = Join-Path $env:SystemRoot 'System32\regsvr32.exe'
        $reg = Invoke-NativeCaptured -Executable $reg64 -NativeArguments @('/s', '/i', $vc64)
        Show-NativeResult -Label 'REGISTER_OBS_VCAM64' -Result $reg
        if ($reg.ExitCode -ne 0 -or -not (Test-Path $clsid64)) {
            throw 'OBS_VCAM64_REGISTRATION_FAILED_OR_REQUIRES_ELEVATION'
        }
    }
    if (-not (Test-Path $clsid32)) {
        $reg32 = Join-Path $env:SystemRoot 'SysWOW64\regsvr32.exe'
        $reg = Invoke-NativeCaptured -Executable $reg32 -NativeArguments @('/s', '/i', $vc32)
        Show-NativeResult -Label 'REGISTER_OBS_VCAM32' -Result $reg
        if ($reg.ExitCode -ne 0 -or -not (Test-Path $clsid32)) {
            throw 'OBS_VCAM32_REGISTRATION_FAILED_OR_REQUIRES_ELEVATION'
        }
    }

    function Test-VirtualCameraLog {
        param([datetime]$NotBefore)
        $latest = Get-ChildItem -LiteralPath "$env:APPDATA\obs-studio\logs" -Filter '*.txt' -ErrorAction SilentlyContinue |
            Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if (-not $latest -or $latest.LastWriteTime -lt $NotBefore.AddSeconds(-1)) { return $false }
        $lines = @(Get-Content -LiteralPath $latest.FullName -ErrorAction SilentlyContinue)
        $startIndex = -1
        $stopIndex = -1
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -match 'Starting Virtual Camera output to Program|Virtual Camera Start') { $startIndex = $i }
            if ($lines[$i] -match 'Stopping Virtual Camera|Virtual Camera Stop') { $stopIndex = $i }
        }
        return ($startIndex -ge 0 -and $startIndex -gt $stopIndex)
    }

    $existing = @(Get-CimInstance Win32_Process -Filter "name='obs64.exe'" -ErrorAction SilentlyContinue)
    $alreadyRequested = $false
    foreach ($process in $existing) {
        if ($process.CommandLine -match '--startvirtualcam' -and (Test-VirtualCameraLog -NotBefore $process.CreationDate)) {
            $alreadyRequested = $true
            break
        }
    }
    if ($alreadyRequested) {
        Write-Output 'OBS_VIRTUAL_CAMERA=ALREADY_ACTIVE_VERIFIED'
        return
    }

    $startTime = Get-Date
    $started = Start-Process -FilePath $obs -ArgumentList @(
        '--startvirtualcam', '--minimize-to-tray', '--multi'
    ) -WorkingDirectory (Split-Path -Parent $obs) -PassThru
    Write-Output "OBS_PID=$($started.Id)"
    $deadline = (Get-Date).AddSeconds(30)
    $ready = $false
    while ((Get-Date) -lt $deadline) {
        Start-Sleep -Milliseconds 500
        if (Test-VirtualCameraLog -NotBefore $startTime) {
            $ready = $true
            break
        }
    }
    if (-not $ready) { throw 'OBS_VIRTUAL_CAMERA_DID_NOT_START_OR_LOG_NOT_CONFIRMED' }
    Write-Output 'OBS_VIRTUAL_CAMERA=START_CONFIRMED_IN_RECENT_LOG'
    Write-Output "OBS_EXECUTABLE=$obs"
}

$hostName = [System.Net.Dns]::GetHostName()
$computer = Get-CimInstance Win32_ComputerSystem
$os = Get-CimInstance Win32_OperatingSystem
Write-Output '=== CIBERCAFE CLI BOOTSTRAP ==='
Write-Output "HOSTNAME_DNS=$hostName"
Write-Output "HOSTNAME_SYSTEM=$($computer.Name)"
Write-Output "USER=$env:USERNAME"
Write-Output "DESKTOP=$([Environment]::GetFolderPath('Desktop'))"
Write-Output "OS=$($os.Caption) BUILD=$($os.BuildNumber)"
Write-Output "POWERSHELL=$($PSVersionTable.PSVersion)"
Write-Output 'REBOOT_POLICY=0 (no reboot, shutdown, firmware or offline repair)'

Ensure-Git
Ensure-Node
Sync-MethodologyRepository

if ($StartOBSVirtualCamera) {
    try {
        Start-OBSVirtualCamera
    }
    catch {
        Write-Output "OBS_RESULT=FAILED: $($_.Exception.Message)"
        Write-Output 'OBS_WARNING=RDC WILL STILL BE STARTED SO THE TERMINAL REMAINS REACHABLE'
    }
}
else {
    Write-Output 'OBS_RESULT=SKIPPED (pass -StartOBSVirtualCamera to start and verify it)'
}

if ($PrepareOnly) {
    Write-Output 'PREPARE_ONLY=True'
    Write-Output 'DEPENDENCIES_AND_REPOSITORY_VERIFIED=True'
    return
}

Write-Output '=== STARTING DESKTOP COMMANDER REMOTE (KEEP THIS TERMINAL OPEN) ==='
Write-Output 'If a device code is displayed, authorize it in the browser and verify the code matches.'
$previousPreference = $ErrorActionPreference
try {
    $ErrorActionPreference = 'Continue'
    & $script:NpxCmd '@wonderwhy-er/desktop-commander@latest' 'remote'
    $rdcExit = $LASTEXITCODE
}
finally {
    $ErrorActionPreference = $previousPreference
}
Write-Output "RDC_EXIT=$rdcExit"
if ($rdcExit -ne 0) {
    throw "RDC_REMOTE_FAILED: exit=$rdcExit"
}
