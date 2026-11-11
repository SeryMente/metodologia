# Piloto local SINK:P004 · MCP-OCP

**Producto:** MCP-OCP 0.1.0 candidato (no aceptado)  
**Sprint:** SINK-P004  
**DUG:** Samantha v388 / NX-388m  
**Base inicial de reconciliación:** `7ab0c555b774adc5b930aad700f101ab2660b79a`  
**Rama:** `feat/mcp-ocp-p004-reconciled-20261111-7ab0c555`

## Objetivo

Construir una recuperación trazable de `SINK:P004` mediante un servidor MCP local sobre STDIO. La fuente se fija por commit y Git blob; el piloto no activa MCP-NORMATIVO ni evalúa aplicabilidad.

## Fuente

- Archivo: `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`
- Commit: `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`
- Git blob: `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`
- DUG v388/NX-388m; Metacanon 1.29; GOW 2.18.
- GOW:ARR = `gow-sec-14`; principio = `P004`.

El lector valida el hash Git del archivo, UTF-8, versiones y fuente canónica, GOW:ARR, autoridad, catálogo único de 43 IDs, marcador humano `[[P:P004]]`, título, ancla, texto normativo exacto, MDP y preponderancia. Nunca sustituye una fuente inválida con memoria ni con el MDP.

## Transporte

- JSON-RPC 2.0 por STDIO.
- Métodos: `initialize`, `notifications/initialized`, `ping`, `tools/list`, `tools/call`.
- Única herramienta: `sink_principle`, restringida a `principle_id=P004`.
- EOF cierra el proceso; no se inventan métodos `shutdown` ni `exit`.
- STDOUT queda reservado al protocolo; eventos y diagnósticos saneados van a STDERR.
- No se levanta listener ni endpoint público.

## Pruebas y validación

Desde `frentes/mcp-metodologia/`:

```powershell
dotnet build src/OcpMcp/OcpMcp.csproj --configuration Release
dotnet run --project tests/OcpMcp.Pilot.Tests/OcpMcp.Pilot.Tests.csproj --configuration Release
dotnet run --project tests/OcpMcp.Monitoring.Tests/OcpMcp.Monitoring.Tests.csproj --configuration Release
./piloto-sink/ci/Invoke-PilotValidation.ps1
```

- 18 casos de contrato P004.
- 23 casos de monitor/readiness.
- Validación del HEAD `e5bd7d992f3fda83035cc43329353b846a25e9a8`: 18/18 P004 + 23/23 monitor PASS; builds y smoke STDIO/EOF PASS en Windows/.NET 10.0.403. El runner hospedado `ubuntu-latest` continúa sin ejecución observable.
- CI captura logs, stdout/stderr y diagnóstico del runner incluso ante fallo.

## Límites

No importa fuentes privadas, crea DB real, provisiona operador, instala en Fila 4, escribe IPZ nativa ni acredita el E2E desde contexto IPZ. EP conserva sus gates y ciclo de vida. La generalización a P001–P043 y el panel WPF son fases posteriores. FOL1 permanece preparado/inactivo y MCP-NORMATIVO DESACTIVADO.


## Revisión de tarjeta humana y rebaseline actual

El DUG renderiza la tarjeta `P004` con `card(p) → render(p.content_markdown)`. El lector valida que ese campo coincida exactamente con `> normative_text`; la suite incluye un negativo que altera ese Markdown incluso tras repinnear el blob. La comprobación estática no reproduce una divergencia entre tarjeta humana y respuesta Sink.

La rama se reconcilió con main `646608896a499f78640d6f17ec1e87876089e16f` mediante el commit `dfae6b0fe60438753fa7abe0b9febd6f9088783c`. Estado actual de la rama: 9 ahead / 0 behind; PR #27 DRAFT / NOT MERGED. El build, los 41 tests y el smoke aún no están ejecutados con evidencia: el job CI terminó sin runner asignado, pasos, logs ni artefactos.


## Segunda sincronización con main vigente

La rama fue sincronizada también con main `8f999198f1d8cde71361c884c9a13b745f442b49` mediante merge `ea32a78e87bd659307fc81ff3f80b3743bae9d0a`, conservando las rutas del candidato y el asiento GOV-TASK-015. Compare posterior: 18 ahead / 0 behind. PR #27 sigue OPEN/DRAFT/NOT MERGED.

