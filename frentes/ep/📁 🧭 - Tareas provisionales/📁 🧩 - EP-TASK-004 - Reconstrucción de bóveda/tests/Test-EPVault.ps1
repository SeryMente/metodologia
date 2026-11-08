[CmdletBinding()]
param()

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$taskRoot = Split-Path -Parent $PSScriptRoot
$srcRoot = Join-Path $taskRoot 'src'
$corePath = Join-Path $srcRoot 'EP.Vault.Core.psm1'
$cliPath = Join-Path $srcRoot 'EP.Vault.CLI.ps1'
$guiPath = Join-Path $srcRoot 'EP-Vault.GUI.ps1'
$xamlPath = Join-Path $srcRoot 'EP-Vault.Window.xaml'

function Assert-EpTest {
    param([bool]$Condition,[string]$Failure)
    if (-not $Condition) { throw ('TEST_FAILED: ' + $Failure) }
}

foreach ($path in @($corePath,$cliPath,$guiPath,$xamlPath)) {
    Assert-EpTest -Condition (Test-Path -LiteralPath $path -PathType Leaf) -Failure ('MISSING_FILE: ' + $path)
}

$scriptFiles = @(Get-ChildItem -LiteralPath $srcRoot -File -Recurse | Where-Object { $_.Extension -in @('.ps1','.psm1') })
foreach ($file in $scriptFiles) {
    $tokens = $null
    $parseErrors = $null
    $null = [Management.Automation.Language.Parser]::ParseFile(
        $file.FullName,
        [ref]$tokens,
        [ref]$parseErrors
    )
    if ($parseErrors.Count -gt 0) {
        $details = ($parseErrors | ForEach-Object { $_.Message + ' @ ' + $_.Extent.StartLineNumber }) -join '; '
        throw ('POWERSHELL_PARSE_FAILED: ' + $file.Name + ': ' + $details)
    }
}
Write-Output 'PASS_POWERSHELL_PARSER'

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Security
[xml]$xaml = Get-Content -LiteralPath $xamlPath -Raw -Encoding UTF8
Assert-EpTest -Condition (-not ($xaml.OuterXml -match '<Image\b|BitmapImage|pack://')) -Failure 'XAML_MUST_BE_VECTOR_ONLY_NO_EXTERNAL_IMAGES'
$reader = [System.Xml.XmlNodeReader]::new($xaml)
try {
    $window = [System.Windows.Markup.XamlReader]::Load($reader)
}
finally {
    $reader.Close()
}
$requiredNames = @(
    'HeaderState','VaultCanvas','ClosedStage','OpenStage','UnlockButton','LockButton',
    'MasterPasswordBox','ConfirmPasswordBox','SessionDuration','VariableList',
    'StoreVariableButton','RevealVariableButton','RemoveVariableButton','NoteList',
    'CaptureNoteButton','ReadNoteButton','PromoteNoteButton','DeleteNoteButton',
    'SessionRemaining','RevealedValueBox'
)
foreach ($name in $requiredNames) {
    Assert-EpTest -Condition ($null -ne $window.FindName($name)) -Failure ('XAML_NAME_MISSING: ' + $name)
}
Write-Output 'PASS_WPF_XAML_PARSE_AND_NAME_CONTRACT'

$legacyReferences = @(Select-String -Path @($guiPath,$xamlPath) -Pattern 'EP-EnvVault-GUI|EP-EnvVault\.ps1|legacy.*xaml|legacy.*resource' -SimpleMatch:$false)
Assert-EpTest -Condition ($legacyReferences.Count -eq 0) -Failure 'NEW_UI_MUST_NOT_REFERENCE_LEGACY_UI'
Write-Output 'PASS_CLEAN_ROOM_REFERENCE_SCAN'

