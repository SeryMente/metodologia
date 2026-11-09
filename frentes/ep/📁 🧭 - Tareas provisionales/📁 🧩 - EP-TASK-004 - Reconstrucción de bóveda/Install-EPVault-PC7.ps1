[CmdletBinding()]
param([switch]$NoDesktopShortcuts)

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
$testOutput = @(& $psExe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File $testPath 2>&1)
$testExit = $LASTEXITCODE
$testOutput | ForEach-Object { Write-Output ([string]$_) }
if ($testExit -ne 0) { throw ('EP_VAULT_TEST_EXIT_CODE: ' + $testExit) }

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
Write-Output 'STEP 4/4: GUI/CLI shortcuts'
foreach ($name in @('EPVault-GUI.cmd','EPVault-CLI.cmd','TEST-EPVault.cmd')) {
    if (-not (Test-Path -LiteralPath (Join-Path $taskRoot $name) -PathType Leaf)) { throw ('EP_VAULT_LAUNCHER_MISSING: ' + $name) }
}
if (-not $NoDesktopShortcuts) {
    $desktop = [Environment]::GetFolderPath('Desktop')
    $shell = New-Object -ComObject WScript.Shell
    try {
        foreach ($item in @(
            @{Name='EP Vault GUI';Target=(Join-Path $taskRoot 'EPVault-GUI.cmd')},
            @{Name='EP Vault CLI';Target=(Join-Path $taskRoot 'EPVault-CLI.cmd')}
        )) {
            $shortcutPath = Join-Path $desktop ($item.Name + '.lnk')
            if (Test-Path -LiteralPath $shortcutPath) {
                $existing = $shell.CreateShortcut($shortcutPath)
                if ([IO.Path]::GetFullPath($existing.TargetPath) -ne [IO.Path]::GetFullPath($item.Target)) {
                    $shortcutPath = Join-Path $desktop ($item.Name + ' (EP-TASK-004).lnk')
                }
            }
            $shortcut = $shell.CreateShortcut($shortcutPath)
            $shortcut.TargetPath = $item.Target
            $shortcut.WorkingDirectory = $taskRoot
            $shortcut.Description = 'EP Vault — herramienta local GUI/CLI'
            $shortcut.Save()
            $check = $shell.CreateShortcut($shortcutPath)
            if ([IO.Path]::GetFullPath($check.TargetPath) -ne [IO.Path]::GetFullPath($item.Target)) {
                throw ('EP_VAULT_SHORTCUT_READBACK_FAILED: ' + $item.Name)
            }
            Write-Output ('SHORTCUT_VERIFIED=' + [IO.Path]::GetFileName($shortcutPath))
        }
    }
    finally { [Runtime.InteropServices.Marshal]::FinalReleaseComObject($shell) | Out-Null }
}
Write-Output 'EP_VAULT_PC7_INSTALLATION_READY — formal store was not initialized or changed'
