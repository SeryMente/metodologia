# Plan integral del componente MCP Jules v1.0

**Versión del plan:** 1.0  
**Frente:** MCP Jules  
**Fase vigente:** Fase 1 — planeación integral; no implementación.  
**Fecha de corte documental:** 2026-10-29  
**OCP:** `frentes/mcp-jules/`  
**Control de responsabilidad:** `CONTROL-RESPONSABILIDAD.json`, generación 2, folio `SES-20261029-6C2F9A17`.  
**Gobierno consultado:** Documento Único de Gobernanza (DUG) Samantha v360 · NX-360m; Metacanon 1.24; GOW 2.9, leídos desde `SeryMente/metodologia/main`.  
**Estado:** línea base de diseño para revisión; no equivale a código aceptado, API validada, conexión de ChatGPT, despliegue ni release.

## 1. Decisión de fase

La primera fase del frente es la **planeación plena y completa del componente MCP Jules en su versión 1.0**. Esta fase define propósito, arquitectura, alcance funcional, contratos de herramientas, estados y ciclos, seguridad, operación, pruebas, aceptación, despliegue, recuperación, exclusiones y decisiones de viabilidad.

Durante esta fase no se añade ni modifica código de producto, no se despliega ni se fusiona por el solo hecho de que exista una rama candidata. Las PR existentes se usan como evidencia y material de comparación, no como prueba de que el diseño ya esté completo o funcione.

La fase 1 se considera cerrada cuando el plan tenga trazabilidad entre requisitos, arquitectura y aceptación, y cada bloqueo material figure como resuelto con evidencia o como decisión explícita pendiente del operador. La implementación y su validación pertenecen a fases posteriores.

## 2. Propósito del componente

MCP Jules debe funcionar como una integración de herramientas adicional, disponible para ChatGPT junto con otras integraciones como Remote Desktop Commander (RDC). Dentro del flujo activo de una conversación, ChatGPT podrá seleccionar e invocar las herramientas MCP para delegar trabajo de desarrollo a Jules, consultar lo que está ocurriendo, recuperar preguntas o solicitudes de retroalimentación y responderlas dentro de la misma sesión.

La función principal no es simplemente enviar un prompt. Es cerrar el ciclo:

**ChatGPT analiza y formula → Jules planea → el operador aprueba el plan → Jules ejecuta → ChatGPT recupera actividad y preguntas → ChatGPT responde con contexto verificado → Jules continúa → ChatGPT comprueba la entrega.**

La integración se invoca como una aplicación/herramienta MCP disponible en el ciclo activo de resolución de problemas de ChatGPT, de modo análogo a otras herramientas como RDC. Para ejecutar una acción nueva, el usuario debe tener el app disponible y seleccionado/mencionado en el mensaje correspondiente; la selección de una app no garantiza que se invoque automáticamente en todos los turnos. Esto describe el uso de herramientas durante la resolución, no acceso a un proceso de razonamiento privado invisible. El modo Agent no se considera runtime objetivo para esta v1.0 y la investigación profunda solo admite lectura/recuperación, no escritura, conforme a la documentación actual de OpenAI.

## 3. Resultado esperado de v1.0

La versión 1.0 debe permitir que un asistente autorizado:

1. Descubra las fuentes de Jules accesibles y seleccione un repositorio devuelto realmente por la API.
2. Compruebe la fuente y la rama antes de iniciar una sesión.
3. Formule una instrucción de desarrollo autosuficiente con objetivo, contexto canónico, alcance, exclusiones, criterios de aceptación, pruebas y formato de entrega.
4. Abra una sesión Jules en la fuente y rama seleccionadas, forzando en el servidor `requirePlanApproval=true`.
5. Consulte las sesiones, el estado actual, las actividades y la paginación.
6. Recupere el plan generado y espere una aprobación explícita antes de que Jules comience la ejecución.
7. Detecte solicitudes de información de Jules, conteste a la misma sesión y vuelva a consultar actividades; un POST aceptado no se trata como prueba de que Jules ya respondió.
8. Continúe el ciclo sin abrir una sesión sustituta por defecto y sin repetir preguntas ya resueltas.
9. Recupere la entrega final, PR/artefactos y estado terminal cuando la API los exponga; inspeccione y verifique lo que esté realmente disponible.
10. Persista un checkpoint de cada ciclo en la crónica del OCP y mantenga el estado vivo resumido en el núcleo único.
11. Devuelva errores seguros y accionables, sin divulgar credenciales ni cuerpos externos arbitrarios.
12. Reutilice el único servidor MCP existente de Khora para los frentes autorizados, sin desplegar un servidor por frente.

## 4. Límites y exclusiones

### Incluido en v1.0

- Siete herramientas MCP para lectura de fuentes/sesiones/actividades y para crear, responder y aprobar planes.
- Creación de sesión con `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR`, ambos establecidos por el servidor y no elegibles como parámetros libres del asistente; la API marca ambos campos como input-only.
- Verificación de fuente/branch dentro del servidor contra el recurso fuente actual de Jules antes de crear sesión.
- PR automático por Jules como artefacto de salida permitido tras aprobar el plan; nunca auto-merge ni auto-deploy.
- Integración en la ruta MCP existente de Khora.
- Autenticación ChatGPT → Khora mediante el mecanismo OAuth/Bearer existente.
- Autenticación Khora → Jules mediante `JULES_API_KEY` guardada exclusivamente en el entorno seguro del servidor.
- Scopes diferenciados `jules:read` y `jules:write`, dentro del contrato de autorización que ya emplea Khora.
- Compatibilidad con el ciclo normativo existente de Khora, sus tokens/controles y diagnósticos.
- Paginación, validación de identificadores, errores estandarizados y pruebas positivas y negativas.
- Uso interactivo desde un cliente ChatGPT real que admita las capacidades de escritura necesarias.
- Registro de sesión, fuente, rama, eventos, checkpoints, resultados, fallos y siguiente paso en el OCP.

### Excluido de v1.0

- Un segundo servidor MCP o un servidor dedicado por proyecto.
- Un trabajador permanente que sondee Jules cuando ChatGPT está inactivo.
- Webhooks de actividad que no estén documentados y disponibles en la API usada.
- Autorespuesta ilimitada, aprobación automática del plan o delegación que amplíe permisos.
- Merge, despliegue a producción o cambios de arquitectura realizados solo porque Jules los proponga.
- Copiar la clave de Jules, tokens de ChatGPT, credenciales o secretos al prompt, cliente, Git, evidencia o logs.
- Garantizar disponibilidad permanente de ChatGPT, ejecución en segundo plano o invocación de herramientas en cada ciclo.
- Usar herramientas MCP de escritura desde Agent mode o Deep Research como si fueran equivalentes al chat conversacional normal.
- Declarar que todos los repositorios de la organización están conectados a Jules sin comprobar la lista de fuentes.

