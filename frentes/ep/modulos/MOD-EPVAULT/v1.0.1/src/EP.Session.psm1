Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function Get-EpSessionRoot {
    if ([string]::IsNullOrWhiteSpace($env:LOCALAPPDATA)) { throw 'EP_SESSION_LOCALAPPDATA_MISSING' }
    return (Join-Path $env:LOCALAPPDATA 'EP\Session')
}
function Ensure-EpSessionPrivateDirectory {
    param([Parameter(Mandatory=$true)][string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $userSid = $identity.User
        $systemSid = [Security.Principal.SecurityIdentifier]::new('S-1-5-18')
        $acl = [Security.AccessControl.DirectorySecurity]::new()
        $acl.SetAccessRuleProtection($true,$false)
        $acl.SetOwner($userSid)
        $inheritance = [Security.AccessControl.InheritanceFlags]::ContainerInherit -bor [Security.AccessControl.InheritanceFlags]::ObjectInherit
        foreach ($sid in @($userSid,$systemSid)) {
            $acl.AddAccessRule([Security.AccessControl.FileSystemAccessRule]::new($sid,[Security.AccessControl.FileSystemRights]::FullControl,$inheritance,[Security.AccessControl.PropagationFlags]::None,[Security.AccessControl.AccessControlType]::Allow))
        }
        [IO.Directory]::CreateDirectory($Path,$acl) | Out-Null
    }
    $attributes = [IO.File]::GetAttributes($Path)
    if (($attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) { throw 'EP_SESSION_REPARSE_POINT_BLOCKED' }
    $currentAcl = Get-Acl -LiteralPath $Path
    if (-not $currentAcl.AreAccessRulesProtected) { throw 'EP_SESSION_ACL_NOT_PRIVATE' }
}
function Get-EpSessionMetadataPath { return (Join-Path (Get-EpSessionRoot) 'active-session.json') }
function Read-EpSessionMetadata {
    $path = Get-EpSessionMetadataPath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw 'EP_SESSION_NOT_FOUND' }
    $item = Get-Item -LiteralPath $path -ErrorAction Stop
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0 -or $item.Length -gt 32768) { throw 'EP_SESSION_METADATA_INVALID' }
    $data = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
    if ($data.schema -cne 'ep-session/1' -or [string]::IsNullOrWhiteSpace([string]$data.sessionId)) { throw 'EP_SESSION_METADATA_SCHEMA_INVALID' }
    return $data
}
function Write-EpSessionMetadata {
    param([Parameter(Mandatory=$true)]$Metadata)
    $root = Get-EpSessionRoot
    Ensure-EpSessionPrivateDirectory -Path $root
    $path = Get-EpSessionMetadataPath
    $tmp = $path + '.tmp'
    $json = ConvertTo-Json -InputObject $Metadata -Depth 6
    [IO.File]::WriteAllText($tmp,$json,[Text.UTF8Encoding]::new($false))
    Move-Item -LiteralPath $tmp -Destination $path -Force
}
function Get-EpSessionFreeLetter {
    $used = @(Get-PSDrive -PSProvider FileSystem | ForEach-Object { ([string]$_.Name).ToUpperInvariant() })
    foreach ($letter in @('R','S','T','U','V','W','X','Y','Z','P','Q','O','N','M','L','K','J','I','H','G','F','E')) {
        if ($used -notcontains $letter) { return $letter }
    }
    throw 'EP_SESSION_NO_FREE_DRIVE_LETTER'
}
function Invoke-EpSessionDiskPart {
    param([Parameter(Mandatory=$true)][string[]]$Lines)
    $scriptPath = Join-Path ([IO.Path]::GetTempPath()) ('ep-diskpart-' + [Guid]::NewGuid().ToString('N') + '.txt')
    try {
        [IO.File]::WriteAllLines($scriptPath,$Lines,[Text.Encoding]::ASCII)
        & "$env:SystemRoot\System32\diskpart.exe" /s $scriptPath *> $null
        $exit = $LASTEXITCODE
        if ($exit -ne 0) { throw ('EP_DISKPART_FAILED_' + $exit) }
    }
    finally {
        Remove-Item -LiteralPath $scriptPath -Force -ErrorAction SilentlyContinue
    }
}
function Get-EpSessionSecretNames {
    param([string]$SessionId)
    return [pscustomobject]@{
        Password = ('EP_SESSION_' + $SessionId.Substring(0,12).ToUpperInvariant() + '_BITLOCKER_PASSWORD')
        Recovery = ('EP_SESSION_' + $SessionId.Substring(0,12).ToUpperInvariant() + '_BITLOCKER_RECOVERY')
    }
}
function Protect-EpSessionRuntime {
    param([Parameter(Mandatory=$true)]$Metadata,[Parameter(Mandatory=$true)][string]$Password,[string]$B2IdName,[string]$B2KeyName,[string]$Bucket,[string]$Prefix)
    $runtime = [ordered]@{
        schema = 'ep-session-runtime/1'
        sessionId = [string]$Metadata.sessionId
        bitlockerPassword = $Password
        b2IdName = $B2IdName
        b2KeyName = $B2KeyName
        bucket = $Bucket
        prefix = $Prefix
    }
    $plain = [Text.UTF8Encoding]::new($false).GetBytes((ConvertTo-Json $runtime -Compress))
    $entropy = [Text.Encoding]::UTF8.GetBytes('EP-SESSION-RUNTIME-V1|' + [string]$Metadata.sessionId)
    $protected = $null
    try {
        $protected = [Security.Cryptography.ProtectedData]::Protect($plain,$entropy,[Security.Cryptography.DataProtectionScope]::CurrentUser)
        [IO.File]::WriteAllBytes([string]$Metadata.runtimePath,$protected)
    }
    finally {
        if ($plain) { [Array]::Clear($plain,0,$plain.Length) }
        if ($entropy) { [Array]::Clear($entropy,0,$entropy.Length) }
        if ($protected) { [Array]::Clear($protected,0,$protected.Length) }
    }
}
function Read-EpSessionRuntime {
    param([Parameter(Mandatory=$true)]$Metadata)
    $bytes = [IO.File]::ReadAllBytes([string]$Metadata.runtimePath)
    $entropy = [Text.Encoding]::UTF8.GetBytes('EP-SESSION-RUNTIME-V1|' + [string]$Metadata.sessionId)
    $plain = $null
    try {
        $plain = [Security.Cryptography.ProtectedData]::Unprotect($bytes,$entropy,[Security.Cryptography.DataProtectionScope]::CurrentUser)
        $runtime = [Text.Encoding]::UTF8.GetString($plain) | ConvertFrom-Json
        if ($runtime.schema -cne 'ep-session-runtime/1' -or $runtime.sessionId -cne $Metadata.sessionId) { throw 'EP_SESSION_RUNTIME_INVALID' }
        return $runtime
    }
    finally {
        if ($bytes) { [Array]::Clear($bytes,0,$bytes.Length) }
        if ($entropy) { [Array]::Clear($entropy,0,$entropy.Length) }
        if ($plain) { [Array]::Clear($plain,0,$plain.Length) }
    }
}
function New-EpSessionPassword {
    $bytes = New-Object byte[] 32
    $rng = [Security.Cryptography.RandomNumberGenerator]::Create()
    try { $rng.GetBytes($bytes); return [Convert]::ToBase64String($bytes).TrimEnd('=').Replace('+','-').Replace('/','_') }
    finally { $rng.Dispose(); [Array]::Clear($bytes,0,$bytes.Length) }
}
function Add-EpSessionDesktopLink {
    param([Parameter(Mandatory=$true)][string]$WorkspaceRoot)
    $desktop = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)
    $link = Join-Path $desktop 'EP'
    if (Test-Path -LiteralPath $link) { throw 'EP_DESKTOP_LINK_ALREADY_EXISTS_REFUSING_REPLACE' }
    New-Item -ItemType Junction -Path $link -Target $WorkspaceRoot -ErrorAction Stop | Out-Null
    return $link
}
function Remove-EpSessionDesktopLink {
    param([Parameter(Mandatory=$true)]$Metadata)
    $link = [string]$Metadata.desktopLink
    if (-not (Test-Path -LiteralPath $link)) { return }
    $item = Get-Item -LiteralPath $link -Force
    if ([string]$item.LinkType -ne 'Junction') { throw 'EP_DESKTOP_LINK_NOT_JUNCTION_REFUSING_REMOVE' }
    $target = [IO.Path]::GetFullPath([string]$item.Target)
    $expected = [IO.Path]::GetFullPath([string]$Metadata.workspaceRoot)
    if ($target.TrimEnd('\') -ine $expected.TrimEnd('\')) { throw 'EP_DESKTOP_LINK_TARGET_MISMATCH' }
    & "$env:SystemRoot\System32\cmd.exe" /c rmdir "$link" *> $null
    if (Test-Path -LiteralPath $link) { throw 'EP_DESKTOP_LINK_REMOVE_FAILED' }
}
function New-EpSessionContainer {
    [CmdletBinding()]
    param([ValidateRange(5,30)][int]$SizeGiB = 30,[switch]$ImportCurrentWorkspace)
    $null = Get-EpVaultSession
    $vaultNames = @(Get-EpVaultVariableNames)
    $idName = 'EP_B2_MASTER_APPLICATION_KEY_ID'
    $keyName = 'EP_B2_MASTER_APPLICATION_KEY'
    foreach ($name in @($idName,$keyName,'EP_B2_BUCKET_NAME','EP_B2_PREFIX')) { if ($vaultNames -notcontains $name) { throw ('EP_SESSION_B2_REQUIRED_VAULT_VARIABLE_MISSING_' + $name) } }
    $bucket = Get-EpVaultVariableValue -Name 'EP_B2_BUCKET_NAME' -Reveal
    $prefix = Get-EpVaultVariableValue -Name 'EP_B2_PREFIX' -Reveal
    $b2IdCheck = Get-EpVaultVariableValue -Name $idName -Reveal
    $b2KeyCheck = Get-EpVaultVariableValue -Name $keyName -Reveal
    if ($bucket -cne 'OCP-MCP' -or $prefix -cne 'ep-ocp/' -or [string]::IsNullOrWhiteSpace($b2IdCheck) -or [string]::IsNullOrWhiteSpace($b2KeyCheck)) { throw 'EP_SESSION_B2_PREFLIGHT_NOT_READY' }
    $required = @('diskpart.exe','Enable-BitLocker','Get-BitLockerVolume','Unlock-BitLocker','Lock-BitLocker','Add-BitLockerKeyProtector')
    foreach ($name in $required) { if (-not (Get-Command $name -ErrorAction SilentlyContinue)) { throw ('EP_SESSION_REQUIRED_COMMAND_MISSING_' + $name) } }
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    if (-not ([Security.Principal.WindowsPrincipal]$identity).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { throw 'EP_SESSION_ADMIN_REQUIRED' }
    $root = Get-EpSessionRoot
    Ensure-EpSessionPrivateDirectory -Path $root
    if (Test-Path -LiteralPath (Get-EpSessionMetadataPath)) { throw 'EP_SESSION_ALREADY_EXISTS_USE_RESTORE' }
    $sid = [Guid]::NewGuid().ToString('N')
    $secretNames = Get-EpSessionSecretNames -SessionId $sid
    $vhdDir = Join-Path $root $sid
    Ensure-EpSessionPrivateDirectory -Path $vhdDir
    $vhd = Join-Path $vhdDir 'workspace.vhdx'
    $drive = Get-EpSessionFreeLetter
    $mount = $drive + ':'
    $metadata = [pscustomobject][ordered]@{
        schema = 'ep-session/1'
        sessionId = $sid
        createdAtUtc = [DateTime]::UtcNow.ToString('o')
        maxAgeHours = 8
        idleMinutes = 10
        leaseMinutes = 30
        heartbeatSeconds = 60
        sizeGiB = $SizeGiB
        vhdPath = $vhd
        mountPoint = $mount
        workspaceRoot = (Join-Path $mount 'workspace')
        desktopLink = ''
        runtimePath = (Join-Path $vhdDir 'runtime.dpapi')
        state = 'CREATING'
        keyNames = $secretNames
        checkpoint = 'NOT_STARTED'
    }
    $password = New-EpSessionPassword
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    $keyStored = $false
    $attached = $false
    try {
        $lines = @(
            ('create vdisk file="' + $vhd + '" maximum=' + ($SizeGiB * 1024) + ' type=expandable'),
            ('select vdisk file="' + $vhd + '"'),
            'attach vdisk',
            'convert gpt',
            'create partition primary',
            'format fs=ntfs quick label=EPSESSION',
            ('assign letter=' + $drive)
        )
        Invoke-EpSessionDiskPart -Lines $lines
        $attached = $true
        Enable-BitLocker -MountPoint $mount -EncryptionMethod XtsAes256 -UsedSpaceOnly -PasswordProtector -Password $securePassword -SkipHardwareTest -ErrorAction Stop | Out-Null
        $deadline = [DateTime]::UtcNow.AddMinutes(20)
        do {
            $volume = Get-BitLockerVolume -MountPoint $mount -ErrorAction Stop
            if ([int]$volume.EncryptionPercentage -eq 100 -and [string]$volume.ProtectionStatus -eq 'On') { break }
            Start-Sleep -Seconds 2
        } while ([DateTime]::UtcNow -lt $deadline)
        if ([int]$volume.EncryptionPercentage -ne 100 -or [string]$volume.ProtectionStatus -ne 'On' -or [string]$volume.EncryptionMethod -ne 'XtsAes256') { throw 'EP_SESSION_BITLOCKER_NOT_FULLY_PROTECTED' }
        Add-BitLockerKeyProtector -MountPoint $mount -RecoveryPasswordProtector -ErrorAction Stop | Out-Null
        $volume = Get-BitLockerVolume -MountPoint $mount -ErrorAction Stop
        $recovery = [string](($volume.KeyProtector | Where-Object { [string]$_.KeyProtectorType -eq 'RecoveryPassword' } | Select-Object -First 1).RecoveryPassword)
        if ($recovery -notmatch '^[0-9]{6}(-[0-9]{6}){7}$') { throw 'EP_SESSION_RECOVERY_PROTECTOR_READBACK_FAILED' }
        $existing = @(Get-EpVaultVariableNames)
        if ($existing -contains $secretNames.Password -or $existing -contains $secretNames.Recovery) { throw 'EP_SESSION_SECRET_NAME_COLLISION' }
        $null = Set-EpVaultVariable -Name $secretNames.Password -Value $password
        $keyStored = $true
        $null = Set-EpVaultVariable -Name $secretNames.Recovery -Value $recovery
        $checkPassword = Get-EpVaultVariableValue -Name $secretNames.Password -Reveal
        $checkRecovery = Get-EpVaultVariableValue -Name $secretNames.Recovery -Reveal
        if ($checkPassword -cne $password -or $checkRecovery -cne $recovery) { throw 'EP_SESSION_VAULT_READBACK_FAILED' }
        $workspace = Join-Path $mount 'workspace'
        New-Item -ItemType Directory -Path $workspace -Force | Out-Null
        if ($ImportCurrentWorkspace) {
            $source = Join-Path ([Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)) 'SeryMente'
            if (Test-Path -LiteralPath $source -PathType Container) {
                $destination = Join-Path $workspace 'SeryMente'
                New-Item -ItemType Directory -Path $destination -Force | Out-Null
                & "$env:SystemRoot\System32\robocopy.exe" $source $destination /E /COPY:DAT /DCOPY:DAT /R:1 /W:1 /XJ /NFL /NDL /NJH /NJS *> $null
                $copyExit = $LASTEXITCODE
                if ($copyExit -ge 8) { throw ('EP_SESSION_WORKSPACE_COPY_FAILED_' + $copyExit) }
            }
        }
        $metadata.desktopLink = Add-EpSessionDesktopLink -WorkspaceRoot $workspace
        $metadata.state = 'ACTIVE'
        Protect-EpSessionRuntime -Metadata $metadata -Password $password -B2IdName $idName -B2KeyName $keyName -Bucket $bucket -Prefix $prefix
        Write-EpSessionMetadata -Metadata $metadata
        return [pscustomobject]@{status='EP_SESSION_CREATED';sessionId=$sid;mountPoint=$mount;workspaceRoot=$workspace;bitlocker='XTS-AES256/100%/ON';desktopLink=$metadata.desktopLink;imported=[bool]$ImportCurrentWorkspace}
    }
    catch {
        try { if (Test-Path -LiteralPath $metadata.desktopLink) { Remove-EpSessionDesktopLink -Metadata $metadata } } catch {}
        try { if ($attached) { Lock-BitLocker -MountPoint $mount -ForceDismount -ErrorAction SilentlyContinue | Out-Null; Invoke-EpSessionDiskPart -Lines @('select vdisk file="' + $vhd + '"','detach vdisk noerr') } } catch {}
        try { if ($keyStored) { Remove-EpVaultVariable -Name $secretNames.Password -Approved -ErrorAction SilentlyContinue | Out-Null; Remove-EpVaultVariable -Name $secretNames.Recovery -Approved -ErrorAction SilentlyContinue | Out-Null } } catch {}
        Remove-Item -LiteralPath $vhdDir -Recurse -Force -ErrorAction SilentlyContinue
        throw
    }
    finally {
        $securePassword.Dispose()
        $password = $null
        $recovery = $null
        $checkPassword = $null
        $checkRecovery = $null
    }
}
function Mount-EpSessionContainer {
    $null = Get-EpVaultSession
    $metadata = Read-EpSessionMetadata
    if (-not (Test-Path -LiteralPath $metadata.vhdPath -PathType Leaf)) { throw 'EP_SESSION_VHDX_MISSING' }
    $letter = Get-EpSessionFreeLetter
    $mount = $letter + ':'
    $password = Get-EpVaultVariableValue -Name ([string]$metadata.keyNames.Password) -Reveal
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    try {
        Invoke-EpSessionDiskPart -Lines @('select vdisk file="' + $metadata.vhdPath + '"','attach vdisk','select partition 1','assign letter=' + $letter)
        Unlock-BitLocker -MountPoint $mount -Password $securePassword -ErrorAction Stop | Out-Null
        $volume = Get-BitLockerVolume -MountPoint $mount -ErrorAction Stop
        if ([string]$volume.EncryptionMethod -ne 'XtsAes256' -or [int]$volume.EncryptionPercentage -ne 100 -or [string]$volume.ProtectionStatus -ne 'On') { throw 'EP_SESSION_RESTORE_BITLOCKER_CHECK_FAILED' }
        $metadata.mountPoint = $mount
        $metadata.workspaceRoot = Join-Path $mount 'workspace'
        if (-not (Test-Path -LiteralPath $metadata.workspaceRoot)) { throw 'EP_SESSION_WORKSPACE_MISSING' }
        if (-not (Test-Path -LiteralPath $metadata.desktopLink)) {
            $desktop = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)
            $metadata.desktopLink = Add-EpSessionDesktopLink -WorkspaceRoot $metadata.workspaceRoot
        }
        $metadata.state = 'ACTIVE'
        Write-EpSessionMetadata -Metadata $metadata
        return [pscustomobject]@{status='EP_SESSION_MOUNTED';sessionId=$metadata.sessionId;mountPoint=$mount;workspaceRoot=$metadata.workspaceRoot}
    }
    finally { $securePassword.Dispose(); $password = $null }
}
function Lock-EpSessionContainer {
    $metadata = Read-EpSessionMetadata
    Remove-EpSessionDesktopLink -Metadata $metadata
    $mount = [string]$metadata.mountPoint
    try { Lock-BitLocker -MountPoint $mount -ForceDismount -ErrorAction Stop | Out-Null } catch {}
    Invoke-EpSessionDiskPart -Lines @('select vdisk file="' + $metadata.vhdPath + '"','detach vdisk')
    $metadata.state = 'SEALED_LOCAL'
    $metadata.mountPoint = ''
    Write-EpSessionMetadata -Metadata $metadata
    return [pscustomobject]@{status='EP_SESSION_SEALED_LOCAL';sessionId=$metadata.sessionId;vhdxPresent=$true}
}
function Invoke-EpSessionB2Checkpoint {
    param([Parameter(Mandatory=$true)]$Metadata)
    $runtime = Read-EpSessionRuntime -Metadata $Metadata
    if ([string]::IsNullOrWhiteSpace([string]$runtime.bucket) -or [string]$runtime.bucket -cne 'OCP-MCP' -or [string]$runtime.prefix -cne 'ep-ocp/') { throw 'EP_SESSION_B2_DESTINATION_NOT_CANONICAL' }
    if ([string]::IsNullOrWhiteSpace([string]$runtime.b2IdName) -or [string]::IsNullOrWhiteSpace([string]$runtime.b2KeyName)) { throw 'EP_SESSION_B2_CREDENTIALS_NOT_CACHED' }
    $b2Path = Join-Path ([Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)) 'SeryMente\EP\local-state\tools\b2-windows.exe'
    if (-not (Test-Path -LiteralPath $b2Path -PathType Leaf)) { throw 'EP_SESSION_B2_CLI_MISSING' }
    $stateDir = Join-Path (Get-EpSessionRoot) 'b2-state'
    Ensure-EpSessionPrivateDirectory -Path $stateDir
    $accountInfo = Join-Path $stateDir 'b2-ep-ocp.sqlite'
    $wrapper = Join-Path $stateDir 'b2-session-checkpoint.ps1'
    $verifyPath = Join-Path $stateDir 'restore-verify.vhdx'
    $receiptPath = Join-Path $stateDir 'checkpoint-receipt.json'
    $objectName = 'ep-ocp/workspace-sessions/' + [string]$Metadata.sessionId + '/session.vhdx'
    $script = @'
param([string]$B2Path,[string]$Bucket,[string]$Source,[string]$ObjectName,[string]$VerifyPath,[string]$ReceiptPath,[string]$AccountInfo)
$ErrorActionPreference = "Stop"
$env:B2_APPLICATION_KEY_ID = $env:EP_B2_KEY_ID
$env:B2_APPLICATION_KEY = $env:EP_B2_KEY
$env:B2_ACCOUNT_INFO = $AccountInfo
function Invoke-B2([string[]]$Arguments) {
    & $B2Path @Arguments *> $null
    if ($LASTEXITCODE -ne 0) { throw ("B2_COMMAND_FAILED_" + $LASTEXITCODE) }
}
try {
    Invoke-B2 @("account","authorize")
    Invoke-B2 @("file","upload","--no-progress","--sha1",$Bucket,$Source,$ObjectName)
    Invoke-B2 @("file","download","--no-progress",("b2://" + $Bucket + "/" + $ObjectName),$VerifyPath)
    $sourceHash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash
    $verifyHash = (Get-FileHash -LiteralPath $VerifyPath -Algorithm SHA256).Hash
    $sourceBytes = (Get-Item -LiteralPath $Source).Length
    $verifyBytes = (Get-Item -LiteralPath $VerifyPath).Length
    if ($sourceHash -ne $verifyHash -or $sourceBytes -ne $verifyBytes) { throw "B2_READBACK_MISMATCH" }
    [ordered]@{status="UPLOAD_AND_READBACK_PASS";bucket=$Bucket;object=$ObjectName;bytes=$sourceBytes;sha256=$sourceHash;readbackSha256=$verifyHash;utc=[DateTime]::UtcNow.ToString("o")} | ConvertTo-Json -Compress | Set-Content -LiteralPath $ReceiptPath -Encoding UTF8
    exit 0
}
catch {
    [ordered]@{status="FAILED";error=$_.Exception.Message;utc=[DateTime]::UtcNow.ToString("o")} | ConvertTo-Json -Compress | Set-Content -LiteralPath $ReceiptPath -Encoding UTF8
    exit 2
}
finally {
    Remove-Item -LiteralPath $VerifyPath -Force -ErrorAction SilentlyContinue
    $env:B2_APPLICATION_KEY_ID = $null
    $env:B2_APPLICATION_KEY = $null
}
'@
    [IO.File]::WriteAllText($wrapper,$script,[Text.UTF8Encoding]::new($false))
    $result = Invoke-EpVaultCommand -ExecutablePath (Join-Path $PSHOME 'powershell.exe') -ArgumentList @('-NoProfile','-NonInteractive','-ExecutionPolicy','Bypass','-File',$wrapper,'-B2Path',$b2Path,'-Bucket',[string]$runtime.bucket,'-Source',[string]$Metadata.vhdPath,'-ObjectName',$objectName,'-VerifyPath',$verifyPath,'-ReceiptPath',$receiptPath,'-AccountInfo',$accountInfo) -Names @([string]$runtime.b2IdName,[string]$runtime.b2KeyName)
    if ([int]$result.exitCode -ne 0) { throw 'EP_SESSION_B2_UPLOAD_OR_READBACK_FAILED' }
    if (-not (Test-Path -LiteralPath $receiptPath)) { throw 'EP_SESSION_B2_RECEIPT_MISSING' }
    $receipt = Get-Content -LiteralPath $receiptPath -Raw | ConvertFrom-Json
    if ($receipt.status -cne 'UPLOAD_AND_READBACK_PASS') { throw 'EP_SESSION_B2_RECEIPT_NOT_PASS' }
    return $receipt
}
function Save-CloseEpSessionContainer {
    $metadata = Read-EpSessionMetadata
    if ([string]$metadata.state -eq 'ACTIVE') { $null = Lock-EpSessionContainer; $metadata = Read-EpSessionMetadata }
    $receipt = Invoke-EpSessionB2Checkpoint -Metadata $metadata
    Remove-Item -LiteralPath $metadata.vhdPath -Force -ErrorAction Stop
    Remove-EpVaultVariable -Name ([string]$metadata.keyNames.Password) -Approved | Out-Null
    Remove-EpVaultVariable -Name ([string]$metadata.keyNames.Recovery) -Approved | Out-Null
    Remove-Item -LiteralPath $metadata.runtimePath -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath (Split-Path -Parent $metadata.vhdPath) -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath (Get-EpSessionMetadataPath) -Force -ErrorAction SilentlyContinue
    return [pscustomobject]@{status='EP_SESSION_SAVED_AND_CRYPTO_ERASED';bucket=$receipt.bucket;object=$receipt.object;bytes=$receipt.bytes;sha256=$receipt.sha256}
}
function Invoke-EpSessionCryptoErase {
    param([string]$Reason='deadman')
    $metadata = Read-EpSessionMetadata
    try { if ([string]$metadata.state -eq 'ACTIVE') { $null = Lock-EpSessionContainer; $metadata = Read-EpSessionMetadata } } catch {}
    Remove-Item -LiteralPath ([string]$metadata.vhdPath) -Force -ErrorAction SilentlyContinue
    if ((Get-EpVaultStatus).sessionActive) {
        Remove-EpVaultVariable -Name ([string]$metadata.keyNames.Password) -Approved -ErrorAction SilentlyContinue | Out-Null
        Remove-EpVaultVariable -Name ([string]$metadata.keyNames.Recovery) -Approved -ErrorAction SilentlyContinue | Out-Null
    }
    Remove-Item -LiteralPath ([string]$metadata.runtimePath) -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath (Split-Path -Parent ([string]$metadata.vhdPath)) -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath (Get-EpSessionMetadataPath) -Force -ErrorAction SilentlyContinue
    return [pscustomobject]@{status='EP_SESSION_CRYPTO_ERASE_REQUESTED';reason=$Reason;localVhdxRemoved=$true}
}
function Start-EpSessionGuardian {
    $metadata = Read-EpSessionMetadata
    $scriptPath = Join-Path $PSScriptRoot 'EP.Session.Guardian.ps1'
    if (-not (Test-Path -LiteralPath $scriptPath)) { throw 'EP_SESSION_GUARDIAN_SCRIPT_MISSING' }
    $args = @('-NoProfile','-NonInteractive','-ExecutionPolicy','Bypass','-WindowStyle','Hidden','-File',$scriptPath,'-ManifestPath',(Get-EpSessionMetadataPath))
    return (Start-Process -FilePath (Join-Path $PSHOME 'powershell.exe') -ArgumentList $args -WindowStyle Hidden -PassThru)
}
Export-ModuleMember -Function @('New-EpSessionContainer','Mount-EpSessionContainer','Lock-EpSessionContainer','Save-CloseEpSessionContainer','Invoke-EpSessionCryptoErase','Start-EpSessionGuardian','Read-EpSessionMetadata','Get-EpSessionRoot')
