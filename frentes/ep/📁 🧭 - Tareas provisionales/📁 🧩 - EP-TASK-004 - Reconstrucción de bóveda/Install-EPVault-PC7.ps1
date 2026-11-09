[CmdletBinding()]
param([switch]$NoDesktopShortcuts, [switch]$SkipSyntheticTests)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'
$taskRoot = $PSScriptRoot
$srcRoot = Join-Path $taskRoot 'src'
$required = @('EP.Vault.Core.psm1','EP.Vault.CLI.ps1','EP-Vault.GUI.ps1','EP-Vault.Window.xaml')
foreach ($name in $required) {
    $path = Join-Path $srcRoot $name
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw ('EP_VAULT_REQUIRED_FILE_MISSING: ' + $name) }
}
$testPath = Join-Path $taskRoot 'tests\Test-EPVault.ps1'
if (-not (Test-Path -LiteralPath $testPath -PathType Leaf)) { throw 'EP_VAULT_TEST_SUITE_MISSING' }
$psExe = Join-Path $PSHOME 'powershell.exe'

Write-Output 'STEP 1/4: PowerShell parser and XAML'
foreach ($file in (Get-ChildItem -LiteralPath $srcRoot -File -Recurse | Where-Object { $_.Extension -in @('.ps1','.psm1') })) {
    $tokens = $null; $parseErrors = $null
    $null = [Management.Automation.Language.Parser]::ParseFile($file.FullName,[ref]$tokens,[ref]$parseErrors)
    if ($parseErrors.Count -gt 0) { throw ('EP_VAULT_PARSE_FAILED: ' + $file.Name + ' line ' + $parseErrors[0].Extent.StartLineNumber) }
}
[xml]$xaml = Get-Content -LiteralPath (Join-Path $srcRoot 'EP-Vault.Window.xaml') -Raw -Encoding UTF8
if ($xaml.DocumentElement.LocalName -ne 'Window') { throw 'EP_VAULT_XAML_ROOT_INVALID' }

Write-Output 'STEP 2/4: Isolated synthetic end-to-end tests'
if ($SkipSyntheticTests) {
    Write-Warning 'SYNTHETIC_TESTS_SKIPPED_BY_EXPLICIT_OPERATOR_SWITCH — use only when the identical source/test hashes already passed on this host'
}
else {
    $testOutput = @(& $psExe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File $testPath 2>&1)
    $testExit = $LASTEXITCODE
    $testOutput | ForEach-Object { Write-Output ([string]$_) }
    if ($testExit -ne 0) { throw ('EP_VAULT_TEST_EXIT_CODE: ' + $testExit) }
}