El sondeo persistente, notificaciones, políticas de respuesta automática acotada y orquestación ampliada de PR/CI son posibles evoluciones posteriores, no condiciones implícitas de v1.0.

## 5. Arquitectura lógica

```text
ChatGPT — conversación activa / selector de herramientas
  │  MCP remoto HTTPS + autenticación de usuario
  ▼
Servidor MCP existente de KHORA
  ├─ autenticación OAuth/Bearer y validación del token
  ├─ autorización por scope de cada herramienta
  ├─ controles del ciclo normativo existente
  ├─ validación de argumentos y nombres de recursos
  ├─ diagnóstico saneado, límites y manejo de errores
  └─ cliente Jules (sin credenciales en el cliente)
        │  HTTPS + X-Goog-Api-Key
        ▼
Jules REST API v1alpha
  ├─ sources (list/get; validación interna de source y branch)
  ├─ sessions
  └─ sessions/{session}/activities
        │
        ▼
Respuesta de herramienta a ChatGPT
  ├─ lectura y evaluación del estado
  ├─ aprobación humana cuando proceda
  ├─ respuesta de retroalimentación en la misma sesión
  └─ verificación y registro del ciclo en frentes/mcp-jules/
```

Se conserva una sola ruta MCP de Khora: `/api/mcp`. El componente Jules es una familia de herramientas y un cliente de proveedor integrado en el servidor existente, no un servidor separado. El estado del proyecto, el código del producto, el control de responsabilidad y las credenciales tienen autoridades y ubicaciones distintas.

### Separación de credenciales

- **ChatGPT → Khora:** OAuth/Bearer y scopes emitidos por el sistema de autenticación de Khora.
- **Khora → Jules:** `JULES_API_KEY`, solo en el servidor.
- Los scopes `jules:read` y `jules:write` habilitan conjuntos diferentes de herramientas. Ninguno debe añadirse implícitamente al conjunto predeterminado de tokens existentes.
- La integración mantiene los controles normativos que requiera la ruta MCP. La matriz exacta de scopes de negocio, control normativo y token de turno se fija contra el contrato real del servidor durante la revisión de diseño y pruebas.

## 6. Contrato funcional de las siete herramientas

| Herramienta | Scope de negocio | Responsabilidad | Reglas principales |
|---|---|---|---|
| `jules_list_sources` | `jules:read` | Enumerar las fuentes reales accesibles y sus páginas. | Limitar `page_size` a 1–100; preservar `nextPageToken`; no inventar fuentes. |
| `jules_list_sessions` | `jules:read` | Enumerar sesiones accesibles y su paginación. | Validar límites y tokens de página; no inferir sesiones ausentes. |
| `jules_get_session` | `jules:read` | Leer estado, tiempos, URL y outputs de una sesión. | Normalizar ID de sesión; no aceptar URL o ruta arbitraria. |
| `jules_list_activities` | `jules:read` | Leer mensajes, plan, progreso, errores, salida y eventos. | Paginación completa; distinguir respuesta parcial, página final y error. |
| `jules_create_session` | `jules:write` | Crear una sesión con fuente, rama y prompt. | El servidor reconsulta el recurso fuente y valida rama; fuerza `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR`. |
| `jules_send_message` | `jules:write` | Enviar respuesta a una sesión existente. | Verificar ID/estado; proteger contra reenvío ciego tras timeout; luego releer actividades. |
| `jules_approve_plan` | `jules:write` | Aprobar el plan de una sesión. | Exigir estado `AWAITING_PLAN_APPROVAL`, plan leído y autorización explícita; rechazar otros estados. |

La API oficial de Jules enumera operaciones para listar fuentes, crear/listar/consultar sesiones, leer actividades, enviar mensajes y aprobar un plan. La sesión incluye estado, `requirePlanApproval` y `automationMode`; si `requirePlanApproval` no se establece, la documentación indica que el plan puede aprobarse automáticamente. Ambos parámetros de política son input-only. La v1.0 fija `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR` en el servidor, no en los argumentos libres del asistente. La API consultada es `v1alpha`, por lo que su contrato debe revalidarse antes del desarrollo y release.

## 7. Ciclo operativo detallado

### 7.1 Preparación y delegación

1. Leer este plan, el núcleo del frente solicitante y su fuente canónica.
2. Confirmar autorización para actuar sobre el repositorio destino.
3. Llamar a `jules_list_sources`; elegir una fuente de la respuesta real y comprobar la rama candidata.
4. Construir el prompt a partir de hechos comprobados: propósito, estado, alcance, exclusiones, restricciones, aceptación, pruebas y formato de entrega.
5. El servidor vuelve a consultar el recurso exacto de fuente en Jules y confirma que el nombre coincide y que `startingBranch` aparece en `branches[]` (o en la rama predeterminada expuesta). Si la fuente/branch no puede verificarse, falla cerrado y no llama a `sessions.create`.
6. Llamar a `jules_create_session`; el servidor fuerza `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR`.
7. Guardar el ID/nombre/URL devueltos y consultar estado/actividades hasta que el plan pueda revisarse. La creación no autoriza ejecución. No se ejecuta un bucle persistente oculto.

### 7.2 Aprobación del plan

1. Leer el estado real y la actividad más reciente que contiene el plan; conservar ID y fecha de creación del plan.
2. Comparar el plan con objetivo, permisos, repo, rama, alcance, riesgos y criterios de aceptación.
3. Presentar al operador los pasos/riesgos y esperar confirmación explícita sobre ese plan específico. No inferir aprobación a partir del silencio, de la creación de la sesión ni de una aprobación de otro plan.
4. Volver a leer la sesión y las actividades inmediatamente antes de aprobar. Si el estado dejó de ser `AWAITING_PLAN_APPROVAL` o el último plan cambió, bloquear la aprobación y volver a presentar el plan actualizado para obtener confirmación.
5. Ejecutar `jules_approve_plan` solo si la sesión sigue en `AWAITING_PLAN_APPROVAL` y la confirmación del operador corresponde al plan actual.
6. Volver a consultar estado/actividades. La respuesta de aprobación puede ser vacía y no sustituye la verificación posterior.

La API de aprobación recibe solo el ID de sesión, no el ID/hash del plan. La relectura minimiza la carrera, pero no constituye una transacción atómica entre la revisión humana y la aprobación en Jules. El servidor comprueba estado; no puede probar criptográficamente quién escribió la confirmación en el chat. Si se exige una barrera independiente del cliente, eso requerirá una superficie de aprobación con recibo de un solo uso fuera del MVP directo.

