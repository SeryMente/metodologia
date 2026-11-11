# Reconciliación del piloto SINK:P004 sobre main vigente

**Fecha:** 2026-11-11  
**Frente:** MCP-OCP  
**Rama limpia:** `feat/mcp-ocp-p004-reconciled-20261111-87c007e9`  
**Base exacta:** `87c007e9bd4a79ee3ec379abd1d701047f3cc974`  
**Commit de portación selectiva:** `528f6de6482a079d3e9f884278f066cc81f9345c`  
**Estado:** PORTACIÓN SELECTIVA PERSISTIDA · BUILD DE ESTA RAMA PENDIENTE

## 1. Fuente y autoridad

- El OCP se mantiene en `SeryMente/metodologia/frentes/mcp-metodologia/`.
- DUG vigente verificado desde `main`: Samantha v388 · NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob Git `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
- Metacanon 1.29; GOW 2.18; GOW:ARR = `gow-sec-14`; inventario = 43 principios.
- P004: `Principio de No-Simulación`, ancla `#P004`, categoría CNP A/0.8. El texto y MDP del pin coinciden literalmente con `gov-data` del DUG.
- `MCP-NORMATIVO` continúa `DESACTIVADO`.
- El control autoritativo conserva MCP-OCP como titularidad `owned`, generación 6. La portación no modifica el control ni amplía la autorización.

## 2. Diagnóstico de la candidata histórica

La PR #27 se conserva como fuente de lectura, no como base de integración. Frente al HEAD de `main` de esta reconciliación, su HEAD `5cc59b708c1d5894e7dbfd2a724504fdf5b92974` presenta estado `diverged`: 53 commits ahead y 95 behind; merge-base `f8a5880f1cbf432754157b5669d1f9e80177766f`. Por ello no se hizo merge, rebase ni cherry-pick de la rama histórica.

La rama nueva parte directamente del HEAD de `main` `87c007e9bd4a79ee3ec379abd1d701047f3cc974`. Su primer commit tiene ese único padre y añadió 19 archivos, todos bajo `frentes/mcp-metodologia/`.

## 3. Inventario REUSE / ADAPT / DROP / DEFER

| Decisión | Elementos | Tratamiento |
|---|---|---|
| REUSE | `src/OcpMcp/` (lector DUG, servidor MCP, programa, pin y proyecto) | Se portan los blobs de la candidata sin modificación. |
| REUSE | `src/OcpMcp.Monitoring/` y sus pruebas | Se conserva la biblioteca de proyección/readiness usada por el servidor y su suite. No se declara instalación ni operación en EP. |
| REUSE | `tests/OcpMcp.Pilot.Tests/`, `tests/OcpMcp.Monitoring.Tests/` | Se portan los proyectos y fuentes de pruebas. Hay 18 casos P004 y 23 de monitor/readiness registrados en la suite. |
| REUSE | `global.json` y `piloto-sink/ci/Invoke-PilotValidation.ps1` | SDK fijado en 10.0.403 y harness reproducible de restore/build/pruebas/smoke STDIO. |
| ADAPT | `piloto-sink/README.md`, `piloto-sink/SOURCE-PIN.json` | Se actualizan base y nombre de rama; se conserva el pin normativo DUG v388, que sigue coincidiendo con main. |
| ADAPT | `piloto-sink/PORTABILITY-DECISIONS.md` | Se conserva como decisión de portabilidad del piloto; esta reconciliación prevalece para la base y el estado actual de rama. |
| ADAPT / REGENERAR | Runbook, manifest, checksums y paquete ZIP que figuraban en `entregas/piloto-sink-p004/` | No se copian los binarios ni sus checksums históricos. Se volverán a producir después de validar el commit de esta rama y se comprobarán por read-back. |
| DROP | `.github/workflows/mcp-ocp-p004-pilot.yml` de la candidata | No se porta: está fuera de `frentes/mcp-metodologia/` y no es requisito para el piloto local autorizado. No se afirma CI nuevo. |
| DROP | Copias de `LISTA-TAREAS-PROVISIONAL.md`, `MCP-METODOLOGIA.md` y `OPERACION-LOCAL-MCP-OCP.md` provenientes de la candidata | No se sustituyen las fuentes vigentes de `main` con snapshots de una rama divergida. Se actualizarán en esta rama desde la base canónica y con este delta explícito. |
| DROP | `conversaciones/CONTINUIDAD-2026-11-10-ULTIMO-TRAMO.md` | Es una continuidad histórica de la rama anterior, no una dependencia de código ni fuente de estado vigente. |
| DEFER | `persistencia/MCP-OCP-14-CONTRATO.md`, cuatro JSON Schemas, suite y evidencia H2/H3 | Se mantienen fuera de este corte P004. MCP-OCP-14 sigue propuesto y no aceptado; se retoma por separado, sin runtime, DB, B2, Vault ni restore. |

