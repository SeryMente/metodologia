#requires -Version 7.4
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$schemaRoot = Join-Path (Split-Path -Parent $root) 'schemas'
$counts = [ordered]@{ pass = 0; fail = 0 }
$results = [System.Collections.Generic.List[object]]::new()

function Invoke-SchemaCase {
    param(
        [string]$Name,
        [string]$SchemaName,
        [object]$Fixture,
        [bool]$ExpectedValid
    )
    $schemaPath = Join-Path $schemaRoot $SchemaName
    $json = ConvertTo-Json -InputObject $Fixture -Depth 30 -Compress
    $actualValid = $false
    $reason = $null
    try {
        $actualValid = Test-Json -Json $json -SchemaFile $schemaPath -ErrorAction Stop
    }
    catch {
        $actualValid = $false
        $reason = $_.Exception.Message
    }
    $passed = ($actualValid -eq $ExpectedValid)
    if ($passed) { $counts.pass++ } else { $counts.fail++ }
    $results.Add([ordered]@{
        name = $Name
        expected_valid = $ExpectedValid
        actual_valid = $actualValid
        result = if ($passed) { 'PASS' } else { 'FAIL' }
        reason = $reason
    })
}

function Copy-JsonObject {
    param([object]$InputObject)
    $json = ConvertTo-Json -InputObject $InputObject -Depth 30 -Compress
    return ConvertFrom-Json -InputObject $json -AsHashtable -Depth 30
}

$uuid1 = '018f0000-0000-7000-8000-000000000001'
$uuid2 = '018f0000-0000-7000-8000-000000000002'
$uuid3 = '018f0000-0000-7000-8000-000000000003'
$uuid4 = '018f0000-0000-7000-8000-000000000004'
$uuid5 = '018f0000-0000-7000-8000-000000000005'
$shaA = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
$shaB = 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'

# Encrypted object envelope
$envelope = [ordered]@{
    schema_version = 'mcp-ocp.encrypted-object/0.1-draft'
    object_id = $uuid1
    object_type = 'snapshot_manifest'
    ciphertext_sha256 = $shaA
    ciphertext_bytes = 256
    encryption_profile_ref = 'synthetic-profile-ref'
    key_reference = 'synthetic-opaque-key-ref'
    envelope_format = 'mcp-ocp-ciphertext-object/0.1'
}
Invoke-SchemaCase 'envelope-valid' 'encrypted-object-envelope.schema.json' $envelope $true
$badEnvelope = (Copy-JsonObject $envelope)
$badEnvelope.object_id = 'not-a-uuidv7'
Invoke-SchemaCase 'envelope-invalid-uuid' 'encrypted-object-envelope.schema.json' $badEnvelope $false
$badEnvelopeExtra = (Copy-JsonObject $envelope)
$badEnvelopeExtra.unexpected = 'no'
Invoke-SchemaCase 'envelope-rejects-extra-property' 'encrypted-object-envelope.schema.json' $badEnvelopeExtra $false

# Snapshot manifest (FULL and INCREMENTAL), with synthetic metadata only
$dataset = [ordered]@{
    dataset_kind = 'workspace_files'
    object_count = 1
    plaintext_bytes = 32
    ciphertext_bytes = 64
    encryption_profile_ref = 'synthetic-profile-ref'
}
$object = [ordered]@{
    object_id = $uuid4
    dataset_kind = 'workspace_files'
    logical_path = 'workspace/project/readme.txt'
    plaintext_bytes = 32
    plaintext_sha256 = $shaA
    ciphertext_object_id = $uuid5
    ciphertext_bytes = 64
    ciphertext_sha256 = $shaB
    encryption_profile_ref = 'synthetic-profile-ref'
}
$manifest = [ordered]@{
    schema_version = 'mcp-ocp.snapshot-manifest/0.1-draft'
    snapshot_id = $uuid1
    workspace_id = $uuid2
    source_session_id = $uuid3
    captured_at_utc = '2026-11-10T16:00:00Z'
    snapshot_kind = 'FULL'
    parent_snapshot_id = $null
    sequence_high_watermark = 1
    retention_policy = 'INDEFINITE_CIPHERTEXT_SUBJECT_TO_LAW_AND_VALID_REQUESTS'
    datasets = @($dataset)
    objects = @($object)
}
Invoke-SchemaCase 'manifest-full-valid' 'snapshot-manifest.schema.json' $manifest $true
$incremental = (Copy-JsonObject $manifest)
$incremental.snapshot_kind = 'INCREMENTAL'
$incremental.parent_snapshot_id = $uuid5
Invoke-SchemaCase 'manifest-incremental-valid' 'snapshot-manifest.schema.json' $incremental $true
$badFullParent = (Copy-JsonObject $manifest)
$badFullParent.parent_snapshot_id = $uuid5
Invoke-SchemaCase 'manifest-full-rejects-parent' 'snapshot-manifest.schema.json' $badFullParent $false
$badIncrementalParent = (Copy-JsonObject $incremental)
$badIncrementalParent.parent_snapshot_id = $null
Invoke-SchemaCase 'manifest-incremental-requires-parent' 'snapshot-manifest.schema.json' $badIncrementalParent $false
$badPathManifest = (Copy-JsonObject $manifest)
$badPathManifest.objects = @((Copy-JsonObject $object))
$badPathManifest.objects[0]['logical_path'] = '../outside.txt'
Invoke-SchemaCase 'manifest-rejects-path-traversal' 'snapshot-manifest.schema.json' $badPathManifest $false
$badManifestExtra = (Copy-JsonObject $manifest)
$badManifestExtra.unexpected = 'no'
Invoke-SchemaCase 'manifest-rejects-extra-property' 'snapshot-manifest.schema.json' $badManifestExtra $false

