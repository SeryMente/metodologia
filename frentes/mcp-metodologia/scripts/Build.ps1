$ErrorActionPreference = 'Continue'
Register-EngineEvent -SourceIdentifier PowerShell.OnError -Action {
    Write-Host ("[ENGINE ERROR] " + $Event.SourceEventArgs.Message) -ForegroundColor Red
} | Out-Null

try {
    $OcpRoot = Split-Path -Parent $PSScriptRoot
    $RepoRoot = (Resolve-Path (Join-Path $OcpRoot "..\..")).Path
    $Project = Join-Path $OcpRoot "src\OcpMcp\OcpMcp.csproj"
    $SourceManifest = Join-Path $OcpRoot "resources\initial-sources.manifest.json"
    & (Join-Path $PSScriptRoot "Prepare-Sources.ps1")
    if ($LASTEXITCODE -ne 0) { throw "Initial source manifest preparation failed." }
    if (-not (Test-Path -LiteralPath $SourceManifest)) { throw "Initial source manifest was not created." }

    $SdkRoot = $env:OCPMCP_DOTNET_ROOT
    if ([string]::IsNullOrWhiteSpace($SdkRoot)) {
        $Dotnet = (Get-Command dotnet -ErrorAction Stop).Source
    } else {
        $Dotnet = Join-Path $SdkRoot "dotnet.exe"
        if (-not (Test-Path -LiteralPath $Dotnet)) { throw "OCPMCP_DOTNET_ROOT does not contain dotnet.exe." }
    }
    $sdkVersion = (& $Dotnet --version).Trim()
    if ($LASTEXITCODE -ne 0) { throw "Unable to query .NET SDK." }
    if ([version]$sdkVersion -lt [version]"10.0.100") { throw ".NET SDK 10.0 or newer is required." }

    $publish = Join-Path $OcpRoot "artifacts\publish\0.1.0"
    $packages = Join-Path $OcpRoot "artifacts\packages"
    if (Test-Path $publish) { Remove-Item -LiteralPath $publish -Recurse -Force }
    New-Item -ItemType Directory -Force -Path $publish,$packages | Out-Null

    $commit = (& git -C $RepoRoot rev-parse HEAD).Trim()
    if ($LASTEXITCODE -ne 0) { throw "git rev-parse HEAD failed." }

    $env:DOTNET_CLI_TELEMETRY_OPTOUT = "1"
    $env:DOTNET_NOLOGO = "1"
    $publishArgs = @(
        "publish", $Project,
        "--configuration", "Release",
        "--runtime", "win-x64",
        "--self-contained", "true",
        "-p:PublishSingleFile=false",
        "-p:PublishAot=false",
        "-p:Version=0.1.0",
        "--output", $publish
    )
    & $Dotnet @publishArgs
    if ($LASTEXITCODE -ne 0) { throw "dotnet publish failed with exit code $LASTEXITCODE" }

    Copy-Item -LiteralPath $SourceManifest -Destination (Join-Path $publish "initial-sources.manifest.json") -Force
    $entrypoint = "OcpMcp.exe"
    if (-not (Test-Path -LiteralPath (Join-Path $publish $entrypoint))) { throw "Published executable not found: $entrypoint" }

    $componentHashes = @()
    Get-ChildItem -LiteralPath $publish -File -Recurse | Sort-Object FullName | ForEach-Object {
        $rel = $_.FullName.Substring($publish.Length).TrimStart('\')
        $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash.ToLowerInvariant()
        $componentHashes += [ordered]@{ path=$rel; size_bytes=$_.Length; sha256=$hash }
    }
    $sourceDoc = Get-Content -Raw -LiteralPath $SourceManifest | ConvertFrom-Json
    $manifest = [ordered]@{
        manifest_version = 1
        product = "OCP MCP"
        identity = "MCP-METODOLOGIA"
        version = "0.1.0"
        source_code_commit = $commit
        target_framework = "net10.0"
        runtime_identifier = "win-x64"
        sdk_version = $sdkVersion
        self_contained = $true
        publish_single_file = $false
        publish_aot = $false
        entrypoint = $entrypoint
        args = @("serve")
        transport = "stdio"
        source_manifest_sha256 = (Get-FileHash -Algorithm SHA256 -LiteralPath $SourceManifest).Hash.ToLowerInvariant()
        sources = $sourceDoc.sources
        components = $componentHashes
        created_at_utc = [DateTimeOffset]::UtcNow.ToString("O")
    }
    $manifestPath = Join-Path $publish "build-manifest.json"
    [System.IO.File]::WriteAllText($manifestPath, ($manifest | ConvertTo-Json -Depth 20) + [Environment]::NewLine, [System.Text.UTF8Encoding]::new($false))
    $manifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $manifestPath).Hash.ToLowerInvariant()

    $zip = Join-Path $packages "ocp-mcp-0.1.0-win-x64.zip"
    if (Test-Path $zip) { Remove-Item -LiteralPath $zip -Force }
    Compress-Archive -Path (Join-Path $publish "*") -DestinationPath $zip -CompressionLevel Optimal
    if (-not (Test-Path $zip)) { throw "Package ZIP was not created." }
    $zipHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $zip).Hash.ToLowerInvariant()

    $evidence = [ordered]@{
        product = "OCP MCP"
        version = "0.1.0"
        source_code_commit = $commit
        sdk_version = $sdkVersion
        runtime_identifier = "win-x64"
        entrypoint = $entrypoint
        args = @("serve")
        manifest_path = $manifestPath
        manifest_sha256 = $manifestHash
        package_path = $zip
        package_sha256 = $zipHash
        component_count = $componentHashes.Count
        created_at_utc = [DateTimeOffset]::UtcNow.ToString("O")
        status = "PUBLISHED_ARTIFACT_BUILT"
    }
    $evidencePath = Join-Path (Join-Path $OcpRoot "artifacts") "build-evidence.json"
    [System.IO.File]::WriteAllText($evidencePath, ($evidence | ConvertTo-Json -Depth 10) + [Environment]::NewLine, [System.Text.UTF8Encoding]::new($false))

    Write-Output "BUILD_COMMIT=$commit"
    Write-Output "SDK=$sdkVersion"
    Write-Output "ENTRYPOINT=$entrypoint"
    Write-Output "ARGS=serve"
    Write-Output "MANIFEST_SHA256=$manifestHash"
    Write-Output "PACKAGE=$zip"
    Write-Output "PACKAGE_SHA256=$zipHash"
    Write-Output "BUILD_EVIDENCE=$evidencePath"
    exit 0
}
catch {
    Write-Host ("[BUILD FAILED] " + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
