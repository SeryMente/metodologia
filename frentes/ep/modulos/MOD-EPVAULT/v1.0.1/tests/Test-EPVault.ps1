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
$sessionPath = Join-Path $srcRoot 'EP.Session.psm1'
$guardianPath = Join-Path $srcRoot 'EP.Session.Guardian.ps1'

function Assert-EpTest {
    param([bool]$Condition,[string]$Failure)
    if (-not $Condition) { throw ('TEST_FAILED: ' + $Failure) }
}

foreach ($path in @($corePath,$cliPath,$guiPath,$xamlPath,$sessionPath,$guardianPath)) {
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
Assert-EpTest -Condition ($xaml.OuterXml -match '<Viewport3D\b') -Failure 'XAML_REQUIRES_REAL_3D_VIEWPORT'
$reader = [System.Xml.XmlNodeReader]::new($xaml)
try {
    $window = [System.Windows.Markup.XamlReader]::Load($reader)
}
finally {
    $reader.Close()
}
$requiredNames = @(
    'HeaderState','VaultCanvas','VaultViewport','ClosedStage','OpenStage','UnlockButton','LockButton',
    'MasterPasswordBox','ConfirmPasswordBox','SessionDuration','VariableList',
    'StoreVariableButton','RevealVariableButton','RemoveVariableButton','NoteList',
    'CaptureNoteButton','ReadNoteButton','PromoteNoteButton','DeleteNoteButton',
    'SessionRemaining','RevealedValueBox','SoundToggle'
)
foreach ($name in $requiredNames) {
    Assert-EpTest -Condition ($null -ne $window.FindName($name)) -Failure ('XAML_NAME_MISSING: ' + $name)
}
$guiContent = [IO.File]::ReadAllText($guiPath)
Assert-EpTest -Condition ($guiContent -match 'SoundToggle\.IsChecked') -Failure 'UI_SOUND_MUTE_TOGGLE_WIRING'
Assert-EpTest -Condition ($guiContent -match 'Set-EpVaultNativeDarkTitleBar') -Failure 'UI_NATIVE_DARK_TITLE_BAR_WIRING'
Assert-EpTest -Condition ($guiContent -match 'function New-Ep3DCylinder' -and $guiContent -match 'function New-Ep3DTorus' -and $guiContent -match 'function New-Ep3DBox') -Failure 'UI_REAL_3D_GEOMETRY_PRIMITIVES'
Assert-EpTest -Condition ($guiContent -match 'PerspectiveCamera' -and $guiContent -match 'AxisAngleRotation3D' -and $guiContent -match 'DoorRotation') -Failure 'UI_3D_PERSPECTIVE_AND_MECHANICAL_HINGE'
Assert-EpTest -Condition ($guiContent -match 'WheelRotation' -and $guiContent -match 'Bolts=\$bolts') -Failure 'UI_3D_WHEEL_AND_INDEPENDENT_BOLTS'
Assert-EpTest -Condition ($guiContent -notmatch '\$canvas\.BeginAnimation\(\[System\.Windows\.UIElement\]::OpacityProperty') -Failure 'UI_DOOR_MUST_NOT_FADE_AS_A_FLAT_CARD'
Assert-EpTest -Condition ($guiContent -match 'OffsetZProperty' -and $guiContent -match 'DoorTranslate') -Failure 'UI_GASKET_RELEASE_BEFORE_HINGE'
Assert-EpTest -Condition ($guiContent -match 'FromMilliseconds\(6500\)') -Failure 'UI_SLOW_OPENING_TIMELINE'
Assert-EpTest -Condition ($guiContent -match 'FromMilliseconds\(3900\)') -Failure 'UI_SLOW_CLOSING_TIMELINE'
$audioRoot = Join-Path $taskRoot 'assets\audio'
foreach ($audioName in @('Vault-Open-Creak.wav','Vault-Close-Latch.wav')) {
    $audioPath = Join-Path $audioRoot $audioName
    Assert-EpTest -Condition (Test-Path -LiteralPath $audioPath -PathType Leaf) -Failure ('UI_AUDIO_ASSET_MISSING: ' + $audioName)
    $audioBytes = [IO.File]::ReadAllBytes($audioPath)
    $validWave = $audioBytes.Length -gt 44 -and
        [Text.Encoding]::ASCII.GetString($audioBytes,0,4) -ceq 'RIFF' -and
        [Text.Encoding]::ASCII.GetString($audioBytes,8,4) -ceq 'WAVE'
    Assert-EpTest -Condition $validWave -Failure ('UI_AUDIO_WAVE_INVALID: ' + $audioName)
}
Write-Output 'PASS_UI_HYPERREALISTIC_3D_STEEL_VAULT_MECHANICAL_CONTRACT'
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

    Import-Module -Name $corePath -Force -DisableNameChecking -WarningAction SilentlyContinue -ErrorAction Stop
    $versionStatus = Get-EpVaultStatus
    Assert-EpTest -Condition ($versionStatus.product -eq 'EP Vault' -and $versionStatus.version -eq '1.0.0' -and $versionStatus.status -eq 'NOT_INITIALIZED') -Failure 'PRODUCT_VERSION_1_0_0'
    Write-Output 'PASS_EP_VAULT_VERSION_1_0_0'
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
    $legacyFixture = & $module {
        param($masterValue)
        $paths=Get-EpVaultPaths; $existing=Get-EpVaultData
        try {
            $legacyVariables=ConvertTo-EpOrderedVariables -Variables $existing.variables
            $legacyVariables['EP_VAULT_LEGACY_MARKER']='legacy-value-only'
            $legacySalt=New-EpRandomBytes -Count 16
            $legacyKey=Get-EpMasterKey -Master $masterValue -Salt $legacySalt -Iterations 200000
            try {
                $legacyEnvelope=New-EpVaultEnvelope -Variables $legacyVariables -Key $legacyKey -Salt $legacySalt -Iterations 200000
                Write-EpVaultAtomic -Envelope $legacyEnvelope -Path $paths.Vault
            } finally { Clear-EpBytes -Bytes $legacySalt; Clear-EpBytes -Bytes $legacyKey }
        } finally { $existing=$null }
        return 'LEGACY_FIXTURE_WRITTEN'
    } $secure
    $null=Lock-EpVault
    $upgradeResult=Unlock-EpVault -Master $secure -DurationSeconds 300
    $upgradeCheck=& $module {
        $envelope=Read-EpVaultEnvelope; $data=Get-EpVaultData
        try { [pscustomobject]@{iterations=[int]$envelope.iterations;legacyMarker=[string]$data.variables.EP_VAULT_LEGACY_MARKER;originalValue=[string]$data.variables.EP_VAULT_SYNTHETIC} }
        finally { $data=$null }
    }
    Assert-EpTest -Condition ($upgradeResult.status -eq 'UNLOCKED_AND_KDF_UPGRADED_READBACK_VERIFIED' -and $upgradeCheck.iterations -eq 600000) -Failure 'LEGACY_KDF_UPGRADE_TO_600K'
    Assert-EpTest -Condition ($upgradeCheck.legacyMarker -ceq 'legacy-value-only' -and $upgradeCheck.originalValue -ceq 'synthetic-value-only') -Failure 'KDF_UPGRADE_PRESERVES_VARIABLES'
    Write-Output 'PASS_LEGACY_KDF_MIGRATION_200K_TO_600K_WITH_READBACK'
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
    $null=Lock-EpVault
    $lockedNoteGates=& $module {
        param($id)
        $blocked=[ordered]@{list=$false;read=$false;delete=$false;capture=$false}
        try{$null=Get-EpVaultNotes}catch{$blocked.list=$_.Exception.Message -match 'VAULT_SESSION_REVOKED_OR_UNAVAILABLE|VAULT_SESSION_NOT_OPEN'}
        try{$null=Get-EpVaultNote -NoteId $id -Reveal}catch{$blocked.read=$_.Exception.Message -match 'VAULT_SESSION_REVOKED_OR_UNAVAILABLE|VAULT_SESSION_NOT_OPEN'}
        try{$null=Remove-EpVaultNote -NoteId $id -Approved}catch{$blocked.delete=$_.Exception.Message -match 'VAULT_SESSION_REVOKED_OR_UNAVAILABLE|VAULT_SESSION_NOT_OPEN'}
        try{$null=New-EpVaultNoteFromClipboard}catch{$blocked.capture=$_.Exception.Message -match 'VAULT_SESSION_REVOKED_OR_UNAVAILABLE|VAULT_SESSION_NOT_OPEN'}
        return [pscustomobject]$blocked
    } $noteId
    Assert-EpTest -Condition ($lockedNoteGates.list -and $lockedNoteGates.read -and $lockedNoteGates.delete -and $lockedNoteGates.capture) -Failure 'ALL_NOTE_OPERATIONS_REQUIRE_ACTIVE_VAULT_SESSION'
    $null=Unlock-EpVault -Master $secure -DurationSeconds 300
    Write-Output 'PASS_LOCKED_NOTE_OPERATIONS_FAIL_CLOSED'
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
    # Prove that an independent CLI process reuses the current-user shared session without prompting.
    $null = Unlock-EpVault -Master $secure -DurationSeconds 300
    $cliStdout = Join-Path $sandbox 'ep-vault-cli-shared-out.txt'
    $cliStderr = Join-Path $sandbox 'ep-vault-cli-shared-err.txt'
    $powerShellExe = Join-Path $PSHOME 'powershell.exe'
    $cliArguments = '-NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "' + $cliPath + '" -Action ListVariables -DurationSeconds 300'
    $cliProcess = Start-Process -FilePath $powerShellExe -ArgumentList $cliArguments -PassThru -Wait -WindowStyle Hidden -RedirectStandardOutput $cliStdout -RedirectStandardError $cliStderr
    $cliOutput = if (Test-Path -LiteralPath $cliStdout) { [IO.File]::ReadAllText($cliStdout) } else { '' }
    $cliError = if (Test-Path -LiteralPath $cliStderr) { [IO.File]::ReadAllText($cliStderr) } else { '' }
    Assert-EpTest -Condition ($cliProcess.ExitCode -eq 0 -and $cliOutput -match 'EP_VAULT_SYNTHETIC' -and $cliOutput -notmatch 'master password|enter locally') -Failure 'CLI_REUSES_SHARED_SESSION_WITHOUT_PASSWORD_PROMPT'
    $null = Get-EpVaultSession

    $lockArguments = '-NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "' + $cliPath + '" -Action Lock'
    $lockProcess = Start-Process -FilePath $powerShellExe -ArgumentList $lockArguments -PassThru -Wait -WindowStyle Hidden -RedirectStandardOutput $cliStdout -RedirectStandardError $cliStderr
    Assert-EpTest -Condition ($lockProcess.ExitCode -eq 0) -Failure 'CLI_SHARED_LOCK_EXIT_ZERO'
    $crossProcessRevoked = $false
    try { $null = Get-EpVaultSession }
    catch {
        $crossProcessRevoked = $_.Exception.Message -match 'VAULT_SESSION_REVOKED_OR_UNAVAILABLE|VAULT_SESSION_NOT_OPEN'
    }
    Assert-EpTest -Condition $crossProcessRevoked -Failure 'CLI_LOCK_REVOKES_OTHER_PROCESS_SESSION'
    $null = Unlock-EpVault -Master $secure -DurationSeconds 300
    Write-Output 'PASS_CLI_GUI_SHARED_SESSION_REUSE_AND_REVOCATION'
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