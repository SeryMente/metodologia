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


## Cierre vivo de candidata · HEAD 4ac337f · 2026-11-10

- Main `8f999198f1d8cde71361c884c9a13b745f442b49`; rama `feat/mcp-ocp-sink-p004-main-a34c1c5b`, HEAD `4ac337f0b1e507497b8ab6c6c64d71d2e8001e13`, 26 ahead / 0 behind; 29 rutas. PR #27 OPEN/DRAFT/NOT MERGED.
- Core candidato v0.1.38; backlog LIST v0.19.
- H1: 41 tests escritos/0 ejecutados con evidencia; build y smoke pendientes. CI jobs actuales sin runner asignado, steps, logs ni artifacts; causa raíz no verificada.
- H2: contrato MCP-OCP-14 v0.1 propuesto y cuatro schemas parseables; no ratificado y sin IO/runtime.


## Revalidación local H1 · 2026-11-10

La preparación inicial que fijó `global.json` en la raíz queda supersedida por el ajuste de alcance: el pin `10.0.403` reside ahora en `frentes/mcp-metodologia/global.json`, y el workflow observa esa ruta. El `.gitignore` fue restaurado desde main para excluir `.env/.env.*`, claves/certificados, bases de datos y logs.

- Main incorporado como segundo padre: `ff9c75926a2907c630f506c4e08c267b15bca7cf`; merge commit `e5bd7d992f3fda83035cc43329353b846a25e9a8`.
- Se corrigió la lectura del MDP: el DUG v388 lo publica bajo `document.principle_inventory_policy`; el fixture sintético ahora reproduce esa forma.
- SDK .NET 10.0.403 instalado solo bajo `%TEMP%` del perfil MantenimientoRCI; no hubo instalación global ni PATH persistente.
- Windows 10.0.26200 x64, PowerShell 7.4.22. Restore de ambas suites PASS; build servidor y dos proyectos de tests PASS, 0 warnings/0 errors.
- P004 18/18 PASS; monitor/readiness 23/23 PASS; MCP STDIO initialize/tools/list/tools/call/EOF smoke PASS; harness exit 0.
- SHA-256: P004 `D6F21749D8898B6624988BF056DA2BCC66DA3A5DF1CAE8FFA1FA2DB36DEB338B`; monitor `B9B3F2B5A42285CC3D81AE5EEFBDC678104E5E408A861BB5D1045885CBC29989`; smoke summary `2D5C90D467B5508A9FAD22F0C00902035D9F3FE7F703B052AAB13365BE2C0B31`; STDOUT `7818B9894239D7760EAD89D18BA78244096041FE2738C639F840A5FCD9918938`; STDERR `8614035B5585D84175B53B1DE4A126ED6B3A84BDED7E6BE51153A2FB8AF2D61B`.
- Git checkout quedó limpio tras las pruebas (`git diff --check` y cero tracked changes).
- Límite: validación local Windows; no acredita runner GitHub `ubuntu-latest`, instalación EP, E2E IPZ, paquete con panel WPF ni aceptación del producto 1.0.0.

## Reconciliación final, pruebas y paquete P004 · 2026-11-11

La portación selectiva se ejecutó y validó localmente sobre el commit `4600086c492582c5d854145db64097310ac73686`, con base de main al build `1867af0c69f250aaee2b35b585eec8b74827b69c`. El DUG v388/NX-388m fue cotejado por Git blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.

- Windows 10.0.26200 x64, PowerShell 7.4.22, .NET SDK 10.0.403 y runtime 10.0.14 x64. SDK y clon usados de manera aislada bajo directorios temporales, sin instalación global ni PATH persistente.
- Restore/build servidor y dos suites: PASS; 0 warnings / 0 errors.
- P004: 18/18 PASS; monitor/readiness: 23/23 PASS; smoke STDIO/EOF: PASS.
- ZIP candidato nuevo con 9 archivos; extracción/hash-readback PASS; smoke sobre binario exacto empaquetado PASS.
- ZIP SHA-256: `50c0c68f769aefec95dfde3e45c74594d34b3fbcb25916814181fad241e8e3a6` (138.142 bytes). Manifest/receipt/SHA256SUMS están en la misma ruta de entrega.
- Paquete y pin publicados en commit `69f17be96e6a5e406d59ce66ffe0ac89589831c4`.

La rama se sincronizó después con main hasta `0b4a7373fdc07f39b3f764e9c6e0c94fce21cc2f`, mediante merge `63e2f1399fdb210294ef26983babc8fbef87a4a6`. Los 26 commits ahead / 0 behind incluyen el producto y las anotaciones MCP-OCP; los cambios externos integrados son documentación EP/Gobernanza no solapada.

**No incluidos/aceptados:** panel WPF y release 1.0.0, generalización P001–P043, hosted CI, instalación/handoff EP, runtime persistente de Fila 4 e IPZ E2E. EP-TASK-003/005 conservan sus gates. El piloto permanece candidato no aceptado.
