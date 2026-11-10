# MCP-OCP SINK:P004 - pilot handoff

Status: CANDIDATE / NOT ACCEPTED / NOT INSTALLED
Build source: SeryMente/metodologia, branch feat/mcp-ocp-sink-p004-main-a34c1c5b, commit b6ce37af1dc32b2e3bb8af3ded2a77c7ba6d7648
Current PR branch: f54ce14a841971e79b887e760593a91f845b1b5f; comparison from build commit shows only a later DTC coordination-file change, no source/build/test changes.
DUG: Samantha v388 / NX-388m; commit 3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c; Git blob 4db0ebadfd1e48b2bdec9236ba7f344921e4a865.
Build: .NET SDK 10.0.403, target net10.0, framework-dependent, no RID, no external NuGet packages.

## Runtime prerequisites
- Windows x64.
- Microsoft.NETCore.App 10.0.x x64 runtime installed (SDK not required to run).
- A complete SeryMente/metodologia checkout containing the pinned DUG source commit/blob.
- Configure the MCP client to launch OcpMcp.exe serve --repo-root <absolute-checkout-path> over STDIO. Keep STDOUT exclusively for JSON-RPC; diagnostics/events remain on STDERR.
- No network listener is created. The sole tool is sink_principle and this pilot accepts only P004.

## Package verification performed
- Nine package files validated against sizes and SHA-256 after ZIP extraction.
- Packaged executable smoke: initialize, tools/list, tools/call(P004), EOF; three JSON-RPC responses; SINK_READ_SUCCESS on STDERR.
- Result returned P004 and DUG v388/NX-388m.
- Local test suite: 18/18 P004 and 23/23 monitor/readiness PASS; build and STDIO smoke PASS.

## Installation and acceptance gates
Do not install or configure a persistent root from this package by MCP-OCP. EP-TASK-003 must first pass its host/workspace/protected-storage gates; EP-TASK-005 owns receipt, extraction and local installation. Operator provisioning (REGISTER <SID>) is separate and interactive; do not automate it or send the SID through chat. Gobernanza owns the IPZ -> RDC -> STDIO end-to-end acceptance. This package does not establish that acceptance.

MCP-NORMATIVO=DISABLED; FOL1 remains inactive.