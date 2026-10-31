# 📝 GOV-TASK-002 · Despliegue de Sink y telemetría de frecuencia

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-002`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Desplegar Sink en Cloudflare, provisionar sus recursos, crear los 43 aliases p001–p043 y habilitar únicamente la medición de frecuencia de acceso por principio.

## Referencia de origen

DUG v371 · ART-027 · sección 7; C-GOBERNANZA-MDP-OCP-01.

## Dependencias y límites

Cuenta/conector Cloudflare, fork autorizado de miantiao-me/Sink, D1, KV y secretos protegidos; sin credenciales en Git.

## Siguiente actuación

Obtener acceso autorizado a Cloudflare y al repositorio fork; provisionar Worker, D1, KV, secretos y, si procede, Analytics Engine.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.
