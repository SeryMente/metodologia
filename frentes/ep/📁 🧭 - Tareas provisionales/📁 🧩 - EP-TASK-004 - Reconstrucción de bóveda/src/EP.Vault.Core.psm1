Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$script:EnvelopeSchema = 'ep-env-vault/1'
$script:PayloadSchema = 'ep-env-vault-data/1'
$script:KdfName = 'PBKDF2-HMAC-SHA256'
$script:CipherName = 'AES-256-CBC+HMAC-SHA256'
$script:Iterations = 200000
$script:Session = $null
$script:ClipboardType = 'EPVault.NativeClipboard'
$script:JobType = 'EPVault.ManagedJobRunner'

function Get-EpVaultPaths {
    if ([string]::IsNullOrWhiteSpace($env:LOCALAPPDATA)) {
        throw 'LOCALAPPDATA_UNAVAILABLE'
    }
    $root = Join-Path $env:LOCALAPPDATA 'Khora\secrets'
    [pscustomobject]@{
        Root = $root
        Vault = (Join-Path $root 'ep-env-vault.enc.json')
        Notes = (Join-Path $root 'working-notes')
        Events = (Join-Path $root 'ep-env-vault-events.jsonl')
    }
}

function New-EpRandomBytes {
    param([Parameter(Mandatory=$true)][ValidateRange(1,4096)][int]$Count)
    $bytes = New-Object byte[] $Count
    $rng = [Security.Cryptography.RandomNumberGenerator]::Create()
    try { $rng.GetBytes($bytes) }
    finally { $rng.Dispose() }
    return ,$bytes
}

function Clear-EpBytes {
    param([byte[]]$Bytes)
    if ($null -ne $Bytes -and $Bytes.Length -gt 0) {
        [Array]::Clear($Bytes, 0, $Bytes.Length)
    }
}

