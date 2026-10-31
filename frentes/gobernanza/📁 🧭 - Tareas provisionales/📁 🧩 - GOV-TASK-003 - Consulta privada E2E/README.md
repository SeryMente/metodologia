# 📝 GOV-TASK-003 · Prueba E2E del flujo OCP MCP/Sync

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
