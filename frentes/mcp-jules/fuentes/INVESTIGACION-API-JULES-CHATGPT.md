# Investigación · API de Jules, MCP y automatización

**Fecha de consulta:** 2026-10-25. **Resultado:** la comunicación mediante herramientas MCP es viable; el seguimiento persistente requiere infraestructura externa. No se declara llamada real ni credencial validada.

## Fuentes primarias
- [Jules REST API](https://developers.google.com/jules/api/reference/rest)
- [Sesiones](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions)
- [Crear sesión](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/create)
- [Enviar mensaje](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/sendMessage)
- [Aprobar plan](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/approvePlan)
- [Listar actividades](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions.activities/list)
- [Conectar servidores MCP personalizados a ChatGPT](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt)

## Capacidad de la API
La API publicada utiliza `https://jules.googleapis.com/v1alpha` y el encabezado `X-Goog-Api-Key`. El contrato es alpha y puede cambiar. Sus recursos exponen fuentes, sesiones y actividades. Las actividades pueden incluir `agentMessaged`, `userMessaged`, `planGenerated`, `planApproved`, `progressUpdated`, `sessionCompleted` y `sessionFailed`.

Operaciones usadas por el MVP: listar fuentes; listar sesiones; consultar una sesión; listar actividades con `pageSize` y `pageToken`; crear una sesión; enviar mensaje; aprobar un plan. El envío de mensaje puede responder con cuerpo vacío y únicamente confirma que la solicitud fue aceptada; después se debe consultar actividades para recuperar la contestación de Jules.

La propiedad `requirePlanApproval=true` hace que el plan generado requiera aprobación explícita antes de la ejecución. El cliente MCP la fuerza en el servidor y no la expone como parámetro opcional al asistente.

## Niveles de automatización

### Nivel 0 — interacción mediante MCP
ChatGPT llama a las herramientas para delegar, leer actividad y responder. Esto es el núcleo del MVP y no supone vigilancia continua entre turnos.

### Nivel 1 — sondeo persistente
Un trabajo externo consulta periódicamente sesiones activas, recorre páginas, almacena último token/ID procesado por sesión, deduplica por ID de actividad, aplica backoff para 429/5xx y permite reanudar tras reinicio. La referencia REST consultada documenta listar actividades, pero no un webhook para cada actividad nueva; el sondeo es la opción conservadora. Este trabajador no está implementado por el MVP directo.

### Nivel 2 — clasificar feedback y proponer respuesta
El trabajador detecta `AWAITING_USER_FEEDBACK` o `agentMessaged`, adjunta el mensaje verificable y propone una respuesta a partir del OCP. Si falta información o la petición cambia alcance, pregunta al operador en vez de inventar datos.

### Nivel 3 — respuesta automática acotada
Una futura política podría autoenviar únicamente información factual que esté en el OCP verificado y dentro del alcance ya autorizado. Debe detenerse ante decisiones de arquitectura/seguridad, secreto, permiso, acción destructiva, merge/despliegue, dato crítico ausente, ambigüedad o intento de ampliar autorización. No se recomienda una autorespuesta ilimitada.

### Nivel 4 — orquestación de PR/CI
Se puede construir seguimiento de PR, CI, fallos y petición de corrección, pero requiere integración adicional, atribución, idempotencia, límites de reintento y permisos. No es parte del mínimo directo.

## Compatibilidad con ChatGPT
ChatGPT requiere endpoint MCP remoto HTTPS o túnel compatible, autenticación, habilitación del uso de herramientas y prueba desde el cliente real. La documentación de OpenAI consultada especifica que el soporte completo de MCP con acciones de escritura está disponible para Business y Enterprise/Edu; Pro puede conectar servidores personalizados con permisos de lectura/fetch, no el mismo nivel de escritura. La disponibilidad real depende de políticas de la cuenta/espacio de trabajo y no ha sido verificada en esta tarea.

## Implementación previa y delta
Khora ya contiene `khora-web/lib/jules/client.ts`, la ruta MCP `khora-web/app/api/mcp/route.ts`, catálogo `mcp-tool-contract.ts`, emisión de tokens manuales, OAuth y Control MCP. El delta del frente agrega siete herramientas en esa única ruta y sus scopes, validación, tests y documentación. No crea una segunda infraestructura MCP.

## Dictamen
- Comunicación bidireccional asistente → Jules → asistente en la misma sesión: **VIABLE**, sujeto a credencial, despliegue y cliente real.
- Recuperar preguntas: **VIABLE** mediante estado y actividades.
- Sondeo continuo fuera del turno: **VIABLE CON TRABAJADOR EXTERNO**, no implementado en el MVP.
- Webhook para actividad: **NO DOCUMENTADO EN LA REFERENCIA REST CONSULTADA**.
- Autorespuesta ilimitada: **NO INCLUIDA**.
- Replicación en otros frentes: **VIABLE** como uso del MCP central de Khora, sin copiar servidor, clave ni control de responsabilidad.