Un plan que expanda alcance, introduzca secreto, requiera permisos nuevos, incluya acciones destructivas, merge/deploy no autorizado o carezca de información esencial no se aprueba por inferencia.

### 7.3 Seguimiento y retroalimentación

1. Leer `jules_get_session` y `jules_list_activities`, siguiendo `nextPageToken` cuando exista. `pageSize` debe estar entre 1 y 100; usar el `pageToken` documentado y no un cursor `createTime` no documentado.
2. Distinguir el evento original de Jules, la interpretación de ChatGPT y la comprobación independiente.
3. Ante una petición de información, recuperar el mensaje literal y compararlo con el OCP/fuentes.
4. Si la respuesta está verificada y permanece dentro del alcance, contestar con `jules_send_message` en el mismo ID de sesión.
5. Si falta un dato o la pregunta cambia una decisión material, escalarla al operador.
6. Volver a leer actividades después de cada envío y registrar el último checkpoint. El endpoint `sendMessage` devuelve cuerpo vacío si lo acepta; no afirmar que Jules respondió solo por el POST.
7. Reanudar desde el último estado comprobado. No duplicar sesiones o mensajes por una respuesta de red ambigua sin consultar primero el estado.

### 7.4 Cierre

1. Consultar estado terminal y outputs/PR expuestos por Jules.
2. Verificar el repositorio, rama, archivos y pruebas accesibles por herramientas autorizadas.
3. La configuración `AUTO_CREATE_PR` permite que Jules cree una rama/PR cuando genera un parche final aplicable; un PR no implica merge ni despliegue.
4. No equiparar “Jules completó” con “cambio aceptado”.
5. Registrar resumen, evidencia literal necesaria, revisión/commit/PR, pruebas, fallos, riesgos, bloqueos y siguiente paso.
6. Actualizar el núcleo solo con el resumen vivo necesario y conservar detalle cronológico en la crónica; leer de vuelta cada cambio persistido.

### 7.5 Política de reintentos de escrituras

Las lecturas GET pueden usar reintentos acotados con backoff. Las escrituras `sessions.create`, `sendMessage` y `approvePlan` no se reintentan automáticamente ante timeout de red o 5xx ambiguo, porque la API no documenta clave de idempotencia y algunas respuestas de éxito son vacías. Ante resultado ambiguo, consultar sesión/actividades y registrar `WRITE_RESULT_AMBIGUOUS`; si no puede determinarse si el efecto ocurrió, solicitar decisión explícita antes de repetir. El 429 se registra como `JULES_RATE_LIMITED`; cualquier reintento de escritura requiere reconciliación previa, no retry automático.

## 8. Modelo de estados y decisiones

Los estados reportados por la API consultada incluyen `QUEUED`, `PLANNING`, `AWAITING_PLAN_APPROVAL`, `AWAITING_USER_FEEDBACK`, `IN_PROGRESS`, `PAUSED`, `FAILED` y `COMPLETED`. Son estados externos informados por Jules; no deben recrearse ni “corregirse” localmente si el proveedor devuelve un valor inesperado.

| Estado observado | Acción de ChatGPT |
|---|---|
| `QUEUED` / `PLANNING` | Consultar actividades cuando proceda; no afirmar que el agente está ejecutando cambios. |
| `AWAITING_PLAN_APPROVAL` | Leer plan y solicitar aprobación explícita; no aprobar automáticamente. |
| `AWAITING_USER_FEEDBACK` | Recuperar la solicitud y responder solo con datos verificados; escalar lo material. |
| `IN_PROGRESS` | Recuperar progreso y actividad; no repetir instrucciones por defecto. |
| `PAUSED` | Identificar la causa reportada y decidir el siguiente paso según lo autorizado. |
| `FAILED` | Registrar error, consultar la actividad pertinente y preparar diagnóstico; no reintentar escrituras a ciegas. |
| `COMPLETED` | Leer outputs y validar el resultado independientemente; no presumir aceptación. |
| Estado vacío/desconocido | Detener acciones dependientes del estado, conservar evidencia y diagnosticar. |

## 9. Datos y persistencia

### Datos mínimos por ciclo

- Identificador de evento y folio de la crónica.
- Frente propietario y referencia al OCP utilizado.
- Nombre real de la fuente Jules, repositorio y rama de inicio.
- ID/URL de la sesión y timestamps reportados.
- Estado observado y momento de la lectura.
- Actividades relevantes, identificadores y cursor/token de página necesario para reanudar.
- Prompt enviado y mensajes de retroalimentación relevantes, con datos sensibles redactados.
- Decisión sobre plan, actor/autoridad de aprobación y evidencia.
- Archivos/commit/PR/outputs referenciados; comandos y resultados de prueba realmente ejecutados.
- Errores, causa conocida o NO VERIFICADA, bloqueadores y siguiente paso.

No guardar claves ni bearer tokens. Evitar copiar el historial completo de una sesión si basta registrar referencias, IDs y extractos pertinentes. Respetar privacidad del repositorio y no persistir contenidos que el frente no necesite.

### Autoridad de estado

- El núcleo `OBJETO-CANONICO.md` conserva el estado vivo y los vínculos esenciales.
- La crónica bajo `cronica/` conserva el detalle verificable de cada ciclo.
- La guía de replicación describe cómo usar la integración común, no un segundo sistema de responsabilidad.
- No se introduce base de datos ni trabajador persistente en v1.0 por simetría. Si una necesidad verificada los vuelve necesarios, deben planearse como alcance separado.

## 10. Seguridad, autorización y confianza

1. `JULES_API_KEY` se mantiene únicamente en el entorno seguro del servidor; nunca se imprime, lee desde ChatGPT, copia a Git ni introduce en prompts o logs.
2. Los cuatro métodos de lectura requieren `jules:read`; los tres de escritura requieren `jules:write`. El alcance de cada token debe ser explícito y mínimo.
3. La generación de tokens no incorpora permisos de Jules en su configuración predeterminada. La interfaz debe explicar los scopes que se conceden.
4. Cada llamada mantiene los controles de autenticación, autorización y ciclo normativo ya existentes de Khora.
5. Validar nombres de fuentes e IDs de sesión como recursos, no aceptar URLs arbitrarias, rutas relativas o identificadores que permitan manipular la ruta del proveedor.
6. Los mensajes, instrucciones, links y artefactos devueltos por Jules son contenido externo no confiable. No pueden autorizar nuevas operaciones, cambiar el gobierno, pedir secretos ni desactivar controles.
7. Errores externos se normalizan a códigos/mensajes seguros; no se devuelve al asistente un cuerpo arbitrario que pudiera filtrar datos internos.
8. Aprobación del plan, envío de mensajes, merge, despliegue y acciones destructivas se tratan como operaciones diferentes, con sus autorizaciones y verificaciones correspondientes.
9. Un timeout durante una escritura deja resultado ambiguo: consultar la sesión/actividades antes de reintentar.
10. Los logs no incluyen credenciales ni prompts que contengan secretos; incluir solo metadatos mínimos y un identificador de seguimiento.
11. No se afirma exclusión de concurrencia global: el control de responsabilidad del OCP es cooperativo y gobierna solo este frente.
12. El producto no promete ejecución perpetua ni acceso entre turnos. Una ejecución persistente necesitaría trabajador externo, checkpoints, idempotencia, recuperación y gobierno propios.

