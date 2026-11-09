# GOV-TASK-015 · Sprint integrado Sink local vía RDC · Gobernanza / MCP-OCP / EP

**Estado:** `PLANIFICADO · NO_INICIADO`
**Tipo:** coordinación y aceptación de un único sprint; no crea un frente nuevo ni controles paralelos.
**Responsabilidad:** frente Gobernanza. Las tareas técnicas conservan sus OCP y fuentes.
**Fuente normativa:** Samantha v385 · NX-385m · Metacanon 1.29 · GOW 2.18.
**DUG:** commit `7dcdac6c62f9e8a27ce11f8fa0e4fc379a3d12f8`; blob `72cd2e8e4e6a594b300ba1868baeabc2472beb97`.
**MCP-OCP:** núcleo v0.1.22 al iniciar esta planificación; la revisión de sprint del núcleo y el backlog se documentan por separado.
**EP:** OEP v0.3.51 al iniciar esta planificación.
**Autorización:** el operador autorizó directamente Sink local por stdio en MCP-OCP. No se requiere aprobación de titularidad anterior, generación ni folio; dichos campos son auditoría, no compuertas.
**Alcance:** contrato, implementación Sink local, pruebas, paquete, handoff, bootstrap en perfil designado y aceptación E2E. Esta ficha es planificación: no acredita código, build, instalación ni prueba ejecutados.

## 1. Objetivo y contrato

Entregar el recorrido local:

`ChatGPT/IPZ → RDC → MCP-OCP por stdio → fuentes canónicas locales protegidas → respuesta validada`

| Referencia | Resultado obligatorio |
|---|---|
| `GOW:ARR` | Recuperar §ARR desde la fuente importada y verificada. |
| `DUG` | Verificar versión, firma, commit, Git blob SHA, SHA-256 y catálogo de 43 IDs/MDP. |
| `SINK:P001` … `SINK:P043` | Recuperar solo el texto desarrollado del ID solicitado, con ID, título, pin DUG y SHA-256 del contenido. |
| Lote | Conservar el orden solicitado y emitir resultado/huella/evento individual por ID exitoso. |
| Frecuencia | Un evento por recuperación completa y satisfactoria; una llamada fallida no cuenta como recuperación. |
| Manifiesto | Hash sobre serialización canónica UTF-8 del conjunto exacto y ordenado: IDs, versión/firma/commit/blob DUG y SHA-256 de cada texto. |
| Fallo | ID inexistente, fuente ausente/antigua, importación no verificada, desconexión o hash distinto ⇒ fallo cerrado. No sustituir con memoria ni MDP. |

El catálogo inicial expone IDs/MDP; el texto desarrollado se devuelve solo mediante una referencia Sink explícita. La recuperación de texto no activa un motor de evaluación normativa. `MCP-NORMATIVO` continúa DESACTIVADO.

## 2. Tareas provisionales por frente

### Frente 1 · Gobernanza

| Tarea | Estado leído | Trabajo en este sprint | Salida |
|---|---|---|---|
| [GOV-TASK-015](./README.md) | En curso | Coordinación maestra, dependencias, bloqueos y aceptación integrada. | Plan único, matriz actualizada y recibo de aceptación. |
| [GOV-TASK-008](../📁%20🧩%20-%20GOV-TASK-008%20-%20Aislamiento%20de%20capa%20desarrollada/README.md) | En curso | Contrato Sink, recuperación individual, frecuencia y manifiesto hash. | Contrato request/response, lote ordenado, evento y hash. |
| [GOV-TASK-001](../📁%20🧩%20-%20GOV-TASK-001%20-%20Validación%20de%20MDP/README.md) | En curso | Ejecutar matriz semántica de 43 MDP: 43 positivos y 8 controles negativos/frontera. | Resultados por caso, falsos positivos/negativos y mapeo etiqueta–ID–título. |
| [GOV-TASK-003](../📁%20🧩%20-%20GOV-TASK-003%20-%20Consulta%20privada%20E2E/README.md) | Pendiente | Aceptación funcional ChatGPT/IPZ → RDC → stdio → respuesta, con positivos y negativos. | Recibo E2E con pins, hashes, frecuencia y fallos cerrados. |
| [GOV-TASK-013](../📁%20🧩%20-%20GOV-TASK-013%20-%20Medición%20y%20optimización%20de%20ciclos/README.md) | En curso | Medir solo `ipz.resolve.rdc.duration_ms` con reloj monotónico y ambos extremos observables. | Registro mínimo; `NOT_MEASURED` si falta un extremo; línea base preliminar después de ≥10 muestras completas comparables. |
| [GOV-TASK-007](../📁%20🧩%20-%20GOV-TASK-007%20-%20IPZ%20y%20FOL1/README.md) | En curso | Preparar IPZ final ≤1.500 caracteres, instalar/read-back nativo en fase final; FOL1 solo después. | Texto medido, referencias locales verificadas, read-back nativo y gate FOL1 separado. |
| [GOV-TASK-009](../📁%20🧩%20-%20GOV-TASK-009%20-%20Revisión%20del%20glosario%20operativo/README.md) | En curso | Solo comprobar vocabulario §ARR y ausencia de colisiones de alias; no reabrir revisión general del GOW. | Mapeo `GOW:ARR` y alias verificados. |