La propuesta MCP-OCP-14 v0.1 y sus cuatro schemas se encuentran bajo `persistencia/`; son diseño documental, no runtime. El último CI P004 sigue sin runner asignado, sin pasos/logs/artefactos; build, tests y smoke no están acreditados.


## Estado candidato vigente · H1/H2

Main sincronizado: `8f999198f1d8cde71361c884c9a13b745f442b49`; merge `ea32a78e87bd659307fc81ff3f80b3743bae9d0a`. HEAD actual de la rama antes de esta nota: `4c3d63a5a20d770c1da31366ec3563320ee1c2f6`; 19 ahead / 0 behind; PR #27 OPEN/DRAFT/NOT MERGED.

H2 aporta una propuesta MCP-OCP-14 v0.1 y cuatro JSON Schemas parseables. No hay código de persistencia, DB, IO, B2, Vault ni restore; dichos actos mantienen responsables y gates EP. Build/tests/smoke H1 no cuentan con evidencia de ejecución por jobs sin runner asignado.


## Último estado de revisión · 2026-11-10

Rama HEAD observado `d50ae21ee96de04d2d99b4eaf8038f2620c249f8`; main `8f999198f1d8cde71361c884c9a13b745f442b49`; 22 ahead / 0 behind; 29 rutas; PR #27 abierta en borrador y sin merge. Core candidato v0.1.37, backlog LIST v0.18.

H1: 41 tests escritos/0 ejecutados con evidencia; build y smoke pendientes. El job piloto más reciente concluyó sin runner asignado, pasos, logs ni artefactos; causa raíz no verificada. H2: contrato MCP-OCP-14 propuesto, sin runtime ni escritura.


## Estado vivo · 2026-11-10

Main `8f999198f1d8cde71361c884c9a13b745f442b49`; rama HEAD `4ac337f0b1e507497b8ab6c6c64d71d2e8001e13`; 34 ahead / 0 behind; 29 rutas. PR #27 OPEN/DRAFT/NOT MERGED. Core v0.1.38; backlog LIST v0.19.

41 pruebas escritas, 0 ejecutadas con evidencia; build y smoke no verificados. CI reciente no asigna runner y no entrega pasos/logs/artefactos. H2 MCP-OCP-14 es propuesta documental; no hay runtime ni IO.


## Revalidación ejecutable local · 2026-11-10

- HEAD validado: `e5bd7d992f3fda83035cc43329353b846a25e9a8`; main base `ff9c75926a2907c630f506c4e08c267b15bca7cf`; comparación 33 ahead / 0 behind.
- Lector DUG corregido para leer `document.principle_inventory_policy`; fixture ahora reproduce la estructura canónica v388.
- `.gitignore` seguro restaurado desde main. El pin .NET 10.0.403 queda en `frentes/mcp-metodologia/global.json`, no en la raíz.
- Entorno de validación: Windows 10.0.26200 x64, SDK 10.0.403, PowerShell 7.4.22.
- Restore de ambos proyectos PASS; build de servidor y suites PASS con 0 warnings/0 errors; pruebas P004 18/18 y monitor/readiness 23/23 PASS.
- Smoke: initialize, tools/list, tools/call y EOF; tres respuestas JSON-RPC en STDOUT, evento `SINK_READ_SUCCESS` en STDERR; exit code 0 y `PILOT_CI_RESULT=PASS`.
- SHA-256: P004 log `D6F21749D8898B6624988BF056DA2BCC66DA3A5DF1CAE8FFA1FA2DB36DEB338B`; monitor log `B9B3F2B5A42285CC3D81AE5EEFBDC678104E5E408A861BB5D1045885CBC29989`; smoke summary `2D5C90D467B5508A9FAD22F0C00902035D9F3FE7F703B052AAB13365BE2C0B31`.
- Esta evidencia corresponde a Windows local, no al runner hospedado Ubuntu ni a la aceptación IPZ. La instalación EP y el E2E IPZ siguen pendientes de sus responsables/gates.

## Paquete candidato disponible para handoff

