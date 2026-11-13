[CmdletBinding()]
param(
    [ValidateRange(1024,65535)]
    [int]$BrainPort = 8765,
    [ValidateRange(1024,65535)]
    [int]$PortalPort = 8766
)

$ErrorActionPreference = 'Stop'
$expectedIdentity = 'CENTRAL\fila4'
$identity = [Security.Principal.WindowsIdentity]::GetCurrent().Name
if ($identity -ne $expectedIdentity) {
    throw "WRONG_WINDOWS_IDENTITY:$identity"
}

$moduleRoot = Split-Path -Parent $PSScriptRoot
$modulesRoot = Split-Path -Parent $moduleRoot
$bmadAssets = Join-Path $modulesRoot 'MOD-EP-BMAD\app\node_modules\bmad-method\src\core-skills\bmad-brainstorming\assets'
$brainHtml = Join-Path $bmadAssets 'brain-selector.html'
$appRoot = Join-Path $moduleRoot 'app'
$appHtml = Join-Path $appRoot 'index.html'
$chromeModule = Join-Path $modulesRoot 'MOD-EP-CHROME'
$chromeLauncher = Join-Path $chromeModule 'launchers\Start-Chrome-EP.ps1'
$chromeExe = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
$profile = Join-Path $chromeModule 'data\Fila4\user-data'
$logs = Join-Path $moduleRoot 'logs\Fila4'
$brainOut = Join-Path $logs 'brain-selector-http.out.log'
$brainErr = Join-Path $logs 'brain-selector-http.err.log'
$portalOut = Join-Path $logs 'product-design-portal-http.out.log'
$portalErr = Join-Path $logs 'product-design-portal-http.err.log'
$logPath = Join-Path $logs 'brain-selector-launch.json'
$brainUrl = "http://127.0.0.1:$BrainPort/brain-selector.html"
$portalUrl = "http://127.0.0.1:$PortalPort/"

New-Item -ItemType Directory -Force -Path $logs | Out-Null
foreach ($required in @($brainHtml, $appHtml, $chromeLauncher, $chromeExe)) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) {
        throw "REQUIRED_FILE_NOT_FOUND:$required"
    }
}

$pythonLauncher = 'C:\Windows\py.exe'
if (-not (Test-Path -LiteralPath $pythonLauncher -PathType Leaf)) {
    throw "PYTHON_LAUNCHER_NOT_FOUND:$pythonLauncher"
}

$brainListener = Get-NetTCPConnection -LocalAddress '127.0.0.1' -LocalPort $BrainPort -State Listen -ErrorAction SilentlyContinue |
    Select-Object -First 1
$portalListener = Get-NetTCPConnection -LocalAddress '127.0.0.1' -LocalPort $PortalPort -State Listen -ErrorAction SilentlyContinue |
    Select-Object -First 1
$brainServer = $null
$portalServer = $null

if (-not $brainListener) {
    $brainServer = Start-Process -FilePath $pythonLauncher -ArgumentList @(
        '-3', '-m', 'http.server', "$BrainPort", '--bind', '127.0.0.1', '--directory', $bmadAssets
    ) -WorkingDirectory $bmadAssets -WindowStyle Hidden -RedirectStandardOutput $brainOut -RedirectStandardError $brainErr -PassThru
}
if (-not $portalListener) {
    $portalServer = Start-Process -FilePath $pythonLauncher -ArgumentList @(
        '-3', '-m', 'http.server', "$PortalPort", '--bind', '127.0.0.1', '--directory', $appRoot
    ) -WorkingDirectory $appRoot -WindowStyle Hidden -RedirectStandardOutput $portalOut -RedirectStandardError $portalErr -PassThru
}

try {
    $brainResponse = Invoke-WebRequest -UseBasicParsing -Uri $brainUrl -Method Head -TimeoutSec 5
    $portalResponse = Invoke-WebRequest -UseBasicParsing -Uri $portalUrl -Method Head -TimeoutSec 5
} catch {
    throw "PRODUCT_DESIGN_HTTP_UNAVAILABLE:$($_.Exception.Message)"
}
if ([int]$brainResponse.StatusCode -ne 200 -or $brainResponse.Headers['Content-Type'] -notmatch 'text/html') {
    throw "BRAIN_SELECTOR_HTTP_INVALID:$($brainResponse.StatusCode):$($brainResponse.Headers['Content-Type'])"
}
if ([int]$portalResponse.StatusCode -ne 200 -or $portalResponse.Headers['Content-Type'] -notmatch 'text/html') {
    throw "PRODUCT_DESIGN_PORTAL_HTTP_INVALID:$($portalResponse.StatusCode):$($portalResponse.Headers['Content-Type'])"
}

$chromeProcess = Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" |
    Where-Object { $_.CommandLine -and $_.CommandLine.Contains("--user-data-dir=$profile") } |
    Select-Object -First 1
if (-not $chromeProcess) {
    & $chromeLauncher | Out-Null
}
Start-Process -FilePath $chromeExe -ArgumentList @(
    "--user-data-dir=$profile", '--profile-directory=Default', '--new-tab', $portalUrl
) | Out-Null

$record = [ordered]@{
    identity = $identity
    portal_url = $portalUrl
    portal_http_status = [int]$portalResponse.StatusCode
    portal_content_type = [string]$portalResponse.Headers['Content-Type']
    portal_server_started = [bool]$portalServer
    portal_server_pid = if ($portalServer) { $portalServer.Id } else { $portalListener.OwningProcess }
    brain_selector_url = $brainUrl
    brain_selector_http_status = [int]$brainResponse.StatusCode
    brain_selector_content_type = [string]$brainResponse.Headers['Content-Type']
    brain_selector_content_length = [string]$brainResponse.Headers['Content-Length']
    brain_server_started = [bool]$brainServer
    brain_server_pid = if ($brainServer) { $brainServer.Id } else { $brainListener.OwningProcess }
    chrome_version = (Get-Item -LiteralPath $chromeExe).VersionInfo.ProductVersion
    chrome_profile = $profile
    brain_selector_source = $brainHtml
    portal_source = $appHtml
    opened_at = (Get-Date).ToString('o')
}
$record | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $logPath -Encoding UTF8
[pscustomobject]$record | ConvertTo-Json -Depth 5

[executed on device: PC10RCIF4EI4 (5182a6bc-db2c-452e-a52a-95d63f6c74d6)]