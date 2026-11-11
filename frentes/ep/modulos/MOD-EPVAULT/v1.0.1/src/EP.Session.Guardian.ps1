[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$ManifestPath)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$corePath = Join-Path $PSScriptRoot 'EP.Vault.Core.psm1'
$sessionPath = Join-Path $PSScriptRoot 'EP.Session.psm1'
if (-not (Test-Path -LiteralPath $corePath) -or -not (Test-Path -LiteralPath $sessionPath)) { exit 20 }
Import-Module -Name $corePath -Force -DisableNameChecking -ErrorAction Stop
Import-Module -Name $sessionPath -Force -DisableNameChecking -ErrorAction Stop

if (-not ('EPSessionLastInput' -as [type])) {
    Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class EPSessionLastInput {
    [StructLayout(LayoutKind.Sequential)]
    public struct LASTINPUTINFO { public uint cbSize; public uint dwTime; }
    [DllImport("user32.dll")]
    private static extern bool GetLastInputInfo(ref LASTINPUTINFO info);
    public static uint IdleSeconds() {
        LASTINPUTINFO info = new LASTINPUTINFO();
        info.cbSize = (uint)Marshal.SizeOf(info);
        if (!GetLastInputInfo(ref info)) return 0;
        return ((uint)Environment.TickCount - info.dwTime) / 1000;
    }
}
'@ -Language CSharp -ErrorAction Stop
}

$expected = [IO.Path]::GetFullPath((Get-EpSessionMetadataPath))
if ([IO.Path]::GetFullPath($ManifestPath) -ine $expected) { exit 21 }

while ($true) {
    try {
        $metadata = Read-EpSessionMetadata
        $created = [DateTime]::Parse([string]$metadata.createdAtUtc).ToUniversalTime()
        $age = [DateTime]::UtcNow - $created
        $idleSeconds = [EPSessionLastInput]::IdleSeconds()
        $reason = $null
        if ($idleSeconds -ge ([int]$metadata.idleMinutes * 60)) { $reason = 'deadman-inactivity' }
        if ($age.TotalHours -ge [double]$metadata.maxAgeHours) { $reason = 'absolute-session-limit' }
        if ($null -ne $reason) {
            try {
                $null = Save-CloseEpSessionContainer
            }
            catch {
                try { $null = Invoke-EpSessionCryptoErase -Reason ($reason + '-checkpoint-failed') } catch {}
            }
            try { $null = Lock-EpVault } catch {}
            exit 0
        }
        Start-Sleep -Seconds 2
    }
    catch {
        Start-Sleep -Seconds 5
        if (-not (Test-Path -LiteralPath $ManifestPath)) { exit 0 }
    }
}
