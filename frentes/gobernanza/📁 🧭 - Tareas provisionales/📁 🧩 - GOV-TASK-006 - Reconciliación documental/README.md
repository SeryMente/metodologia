# 📝 GOV-TASK-006 · Reconciliar divergencias documentales de Gobernanza

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-006`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Auditar y reconciliar las divergencias entre el estado vigente del DUG, índices, núcleo operativo, pendientes, crónicas y evidencias, conservando los antecedentes históricos sin presentarlos como estado actual.

## Referencia de origen

frentes/gobernanza/README.md; GOBERNANZA.md; PENDIENTES.md; crónicas y evidencias históricas; INICIO.md.

## Dependencias y límites

Control de Gobernanza generación 7 (C-GOBERNANZA-RETOMA-06); cualquier diferencia normativa se resuelve en el DUG y no mediante fusión silenciosa de copias.

## Hallazgos de reconciliación actual

- DUG vigente: v373 · NX-373m, blob `cac4525de77d4f47a8a59c25201968ecf2056b90`.
- Control de Gobernanza: generación 7, blob leído de vuelta `c41c3cddc866de999827fc6ae36c23dde400344f`.
- Punto de entrada, núcleo, pendientes y registro de tareas conservaban referencias activas a v371/generación 6; se corrigen en este corte documental, sin reescribir los registros históricos.
- Discrepancia aún abierta: GOW humano v2.12 frente a `gov-data` v2.14 y metadatos auxiliares v2.11. Se preserva y escala para decisión; no se corrige el canon en este ciclo.

## Siguiente actuación

Contrastar versiones, eventos, commit/blob SHA y estados; corregir solo los índices y registros activos que apunten a información desactualizada, preservando los eventos históricos.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.