function ConvertFrom-EpSecureString {
    param([Parameter(Mandatory=$true)][Security.SecureString]$SecureString)
    $pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
    try {
        return [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
    }
    finally {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
    }
}

function Get-EpMasterKey {
    param(
        [Parameter(Mandatory=$true)][Security.SecureString]$Master,
        [Parameter(Mandatory=$true)][byte[]]$Salt
    )
    $plain = $null
    $derive = $null
    try {
        $plain = ConvertFrom-EpSecureString -SecureString $Master
        $derive = [Security.Cryptography.Rfc2898DeriveBytes]::new(
            $plain,
            $Salt,
            $script:Iterations,
            [Security.Cryptography.HashAlgorithmName]::SHA256
        )
        return ,$derive.GetBytes(64)
    }
    finally {
        $plain = $null
        if ($derive) { $derive.Dispose() }
    }
}

function Test-EpBytesEqual {
    param([byte[]]$A, [byte[]]$B)
    if ($null -eq $A -or $null -eq $B -or $A.Length -ne $B.Length) {
        return $false
    }
    $difference = 0
    for ($i = 0; $i -lt $A.Length; $i++) {
        $difference = $difference -bor ($A[$i] -bxor $B[$i])
    }
    return ($difference -eq 0)
}

function Get-EpMacInput {
    param([Parameter(Mandatory=$true)]$Envelope)
    $text = [string]::Join('|', @(
        [string]$Envelope.schema,
        [string]$Envelope.version,
        [string]$Envelope.kdf,
        [string]$Envelope.iterations,
        [string]$Envelope.cipher,
        [string]$Envelope.salt,
        [string]$Envelope.iv,
        [string]$Envelope.updatedAtUtc,
        [string]$Envelope.ciphertext
    ))
    return [Text.Encoding]::UTF8.GetBytes($text)
}

function New-EpVaultEnvelope {
    param(
        [Parameter(Mandatory=$true)][System.Collections.IDictionary]$Variables,
        [Parameter(Mandatory=$true)][byte[]]$Key,
        [Parameter(Mandatory=$true)][byte[]]$Salt
    )

    if ($Key.Length -ne 64 -or $Salt.Length -ne 16) {
        throw 'VAULT_KEY_OR_SALT_LENGTH_INVALID'
    }

    $iv = New-EpRandomBytes -Count 16
    $aes = [Security.Cryptography.Aes]::Create()
    $plain = $null
    $ciphertext = $null
    $hmac = $null
    $macKey = $null
    try {
        $aes.KeySize = 256
        $aes.BlockSize = 128
        $aes.Mode = [Security.Cryptography.CipherMode]::CBC
        $aes.Padding = [Security.Cryptography.PaddingMode]::PKCS7
        $aes.Key = [byte[]]$Key[0..31]
        $aes.IV = $iv

        $payload = [ordered]@{
            schema = $script:PayloadSchema
            variables = $Variables
        }
        $json = ConvertTo-Json -InputObject $payload -Depth 12 -Compress
        $plain = [Text.Encoding]::UTF8.GetBytes($json)

        $encryptor = $aes.CreateEncryptor()
        try {
            $ciphertext = $encryptor.TransformFinalBlock($plain, 0, $plain.Length)
        }
        finally {
            $encryptor.Dispose()
        }

        $envelope = [pscustomobject][ordered]@{
            schema = $script:EnvelopeSchema
            version = 1
            kdf = $script:KdfName
            iterations = $script:Iterations
            cipher = $script:CipherName
            salt = [Convert]::ToBase64String($Salt)
            iv = [Convert]::ToBase64String($iv)
            updatedAtUtc = [DateTime]::UtcNow.ToString('o')
            ciphertext = [Convert]::ToBase64String($ciphertext)
        }

        $macKey = [byte[]]$Key[32..63]
        $hmac = [Security.Cryptography.HMACSHA256]::new($macKey)
        $tag = $hmac.ComputeHash((Get-EpMacInput -Envelope $envelope))
        $envelope | Add-Member -MemberType NoteProperty -Name tag -Value ([Convert]::ToBase64String($tag))
        return $envelope
    }
    finally {
        if ($hmac) { $hmac.Dispose() }
        $aes.Dispose()
        Clear-EpBytes -Bytes $iv
        Clear-EpBytes -Bytes $macKey
        Clear-EpBytes -Bytes $plain
        Clear-EpBytes -Bytes $ciphertext
    }
}

function Open-EpVaultEnvelope {
    param(
        [Parameter(Mandatory=$true)]$Envelope,
        [Parameter(Mandatory=$true)][byte[]]$Key
    )

    if ($Envelope.schema -cne $script:EnvelopeSchema -or
        [int]$Envelope.version -ne 1 -or
        $Envelope.kdf -cne $script:KdfName -or
        [int]$Envelope.iterations -ne $script:Iterations -or
        $Envelope.cipher -cne $script:CipherName) {
        throw 'VAULT_FORMAT_OR_ALGORITHM_UNSUPPORTED'
    }

    $salt = [Convert]::FromBase64String([string]$Envelope.salt)
    $iv = [Convert]::FromBase64String([string]$Envelope.iv)
    $ciphertext = [Convert]::FromBase64String([string]$Envelope.ciphertext)
    $tag = [Convert]::FromBase64String([string]$Envelope.tag)
    $macKey = $null
    $expected = $null
    $hmac = $null
    $aes = $null
    $plain = $null

    try {
        if ($salt.Length -ne 16 -or $iv.Length -ne 16 -or
            $ciphertext.Length -lt 16 -or ($ciphertext.Length % 16) -ne 0 -or
            $tag.Length -ne 32 -or $Key.Length -ne 64) {
            throw 'VAULT_BINARY_FORMAT_INVALID'
        }

        $macKey = [byte[]]$Key[32..63]
        $hmac = [Security.Cryptography.HMACSHA256]::new($macKey)
        $expected = $hmac.ComputeHash((Get-EpMacInput -Envelope $Envelope))
        if (-not (Test-EpBytesEqual -A $tag -B $expected)) {
            throw 'MASTER_PASSWORD_INVALID_OR_VAULT_TAMPERED'
        }

        $aes = [Security.Cryptography.Aes]::Create()
        $aes.KeySize = 256
        $aes.BlockSize = 128
        $aes.Mode = [Security.Cryptography.CipherMode]::CBC
        $aes.Padding = [Security.Cryptography.PaddingMode]::PKCS7
        $aes.Key = [byte[]]$Key[0..31]
        $aes.IV = $iv

        $decryptor = $aes.CreateDecryptor()
        try {
            $plain = $decryptor.TransformFinalBlock($ciphertext, 0, $ciphertext.Length)
        }
        finally {
            $decryptor.Dispose()
        }

        $payload = [Text.Encoding]::UTF8.GetString($plain) | ConvertFrom-Json
        if ($payload.schema -cne $script:PayloadSchema -or $null -eq $payload.variables) {
            throw 'VAULT_PAYLOAD_INVALID'
        }
        return $payload
    }
    finally {
        if ($hmac) { $hmac.Dispose() }
        if ($aes) { $aes.Dispose() }
        Clear-EpBytes -Bytes $salt
        Clear-EpBytes -Bytes $iv
        Clear-EpBytes -Bytes $ciphertext
        Clear-EpBytes -Bytes $tag
        Clear-EpBytes -Bytes $macKey
        Clear-EpBytes -Bytes $expected
        Clear-EpBytes -Bytes $plain
    }
}

function Ensure-EpPrivateDirectory {
    param([Parameter(Mandatory=$true)][string]$Path)

    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $userSid = $identity.User
    $systemSid = [Security.Principal.SecurityIdentifier]::new('S-1-5-18')
    $allowed = @($userSid.Value, $systemSid.Value)

    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        $acl = [Security.AccessControl.DirectorySecurity]::new()
        $acl.SetAccessRuleProtection($true, $false)
        $acl.SetOwner($userSid)
        $inheritance = [Security.AccessControl.InheritanceFlags]::ContainerInherit -bor
            [Security.AccessControl.InheritanceFlags]::ObjectInherit
        $rights = [Security.AccessControl.FileSystemRights]::FullControl
        $propagation = [Security.AccessControl.PropagationFlags]::None
        $allow = [Security.AccessControl.AccessControlType]::Allow
        $acl.AddAccessRule([Security.AccessControl.FileSystemAccessRule]::new(
            $userSid, $rights, $inheritance, $propagation, $allow
        ))
        $acl.AddAccessRule([Security.AccessControl.FileSystemAccessRule]::new(
            $systemSid, $rights, $inheritance, $propagation, $allow
        ))
        [IO.Directory]::CreateDirectory($Path, $acl) | Out-Null
    }

    $currentAcl = Get-Acl -LiteralPath $Path
    if (-not $currentAcl.AreAccessRulesProtected) {
        throw 'VAULT_DIRECTORY_ACL_NOT_PRIVATE'
    }
    if ($allowed -notcontains ([string]$currentAcl.Owner)) {
        $ownerSid = $null
        try { $ownerSid = ([Security.Principal.NTAccount]$currentAcl.Owner).Translate([Security.Principal.SecurityIdentifier]).Value } catch { }
        if ($allowed -notcontains $ownerSid) { throw 'VAULT_DIRECTORY_OWNER_UNEXPECTED' }
    }
    $allowSids = @()
    foreach ($rule in $currentAcl.GetAccessRules($true, $false, [Security.Principal.SecurityIdentifier])) {
        if ($rule.AccessControlType -eq [Security.AccessControl.AccessControlType]::Allow) {
            if ($allowed -notcontains $rule.IdentityReference.Value) {
                throw 'VAULT_DIRECTORY_HAS_UNEXPECTED_ALLOW_RULE'
            }
            if (($rule.FileSystemRights -band [Security.AccessControl.FileSystemRights]::FullControl) -ne [Security.AccessControl.FileSystemRights]::FullControl) {
                throw 'VAULT_DIRECTORY_ALLOW_RULE_NOT_FULL_CONTROL'
            }
            $allowSids += [string]$rule.IdentityReference.Value
        }
    }
    foreach ($sid in $allowed) {
        if ($allowSids -notcontains $sid) { throw 'VAULT_DIRECTORY_REQUIRED_ALLOW_RULE_MISSING' }
    }
}

function Write-EpVaultEvent {
    param([Parameter(Mandatory=$true)][string]$Event)
    try {
        $paths = Get-EpVaultPaths
        Ensure-EpPrivateDirectory -Path $paths.Root
        $record = [ordered]@{
            timestampUtc = [DateTime]::UtcNow.ToString('o')
            event = $Event
            processId = $PID
            powershellVersion = $PSVersionTable.PSVersion.ToString()
        }
        $line = (ConvertTo-Json -InputObject $record -Compress) + [Environment]::NewLine
        [IO.File]::AppendAllText($paths.Events, $line, [Text.UTF8Encoding]::new($false))
    }
    catch {
        # Event logging must not turn a successful vault operation into a failed write.
    }
}

function Write-EpVaultAtomic {
    param(
        [Parameter(Mandatory=$true)]$Envelope,
        [Parameter(Mandatory=$true)][string]$Path
    )
    $directory = Split-Path -Parent $Path
    Ensure-EpPrivateDirectory -Path $directory

    $json = ConvertTo-Json -InputObject $Envelope -Depth 12
    $bytes = [Text.UTF8Encoding]::new($false).GetBytes($json)
    $temporary = $Path + '.tmp-' + [Guid]::NewGuid().ToString('N')
    $stream = $null
    try {
        $stream = [IO.FileStream]::new(
            $temporary,
            [IO.FileMode]::CreateNew,
            [IO.FileAccess]::Write,
            [IO.FileShare]::None
        )
        $stream.Write($bytes, 0, $bytes.Length)
        $stream.Flush($true)
        $stream.Dispose()
        $stream = $null

        if (Test-Path -LiteralPath $Path -PathType Leaf) {
            $backup = $Path + '.pre-' + [Guid]::NewGuid().ToString('N') + '.bak'
            [IO.File]::Replace($temporary, $Path, $backup)
        }
        else {
            [IO.File]::Move($temporary, $Path)
        }
    }
    catch {
        if ($stream) { $stream.Dispose() }
        if (Test-Path -LiteralPath $temporary) {
            Remove-Item -LiteralPath $temporary -Force -ErrorAction SilentlyContinue
        }
        throw 'VAULT_ATOMIC_WRITE_FAILED_PREVIOUS_FILE_PRESERVED'
    }
    finally {
        Clear-EpBytes -Bytes $bytes
    }
}

