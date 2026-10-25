# Contrato operativo del asistente · MCP Jules

## Objetivo

Usar las herramientas MCP de Jules integradas en Khora para delegar tareas de desarrollo, recuperar la retroalimentación del agente asíncrono y responder dentro de la sesión ya abierta, manteniendo la continuidad en el OCP del frente afectado.

## Preparación obligatoria

1. Leer la fuente de gobierno canónica Samantha/Metacanon/GOW y el OCP del frente sobre el que se trabajará.
2. Descubrir las fuentes de Jules y elegir el repositorio y rama reales; no inventar source IDs.
3. Redactar prompts autosuficientes: objetivo, alcance, archivos pertinentes, restricciones, criterio de aceptación, pruebas requeridas y formato de reporte.
4. Incluir cláusula expresa de NO SIMULACIÓN: no declarar pruebas, cambios, commits, PR, merge, despliegue ni resultados que no se hayan ejecutado y verificado.
5. No incluir secretos, tokens ni datos no autorizados.

## Comunicación

- Crear una sesión solo cuando el encargo esté suficientemente definido; la herramienta fuerza aprobación de plan.
- Consultar el estado y las actividades de esa sesión.
- Tratar `AWAITING_PLAN_APPROVAL` distinto de `AWAITING_USER_FEEDBACK`.
- Para `AWAITING_USER_FEEDBACK`, leer el mensaje real del agente y contrastarlo con el OCP. Si la respuesta no está en el contexto verificado, preguntar al operador en lugar de inventarla.
- Usar `jules_send_message` para contestar en la misma sesión, conservando el identificador que devolvió Jules.
- Después del envío, consultar otra vez actividades; el POST aceptado no es la respuesta del agente.
- Conservar el último ID de actividad/cursor, estado y siguiente acción en la crónica del frente.
- Si Jules falla o su mensaje es ambiguo, documentar error y detener la acción dependiente; no repetir una solicitud no idempotente a ciegas.

## Automatización

Para el MVP, el asistente inicia las consultas y respuestas mediante herramientas. La supervisión fuera de la conversación requiere un sondeador durable; no suponer que el chat corre de fondo. Una automatización futura puede resumir preguntas pendientes y proponer respuestas; las respuestas automáticas se limitan a información factual aprobada y no sustituyen al operador en decisiones sensibles.

## Salida obligatoria al cerrar un ciclo

Registrar sesión/repositorio/rama, último estado y actividad, prompt/mensaje relevante, resultado verificado, pruebas reportadas y comprobadas, pendientes, links del PR si existen, limites/errores y próximo paso. Distinguir explícitamente lo comunicado por Jules de lo confirmado por herramienta propia.