- Ruta en la rama PR #27: frentes/mcp-metodologia/entregas/piloto-sink-p004/MCP-OCP-SINK-P004-b6ce37af-v3.zip
- Manifest: frentes/mcp-metodologia/entregas/piloto-sink-p004/manifest.json
- Runbook: frentes/mcp-metodologia/entregas/piloto-sink-p004/RUNBOOK.md
- ZIP SHA-256: DE556FD547ACF2AB3946DF5AC2395A3993CB459B5E48F8E745A661A113A90783
- Manifest SHA-256: 85F70366144FD2109D9688F2DDB6E7819FF955B8F05697C2FC6966E04F0044B1
- Estado: CANDIDATE_NOT_ACCEPTED. ZIP extraído, 9/9 archivos cotejados y package smoke P004/STDIO/EOF PASS.
- Requisito de runtime: Microsoft.NETCore.App 10.0.x x64. Fila 4 NO VERIFICADO.
- No transferido ni instalado; EP-TASK-003/005 conservan los gates. No equivale a E2E IPZ ni producto 1.0.0.


## Reconciliación sobre main vigente · 2026-11-11

La PR #27 permanece como fuente de lectura; su HEAD histórico estaba divergido del main (53 ahead / 100 behind). No se integró su historia completa.

Rama limpia: `feat/mcp-ocp-p004-reconciled-20261111-7ab0c555`, portación inicial `6dda16a2fe9a5173f21ccdaaa23ba1ac9f9721c4`, creada desde `7ab0c555...`. Main actual `9fa37906373e0a9af01f4ccec5060d59b8194ccb` se integró mediante merge `d69bec6a9a56e3f5fb90bec6ce04fc7c56d86722` de dos padres, preservando los commits del frente EP.

Inventario REUSE/ADAPT/DROP/DEFER: [RECONCILIACION-20261111.md](RECONCILIACION-20261111.md). DUG v388/NX-388m y pin `3ba8e737... / 4db0ebad...` vigentes. SDK .NET 10.0.403; piloto net10.0 framework-dependent, sin RID.

Las suites y fuentes coinciden con blobs de una validación local histórica; build, tests y smoke no se han reejecutado en esta rama. No se reutiliza ZIP/manifest/checksums antiguos. No equivale a instalación EP ni aceptación E2E IPZ.


La sincronización más reciente incorpora main `1867af0c69f250aaee2b35b585eec8b74827b69c` por merge `d981953da84eaede38cb25649eb76b30a454a7ef`. La rama se revisa en [PR #28](https://github.com/SeryMente/metodologia/pull/28), abierta en DRAFT; no está fusionada. Build/tests/smoke y paquete actual permanecen pendientes.

## Validación nueva y paquete piloto · 2026-11-11

**Build source:** `4600086c492582c5d854145db64097310ac73686`; main base de build `1867af0c69f250aaee2b35b585eec8b74827b69c`; DUG v388/NX-388m, commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`, blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.

- .NET SDK 10.0.403; PowerShell 7.4.22; Windows x64; checkout y SDK aislados/temporales.
- Restore y builds: PASS; 0 warnings / 0 errors.
- P004: 18/18 PASS. Monitor/readiness: 23/23 PASS. Smoke STDIO/EOF: PASS.
- Paquete candidato: `entregas/piloto-sink-p004/MCP-OCP-SINK-P004-4600086c-candidate.zip`; 138.142 bytes; SHA-256 `50c0c68f769aefec95dfde3e45c74594d34b3fbcb25916814181fad241e8e3a6`.
- Extracción y cotejo de nueve archivos: PASS. Smoke sobre el ejecutable exacto extraído: PASS.
- Manifest, `VALIDATION-RECEIPT.json` y `SHA256SUMS.txt` acompañan el paquete; ver el informe [RECONCILIACION-20261111.md](RECONCILIACION-20261111.md).

**Límites:** candidato piloto P004, no release 1.0.0; GitHub-hosted CI NOT_VERIFIED; EP installation NOT_PERFORMED; EP-TASK-003/005 pendientes; runtime persistente Fila 4 NO VERIFICADO; IPZ E2E NOT_ACCEPTED; MCP-NORMATIVO DESACTIVADO.

La rama incorpora main `cb9b6a704bb18ccd219d847a48e810f22b4e2c3e` mediante merge `d1625f9345e54b90ac1ad884d4ee8476c78af491`; compare de cierre 34 ahead / 0 behind. PR #28 permanece OPEN/DRAFT/NOT MERGED.
