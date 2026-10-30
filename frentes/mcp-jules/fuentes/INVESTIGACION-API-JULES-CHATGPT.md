# Investigación · API de Jules, MCP y automatización

**Revisión documental:** 2026-10-29 · R2, cierre de Fase 1. **Restricciones del operador:** ChatGPT Free obligatorio; Codex nunca se utilizará. **Objeto:** verificar el contrato oficial de Jules, la superficie de uso de MCP personalizada en ChatGPT y los deltas relevantes del candidato de Khora. **Límite:** no se ejecutó una llamada real autenticada a Jules; no se probó la credencial y no se validó conexión de ChatGPT desde el cliente final.

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
- [OpenAI — Plugins en ChatGPT](https://help.openai.com/en/articles/20001256-plugins-in-chatgpt)
- [OpenAI Developers — envío y publicación de plugins](https://developers.openai.com/plugins/deploy/submission)
- [OpenAI Developers — autenticación de usuarios en plugins MCP](https://developers.openai.com/plugins/build/auth)
- [OpenAI — Apps en ChatGPT](https://help.openai.com/en/articles/11487775-apps-in-chatgpt)
- [OpenAI — preguntas frecuentes del plan ChatGPT Free](https://help.openai.com/en/articles/9275245-chatgpt-free-tier-faq)

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

## Compatibilidad ChatGPT Free y modelo de distribución

### Conexión MCP privada

La documentación de OpenAI consultada el 2026-10-29 especifica que la compatibilidad completa de MCP personalizado, incluidas acciones de escritura, se habilita para ChatGPT Business y Enterprise/Edu; Pro figura con permisos de lectura/recuperación. No se debe suponer que una cuenta personal Free pueda conectar directamente un servidor MCP personalizado con escritura. Esta ruta no se selecciona como cliente final del producto.

### Plugin MCP público del directorio

OpenAI indica que el directorio de plugins está disponible en distintos planes y que los plugins pueden incorporar apps/conexiones externas. Los plugins publicados pueden ejecutarse en ChatGPT y pueden incluir un servidor MCP remoto. La disponibilidad y funciones de cada plugin siguen dependiendo del plan, cuenta, región y capacidades del plugin. Por tanto, esta es una ruta técnicamente candidata para ChatGPT Free, pero no existe en la documentación una garantía de escritura para MCP Jules en Free.

Decisión de diseño: preparar MCP Jules como plugin público con un único servidor remoto que apunta al endpoint existente /api/mcp de KHORA. El paquete se verificará y someterá a revisión en el portal de desarrolladores de OpenAI; solo después de aprobación se publicará. El usuario Free lo encontrará/instalará desde el directorio, conectará su identidad KHORA y seleccionará/mencionará el plugin en chat normal.

El paquete MCP incluye metadata, identidad de editor verificada, dominio HTTPS, descripción precisa, recursos gráficos requeridos, política de privacidad y soporte. El portal exige conectar y escanear el servidor, revisar las herramientas encontradas, resolver findings, completar autenticación y pasar la revisión antes de publicar. La publicación es una compuerta externa, no un resultado presumido.

### OAuth y aislamiento

El contrato de autenticación de plugins MCP de OpenAI exige OAuth para datos de usuario y acciones de escritura. La implementación debe soportar OAuth 2.1 Authorization Code + PKCE S256, protected resource metadata, authorization server metadata, el mecanismo de cliente publicado (CIMD o DCR, según configuración), preservación del parámetro resource y validación de issuer, audience, expiración, sujeto y scopes.

El servidor debe asignar el sujeto OAuth a una identidad KHORA autorizada y filtrar fuentes, repositorios y ramas por usuario. La secuencia mínima es sujeto → identidad KHORA → fuentes Jules permitidas → repositorios → ramas → scopes. No basta con scopes globales jules:read/jules:write para proteger repos privados. La lista de fuentes debe filtrar por ACL y la creación de sesión debe revalidar fuente y rama en Jules y contra el permiso del sujeto. JULES_API_KEY permanece solo en servidor.

### Free como gate de aceptación

Se requiere probar desde una cuenta personal ChatGPT Free real, en la región/superficie objetivo, sin Developer Mode ni un workspace de pago: listing disponible, instalación, OAuth, descubrimiento de las siete herramientas, lectura, escritura no destructiva, ciclo E2E y comportamiento ante cuota Free. La documentación general del directorio no demuestra que el plugin específico tenga escritura; T23/T26/T27 bloquean release hasta disponer de evidencia real.

Si el plugin no está disponible o la escritura se deniega en Free, el estado es BLOCKED/FAIL. No se sustituye por conexión MCP privada de plan de pago, GPT Actions, relevo manual ni Codex. El cambio de arquitectura requiere decisión explícita del operador.

### Herramientas del plugin vs. extensiones nativas

Debe distinguirse la capacidad de invocar herramientas MCP desde un plugin de las extensiones nativas de plugin que añaden superficies específicas de ChatGPT (barra lateral, compositor, visores de archivos e interacciones enriquecidas). La documentación de OpenAI dice que las extensiones web están pendientes para Free y Go, mientras que la funcionalidad existente del plugin no se ve afectada. Asimismo, ChatGPT web utiliza herramientas MCP remotas a través de plugins. Por tanto, no se requiere una extensión nativa para el ciclo MCP Jules v1.0; el sistema debe exponer herramientas básicas desde chat web normal. Aun así, esto no demuestra por sí solo que cada plugin y cada escritura sean elegibles en Free: la disponibilidad final se prueba con la cuenta objetivo.

Fuentes: [Plugin Extensions](https://developers.openai.com/plugins/build/extensions), [Plugins en ChatGPT](https://help.openai.com/en/articles/20001256-plugins-in-chatgpt), [Model Context Protocol en ChatGPT Learn](https://learn.chatgpt.com/docs/extend/mcp), [solución de problemas de plugins y apps](https://help.openai.com/en/articles/20001497-troubleshooting-plugins-and-apps).

### GPT Actions y Codex

Se descartan GPT Actions como dependencia: las cuentas personales Free no pueden crear ni publicar GPTs personalizados nuevos. **Codex queda expresamente excluido** del desarrollo, pruebas, publicación, instalación, operación y contingencias. No se recomienda ni invoca ese producto.

### Uso conversacional y límites

El plugin debe seleccionarse/mencionarse en los mensajes que necesiten herramientas; no se promete invocación automática en cada turno, operación en Agent/Deep Research para escritura ni ejecución permanente en background. Al alcanzar límites Free, preservar checkpoint y reanudar después sin duplicar POST ni perder contexto. La operación activa sigue siendo por turnos conversacionales.

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