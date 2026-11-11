# Reconciliación selectiva del piloto SINK:P004

**Fecha:** 2026-11-11 · **Frente:** MCP-OCP  
**Rama:** `feat/mcp-ocp-p004-reconciled-20261111-7ab0c555`  
**Base inicial:** `7ab0c555b774adc5b930aad700f101ab2660b79a`  
**Commit portación:** `6dda16a2fe9a5173f21ccdaaa23ba1ac9f9721c4`  
**Main actual incorporado:** `9fa37906373e0a9af01f4ccec5060d59b8194ccb`  
**Última sincronización:** `d69bec6a9a56e3f5fb90bec6ce04fc7c56d86722`  
**Estado:** PORTACIÓN SELECTIVA PERSISTIDA · BUILD/PRUEBAS NUEVAS PENDIENTES

## 1. Fuente y autoridad

- OCP propietario: `SeryMente/metodologia/frentes/mcp-metodologia/`.
- Control MCP-OCP `owned`, generación 6; se conserva sin cambios por esta portación.
- DUG Samantha v388/NX-388m; Metacanon 1.29; GOW 2.18. Commit DUG `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
- GOW:ARR `gow-sec-14`, ancla `#gow-arranque-chatgpt`, función de entrada presente.
- P004 = Principio de No-Simulación, CNP A/0.8; texto y MDP del pin cotejados con el DUG.
- MCP-NORMATIVO permanece DESACTIVADO.

## 2. PR #27 y base

PR #27 permanece abierta, draft y sin merge. Su HEAD `5cc59b708c1d5894e7dbfd2a724504fdf5b92974` frente al main `7ab0c555...` estaba divergido: 53 ahead / 100 behind; merge-base `f8a5880f1cbf432754157b5669d1f9e80177766f`. No se integró su historia completa.

La rama actual nació de `7ab0c555...`. Los commits posteriores de main eran exclusivamente EP y se incorporaron con merges de dos padres:
- `a33308a3527516dd2427d0cfa73b5d30402afbc6` (main `cefcf63d...`).
- `85902f86a13cb809c38a9cf6b288b1ece08cccc9` (main `07e51261...`).
- `d69bec6a9a56e3f5fb90bec6ce04fc7c56d86722` (main `9fa37906...`).

La comparación tras la última sincronización dejó la rama AHEAD y 0 detrás.

## 3. Inventario REUSE / ADAPT / DROP / DEFER

| Decisión | Elementos | Tratamiento |
|---|---|---|
| REUSE | `src/OcpMcp/` | Lector DUG, servidor STDIO, Program, pin y proyecto portados. |
| REUSE | `src/OcpMcp.Monitoring/` | Modelos, writer, reader, readiness y proyecto conservados. |
| REUSE | Dos proyectos de tests | 18 casos P004 y 23 de monitor/readiness. |
| REUSE | `global.json`, harness PowerShell | SDK 10.0.403 y script de restore/build/tests/smoke. |
| ADAPT | README, SOURCE-PIN, decisiones de portabilidad | Alinear rama/base y diferenciar evidencia histórica de validación nueva. |
| ADAPT / REGENERAR | ZIP, manifest, SHA sums, runbook | No copiar paquete ni checksums históricos; regenerar tras validar esta rama. |
| DROP | Workflow `.github/workflows/mcp-ocp-p004-pilot.yml` | Fuera de `frentes/mcp-metodologia/`; no se afirma CI nuevo. |
| DROP | Snapshots core/backlog de PR #27 | Se conservan fuentes de main y se actualizan desde su revisión vigente. |
| DEFER | MCP-OCP-14, schemas, fixtures H2/H3 | Propuesta separada; no se mezcla con P004 ni implica runtime, DB, B2 o Vault. |

## 4. Contrato técnico

El piloto expone solo `sink_principle(principle_id=P004)` por JSON-RPC/MCP STDIO. STDOUT queda reservado al protocolo; eventos saneados por STDERR. No crea listeners, túneles ni endpoints públicos.

El lector verifica Git blob SHA, UTF-8, identidad/versiones DUG, fuente canónica, §ARR, estado MCP-NORMATIVO, autoridad, inventario de 43 IDs, marcador humano P004, título, ancla, texto íntegro, MDP y preponderancia. Falla cerrado ante fuente ausente, obsoleta, alterada o incompatible.

## 5. SDK / runtime

- .NET SDK 10.0.403 fijado por `global.json`.
- Piloto `net10.0`, framework-dependent, sin RID.
- Microsoft.NETCore.App 10.0.x x64 en Fila 4: NO VERIFICADO.
- `win-x64` self-contained corresponde al release final, no a este piloto.

## 6. Evidencia y límites

Los blobs de lector, servidor, Program, pin, tests P004, tests monitor y harness coinciden con el contenido usado en la validación local histórica del commit `b6ce37af1dc32b2e3bb8af3ded2a77c7ba6d7648`. La crónica anterior informa Windows/.NET 10.0.403, restore/build PASS, 18/18 P004, 23/23 monitor/readiness y smoke STDIO/EOF PASS. La igualdad de blobs rastrea esos mismos contenidos, pero **no demuestra una ejecución nueva en esta rama**.

En este entorno `dotnet` y `pwsh` no están disponibles:
- `NEW_BRANCH_BUILD=NOT_RUN`
- `NEW_BRANCH_TESTS=NOT_RUN`
- `NEW_BRANCH_SMOKE=NOT_RUN`
- `NEW_PACKAGE=NOT_REGENERATED`
- `HOSTED_CI=NOT_VERIFIED`

No se reutilizaron ZIP, manifest ni hashes de la candidata histórica. Se deben regenerar tras ejecutar el harness en un entorno con SDK 10.0.403 y PowerShell 7.4+, con extracción, read-back y smoke sobre el binario exacto.

## 7. Bloqueos y límites

1. Ejecutar restore/build, 18 pruebas P004, 23 monitor/readiness y smoke STDIO/EOF; emitir recibo ligado al commit.
2. Regenerar manifest, ZIP, SHA sums y runbook; verificar por read-back.
3. Mantener instalación/handoff bloqueados hasta EP-TASK-003 PASS y recepción EP-TASK-005.
4. La aceptación IPZ E2E corresponde a Gobernanza y exige respuesta visible desde contexto IPZ; el smoke de consola no la sustituye.
5. Generalización P001–P043/lotes, panel 1.0.0 y MCP-OCP-14 quedan como etapas posteriores/separadas.

No se modificó DUG, ART-025, ART-027, IPZ, Khora, EP, B2, Vault, credenciales, host ni producción. No se autoriza merge, instalación o despliegue por esta reconciliación.

## 8. Sincronización final y revisión · 2026-11-11

Después del primer registro se incorporó el commit de main `1867af0c69f250aaee2b35b585eec8b74827b69c` (actualización de coordinación del frente EP) mediante merge de dos padres `d981953da84eaede38cb25649eb76b30a454a7ef`, preservando el árbol de MCP-OCP y cotejando el blob EP resultante con main. El compare inmediato dio 0 commits detrás.

La rama se publicó para revisión en [PR #28](https://github.com/SeryMente/metodologia/pull/28): `OPEN / DRAFT / NOT MERGED`, 23 archivos, 16 commits ahead / 0 behind en la apertura; GitHub informó `mergeable=true`. PR #27 sigue abierta/draft como antecedente divergente y no integrado.

Los estados de build, tests, smoke y paquete de la rama actual permanecen `NOT_RUN / NOT_REGENERATED`; la apertura de una PR no los convierte en PASS ni en aceptación.
