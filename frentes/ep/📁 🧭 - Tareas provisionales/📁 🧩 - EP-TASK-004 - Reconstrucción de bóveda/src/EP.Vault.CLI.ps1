[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet(
        'Status','Initialize','ListVariables','RevealVariable','SetFromClipboard',
        'RemoveVariable','CaptureNote','ListNotes','ReadNote','PromoteNote',
        'DeleteNote','Run','SelfTest','Lock'
    )]
    [string]$Action,

    [string]$Name = '',
    [string]$NoteId = '',
    [string[]]$Names = @(),
    [string]$ExecutablePath = '',
    [string[]]$ArgumentList = @(),

    [ValidateSet(15,30,60,120,180,300,600,900)]
    [int]$DurationSeconds = 300,

    [ValidateRange(1,240)]
    [int]$NoteTtlMinutes = 30,

    [switch]$Reveal,
    [switch]$Replace,
    [switch]$ApproveRemove,
    [switch]$ApproveDelete
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$corePath = Join-Path $PSScriptRoot 'EP.Vault.Core.psm1'
if (-not (Test-Path -LiteralPath $corePath -PathType Leaf)) {
    throw 'EP_VAULT_CORE_NOT_FOUND'
}
Import-Module -Name $corePath -Force -ErrorAction Stop

function Read-EpLocalMaster {
    return Read-Host 'EP Vault master password — enter locally; never send it to the model' -AsSecureString
}

function Test-EpSecureStringsEqual {
    param(
        [Parameter(Mandatory=$true)][Security.SecureString]$A,
        [Parameter(Mandatory=$true)][Security.SecureString]$B
    )
    $pointerA = [IntPtr]::Zero
    $pointerB = [IntPtr]::Zero
    try {
        if ($A.Length -ne $B.Length) { return $false }
        $pointerA = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($A)
        $pointerB = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($B)
        $difference = 0
        for ($i = 0; $i -lt $A.Length; $i++) {
            $charA = [Runtime.InteropServices.Marshal]::ReadInt16($pointerA, $i * 2)
            $charB = [Runtime.InteropServices.Marshal]::ReadInt16($pointerB, $i * 2)
            $difference = $difference -bor ($charA -bxor $charB)
        }
        return ($difference -eq 0)
    }
    finally {
        if ($pointerA -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointerA) }
        if ($pointerB -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointerB) }
    }
}

function Enter-EpLocalSession {
    param([int]$Seconds)
    $master = Read-EpLocalMaster
    try {
        return Unlock-EpVault -Master $master -DurationSeconds $Seconds
    }
    finally {
        if ($master) { $master.Dispose() }
    }
}

