# C-GOBERNANZA-IPZ-RDC-SINK-01 — Armonización del IPZ con Sink local vía RDC

**Fecha:** 2026-11-09  
**Frente responsable:** Gobernanza · generación 17  
**Sesión:** `SES-20261108-506DCF0C`  
**UUIDv7 local de sesión:** `01a1bc38-78e0-74e5-92ca-8d28506dcf0c`  
**Folio global:** PENDIENTE / NO ASIGNADO · FOL1 no activo.

## Instrucción y decisión

El operador aprobó el uso de Sink local mediante conexión RDC y autorizó armonizar ART-025 y GOV-TASK-003/007/008 para utilizar referencias operativas locales en lugar de enlaces HTTP acortados.

**Contrato aprobado:**
- `GOW:ARR`: recuperar §ARR.
- `DUG`: verificar fuente normativa completa, versión y procedencia.
- `SINK:P001` … `SINK:P043`: recuperar individualmente el texto desarrollado pertinente mediante RDC → MCP-OCP local por stdio.

Los identificadores no son URLs ni credenciales. No se necesita resolvedor HTTP, listener, túnel, Cloudflare ni GitHub Actions por consulta. El DUG sigue siendo la única fuente normativa; el almacén local es una proyección cifrada y derivada.

## Alcance documental ejecutado en Gobernanza

1. ART-025 se armonizó con el contrato de referencias locales, consulta individual, pin de fuente, manifiesto ordenado y separación de telemetría de frecuencia frente a latencia.
2. GOV-TASK-003 recibió criterios E2E para RDC/stdio, consulta exacta por principio, frecuencia por recuperación satisfactoria, hash del manifiesto y fail-closed.
3. GOV-TASK-007 recibió la secuencia `GOW:ARR` → `DUG` y el contrato para crear IPZ menor a 1.500 caracteres preservando las salvaguardas de v0.7.
4. GOV-TASK-008 resolvió la entrega de capa 2 mediante Sink local y mantuvo desactivada la selección normativa automática mientras falten metadatos canónicos.
5. GOV-TASK-009 y GOV-TASK-010 recibieron una alineación limitada de sus referencias, sin ampliar su alcance funcional.
6. GOV-TASK-013 ya contiene la métrica secundaria `ipz.resolve.rdc.duration_ms`: inicio predespacho, fin al recibir/validar mínimamente la respuesta, reloj monotónico y `NOT_MEASURED` cuando no se observan ambos extremos.

## Frentes y límites

- **Gobernanza:** contrato IPZ, definición normativa y criterios de aceptación.
- **MCP-OCP:** implementación de Sink local, herramientas, importación de fuentes, manifest/hash y telemetría de frecuencia. No se modificó su control ni su código.
- **EP:** perfil, almacenamiento seguro, instalación, operación y read-back. No se modificó su control, host ni OEP.
- **RDC:** medio de invocación; no es un frente separado.

No intervienen en este MVP Acceso, Khora, Jules, Backblaze, Cloudflare ni MOD-SYNC. GOV-TASK-002 permanece cancelada. `MCP-NORMATIVO` permanece `DESACTIVADO`.

## Estado observado y bloqueos

- DUG resultante: Samantha v384 · NX-384m.
- La candidata MCP-OCP 0.1.0 disponible históricamente está fijada a DUG v377/core v0.1.20; el núcleo canónico observado es v0.1.21 y el DUG actual v384. Se requiere reconciliación/build fresco.
- El control MCP-OCP generación 5 excluye expresamente Sink productivo; su titular debe autorizar el alcance en su propio control antes de implementar.
- EP conserva la instalación/host. El workspace PC-14 observado tiene restricciones de cifrado y no se declara listo para materializar fuentes sensibles; EP debe determinar el perfil seguro.
- Los 43 registros no poseen los metadatos canónicos completos para selección automática (applicability, activation_conditions, mandatory y dependencies); no inferirlos.
- No se ejecutó código Sink, build, pruebas Sink, importación a perfil real, provisión de operador, instalación EP, prueba E2E ni instalación nativa del IPZ.
- FOL1 permanece `PREPARADO_PENDIENTE_ACTIVACION_IPZ`.

## DTC y secuencia

Se leyeron los objetos de coordinación existentes de EP y MCP-OCP. Sus últimos cursores observados para esta revisión fueron EP blob `cfa59cdf083905dd4793d5b8b046dc501b09b820` y MCP-OCP blob `2499afb15f11dded54c6d6b3f43f3482831aa262`. No se observó una respuesta nueva posterior a esos cursores. No se enviaron solicitudes ni se escribieron sus OCP o controles.

La apertura formal de DTC no quedó persistida antes de iniciar el análisis técnico; por tanto, este registro no declara un ciclo trilateral conforme ni aceptación de los frentes ejecutores. La siguiente coordinación deberá abrirse en los objetos existentes de EP y MCP-OCP, solicitar respuesta inicial, respetar sus controles y realizar read-back.

## Resultado

**DOCUMENTALMENTE ALINEADO EN GOBERNANZA · IMPLEMENTACIÓN LOCAL NO EJECUTADA · E2E NO ACEPTADO.**  
La autorización de Gobernanza no transfiere titularidad ni amplía por sí sola los controles de MCP-OCP o EP.
