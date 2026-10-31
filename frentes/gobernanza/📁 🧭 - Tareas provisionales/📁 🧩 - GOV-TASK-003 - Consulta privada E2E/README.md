# 📝 GOV-TASK-003 · Prueba de consulta privada Sink → GitHub

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-003`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Verificar de extremo a extremo que cada alias Sink redirige al principio correcto y que el modelo recupera el texto desarrollado mediante GitHub autenticado sin hacer público el repositorio.

## Referencia de origen

DUG v371 · ART-027 · secciones 4 y 7; repositorio SeryMente/metodologia.

## Dependencias y límites

Depende de GOV-TASK-002; repositorio GitHub privado y conector autenticado.

## Siguiente actuación

Tras desplegar Sink, probar un alias representativo, observar el fragmento Pxxx, recuperar gov-data con el conector GitHub y cotejar el texto y la revisión.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.
