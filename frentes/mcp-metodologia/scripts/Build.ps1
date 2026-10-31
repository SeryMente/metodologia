$ErrorActionPreference = 'Continue'
Register-EngineEvent -SourceIdentifier PowerShell.OnError -Action {
    Write-Host ("[ENGINE ERROR] " + $Event.SourceEventArgs.Message) -ForegroundColor Red
} | Out-Null

try {
    $OcpRoot = Split-Path -Parent $PSScriptRoot
    $RepoRoot = (Resolve-Path (Join-Path $OcpRoot "..\..")).Path
    $Project = Join-Path $OcpRoot "src\OcpMcp\OcpMcp.csproj"
    $SourceManifest = Join-Path $OcpRoot "resources\initial-sources.manifest.json"
    $ArtifactsRoot = Join-Path $OcpRoot "artifacts"
    New-Item -ItemType Directory -Force -Path $ArtifactsRoot | Out-Null

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

    $env:DOTNET_CLI_TELEMETRY_OPTOUT = "1"
    $env:DOTNET_NOLOGO = "1"

    # Unit-level cryptography, SQLite rollback, event-chain and immutability tests.
    $unitProject = Join-Path $OcpRoot "tests\OcpMcp.UnitTests\OcpMcp.UnitTests.csproj"
    $env:OCPMCP_UNIT_REPO_ROOT = $RepoRoot
    $unitLines = & $Dotnet run --project $unitProject --configuration Release 2>&1
    $unitExit = $LASTEXITCODE
    $unitLines | ForEach-Object { Write-Output $_ }
    $unitSummaryText = ($unitLines | ForEach-Object { [string]$_ }) -join "`n"
    $unitMatch = [regex]::Match($unitSummaryText, "UNIT_SUMMARY PASS=(\d+) FAIL=(\d+)")
    if ($unitExit -ne 0 -or -not $unitMatch.Success -or [int]$unitMatch.Groups[2].Value -ne 0) {
        throw "Unit test suite failed or did not emit its summary (exit $unitExit)."
    }
    $unitPassed = [int]$unitMatch.Groups[1].Value
    $unitFailed = [int]$unitMatch.Groups[2].Value

    $publish = Join-Path $ArtifactsRoot "publish\0.1.0"
    $packages = Join-Path $ArtifactsRoot "packages"
    if (Test-Path $publish) { Remove-Item -LiteralPath $publish -Recurse -Force }
    New-Item -ItemType Directory -Force -Path $publish,$packages | Out-Null

    $commit = (& git -C $RepoRoot rev-parse HEAD).Trim()
    if ($LASTEXITCODE -ne 0) { throw "git rev-parse HEAD failed." }

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
    $sourceManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $SourceManifest).Hash.ToLowerInvariant()
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
        source_manifest_sha256 = $sourceManifestHash
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

    # Verify the compressed delivery package by extracting and rechecking every published component.
    $packageCheck = Join-Path $ArtifactsRoot "package-check"
    if (Test-Path $packageCheck) { Remove-Item -LiteralPath $packageCheck -Recurse -Force }
    New-Item -ItemType Directory -Force -Path $packageCheck | Out-Null
    Expand-Archive -LiteralPath $zip -DestinationPath $packageCheck -Force
    $packageComponentsOk = $true
    foreach ($component in $componentHashes) {
        $extracted = Join-Path $packageCheck $component.path
        if (-not (Test-Path -LiteralPath $extracted)) { $packageComponentsOk = $false; break }
        $extractedHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $extracted).Hash.ToLowerInvariant()
        if ($extractedHash -ne $component.sha256) { $packageComponentsOk = $false; break }
    }
    $extractedManifest = Join-Path $packageCheck "build-manifest.json"
    if (-not (Test-Path -LiteralPath $extractedManifest) -or (Get-FileHash -Algorithm SHA256 -LiteralPath $extractedManifest).Hash.ToLowerInvariant() -ne $manifestHash) {
        $packageComponentsOk = $false
    }
    Remove-Item -LiteralPath $packageCheck -Recurse -Force
    if (-not $packageComponentsOk) { throw "Compressed package verification failed." }

    # End-to-end stdio integration tests against the self-contained published executable.
    $smokeScript = Join-Path $OcpRoot "tests\Smoke.ps1"
    $smokeLines = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $smokeScript 2>&1
    $smokeExit = $LASTEXITCODE
    $smokeLines | ForEach-Object { Write-Output $_ }
    $smokeSummaryText = ($smokeLines | ForEach-Object { [string]$_ }) -join "`n"
    $smokeMatch = [regex]::Match($smokeSummaryText, "TEST_SUMMARY PASS=(\d+) FAIL=(\d+)")
    if ($smokeExit -ne 0 -or -not $smokeMatch.Success -or [int]$smokeMatch.Groups[2].Value -ne 0) {
        throw "MCP stdio integration tests failed or did not emit their summary (exit $smokeExit)."
    }
    $smokePassed = [int]$smokeMatch.Groups[1].Value
    $smokeFailed = [int]$smokeMatch.Groups[2].Value

    $testEvidence = [ordered]@{
        product = "OCP MCP"
        version = "0.1.0"
        source_code_commit = $commit
        sdk_version = $sdkVersion
        unit_tests = [ordered]@{ status="PASS"; passed=$unitPassed; failed=$unitFailed }
        stdio_integration_tests = [ordered]@{ status="PASS"; passed=$smokePassed; failed=$smokeFailed }
        created_at_utc = [DateTimeOffset]::UtcNow.ToString("O")
    }
    $testEvidencePath = Join-Path $ArtifactsRoot "test-evidence.json"
    [System.IO.File]::WriteAllText($testEvidencePath, ($testEvidence | ConvertTo-Json -Depth 10) + [Environment]::NewLine, [System.Text.UTF8Encoding]::new($false))

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
        source_manifest_sha256 = $sourceManifestHash
        package_path = $zip
        package_sha256 = $zipHash
        component_count = $componentHashes.Count
        unit_tests_passed = $unitPassed
        unit_tests_failed = $unitFailed
        integration_tests_passed = $smokePassed
        integration_tests_failed = $smokeFailed
        test_evidence_path = $testEvidencePath
        status = "BUILT_AND_TESTED"
        created_at_utc = [DateTimeOffset]::UtcNow.ToString("O")
    }
    $evidencePath = Join-Path $ArtifactsRoot "build-evidence.json"
    [System.IO.File]::WriteAllText($evidencePath, ($evidence | ConvertTo-Json -Depth 10) + [Environment]::NewLine, [System.Text.UTF8Encoding]::new($false))
    [System.IO.File]::WriteAllText($zip + ".sha256", ($zipHash + "  " + [System.IO.Path]::GetFileName($zip) + [Environment]::NewLine), [System.Text.UTF8Encoding]::new($false))
    [System.IO.File]::WriteAllText((Join-Path $ArtifactsRoot "build-manifest.json.sha256"), ($manifestHash + "  build-manifest.json" + [Environment]::NewLine), [System.Text.UTF8Encoding]::new($false))

    Write-Output "BUILD_COMMIT=$commit"
    Write-Output "SDK=$sdkVersion"
    Write-Output "ENTRYPOINT=$entrypoint"
    Write-Output "ARGS=serve"
    Write-Output "MANIFEST_SHA256=$manifestHash"
    Write-Output "SOURCE_MANIFEST_SHA256=$sourceManifestHash"
    Write-Output "PACKAGE=$zip"
    Write-Output "PACKAGE_SHA256=$zipHash"
    Write-Output "UNIT_TESTS=PASS:$unitPassed/FAIL:$unitFailed"
    Write-Output "INTEGRATION_TESTS=PASS:$smokePassed/FAIL:$smokeFailed"
    Write-Output "BUILD_EVIDENCE=$evidencePath"
    Write-Output "TEST_EVIDENCE=$testEvidencePath"
    exit 0
}
catch {
    Write-Host ("[BUILD FAILED] " + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