function Read-EpVaultEnvelope {
    $paths = Get-EpVaultPaths
    if (-not (Test-Path -LiteralPath $paths.Vault -PathType Leaf)) {
        throw 'VAULT_NOT_INITIALIZED'
    }
    try {
        return ([IO.File]::ReadAllText($paths.Vault, [Text.Encoding]::UTF8) | ConvertFrom-Json)
    }
    catch {
        throw 'VAULT_ENVELOPE_INVALID'
    }
}

function Get-EpVaultStatus {
    $paths = Get-EpVaultPaths
    $exists = Test-Path -LiteralPath $paths.Vault -PathType Leaf
    if (-not $exists) {
        return [pscustomobject]@{
            status = 'NOT_INITIALIZED'
            vaultExists = $false
            schema = $null
            updatedAtUtc = $null
            bytes = 0
            sessionActive = $false
        }
    }

    $file = Get-Item -LiteralPath $paths.Vault
    $envelope = Read-EpVaultEnvelope
    [pscustomobject]@{
        status = 'ENCRYPTED_FILE_PRESENT'
        vaultExists = $true
        schema = [string]$envelope.schema
        updatedAtUtc = [string]$envelope.updatedAtUtc
        bytes = [long]$file.Length
        sessionActive = ($null -ne $script:Session)
    }
}

function Set-EpVaultSession {
    param(
        [Parameter(Mandatory=$true)][byte[]]$Key,
        [Parameter(Mandatory=$true)][ValidateSet(15,30,60,120,180,300,600,900)][int]$DurationSeconds
    )
    if ($script:Session -and $script:Session.Key) {
        Clear-EpBytes -Bytes $script:Session.Key
    }
    $now = [DateTime]::UtcNow
    $script:Session = [pscustomobject]@{
        key = $Key
        startedAtUtc = $now
        expiresAtUtc = $now.AddSeconds($DurationSeconds)
        durationSeconds = $DurationSeconds
        sessionId = [Guid]::NewGuid().ToString('N')
    }
}

function Initialize-EpVault {
    param(
        [Parameter(Mandatory=$true)][Security.SecureString]$Master,
        [ValidateSet(15,30,60,120,180,300,600,900)][int]$DurationSeconds = 300
    )
    $paths = Get-EpVaultPaths
    Ensure-EpPrivateDirectory -Path $paths.Root
    if (Test-Path -LiteralPath $paths.Vault) {
        throw 'VAULT_ALREADY_EXISTS_REFUSING_OVERWRITE'
    }

    $salt = New-EpRandomBytes -Count 16
    $key = Get-EpMasterKey -Master $Master -Salt $salt
    $lock = $null
    try {
        $lockPath = $paths.Vault + '.lock'
        try {
            $lock = [IO.FileStream]::new($lockPath, [IO.FileMode]::OpenOrCreate, [IO.FileAccess]::ReadWrite, [IO.FileShare]::None)
        }
        catch {
            throw 'VAULT_BUSY_OR_LOCK_UNAVAILABLE'
        }
        if (Test-Path -LiteralPath $paths.Vault) {
            throw 'VAULT_CREATED_CONCURRENTLY_REFUSING_OVERWRITE'
        }

        $empty = [ordered]@{}
        $envelope = New-EpVaultEnvelope -Variables $empty -Key $key -Salt $salt
        Write-EpVaultAtomic -Envelope $envelope -Path $paths.Vault
        $readback = Read-EpVaultEnvelope
        $check = Open-EpVaultEnvelope -Envelope $readback -Key $key
        if (@($check.variables.PSObject.Properties).Count -ne 0) {
            throw 'VAULT_INITIALIZATION_READBACK_FAILED'
        }
        Set-EpVaultSession -Key $key -DurationSeconds $DurationSeconds
        $key = $null
        Write-EpVaultEvent -Event 'VAULT_INITIALIZED'
        return [pscustomobject]@{
            status = 'INITIALIZED_AND_READBACK_VERIFIED'
            expiresAtUtc = $script:Session.expiresAtUtc.ToString('o')
            durationSeconds = $DurationSeconds
        }
    }
    finally {
        if ($lock) { $lock.Dispose() }
        Clear-EpBytes -Bytes $salt
        Clear-EpBytes -Bytes $key
    }
}

function Unlock-EpVault {
    param(
        [Parameter(Mandatory=$true)][Security.SecureString]$Master,
        [ValidateSet(15,30,60,120,180,300,600,900)][int]$DurationSeconds = 300
    )
    $envelope = Read-EpVaultEnvelope
    $salt = [Convert]::FromBase64String([string]$envelope.salt)
    $key = $null
    try {
        if ($salt.Length -ne 16) { throw 'VAULT_SALT_INVALID' }
        $key = Get-EpMasterKey -Master $Master -Salt $salt
        $null = Open-EpVaultEnvelope -Envelope $envelope -Key $key
        Set-EpVaultSession -Key $key -DurationSeconds $DurationSeconds
        $key = $null
        Write-EpVaultEvent -Event 'VAULT_UNLOCKED'
        return [pscustomobject]@{
            status = 'UNLOCKED'
            expiresAtUtc = $script:Session.expiresAtUtc.ToString('o')
            durationSeconds = $DurationSeconds
        }
    }
    finally {
        Clear-EpBytes -Bytes $salt
        Clear-EpBytes -Bytes $key
    }
}

function Lock-EpVault {
    if ($script:Session -and $script:Session.Key) {
        Clear-EpBytes -Bytes $script:Session.Key
    }
    $script:Session = $null
    Write-EpVaultEvent -Event 'VAULT_LOCKED'
    return 'VAULT_SESSION_LOCKED'
}

function Assert-EpVaultSession {
    if ($null -eq $script:Session -or $null -eq $script:Session.Key) {
        throw 'VAULT_SESSION_NOT_OPEN'
    }
    if ([DateTime]::UtcNow -ge $script:Session.expiresAtUtc) {
        $null = Lock-EpVault
        throw 'VAULT_SESSION_EXPIRED'
    }
}

