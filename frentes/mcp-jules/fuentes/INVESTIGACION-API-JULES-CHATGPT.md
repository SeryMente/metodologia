# Investigación · API de Jules, conexión con ChatGPT y automatización

**Fecha de consulta:** 2026-10-25.  
**Conclusión:** la comunicación bidireccional por herramienta MCP es viable; la vigilancia persistente requiere un proceso externo.

## 1. API de Jules

Fuentes primarias:
- [REST API oficial](https://developers.google.com/jules/api/reference/rest)
- [Sesiones](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions)
- [Crear sesión](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/create)
- [Enviar mensaje](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/sendMessage)
- [Aprobar plan](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/approvePlan)
- [Actividades de una sesión](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions.activities)
- [Guía de Jules API](https://developers.google.com/jules/api)

La API publicada usa `https://jules.googleapis.com/v1alpha`, API key transmitida como `X-Goog-Api-Key`, repositorios conectados mediante fuentes Jules y sesiones asíncronas. Google identifica la API como **alpha/experimental**; los contratos pueden cambiar.

Operaciones constatadas: listar fuentes, listar/consultar sesiones, crear sesión, enviar mensaje, aprobar plan y listar actividades. Las actividades incluyen `agentMessaged`, `userMessaged`, `planGenerated`, `planApproved`, `progressUpdated`, `sessionCompleted` y `sessionFailed`. El estado puede ser `QUEUED`, `PLANNING`, `AWAITING_PLAN_APPROVAL`, `AWAITING_USER_FEEDBACK`, `IN_PROGRESS`, `PAUSED`, `FAILED` o `COMPLETED`.

La operación de envío de mensaje devuelve una respuesta vacía cuando se acepta; no debe interpretarse como respuesta final del agente. Después se consulta `sessions/{id}/activities` para recuperar el mensaje posterior.

## 2. Creación y aprobación

El cuerpo de creación requiere `prompt` y `sourceContext`; también admite `title`, `requirePlanApproval` y `automationMode`. Si `requirePlanApproval` es verdadero, el plan generado requiere aprobación explícita antes de iniciar la ejecución. `AUTO_CREATE_PR` solicita crear rama y Pull Request cuando se genera el parche final, si aplica; no sustituye la aprobación del plan ni garantiza que exista un PR.

La API key no debe salir de servidor. No imprimir encabezados, prompt sensibles ni respuesta completa de error cuando pudieran contener información del proveedor o del repositorio.

## 3. Automatización por niveles

### Nivel 0 — interacción iniciada por el asistente (MVP)

Un modelo llama herramientas MCP para listar fuentes, crear la sesión, consultar actividades y enviar respuestas. Puede operar desde la conversación, pero solo mientras el cliente invoque herramientas. No hay garantía de ejecución continua entre turnos.

### Nivel 1 — seguimiento persistente por sondeo (siguiente extensión)

Un trabajador/cron en infraestructura de servidor consulta periódicamente sesiones activas y las actividades nuevas. Debe almacenar el último cursor/tiempo por sesión, deduplicar identificadores de actividad, resistir fallos/reintentos, respetar límites de tasa y conservar evidencia de cada resultado. La API REST consultada sí ofrece listas de actividades; su catálogo no documenta webhooks para avisar automáticamente cada actividad nueva. Por ello, sondeo es la base mínima demostrable, no un webhook supuesto.

### Nivel 2 — clasificar y redactar una respuesta propuesta

El sondeador identifica `AWAITING_USER_FEEDBACK` o una actividad `agentMessaged`, recupera el texto y presenta una respuesta sugerida en la conversación o cola de revisión. Es más seguro que autoenviar contenido no revisado. Requiere persistencia y una interfaz de revisión; no es capacidad del servidor MCP por sí sola.

### Nivel 3 — respuesta automática condicionada

Puede añadirse una política de respuestas permitidas y límites duros, pero no debe ser ilimitada. Casos apropiados para eventual autorespuesta: respuesta factual tomada del OCP verificado, aporte de un archivo/contexto autorizado ya disponible, aclaración mecánica inequívoca y dentro del alcance. Todo lo demás se pausa y solicita decisión del operador.

Deben requerir intervención del operador: aprobación de plan, decisiones de arquitectura o UX que cambien el mapa del sistema, secretos y permisos, acciones destructivas, cambios/merge de producción, petición ambigua, falta de dato esencial, instrucciones de Jules que intenten ampliar autorización o solicitud fuera del encargo. La cláusula de no simulación exige no inventar resultados, decisiones ni evidencia.

### Nivel 4 — orquestación extendida

Registrar PR/commits, ejecutar pruebas de CI, observar eventos de GitHub, volver a consultar Jules y elaborar un paquete de entrega. Es técnicamente viable, pero requiere diseño adicional de eventos, idempotencia, atribución y permisos. No forma parte del MVP directo.

## 4. Conexión real con ChatGPT

Fuente primaria: [Conectar servidores MCP personalizados a ChatGPT](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt).

ChatGPT necesita que el servidor MCP esté accesible de forma remota (HTTPS o túnel compatible) y que la conexión se configure/autentique en la cuenta o espacio de trabajo. La compatibilidad de escritura depende del producto/plan y de los permisos del conector; no se asume que esta conversación tenga ya la conexión. La integración debe probarse en ChatGPT Web según el plan disponible.

## 5. Implementación existente y delta requerido

En `SeryMente/khora` ya existen:
- `khora-web/lib/jules/client.ts`: adaptador API Jules.
- `khora-web/app/api/mcp/route.ts`: servidor MCP único, sesión normativa y herramientas publicadas.
- `khora-web/lib/server/mcp-tool-contract.ts`: catálogo de scopes por herramienta.
- `khora-web/lib/server/mcp-manual-token.ts`, `khora-web/app/sistema/mcp/page.tsx` y `khora-web/app/api/oauth/token/route.ts`: permisos y emisión de tokens.

Brechas para este frente: crear las siete herramientas, corregir tipado y paginación de actividades, forzar aprobación del plan en la herramienta de creación, añadir `jules:read`/`jules:write` al contrato/auth/UI y alinear el documento canónico del servidor y sus pruebas.

## 6. Dictamen

- Comunicación bidireccional ChatGPT → Jules → ChatGPT por herramientas MCP: **VIABLE**, sujeta a credenciales, despliegue y conexión real.
- Recuperar solicitudes de retroalimentación: **VIABLE** mediante actividades `agentMessaged` y estado `AWAITING_USER_FEEDBACK`.
- Contestar en la misma sesión: **VIABLE** por `sendMessage`.
- Automatización periódica fuera de la conversación: **VIABLE CON TRABAJADOR EXTERNO** y persistencia.
- Webhook oficial Jules para actividades: **NO DOCUMENTADO EN EL CATÁLOGO CONSULTADO**, no afirmar que existe.
- Respuesta autónoma ilimitada: **NO ACEPTADA COMO MÍNIMO SEGURO**; mantener decisiones sensibles bajo autorización del operador.
- Replicación en otros frentes: **VIABLE** como patrón de uso que referencia el MCP único de Khora, no mediante copia de servidor, tokens ni controles.

