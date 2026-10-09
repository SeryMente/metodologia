[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^https://github\.com/[^/]+/[^/]+(?:\.git)?/?$')]
    [string]$RepositoryUrl,

    [string]$TargetName
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Invoke-NativeCaptured {
    param(
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(Mandatory = $true)][string[]]$Arguments
    )

    $previousPreference = $ErrorActionPreference
    try {
        # Windows PowerShell 5.1 can turn native stderr into NativeCommandError.
        # Capture output and inspect the native exit code explicitly.
        $ErrorActionPreference = 'Continue'
        $lines = @(& $FilePath @Arguments 2>&1)
        $exitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousPreference
    }

    $stringLines = @($lines | ForEach-Object { [string]$_ })
    [pscustomobject]@{
        ExitCode = [int]$exitCode
        Lines    = $stringLines
    }
}

function Show-NativeResult {
    param(
        [string]$Label,
        [pscustomobject]$Result
    )
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

$RepositoryUrl = $RepositoryUrl.Trim().TrimEnd('/')
if (-not $RepositoryUrl.EndsWith('.git', [System.StringComparison]::OrdinalIgnoreCase)) {
    $RepositoryUrl = "$RepositoryUrl.git"
}

if ([string]::IsNullOrWhiteSpace($TargetName)) {
    $TargetName = [System.IO.Path]::GetFileNameWithoutExtension(
        [System.IO.Path]::GetFileName($RepositoryUrl)
    )
}
if ([string]::IsNullOrWhiteSpace($TargetName) -or
    $TargetName -match '[\\/]' -or
    $TargetName -in @('.', '..')) {
    throw 'INVALID_TARGET_NAME: use a single folder name, not a path.'
}

$desktop = [Environment]::GetFolderPath('Desktop')
if ([string]::IsNullOrWhiteSpace($desktop) -or -not (Test-Path -LiteralPath $desktop)) {
    throw 'DESKTOP_PATH_NOT_FOUND'
}
$target = Join-Path $desktop $TargetName

# Keep authentication non-interactive: public repositories clone without login;
# private repositories require prior CLI authentication and must fail visibly otherwise.
$env:GIT_TERMINAL_PROMPT = '0'
$env:GCM_INTERACTIVE = 'Never'

$gitPath = $null
$gitCommand = Get-Command git.exe -ErrorAction SilentlyContinue
if ($gitCommand -and $gitCommand.Source) {
    $gitPath = $gitCommand.Source
}

$gitCandidates = @(
    "$env:ProgramFiles\Git\cmd\git.exe",
    'C:\Program Files (x86)\Git\cmd\git.exe',
    "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe"
)
if (-not $gitPath) {
    $gitPath = $gitCandidates |
        Where-Object { Test-Path -LiteralPath $_ } |
        Select-Object -First 1
}

if (-not $gitPath) {
    $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
    if (-not $winget) {
        throw 'GIT_AND_WINGET_NOT_FOUND: cannot clone safely on this terminal.'
    }

    $install = Invoke-NativeCaptured -FilePath $winget.Source -Arguments @(
        'install', '--id', 'Git.Git', '-e',
        '--source', 'winget',
        '--accept-source-agreements',
        '--accept-package-agreements',
        '--silent'
    )
    Show-NativeResult -Label 'INSTALL_GIT' -Result $install

    $deadline = (Get-Date).AddSeconds(30)
    do {
        $gitPath = $gitCandidates |
            Where-Object { Test-Path -LiteralPath $_ } |
            Select-Object -First 1
        if (-not $gitPath) {
            Start-Sleep -Milliseconds 500
        }
    } while (-not $gitPath -and (Get-Date) -lt $deadline)

    if (-not $gitPath) {
        throw "GIT_INSTALL_NOT_VERIFIED: winget exit=$($install.ExitCode)"
    }
}

$gitDirectory = Split-Path -Parent $gitPath
$env:Path = "$gitDirectory;$env:Path"
$version = Invoke-NativeCaptured -FilePath $gitPath -Arguments @('--version')
Show-NativeResult -Label 'GIT_VERSION' -Result $version
if ($version.ExitCode -ne 0) {
    throw 'GIT_VERSION_CHECK_FAILED'
}

$normalizedExpected = Normalize-RepositoryUrl -Value $RepositoryUrl
$operation = $null

if (Test-Path -LiteralPath $target) {
    if (-not (Test-Path -LiteralPath (Join-Path $target '.git'))) {
        throw "TARGET_EXISTS_BUT_IS_NOT_A_GIT_REPOSITORY: $target. Nothing was overwritten."
    }

    $originResult = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
        '-C', $target, 'remote', 'get-url', 'origin'
    )
    Show-NativeResult -Label 'CHECK_ORIGIN' -Result $originResult
    if ($originResult.ExitCode -ne 0) {
        throw 'GIT_ORIGIN_CHECK_FAILED'
    }
    $origin = ($originResult.Lines -join '').Trim()
    if ((Normalize-RepositoryUrl -Value $origin) -ne $normalizedExpected) {
        throw "ORIGIN_MISMATCH: expected $RepositoryUrl; found $origin. Nothing was overwritten."
    }

    $branchResult = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
        '-C', $target, 'branch', '--show-current'
    )
    if ($branchResult.ExitCode -ne 0 -or
        [string]::IsNullOrWhiteSpace(($branchResult.Lines -join '').Trim())) {
        throw 'BRANCH_CHECK_FAILED_OR_DETACHED_HEAD'
    }

    $statusResult = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
        '-C', $target, 'status', '--porcelain'
    )
    if ($statusResult.ExitCode -ne 0) {
        throw 'GIT_STATUS_CHECK_FAILED'
    }
    $dirtyLines = @($statusResult.Lines | Where-Object {
        -not [string]::IsNullOrWhiteSpace($_)
    })
    if ($dirtyLines.Count -gt 0) {
        throw 'WORKTREE_NOT_CLEAN: refusing to pull or overwrite local changes.'
    }

    $pull = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
        '-C', $target, 'pull', '--ff-only'
    )
    Show-NativeResult -Label 'FAST_FORWARD_UPDATE' -Result $pull
    if ($pull.ExitCode -ne 0) {
        throw "GIT_PULL_FAILED: exit=$($pull.ExitCode)"
    }
    $operation = 'UPDATED'
}
else {
    $clone = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
        'clone', '--', $RepositoryUrl, $target
    )
    Show-NativeResult -Label 'CLONE' -Result $clone
    if ($clone.ExitCode -ne 0) {
        throw "GIT_CLONE_FAILED: exit=$($clone.ExitCode). Check URL and repository access."
    }
    $operation = 'CLONED'
}