## 4. Contrato técnico portado

El servidor es local y usa MCP JSON-RPC sobre STDIO. El piloto expone únicamente `sink_principle` con `principle_id=P004`; reserva STDOUT para protocolo y emite eventos/diagnósticos saneados por STDERR. No levanta listener, túnel ni endpoint público.

El lector:
- verifica el Git blob SHA del DUG fijado y UTF-8 estricto;
- comprueba identidad/versiones del DUG, GOW:ARR, autoridad y el inventario exacto de 43 IDs;
- valida el marcador humano, título, ancla, texto desarrollado, MDP y preponderancia de P004;
- exige que MCP-NORMATIVO permanezca DESACTIVADO;
- falla cerrado ante fuente ausente, alterada, obsoleta o metadatos incompatibles; no sustituye la capa 2 con memoria ni MDP;
- entrega procedencia y SHA-256 de la fuente y del texto recuperado.

El pin de código `SourcePin.Current` apunta al commit DUG `3ba8e737...` y al blob `4db0ebad...`, ambos cotejados contra el DUG actual de `main`.

## 5. SDK, runtime y RID

- `global.json` fija .NET SDK `10.0.403`.
- El piloto usa `net10.0`, modo framework-dependent; no fija RID para el piloto.
- El runtime requerido en destino es Microsoft.NETCore.App 10.0.x x64. Su presencia en Fila 4 no está verificada.
- `win-x64` self-contained corresponde al objetivo de release final, no al artefacto piloto ni a una instalación autorizada en este ciclo.

## 6. Evidencia y límites de validación

Los siguientes siete blobs de lector, servidor, programa, pin, pruebas P004, pruebas de monitor y harness coinciden exactamente entre la candidata actual `5cc59b7...` y el commit local de build histórico `b6ce37af1dc32b2e3bb8af3ded2a77c7ba6d7648`:

| Archivo | Git blob |
|---|---|
| `src/OcpMcp/DugSourceReader.cs` | `294116597fdb281ca1e4e8bf2d9a5e2e94234af3` |
| `src/OcpMcp/McpServer.cs` | `0b116f82edb2fe60fa2351c12f7b6c7850e146e8` |
| `src/OcpMcp/Program.cs` | `d8da368553bce9232583c5784be92fa9b32879d4` |
| `src/OcpMcp/SourcePin.cs` | `a99dcd448724256de238da0e312d12f0d96e4152` |
| `tests/OcpMcp.Pilot.Tests/Program.cs` | `0f55f3ac1ceb51fdb9f70f3780efba0db565436f` |
| `tests/OcpMcp.Monitoring.Tests/Program.cs` | `6c3fb803f8174f2d805f5a5e84bd3a809d575413` |
| `piloto-sink/ci/Invoke-PilotValidation.ps1` | `08711ffd6d98601196936411666885750dee0772` |

La crónica anterior registra ejecución local en Windows/.NET SDK 10.0.403: restore y builds PASS, P004 18/18, monitor/readiness 23/23, smoke STDIO/EOF PASS, cero warnings/errors. También registra un package smoke sobre el paquete histórico. La igualdad de blobs permite identificar esos mismos contenidos fuente; **no equivale a haber ejecutado el build de la nueva rama**.

En esta sesión no están disponibles `dotnet` ni `pwsh`; por tanto:
- `NEW_BRANCH_BUILD = NOT_RUN`;
- `NEW_BRANCH_TESTS = NOT_RUN`;
- `NEW_BRANCH_PACKAGE = NOT_REGENERATED`;
- GitHub-hosted CI = `NOT_VERIFIED` (los jobs históricos terminaban sin runner, steps ni logs observables).

No se copia ni se presenta el ZIP de la rama histórica como paquete de esta rama. La próxima validación deberá ejecutarse en un entorno con .NET SDK 10.0.403 y PowerShell 7.4+, registrar el recibo ligado al commit de esta rama y regenerar manifest, ZIP, SHA-256 y smoke.

## 7. Dependencias y límites pendientes

1. Ejecutar restore, builds, 18 pruebas P004, 23 de monitor y smoke STDIO/EOF sobre el commit reconciliado.
2. Generar paquete piloto nuevo, cotejar todos los archivos contra el manifest y verificar el binario exacto por read-back.
3. Mantener handoff/instalación bloqueados hasta los gates EP-TASK-003 y EP-TASK-005; el runtime de destino sigue NO VERIFICADO.
4. La aceptación IPZ E2E corresponde a Gobernanza y requiere respuesta visible desde el contexto IPZ, no solo un smoke de consola.
5. Mantener MCP-NORMATIVO DESACTIVADO y FOL1 PREPARADO_PENDIENTE_ACTIVACION_IPZ.

No se modificó DUG, ART-025, ART-027, IPZ, Khora, EP, B2, Vault ni producción. Esta reconciliación no autoriza merge, instalación ni despliegue.
