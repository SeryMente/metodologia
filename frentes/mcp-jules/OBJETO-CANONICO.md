# Objeto Canónico de Persistencia (OCP) · Frente MCP Jules

## 1. Control e identidad

- **Nombre canónico:** Frente MCP Jules.
- **Versión del artefacto:** v0.1.13 · decisión de ruta RDC/stdio, backlog provisional y aceptación T01–T38 · C-MCP-JULES-016.
- **Evento de creación:** C-MCP-JULES-001.
- **Folio de sesión vigente:** PENDIENTE / NO ASIGNADO (FOL1 inactivo); generación del control: 3. El folio anterior `SES-20261029-6C2F9A17` queda preservado en el historial.
- **OCP:** `SeryMente/metodologia/frentes/mcp-jules/`.
- **Repositorio de implementación:** `SeryMente/khora`, `khora-web`, servidor MCP existente.
- **Rama de documentación:** `feat/metacanon-mcp-jules-20261025-c32f81`.
- **Rama de implementación:** `feat/mcp-jules-f2-20261029-6c2f9a17`.
- **Estado:** titularidad operativa transferida y verificada en generación 3 dentro de esta rama; folio no asignado por FOL1 inactivo. Fase 1 sigue COMPLETA como diseño integral; Fase 2 sigue EN CURSO. Las herramientas Jules quedaron integradas en Khora main por PR #345 (merge `953e69484eabb4e8dc8221d1d8fc188373531bfa`); el puente local RDC/stdio OAuth 2.1/PKCE quedó integrado por PR #347 (merge `4530e03a33c5e1743ab9646eb6c862b3c458c605`). Los tests 568/568 y 572/572, TypeScript, UI Review y build 78/78 son históricos de PC-14, no pruebas frescas del dispositivo RDC actual. OAuth real, tools/list, lectura Jules y E2E siguen pendientes. El OCP está en v0.1.13 y su lista auxiliar es [LISTA-TAREAS-PROVISIONAL.md](LISTA-TAREAS-PROVISIONAL.md), v0.1, provisional. La crónica de actualización es [C-MCP-JULES-016](cronica/C-MCP-JULES-016.md).
- **Fuente de titularidad:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). No modifica ni sustituye el control del frente padre Metacanon.
- **Lista provisional de tareas:** [LISTA-TAREAS-PROVISIONAL.md](LISTA-TAREAS-PROVISIONAL.md), v0.1. Esta lista no es un segundo OCP/control; el detalle activo y los gates de Fase 2 se desglosan allí y en la matriz de aceptación T01–T38.

## 2. LEER PRIMERO

Este frente construye un puente para que ChatGPT delegue desarrollo en Jules, agente asíncrono de programación, pueda leer la retroalimentación y contestarla dentro de la misma sesión. El estado único de este trabajo está aquí; el código se integra en el servidor MCP ya existente de Khora.

Orden de uso: leer la fuente canónica Samantha/Metacanon/GOW; leer este OCP y su control; comprobar folio y titularidad; comprobar la revisión real del código en Khora; validar credenciales y permisos; ejecutar pruebas; actualizar crónica y aceptación; releer lo guardado. No afirmar ejecución, pruebas, merge, despliegue ni conexión a ChatGPT que no estén demostrados.

**MCP-NORMATIVO: DESACTIVADO** conforme al estado observado del frente Metacanon; se mantiene revisión manual de la cascada. La grafía «MSP» en el dictado se interpreta como «MCP» a partir del contexto explícito de este encargo y no se convierte en un sistema alternativo.

## 3. Referencia metodológica

