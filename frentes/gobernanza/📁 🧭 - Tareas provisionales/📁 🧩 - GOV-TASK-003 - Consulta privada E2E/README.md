# 📝 GOV-TASK-003 · Prueba de consulta privada Sink → GitHub

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-003`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Verificar de extremo a extremo que cada alias Sink redirige al principio correcto y que el modelo recupera el texto desarrollado mediante GitHub autenticado sin hacer público el repositorio.

## Referencia de origen

ART-027 vigente en DUG v373 · NX-373m; repositorio privado SeryMente/metodologia.

## Dependencias y límites

Depende de GOV-TASK-002 y GOV-TASK-008; repositorio GitHub privado y canal autenticado que entregue un único principio. El conector GitHub disponible recupera el HTML completo, por lo que no constituye por sí solo una prueba de aislamiento.

## Siguiente actuación

Tras desplegar el resolvedor, probar un alias piloto y verificar que responde únicamente el objeto del ID solicitado, con versión/firma/SHA de fuente; probar IDs inexistentes, autenticación inválida y fuente no disponible con respuesta fail-closed. No usar el HTML completo ni `gov-data` completo como resultado de prueba.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.
