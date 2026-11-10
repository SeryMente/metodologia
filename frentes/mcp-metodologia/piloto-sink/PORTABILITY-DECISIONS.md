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


## Reconciliación posterior al avance de main · 2026-11-10

La base de creación anterior se conserva como hecho histórico. Después de que main avanzara, la rama se reconcilió selectivamente con el main vigente:

- Main/segundo padre: `646608896a499f78640d6f17ec1e87876089e16f`.
- Commit de reconciliación: `dfae6b0fe60438753fa7abe0b9febd6f9088783c`; padres: HEAD previo de la rama `ebc80ae464a24ea99d634eb2d928fcc50a43acfc` y main `646608896a499f78640d6f17ec1e87876089e16f`.
- Se usó el árbol de main y se sobrepusieron únicamente 22 archivos propiedad del candidato. Se dejaron los documentos núcleo/lista tal como estaban en main en ese commit; sus actualizaciones MCP-OCP posteriores se hicieron sobre estas versiones frescas. No se copiaron las modificaciones EP/Gobernanza al alcance funcional MCP.
- Compare posterior a la reconciliación: 7 ahead / 0 behind; merge-base = main actual. Tras actualizar núcleo y backlog, la PR compara 9 ahead / 0 behind y 24 rutas.
- PR #27 sigue OPEN / DRAFT / NOT MERGED.
- CI tras reconciliar: run `42903756431`, job `130136260875`; job sin runner asignado (`runner_id=0`), sin pasos, logs ni artefactos. Causa raíz no verificada; build/pruebas/smoke no acreditados.

Esta subsección no sustituye el registro original de la comparación inicial 0/0 ni declara PASS técnico.


## Segunda sincronización selectiva con main · 2026-11-10

- Main: `8f999198f1d8cde71361c884c9a13b745f442b49`; commit nuevo de Gobernanza: revisión interfrentes GOV-TASK-015. El diff desde el corte previo cambia únicamente ese README de Gobernanza.
- Reconciliación: `ea32a78e87bd659307fc81ff3f80b3743bae9d0a`, padres `6d56b8b85ef75ea520165c94eb2f7a8b65ac27ad` y `8f999198f1d8cde71361c884c9a13b745f442b49`.
- Se conserva el contenido de las 29 rutas propiedad del candidato, incluidas 5 del contrato MCP-OCP-14; el asiento GOV-TASK-015 permanece incorporado desde el árbol de main y no se modificó.
- Compare posterior: 18 ahead / 0 behind; merge-base igual a main. La actualización documental posterior incrementará el conteo ahead, no las rutas funcionales.
- PR #27 OPEN / DRAFT / NOT MERGED. CI sigue sin runner observable (jobs recientes `runner_id=0`, pasos vacíos, logs `BlobNotFound`, cero artifacts).


## Estado actualizado de la candidata · H1/H2 · 2026-11-10

- Main sincronizado: `8f999198f1d8cde71361c884c9a13b745f442b49`; merge de sincronización `ea32a78e87bd659307fc81ff3f80b3743bae9d0a` conserva ese main como segundo padre y mantiene 29 rutas del candidato.
- HEAD después de reconciliación y artefactos H2: `4c3d63a5a20d770c1da31366ec3563320ee1c2f6`; compare actual 19 ahead / 0 behind, 29 rutas. PR #27 OPEN / DRAFT / NOT MERGED.
- Core candidato v0.1.36; backlog provisional LIST_VERSION 0.17.
- MCP-OCP-14: contrato propuesto v0.1 y cuatro JSON Schemas parseables. Son documentación/esquemas, no motor ni escritura; perfil criptográfico, root, keys, B2 y restore siguen bajo EP. No hubo validación formal con suite ni aceptación GOV-TASK-014.
- H1: 41 pruebas escritas / 0 ejecutadas con evidencia; build/smoke sin verificar. CI jobs recientes no asignan runner (`runner_id=0`), no tienen pasos, logs `BlobNotFound` ni artefactos; causa raíz no verificada.


## Estado más reciente después del registro H2 · 2026-11-10

- HEAD de rama observado: `d50ae21ee96de04d2d99b4eaf8038f2620c249f8`; main `8f999198f1d8cde71361c884c9a13b745f442b49`; 22 ahead / 0 behind; 29 rutas; PR #27 OPEN/DRAFT/NOT MERGED.
- Core MCP-OCP v0.1.37; backlog LIST v0.18.
- H2: contrato MCP-OCP-14 propuesto + 4 schemas JSON parseables. No se implementó motor/DB/IO/cifrado/B2/restore.
- H1 CI: job más reciente piloto `130142324655`, `runner_id=0`, `steps=[]`, logs `BlobNotFound`, sin artifacts. No ejecución acreditada.