function Get-EpVaultSession {
    Assert-EpVaultSession
    $remaining = [Math]::Max(0, [Math]::Ceiling(($script:Session.expiresAtUtc - [DateTime]::UtcNow).TotalSeconds))
    [pscustomobject]@{
        active = $true
        startedAtUtc = $script:Session.startedAtUtc.ToString('o')
        expiresAtUtc = $script:Session.expiresAtUtc.ToString('o')
        durationSeconds = [int]$script:Session.durationSeconds
        remainingSeconds = [int]$remaining
    }
}

function Get-EpVaultData {
    Assert-EpVaultSession
    $envelope = Read-EpVaultEnvelope
    return Open-EpVaultEnvelope -Envelope $envelope -Key $script:Session.Key
}

function ConvertTo-EpOrderedVariables {
    param([Parameter(Mandatory=$true)]$Variables)
    $ordered = [ordered]@{}
    foreach ($property in $Variables.PSObject.Properties) {
        if ($property.MemberType -eq [System.Management.Automation.PSMemberTypes]::NoteProperty) {
            $ordered[[string]$property.Name] = [string]$property.Value
        }
    }
    return $ordered
}

function Test-EpVariableName {
    param([Parameter(Mandatory=$true)][string]$Name)
    return ($Name -cmatch '^[A-Za-z_][A-Za-z0-9_]{0,127}$')
}

function Get-EpVaultVariableNames {
    $data = Get-EpVaultData
    try {
        $names = @(
            foreach ($property in $data.variables.PSObject.Properties) {
                if ($property.MemberType -eq [System.Management.Automation.PSMemberTypes]::NoteProperty) {
                    [string]$property.Name
                }
            }
        )
        return @($names | Sort-Object -CaseSensitive)
    }
    finally {
        $data = $null
    }
}

function Get-EpVaultVariableValue {
    param(
        [Parameter(Mandatory=$true)][string]$Name,
        [switch]$Reveal
    )
    if (-not $Reveal) { throw 'VARIABLE_READ_REQUIRES_EXPLICIT_REVEAL' }
    if (-not (Test-EpVariableName -Name $Name)) { throw 'INVALID_ENVIRONMENT_VARIABLE_NAME' }
    $data = Get-EpVaultData
    try {
        $property = $data.variables.PSObject.Properties[$Name]
        if ($null -eq $property) { throw 'VARIABLE_NOT_FOUND' }
        return [string]$property.Value
    }
    finally {
        $data = $null
    }
}

function Save-EpVaultVariables {
    param([Parameter(Mandatory=$true)][System.Collections.IDictionary]$Variables)
    Assert-EpVaultSession
    $paths = Get-EpVaultPaths
    $lock = $null
    try {
        try {
            $lock = [IO.FileStream]::new(
                ($paths.Vault + '.lock'),
                [IO.FileMode]::OpenOrCreate,
                [IO.FileAccess]::ReadWrite,
                [IO.FileShare]::None
            )
        }
        catch {
            throw 'VAULT_BUSY_OR_LOCK_UNAVAILABLE'
        }

        $current = Read-EpVaultEnvelope
        $salt = [Convert]::FromBase64String([string]$current.salt)
        try {
            $updated = New-EpVaultEnvelope -Variables $Variables -Key $script:Session.Key -Salt $salt
            Write-EpVaultAtomic -Envelope $updated -Path $paths.Vault
            $readbackEnvelope = Read-EpVaultEnvelope
            $readback = Open-EpVaultEnvelope -Envelope $readbackEnvelope -Key $script:Session.Key
            $expectedNames = @($Variables.Keys | Sort-Object -CaseSensitive)
            $actualNames = @(
                foreach ($property in $readback.variables.PSObject.Properties) {
                    if ($property.MemberType -eq [System.Management.Automation.PSMemberTypes]::NoteProperty) {
                        [string]$property.Name
                    }
                }
            ) | Sort-Object -CaseSensitive
            if (($expectedNames -join [char]10) -cne ($actualNames -join [char]10)) {
                throw 'VAULT_WRITE_READBACK_NAMES_MISMATCH'
            }
            foreach ($name in $expectedNames) {
                if ([string]$readback.variables.PSObject.Properties[$name].Value -cne [string]$Variables[$name]) {
                    throw 'VAULT_WRITE_READBACK_VALUE_MISMATCH'
                }
            }
            Write-EpVaultEvent -Event 'VAULT_DATA_UPDATED'
            return 'VAULT_WRITE_READBACK_VERIFIED'
        }
        finally {
            Clear-EpBytes -Bytes $salt
        }
    }
    finally {
        if ($lock) { $lock.Dispose() }
    }
}

function Set-EpVaultVariable {
    param(
        [Parameter(Mandatory=$true)][string]$Name,
        [Parameter(Mandatory=$true)][string]$Value,
        [switch]$Replace
    )
    Assert-EpVaultSession
    if (-not (Test-EpVariableName -Name $Name)) { throw 'INVALID_ENVIRONMENT_VARIABLE_NAME' }
    if ([string]::IsNullOrWhiteSpace($Value) -or $Value.Contains([char]0)) {
        throw 'VARIABLE_VALUE_INVALID'
    }

    $data = Get-EpVaultData
    try {
        $variables = ConvertTo-EpOrderedVariables -Variables $data.variables
        if ($variables.Contains($Name) -and -not $Replace) {
            throw 'VARIABLE_ALREADY_EXISTS_USE_EXPLICIT_REPLACE'
        }
        $variables[$Name] = $Value
        $result = Save-EpVaultVariables -Variables $variables
        return [pscustomobject]@{ status = $result; name = $Name }
    }
    finally {
        $data = $null
        $variables = $null
    }
}

function Remove-EpVaultVariable {
    param(
        [Parameter(Mandatory=$true)][string]$Name,
        [switch]$Approved
    )
    Assert-EpVaultSession
    if (-not $Approved) { throw 'VARIABLE_REMOVAL_REQUIRES_EXPLICIT_APPROVAL' }
    if (-not (Test-EpVariableName -Name $Name)) { throw 'INVALID_ENVIRONMENT_VARIABLE_NAME' }

    $data = Get-EpVaultData
    try {
        $variables = ConvertTo-EpOrderedVariables -Variables $data.variables
        if (-not $variables.Contains($Name)) { throw 'VARIABLE_NOT_FOUND' }
        [void]$variables.Remove($Name)
        $result = Save-EpVaultVariables -Variables $variables
        $check = Get-EpVaultData
        try {
            if ($null -ne $check.variables.PSObject.Properties[$Name]) {
                throw 'VAULT_REMOVE_READBACK_FAILED'
            }
        }
        finally {
            $check = $null
        }
        Write-EpVaultEvent -Event 'VAULT_VARIABLE_REMOVED'
        return [pscustomobject]@{ status = 'REMOVED_AND_VERIFIED'; name = $Name }
    }
    finally {
        $data = $null
        $variables = $null
    }
}