# Append-only journal event
$journal = [ordered]@{
    schema_version = 'mcp-ocp.journal-event/0.1-draft'
    event_id = $uuid1
    workspace_id = $uuid2
    session_id = $uuid3
    sequence = 1
    occurred_at_utc = '2026-11-10T16:00:00Z'
    event_type = 'checkpoint.started'
    previous_event_sha256 = $null
    event_sha256 = $shaA
    object_refs = @($uuid4)
    monotonic_elapsed_ms = 0
}
Invoke-SchemaCase 'journal-valid-genesis' 'journal-event.schema.json' $journal $true
$badJournal = (Copy-JsonObject $journal)
$badJournal.content = 'synthetic body must not be stored in journal'
Invoke-SchemaCase 'journal-rejects-content-property' 'journal-event.schema.json' $badJournal $false
$badJournalHash = (Copy-JsonObject $journal)
$badJournalHash.event_sha256 = 'xyz'
Invoke-SchemaCase 'journal-rejects-invalid-hash' 'journal-event.schema.json' $badJournalHash $false
$badJournalRefs = (Copy-JsonObject $journal)
$badJournalRefs.object_refs = @($uuid4, $uuid4)
Invoke-SchemaCase 'journal-rejects-duplicate-object-refs' 'journal-event.schema.json' $badJournalRefs $false

# Checkpoint receipts and state separation
$receipt = [ordered]@{
    schema_version = 'mcp-ocp.checkpoint-receipt/0.1-draft'
    receipt_id = $uuid1
    workspace_id = $uuid2
    session_id = $uuid3
    snapshot_id = $uuid4
    started_at_utc = '2026-11-10T16:00:00Z'
    finished_at_utc = '2026-11-10T16:00:05Z'
    budget_ms = 30000
    result = 'CONFIRMED'
    highest_confirmed_state = 'LOCAL_DURABLE'
    remote_backend = 'NOT_APPLICABLE'
    evidence_refs = @($uuid5)
}
Invoke-SchemaCase 'receipt-local-durable-valid' 'checkpoint-receipt.schema.json' $receipt $true
$notConfirmed = (Copy-JsonObject $receipt)
$notConfirmed.result = 'NOT_CONFIRMED'
$notConfirmed.highest_confirmed_state = 'NONE'
$notConfirmed.remote_backend = 'NOT_APPLICABLE'
Invoke-SchemaCase 'receipt-not-confirmed-valid' 'checkpoint-receipt.schema.json' $notConfirmed $true
$emergency = (Copy-JsonObject $receipt)
$emergency.result = 'SKIPPED_EMERGENCY'
$emergency.highest_confirmed_state = 'NONE'
$emergency.remote_backend = 'NOT_APPLICABLE'
Invoke-SchemaCase 'receipt-emergency-valid' 'checkpoint-receipt.schema.json' $emergency $true
$badEmergency = (Copy-JsonObject $receipt)
$badEmergency.result = 'SKIPPED_EMERGENCY'
Invoke-SchemaCase 'receipt-emergency-cannot-claim-durability' 'checkpoint-receipt.schema.json' $badEmergency $false
$badRemote = (Copy-JsonObject $receipt)
$badRemote.highest_confirmed_state = 'REMOTE_UPLOADED'
Invoke-SchemaCase 'receipt-remote-state-requires-backblaze' 'checkpoint-receipt.schema.json' $badRemote $false
$validRemote = (Copy-JsonObject $receipt)
$validRemote.highest_confirmed_state = 'REMOTE_UPLOADED'
$validRemote.remote_backend = 'BACKBLAZE'
Invoke-SchemaCase 'receipt-remote-uploaded-valid' 'checkpoint-receipt.schema.json' $validRemote $true
$badBudget = (Copy-JsonObject $receipt)
$badBudget.budget_ms = 30001
Invoke-SchemaCase 'receipt-rejects-budget-over-30s' 'checkpoint-receipt.schema.json' $badBudget $false

$results | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $env:TEMP 'MCP-OCP-14-schema-test-results.json') -Encoding utf8
"SCHEMA_TEST_SUMMARY PASS=$($counts.pass) FAIL=$($counts.fail)"
"SCHEMA_TEST_CASES=$($results.Count)"
if ($counts.fail -gt 0) { $results | Where-Object { $_.result -eq 'FAIL' } | ConvertTo-Json -Depth 8; exit 1 }
exit 0