GOV-TASK-010 ya contiene la corrección de admisión por instrucción directa y generaciones como auditoría. GOV-TASK-011 (DTC recurrente), GOV-TASK-012 (fluidez general), GOV-TASK-014 (Backblaze) y la incubación Tareas no son dependencias de ejecución de este sprint.

### Frente 2 · MCP-OCP

| Tarea | Orden | Trabajo ejecutable | Criterio de salida |
|---|---:|---|---|
| MCP-OCP-02 | 1 | Reconciliar código fuente remoto con `main` y pins actuales; comparar ramas `integration/ocp-mcp-0.1.0-selective-20261101` y `build/ocp-mcp-mvp-0.1.0`. | Base y diff identificados; código portado sobre `main`; manifiesto actual. |
| MCP-OCP-05 | 2 | Implementar/importar `GOW:ARR`, `DUG` y resolver Sink P001–P043; lote ordenado, evento de frecuencia por éxito. | Contrato de herramientas, respuesta exacta y fallo cerrado para fuente/hash/ID inválidos. |
| MCP-OCP-03 | 3 | Build fresco; pruebas unitarias, contrato, negativas, integración stdio, secretos, shutdown, hash y root de datos protegido. | Build reproducible con DUG v385/core vigente; suites actuales PASS. No reutilizar 50/30/200 históricos. |
| MCP-OCP-04 | 4 | Probar `initialize`, `tools/list`, `tools/call`, respuesta completa, desconexión y reinicio por el mismo canal RDC de uso. | Smoke real bridge RDC/stdio; sin listener, URL pública, túnel ni regla de firewall. |
| MCP-OCP-10 | 5 | Congelar fuentes, commits, Git blob SHA, SHA-256, SDK/RID, tests, manifiestos y limitaciones. | Recibo/manifiesto actuales con read-back. |
| MCP-OCP-07 | 6 | Empaquetar ZIP nuevo; verificar extracción, hashes, launcher y runbook. | Paquete vigente recuperable y verificado; no presentar la candidata 0.1.0 histórica como disponible. |
| MCP-OCP-12 | 7 | Bootstrap local: extracción, import-sources desde checkout fijado y provisión del operador. | `operator_provisioned=true` y fuentes importadas; consentimiento local interactivo. |
| MCP-OCP-08 | 8 | Handoff al frente EP para instalación/aceptación en almacenamiento protegido. | EP acepta paquete/hash, ruta, perfil, root de datos, launcher, rollback y prueba local. |

Fuera del sprint: MCP-OCP-06/11 (Jules, permanece pausado) y MCP-OCP-09 (PPR/restauración cross-host, P2). Tampoco entran B2, Khora, HTTP público ni activación de MCP-NORMATIVO.

### Frente 3 · Entorno Persistente (EP)

