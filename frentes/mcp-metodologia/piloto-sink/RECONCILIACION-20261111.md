# Reconciliación selectiva del piloto SINK:P004

**Fecha:** 2026-11-11  
**Frente:** MCP-OCP  
**Rama:** `feat/mcp-ocp-p004-reconciled-20261111-7ab0c555`  
**HEAD de main incorporado:** `cefcf63d6ddc4b82f9fdbd3a6ce3366efc030f48`  
**Commit de reconciliación:** `a33308a3527516dd2427d0cfa73b5d30402afbc6`  
**Commit de portación:** `6dda16a2fe9a5173f21ccdaaa23ba1ac9f9721c4`  
**Estado:** PORTACIÓN SELECTIVA PERSISTIDA · VALIDACIÓN NUEVA PENDIENTE

## 1. Fuente y control

- Repositorio y ruta propietaria: `SeryMente/metodologia/frentes/mcp-metodologia/`.
- Titularidad MCP-OCP `owned`, generación 6; se conserva el control y el alcance autorizado. Esta rama no toca `CONTROL-RESPONSABILIDAD.json`.
- DUG Samantha v388 / NX-388m; Metacanon 1.29; GOW 2.18. DUG commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`, blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
- GOW:ARR = `gow-sec-14`, ancla `#gow-arranque-chatgpt`, con `### Función de entrada`.
- P004 = `Principio de No-Simulación`, categoría CNP A/0.8. El texto y MDP del pin coinciden con `gov-data` del DUG.
- `MCP-NORMATIVO` permanece `DESACTIVADO`.

## 2. Diagnóstico de PR #27

PR #27 se mantiene abierta, en borrador y sin merge. Su HEAD `5cc59b708c1d5894e7dbfd2a724504fdf5b92974` no es una base válida: contra main `7ab0c555b774adc5b930aad700f101ab2660b79a` se encontraba divergida (53 ahead / 100 behind; merge-base `f8a5880f1cbf432754157b5669d1f9e80177766f`). No se integró la historia completa de esa rama.

La nueva rama se creó desde main `7ab0c555...` y después incorporó los dos commits posteriores de main mediante merge de dos padres. El HEAD resultante de main incorporado es `cefcf63d6ddc4b82f9fdbd3a6ce3366efc030f48`; ese delta afectaba únicamente entregas del frente EP y se conservó íntegro.

## 3. Inventario REUSE / ADAPT / DROP / DEFER

| Decisión | Componentes | Tratamiento |
|---|---|---|
| REUSE | `src/OcpMcp/` (lector DUG, servidor MCP STDIO, Program, SourcePin y csproj) | Se portan los blobs funcionales de la candidata. |
| REUSE | `src/OcpMcp.Monitoring/` y csproj | Se conserva la proyección/readiness del monitor. No se declara instalación u operación EP. |
| REUSE | Proyectos y fuentes de `tests/OcpMcp.Pilot.Tests/` y `tests/OcpMcp.Monitoring.Tests/` | Suites de 18 casos P004 y 23 casos monitor/readiness, respectivamente. |
| REUSE | `global.json` y `piloto-sink/ci/Invoke-PilotValidation.ps1` | SDK fijado 10.0.403 y harness de restore/build/tests/smoke STDIO/EOF. |
| ADAPT | `piloto-sink/README.md`, `SOURCE-PIN.json`, `PORTABILITY-DECISIONS.md` | Ajustar rama/base y diferenciar evidencia histórica de la validación pendiente de esta rama. |
| ADAPT / REGENERAR | ZIP, manifest, SHA sums y runbook de `entregas/piloto-sink-p004/` | No se copian artefactos binarios ni sumas viejas. Se generarán después de validar este commit y se leerán de vuelta. |
| DROP | Workflow `.github/workflows/mcp-ocp-p004-pilot.yml` de la candidata | Está fuera de `frentes/mcp-metodologia/` y no se requiere para este corte local. No se afirma CI nuevo. |
| DROP | Copias de core, backlog y operación local provenientes de PR #27 | No se sustituyen fuentes vigentes de main por snapshots de rama divergida. Se actualizan directamente en esta rama después de revalidar main. |
| DROP | Continuidad de conversación de la rama histórica | No es dependencia de código ni fuente de estado vigente. |
| DEFER | Contrato MCP-OCP-14, cuatro schemas y fixtures H2/H3 | Permanece como propuesta separada; no se incluye en el corte P004 ni implica runtime, DB, B2, Vault o restore. |