function Ensure-EpClipboardType {
    if ($script:ClipboardType -as [type]) { return }
    $source = @'
using System;
using System.ComponentModel;
using System.Runtime.InteropServices;

namespace EPVault {
    public static class NativeClipboard {
        [DllImport("user32.dll", SetLastError=true)]
        private static extern bool OpenClipboard(IntPtr owner);
        [DllImport("user32.dll", SetLastError=true)]
        private static extern bool CloseClipboard();
        [DllImport("user32.dll", SetLastError=true)]
        private static extern IntPtr GetClipboardData(uint format);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern IntPtr GlobalLock(IntPtr memory);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern bool GlobalUnlock(IntPtr memory);
        [DllImport("user32.dll", SetLastError=true)]
        private static extern bool EmptyClipboard();
        [DllImport("user32.dll", SetLastError=true)]
        private static extern bool IsClipboardFormatAvailable(uint format);

        public static string ReadUnicodeTextAndClear() {
            if (!OpenClipboard(IntPtr.Zero))
                throw new Win32Exception(Marshal.GetLastWin32Error(), "CLIPBOARD_OPEN_FAILED");
            try {
                IntPtr handle = GetClipboardData(13);
                if (handle == IntPtr.Zero)
                    throw new InvalidOperationException("CLIPBOARD_NO_UNICODE_TEXT");
                IntPtr pointer = GlobalLock(handle);
                if (pointer == IntPtr.Zero)
                    throw new Win32Exception(Marshal.GetLastWin32Error(), "CLIPBOARD_LOCK_FAILED");
                string value;
                try { value = Marshal.PtrToStringUni(pointer); }
                finally { GlobalUnlock(handle); }

                if (String.IsNullOrWhiteSpace(value))
                    throw new InvalidOperationException("CLIPBOARD_EMPTY");
                if (!EmptyClipboard())
                    throw new Win32Exception(Marshal.GetLastWin32Error(), "CLIPBOARD_CLEAR_FAILED");
                if (IsClipboardFormatAvailable(13) || IsClipboardFormatAvailable(1))
                    throw new InvalidOperationException("CLIPBOARD_CLEAR_NOT_VERIFIED");
                return value;
            }
            finally {
                CloseClipboard();
            }
        }
    }
}
'@
    Add-Type -TypeDefinition $source -Language CSharp -ErrorAction Stop
}

function Read-EpClipboardAndClear {
    Ensure-EpClipboardType
    try {
        return [EPVault.NativeClipboard]::ReadUnicodeTextAndClear()
    }
    catch {
        throw 'CLIPBOARD_CAPTURE_OR_CLEAR_FAILED_VALUE_NOT_STORED'
    }
}

function Set-EpVaultVariableFromClipboard {
    param([Parameter(Mandatory=$true)][string]$Name, [switch]$Replace)
    $value = Read-EpClipboardAndClear
    try {
        $value = $value.TrimEnd([char[]]@([char]13,[char]10))
        return Set-EpVaultVariable -Name $Name -Value $value -Replace:$Replace
    }
    finally {
        $value = $null
    }
}

function Ensure-EpWorkingNotesDirectory {
    $paths = Get-EpVaultPaths
    Ensure-EpPrivateDirectory -Path $paths.Root
    Ensure-EpPrivateDirectory -Path $paths.Notes
    return $paths.Notes
}

function Get-EpWorkingNotePath {
    param([Parameter(Mandatory=$true)][string]$NoteId)
    if ($NoteId -cnotmatch '^N-[0-9]{14}-[A-F0-9]{8}$') {
        throw 'WORKING_NOTE_ID_INVALID'
    }
    return (Join-Path (Ensure-EpWorkingNotesDirectory) ($NoteId + '.note.json'))
}

function Remove-EpExpiredWorkingNotes {
    $directory = Ensure-EpWorkingNotesDirectory
    $now = [DateTime]::UtcNow
    foreach ($file in Get-ChildItem -LiteralPath $directory -Filter '*.note.json' -File -ErrorAction SilentlyContinue) {
        try {
            $metadata = [IO.File]::ReadAllText($file.FullName, [Text.Encoding]::UTF8) | ConvertFrom-Json
            if ([DateTime]::Parse([string]$metadata.expiresAtUtc).ToUniversalTime() -le $now) {
                Remove-Item -LiteralPath $file.FullName -Force -ErrorAction Stop
                Write-EpVaultEvent -Event 'WORKING_NOTE_EXPIRED'
            }
        }
        catch {
            # Malformed notes are not revealed or automatically deleted.
        }
    }
}

function New-EpVaultNoteFromClipboard {
    param([ValidateRange(1,240)][int]$TtlMinutes = 30)
    $value = Read-EpClipboardAndClear
    $plain = $null
    $protected = $null
    $entropy = [Text.Encoding]::UTF8.GetBytes('EP-ENV-VAULT-WORKING-NOTE-V1')
    try {
        if ([string]::IsNullOrWhiteSpace($value) -or $value.Contains([char]0)) {
            throw 'WORKING_NOTE_VALUE_INVALID'
        }
        Remove-EpExpiredWorkingNotes
        $id = 'N-' + [DateTime]::UtcNow.ToString('yyyyMMddHHmmss') + '-' +
            ([Guid]::NewGuid().ToString('N').Substring(0,8).ToUpperInvariant())
        $created = [DateTime]::UtcNow
        $expires = $created.AddMinutes($TtlMinutes)
        $payload = [ordered]@{
            id = $id
            createdAtUtc = $created.ToString('o')
            expiresAtUtc = $expires.ToString('o')
            value = $value
        }
        $plain = [Text.UTF8Encoding]::new($false).GetBytes((ConvertTo-Json -InputObject $payload -Compress -Depth 4))
        Add-Type -AssemblyName System.Security
        $protected = [Security.Cryptography.ProtectedData]::Protect(
            $plain, $entropy, [Security.Cryptography.DataProtectionScope]::CurrentUser
        )
        $record = [ordered]@{
            schema = 'ep-env-vault-working-note/1'
            id = $id
            createdAtUtc = $created.ToString('o')
            expiresAtUtc = $expires.ToString('o')
            protection = 'DPAPI-CURRENT-USER'
            payload = [Convert]::ToBase64String($protected)
        }
        $path = Get-EpWorkingNotePath -NoteId $id
        $temporary = $path + '.tmp'
        [IO.File]::WriteAllText($temporary, (ConvertTo-Json -InputObject $record -Depth 4), [Text.UTF8Encoding]::new($false))
        [IO.File]::Move($temporary, $path)
        Write-EpVaultEvent -Event 'WORKING_NOTE_CAPTURED'
        return [pscustomobject]@{
            id = $id
            createdAtUtc = $created.ToString('o')
            expiresAtUtc = $expires.ToString('o')
            ttlMinutes = $TtlMinutes
        }
    }
    finally {
        $value = $null
        Clear-EpBytes -Bytes $plain
        Clear-EpBytes -Bytes $protected
        Clear-EpBytes -Bytes $entropy
    }
}