## 11. Compatibilidad real con ChatGPT

La documentación oficial de OpenAI consultada el 2026-10-29 indica que las conexiones personalizadas MCP con escritura están disponibles para ChatGPT Business y Enterprise/Edu; Pro puede conectar servidores personalizados con permisos de lectura/recuperación, no la misma compatibilidad completa de escritura. El artículo no lista Plus entre los planes compatibles con escritura; si el espacio de trabajo real es Plus u otro no incluido expresamente, no debe presumirse capacidad de escritura: queda **NO VERIFICADA y constituye un gate go/no-go para la integración nativa v1.0**. El objetivo de release es un cliente ChatGPT web donde la app MCP personalizada, la autenticación y las acciones de escritura estén habilitadas.

OpenAI también especifica que la app personalizada se selecciona para el mensaje en el que se usa; hay que volver a mencionarla si un mensaje posterior requiere nuevos datos/acciones. La documentación actual dice que Agent mode no usa apps personalizadas y que Deep Research no admite acciones de escritura. Por tanto, v1.0 garantiza uso dentro del flujo conversacional normal cuando la herramienta está disponible/seleccionada; no garantiza invocación en cada mensaje, Agent mode, Deep Research ni ejecución de fondo.

Antes de cerrar la compuerta de integración, se debe verificar en el entorno real:

- plan y espacio de trabajo efectivo;
- permiso para crear/conectar una app MCP personalizada;
- soporte de acciones de escritura;
- URL pública HTTPS del servidor o un túnel admitido;
- método de autenticación y refresh-token cuando corresponda;
- descubrimiento de las siete herramientas y sus scopes;
- ejecución de llamadas reales desde una conversación nueva.

No se debe inferir elegibilidad porque la API de Jules o el servidor Khora sean técnicamente viables. Si el cliente/plan no habilita escritura, la integración nativa del objetivo de v1.0 no es viable en ese cliente hasta resolver una vía compatible; no se presenta la lectura-only como sustituto equivalente.

## 12. Requisitos no funcionales

| Área | Requisito verificable |
|---|---|
| Seguridad | Secretos solo en servidor; scopes mínimos; validación de estado e IDs; respuestas saneadas. |
| Compatibilidad | Los controles existentes y las demás herramientas MCP de Khora no se degradan. |
| Confiabilidad | Paginación completa, timeout controlado, backoff para rate limit/errores transitorios y consulta antes de reintentar escrituras ambiguas. |
| Trazabilidad | Cada ciclo tiene IDs, fecha, fuente, sesión, estado observado, decisión, prueba y checkpoint persistidos. |
| Recuperación | Una nueva conversación puede retomar el ciclo desde OCP/IDs/estado confirmado, sin reconstruirlo de memoria. |
| Observabilidad | Diagnósticos diferenciados para clave ausente, rechazo de autenticación/permisos, rate limit, fallo externo, timeout, ID inválido y estado incompatible. |
| Mantenibilidad | Cliente Jules separado del handler común; contratos, tipos y pruebas alineados; no crear ruta/servidor paralelo. |
| Privacidad | Persistir la evidencia mínima necesaria; sin secretos ni datos privados superfluos en logs/crónicas. |
| Transparencia | Separar pruebas sintéticas, tests locales, CI, llamada Jules real, conexión ChatGPT, despliegue y aceptación funcional. |
| Coste/control | No introducir sondeo permanente en v1.0; evitar bucles de polling sin límite ni reintentos de escritura duplicados. |

## 13. Plan de pruebas y aceptación

La aceptación exige evidencia real. Un test que utiliza mocks no acredita conectividad con Jules; un PR abierto no acredita merge; un deployment preview no acredita producción; y la presencia de la variable no acredita una clave válida.

| ID | Prueba | Condición de aceptación |
|---|---|---|
| T01 | Contratos MCP | Las siete herramientas se descubren con schemas y metadata válidos. |
| T02 | No regresión | Las herramientas existentes de Khora mantienen contratos y permisos; suite completa ejecutada. |
| T03 | Autorización | Sin scope requerido, una herramienta no llama al cliente Jules. |
| T04 | Ciclo normativo | Las herramientas sustantivas respetan el contrato real de token/turno y su liberación. |
| T05 | Fuente/branch | Solo se usan recursos devueltos/verificados; rechazar identificadores inválidos. |
| T06 | Payload de creación | Test de contrato demuestra que el servidor envía `requirePlanApproval=true` y `automationMode=AUTO_CREATE_PR`; no se depende de que la API devuelva esos campos input-only. |
| T07 | Estado de aprobación | El endpoint de aprobación rechaza cualquier estado distinto de `AWAITING_PLAN_APPROVAL`. |
| T08 | Retroalimentación | Leer una solicitud real, responder en la misma sesión y verificar actividad posterior. |
| T09 | Paginación | Seguir tokens hasta fin; distinguir respuesta vacía de página agotada. |
| T10 | Escritura ambigua | Tras timeout de crear/enviar/aprobar, consultar estado antes de repetir. |
| T11 | Errores | 401/403, 429, 5xx, timeout, clave ausente, fuente inválida y estado inválido entregan diagnósticos seguros. |
| T12 | Secretos | Clave ausente/rechazada no se filtra por salida, error, prompt, test snapshot ni log. |
| T13 | Datos no confiables | Texto malicioso de Jules no modifica scopes, autorización ni reglas de ejecución. |
| T14 | API real | `JULES_API_KEY` aceptada sin revelar su valor; prueba no destructiva en fuente/rama autorizada. |
| T15 | Cliente real | ChatGPT descubre y llama a las herramientas desde el cliente/espacio de trabajo previsto, incluyendo escritura. |
| T16 | E2E | Secuencia creación → plan → aprobación explícita → avance → feedback → respuesta → cierre/entrega verificada. |
| T17 | Persistencia | Núcleo/crónica reflejan exactamente el resultado comprobado y sobreviven a una reinstanciación. |
| T18 | Liberación | PR revisado y aprobado conforme a autorización; checks pertinentes verdes o excepción explícita, documentada y aceptada. |
| T19 | Verificación de rama en servidor | Fuente y branch se vuelven a consultar por API desde el servidor; rama no verificada bloquea `sessions.create`. |
| T20 | Modo de salida | La solicitud de creación usa `AUTO_CREATE_PR`; cualquier PR se verifica por URL/estado real, sin asumir merge. |
| T21 | Seguridad de reintento | Tests demuestran cero reintentos automáticos de POST no idempotentes ante red/5xx ambiguos; GET aplica límites. |
| T22 | Plan exacto vigente | Si cambia el plan/actividad después de su revisión, se bloquea la aprobación hasta recabar consentimiento para el plan actual. |
| T23 | Disponibilidad ChatGPT | Se documenta cliente/plan/espacio de trabajo compatible con escritura y descubrimiento actualizado de herramientas; si falta, el gate falla cerrado. |
| T24 | Uso conversacional real | Se prueba uso en chat normal y disponibilidad/reselección para mensajes posteriores; Agent/Deep Research quedan fuera del camino de escritura. |
| T25 | Branch/source negatives | Fuente desconectada, rama inexistente, respuesta malformada o error al obtener fuente no llama a `sessions.create`. |