| Tarea | Estado leído | Trabajo de este sprint | Condición |
|---|---|---|---|
| [EP-TASK-003](../../ep/📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md) | En curso | Migrar workspace a W: con manifiesto SHA-256 de 195 archivos/11 directorios, cambio de montaje y segundo read-back. Dead-man solo si el destino final es LOC-OTHER. | Árbol completo en volumen protegido; origen intacto hasta cotejo íntegro; dead-man probado cuando aplique. |
| [EP-TASK-005](../../ep/📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-005%20-%20Instalación%20y%20aceptación%20de%20MCP-OCP%20local/README.md) | Nueva · Pendiente | Instalar/bootstrap en el perfil Windows designado; root de datos cifrado, autenticación local si se requiere y prueba stdio/RDC. | Paquete/hash, fuentes importadas, `REGISTER <SID>` local, `operator_provisioned=true`, health/tools/call y E2E PASS. |
| EP-TASK-004 | En curso · independiente | Reconstrucción/aceptación de la GUI de bóveda. | No bloquea build Sink ni bootstrap DPAPI salvo dependencia técnica demostrada. |

EP-TASK-002 (Backblaze), EP-TASK-001 (NCL) y PPR cross-host no forman parte del camino crítico.

## 3. Secuencia optimizada

| Fase | Actividad | Puede avanzar sin host | Gate para pasar |
|---|---|---|---|
| 0 · Plan/preflight | Contrato, tareas, fuente remota, pins y bloqueos. | Sí. | Matriz vigente; host final requerido para fase EP. |
| 1 · Reconciliar | Comparar rama remota con `main`; fijar DUG v385 y core vigente. | Sí. | Diff revisado, branch reproducible y manifest actual. |
| 2 · Corte vertical | Implementar/probar `GOW:ARR`, `DUG` y `SINK:P004`; validar transporte RDC/stdio real. | Código/tests sí; E2E host no. | Primer recorrido completo y hash correcto. No generalizar 43 IDs hasta PASS. |
| 3 · Generalizar | Implementar P001–P043, lote ordenado, frecuencia individual y manifiesto canónico. | Sí. | 43 IDs exactos, positivos/negativos y hash por texto. |
| 4 · Build/package | Suite fresca, ZIP, manifiestos, recibo y runbook. | Sí, en entorno de build autorizado. | Tests actuales PASS y read-back del paquete. |
| 5 · Preparar EP | Descubrir host/perfil en vivo; migrar workspace a W:; fijar data-root cifrado; dead-man si LOC-OTHER. | Diseño sí; operación host requiere capacidad RDC. | Root/runtime protegido y preflight aceptado. |
| 6 · Bootstrap/handoff | Importar fuentes, `provision-operator`, `REGISTER <SID>` y configurar stdio. | No. | Consentimiento local interactivo y fuentes actuales importadas. |
| 7 · E2E/cierre | GOV-TASK-003, medición GOV-TASK-013, recibo, IPZ/read-back; FOL1 posterior. | No para prueba completa. | E2E PASS; IPZ nativa verificada; gate FOL1 separado. |

Se usará un único harness: primero corte vertical P004; después el mismo harness para 43 IDs y negativos. Un build final, un manifiesto de fuentes y un recibo. Frecuencia y latencia no se mezclan.

## 4. Bloqueos y mitigación

