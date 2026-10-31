# 📝 GOV-TASK-002 · Despliegue de Sink y telemetría de frecuencia

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-002`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Desplegar Sink en Cloudflare, provisionar sus recursos, crear los 43 aliases p001–p043 y habilitar únicamente la medición de frecuencia de acceso por principio.

## Referencia de origen

ART-027 vigente en DUG v373 · NX-373m; diseño originado en C-GOBERNANZA-MDP-OCP-01.

## Dependencias y límites

Cuenta y acceso autorizado a Cloudflare, integración/conector o vía de despliegue, fork autorizado de miantiao-me/Sink, D1, KV y secretos protegidos; sin credenciales en Git. La comprobación de PC-14 (RDC) devolvió `WRANGLER_NOT_INSTALLED`; la sesión no dispone de integración Cloudflare. La lista de herramientas GitHub tampoco ofrece una operación de fork.

## Siguiente actuación

Obtener acceso autorizado a Cloudflare y habilitar la vía autorizada de fork/despliegue; solo después provisionar Worker, D1, KV, secretos y, si procede, Analytics Engine. No instalar CLI ni desplegar recursos a ciegas.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.