- Fuente normativa única consultada en este ciclo: [Documento Único de Gobernanza (DUG) · Samantha v372 · NX-372m](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), rama `main`, SHA `28d0f255cdb3371a60310b0da45ca049dea05fdb`, leído el 2026-10-30.
- Marco de objetos canónicos: Metacanon **1.26**, sección integrada en el mismo documento normativo; se aplica ART-014/SPDF y §§42–48 pertinentes.
- Glosario Operativo del Workspace (GOW): **2.14**, integrado en el documento canónico.
- Control vigente del frente padre leído desde `main`: `frentes/metacanon/CONTROL-RESPONSABILIDAD.json`, blob `86f0e4fa59e37976704231290b460cf6dc9252b0`, generación 6, folio `SES-20261029-7F4A9C21`. No fue modificado por este ciclo.
- API de Jules: [referencia REST oficial](https://developers.google.com/jules/api/reference/rest), versión `v1alpha`.
- Conexión MCP en ChatGPT: [documentación oficial de OpenAI](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt).
- Investigación específica: [INVESTIGACION-API-JULES-CHATGPT.md](fuentes/INVESTIGACION-API-JULES-CHATGPT.md).
- La revisión de gobierno fue manual; no se declara verificación normativa automática.

## 4. Propósito y alcance

**Propósito dictado por el operador:** construir un frente de trabajo independiente dentro de Metacanon que defina e implemente la comunicación con Jules para entregar prompts de desarrollo, recuperar sus preguntas y solicitudes de retroalimentación, responderlas dentro de la misma sesión, investigar hasta qué punto puede automatizarse el proceso MCP y llegar a un producto mínimo viable replicable en los frentes sujetos a esta metodología. El original completo se conserva en [C-MCP-JULES-001-operador.txt](originales/C-MCP-JULES-001-operador.txt).

**Secuencia ratificada en este ciclo:** la primera fase es la planeación plena y completa del componente MCP Jules v1.0 para uso desde una cuenta ChatGPT Free, sin Codex. El plan define el comportamiento conversacional, el MCP central de Khora, los siete contratos, el ciclo Jules bidireccional, la distribución mediante plugin MCP público, OAuth 2.1, aislamiento por usuario/repositorio, seguridad y aceptación. La disponibilidad y escritura reales de ese plugin en Free siguen como gates de fases posteriores. La implementación posterior deberá reconciliarse contra [el plan integral v1.0](PLAN-INTEGRAL-MCP-JULES-v1.0.md).

### Arquitectura aprobada

El operador autorizó ampliar el servidor MCP existente de `SeryMente/khora`, sin crear un segundo servidor; añadir permisos separados `jules:read` y `jules:write`; conservar autenticación/ciclo normativo; mantener `JULES_API_KEY` solo en servidor; y exigir aprobación explícita del plan. En R2, el cliente requerido es ChatGPT Free y la distribución objetivo es un plugin MCP público conectado al mismo endpoint. Codex no se utilizará. La aprobación de arquitectura no equivale a autorización para publicar credenciales, desplegar sin prueba o fusionar sin revisión.

### Resultado esperado

Un asistente puede localizar fuentes de Jules, crear una sesión con prompt completo, consultar estado, leer actividades y mensajes de Jules, responder a una solicitud del agente sin reiniciar el trabajo, y aprobar un plan solo cuando la sesión espera aprobación. El sistema conserva IDs/cursor, estado, fuente, rama y último punto de comprobación.

### Incluido en el producto mínimo viable (MVP)

- Siete herramientas MCP en el servidor Khora existente.
- Plugin MCP público aprobado/publicado en el directorio de ChatGPT como superficie de instalación para ChatGPT Free; sujeto a prueba de capacidad real.
- Lectura de fuentes, sesiones individuales y actividades con paginación.
- Crear sesión forzando `requirePlanApproval=true`.
- Enviar respuesta a la misma sesión y recuperar después las actividades.
- Aprobar un plan únicamente cuando el estado real sea `AWAITING_PLAN_APPROVAL`.
- Scopes diferenciados de lectura/escritura y OAuth 2.1 del plugin; autorización por sujeto, fuente Jules, repositorio y rama.
- Pruebas positivas/negativas, seguridad de usuario/recurso, revisión/publicación del plugin, uso real en Free, límites de cuota, manejo seguro, guía y aceptación.
- Guía replicable que referencia un único servidor; sin copiar claves, servidor ni controles de responsabilidad.

### Fuera del MVP directo

- Codex, en cualquiera de sus superficies, como herramienta, cliente o fallback.
- GPT Actions o GPT personalizado como dependencia.
- Conexión MCP privada desde un plan distinto como sustituto de la ruta ChatGPT Free.
- Un segundo servidor especializado.
- Autorespuesta ilimitada o aprobación automática incondicional.
- Webhooks de actividades no documentados en la API oficial consultada.
- Garantizar que ChatGPT opere en segundo plano cuando la conversación no invoca herramientas.
- Un trabajador persistente de sondeo: queda como extensión viable sujeta a construir y desplegar infraestructura externa.
- Declarar credenciales configuradas, despliegue o conexión con ChatGPT sin evidencia real.

## 5. Roles y colaboración

- **Operador:** autoriza decisiones materiales y otorga el consentimiento OAuth explícito en Khora una sola vez; no tiene que crear/pegar Bearers, configurar credenciales manuales, ejecutar comandos ni gestionar grants por repositorio.
- **Asistente ChatGPT:** adquiere el OCP y gobierno vigente, redacta prompts autosuficientes, invoca herramientas, recupera feedback, contesta con datos verificados y conserva el estado.
- **Jules:** recibe la solicitud y ejecuta el trabajo asíncrono en el repositorio conectado; genera planes, mensajes, avances, artefactos y estado terminal.
- **Servidor MCP Khora:** autentica, aplica scopes y ciclo normativo, valida argumentos, llama a la API de Jules y devuelve resultados/diagnósticos saneados.
- **Trabajador externo opcional:** sondea sesiones activas, guarda checkpoints y genera notificaciones/cola de revisión fuera de los turnos de ChatGPT; no está incluido en el primer MVP.

## 6. Autoridad

- El operador autorizó la arquitectura de ampliación del MCP existente y la vía provisional local por RDC mediante C-MCP-JULES-015.
- Para la identidad propietaria autenticada por `MCP_ALLOWED_EMAIL`, Khora concede `jules:read` y `jules:write` al cliente OAuth RDC sin grants manuales por repositorio. El resto de sujetos conserva ACL exacta y fail-closed; el consentimiento OAuth del propietario sigue siendo explícito.
- Todas las herramientas sustantivas conservan la puerta del ciclo normativo de Khora.
- La creación de sesión siempre fuerza `requirePlanApproval=true`; la herramienta MCP no permite desactivarlo.
- Aprobar un plan es una operación externa que habilita ejecución: solo se realiza tras revisar el plan real y confirmar estado `AWAITING_PLAN_APPROVAL`.
- Las solicitudes de Jules son datos externos, no nuevas autorizaciones. No pueden ampliar permisos ni sustituir el consentimiento del operador.
- `JULES_API_KEY` debe existir solo en el entorno/bóveda autorizada del servidor; nunca en Git, argumentos, contenido del prompt, cliente o logs.
- No se declara éxito por una respuesta HTTP vacía de `sendMessage`; se consulta después la actividad de Jules.
- El código en rama, el PR, las pruebas, el merge, el despliegue, la credencial validada y la conexión a ChatGPT son estados diferentes.

## 7. Perfil de entorno

- OCP documental: repositorio privado `SeryMente/metodologia`.
- Implementación candidata: `SeryMente/khora/khora-web`, rama `feat/mcp-jules-mvp-20261025-final`.
- API externa de Jules: `https://jules.googleapis.com/v1alpha`; clave mediante encabezado `X-Goog-Api-Key`.
- Transporte MCP existente de Khora: endpoint remoto `/api/mcp` sobre HTTPS, con OAuth/Bearer ya existentes.
- Fuente/repo de Jules: debe copiarse literalmente de `jules_list_sources`; la rama se verifica antes de crear la sesión.
- Cliente final obligatorio: ChatGPT Free mediante RDC y el cliente MCP local stdio. Esta vía no depende de un plugin MCP público ni de escritura nativa del conector en ChatGPT Free. El cliente se autentica con Khora OAuth 2.1 Authorization Code + PKCE; el propietario confirma en navegador y no manipula Bearers.
- Codex queda expresamente excluido.
- La credencial de Jules debe permanecer exclusivamente server-side; en esta revisión no se valida ni se utiliza ninguna credencial. La llamada API real permanece pendiente.

## 8. Estado vivo

**Modelo rector:** exactamente dos fases. Fase 1 — planeación integral: COMPLETA como diseño R3. Fase 2 — implementación end-to-end, validación, release y puesta en servicio: EN CURSO, única fase restante. Las etapas internas no crean fases adicionales. El plan integral v1.0 se conserva como línea base histórica de alcance; la ruta de entrega de Fase 2 se ajustó mediante la decisión C-MCP-JULES-015.

**Fase 2 — puente actual:** [Khora PR #347](https://github.com/SeryMente/khora/pull/347), rama `feat/jules-rdc-local-bridge-20261030`, head `cda38145fd74b109703be24b6e3eda4c0998b15a`, abierta y no fusionada. Se sustituye la instrucción previa de Bearer manual por cliente MCP local stdio controlado por RDC y OAuth 2.1 Authorization Code + PKCE contra Khora. No se levanta un segundo servidor MCP ni un puerto permanente; el refresh token se cifra con DPAPI CurrentUser y `JULES_API_KEY` permanece en Khora Production. El propietario admitido por `MCP_ALLOWED_EMAIL` obtiene `jules:read` y `jules:write` sin grants por repositorio; otros sujetos conservan ACL exacta y fail-closed.

**Preview:** Vercel deployment `dpl_GdwKnsFJCo289dsCEfhyQaWPUJ2g` READY para el head de PR #347. Su URL de Preview está protegida por SSO del equipo; una petición anónima devuelve 302, por lo que la metadata OAuth no se validó por HTTP desde esta sesión. Production no se modificó ni desplegó.

**Validación local PC-14:** `npm ci` instaló 576 paquetes; Node bridge syntax, parser PowerShell 5.1, TypeScript, UI Review, contrato de navegación, DPAPI con fixture sintético y DCR loopback allowlist: PASS. Suite unitaria **572/572 PASS**. Build local Next.js 16.4.0: PASS, 78/78 páginas. El build final usó solo una clave AUTH_SECRET aleatoria/efímera en el entorno del proceso; no se persistió ni desplegó y se eliminó al finalizar. No se descargaron secretos de Vercel Production.

**Falta acreditar:** consentimiento OAuth real del propietario, conexión MCP autenticada, descubrimiento de las siete herramientas en `tools/list`, lectura real de fuentes/sesiones Jules y ciclo E2E. El primer smoke test será solo de lectura; no creará sesiones ni iniciará desarrollo. T22 sigue parcial porque Jules no ofrece aprobación condicional atómica por plan/ETag/If-Match; el doble preflight no se presenta como garantía transaccional.

**Documentación y titularidad:** el original `ChatGPT-JULES-20261030-1858.md` está preservado sin transformación en `documentos/originales/`, SHA-256 cotejado, con manifiesto y evidencia C015. La responsabilidad del frente está transferida y releída en generación 3, alias operativo no nativo; folio PENDIENTE/NO ASIGNADO por FOL1 inactivo. Ambos cambios se encuentran en la rama del PR documental #19, OPEN/DRAFT/NOT MERGED. No declarar `main` actualizado hasta integrar el PR.

## 9. Aceptación y viabilidad

| Requisito | Criterio verificable | Estado inicial |
|---|---|---|
| Listar fuentes Jules | Devuelve fuentes reales, solo ramas autorizadas y paginación correcta | Código y fixture actualizados para la rama default; CI no ejecutado y API real no probada |
| Listar/consultar sesiones | ID validado, estado y token de página correctos | Código y fixture ACL versionados; CI no ejecutado y API real no probada |
| Leer retroalimentación | Recupera `agentMessaged`, `userMessaged`, `planGenerated`, progreso, fallo/completado y paginación | Código/contrato versionados; CI no ejecutado y llamada real pendiente |
| Crear sesión | Fuente y rama verificadas; prompt completo; fuerza `requirePlanApproval=true` | `sources.get`, validación branch y fixture versionados; CI no ejecutado y API real pendiente |
| Responder | Mismo ID de sesión; envía solo en estado permitido; luego vuelve a consultar actividades | Código en rama; API real no probada |
| Aprobar plan | Rechaza salvo `AWAITING_PLAN_APPROVAL` y usa scope de escritura | Código en rama; prueba pendiente |
| Aislar permisos | Lectura no permite escribir; escritura no da acceso a lectura/otras funciones y la ACL exacta se aplica por sujeto/fuente/rama | Implementación y negativos versionados; test confirma JWT `sub` como sujeto ACL; CI no ejecutó steps, aislamiento real pendiente |
| Preservar gobierno | Las siete herramientas pasan por la validación del ciclo normativo | Código y fixture añadidos; ejecución pendiente |
| Proteger secretos | El secreto del proveedor permanece server-side y no aparece en respuestas, prompts, logs ni repositorio | Rutas de fuente y sesión se redactan antes de observabilidad; test versionado, CI no ejecutado, llamada real pendiente |
| Uso real mediante RDC en ChatGPT Free | Cliente MCP local stdio autenticado por OAuth Khora, descubrimiento de siete herramientas y lectura E2E de fuentes/sesiones | Pendiente de consentimiento OAuth real y smoke test autenticado |
| Automatización persistente | Proceso programado con checkpoint, idempotencia y recuperación tras reinicio | Fuera de alcance hasta aprobar implementación del trabajador |

**MVP realmente utilizable:** exige suite aprobada, API Jules real, plugin aprobado/publicado, instalación en cuenta ChatGPT Free real, OAuth/aislamiento por sujeto, escritura no destructiva, E2E bidireccional y release autorizado. Sin ello es candidato, no producción aceptada.

## 10. Formato de ciclo

Aplicar Metacanon §4 en cada ciclo sustantivo: identidad/gobierno; dónde estamos; delta; avance y evidencia; pendientes; viabilidad; siguiente hito; siguiente acción; continuación/prompt; persistencia y lectura de vuelta. Cada cambio se registra en `cronica/`; originales del operador y salidas visibles disponibles se conservan en `originales/` con procedencia. Diferenciar tests sintéticos, pruebas locales, llamadas reales a Jules, CI, merge y despliegue.

## 11. Crónica y fuentes

- [Ciclo de creación C-MCP-JULES-001](cronica/C-MCP-JULES-001.md).
- [Ciclo de transferencia y estado C-MCP-JULES-005](cronica/C-MCP-JULES-005.md).
- [Ciclo histórico C-MCP-JULES-006](cronica/C-MCP-JULES-006.md) — apertura de la fase de planeación.
- [Ciclo histórico C-MCP-JULES-007](cronica/C-MCP-JULES-007.md) — cierre R1.
- [Ciclo histórico C-MCP-JULES-008](cronica/C-MCP-JULES-008.md) — cierre R2, requisito Free y no Codex.
- [Ciclo de implementación C-MCP-JULES-010](cronica/C-MCP-JULES-010.md) — antecedente de PR #344 y ACL.
- [Retoma RDC, captura original y transferencia C-MCP-JULES-015](cronica/C-MCP-JULES-015.md).
- [Plan integral del componente MCP Jules v1.0](PLAN-INTEGRAL-MCP-JULES-v1.0.md) — línea base de diseño completa; la implementación y validación siguen pendientes.
- [Texto original del operador](originales/C-MCP-JULES-001-operador.txt).
- [Exportación original ChatGPT-JULES-20261030-1858.md](documentos/originales/ChatGPT-JULES-20261030-1858.md) — original preservado y verificado por SHA-256; [manifiesto documental](documentos/MANIFIESTO-DOCUMENTAL.json).
- [Investigación de API, ChatGPT y automatización](fuentes/INVESTIGACION-API-JULES-CHATGPT.md).
- [Plan de aceptación](pruebas/PLAN-ACEPTACION-MVP.md).
- [Contrato de uso por el asistente](prompts/ASISTENTE-MCP.md).
- [Contrato para prompts a Jules](prompts/JULES-CONSTRUCTOR.md).
- [Guía de replicación](replicacion/GUIA-REPLICACION-FRENTES.md).
- [Implementación candidata actual en Khora · PR #344](https://github.com/SeryMente/khora/pull/344) y [rama](https://github.com/SeryMente/khora/tree/feat/mcp-jules-f2-20261029-6c2f9a17).

## 12. Reinstanciación

En una sesión nueva, leer este núcleo y [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json), cotejar generación 3 y el estado de folio pendiente, y revisar [C-MCP-JULES-015](cronica/C-MCP-JULES-015.md) como última crónica, sin saltarse el control y la matriz de aceptación.

No adquirir, transferir ni modificar el control de `frentes/metacanon/`; el frente MCP Jules es independiente. No copiar a otros OCP el control, la credencial, la titularidad ni un estado vivo alternativo.

## 13. Persistencia y revisión

Guardar cambios en las ramas correspondientes, cotejar cada escritura por lectura de vuelta y registrar revisiones. Este OCP no es el documento normativo de Metacanon y no altera el canon de gobernanza. La replicación consiste en referenciar el servidor MCP común y aplicar el patrón a cada frente, no en desplegar una copia de servidor por proyecto.

Al cierre de un ciclo:
1. cotejar aceptación contra outputs reales;
2. actualizar estado vivo, crónica y pendientes;
3. leer de vuelta el contenido y las rutas;
4. actualizar [INVENTARIO-REPOSITORIOS-Y-FRENTES.md](../../INVENTARIO-REPOSITORIOS-Y-FRENTES.md);
5. separar en la salida lo probado, lo reportado y lo no verificado.

## 14. Retoma RDC, persistencia documental y transferencia — C-MCP-JULES-015

Este ciclo registra dos instrucciones directas del operador: la sesión RDC activa es la única sesión local que debe utilizarse y asume el frente; no se solicitará un Bearer manual ni comandos manuales. El puente elegido es un cliente MCP local stdio controlado por RDC, autenticado mediante Khora OAuth 2.1 PKCE. La única interacción humana inicial es el consentimiento OAuth explícito en el navegador de Khora.

El original `ChatGPT-JULES-20261030-1858.md` fue preservado en `documentos/originales/`; el SHA-256 local y la descarga de vuelta coinciden exactamente: `B7D25FF3CBF233787D201AB0D7643E45C181EAE4430E3300876BCFE8CF3B1737`. Su entrada documental está en `documentos/MANIFIESTO-DOCUMENTAL.json`; el recibo de captura y transferencia está en [evidencias/C-MCP-JULES-015.json](evidencias/C-MCP-JULES-015.json).

La titularidad del único control del frente se actualizó condicionalmente desde generación 2 a 3, preservando el evento previo. Propietario operativo: `chatgpt-C-MCP-JULES-015-01a18f95-61cf-70ce-9321-c56fbd3cc99d`; instancia: `chatgpt-mcp-jules-2026-10-30-01a18f95`. No se expuso un ID nativo de ChatGPT. `session_folio=null`; FOL1 inactivo, folio global/OCP pendiente. El control padre Metacanon no se modificó.

La captura del original, el manifiesto, la crónica y el control quedan guardados y releídos en `feat/metacanon-mcp-jules-20261025-c32f81`, PR #19. **Estado de integración: pendiente**. El contenido no se presenta como canónico en `main` hasta que el PR documental se integre y relea.


## 15. Decisión operativa y reconfiguración de tareas · C-MCP-JULES-016 · 2026-11-06

### 15.1 Ruta de integración vigente

La ruta plugin MCP público mencionada en el plan original queda SUPERSEDIDA. El uso objetivo de ChatGPT Free es mediante cliente MCP local stdio operado por RDC y autenticado con OAuth 2.1 Authorization Code + PKCE contra Khora. No se exige un plugin público, un endpoint público adicional, MCP personalizado nativo con escritura ni manipulación manual de Bearers.

### 15.2 Separación de productos

MCP-OCP construye un servidor local de Metodología en SeryMente/metodologia, independiente y de propiedad exclusiva de su OCP. Khora conserva su servidor MCP único /api/mcp y las siete herramientas Jules. El bridge local de Jules es un cliente separado que conecta a Khora por OAuth. No se duplica servidor, endpoint, API key, refresh token, access token, ACL ni control entre frentes.

### 15.3 Código integrado y límites de evidencia

- PR #345 integró siete herramientas Jules y ACL por recurso en Khora main; merge commit 953e69484eabb4e8dc8221d1d8fc188373531bfa.
- PR #347 integró bridge local RDC/stdio OAuth 2.1/PKCE en Khora main; merge commit 4530e03a33c5e1743ab9646eb6c862b3c458c605.
- Las suites 568/568 y 572/572, TypeScript, UI Review y build 78/78 se conservan como resultados históricos de PC-14. No acreditan pruebas frescas en PC10RCIF4EI4.
- En el perfil RDC activo PC10RCIF4EI4, la preparación local del bridge y el consentimiento OAuth real no se han ejecutado en este ciclo.
- tools/list autenticado, lectura real de fuentes/sesiones/actividades, escrituras y E2E permanecen NO VERIFICADOS.
- No se creó sesión Jules ni se invocaron herramientas de escritura en este ciclo.

### 15.4 Configuración del backlog

Se crea LISTA-TAREAS-PROVISIONAL.md v0.1. Incluye diez tareas ordenadas: reconciliación de arquitectura, preparación del bridge, consentimiento OAuth, smoke de solo lectura, verificación de seguridad/scopes, E2E sandbox, T22/reintentos, coexistencia con MCP-OCP, aceptación y reconciliación documental. La matriz de aceptación se amplía de T01–T32 a T01–T38. Las fases del proyecto siguen siendo exactamente dos; no se inventa una tercera fase.

### 15.5 Pausa de uso de Jules

Por instrucción del operador, no se invoca Jules ni se crean sesiones hasta que el backlog y sus criterios queden configurados y el operador ordene reanudar. Esta actualización completa la configuración documental inicial; no inicia el smoke OAuth ni el E2E. El consentimiento de navegador sigue siendo explícito y se solicitará en el momento de uso.

### 15.6 Titularidad y autorización

Esta actualización usa únicamente la autorización puntual del operador para modificar tareas provisionales, plan y criterios de aceptación de MCP-Jules con el fin de alinearlos a MCP-OCP. No se cambia CONTROL-RESPONSABILIDAD.json, su generación 3 ni su titular. No se modifica Khora main, código, secretos, configuración Production, EP, Metacanon ni el control padre. La PR documental #19 permanece abierta; la integración a Metodología main requiere revisión y autorización de merge separadas. La crónica y el recibo de esta actualización están en [C-MCP-JULES-016](cronica/C-MCP-JULES-016.md) y [evidencia C-MCP-JULES-016](evidencias/C-MCP-JULES-016.json).