| Bloqueo | Evidencia disponible al planificar | Tratamiento |
|---|---|---|
| Código productivo no está en `main` | Hay código C# en ramas remotas; el ZIP 0.1.0 usa pins v377/core v0.1.20 y no está en el repo. | Reconciliar y portar fuente; no recuperar binario ni depender de una terminal histórica. |
| Sink no implementado | El catálogo actual identifica 43 IDs/MDP; el resolver de texto individual no está desplegado en main. | Implementar Sink explícito; no inferir applicability/dependencies faltantes. |
| Root de datos fuera del perímetro cifrado | El código candidato usa `%LOCALAPPDATA%\SeryMente\OCP MCP` por defecto; W: es el volumen protegido. | Añadir root configurable y validado hacia W:, o demostrar cifrado completo del volumen del perfil. Sin esto no instalar persistente. |
| Workspace no migrado | Última evidencia: 195 archivos/11 directorios en staging; W: cifrado pero sin copia, manifest de destino ni segundo read-back. | EP-TASK-003; preservar original hasta read-back íntegro. |
| Capacidad RDC agotada | Última evidencia reportó `remote_calls_left_pct=0`. | Reanudar cuando herramienta disponga de capacidad; no eludir cuota. |
| Host/ubicación no designados | No hay preflight vigente del destino final de instalación para este sprint. | Una sola selección del operador; descubrimiento y preflight en vivo. Si LOC-OTHER, dead-man antes del runtime persistente. |
| Transporte real ChatGPT→RDC→stdio | Hubo smoke JSON-RPC manual en root temporal; no demuestra bridge de uso final. | Corte vertical P004 por el mismo camino de uso antes de generalizar. |
| Autenticación GitHub local | Conector GitHub de ChatGPT está autenticado; el token no se transfiere al perfil Windows. | Verificar `gh auth status` en el perfil final; si falta, login web interactivo local. |
| Provisión del operador | El build histórico no creó trust root en perfil real. | `provision-operator` + `REGISTER <SID>` local, con operador presente; no automatizar ni registrar SID en Git. |
| Metadatos normativos incompletos | Fuente no declara campos de aplicabilidad/activación. | Mantener `MCP-NORMATIVO=DESACTIVADO`; Sink devuelve texto solicitado y trazable, no dictamen. |

## 5. Insumos del operador

**Una decisión necesaria para la fase de instalación:** designar qué equipo y perfil Windows serán el destino definitivo y confirmar si la ubicación es `LOC-CECEQ` o `LOC-OTHER`. No reutilizar nombres/IDs de dispositivos ni perfiles históricos; el preflight será en vivo al iniciar esa fase.

Acciones locales futuras, sin enviar secretos por chat:

- Si el perfil destino no está autenticado para el repositorio privado, el operador realiza `gh auth login --web` en esa misma sesión Windows; el token permanece en el almacén local.
- El operador ejecuta `provision-operator` y confirma `REGISTER <SID>` en la consola local cuando el paquete y la ruta de datos estén verificados.
- El RecoveryPassword vigente ya aparece custodiado y leído de vuelta en EP Vault; no se solicita volver a copiarlo ni publicarlo.

No son insumos por ahora: contraseña, token, SID, RecoveryPassword, B2, OAuth Jules, Cloudflare, DNS, Vercel, GitHub Actions ni nuevas generaciones/folios.

## 6. Aceptación integral

1. GOW:ARR y DUG se recuperan desde fuentes importadas, con identidad/procedencia/hash verificados.
2. Los 43 SINK:Pxxx devuelven exactamente su texto desarrollado y hash; sin sustitución por memoria ni MDP.
3. Batch conserva orden, resultados y evento de frecuencia individual por recuperación exitosa.
4. Manifiesto canónico coincide con el contenido exacto y su SHA-256.
5. Matriz semántica GOV-TASK-001 y suite MCP cubren positivos, negativos, obsolescencia, desconexión y corrupción.
6. Round-trip real ChatGPT/RDC/stdio probado; latencia solo se acepta con ambos extremos observables.
7. DB, backups y runtime en almacenamiento protegido; provisión local verificada.
8. E2E Gobernanza PASS con evidencia y read-back.
9. IPZ final instalada/leída de vuelta antes de evaluar FOL1 en gate independiente.
10. MCP-NORMATIVO desactivado; sin endpoints públicos ni secretos en repo/logs/salida.

## 7. Estado de planificación

- **Autorización Sink:** directa del operador y vigente.
- **Implementación Sink en main:** NO IMPLEMENTADA.
- **Código fuente candidato:** recuperable desde ramas remotas; requiere reconciliación con main y pins actuales.
- **Build/paquete vigente:** NO GENERADO.
- **Workspace protegido:** W: cifrado y recovery custodiado; migración del árbol pendiente.
- **Instalación/Bootstrap EP:** NO INICIADOS.
- **E2E:** NO EJECUTADA.
- **IPZ nativa/FOL1:** pendientes; MCP-NORMATIVO sigue desactivado.

**Siguiente transición:** designar equipo/perfil Windows final y ubicación. En paralelo, Gobernanza puede cerrar el contrato de aceptación y MCP-OCP puede reconciliar código remoto sin tocar un host.