## 4. Contrato técnico conservado

El piloto expone únicamente `sink_principle(principle_id=P004)` por JSON-RPC/MCP sobre STDIO. STDOUT queda reservado al protocolo; los eventos y diagnósticos saneados van por STDERR. No levanta listeners, túneles ni endpoints públicos.

El lector exige el DUG fijado y comprueba Git blob SHA, UTF-8, versión/firma/evento, fuente canónica, §ARR, estado MCP-NORMATIVO, autoridad, catálogo exacto de 43 IDs, marcador humano P004, título, ancla, texto íntegro, MDP y preponderancia. La operación falla cerrada ante fuente ausente, obsoleta, alterada o no coincidente; no sustituye la capa 2 por memoria ni por MDP.

## 5. SDK / runtime

- SDK fijado: .NET 10.0.403 (`global.json`).
- Piloto: `net10.0`, framework-dependent y sin RID.
- Requiere Microsoft.NETCore.App 10.0.x x64 en el destino; disponibilidad en Fila 4 = NO VERIFICADA.
- `win-x64` self-contained es objetivo del release final, no este piloto.

## 6. Evidencia y límites

Los blobs de lector, servidor, programa, pin, pruebas P004, pruebas monitor y harness coinciden exactamente con los usados en la validación local histórica del commit `b6ce37af1dc32b2e3bb8af3ded2a77c7ba6d7648`:

| Archivo | Git blob |
|---|---|
| `src/OcpMcp/DugSourceReader.cs` | `294116597fdb281ca1e4e8bf2d9a5e2e94234af3` |
| `src/OcpMcp/McpServer.cs` | `0b116f82edb2fe60fa2351c12f7b6c7850e146e8` |
| `src/OcpMcp/Program.cs` | `d8da368553bce9232583c5784be92fa9b32879d4` |
| `src/OcpMcp/SourcePin.cs` | `a99dcd448724256de238da0e312d12f0d96e4152` |
| `tests/OcpMcp.Pilot.Tests/Program.cs` | `0f55f3ac1ceb51fdb9f70f3780efba0db565436f` |
| `tests/OcpMcp.Monitoring.Tests/Program.cs` | `6c3fb803f8174f2d805f5a5e84bd3a809d575413` |
| `piloto-sink/ci/Invoke-PilotValidation.ps1` | `08711ffd6d98601196936411666885750dee0772` |

La evidencia histórica registrada en el ciclo local previo informa Windows/.NET SDK 10.0.403, restore/build PASS, 18/18 P004, 23/23 monitor/readiness y smoke STDIO/EOF PASS. La igualdad de blobs permite rastrear esa evidencia a los mismos contenidos fuente, **pero no acredita una ejecución nueva en la rama reconciliada**.

En este entorno no están disponibles `dotnet` ni `pwsh`:
- `NEW_BRANCH_BUILD=NOT_RUN`
- `NEW_BRANCH_TESTS=NOT_RUN`
- `NEW_BRANCH_SMOKE=NOT_RUN`
- `NEW_PACKAGE=NOT_REGENERATED`
- `HOSTED_CI=NOT_VERIFIED`

Por ello, no se copió el ZIP histórico, no se reutilizaron sus hashes ni se declaró build/test actual PASS. El paquete debe regenerarse tras ejecutar el harness sobre la rama actual, con manifest/SHA y read-back del binario exacto.

## 7. Bloqueos y límites

1. Ejecutar restore/build, 18 pruebas P004, 23 monitor/readiness y smoke STDIO/EOF en un entorno con .NET SDK 10.0.403 y PowerShell 7.4+; ligar recibo al commit de esta rama.
2. Regenerar manifest, ZIP, SHA sums y runbook; cotejar la extracción y el binario exacto.
3. Mantener instalación/handoff bloqueados hasta EP-TASK-003 PASS y recepción EP-TASK-005.
4. La aceptación IPZ E2E corresponde a Gobernanza y requiere respuesta visible desde contexto IPZ; el smoke de consola no la sustituye.
5. Generalización P001–P043/lotes, panel 1.0.0 y MCP-OCP-14 siguen fases posteriores.

No se modificó DUG, ART-025, ART-027, IPZ, Khora, EP, B2, Vault, credenciales, host ni producción. Esta reconciliación no autoriza merge, instalación ni despliegue.