$oldLocalAppData = $env:LOCALAPPDATA
$tempRoot = if (-not [string]::IsNullOrWhiteSpace($env:RUNNER_TEMP)) { $env:RUNNER_TEMP } else { [IO.Path]::GetTempPath() }
$sandbox = Join-Path $tempRoot ('ep-vault-synthetic-' + [Guid]::NewGuid().ToString('N'))
$secure = $null
$bad = $null
$noteId = $null
try {
    [IO.Directory]::CreateDirectory($sandbox) | Out-Null
    $env:LOCALAPPDATA = $sandbox

    Import-Module -Name $corePath -Force -ErrorAction Stop
    $cryptoResult = Invoke-EpVaultSelfTest
    Assert-EpTest -Condition ($cryptoResult -like 'SELFTEST_PASS:*') -Failure 'CRYPTO_SELFTEST'
    Write-Output $cryptoResult

    $jobResult = Invoke-EpVaultJobSelfTest
    Assert-EpTest -Condition ($jobResult -like 'JOB_RUNNER_SELFTEST_PASS:*') -Failure 'JOB_RUNNER_SELFTEST'
    Write-Output $jobResult
    $timeoutResult = Invoke-EpVaultJobTimeoutSelfTest
    Assert-EpTest -Condition ($timeoutResult -like 'JOB_RUNNER_TIMEOUT_PASS:*') -Failure 'JOB_RUNNER_TIMEOUT_SELFTEST'
    Write-Output $timeoutResult

    $secure = ConvertTo-SecureString 'synthetic-master-password-only' -AsPlainText -Force
    $bad = ConvertTo-SecureString 'synthetic-incorrect-password-only' -AsPlainText -Force

    $module = Get-Module EP.Vault.Core
    foreach ($seconds in @(15,30,60,120,180,300,600,900)) {
        $sessionCheck = & $module {
            param($masterValue,$durationValue)
            $ttlSalt = New-EpRandomBytes -Count 16
            $ttlKey = Get-EpMasterKey -Master $masterValue -Salt $ttlSalt
            try {
                Set-EpVaultSession -Key $ttlKey -DurationSeconds $durationValue
                return (Get-EpVaultSession)
            }
            finally {
                $null = Lock-EpVault
                Clear-EpBytes -Bytes $ttlKey
                Clear-EpBytes -Bytes $ttlSalt
            }
        } $secure $seconds
        $elapsed = ([DateTime]::Parse($sessionCheck.expiresAtUtc) - [DateTime]::Parse($sessionCheck.startedAtUtc)).TotalSeconds
        Assert-EpTest -Condition ($sessionCheck.durationSeconds -eq $seconds -and [Math]::Abs($elapsed - $seconds) -lt 0.1) -Failure ('TTL_DURATION_OPTION_' + $seconds)
    }
    Write-Output 'PASS_ALL_EIGHT_SESSION_DURATION_OPTIONS'

    $initialized = Initialize-EpVault -Master $secure -DurationSeconds 300
    Assert-EpTest -Condition ($initialized.status -eq 'INITIALIZED_AND_READBACK_VERIFIED') -Failure 'SYNTHETIC_INITIALIZE'
    Assert-EpTest -Condition ((Get-EpVaultStatus).vaultExists) -Failure 'SYNTHETIC_VAULT_STATUS'

    $null = Lock-EpVault
    $badRejected = $false
    try {
        $null = Unlock-EpVault -Master $bad -DurationSeconds 300
    }
    catch {
        $badRejected = $_.Exception.Message -match 'MASTER_PASSWORD_INVALID_OR_VAULT_TAMPERED'
    }
    Assert-EpTest -Condition $badRejected -Failure 'WRONG_PASSWORD_REJECTION'

    $null = Unlock-EpVault -Master $secure -DurationSeconds 300
    $null = Set-EpVaultVariable -Name 'EP_VAULT_SYNTHETIC' -Value 'synthetic-value-only'
    $names = @(Get-EpVaultVariableNames)
    Assert-EpTest -Condition ($names -contains 'EP_VAULT_SYNTHETIC') -Failure 'SYNTHETIC_VARIABLE_NAME_READBACK'
    $value = Get-EpVaultVariableValue -Name 'EP_VAULT_SYNTHETIC' -Reveal
    Assert-EpTest -Condition ($value -ceq 'synthetic-value-only') -Failure 'SYNTHETIC_VARIABLE_VALUE_READBACK'
    $value = $null

    $runnerExe = Join-Path $PSHOME 'powershell.exe'
    $sentinelName = 'EP_VAULT_PARENT_SECRET_SENTINEL'
    $oldSentinel = [Environment]::GetEnvironmentVariable($sentinelName,'Process')
    [Environment]::SetEnvironmentVariable($sentinelName,'parent-only-synthetic-sentinel','Process')
    $runnerCommand = 'if ($env:EP_VAULT_SYNTHETIC -cne ''synthetic-value-only'') { exit 19 }; if (Test-Path Env:EP_VAULT_PARENT_SECRET_SENTINEL) { exit 20 }; exit 0'
    try {
        $runnerResult = Invoke-EpVaultCommand -ExecutablePath $runnerExe -ArgumentList @(
            '-NoLogo','-NoProfile','-NonInteractive','-Command',$runnerCommand
        ) -Names @('EP_VAULT_SYNTHETIC')
    }
    finally {
        [Environment]::SetEnvironmentVariable($sentinelName,$oldSentinel,'Process')
    }
    Assert-EpTest -Condition ($runnerResult.exitCode -eq 0 -and $runnerResult.injectedVariableCount -eq 1 -and $runnerResult.childProcessTreeManaged) -Failure 'EXPLICIT_ALLOWLIST_CHILD_PROCESS'
    Write-Output 'PASS_ALLOWLIST_WITHOUT_PARENT_SECRET_INHERITANCE_AND_JOB_OBJECT_PROCESS_SCOPE'

    $module = Get-Module EP.Vault.Core
    $noteId = & $module {
        $value = 'synthetic-note-value-only'
        $id = 'N-' + [DateTime]::UtcNow.ToString('yyyyMMddHHmmss') + '-' +
            ([Guid]::NewGuid().ToString('N').Substring(0,8).ToUpperInvariant())
        $created = [DateTime]::UtcNow
        $expires = $created.AddMinutes(30)
        $payload = [ordered]@{
            id = $id
            createdAtUtc = $created.ToString('o')
            expiresAtUtc = $expires.ToString('o')
            value = $value
        }
        $plain = [Text.UTF8Encoding]::new($false).GetBytes((ConvertTo-Json -InputObject $payload -Compress -Depth 4))
        $entropy = [Text.Encoding]::UTF8.GetBytes('EP-ENV-VAULT-WORKING-NOTE-V1')
        $protected = [Security.Cryptography.ProtectedData]::Protect(
            $plain,$entropy,[Security.Cryptography.DataProtectionScope]::CurrentUser
        )
        $record = [ordered]@{
            schema='ep-env-vault-working-note/1'
            id=$id
            createdAtUtc=$created.ToString('o')
            expiresAtUtc=$expires.ToString('o')
            protection='DPAPI-CURRENT-USER'
            payload=[Convert]::ToBase64String($protected)
        }
        $notePath = Get-EpWorkingNotePath -NoteId $id
        [IO.File]::WriteAllText($notePath,(ConvertTo-Json -InputObject $record -Depth 4),[Text.UTF8Encoding]::new($false))
        [Array]::Clear($plain,0,$plain.Length)
        [Array]::Clear($entropy,0,$entropy.Length)
        [Array]::Clear($protected,0,$protected.Length)
        return $id
    }
    $notes = @(Get-EpVaultNotes)
    $metadata = $notes | Where-Object { $_.id -eq $noteId } | Select-Object -First 1
    Assert-EpTest -Condition ($null -ne $metadata -and $null -eq $metadata.PSObject.Properties['value']) -Failure 'NOTES_METADATA_ONLY'
    $note = Get-EpVaultNote -NoteId $noteId -Reveal
    Assert-EpTest -Condition ($note.value -ceq 'synthetic-note-value-only') -Failure 'DPAPI_NOTE_REVEAL'
    $note = $null
    $null = Remove-EpVaultNote -NoteId $noteId -Approved
    Assert-EpTest -Condition (@(Get-EpVaultNotes | Where-Object { $_.id -eq $noteId }).Count -eq 0) -Failure 'DPAPI_NOTE_DELETE_READBACK'
    Write-Output 'PASS_DPAPI_NOTE_METADATA_REVEAL_DELETE'

    $null = Set-EpVaultVariable -Name 'EP_VAULT_SYNTHETIC' -Value 'synthetic-value-only' -Replace
    $vaultPath = Join-Path $sandbox 'Khora\secrets\ep-env-vault.enc.json'
    $originalEnvelopeText = [IO.File]::ReadAllText($vaultPath,[Text.Encoding]::UTF8)
    $tamperedEnvelope = $originalEnvelopeText | ConvertFrom-Json
    $cipherText = [string]$tamperedEnvelope.ciphertext
    $tamperedEnvelope.ciphertext = $cipherText.Substring(0,$cipherText.Length-4) + 'AAAA'
    [IO.File]::WriteAllText($vaultPath,(ConvertTo-Json -InputObject $tamperedEnvelope -Depth 10),[Text.UTF8Encoding]::new($false))
    $tamperRejected = $false
    try {
        $null = Lock-EpVault
        $null = Unlock-EpVault -Master $secure -DurationSeconds 300
    }
    catch {
        $tamperRejected = $_.Exception.Message -match 'MASTER_PASSWORD_INVALID_OR_VAULT_TAMPERED'
    }
    finally {
        [IO.File]::WriteAllText($vaultPath,$originalEnvelopeText,[Text.UTF8Encoding]::new($false))
    }
    Assert-EpTest -Condition $tamperRejected -Failure 'TAMPER_REJECTION'
    $null = Unlock-EpVault -Master $secure -DurationSeconds 300

    $backupFiles = @(Get-ChildItem -LiteralPath (Split-Path -Parent $vaultPath) -Filter '*.bak' -File)
    Assert-EpTest -Condition ($backupFiles.Count -ge 1) -Failure 'ATOMIC_BACKUP_PRESERVED'

    $module = Get-Module EP.Vault.Core
    & $module { $script:Session.expiresAtUtc = [DateTime]::UtcNow.AddSeconds(-1) }
    $expiredRejected = $false
    try { $null = Get-EpVaultSession }
    catch { $expiredRejected = $_.Exception.Message -match 'VAULT_SESSION_EXPIRED' }
    Assert-EpTest -Condition $expiredRejected -Failure 'ABSOLUTE_SESSION_EXPIRY'
    Write-Output 'PASS_VAULT_CRUD_TAMPER_BACKUP_AND_ABSOLUTE_TTL'

    $logPath = Join-Path $sandbox 'Khora\secrets\ep-env-vault-events.jsonl'
    if (Test-Path -LiteralPath $logPath) {
        $logText = [IO.File]::ReadAllText($logPath,[Text.Encoding]::UTF8)
        Assert-EpTest -Condition (-not $logText.Contains('synthetic-value-only') -and -not $logText.Contains('synthetic-note-value-only')) -Failure 'EVENT_LOG_SECRET_REDACTION'
    }
    Write-Output 'PASS_EVENT_LOG_REDACTION'
}
finally {
    if ($secure) { $secure.Dispose() }
    if ($bad) { $bad.Dispose() }
    if (Get-Command Lock-EpVault -ErrorAction SilentlyContinue) { $null = Lock-EpVault }
    $env:LOCALAPPDATA = $oldLocalAppData
    if (Test-Path -LiteralPath $sandbox) {
        Remove-Item -LiteralPath $sandbox -Recurse -Force
    }
}

Write-Output 'EP_VAULT_VALIDATION_PASS'