**Gate de release:** T01–T13 deben pasar según sus ámbitos; T14–T16 deben ejecutarse con API y cliente reales. T17 debe tener lectura de vuelta. No se declara MVP utilizable mientras un gate necesario permanezca pendiente o fallido. Las excepciones no se silencian ni se interpretan como PASS.

## 14. Bloqueos y riesgos conocidos al iniciar la planeación

1. **Elegibilidad de ChatGPT para acciones de escritura:** no verificada para el espacio de trabajo que usará MCP Jules; consultar requisitos oficiales antes de cerrar diseño de integración.
2. **Credencial Jules:** `JULES_API_KEY` figura configurada como variable sensible en Vercel producción según el registro previo, consultada sin descifrar. Su validez no está demostrada; no recuperar ni exponer el valor.
3. **CI de Khora:** el último diagnóstico persistido para PR #338 reporta typecheck/UI review/contratos UI/API tests aprobados, suite unitaria 547 PASS/1 FAIL por lectura del esquema privado de Metodología sin `GH_TOKEN`, dos findings Ruff fuera del diff y build/E2E fallidos aguas abajo. Debe refrescarse contra el head vigente antes de tomar decisiones.
4. **CI de Metodología:** `validate-canonical-bootstrap.py` y un workflow de gobernanza muestran runs fallidos. La fuente de validación contiene expectativas antiguas de Samantha v339/NX-339m y varios archivos Markdown de compatibilidad; el canon vigente es el DUG HTML v360/NX-360m. El diseño de corrección debe preservar una fuente normativa única y distinguir interfaces de compatibilidad de autoridad normativa. Los logs del run no fueron recuperables, por lo que no se atribuye a un paso exacto la causa de una ejecución concreta.
5. **Límite de API:** Jules documenta la API `v1alpha`; el contrato puede cambiar. Revalidar los esquemas al comenzar implementación y antes de release.
6. **Automatización persistente:** no hay trabajador externo aprobado/implementado por este plan. La interacción MCP ocurre cuando se invocan herramientas durante una conversación activa.
7. **PR documental sin integrar:** Metodología PR #19 sigue en borrador en la rama de trabajo. El plan y los artefactos no están disponibles todavía como estado de `main`.

## 15. Secuencia de fases posterior a la planeación

### Fase 1 — Planeación integral del componente v1.0 (vigente)

- Establecer requisitos, arquitectura y límites.
- Especificar contratos de las siete herramientas y estados.
- Definir seguridad, trazabilidad, persistencia, fallos, operación y recuperación.
- Completar pruebas y criterios de aceptación.
- Resolver o registrar formalmente las compuertas de viabilidad y los riesgos.
- Hacer revisión de consistencia entre plan, OCP, plan de aceptación y PR candidato.

**Salida:** plan v1.0 consistente, trazable y revisable. No cambia código de producto.

### Fase 2 — Reconciliación e implementación

- Comparar PR #338 y el código actual del servidor con el diseño aceptado; construir una matriz de delta.
- Confirmar contratos actuales de la API Jules y del servidor Khora.
- Ejecutar la corrección mínima en la rama de implementación autorizada.
- Mantener aisladas las modificaciones de Jules frente a fallos ajenos al diff y documentar sus responsables.
- Volver a ejecutar pruebas con evidencia real.

**Salida:** candidato de implementación alineado, no todavía release aceptado.

### Fase 3 — Validación integrada real

- Validar la credencial por una llamada real sin mostrarla.
- Completar la secuencia de sesión con aprobación obligatoria y feedback en la misma sesión.
- Probar conexión ChatGPT y permisos efectivos de escritura.
- Probar recuperación tras timeout, paginación, errores y reanudación.
- Persistir resultados en el OCP.

**Salida:** evidencia end-to-end reproducible y bloqueos restantes explícitos.

### Fase 4 — Release y replicación controlada

- Revisar el diff, los checks y las autorizaciones de integración.
- Completar el merge y despliegue solo con autorización y verificación pertinentes.
- Comprobar tools descubiertas después del despliegue y ejecutar prueba de humo.
- Publicar guía de consumo y replicación por frente, usando el servidor central.
- Declarar v1.0 utilizable solo cuando los gates de aceptación se satisfagan.

**Salida:** release verificado, guía de uso y matriz de capacidades/limitaciones.

### Evolución futura

Si se solicita sondeo persistente, notificaciones, respuesta automática acotada u orquestación avanzada de PR/CI, planificar una versión posterior con su propio diseño de disponibilidad, coste, idempotencia, seguridad, permisos, checkpoint y aceptación. No inferir su inclusión a partir de v1.0.

## 16. Condiciones para declarar completa la fase 1

La planeación estará completa cuando:

- El propósito y el comportamiento esperado estén definidos inequívocamente.
- Cada función tenga contrato, scope, estado esperado, errores y prueba asignada.
- Las transiciones de la sesión y las decisiones de aprobación estén definidas.
- La arquitectura conserve el servidor MCP central de Khora y sus controles existentes.
- Los dos planos de credenciales estén delimitados y la clave solo exista en servidor.
- Persistencia, recuperación, reintentos, concurrencia, errores y seguridad tengan tratamiento.
- Cada gate de aceptación tenga un resultado esperado y evidencia identificable.
- Las dependencias externas, elegibilidad de ChatGPT y bloqueos de CI estén nombrados, sin inventar solución ni resultado.
- La relación entre el plan, `OBJETO-CANONICO.md`, el plan de aceptación y los PR sea consistente.
- El plan completo esté escrito en este OCP y verificado mediante lectura de vuelta.

