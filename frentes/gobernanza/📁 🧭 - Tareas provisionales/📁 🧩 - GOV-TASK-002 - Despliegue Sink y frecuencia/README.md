# 📝 GOV-TASK-002 · Despliegue de Sink y telemetría de frecuencia (supersedida)

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `cancelada`
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-002`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Conservar el diseño Sink/Cloudflare como antecedente de una alternativa descartada para el MVP actual. No desplegar infraestructura, aliases ni recursos Cloudflare. El requisito activo de resolución individual y telemetría se atiende mediante la arquitectura Sync de OCP MCP bajo GOV-TASK-008 y GOV-TASK-003.

## Referencia de origen

ART-027 vigente en DUG v373 · NX-373m; diseño originado en C-GOBERNANZA-MDP-OCP-01.

## Dependencias y límites

Cuenta y acceso autorizado a Cloudflare, integración/conector o vía de despliegue, fork autorizado de miantiao-me/Sink, D1, KV y secretos protegidos; sin credenciales en Git. La comprobación de PC-14 (RDC) devolvió `WRANGLER_NOT_INSTALLED`; la sesión no dispone de integración Cloudflare. La lista de herramientas GitHub tampoco ofrece una operación de fork.

## Siguiente actuación

No hay actuación de despliegue pendiente para esta tarea: se cancela Sink/Cloudflare para el MVP actual. Las necesidades de resolución individual y frecuencia pasan a GOV-TASK-008/003 bajo OCP MCP/Sync. No abrir cuentas, instalar CLI, crear aliases ni desplegar recursos.

## Criterio de cierre

La tarea se cierra como `cancelada` para el despliegue Sink/Cloudflare, preservando diseño y procedencia histórica. No se interpreta como cancelación del requisito funcional de enlaces individuales y telemetría, que continúa en GOV-TASK-008/003.


## Revisión de alcance · instrucción del operador · 2026-10-31

El título y diseño Sink/Cloudflare quedan como antecedente histórico en revisión, no como autorización vigente para desplegar esa infraestructura. El objetivo actual es obtener enlaces Sync acortados e individuales para GOW/§ARR, DUG y principios desarrollados, con resolución y telemetría de frecuencia compatibles con el contrato de OCP MCP.

**No ejecutar** despliegue Sink, creación de aliases p001–p043 ni recursos Cloudflare por inercia. Primero OCP MCP debe informar si su arquitectura 0.1.0 puede generar/servir los enlaces Sync requeridos, registrar cada acceso y devolver evidencia de integridad. Gobernanza define requisitos y acepta resultados; la implementación del servidor pertenece al OCP MCP. No asumir que «Sink» y «Sync» son el mismo servicio.