Write-Output 'STEP 3/4: Formal vault status — read-only'
$statusStdout = Join-Path ([IO.Path]::GetTempPath()) ('ep-vault-status-' + [Guid]::NewGuid().ToString('N') + '.out')
$statusStderr = $statusStdout + '.err'
try {
    $statusProcess = Start-Process -FilePath $psExe -ArgumentList @(
        '-NoLogo','-NoProfile','-NonInteractive','-ExecutionPolicy','Bypass',
        '-File',('"' + (Join-Path $srcRoot 'EP.Vault.CLI.ps1') + '"'),
        '-Action','Status'
    ) -PassThru -Wait -WindowStyle Hidden -RedirectStandardOutput $statusStdout -RedirectStandardError $statusStderr
    if ($statusProcess.ExitCode -ne 0) { throw ('EP_VAULT_STATUS_QUERY_FAILED_EXIT_' + $statusProcess.ExitCode) }
    $statusText = [IO.File]::ReadAllText($statusStdout,[Text.Encoding]::UTF8).Trim()
    if ([string]::IsNullOrWhiteSpace($statusText)) { throw 'EP_VAULT_STATUS_EMPTY' }
    try { $status = $statusText | ConvertFrom-Json -ErrorAction Stop }
    catch { throw 'EP_VAULT_STATUS_OUTPUT_NOT_VALID_JSON' }
    if ($status.vaultExists -and $status.status -ne 'ENCRYPTED_FILE_PRESENT') { throw 'EP_VAULT_EXISTING_STORE_STATUS_UNEXPECTED' }
    if ($status.status -eq 'NOT_INITIALIZED') { Write-Output 'FORMAL_VAULT_NOT_INITIALIZED — installer did not create it' }
    else { Write-Output ('FORMAL_VAULT_PRESENT_UNTOUCHED_BYTES=' + $status.bytes) }
}
finally {
    foreach ($tempFile in @($statusStdout,$statusStderr)) {
        if (Test-Path -LiteralPath $tempFile) { Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue }
    }
}
Write-Output 'STEP 4/4: Visible desktop launchers (no WScript.Shell COM)'
if (-not $NoDesktopShortcuts) {
    $desktop = [Environment]::GetFolderPath('Desktop')
    $quotedTaskRoot = "'" + $taskRoot.Replace("'","''") + "'"

    $guiPs1Text = @'
$ErrorActionPreference = 'Stop'
$taskRoot = __TASKROOT__
$gui = Join-Path $taskRoot 'src\EP-Vault.GUI.ps1'
if (-not (Test-Path -LiteralPath $gui -PathType Leaf)) { [Console]::Error.WriteLine('EP_VAULT_GUI_NOT_FOUND'); exit 2 }
try { & $gui; exit 0 } catch { [Console]::Error.WriteLine('EP_VAULT_GUI_LAUNCH_FAILED'); exit 1 }
'@
    $guiPs1Text = $guiPs1Text.Replace('__TASKROOT__',$quotedTaskRoot)

    $cliPs1Text = @'
param([Parameter(ValueFromRemainingArguments=$true)][object[]]$Arguments)
$ErrorActionPreference = 'Stop'
$taskRoot = __TASKROOT__
$cli = Join-Path $taskRoot 'src\EP.Vault.CLI.ps1'
if (-not (Test-Path -LiteralPath $cli -PathType Leaf)) { [Console]::Error.WriteLine('EP_VAULT_CLI_NOT_FOUND'); exit 2 }
try {
    & $cli @Arguments
    if ($LASTEXITCODE -is [int]) { exit $LASTEXITCODE }
    exit 0
} catch { [Console]::Error.WriteLine('EP_VAULT_CLI_LAUNCH_FAILED'); exit 1 }
'@
    $cliPs1Text = $cliPs1Text.Replace('__TASKROOT__',$quotedTaskRoot)

    $guiCmdText = @'
@echo off
setlocal
set "WRAPPER=%~dp0EP Vault GUI.ps1"
if not exist "%WRAPPER%" (echo EP_VAULT_GUI_WRAPPER_NOT_FOUND& exit /b 2)
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -STA -ExecutionPolicy Bypass -File "%WRAPPER%" %*
exit /b %ERRORLEVEL%
'@
    $cliCmdText = @'
@echo off
setlocal
set "WRAPPER=%~dp0EP Vault CLI.ps1"
if not exist "%WRAPPER%" (echo EP_VAULT_CLI_WRAPPER_NOT_FOUND& exit /b 2)
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%WRAPPER%" %*
exit /b %ERRORLEVEL%
'@

    $launcherFiles = @(
        @{ Name='EP Vault GUI.ps1'; Content=$guiPs1Text },
        @{ Name='EP Vault CLI.ps1'; Content=$cliPs1Text },
        @{ Name='EP Vault GUI.cmd'; Content=$guiCmdText },
        @{ Name='EP Vault CLI.cmd'; Content=$cliCmdText }
    )
    foreach ($item in $launcherFiles) {
        $destination = Join-Path $desktop $item.Name
        if (Test-Path -LiteralPath $destination -PathType Leaf) {
            $existingText = [IO.File]::ReadAllText($destination)
            if ($existingText -cne $item.Content) {
                $name = [IO.Path]::GetFileNameWithoutExtension($item.Name)
                $extension = [IO.Path]::GetExtension($item.Name)
                $destination = Join-Path $desktop ($name + ' (EP)' + $extension)
                if (Test-Path -LiteralPath $destination -PathType Leaf) {
                    $existingText = [IO.File]::ReadAllText($destination)
                    if ($existingText -cne $item.Content) { throw ('EP_VAULT_DESKTOP_LAUNCHER_COLLISION: ' + $item.Name) }
                }
            }
        }
        if (-not (Test-Path -LiteralPath $destination -PathType Leaf) -or
            [IO.File]::ReadAllText($destination) -cne $item.Content) {
            [IO.File]::WriteAllText($destination,$item.Content,[Text.UTF8Encoding]::new($true))
        }
        if ([IO.File]::ReadAllText($destination) -cne $item.Content) {
            throw ('EP_VAULT_DESKTOP_LAUNCHER_READBACK_FAILED: ' + $item.Name)
        }
        if ($item.Name.EndsWith('.ps1')) {
            $file = Get-Item -LiteralPath $destination -Force
            $file.Attributes = $file.Attributes -bor [IO.FileAttributes]::Hidden
        }
        Write-Output ('DESKTOP_LAUNCHER_VERIFIED=' + [IO.Path]::GetFileName($destination))
    }
}
Write-Output 'EP_VAULT_PC7_INSTALLATION_READY — formal store was not initialized or changed'
