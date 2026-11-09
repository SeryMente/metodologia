# 📝 GOV-TASK-003 · Prueba E2E del flujo OCP MCP/Sink local vía RDC

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-003`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Verificar de extremo a extremo el recorrido del ciclo en OCP MCP: validación del folio de ciclo y su vínculo con la sesión autorizada; entrega del inventario de 43 principios; selección reportada por el modelo; entrega de enlaces Sync individuales a los principios desarrollados; registro de frecuencia por acceso individual; reconsulta de principios adicionales cuando falte suficiencia; y hash verificable del paquete exacto y ordenado de enlaces.

## Referencia de origen

ART-027 vigente en DUG v373 · NX-373m; repositorio privado SeryMente/metodologia.

## Dependencias y límites

Depende de GOV-TASK-001, GOV-TASK-007, GOV-TASK-008, OCP MCP 0.1.0 y de la instalación validada por EP. La prueba no se satisface con leer el HTML completo ni con telemetría genérica de operaciones: debe comprobar el acceso real a cada URL Sync individual. Incluye casos positivos y negativos y conserva el DUG como única fuente normativa.

## Siguiente actuación

Tras la entrega de OCP MCP y la instalación validada por EP, ejecutar el flujo completo de aceptación. Antes de esa condición, revisar schemas y artefactos de release; no ejecutar instalaciones en el host ni declarar prueba E2E a partir de unit tests o de telemetría genérica.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.


## Revisión de alcance · instrucción del operador · 2026-10-31

La prueba E2E deja de describirse exclusivamente como «Sink → GitHub». Debe verificar el flujo completo con OCP MCP: validar el folio del ciclo y su vínculo con la sesión autorizada; entregar el inventario de 43 principios; recibir la selección del modelo; devolver enlaces Sync individuales a los textos completos seleccionados; registrar la frecuencia de cada acceso; permitir solicitar principios adicionales cuando la información sea insuficiente; y emitir un hash verificable del paquete exacto de enlaces.

La prueba debe cubrir respuestas positivas y negativas, IDs inexistentes, ciclo/sesión no válidos, enlace no resoluble, fuente desactualizada, hash alterado y fallo cerrado. No declarar que el servidor 0.1.0 satisface el flujo hasta obtener evidencia de cada operación. La instalación/operación local y el transporte RDC pertenecen a EP; esta tarea define aceptación funcional desde Gobernanza.



## Rectificación de arquitectura aprobada · 2026-11-09 · C-GOBERNANZA-IPZ-RDC-SINK-01

La aceptación E2E se realizará sobre el flujo **ChatGPT/IPZ → RDC → MCP-OCP local por stdio → almacén local → respuesta validada**. Las referencias ejecutables son `GOW:ARR`, `DUG` y `SINK:P001` … `SINK:P043`. No se exige una URL por principio ni un resolvedor HTTP. Las menciones previas a Sync URLs y paquetes de URLs quedan como antecedentes sustituidos para este flujo.

Pruebas exigidas:
1. `GOW:ARR` devuelve §ARR desde la fuente importada y verificada.
2. `DUG` identifica versión, firma, commit, Git blob SHA y SHA-256 del documento; el inventario conserva los 43 IDs/MDP.
3. Cada `SINK:Pxxx` devuelve únicamente el texto desarrollado correspondiente, su ID, título, pin de DUG y SHA-256; un ID inexistente o un texto cuyo hash no coincida falla cerrado.
4. Cada recuperación completa y satisfactoria produce un evento individual de frecuencia para ese principio. Una llamada agrupada conserva el orden pedido y produce un resultado/evento por cada principio recuperado; una consulta fallida no cuenta como recuperación lograda.
5. El manifiesto representa el conjunto exacto y ordenado: IDs solicitados, versión/firma/commit/blob del DUG y SHA-256 de cada texto. Su hash se calcula sobre serialización canónica UTF-8; no basta `selection_sha256` de IDs ni un hash de URLs.
6. Si RDC no responde, el servidor no está disponible, la fuente está obsoleta/no importada o hay una discrepancia de hash, el resultado es no verificado y no se aplica el principio. No se sustituye por memoria ni por MDP.
7. La latencia de extremo a extremo se registra separadamente mediante `ipz.resolve.rdc.duration_ms` según GOV-TASK-013: reloj monotónico, inicio inmediatamente antes del despacho RDC y final al recibir y validar mínimamente la respuesta completa. Si no se pueden observar ambos extremos: `NOT_MEASURED`. No mezclar latencia y frecuencia.

**Compuertas:** no ejecutar esta prueba completa hasta que MCP-OCP haya autorizado e implementado Sink, el paquete esté actualizado a los pins canónicos vigentes y EP haya realizado la instalación autorizada/read-back del perfil de uso. Esta tarea no autoriza host, instalación ni cambio de control ajeno. FOL1 sigue pendiente; no inventar folios globales mientras no esté activo. `MCP-NORMATIVO` permanece desactivado.

**Estado:** la especificación de aceptación está armonizada; la ejecución E2E permanece `PENDIENTE`.
