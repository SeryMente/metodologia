# Investigación · API de Jules, MCP y automatización

**Revisión documental:** 2026-10-29. **Objeto:** verificar el contrato oficial de Jules, la superficie de uso de MCP personalizada en ChatGPT y los deltas relevantes del candidato de Khora. **Límite:** no se ejecutó una llamada real autenticada a Jules; no se probó la credencial y no se validó conexión de ChatGPT desde el cliente final.

## Fuentes primarias vigentes

- [Jules REST API — catálogo](https://developers.google.com/jules/api/reference/rest)
- [Jules Session resource, estados y outputs](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions)
- [Jules sources.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sources/list)
- [Jules Source resource](https://developers.google.com/jules/api/reference/rest/v1alpha/sources)
- [Jules sessions.create](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/create)
- [Jules sessions.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/list)
- [Jules sessions.activities.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions.activities/list)
- [Jules sessions.sendMessage](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/sendMessage)
- [Jules sessions.approvePlan](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/approvePlan)
- [OpenAI — conectar servidores MCP personalizados en ChatGPT](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt)
- [OpenAI — modo de desarrollador y aplicaciones MCP](https://help.openai.com/en/articles/12584461-developer-mode-and-full-mcp-connectors-in-chatgpt)

## Contrato Jules verificado

La base REST es `https://jules.googleapis.com/v1alpha`; la autenticación documentada para la API es mediante `X-Goog-Api-Key`. La API publicada contiene recursos `sources`, `sessions` y `sessions/{session}/activities`, y métodos para listar/consultar fuente, crear/listar/consultar sesión, listar actividades, enviar mensaje y aprobar plan.

- Sources: `GET /v1alpha/sources`; parámetros `pageSize` de 1 a 100 y `pageToken`; respuesta `sources[]` y `nextPageToken`. Cada Source expone el nombre de recurso, el repositorio GitHub y sus ramas.
- Source: la API publica un método `get`; por tanto, el servidor puede verificar la fuente y la rama internamente antes de crear una sesión sin añadir una octava herramienta MCP visible.
- Sessions: `GET /v1alpha/sessions`, `pageSize` 1–100 y `pageToken`; `GET /v1alpha/{name=sessions/*}` devuelve datos como id/name, state, timestamps, URL y outputs.
- Activities: `GET /v1alpha/{parent=sessions/*}/activities`, `pageSize` 1–100 y `pageToken`; el contrato consultado no documenta `createTime` como cursor de la operación de listado.
- Create: el payload lleva `prompt`, `sourceContext.source` y `githubRepoContext.startingBranch`. `requirePlanApproval=true` evita aprobación automática del plan. `automationMode=AUTO_CREATE_PR` pide crear rama/PR cuando Jules produce un parche final aplicable. Ambos campos son input-only: su ausencia en la respuesta no demuestra que el servidor no los enviara.
- Estados publicados: `STATE_UNSPECIFIED`, `QUEUED`, `PLANNING`, `AWAITING_PLAN_APPROVAL`, `AWAITING_USER_FEEDBACK`, `IN_PROGRESS`, `PAUSED`, `FAILED` y `COMPLETED`.
- Activities incluye eventos de plan generado/aprobado, mensaje de usuario/agente, progreso, finalización y fallo; la unión de Activity también puede incluir artefactos.
- `sendMessage` recibe `{prompt}` y devuelve cuerpo vacío cuando se acepta; `approvePlan` usa cuerpo vacío y también devuelve una respuesta vacía. En ambos casos hay que volver a consultar estado/actividades para verificar el efecto.
- La documentación consultada es `v1alpha`; el contrato se debe revalidar antes de implementar y antes del release.

## Contratos de automatización fijados para v1.0

1. Siete herramientas MCP públicas; la lectura de fuente/branch por API se hace internamente al crear una sesión.
2. La creación fuerza `requirePlanApproval=true` y fija `automationMode=AUTO_CREATE_PR`. Un PR no implica merge ni despliegue.
3. El servidor verifica que la fuente existe y que la rama exacta está disponible; fallo de consulta o discrepancia bloquea `sessions.create`.
4. GET usa `pageToken` documentado y puede reintentarse de forma limitada. No usar helpers con cursor `createTime` no documentado.
5. El candidato tiene `listActivitiesPage`, usado por la ruta MCP, y conserva un helper anterior que agrega `createTime`. La fase 2 debe retirar o aislar el helper no documentado.
6. `fetchWithBackoff` en el candidato reintenta algunas solicitudes por red, 429 y 5xx sin distinguir método HTTP. Es un delta obligatorio: create/message/approve no se deben reintentar automáticamente tras timeout de red o 5xx ambiguo, porque pueden duplicarse sesiones o mensajes y no se documenta una clave de idempotencia.
7. La ruta candidata verifica el estado antes de enviar mensaje/aprobar, pero puede cambiar después. Antes de aprobar, volver a leer plan/estado; si cambió, solicitar consentimiento sobre el plan vigente.
8. El servidor no puede probar por sí solo quién escribió una confirmación en la conversación. El contrato exige consentimiento explícito del operador y respeta cualquier confirmación de la plataforma; no se afirma una barrera criptográfica independiente.

## Compatibilidad ChatGPT y modelo de uso

La documentación oficial consultada el 2026-10-29 declara conexiones MCP personalizadas con escritura para ChatGPT Business y Enterprise/Edu; Pro puede conectar servidores personalizados con lectura/recuperación, no la misma compatibilidad completa de escritura. Plus no figura expresamente entre los planes habilitados para escritura en la documentación consultada; su elegibilidad no se presume y queda como gate externo.

La app personalizada se selecciona para el mensaje en el que se usa; si un mensaje posterior requiere una nueva acción o datos, hay que volver a mencionarla. La documentación actual excluye apps personalizadas de Agent mode y restringe Deep Research a lectura/recuperación. Por tanto, el objetivo v1.0 es el chat web conversacional normal cuando la herramienta esté disponible/seleccionada, no un agente de fondo ni una promesa de invocación automática en todos los turnos.

OpenAI conecta ChatGPT a servidores MCP remotos mediante HTTPS público o túnel seguro admitido. La configuración real de cuenta/espacio de trabajo y permiso de escritura permanece NO VERIFICADA hasta una prueba en el cliente final.

## Niveles de automatización

- **Nivel 0 — interacción MCP en chat activo (v1.0):** ChatGPT invoca herramientas para delegar, revisar el plan, leer actividades, responder feedback y validar la entrega. No hay vigilancia entre turnos.
- **Nivel 1 — sondeo persistente:** requiere un trabajador externo, checkpoint, deduplicación, paginación, backoff y recuperación. Está fuera de v1.0.
- **Nivel 2 — clasificar feedback/proponer respuesta:** extensión futura que propone respuestas basadas en el OCP; si falta información, escala al operador.
- **Nivel 3 — autorespuesta acotada:** solo podría evaluarse para datos factuales verificados dentro del alcance; decisiones materiales requieren un control distinto.
- **Nivel 4 — orquestación de PR/CI:** futura integración adicional, no incluida en el MVP directo.

La referencia REST consultada no documenta un webhook para cada actividad nueva; no se promete uno.

## Implementación candidata y delta de diseño

En la rama de Khora `feat/mcp-jules-mvp-20261025-final` se observaron el cliente `khora-web/lib/jules/client.ts`, la ruta MCP existente `khora-web/app/api/mcp/route.ts`, scopes separados, metadata OAuth y siete herramientas. El candidato:
- ya fuerza `requirePlanApproval=true`;
- establece `automationMode=AUTO_CREATE_PR`;
- comprueba estados antes de enviar mensaje/aprobar;
- usa `listActivitiesPage` en la ruta MCP;
- no verifica fuente/branch con GET server-side inmediatamente antes de crear;
- usa retries HTTP comunes para algunas solicitudes POST, que se deben separar por idempotencia;
- no tiene evidencia de una llamada real a Jules ni de una conexión cliente ChatGPT con escritura.

Los estados de CI persistidos en `C-MCP-JULES-004` son históricos y se deben refrescar contra los heads actuales en fase 2. La crónica anterior reportó una falla unitaria por ausencia de acceso interrepositorio al esquema privado, findings Ruff fuera del diff y fallos de build/E2E aguas abajo. No se declara que esos resultados se hayan vuelto a ejecutar en esta revisión.

## Dictamen de viabilidad

- Ciclo conversacional bidireccional asistente → Jules → asistente: **viable en diseño**, sujeto a credencial y cliente real.
- Fuente/branch validada server-side y aprobación de plan: **requisito obligatorio de implementación**.
- Responder en la misma sesión: **viable mediante sendMessage + relectura de activities**.
- Crear PR cuando Jules produzca un parche: **seleccionado para v1.0 mediante AUTO_CREATE_PR**; merge/deploy permanecen fuera del alcance.
- Uso nativo de escritura en el cliente/espacio real: **NO VERIFICADO**; sin plan/espacio compatible no puede afirmarse el flujo solicitado.
- Sondeo persistente fuera del turno: **requiere trabajador externo y queda fuera de v1.0**.
- Webhook de actividad: **no documentado en la referencia REST consultada**.
- MVP utilizable: **no aceptado** hasta completar suite, llamada real, cliente real y gates de release.