$originResult = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
    '-C', $target, 'remote', 'get-url', 'origin'
)
$branchResult = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
    '-C', $target, 'branch', '--show-current'
)
$headResult = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
    '-C', $target, 'rev-parse', 'HEAD'
)
$statusResult = Invoke-NativeCaptured -FilePath $gitPath -Arguments @(
    '-C', $target, 'status', '--porcelain'
)

foreach ($check in @($originResult, $branchResult, $headResult, $statusResult)) {
    if ($check.ExitCode -ne 0) {
        throw 'POST_OPERATION_VERIFICATION_FAILED'
    }
}

$origin = ($originResult.Lines -join '').Trim()
$branch = ($branchResult.Lines -join '').Trim()
$head = ($headResult.Lines -join '').Trim()
$dirtyLines = @($statusResult.Lines | Where-Object {
    -not [string]::IsNullOrWhiteSpace($_)
})

if ((Normalize-RepositoryUrl -Value $origin) -ne $normalizedExpected) {
    throw 'POST_OPERATION_ORIGIN_MISMATCH'
}
if ($head -notmatch '^[0-9a-fA-F]{40}$') {
    throw 'POST_OPERATION_HEAD_SHA_INVALID'
}
if ($dirtyLines.Count -gt 0) {
    throw 'POST_OPERATION_WORKTREE_NOT_CLEAN'
}

Write-Output "RESULT=$operation"
Write-Output "TARGET=$target"
Write-Output "ORIGIN=$origin"
Write-Output "BRANCH=$branch"
Write-Output "HEAD=$head"
Write-Output 'WORKTREE_CLEAN=True'
Write-Output 'REPOSITORY_VERIFIED=True'
