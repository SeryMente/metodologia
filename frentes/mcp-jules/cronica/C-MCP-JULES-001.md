# C-MCP-JULES-001 · creación del frente MCP Jules

**Fecha:** 2026-10-25. **OCP:** `frentes/mcp-jules/`. **Folio:** SES-20261025-84D3B2F1, generación 1. **Gobierno adquirido:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2. **Evidencia:** lectura directa del repositorio y documentación oficial; no representa ejecución de tests ni llamada autenticada a Jules.

## Objetivo
El operador autorizó un frente independiente dentro de Metacanon para comunicación bidireccional con Jules: enviar prompts, recuperar solicitudes de retroalimentación, responder en la misma sesión, investigar automatización y definir un patrón replicable. Aprobó ampliar el MCP existente de Khora con scopes `jules:read` y `jules:write`, clave solo en servidor y aprobación explícita del plan.

## Hallazgos
- Metacanon §§46/51 definen OCP como carpeta independiente con único núcleo y control individual. No se modificó el control del frente padre.
- El control padre se leyó desde `main`: generación 4, folio `SES-20261022-5E7C91A4`. No hubo transferencia.
- Khora ya dispone de un cliente Jules en `khora-web/lib/jules/client.ts` y un MCP remoto con autenticación, scopes y puerta normativa. No es necesario crear un servidor duplicado.
- La API REST oficial `v1alpha` permite listar fuentes, crear/consultar sesiones, enviar mensajes, aprobar planes y listar actividades.
- La creación de sesión del MCP nuevo fuerza `requirePlanApproval=true`; la aprobación se condiciona al estado `AWAITING_PLAN_APPROVAL`.
- ChatGPT full MCP con herramientas de escritura está sujeto al plan, espacio de trabajo y permisos; no se declara conexión efectiva.
- La automatización fuera de turnos de ChatGPT requiere un trabajador externo con sondeo, checkpoints y deduplicación. No se afirma un webhook de Jules.

## Acciones
- Se creó un OCP separado y un control propio.
- Se documentaron el contrato de 13 bloques, fuentes, criterios, prompts y replicación.
- Se abrió una rama limpia de implementación de Khora `feat/mcp-jules-mvp-20261025-a71c9e2`; el estado exacto de tests se documentará a partir de una ejecución real.
- No se añadió ningún secreto ni se declaró despliegue, merge o test aprobado.

## Límite y siguiente paso
Verificar el read-back, abrir un PR en borrador para que corra CI, revisar los fallos reales, ejecutar la secuencia integrada con credencial real y conectar con un cliente ChatGPT compatible. Actualizar el objeto tras cada evidencia sin sobrescribir la historia.
