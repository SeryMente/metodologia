# Investigación · API de Jules, MCP y automatización

**Revisión documental:** 2026-10-30 · R3, contraste de documentación viva y revisión de implementación Fase 2. **Restricciones del operador:** ChatGPT Free obligatorio; Codex nunca se utilizará. **Objeto:** verificar el contrato oficial de Jules, la superficie de uso de MCP personalizada en ChatGPT y los deltas relevantes del candidato de Khora. **Límite:** no se ejecutó una llamada real autenticada a Jules; no se probó la credencial y no se validó conexión de ChatGPT desde el cliente final.

## Fuentes primarias vigentes

- [Jules REST API — catálogo](https://developers.google.com/jules/api/reference/rest)
- [Jules Session resource, estados y outputs](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions)
- [Jules sources.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sources/list)
- [Jules Source resource](https://developers.google.com/jules/api/reference/rest/v1alpha/sources)
- [Jules Sources API actual — list/get](https://jules.google/docs/api/reference/sources/)
- [Jules Sessions API actual — create/list/get/activities](https://jules.google/docs/api/reference/sessions)
- [Jules API types actuales — GitHubRepo/GitHubBranch](https://jules.google/docs/api/reference/types/)
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

La base REST continúa siendo `https://jules.googleapis.com/v1alpha`. Las referencias vivas de Jules consultadas el 2026-10-30 describen `sources`, `sessions` y `sessions/{session}/activities` y documentan los métodos actuales de listado, consulta, creación, feedback y aprobación.

- Sources: `GET /v1alpha/sources`; `pageSize` de 1 a 100, `pageToken` y filtro opcional; la respuesta contiene `sources[]` y `nextPageToken`.
- Source names: el recurso conserva el patrón `sources/{source}`. Las referencias actuales muestran tanto nombres con estructura `sources/github/{owner}/{repo}` como identificadores `sources/github-{owner}-{repo}`; la validación del servidor admite segmentos seguros bajo `sources/` y excluye traversal, URLs y query/fragment arbitrarios.
- Source data: `githubRepo` documenta `owner`, `repo`, `isPrivate`, `defaultBranch.displayName` y `branches[].displayName`. La rama predeterminada puede no repetirse dentro de `branches[]`; al enumerar ramas autorizadas, el servidor debe considerar ambas fuentes de datos, deduplicarlas y aplicar ACL exacta antes de devolverlas.
- `sources.get`: `GET /v1alpha/sources/{sourceId}`; permite consultar los detalles de una fuente, incluidas las ramas activas. Se usa como preflight server-side antes de crear una sesión. La API lee fuentes conectadas; su creación/instalación se efectúa desde la interfaz de Jules.
- Sessions: `GET /v1alpha/sessions`, parámetros `pageSize` 1–100 y `pageToken`; `GET /v1alpha/{name=sessions/*}` devuelve ID/nombre, estado, URL, marcas de tiempo, contexto y outputs.
- Activities: `GET /v1alpha/{parent=sessions/*}/activities`, con paginación `pageSize`/`pageToken`; no se usa `createTime` como cursor de listado.
- Create: el payload lleva `prompt`, `sourceContext.source` y `githubRepoContext.startingBranch`. `requirePlanApproval=true` exige aprobación explícita del plan; si se omite, la referencia indica que los planes pueden autoaprobarse. `automationMode=AUTO_CREATE_PR` solicita una rama/PR automáticamente cuando corresponda. Ambos campos son input-only: que no aparezcan en respuesta no demuestra que el servidor no los enviara.
- Estados publicados: `STATE_UNSPECIFIED`, `QUEUED`, `PLANNING`, `AWAITING_PLAN_APPROVAL`, `AWAITING_USER_FEEDBACK`, `IN_PROGRESS`, `PAUSED`, `FAILED` y `COMPLETED`.
- Activity incluye plan generado/aprobado, mensajes de usuario/agente, progreso, finalización, fallo y artefactos. Tras `sendMessage` o `approvePlan`, que devuelven respuesta vacía al aceptarse, se reconsulta la sesión y/o las actividades para verificar el efecto.
- El contrato sigue en `v1alpha` y puede cambiar; revalidar antes de un release y ante cualquier respuesta no conforme.

## Contratos de automatización fijados para v1.0

1. Siete herramientas MCP públicas; la lectura de fuente/branch por API se hace internamente al crear una sesión.
2. La creación fuerza `requirePlanApproval=true` y fija `automationMode=AUTO_CREATE_PR`. Un PR no implica merge ni despliegue.
3. El servidor verifica que la fuente existe y que la rama exacta está disponible; fallo de consulta o discrepancia bloquea `sessions.create`.
4. GET usa `pageToken` documentado y puede reintentarse de forma limitada. No usar helpers con cursor `createTime` no documentado.
5. El candidato usa `listActivitiesPage` con `pageToken` documentado; el helper heredado que agregaba `createTime` fue retirado del adaptador.
6. `fetchWithBackoff` distingue GET/HEAD de POST. Los POST create/message/approve no se reintentan en fallos de red, 5xx ambiguos ni 429; los tests sintéticos cubren esas rutas, pero todavía no se han ejecutado en CI.
7. La herramienta de aprobación exige `plan_id` y `plan_sha256` obtenidos en `jules_list_activities`; el servidor calcula la huella de forma canónica sobre `Plan`, relee sesión/actividades paginadas dos veces y bloquea cambios de ID o contenido antes del POST. La API `sessions.approvePlan` solo acepta la sesión y cuerpo vacío; no expone plan_id, ETag ni If-Match, por lo que la última lectura y el POST no son atómicos. T22 permanece parcialmente mitigado pero PENDIENTE de resolver mediante soporte condicional del proveedor o bloquear/limitar el flujo; no afirmar atomicidad.
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

## Implementación candidata y delta de diseño · corte 2026-10-30

La implementación está versionada en [KHORA PR #344](https://github.com/SeryMente/khora/pull/344), rama `feat/mcp-jules-f2-20261029-6c2f9a17`, head `ad7826a186ff9f74b51874aa4bae04725a2e33c4` al momento de esta revisión documental. Se mantiene en borrador y apilada sobre la PR de Custodia #340 para no introducir su base pendiente en `main` prematuramente.

- Las siete herramientas Jules se integran al servidor MCP existente `/api/mcp`; no se crea servidor paralelo.
- Se publican scopes separados `jules:read` y `jules:write`, sin agregarlos a los scopes predeterminados de otros clientes.
- ACL privada `khora_private.jules_source_acl`: coincidencia exacta `subject + source + branch`, permisos de lectura/escritura separados, denegación por defecto y fallo cerrado ante consulta no disponible. Se filtran fuentes, ramas y sesiones; consulta de actividades, mensaje y aprobación requieren una sesión cuyo contexto coincida con el grant exacto.
- Antes de crear una sesión, se valida un grant de escritura exacto, se llama a `sources.get` y se confirma la rama en `branches`/`defaultBranch`; de lo contrario `sessions.create` no se ejecuta.
- El adaptador conserva `pageToken`, elimina el helper heredado con cursor `createTime` y distingue GET/HEAD reintentables de POST no reintentables cuando el resultado es ambiguo.
- `jules_create_session` fuerza `requirePlanApproval=true` y `AUTO_CREATE_PR`; el estado se relee antes de enviar mensaje/aprobar.
- Tests sintéticos de ruta y cliente, fixtures ACL, control de branches/retry y doble preflight de aprobación están escritos y versionados. Se añadieron negativos de ACL caída, fuente/rama/sesión no autorizadas, cambios del plan por ID y por huella de contenido, y POST 429 sin replay.
- La migración `033_jules_source_acl.sql` está añadida al PR pero NO aplicada. No se concede permiso al rol productivo sin identificarlo y verificar que solo recibe `USAGE` y `SELECT` de la ACL privada.

**Validación real al corte:** UI Quality `41086322565` y CI `41086322753` para el head actual finalizaron con jobs `steps: null`; CI `41086312312` fue repetición adicional, también sin ejecutar steps. No hay logs de runner ni output de pruebas recuperable. Los checks Vercel fallan por la restricción de deploy de repositorios privados de organización en el plan actual. Por tanto, no hay evidencia de que el head compile ni de que los tests se hayan ejecutado. La llamada real de Jules, OAuth/aislamiento real, plugin publicado, escritura en ChatGPT Free, E2E, merge y despliegue siguen pendientes. T01–T32 permanecen PENDIENTE. T22 está parcialmente mitigado con ID/huella y doble lectura, pero no puede cerrarse atómicamente mientras `approvePlan` no acepte una precondición por plan.

El candidato anterior PR #338 ya no es el head vigente; permanece como evidencia histórica sin merge. La Fase 2 continúa EN CURSO, no aceptada.

## Dictamen de viabilidad

- Ciclo conversacional bidireccional asistente → Jules → asistente: **viable en diseño**, sujeto a credencial y cliente real.
- Fuente/branch validada server-side y aprobación de plan: **requisito obligatorio de implementación**.
- Responder en la misma sesión: **viable mediante sendMessage + relectura de activities**.
- Crear PR cuando Jules produzca un parche: **seleccionado para v1.0 mediante AUTO_CREATE_PR**; merge/deploy permanecen fuera del alcance.
- Uso nativo de escritura en el cliente/espacio real: **NO VERIFICADO**; sin plan/espacio compatible no puede afirmarse el flujo solicitado.
- Sondeo persistente fuera del turno: **requiere trabajador externo y queda fuera de v1.0**.
- Webhook de actividad: **no documentado en la referencia REST consultada**.
- MVP utilizable: **no aceptado** hasta completar suite, llamada real, cliente real y gates de release.