Completar la planeación no equivale a aceptar la implementación, validar la API, conectar ChatGPT ni autorizar despliegue. Esas son salidas posteriores, sujetas a evidencia.

## 17. Fuentes técnicas consultadas

- [Jules REST API — catálogo de métodos](https://developers.google.com/jules/api/reference/rest) — endpoints para sources, sessions y activities; API `v1alpha`.
- [Jules Session resource](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions) — `requirePlanApproval`, source context y estados publicados.
- [Jules sessions.create](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/create) — creación de sesiones.
- [Jules sessions.sendMessage](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/sendMessage) — envío de mensajes a una sesión.
- [Jules sessions.approvePlan](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/approvePlan) — aprobación de plan.
- [Jules sessions.activities.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions.activities/list) — actividades y paginación.
- [OpenAI: Connecting custom MCP servers in ChatGPT](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt) — disponibilidad según plan/espacio de trabajo, selección por mensaje, HTTPS/túnel y confirmaciones de escritura. Consultado el 2026-10-29; full MCP con escritura figura para Business y Enterprise/Edu, mientras que Pro figura con lectura/recuperación.
- [Investigación específica ya persistida en el OCP](fuentes/INVESTIGACION-API-JULES-CHATGPT.md) — antecedentes de automatización y comparación del cliente.
- [Contrato operativo del asistente](prompts/ASISTENTE-MCP.md) y [contrato de prompts a Jules](prompts/JULES-CONSTRUCTOR.md) — material previo a reconciliar contra este plan.

**Conclusión de diseño:** MCP Jules v1.0 es una integración conversacional bidireccional sobre el servidor MCP central de Khora. Su unidad funcional es el ciclo completo de delegación, aprobación, seguimiento, retroalimentación y verificación. La fase vigente es planificación integral; la implementación candidata existente no sustituye este plan ni demuestra que el producto esté aceptado.


## 18. Contrato de API fijado para v1.0

Esta tabla es la referencia de implementación para la API oficial `v1alpha`; antes de implementar se revalida contra la documentación viva.

| Operación interna | Endpoint oficial | Payload/consulta | Respuesta y conducta |
|---|---|---|---|
| Enumerar fuentes | `GET /v1alpha/sources` | `pageSize` 1–100, `pageToken?` | `sources[]`, `nextPageToken?`; cada fuente expone el nombre de recurso y el repo GitHub con ramas. |
| Consultar fuente | `GET /v1alpha/{name=sources/**}` | Nombre completo copiado de la lista | Validación interna previa a crear sesión; no necesita herramienta MCP pública adicional. |
| Enumerar sesiones | `GET /v1alpha/sessions` | `pageSize` 1–100, `pageToken?` | `sessions[]`, `nextPageToken?`. |
| Leer sesión | `GET /v1alpha/{name=sessions/*}` | Nombre/ID validado | Estado, timestamps, sourceContext, URL y outputs si los expone la API. |
| Leer actividades | `GET /v1alpha/{parent=sessions/*}/activities` | `pageSize` 1–100, `pageToken?` | `activities[]`, `nextPageToken?`; recorrer páginas hasta que no exista token siguiente. |
| Crear sesión | `POST /v1alpha/sessions` | `prompt`, `sourceContext.source`, `githubRepoContext.startingBranch`, `requirePlanApproval:true`, `automationMode:AUTO_CREATE_PR` | Recurso Session. Los dos campos de política son input-only y pueden no repetirse en la respuesta. Guardar name/id/url/estado real. |
| Responder | `POST /v1alpha/{session=sessions/*}:sendMessage` | `{prompt}` | Respuesta exitosa vacía; comprobar estado/actividades posteriormente. |
| Aprobar plan | `POST /v1alpha/{session=sessions/*}:approvePlan` | Cuerpo vacío | Respuesta exitosa vacía; comprobar estado/actividades posteriormente. |

Fuentes oficiales: [catálogo REST](https://developers.google.com/jules/api/reference/rest), [sources.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sources/list), [recurso Source](https://developers.google.com/jules/api/reference/rest/v1alpha/sources), [sessions.create](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/create), [recurso Session/estados](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions), [activities.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions.activities/list), [sendMessage](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/sendMessage) y [approvePlan](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/approvePlan).

### Semántica importante

- El catálogo actual de estados incluye `STATE_UNSPECIFIED`, `QUEUED`, `PLANNING`, `AWAITING_PLAN_APPROVAL`, `AWAITING_USER_FEEDBACK`, `IN_PROGRESS`, `PAUSED`, `FAILED` y `COMPLETED`. Un estado desconocido debe bloquear operaciones dependientes del estado.
- El recurso Activity expone `name`, `id`, `description`, `createTime`, `originator`, `artifacts[]` y eventos como `planGenerated`, `planApproved`, `userMessaged`, `agentMessaged`, `progressUpdated`, `sessionCompleted` y `sessionFailed`.
- `Session.requirePlanApproval` y `Session.automationMode` son de entrada. La prueba unitaria inspecciona el cuerpo de creación enviado; la prueba real confirma estado y actividad; no espera que la API devuelva necesariamente esos dos valores.
- `AUTO_CREATE_PR` significa que Jules crea una rama y un pull request si genera un parche final aplicable. No autoriza merge, revisión automática ni despliegue.
- El listado de actividad usa `pageToken`; el diseño no depende de un parámetro `createTime` como cursor incremental, porque no es parte del contrato de listado consultado.

## 19. Registro de decisiones de arquitectura

| ID | Decisión v1.0 | Motivo | Consecuencia / prueba |
|---|---|---|---|
| ADR-01 | Un solo servidor MCP central de Khora, ruta `/api/mcp`. | Reduce duplicación y mantiene controles comunes. | No desplegar servidor por frente; T01/T02. |
| ADR-02 | Siete herramientas públicas; operaciones de lectura de fuente/branch adicionales se hacen internamente en el cliente. | Mantiene el contrato conversacional acotado sin sacrificar validación. | T01/T05/T25. |
| ADR-03 | Cada creación fuerza `requirePlanApproval=true`. | Impide que la sesión empiece sin revisión del plan. | El parámetro no se expone al modelo; T06. |
| ADR-04 | Crear con `automationMode=AUTO_CREATE_PR`. | El componente está destinado a desarrollo delegado y debe entregar un PR cuando se genera un parche aplicable. | PR no equivale a merge; T20/T18. |
| ADR-05 | Lectura y escritura quedan separadas por `jules:read` y `jules:write`, y conservan el ciclo normativo existente de Khora. | Principio de privilegio mínimo y coherencia con el servidor común. | Los tokens no reciben scopes Jules por defecto; T03/T04. |
| ADR-06 | La aprobación requiere consentimiento explícito en la conversación y comprobación del estado/plan inmediatamente antes de invocar la herramienta. | La aprobación habilita ejecución en un proveedor externo. | El MCP de v1.0 comprueba el estado, pero no puede probar por sí solo quién escribió el consentimiento; se debe obedecer además la confirmación de la plataforma cuando se presente. No declarar una barrera criptográfica de aprobación. T07/T22. |
| ADR-07 | GET permite reintentos acotados; POST de creación/mensaje/aprobación no se reintenta automáticamente ante timeout de red o 5xx ambiguo. | El contrato no documenta clave de idempotencia y ciertos POST responden vacío. | Read-after-ambiguous-write y decisión explícita antes de repetir; T10/T21. |
| ADR-08 | El endpoint de creación valida fuente y rama desde el servidor antes del POST. | No confiar únicamente en argumentos generados por el modelo. | Obtener Source actual y comparar branch exacta; T19/T25. |
| ADR-09 | El modo objetivo es chat web conversacional normal con app MCP personalizada habilitada para escritura. | La disponibilidad depende del plan y espacio de trabajo; Agent/Deep Research no son un runtime de escritura equivalente. | Gate externo de cliente/plan; T15/T23/T24. |
| ADR-10 | Sin worker persistente, autorespuesta ilimitada, auto-merge ni auto-deploy en v1.0. | Mantiene el MVP acotado y evita conceder autonomía no solicitada. | Seguimiento invocado por herramientas durante turnos activos; extensiones fuera de alcance. |
| ADR-11 | OCP: núcleo como estado vivo único y crónicas como historial verificable; no crear otra DB solo por simetría. | Respeta el objeto canónico y el requisito de continuidad. | Registrar IDs/cursor/estado/resultados mínimos; T17. |

### Límite de la aprobación

El cliente ChatGPT puede solicitar confirmación para una acción de escritura según su política, el permiso de la app y el contexto; no debe suponerse que lo hará en todos los casos. Por eso el contrato operativo exige que ChatGPT pida al operador una respuesta afirmativa concreta sobre el plan leído y que después de ella invoque la herramienta. El servidor garantiza el estado de sesión previo, no una prueba criptográfica del consentimiento conversacional. Si se exige una barrera técnica independiente de ChatGPT, hará falta una futura superficie de aprobación con recibo de un solo uso; ese mecanismo no pertenece al MVP directo fijado aquí.

## 20. Política de errores, reintentos y reconciliación

| Condición | Tratamiento requerido | Reintento |
|---|---|---|
| `JULES_API_KEY` ausente | `JULES_API_KEY_MISSING`, fail-closed | No |
| 401/403 de Jules | `JULES_API_AUTH_REJECTED`; no mostrar respuesta upstream | No hasta corregir permiso/configuración |
| 429 | `JULES_RATE_LIMITED`; respetar `Retry-After` si existe; registrar metadatos seguros | GET: limitado; POST: no automático |
| 5xx | `JULES_API_FAILED`; guardar status/correlation ID, no cuerpo arbitrario | GET: limitado; POST: estado ambiguo, reconciliar |
| Timeout/red en GET | Error de dependencia con contexto seguro | Sí, limitado con backoff |
| Timeout/red en POST | Registrar `WRITE_RESULT_AMBIGUOUS`; no afirmar éxito ni fallo definitivo | No automático; consultar sesión/actividad primero |
| Fuente/branch inválida | `JULES_SOURCE_ID_INVALID` / `JULES_BRANCH_INVALID`; no crear sesión | No |
| ID sesión inválido | `JULES_SESSION_ID_INVALID`; no invocar Jules | No |
| Estado incompatible para enviar mensaje | `JULES_SESSION_NOT_READY_FOR_MESSAGE`; releer y explicar estado | No |
| Estado incompatible para aprobar | `JULES_PLAN_NOT_AWAITING_APPROVAL`; no aprobar | No |
| Estado o evento desconocido | Conservar respuesta mínima y bloquear la mutación dependiente | No automático |
| Respuesta JSON inválida o incompleta | Error de protocolo saneado; registrar solo metadatos | GET puede repetir de forma limitada; POST requiere reconciliación |
| Límite agotado | Mostrar bloqueo y siguiente paso concreto; no entrar en polling infinito | Espera explícita/turno posterior |

El helper HTTP no debe aplicar una única política de retry a todos los métodos. En concreto, el cliente candidato observado actualmente reintenta algunas solicitudes POST a causa de red/429/5xx; ese comportamiento es un delta obligatorio de fase 2. El plan no declara que ya se haya corregido.

## 21. Seguridad y revisión de amenazas

| Riesgo | Control de diseño | Evidencia requerida |
|---|---|---|
| Fuga de API key | Variable solo en entorno de servidor; no retornar headers; logs saneados. | T12 y revisión de logs/configuración. |
| Uso no autorizado | Bearer/OAuth, scope por herramienta, token de turno normativo; fail-closed. | T03/T04. |
| Confusión de repositorio o rama | Source get/list en servidor y comparación exacta de rama antes de crear. | T19/T25. |
| Prompt injection desde la salida de Jules | Outputs de Jules son datos; no amplían permisos ni autorizaciones. | Test malicioso T13. |
| Aprobación del plan equivocado | Leer actividad del plan, presentar pasos/restricciones, pedir confirmación, reconsultar antes de aprobar. | T07/T22. |
| Doble sesión/doble mensaje por timeout | Sin retry automático de POST; consultar estado/actividad primero. | T10/T21. |
| Acceso cruzado entre frentes | Cada petición queda sujeta al token, permisos y OCP de destino; no copiar control ni secretos entre frentes. | Tests de autorización/contexto y revisión de uso. |
| Exposición de respuesta upstream | Código de diagnóstico público; nunca propagar cuerpo upstream no saneado. | T11/T12. |
| Paginación truncada | Conservar `nextPageToken`; no confundir ausencia de resultados de una página con final de colección. | T09. |
| Saturación / coste | PageSize 1–100; backoff limitado para GET; sin loops infinitos ni trabajador persistente. | Pruebas de límite/reintento. |
| Herramienta no disponible en el plan | Gate de elegibilidad del cliente/espacio de trabajo; no declarar viable antes de confirmarlo. | T23/T24. |

El registro operativo incluye IDs y tiempos mínimos, estados, errores de clase, correlación y checkpoint. No debe copiar cuerpos completos, prompts sensibles ni secretos a telemetría. Las pruebas con repositorios privados requieren fuente y rama de prueba autorizadas.

## 22. Procedimiento de implementación y release posterior

### Fase 2 — reconciliación

1. Obtener el head actual de Khora PR #338 y comparar sus archivos con el diseño de este plan.
2. Crear matriz de deltas: conforme, falta, contradicción, no verificable.
3. Implementar primero la validación interna source/branch, política de retries por método, contratos input-only, estados, diagnósticos y pruebas.
4. Corregir la paginación con `pageToken` exclusivamente; retirar o aislar helpers antiguos que usen parámetros no documentados.
5. No incluir fixes de Ruff ajenos al diff de Jules sin coordinación con su frente responsable.
6. Mantener `JULES_API_KEY` fuera de Git y no leer su valor para depurar; la prueba debe informar éxito/fallo y metadatos mínimos.

### Fase 3 — validación integrada

1. Obtener una fuente y rama de prueba reales a partir de Jules.
2. Crear una sesión inocua y comprobar el estado `AWAITING_PLAN_APPROVAL`; el test de payload comprueba `requirePlanApproval=true` aunque la respuesta omita ese campo input-only.
3. Revisar el plan con el operador y recibir aprobación explícita.
4. Aprobar, reconsultar y verificar ejecución/actividad real.
5. Simular/ejecutar una solicitud de feedback y responder en la misma sesión.
6. Confirmar en el cliente ChatGPT real la disponibilidad de herramientas de escritura y los prompts de confirmación.
7. Probar timeout ambiguo, 429, 5xx, página siguiente, fuente desconectada y branch inexistente.

### Fase 4 — release/reversión

1. Actualizar/revisar la app MCP en ChatGPT para que descubra la versión real de herramientas; los cambios no tienen por qué activarse automáticamente.
2. Confirmar CI, diff, revisión humana y autorización aplicable antes de merge.
3. Desplegar solo con autorización y compuertas de Khora; revisar la URL canónica y estado de producción.
4. Ejecutar prueba de humo no destructiva: health/lectura de fuentes; crear sesión real solo en fuente/rama aprobada.
5. **Rollback:** si una regresión afecta el endpoint MCP común, detener nuevas acciones Jules, revocar/deshabilitar scopes Jules en la app/tokens según la capacidad existente, revertir el commit mediante el procedimiento de Khora y comprobar que las herramientas previas funcionan. No borrar sesiones o PR creados. Si hay sospecha de clave comprometida, rotarla en el proveedor/entorno autorizado y verificar sin imprimirla.
6. Rehabilitar escritura solo después de releer el despliegue, descubrir de nuevo las herramientas y pasar una prueba de humo.

## 23. Matriz de trazabilidad requisito → diseño → aceptación

| Requisito | Diseño/decisión | Pruebas | Estado al cierre de Fase 1 |
|---|---|---|---|
| REQ-01 ChatGPT invoca MCP durante resolución conversacional | §2, §11, ADR-09 | T15/T23/T24 | Contrato definido; plan/espacio real por verificar |
| REQ-02 Descubrir fuentes reales | §6, §18 | T01/T05 | Definido |
| REQ-03 Validar rama en servidor | ADR-08, §18 | T19/T25 | Diseño definido; falta implementar |
| REQ-04 Crear sesión con control de plan y PR | ADR-03/04, §18 | T06/T20 | Definido; falta implementar/probar |
| REQ-05 Aprobación explícita del plan | §7.2, ADR-06 | T07/T22 | Política de uso definida; no existe prueba criptográfica de consentimiento en el servidor |
| REQ-06 Leer estado/actividad/páginas | §§6–8, §18 | T01/T09 | Definido |
| REQ-07 Responder en la misma sesión | §§7.3/18 | T08/T16 | Definido |
| REQ-08 Evitar duplicados por escritura ambigua | ADR-07, §20 | T10/T21 | Definido; fix de fase 2 obligatorio |
| REQ-09 Autorización de mínimo privilegio | §§5/10, ADR-05 | T03/T04 | Definido |
| REQ-10 Secretos y errores seguros | §§10/20/21 | T11/T12 | Definido |
| REQ-11 Resistir instrucciones no confiables | §§10/21 | T13 | Definido |
| REQ-12 Persistir y reanudar | §9, ADR-11 | T17 | Definido |
| REQ-13 No degradar Khora existente | ADR-01/05 | T02/T18 | Definido |
| REQ-14 No declarar aceptación sin E2E real | §13, §22 | T14–T18 | Definido |
| REQ-15 Seguimiento continuo y respuesta autónoma | §4 | Fuera de v1.0; plan futuro | Excluido intencionalmente |
| REQ-16 Release y reversión seguros | §22 | T18 y smoke/rollback | Definido |

## 24. Cierre verificable de la Fase 1

**Resultado de planeación: COMPLETO como especificación de diseño lista para implementación**, sujeto a los gates externos de validación posteriores. La completitud de la fase significa que no quedan decisiones funcionales implícitas para construir el MVP; no significa que el sistema ya funcione.

Decisiones cerradas:
- producto y propósito: complemento MCP usado en el ciclo de resolución conversacional;
- arquitectura: servidor MCP central de Khora;
- contrato público: siete herramientas;
- flujo de desarrollo: crear sesión con aprobación obligatoria y generación de PR automática cuando haya parche;
- autoridad: read/write separados más el ciclo normativo existente;
- fuente/rama: verificación server-side;
- robustez: paginación oficial y no retry ciego de POST;
- seguridad: secretos server-side, diagnósticos saneados y outputs externos no confiables;
- aceptación: 25 pruebas/gates con resultado verificable;
- límites: sin worker persistente, auto-respuesta ilimitada, auto-merge ni auto-deploy;
- release/reversión: procedimientos definidos.

Gates que no pueden cerrarse solo mediante planeación:
1. La cuenta/espacio real de ChatGPT debe disponer de escritura MCP personalizada. Si no, la ruta de complemento nativo no es viable en ese cliente bajo la documentación actual.
2. La clave Jules debe probarse mediante llamada real sin revelar el valor.
3. Deben corregirse los deltas del candidato y comprobar CI/contratos.
4. Debe ejecutarse la secuencia E2E en una fuente/branch autorizada.
5. El PR documental debe superar sus validaciones heredadas y entrar en `main` bajo la gobernanza correspondiente.

Ninguno de esos gates se reporta como PASS antes de tener evidencia. Esos son prerrequisitos de implementación, integración y release, no lagunas del diseño. El código candidato será reconciliado contra este plan; no se acepta por antigüedad ni por existir un PR abierto.

**Estado de la fase:** cerrada en planeación; siguiente fase autorizable: reconciliación e implementación contra este contrato, después de comprobar el cliente/plan de ChatGPT previsto.