function Get-EpVaultNotes {
    Remove-EpExpiredWorkingNotes
    $directory = Ensure-EpWorkingNotesDirectory
    $items = @(
        foreach ($file in Get-ChildItem -LiteralPath $directory -Filter '*.note.json' -File -ErrorAction SilentlyContinue) {
            try {
                $metadata = [IO.File]::ReadAllText($file.FullName, [Text.Encoding]::UTF8) | ConvertFrom-Json
                [pscustomobject]@{
                    id = [string]$metadata.id
                    createdAtUtc = [string]$metadata.createdAtUtc
                    expiresAtUtc = [string]$metadata.expiresAtUtc
                    status = 'VOLATILE_DPAPI'
                }
            }
            catch { }
        }
    )
    return $items
}

function Get-EpVaultNote {
    param([Parameter(Mandatory=$true)][string]$NoteId, [switch]$Reveal)
    if (-not $Reveal) { throw 'NOTE_READ_REQUIRES_EXPLICIT_REVEAL' }
    Remove-EpExpiredWorkingNotes
    $path = Get-EpWorkingNotePath -NoteId $NoteId
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw 'WORKING_NOTE_NOT_FOUND_OR_EXPIRED'
    }
    $record = [IO.File]::ReadAllText($path, [Text.Encoding]::UTF8) | ConvertFrom-Json
    if ($record.schema -cne 'ep-env-vault-working-note/1' -or
        $record.protection -cne 'DPAPI-CURRENT-USER' -or
        $record.id -cne $NoteId) {
        throw 'WORKING_NOTE_FORMAT_INVALID'
    }

    $cipher = [Convert]::FromBase64String([string]$record.payload)
    $entropy = [Text.Encoding]::UTF8.GetBytes('EP-ENV-VAULT-WORKING-NOTE-V1')
    $plain = $null
    try {
        Add-Type -AssemblyName System.Security
        $plain = [Security.Cryptography.ProtectedData]::Unprotect(
            $cipher, $entropy, [Security.Cryptography.DataProtectionScope]::CurrentUser
        )
        $payload = [Text.Encoding]::UTF8.GetString($plain) | ConvertFrom-Json
        if ($payload.id -cne $NoteId -or
            [DateTime]::Parse([string]$payload.expiresAtUtc).ToUniversalTime() -le [DateTime]::UtcNow) {
            throw 'WORKING_NOTE_EXPIRED_OR_ID_MISMATCH'
        }
        return [pscustomobject]@{
            id = [string]$payload.id
            createdAtUtc = [string]$payload.createdAtUtc
            expiresAtUtc = [string]$payload.expiresAtUtc
            value = [string]$payload.value
        }
    }
    finally {
        Clear-EpBytes -Bytes $cipher
        Clear-EpBytes -Bytes $entropy
        Clear-EpBytes -Bytes $plain
    }
}

function Remove-EpVaultNote {
    param([Parameter(Mandatory=$true)][string]$NoteId)
    $path = Get-EpWorkingNotePath -NoteId $NoteId
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw 'WORKING_NOTE_NOT_FOUND'
    }
    Remove-Item -LiteralPath $path -Force
    if (Test-Path -LiteralPath $path) { throw 'WORKING_NOTE_DELETE_READBACK_FAILED' }
    Write-EpVaultEvent -Event 'WORKING_NOTE_DELETED'
    return 'WORKING_NOTE_DELETED_AND_VERIFIED'
}

function Promote-EpVaultNote {
    param(
        [Parameter(Mandatory=$true)][string]$NoteId,
        [Parameter(Mandatory=$true)][string]$Name,
        [switch]$Replace
    )
    Assert-EpVaultSession
    $note = Get-EpVaultNote -NoteId $NoteId -Reveal
    try {
        $null = Set-EpVaultVariable -Name $Name -Value $note.value -Replace:$Replace
        $readback = Get-EpVaultVariableValue -Name $Name -Reveal
        if ($readback -cne $note.value) { throw 'VAULT_PROMOTION_READBACK_MISMATCH' }
        $null = Remove-EpVaultNote -NoteId $NoteId
        Write-EpVaultEvent -Event 'WORKING_NOTE_PROMOTED'
        return [pscustomobject]@{ status = 'PROMOTED_READBACK_VERIFIED_NOTE_REMOVED'; name = $Name; noteId = $NoteId }
    }
    finally {
        $readback = $null
        $note = $null
    }
}