$exitCode = 0
try {
    switch ($Action) {
        'Status' {
            Get-EpVaultStatus | ConvertTo-Json -Depth 4
        }

        'Initialize' {
            if ((Get-EpVaultStatus).vaultExists) { throw 'VAULT_ALREADY_EXISTS_REFUSING_OVERWRITE' }
            $first = Read-EpLocalMaster
            $second = Read-Host 'Repeat the master password locally' -AsSecureString
            try {
                if (-not (Test-EpSecureStringsEqual -A $first -B $second)) {
                    throw 'MASTER_PASSWORD_CONFIRMATION_MISMATCH'
                }
                Initialize-EpVault -Master $first -DurationSeconds $DurationSeconds | ConvertTo-Json -Compress
            }
            finally {
                if ($first) { $first.Dispose() }
                if ($second) { $second.Dispose() }
            }
        }

        'ListVariables' {
            $null = Enter-EpLocalSession -Seconds $DurationSeconds
            try {
                $names = @(Get-EpVaultVariableNames)
                if ($names.Count -eq 0) { 'VAULT_EMPTY' }
                else { $names }
            }
            finally { $null = Lock-EpVault }
        }

        'RevealVariable' {
            if (-not $Reveal) { throw 'REVEAL_SWITCH_REQUIRED' }
            if ([string]::IsNullOrWhiteSpace($Name)) { throw 'VARIABLE_NAME_REQUIRED' }
            $null = Enter-EpLocalSession -Seconds $DurationSeconds
            try {
                $value = Get-EpVaultVariableValue -Name $Name -Reveal
                [Console]::Out.WriteLine($value)
            }
            finally {
                $value = $null
                $null = Lock-EpVault
            }
        }

        'SetFromClipboard' {
            if ([string]::IsNullOrWhiteSpace($Name)) { throw 'VARIABLE_NAME_REQUIRED' }
            $null = Enter-EpLocalSession -Seconds $DurationSeconds
            try {
                Set-EpVaultVariableFromClipboard -Name $Name -Replace:$Replace | ConvertTo-Json -Compress
            }
            finally { $null = Lock-EpVault }
        }

        'RemoveVariable' {
            if ([string]::IsNullOrWhiteSpace($Name)) { throw 'VARIABLE_NAME_REQUIRED' }
            if (-not $ApproveRemove) { throw 'APPROVE_REMOVE_SWITCH_REQUIRED' }
            $null = Enter-EpLocalSession -Seconds $DurationSeconds
            try {
                Remove-EpVaultVariable -Name $Name -Approved | ConvertTo-Json -Compress
            }
            finally { $null = Lock-EpVault }
        }

        'CaptureNote' {
            New-EpVaultNoteFromClipboard -TtlMinutes $NoteTtlMinutes | ConvertTo-Json -Compress
        }

        'ListNotes' {
            Get-EpVaultNotes | ConvertTo-Json -Depth 4
        }

        'ReadNote' {
            if (-not $Reveal) { throw 'REVEAL_SWITCH_REQUIRED' }
            if ([string]::IsNullOrWhiteSpace($NoteId)) { throw 'NOTE_ID_REQUIRED' }
            $note = Get-EpVaultNote -NoteId $NoteId -Reveal
            [Console]::Out.WriteLine($note.value)
            $note = $null
        }

        'PromoteNote' {
            if ([string]::IsNullOrWhiteSpace($NoteId) -or [string]::IsNullOrWhiteSpace($Name)) {
                throw 'NOTE_ID_AND_VARIABLE_NAME_REQUIRED'
            }
            $null = Enter-EpLocalSession -Seconds $DurationSeconds
            try {
                Promote-EpVaultNote -NoteId $NoteId -Name $Name -Replace:$Replace | ConvertTo-Json -Compress
            }
            finally { $null = Lock-EpVault }
        }

        'DeleteNote' {
            if ([string]::IsNullOrWhiteSpace($NoteId)) { throw 'NOTE_ID_REQUIRED' }
            if (-not $ApproveDelete) { throw 'APPROVE_DELETE_SWITCH_REQUIRED' }
            Remove-EpVaultNote -NoteId $NoteId -Approved
        }

        'Run' {
            if ([string]::IsNullOrWhiteSpace($ExecutablePath)) { throw 'EXECUTABLE_PATH_REQUIRED' }
            if ($Names.Count -eq 0) { throw 'EXPLICIT_NAMES_ALLOWLIST_REQUIRED' }
            $null = Enter-EpLocalSession -Seconds $DurationSeconds
            try {
                $result = Invoke-EpVaultCommand -ExecutablePath $ExecutablePath -ArgumentList $ArgumentList -Names $Names
                $result | ConvertTo-Json -Compress
                $exitCode = [int]$result.exitCode
            }
            finally { $null = Lock-EpVault }
        }

        'SelfTest' {
            Invoke-EpVaultSelfTest
            Invoke-EpVaultJobSelfTest
            Invoke-EpVaultJobTimeoutSelfTest
        }

        'Lock' {
            Lock-EpVault
        }
    }
}
catch {
    [Console]::Error.WriteLine('EP_VAULT_ERROR: ' + $_.Exception.Message)
    $exitCode = 1
}
finally {
    $value = $null
    $note = $null
    $result = $null
}

exit $exitCode
