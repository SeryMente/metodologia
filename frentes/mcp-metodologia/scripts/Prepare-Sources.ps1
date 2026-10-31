$ErrorActionPreference = 'Continue'
Register-EngineEvent -SourceIdentifier PowerShell.OnError -Action {
    Write-Host ("[ENGINE ERROR] " + $Event.SourceEventArgs.Message) -ForegroundColor Red
} | Out-Null

function Assert-ExitCode([string]$Label) {
    if ($LASTEXITCODE -ne 0) { throw "$Label failed with exit code $LASTEXITCODE" }
}

function Get-GitBlobBytes([string]$RepoRoot,[string]$BlobSha) {
    $p = [System.Diagnostics.Process]::new()
    $p.StartInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $p.StartInfo.FileName = "git"
    $p.StartInfo.WorkingDirectory = $RepoRoot
    $p.StartInfo.UseShellExecute = $false
    $p.StartInfo.RedirectStandardOutput = $true
    $p.StartInfo.RedirectStandardError = $true
    $p.StartInfo.CreateNoWindow = $true
    $p.StartInfo.Arguments = "cat-file blob $BlobSha"
    if (-not $p.Start()) { throw "Could not start git cat-file." }
    $ms = [System.IO.MemoryStream]::new()
    $copy = $p.StandardOutput.BaseStream.CopyToAsync($ms)
    $stderr = $p.StandardError.ReadToEnd()
    [void]$copy.GetAwaiter().GetResult()
    $p.WaitForExit()
    if ($p.ExitCode -ne 0) { throw "git cat-file failed: $stderr" }
    return ,$ms.ToArray()
}

try {
    $OcpRoot = Split-Path -Parent $PSScriptRoot
    $RepoRoot = (Resolve-Path (Join-Path $OcpRoot "..\..")).Path
    $TemplatePath = Join-Path $OcpRoot "resources\initial-sources.template.json"
    $ManifestPath = Join-Path $OcpRoot "resources\initial-sources.manifest.json"
    $Template = Get-Content -Raw -LiteralPath $TemplatePath | ConvertFrom-Json
    $captured = [DateTimeOffset]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    $sources = @()
    foreach ($source in $Template.sources) {
        $spec = "$($source.commit_id):$($source.canonical_path)"
        $blob = (& git -C $RepoRoot rev-parse $spec).Trim()
        Assert-ExitCode "git rev-parse $spec"
        if ($blob -ne $source.git_blob_sha) {
            throw "Git blob SHA mismatch for $($source.source_id): expected $($source.git_blob_sha), got $blob"
        }
        $bytes = Get-GitBlobBytes -RepoRoot $RepoRoot -BlobSha $blob
        $shaAlg = [System.Security.Cryptography.SHA256]::Create()
        try { $sha256 = [BitConverter]::ToString($shaAlg.ComputeHash($bytes)).Replace("-","").ToLowerInvariant() }
        finally { $shaAlg.Dispose() }
        $sources += [ordered]@{
            source_id = $source.source_id
            canonical_path = $source.canonical_path
            ref_name = $source.ref_name
            commit_id = $source.commit_id
            git_blob_sha = $blob
            content_sha256 = $sha256
            captured_at_utc = $captured
            verification_status = "VERIFIED_AT_BUILD"
            freshness_status = "NOT_CHECKED_AGAINST_MAIN"
        }
    }
    $manifest = [ordered]@{
        manifest_version = 1
        repository = "https://github.com/SeryMente/metodologia"
        captured_at_utc = $captured
        sources = $sources
    }
    $json = $manifest | ConvertTo-Json -Depth 12
    [System.IO.File]::WriteAllText($ManifestPath, $json + [Environment]::NewLine, [System.Text.UTF8Encoding]::new($false))
    $manifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $ManifestPath).Hash.ToLowerInvariant()
    Write-Output "SOURCE_MANIFEST=$ManifestPath"
    Write-Output "SOURCE_MANIFEST_SHA256=$manifestHash"
    foreach ($source in $sources) {
        Write-Output ("SOURCE {0} COMMIT={1} GIT_BLOB={2} SHA256={3} FRESHNESS={4}" -f $source.source_id,$source.commit_id,$source.git_blob_sha,$source.content_sha256,$source.freshness_status)
    }
    exit 0
}
catch {
    Write-Host ("[PREPARE SOURCES FAILED] " + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
