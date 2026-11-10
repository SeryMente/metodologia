# Decisiones de portabilidad · MCP-OCP Hito A

**Corte:** 2026-11-10. **Rama:** `feat/mcp-ocp-p004-rebaseline-20261110-cycle02`.
**Base de main:** `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd`.
**DUG:** Samantha v388/NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
**Core:** v0.1.28. **Backlog:** LIST_VERSION 0.9.

## Rebaseline
La rama se creó directamente desde el HEAD de main indicado arriba. No se reutiliza una rama histórica como base y no se fusiona ninguna rama divergente completa.

### Ramas inspeccionadas
- `integration/ocp-mcp-0.1.0-selective-20261101`: 3 ahead / 620 behind frente al main de referencia antes del último update EP; divergente.
- `build/ocp-mcp-mvp-0.1.0`: 11 ahead / 939 behind frente al mismo main de referencia; divergente.
- `feat/mcp-ocp-p004-pilot-20261110-cycle05`: 26 ahead / 11 behind frente a main SHA `06467fb32f344e5ff7e4006479a4f614ecd21164`; merge-base `0f933b9e3efae20131da37f99f50f4bc4a4eaf74`. No se usa como base.
- `feat/mcp-ocp-p004-rebaseline-20261110`: rama de ciclo anterior creada desde `06467fb...`; quedó 16 ahead / 1 behind tras el commit EP `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd`. Se deja como antecedente del PR supersedido; el presente ciclo02 parte del main actualizado.

## Clasificación de portabilidad
| Componente | Decisión | Motivo |
|---|---|---|
| OcpMcp.csproj histórico | REWRITE | .NET 10 como base; sin DB/vault dependientes. |
| Program.cs histórico | REWRITE | Arranque mínimo STDIO, sin inicializar datos persistentes ni credenciales. |
| McpServer.cs histórico | REWRITE | JSON-RPC STDIO, initialize/initialized, tools/list/call; herramienta única P004. |
| DugSourceReader.cs | REWRITE | Validación cerrada sobre DUG v388 y blob fijado. |
| SourcePin.cs | REWRITE | Pins v388, commit/blob/versiones actuales. |
| PrincipleCatalog / SourceImporter | DROP en Hito A | Catálogo/importador persistente no necesarios para corte P004. |
| SQLite, CryptoBox, KeyVault, EventChain, ReceiptSigner, BackupService, OperationService | DROP | Persistencia, custodia y operaciones fuera del piloto. |
| Pruebas históricas | REWRITE | No cubren el contrato Sink actual. |
| Scripts/builds/binaries/manifests históricos | DROP como artefactos | No se heredan PASS, binarios ni recibos antiguos. |
| Panel WPF / monitor | REWRITE · CANDIDATO ESCRITO | Proyecto WPF read-only + writer/reader y 11 pruebas sintéticas; build, tests, smoke visual e integración EP pendientes. Obligatorio en 1.0.0; no bloquea P004. |

## Stack y publicación fijados
- .NET SDK **10.0.403**, fijado en `global.json`.
- Piloto `net10.0`; ninguna dependencia NuGet externa.
- Piloto CI framework-dependent sin RID, para ejecutar fixtures en runner Linux.
- Producto Windows 1.0.0: publicación `win-x64`, self-contained, perfil separado.
- Panel futuro: WPF/C# con `net10.0-windows`, solo después de schema y dentro del contrato aprobado.

## Evidencia de código
El código del piloto se portó por archivo desde la rama de ciclo anterior, no mediante merge. El DUG se leyó tanto en el commit pinneado como en main actualizado; ambas lecturas devuelven blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. La representación humana del DUG renderiza `content_markdown` desde el mismo objeto P004 del bloque gov-data; el lector valida marcador/ancla y el registro P004 exacto.

**Estado:** rama y pins publicados; código/tests escritos; build, suite y smoke sin ejecución verificada.


## Implementación candidata de observabilidad · ciclo02

El proyecto `OcpMcp.Monitoring` define modelos schemaVersion 1, writer best-effort de `state.json` / `events.jsonl` y reader fail-closed de `session.json` / snapshot / eventos. `OcpMcp.Panel` es una ventana WPF read-only; el servidor solo activa la proyección mediante el parámetro explícito `--monitor-root` suministrado por EP. No se infiere protección del volumen a partir de MCP y no hay default de root.

Tests escritos: 15 piloto P004 + 11 monitor; 0 ejecutados. CI configurado para build del servidor, ambas suites, WPF cross-target y smoke STDIO; no hay build/test PASS observado ni paquete.