function Ensure-EpManagedJobType {
    if ($script:JobType -as [type]) { return }
    $source = @'
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Text;
using Microsoft.Win32.SafeHandles;

namespace EPVault {
    public static class ManagedJobRunner {
        [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode)]
        private struct STARTUPINFO {
            public int cb;
            public string lpReserved;
            public string lpDesktop;
            public string lpTitle;
            public int dwX;
            public int dwY;
            public int dwXSize;
            public int dwYSize;
            public int dwXCountChars;
            public int dwYCountChars;
            public int dwFillAttribute;
            public int dwFlags;
            public short wShowWindow;
            public short cbReserved2;
            public IntPtr lpReserved2;
            public IntPtr hStdInput;
            public IntPtr hStdOutput;
            public IntPtr hStdError;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct PROCESS_INFORMATION {
            public IntPtr hProcess;
            public IntPtr hThread;
            public int dwProcessId;
            public int dwThreadId;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct JOBOBJECT_BASIC_LIMIT_INFORMATION {
            public long PerProcessUserTimeLimit;
            public long PerJobUserTimeLimit;
            public uint LimitFlags;
            public UIntPtr MinimumWorkingSetSize;
            public UIntPtr MaximumWorkingSetSize;
            public uint ActiveProcessLimit;
            public UIntPtr Affinity;
            public uint PriorityClass;
            public uint SchedulingClass;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct IO_COUNTERS {
            public ulong ReadOperationCount;
            public ulong WriteOperationCount;
            public ulong OtherOperationCount;
            public ulong ReadTransferCount;
            public ulong WriteTransferCount;
            public ulong OtherTransferCount;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct JOBOBJECT_EXTENDED_LIMIT_INFORMATION {
            public JOBOBJECT_BASIC_LIMIT_INFORMATION BasicLimitInformation;
            public IO_COUNTERS IoInfo;
            public UIntPtr ProcessMemoryLimit;
            public UIntPtr JobMemoryLimit;
            public UIntPtr PeakProcessMemoryUsed;
            public UIntPtr PeakJobMemoryUsed;
        }

        private const uint CREATE_SUSPENDED = 0x00000004;
        private const uint CREATE_UNICODE_ENVIRONMENT = 0x00000400;
        private const uint JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE = 0x00002000;
        private const uint WAIT_OBJECT_0 = 0x00000000;
        private const uint WAIT_TIMEOUT = 0x00000102;
        private const uint INFINITE = 0xFFFFFFFF;
        private const int JobObjectExtendedLimitInformation = 9;

        [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
        private static extern SafeFileHandle CreateJobObject(IntPtr attributes, string name);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern bool SetInformationJobObject(SafeFileHandle job, int infoClass, IntPtr info, uint length);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern bool AssignProcessToJobObject(SafeFileHandle job, IntPtr process);
        [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
        private static extern bool CreateProcess(
            string applicationName, StringBuilder commandLine,
            IntPtr processAttributes, IntPtr threadAttributes,
            bool inheritHandles, uint creationFlags, IntPtr environment,
            string currentDirectory, ref STARTUPINFO startupInfo,
            out PROCESS_INFORMATION processInformation);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern uint ResumeThread(IntPtr thread);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern uint WaitForSingleObject(IntPtr handle, uint milliseconds);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern bool GetExitCodeProcess(IntPtr process, out uint exitCode);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern bool TerminateJobObject(SafeFileHandle job, uint exitCode);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern bool TerminateProcess(IntPtr process, uint exitCode);
        [DllImport("kernel32.dll", SetLastError=true)]
        private static extern bool CloseHandle(IntPtr handle);

        private static string Quote(string value) {
            if (value == null) return "\"\"";
            if (value.Length > 0 && value.IndexOfAny(new char[] {' ', '\t', '\n', '\v', '"'}) < 0)
                return value;
            StringBuilder result = new StringBuilder();
            result.Append('"');
            int slashes = 0;
            foreach (char ch in value) {
                if (ch == '\\') { slashes++; continue; }
                if (ch == '"') {
                    result.Append('\\', slashes * 2 + 1);
                    result.Append('"');
                    slashes = 0;
                    continue;
                }
                if (slashes > 0) { result.Append('\\', slashes); slashes = 0; }
                result.Append(ch);
            }
            if (slashes > 0) result.Append('\\', slashes * 2);
            result.Append('"');
            return result.ToString();
        }

        private static string BuildEnvironment(IDictionary extra) {
            SortedDictionary<string,string> values =
                new SortedDictionary<string,string>(StringComparer.OrdinalIgnoreCase);
            foreach (DictionaryEntry entry in Environment.GetEnvironmentVariables()) {
                values[Convert.ToString(entry.Key)] = Convert.ToString(entry.Value);
            }
            foreach (DictionaryEntry entry in extra) {
                string key = Convert.ToString(entry.Key);
                string value = Convert.ToString(entry.Value);
                if (String.IsNullOrWhiteSpace(key) || key.IndexOf('=') >= 0 ||
                    key.IndexOf('\0') >= 0 || value == null || value.IndexOf('\0') >= 0)
                    throw new ArgumentException("CHILD_ENVIRONMENT_ENTRY_INVALID");
                values[key] = value;
            }
            StringBuilder block = new StringBuilder();
            foreach (KeyValuePair<string,string> item in values) {
                block.Append(item.Key).Append('=').Append(item.Value).Append('\0');
            }
            block.Append('\0');
            return block.ToString();
        }

        public static int Run(string executable, string[] arguments, IDictionary extraEnvironment, int timeoutMilliseconds) {
            if (String.IsNullOrWhiteSpace(executable) || !System.IO.Path.IsPathRooted(executable) ||
                !System.IO.File.Exists(executable))
                throw new ArgumentException("EXECUTABLE_MUST_BE_AN_EXISTING_ABSOLUTE_FILE");
            if (timeoutMilliseconds < 1000)
                throw new ArgumentOutOfRangeException("timeoutMilliseconds");
            if (arguments == null) arguments = new string[0];

            SafeFileHandle job = CreateJobObject(IntPtr.Zero, null);
            if (job == null || job.IsInvalid)
                throw new Win32Exception(Marshal.GetLastWin32Error(), "JOB_CREATE_FAILED");

            IntPtr infoPointer = IntPtr.Zero;
            IntPtr environmentPointer = IntPtr.Zero;
            PROCESS_INFORMATION process = new PROCESS_INFORMATION();
            bool processCreated = false;
            try {
                JOBOBJECT_EXTENDED_LIMIT_INFORMATION limits = new JOBOBJECT_EXTENDED_LIMIT_INFORMATION();
                limits.BasicLimitInformation.LimitFlags = JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE;
                infoPointer = Marshal.AllocHGlobal(Marshal.SizeOf(typeof(JOBOBJECT_EXTENDED_LIMIT_INFORMATION)));
                Marshal.StructureToPtr(limits, infoPointer, false);
                if (!SetInformationJobObject(job, JobObjectExtendedLimitInformation, infoPointer,
                    (uint)Marshal.SizeOf(typeof(JOBOBJECT_EXTENDED_LIMIT_INFORMATION))))
                    throw new Win32Exception(Marshal.GetLastWin32Error(), "JOB_LIMIT_CONFIGURATION_FAILED");

                StringBuilder command = new StringBuilder(Quote(executable));
                foreach (string argument in arguments) {
                    command.Append(' ').Append(Quote(argument));
                }
                environmentPointer = Marshal.StringToHGlobalUni(BuildEnvironment(extraEnvironment));
                STARTUPINFO startup = new STARTUPINFO();
                startup.cb = Marshal.SizeOf(typeof(STARTUPINFO));
                bool created = CreateProcess(
                    executable, command, IntPtr.Zero, IntPtr.Zero, false,
                    CREATE_SUSPENDED | CREATE_UNICODE_ENVIRONMENT,
                    environmentPointer, System.IO.Path.GetDirectoryName(executable),
                    ref startup, out process);
                if (!created)
                    throw new Win32Exception(Marshal.GetLastWin32Error(), "CHILD_PROCESS_CREATE_FAILED");
                processCreated = true;

                if (!AssignProcessToJobObject(job, process.hProcess)) {
                    TerminateProcess(process.hProcess, 127);
                    throw new Win32Exception(Marshal.GetLastWin32Error(), "CHILD_PROCESS_JOB_ASSIGN_FAILED");
                }
                uint resumed = ResumeThread(process.hThread);
                if (resumed == 0xFFFFFFFF) {
                    TerminateJobObject(job, 127);
                    throw new Win32Exception(Marshal.GetLastWin32Error(), "CHILD_PROCESS_RESUME_FAILED");
                }

                uint wait = WaitForSingleObject(process.hProcess, (uint)timeoutMilliseconds);
                if (wait == WAIT_TIMEOUT) {
                    TerminateJobObject(job, 124);
                    WaitForSingleObject(process.hProcess, 5000);
                    throw new TimeoutException("VAULT_SESSION_EXPIRED_CHILD_PROCESS_TREE_TERMINATED");
                }
                if (wait != WAIT_OBJECT_0)
                    throw new Win32Exception(Marshal.GetLastWin32Error(), "CHILD_PROCESS_WAIT_FAILED");

                uint exitCode;
                if (!GetExitCodeProcess(process.hProcess, out exitCode))
                    throw new Win32Exception(Marshal.GetLastWin32Error(), "CHILD_PROCESS_EXIT_CODE_UNAVAILABLE");
                return unchecked((int)exitCode);
            }
            finally {
                if (processCreated) {
                    if (process.hThread != IntPtr.Zero) CloseHandle(process.hThread);
                    if (process.hProcess != IntPtr.Zero) CloseHandle(process.hProcess);
                }
                if (environmentPointer != IntPtr.Zero) Marshal.FreeHGlobal(environmentPointer);
                if (infoPointer != IntPtr.Zero) Marshal.FreeHGlobal(infoPointer);
                job.Dispose(); // KILL_ON_JOB_CLOSE terminates any remaining descendants.
            }
        }
    }
}
'@
    Add-Type -TypeDefinition $source -Language CSharp -ErrorAction Stop
}

function Invoke-EpVaultCommand {
    param(
        [Parameter(Mandatory=$true)][string]$ExecutablePath,
        [string[]]$ArgumentList = @(),
        [Parameter(Mandatory=$true)][string[]]$Names
    )
    Assert-EpVaultSession
    if ($Names.Count -lt 1) { throw 'EXPLICIT_VARIABLE_ALLOWLIST_REQUIRED' }
    if (-not [IO.Path]::IsPathRooted($ExecutablePath) -or -not (Test-Path -LiteralPath $ExecutablePath -PathType Leaf)) {
        throw 'EXECUTABLE_MUST_BE_AN_EXISTING_ABSOLUTE_FILE'
    }

    $values = @{}
    try {
        $data = Get-EpVaultData
        try {
            foreach ($name in $Names) {
                if (-not (Test-EpVariableName -Name $name)) { throw 'INVALID_ENVIRONMENT_VARIABLE_NAME' }
                $property = $data.variables.PSObject.Properties[$name]
                if ($null -eq $property) { throw ('VARIABLE_NOT_FOUND: ' + $name) }
                $values[$name] = [string]$property.Value
            }
        }
        finally {
            $data = $null
        }

        $session = Get-EpVaultSession
        $timeout = [Math]::Min(
            [int]($session.remainingSeconds * 1000),
            [int]($script:Session.durationSeconds * 1000)
        )
        if ($timeout -lt 1000) { throw 'VAULT_SESSION_TOO_CLOSE_TO_EXPIRY' }

        Ensure-EpManagedJobType
        $exitCode = [EPVault.ManagedJobRunner]::Run(
            $ExecutablePath,
            [string[]]$ArgumentList,
            [System.Collections.IDictionary]$values,
            $timeout
        )
        return [pscustomobject]@{
            status = 'CHILD_PROCESS_COMPLETED'
            exitCode = $exitCode
            injectedVariableCount = $values.Count
            childProcessTreeManaged = $true
        }
    }
    finally {
        foreach ($keyName in @($values.Keys)) { $values[$keyName] = $null }
        $values.Clear()
        $values = $null
    }
}

function Invoke-EpVaultSelfTest {
    $master = ConvertTo-SecureString 'synthetic-ep-vault-selftest-only' -AsPlainText -Force
    $wrong = ConvertTo-SecureString 'synthetic-wrong-password' -AsPlainText -Force
    $salt = New-EpRandomBytes -Count 16
    $key = $null
    $wrongKey = $null
    $tampered = $null
    $payload = $null
    try {
        $key = Get-EpMasterKey -Master $master -Salt $salt
        $sample = [ordered]@{ EP_VAULT_SYNTHETIC = 'synthetic-value-only' }
        $envelope = New-EpVaultEnvelope -Variables $sample -Key $key -Salt $salt
        $payload = Open-EpVaultEnvelope -Envelope $envelope -Key $key
        if ([string]$payload.variables.EP_VAULT_SYNTHETIC -cne 'synthetic-value-only') {
            throw 'SELFTEST_ROUNDTRIP_FAILED'
        }

        $wrongKey = Get-EpMasterKey -Master $wrong -Salt $salt
        $rejected = $false
        try { $null = Open-EpVaultEnvelope -Envelope $envelope -Key $wrongKey }
        catch { $rejected = $true }
        if (-not $rejected) { throw 'SELFTEST_WRONG_PASSWORD_NOT_REJECTED' }

        $tampered = $envelope | ConvertTo-Json -Depth 6 | ConvertFrom-Json
        $old = [string]$tampered.ciphertext
        $tampered.ciphertext = $old.Substring(0, $old.Length - 4) + 'AAAA'
        $rejected = $false
        try { $null = Open-EpVaultEnvelope -Envelope $tampered -Key $key }
        catch { $rejected = $true }
        if (-not $rejected) { throw 'SELFTEST_TAMPER_NOT_REJECTED' }

        return 'SELFTEST_PASS: PBKDF2-SHA256, AES-256-CBC, HMAC-SHA256, round-trip, wrong-password and tamper rejection.'
    }
    finally {
        $master.Dispose()
        $wrong.Dispose()
        Clear-EpBytes -Bytes $salt
        Clear-EpBytes -Bytes $key
        Clear-EpBytes -Bytes $wrongKey
        $payload = $null
        $tampered = $null
    }
}

function Invoke-EpVaultJobSelfTest {
    Ensure-EpManagedJobType
    $environment = @{ EP_VAULT_SYNTHETIC_JOB_TEST = 'synthetic-only' }
    $exitCode = [EPVault.ManagedJobRunner]::Run(
        $env:ComSpec,
        [string[]]@('/c','exit','0'),
        [System.Collections.IDictionary]$environment,
        10000
    )
    if ($exitCode -ne 0) { throw 'JOB_RUNNER_SELFTEST_FAILED' }
    return 'JOB_RUNNER_SELFTEST_PASS: suspended start, job assignment, bounded process and exit-code readback.'
}

Export-ModuleMember -Function @(
    'Get-EpVaultStatus',
    'Initialize-EpVault',
    'Unlock-EpVault',
    'Lock-EpVault',
    'Get-EpVaultSession',
    'Get-EpVaultVariableNames',
    'Get-EpVaultVariableValue',
    'Set-EpVaultVariable',
    'Set-EpVaultVariableFromClipboard',
    'Remove-EpVaultVariable',
    'New-EpVaultNoteFromClipboard',
    'Get-EpVaultNotes',
    'Get-EpVaultNote',
    'Promote-EpVaultNote',
    'Remove-EpVaultNote',
    'Invoke-EpVaultCommand',
    'Invoke-EpVaultSelfTest',
    'Invoke-EpVaultJobSelfTest'
)
