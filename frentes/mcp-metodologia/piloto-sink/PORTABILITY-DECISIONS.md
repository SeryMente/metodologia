# Decisiones de portabilidad · Sprint SINK-P004

**Corte:** 2026-11-10  
**Rama nueva:** `feat/mcp-ocp-sink-p004-main-a34c1c5b`  
**Base exacta de main:** `a34c1c5b43edbcbaf015056f4dc892f5def29eea`  
**Tree base:** `69b0b8a29fe9bfb981e9afce03aa6913ab036539`  
**Comparación inicial:** 0 ahead / 0 behind antes del primer commit  
**DUG:** Samantha v388/NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; Git blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`  
**Núcleo/backlog vigentes al iniciar:** MCP-OCP v0.1.29 / LIST v0.10  
**SDK/TFM:** .NET SDK 10.0.403; servidor, monitor y pruebas `net10.0`; piloto framework-dependent, sin RID. El RID de release final no se infiere ni se fija en este corte.

## Reconciliación de ramas

Todos los cotejos se hicieron contra el mismo HEAD de main `a34c1c5b43edbcbaf015056f4dc892f5def29eea`; ninguna candidata histórica se usa como base ni se fusiona completa.

| Rama candidata | Ahead | Behind | Archivos en diff | Decisión |
|---|---:|---:|---:|---|
| `integration/ocp-mcp-0.1.0-selective-20261101` | 3 | 678 | 22 | DROP como base; incluye DB, Vault, backup, cifrado y operaciones fuera de P004. |
| `build/ocp-mcp-mvp-0.1.0` | 11 | 997 | 28 | DROP como base/release; manifiestos y recibos históricos no acreditan esta implementación. |
| `feat/mcp-ocp-p004-pilot-20261110-cycle01` | 9 | 91 | 9 | Fuente histórica de primer lector/servidor; no mergear. |
| `feat/mcp-ocp-p004-pilot-20261110-cycle02` | 64 | 86 | 15 | Fuente histórica de P004/CI; no mergear. |
| `feat/mcp-ocp-p004-pilot-20261110-cycle03` | 2 | 85 | 2 | Deltas documentales; no mergear. |
| `feat/mcp-ocp-p004-pilot-20261110-cycle04` | 27 | 77 | 16 | Fuente histórica puntual; no mergear. |
| `feat/mcp-ocp-p004-pilot-20261110-cycle05` | 26 | 69 | 16 | Fuente histórica puntual; no mergear. |
| `feat/mcp-ocp-p004-rebaseline-20261110` | 16 | 58 | 16 | Fuente selectiva; no mergear. |
| `feat/mcp-ocp-p004-rebaseline-20261110-cycle02` | 112 | 57 | 30 | Fuente técnica más completa inspeccionada; archivos portados selectivamente. No mergear. |
| `feat/mcp-ocp-sink-p004-pilot-20261110` | 0 | 92 | 0 | Histórica/obsoleta; no usar. |
| `feature/mcp-ocp-portable-recovery-v1-20261101` | 26 | 497 | 32 | DROP para este sprint; PPR/cross-host y custodia fuera de alcance. |

## Matriz REUSE / ADAPT / REWRITE / DROP

| Componente | Decisión | Tratamiento en este corte |
|---|---|---|
| Pin DUG v388/NX-388m | REUSE | Cotejado contra main; commit/blob/versiones fijados en `SourcePin` y `SOURCE-PIN.json`. |
| SDK .NET 10.0.403 | REUSE | Fijado mediante `global.json`; no implica que exista un SDK en el entorno local. |
| `DugSourceReader` | ADAPT | Portado y revisado; valida Git blob, UTF-8, GOW:ARR, versiones, autoridad, 43 IDs, marcador humano P004, texto/MDP/preponderancia y hashes. |
| `SourcePin` | ADAPT | Pin v388 conservado; manifiesto actualizado a esta rama/base. |
| `McpServer` | ADAPT | JSON-RPC STDIO; initialize, initialized, tools/list/call; una herramienta y P004; no crea shutdown/exit propio. Versión candidata 0.1.0. |
| `Program` | ADAPT | STDIO; root del repositorio requerido/resuelto; monitor opt-in solo con ruta proporcionada por EP; diagnósticos en STDERR. |
| `OcpMcp.csproj` | ADAPT | `net10.0`, versión candidata 0.1.0, warnings-as-errors; referencia local a biblioteca de monitor; sin paquetes NuGet externos. |
| Biblioteca de monitorización | ADAPT | Writer/reader/evaluator read-only/fail-closed; servidor solo escribe proyección si EP suministra explícitamente `--monitor-root`. |
| 18 pruebas P004 | ADAPT | Fixtures sintéticos, pin de main y negativos; incluidas, aún sin ejecutar en esta rama. |
| 23 pruebas monitor/readiness | ADAPT | Suite sintética separada; incluida, aún sin ejecutar en esta rama. |
| Harness/workflow | ADAPT | Captura `dotnet --info`, restore/build, suites, stdout/stderr, smoke real STDIO/EOF y artefactos incluso en fallo. |
| `PrincipleCatalog`/aliases generales/importación privada | DEFER | No son necesarios para el corte vertical P004; después de aceptación del piloto y gate EP para fuentes privadas. |
| SQLite, CryptoBox, KeyVault, EventChain, ReceiptSigner, BackupService, OperationService y PPR | DROP | Fuera de SINK-P004 y del alcance autorizado del piloto. |
| Panel WPF | DEFER / REWRITE | Obligatorio para 1.0.0 después de congelar schema; no bloquea la primera respuesta P004. |
| Builds, ZIP, manifests y PASS históricos | DROP como evidencia | No se reutilizan como resultados de esta rama. |

## Estado de la portabilidad

- Rama nueva creada desde main y comparación inicial 0/0 verificada.
- Código portado por archivo; no hubo merge de ramas divergentes.
- 18 pruebas P004 y 23 de monitor están escritas; su ejecución sigue pendiente.
- Build, smoke, paquete y aceptación no están acreditados.
- EP-TASK-003 PASS es requisito para fuentes privadas, DB real, runtime persistente e instalación; no bloquea código remoto no sensible ni fixtures sintéticos.
- DUG, ART-025/027, IPZ nativa, control de responsabilidad, Fila 4 y recursos EP no se modifican.
