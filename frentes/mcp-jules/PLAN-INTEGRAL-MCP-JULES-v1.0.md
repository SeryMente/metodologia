# Plan integral del componente MCP Jules v1.0

**Versión del plan:** 1.0  
**Frente:** MCP Jules  
**Fase completada:** Fase 1 — planeación integral de diseño; no se implementó código de producto.  
**Fecha de corte documental:** 2026-10-29  
**Revisión de cierre:** R2 · C-MCP-JULES-008; requisito ChatGPT Free y exclusión absoluta de Codex  
**OCP:** `frentes/mcp-jules/`  
**Control de responsabilidad:** `CONTROL-RESPONSABILIDAD.json`, generación 2, folio `SES-20261029-6C2F9A17`.  
**Gobierno consultado:** Documento Único de Gobernanza (DUG) Samantha v360 · NX-360m; Metacanon 1.24; GOW 2.9, leídos desde `SeryMente/metodologia/main`.  
**Estado:** especificación de Fase 1 revisada y completada como línea base integral; cliente final obligatorio ChatGPT Free, sin Codex. Ruta candidata: plugin MCP público del directorio de ChatGPT, aún sujeta a prueba real de disponibilidad y escritura en Free. Código, API real, publicación/aprobación del plugin, E2E, despliegue y release siguen pendientes.

## 1. Decisión de fase

La primera fase del frente es la **planeación plena y completa del componente MCP Jules en su versión 1.0**. Esta fase define propósito, arquitectura, alcance funcional, contratos de herramientas, estados y ciclos, seguridad, operación, pruebas, aceptación, despliegue, recuperación, exclusiones y decisiones de viabilidad.

Durante esta fase no se añade ni modifica código de producto, no se despliega ni se fusiona por el solo hecho de que exista una rama candidata. Las PR existentes se usan como evidencia y material de comparación, no como prueba de que el diseño ya esté completo o funcione.

La fase 1 se considera cerrada cuando el plan tenga trazabilidad entre requisitos, arquitectura y aceptación, y cada bloqueo material figure como resuelto con evidencia o como decisión explícita pendiente del operador. La implementación y su validación pertenecen a fases posteriores.

## 2. Propósito del componente

MCP Jules permitirá desarrollar repositorios desde una conversación normal de ChatGPT Free mediante un plugin público de ChatGPT conectado al servidor MCP central de KHORA. **Codex queda excluido de forma absoluta**: no se usará para construir, ejecutar, probar, publicar, operar ni como alternativa o contingencia.

La unidad funcional no es simplemente enviar un prompt. Es cerrar el ciclo:
**ChatGPT analiza y formula → Jules planea → el operador aprueba el plan → Jules ejecuta → ChatGPT recupera actividad y preguntas → ChatGPT responde con contexto verificado → Jules continúa → ChatGPT comprueba la entrega.**

El plugin se descubrirá e instalará desde el directorio público de plugins de ChatGPT y expondrá el mismo endpoint central de KHORA, no un servidor paralelo. La publicación, disponibilidad individual en Free y capacidad real de escritura son gates externos: no se presumen. El usuario debe operar desde chat normal sin plan de pago, Developer Mode, GPT personalizado creado por él o Codex.

El plugin se selecciona o menciona en los mensajes que requieren invocación. No se garantiza invocación automática en todos los turnos, ejecución oculta ni trabajo cuando la conversación está inactiva.

## 3. Resultado esperado de v1.0

La versión 1.0 debe permitir que una cuenta personal ChatGPT Free, mediante el plugin MCP público aprobado y en conversación normal, complete el siguiente ciclo sin Codex:

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

- Un solo servidor MCP central de KHORA, endpoint /api/mcp, con siete herramientas públicas.
- Consumo desde ChatGPT Free mediante un plugin MCP público aprobado y publicado en el directorio oficial; prueba Free real obligatoria.
- Paquete de plugin, metadatos, identidad de editor verificada, dominio HTTPS, política de privacidad, soporte, escaneo y revisión de OpenAI.
- OAuth 2.1 compatible con el cliente ChatGPT: Authorization Code + PKCE S256, metadatos de recurso protegido/autorización y validación de issuer, audience, expiración, sujeto y scopes.
- Autorización por sujeto y recurso: identidad OAuth → identidad KHORA → fuentes Jules permitidas → repositorios → ramas → scopes. Sin acceso anónimo ni filtración de fuentes privadas.
- Scopes jules:read y jules:write separados, además del ciclo normativo y controles existentes de KHORA.
- Validación server-side de fuente y rama antes de crear sesión; requirePlanApproval=true y automationMode=AUTO_CREATE_PR.
- Seguimiento conversacional, actividades paginadas, feedback en la misma sesión, aprobación humana y verificación independiente.
- Tratamiento explícito de cuotas Free, interrupciones y reanudación mediante checkpoint; no se promete uso ilimitado.
- Pruebas de API real, OAuth, aislamiento, revisión/publicación del plugin, uso en Free y E2E en repositorio sandbox.
- Guía de instalación/replicación con el plugin y servidor central, sin copiar secretos ni controles.

### Excluido de v1.0

- **Codex en cualquier producto, superficie o modo**: no instalar, invocar, documentar como ruta ni utilizar como fallback.
- Conexión privada directa de un servidor MCP personalizado como ruta objetivo de Free; su compatibilidad de escritura documentada corresponde a otros planes.
- GPT personalizados/GPT Actions como integración objetivo; las cuentas personales Free no pueden crear/publicar GPTs nuevos.
- Servidor MCP por frente, segundo servidor Jules, trabajador persistente, webhook no documentado o ejecución sin turno activo.
- Aprobación automática, autorespuesta ilimitada, auto-merge o auto-deploy.
- Acceso anónimo o acceso indiscriminado a todos los repositorios por instalar el plugin.
- Declarar compatibilidad Free por la sola presencia del directorio; se requiere prueba real de instalación, descubrimiento y escritura.

La publicación pública distribuye el plugin, no concede autorización sobre KHORA, Jules ni GitHub. Cada llamada permanece autenticada y limitada al sujeto y recursos permitidos.

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

## 11. Compatibilidad real con ChatGPT Free y distribución

### 11.1 Requisito obligatorio

El cliente final es una cuenta personal ChatGPT Free en chat normal y web. No se aceptará como sustituto probar solo con Business, Enterprise, Edu, Pro o Plus, ni exclusivamente desde Developer Mode. La prueba debe usar una cuenta Free real en la región de operación.

**Codex no forma parte del sistema:** ninguna fase, instrucción, artefacto, CI, publicación, operación o contingencia dependerá de ese producto.

### 11.2 Rutas evaluadas

1. **MCP personalizado privado:** descartado como ruta de Free. OpenAI documenta compatibilidad completa de MCP con escritura para Business y Enterprise/Edu; Pro dispone de lectura/recuperación. No se debe inferir que Free puede conectar directamente un servidor MCP personalizado con escritura.
2. **Plugin público con herramientas MCP:** ruta objetivo para validar Free. La documentación indica que el directorio es visible en todos los planes, que algunos plugins están disponibles en Free y que ChatGPT web usa herramientas MCP remotas a través de plugins. La disponibilidad y capacidades concretas dependen del plan, cuenta, región y plugin; no hay garantía de que MCP Jules pueda escribir en Free. Se debe probar el plugin publicado en chat normal con cuenta Free real.

   **Distinción de extensión:** las extensiones nativas de plugins (superficies propias de barra lateral, compositor o visores de archivos) son una capacidad separada de las herramientas del plugin. OpenAI indica que las extensiones web aún están pendientes para Free/Go, pero que la funcionalidad existente de plugins no se afecta. MCP Jules no dependerá de esas extensiones; utilizará únicamente herramientas MCP en chat normal. La falta de extensiones nativas no demuestra por sí sola que la invocación básica esté bloqueada ni demuestra que la escritura de este plugin esté habilitada.
3. **GPT personalizado/GPT Actions:** no seleccionado. Free no puede crear ni publicar GPTs personales nuevos; no es una dependencia estable del diseño.
4. **Codex:** prohibido como herramienta, cliente, canal de prueba o alternativa.

### 11.3 Distribución e instalación

1. Preparar un paquete de plugin con un solo servidor MCP remoto apuntando al endpoint HTTPS existente de KHORA /api/mcp. Debe ser utilizable desde ChatGPT web en chat normal, sin extensión nativa de sidebar/composer/file-viewer ni dependencia de la superficie Work.
2. Verificar la identidad del editor en el portal de desarrolladores de OpenAI; incluir metadatos, nombre/descrición, recursos gráficos requeridos, política de privacidad y soporte. No incluir secretos.
3. Verificar el dominio, conectar el MCP, completar autenticación y escaneo automatizado de las siete herramientas.
4. Corregir findings y someter el paquete a revisión. Publicar solo después de aprobación real de OpenAI.
5. Desde ChatGPT Free, encontrar/instalar el plugin publicado y conectar KHORA mediante OAuth.
6. Seleccionar o mencionar el plugin en chat normal para invocar herramientas. Confirmar continuidad de autorización sin reinstalación y respetar revocación/expiración.

### 11.4 OAuth, identidad y permisos

El servidor deberá cumplir el contrato OAuth 2.1 publicado para plugins MCP: metadata del recurso protegido y del servidor de autorización; Authorization Code + PKCE S256; método de identificación/registro de cliente admitido (CIMD o DCR según configuración); preservación del parámetro resource; validación de issuer, audience, expiración, sujeto y scopes en cada llamada.

El sujeto OAuth debe resolverse a una identidad KHORA autorizada. Cada herramienta aplica permiso por sujeto, fuente, repositorio, rama y scope. jules_list_sources filtra las fuentes autorizadas; jules_create_session vuelve a obtener Source desde Jules y confirma la rama contra esa autorización. Si la asignación no puede verificarse, falla cerrado. JULES_API_KEY permanece solo en el servidor.

Un plugin público no vuelve público el acceso a repositorios privados. La autorización debe ocurrir en el servidor, no quedar delegada a instrucciones del modelo.

### 11.5 Gate de ChatGPT Free

PASS exige evidencia desde una cuenta Free real, en chat normal, sin Developer Mode, extensión nativa de plugin ni plan de pago:
- listing público localizable y plugin instalable;
- OAuth exitoso en la superficie y región objetivo;
- descubrimiento de las siete herramientas y schemas;
- lectura con permisos mínimos;
- una escritura real y no destructiva desde chat normal;
- ciclo completo: sesión → plan → confirmación humana → ejecución → feedback → respuesta misma sesión → entrega verificada;
- manejo de cuota Free e interrupción sin duplicados ni pérdida de checkpoint.

Si el plugin no aparece, no se instala o las escrituras están bloqueadas para Free, el gate es BLOCKED/FAIL. No se reporta PASS por lectura solamente, por una cuenta de pago, por Developer Mode o por un relevo manual. Cambiar arquitectura requiere nueva decisión explícita.

### 11.6 Límites del plan Free

- No prometer cuota, prioridad ni disponibilidad ilimitada.
- Ante límite o indisponibilidad, conservar el último checkpoint verificado y comunicar cómo reanudar.
- Nunca repetir un POST ambiguo al alcanzar una cuota o cortarse un turno.
- La interrupción de ChatGPT, plugin, OAuth o Jules bloquea la operación dependiente; no autoriza usar un cliente excluido ni omitir aprobación.

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
| T15 | Cliente real | ChatGPT Free instala el plugin público aprobado, descubre las siete herramientas y ejecuta acciones desde chat normal. |
| T16 | E2E | Secuencia creación → plan → aprobación explícita → avance → feedback → respuesta → cierre/entrega verificada. |
| T17 | Persistencia | Núcleo/crónica reflejan exactamente el resultado comprobado y sobreviven a una reinstanciación. |
| T18 | Liberación | PR revisado y aprobado conforme a autorización; checks pertinentes verdes o excepción explícita, documentada y aceptada. |
| T19 | Verificación de rama en servidor | Fuente y branch se vuelven a consultar por API desde el servidor; rama no verificada bloquea `sessions.create`. |
| T20 | Modo de salida | La solicitud de creación usa `AUTO_CREATE_PR`; cualquier PR se verifica por URL/estado real, sin asumir merge. |
| T21 | Seguridad de reintento | Tests demuestran cero reintentos automáticos de POST no idempotentes ante red/5xx ambiguos; GET aplica límites. |
| T22 | Plan exacto vigente | Si cambia el plan/actividad después de su revisión, se bloquea la aprobación hasta recabar consentimiento para el plan actual. |
| T23 | Disponibilidad ChatGPT Free | Una cuenta Free real, sin Developer Mode ni workspace pagado, instala el plugin y ejecuta escritura no destructiva; de lo contrario BLOCKED/FAIL. |
| T24 | Uso conversacional Free | El plugin funciona en chat normal y se puede volver a seleccionar/mencionar; se registra conducta ante límites Free. Agent/Deep Research no son runtime de escritura. |
| T25 | Branch/source negatives | Fuente desconectada, rama inexistente, respuesta malformada o error al obtener fuente no llama a `sessions.create`. |
| T26 | Publicación plugin | Paquete MCP, dominio, escaneo, revisión y publicación oficial comprobados. Sin aprobación no se declara disponibilidad pública. |
| T27 | OAuth y aislamiento | OAuth 2.1/PKCE identifica sujeto; el servidor valida issuer/audience/expiry/scopes y filtra fuentes/repos/ramas. Usuario no autorizado no lista ni muta recursos ajenos. |
| T28 | Cuotas Free y reanudación | Al alcanzar límite Free, se detiene sin duplicar POST y retoma desde el último checkpoint. |
| T29 | No dependencia de GPT Actions | La instalación y escritura funcionan sin crear/editar un GPT personalizado ni usar GPT Actions. |
| T30 | Exclusión Codex | Desarrollo, pruebas, publicación, instalación y operación no invocan ni requieren Codex. |
| T31 | Actualización de tools | El directorio refleja la versión aprobada; un cambio de herramientas no escaneado/aprobado no se declara disponible. |
| T32 | Sin extensiones nativas | El ciclo de herramientas MCP funciona en chat web normal sin depender de extensiones de sidebar/composer/file-viewer no disponibles aún en Free. |

**Gate de release:** T01–T13 pasan según ámbito; T14–T17 se ejecutan con API, plugin y ChatGPT Free reales. T18 tiene lectura de vuelta; T23, T26 y T27 son gates duros; T28–T32 también deben pasar. No se declara MVP utilizable con gates pendientes o fallidos. Las excepciones no se silencian ni se interpretan como PASS.

## 14. Bloqueos y riesgos conocidos al iniciar la planeación

1. **Disponibilidad real del plugin MCP público en ChatGPT Free:** el directorio abarca distintos planes, pero cada plugin tiene disponibilidad/capacidades propias por plan y región. Escritura Free aún NO VERIFICADA; requiere prueba real.
2. **Credencial Jules:** `JULES_API_KEY` figura configurada como variable sensible en Vercel producción según el registro previo, consultada sin descifrar. Su validez no está demostrada; no recuperar ni exponer el valor.
3. **CI de Khora:** el último diagnóstico persistido para PR #338 reporta typecheck/UI review/contratos UI/API tests aprobados, suite unitaria 547 PASS/1 FAIL por lectura del esquema privado de Metodología sin `GH_TOKEN`, dos findings Ruff fuera del diff y build/E2E fallidos aguas abajo. Debe refrescarse contra el head vigente antes de tomar decisiones.
4. **CI de Metodología:** `validate-canonical-bootstrap.py` y un workflow de gobernanza muestran runs fallidos. La fuente de validación contiene expectativas antiguas de Samantha v339/NX-339m y varios archivos Markdown de compatibilidad; el canon vigente es el DUG HTML v360/NX-360m. El diseño de corrección debe preservar una fuente normativa única y distinguir interfaces de compatibilidad de autoridad normativa. Los logs del run no fueron recuperables, por lo que no se atribuye a un paso exacto la causa de una ejecución concreta.
5. **Límite de API:** Jules documenta la API `v1alpha`; el contrato puede cambiar. Revalidar los esquemas al comenzar implementación y antes de release.
6. **Automatización persistente:** no hay trabajador externo aprobado/implementado por este plan. La interacción MCP ocurre cuando se invocan herramientas durante una conversación activa.
7. **PR documental sin integrar:** Metodología PR #19 sigue en borrador en la rama de trabajo. El plan y los artefactos no están disponibles todavía como estado de `main`.
8. **Revisión/publicación externa:** OpenAI puede rechazar o demorar el plugin o exigir cambios de metadata, privacidad, seguridad o autenticación. La aprobación es externa y no se presume.
9. **Aislamiento de usuario/repositorio:** el servidor actual debe demostrar autorización por sujeto y recurso antes de exponerse públicamente; read/write global no basta para proteger repositorios privados.

## 15. Secuencia de fases posterior a la planeación

### Fase 1 — Planeación integral del componente v1.0 (COMPLETA — cierre de diseño)

- Establecer requisitos, arquitectura y límites.
- Especificar contratos de las siete herramientas y estados.
- Definir seguridad, trazabilidad, persistencia, fallos, operación y recuperación.
- Completar pruebas y criterios de aceptación.
- Resolver o registrar formalmente las compuertas de viabilidad y los riesgos.
- Hacer revisión de consistencia entre plan, OCP, plan de aceptación y PR candidato.

**Salida:** plan v1.0 consistente, trazable y revisable. No cambia código de producto.

### Fase 2 — Reconciliación e implementación

- Comparar PR #338 y el código del servidor con la línea base; matriz de deltas por archivo/requisito.
- Revalidar API Jules v1alpha, contratos KHORA y OAuth 2.1 para plugins MCP públicos.
- Ejecutar primero un gate temprano de viabilidad: usar el endpoint central de KHORA, preparar un paquete MCP de prueba, verificar dominio/identidad, escanear tools e intentar instalar/autenticar desde ChatGPT Free. No crear un segundo servidor. Si OpenAI no permite prueba antes de revisión/publicación, documentar ese requisito antes de seguir.
- Auditar autorización por sujeto/recurso: identidad OAuth → KHORA → source/repo/branch allowlist → scopes. No filtrar fuentes de Jules que el sujeto no pueda usar.
- Corregir source/branch server-side, retries GET/POST, pageToken, estados, diagnósticos, contratos y pruebas.
- Preparar paquete, metadatos, privacidad, soporte, acceso demo aislado y evidencias para el proceso de revisión del directorio.
- Aislar fallos ajenos al diff y documentar sus responsables; ejecutar suite actual y leer de vuelta evidencia.

**Salida:** candidato alineado y paquete sometido/aceptado según evidencia; todavía no MVP utilizable hasta que Free supere Fase 3.

### Fase 3 — Validación integrada real

- Validar JULES_API_KEY por llamada real sin mostrar su valor.
- Instalar el plugin publicado desde el directorio en una cuenta personal ChatGPT Free real, en la región/superficie objetivo; sin Developer Mode ni cuenta de pago.
- Completar OAuth y verificar que el sujeto solo ve fuentes/repos/ramas autorizados.
- Descubrir las siete herramientas y validar scopes de lectura/escritura.
- Ejecutar ciclo no destructivo en repositorio sandbox: crear → plan → aprobación humana → ejecución → feedback → respuesta en la misma sesión → PR/outputs → verificación independiente.
- Probar cuota Free, OAuth expirado/revocado, timeout ambiguo, 429/5xx, paginación, fuente desconectada, branch inexistente y usuario sin permiso.
- Interrumpir y reanudar desde checkpoint sin worker persistente ni duplicados.
- Persistir outputs y evidencias en OCP.

**Salida:** E2E reproducible desde ChatGPT Free; si escritura Free no está disponible, gate BLOCKED y no se declara MVP.

### Fase 4 — Release y replicación controlada

- Revisar diff, CI vigente, findings del plugin, credenciales, privacidad, permisos y autorizaciones.
- Completar merge y despliegue solo con autorización; la aprobación OpenAI del plugin no sustituye revisión de código.
- Publicar/activar plugin aprobado y comprobar que listing y tools reflejan la versión aprobada.
- Ejecutar smoke desde ChatGPT Free tras despliegue: instalación, OAuth, descubrimiento, lectura y escritura no destructiva.
- Publicar guía de instalación/operación/replicación; todos los frentes reutilizan plugin y servidor central.
- Documentar límites Free, revocación, rollback, soporte y ámbito de acceso.
- Declarar v1.0 utilizable solo con todos los gates aplicables, especialmente T23/T26/T27.

**Salida:** release verificado y utilizable desde ChatGPT Free, guía de instalación/operación y matriz de límites.

### Evolución futura

Si se solicita sondeo persistente, notificaciones, respuesta automática acotada u orquestación avanzada de PR/CI, planificar una versión posterior con su propio diseño de disponibilidad, coste, idempotencia, seguridad, permisos, checkpoint y aceptación. No inferir su inclusión a partir de v1.0.

## 16. Condiciones para declarar completa la fase 1

- Propósito y resultado con ChatGPT Free como cliente obligatorio y Codex excluido.
- Ciclo bidireccional y contratos de las siete herramientas, scopes, estados, errores y pruebas.
- Ruta de distribución definida: plugin MCP público, mismo endpoint central KHORA /api/mcp.
- Diferencia documentada entre conexión MCP privada (no objetivo de Free) y plugin público (candidato Free con capacidades por probar).
- Proceso de paquete, verificación de dominio, OAuth, escaneo, revisión, publicación e instalación.
- OAuth 2.1, identidad KHORA y permisos granulares por sujeto/fuente/repositorio/rama.
- Seguridad, control normativo, aprobación humana, source/branch, pageToken, retry diferenciado, persistencia, recuperación y errores.
- Límites Free, interrupciones, checkpoints y reanudación.
- Gates de aceptación con evidencias, fases y resultados explícitos; pruebas de plugin/Free/OAuth/aislamiento/no-Codex.
- Secuencia de solo cuatro fases posteriores: Fase 2 reconciliación e implementación; Fase 3 validación integrada real; Fase 4 release y replicación controlada.
- Consistencia entre plan, OCP, README, investigación, prompts, guía de replicación y aceptación.
- Control de responsabilidad de este frente sin cambios; DUG y control del frente padre intactos.
- Plan guardado y verificado mediante lectura de vuelta.

Completar el diseño no equivale a publicar el plugin, validar la API, instalar en Free, demostrar escritura, desplegar o aceptar código. Son gates posteriores; la viabilidad Free no se marca PASS por inferencia.

## 17. Fuentes técnicas consultadas

- [Jules REST API — catálogo de métodos](https://developers.google.com/jules/api/reference/rest) — endpoints para sources, sessions y activities; API `v1alpha`.
- [Jules Session resource](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions) — `requirePlanApproval`, source context y estados publicados.
- [Jules sessions.create](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/create) — creación de sesiones.
- [Jules sessions.sendMessage](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/sendMessage) — envío de mensajes a una sesión.
- [Jules sessions.approvePlan](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions/approvePlan) — aprobación de plan.
- [Jules sessions.activities.list](https://developers.google.com/jules/api/reference/rest/v1alpha/sessions.activities/list) — actividades y paginación.
- [OpenAI: Connecting custom MCP servers in ChatGPT](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt) — disponibilidad de conexión MCP privada y escritura por plan; no se usa como ruta Free.
- [OpenAI: Plugins in ChatGPT](https://help.openai.com/en/articles/20001256-plugins-in-chatgpt) — directorio disponible en distintos planes; plugin individual sujeto a plan, cuenta, región y capacidades.
- [OpenAI: Apps in ChatGPT](https://help.openai.com/en/articles/11487775-apps-in-chatgpt) — terminología/disponibilidad.
- [OpenAI Developers: Upload and submit your plugin](https://developers.openai.com/plugins/deploy/submission) — paquete, identidad, conexión/escaneo, revisión y publicación.
- [OpenAI Developers: Authenticate your users](https://developers.openai.com/plugins/build/auth) — OAuth 2.1, PKCE S256 y autenticación MCP.
- [OpenAI: ChatGPT Free Tier FAQ](https://help.openai.com/en/articles/9275245-chatgpt-free-tier-faq) — límites Free y creación de GPT personales no disponible.
- [OpenAI: Plugin Extensions](https://developers.openai.com/plugins/build/extensions) — extensiones nativas de sidebar/composer/file viewer son distintas de las herramientas MCP del plugin; extensión web pendiente para Free/Go, funcionalidad existente del plugin no afectada.
- [ChatGPT Learn: Model Context Protocol](https://learn.chatgpt.com/docs/extend/mcp) — ChatGPT web consume herramientas MCP remotas a través de plugins; el empaquetado debe declarar compatibilidad con web.
- [OpenAI: GPTs in ChatGPT](https://help.openai.com/en/articles/8554407-gpts-in-chatgpt) y [GPT Actions](https://developers.openai.com/api/docs/actions/introduction) — no seleccionado como dependencia.

La disponibilidad general del directorio no garantiza que este plugin tenga escritura en Free; esa incertidumbre sigue siendo un gate real.
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
| ADR-02 | Siete herramientas públicas; la lectura/validación de fuente y branch se realiza internamente en el servidor/adaptador Jules. | Mantiene el contrato acotado y evita confiar en argumentos del modelo. | T01/T05/T19/T25. |
| ADR-03 | Cada creación fuerza `requirePlanApproval=true`. | Impide que la sesión empiece sin revisión del plan. | El parámetro no se expone al modelo; T06. |
| ADR-04 | Crear con `automationMode=AUTO_CREATE_PR`. | El componente está destinado a desarrollo delegado y debe entregar un PR cuando se genera un parche aplicable. | PR no equivale a merge; T20/T18. |
| ADR-05 | Lectura y escritura quedan separadas por `jules:read` y `jules:write`, y conservan el ciclo normativo existente de Khora. | Principio de privilegio mínimo y coherencia con el servidor común. | Los tokens no reciben scopes Jules por defecto; T03/T04. |
| ADR-06 | La aprobación requiere consentimiento explícito en la conversación y comprobación del estado/plan inmediatamente antes de invocar la herramienta. | La aprobación habilita ejecución en un proveedor externo. | El MCP de v1.0 comprueba el estado, pero no puede probar por sí solo quién escribió el consentimiento; se debe obedecer además la confirmación de la plataforma cuando se presente. No declarar una barrera criptográfica de aprobación. T07/T22. |
| ADR-07 | GET permite reintentos acotados; POST de creación/mensaje/aprobación no se reintenta automáticamente ante timeout de red o 5xx ambiguo. | El contrato no documenta clave de idempotencia y ciertos POST responden vacío. | Read-after-ambiguous-write y decisión explícita antes de repetir; T10/T21. |
| ADR-08 | El endpoint de creación valida fuente y rama desde el servidor antes del POST. | No confiar únicamente en argumentos generados por el modelo. | Obtener Source actual y comparar branch exacta; T19/T25. |
| ADR-09 | El modo objetivo es chat web conversacional normal con plugin MCP público aprobado e instalado en ChatGPT Free. | El directorio y la capacidad de escritura de cada plugin dependen de plan/cuenta/región; Agent/Deep Research no son runtime de escritura equivalente. | Gate externo de publicación y Free real; T15/T23/T24/T26. |
| ADR-10 | Sin worker persistente, autorespuesta ilimitada, auto-merge ni auto-deploy en v1.0. | Mantiene el MVP acotado y evita conceder autonomía no solicitada. | Seguimiento invocado por herramientas durante turnos activos; extensiones fuera de alcance. |
| ADR-11 | OCP: núcleo como estado vivo único y crónicas como historial verificable; no crear otra DB solo por simetría. | Respeta el objeto canónico y el requisito de continuidad. | Registrar IDs/cursor/estado/resultados mínimos; T17. |
| ADR-12 | Distribución v1.0 como plugin MCP público en el directorio ChatGPT, conectado al endpoint único KHORA /api/mcp. | MCP privado con escritura no es la ruta Free; directorio de plugins incluye varios planes, capacidades individuales no garantizadas. | Paquete/revisión/publicación y prueba Free; T15/T23/T26/T31. |
| ADR-13 | ChatGPT Free es el cliente obligatorio; Codex se excluye de construcción, pruebas, publicación, operación y contingencia. | Restricción expresa del operador. | T23/T29/T30. |
| ADR-14 | No depender de GPTs personalizados ni GPT Actions. | Free no crea/publica GPTs personales nuevos; no es dependencia estable del MVP. | T29. |
| ADR-15 | Cada llamada exige OAuth 2.1 y autorización del sujeto por source/repo/branch además de scopes Jules. | Publicar el plugin no debe abrir repos privados. | T27 y negativos de aislamiento. |
| ADR-16 | Escritura desde ChatGPT Free es NO VERIFICADA hasta prueba real. | Directorio general no garantiza acciones de cada plugin por plan/región. | Gate T23/T26; si falla se detiene la declaración de MVP. |

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
| Acceso indebido por plugin público | OAuth identifica sujeto; autorización server-side por fuente, repositorio y rama; rechazo por defecto. | T27. |
| Saturación / coste | PageSize 1–100; backoff limitado para GET; sin loops infinitos ni trabajador persistente. | Pruebas de límite/reintento. |
| Plugin no visible/no habilitado en Free | Confirmar listing, plan, región y superficie; bloquear, no sustituir con MCP privado de otro plan. | T23/T26. |
| Sujeto OAuth sin permiso de fuente | Rechazar sin filtrar fuente, rama, sesión ni actividad ajena. | T27. |
| Plugin/cambio de tools no aprobado | No simular publicación; conservar versión aprobada anterior o bloquear función. | T26/T31. |
| Cuota Free agotada | Preservar checkpoint y reanudar explícitamente; no repetir POST ambiguo. | T28.

El registro operativo incluye IDs y tiempos mínimos, estados, errores de clase, correlación y checkpoint. No debe copiar cuerpos completos, prompts sensibles ni secretos a telemetría. Las pruebas con repositorios privados requieren fuente y rama de prueba autorizadas.

## 22. Procedimiento de implementación y release posterior

### Fase 2 — reconciliación

1. Obtener el head actual de Khora PR #338 y comparar sus archivos con el diseño de este plan.
2. Crear matriz de deltas: conforme, falta, contradicción, no verificable.
3. Implementar primero la validación interna source/branch, política de retries por método, contratos input-only, estados, diagnósticos y pruebas.
4. Corregir la paginación con `pageToken` exclusivamente; retirar o aislar helpers antiguos que usen parámetros no documentados.
5. No incluir fixes de Ruff ajenos al diff de Jules sin coordinación con su frente responsable.
6. Mantener `JULES_API_KEY` fuera de Git y no leer su valor para depurar; la prueba debe informar éxito/fallo y metadatos mínimos.
7. Auditar OAuth 2.1 del endpoint: metadata de recurso/autorización, PKCE S256, resource, issuer, audience, expiración y scopes.
8. Implementar autorización por sujeto y recurso; no devolver fuentes Jules que el sujeto KHORA no puede usar.
9. Preparar paquete MCP público con un solo servidor remoto, identidad verificada, dominio, metadata, privacidad/soporte, escaneo y revisión oficial. No usar GPT Actions ni Codex.

### Fase 3 — validación integrada

1. Obtener una fuente y rama de prueba reales a partir de Jules.
2. Crear una sesión inocua y comprobar el estado `AWAITING_PLAN_APPROVAL`; el test de payload comprueba `requirePlanApproval=true` aunque la respuesta omita ese campo input-only.
3. Revisar el plan con el operador y recibir aprobación explícita.
4. Aprobar, reconsultar y verificar ejecución/actividad real.
5. Simular/ejecutar una solicitud de feedback y responder en la misma sesión.
6. Instalar el plugin publicado en cuenta ChatGPT Free real desde el directorio; completar OAuth sin Developer Mode.
7. Confirmar las siete tools, scopes y aislamiento por sujeto/fuente/repo/branch.
8. Ejecutar escritura real no destructiva, aprobación humana y feedback bidireccional en el mismo session ID.
9. Probar cuota Free y reanudar desde checkpoint.
10. Probar timeout ambiguo, 429/5xx, paginación, fuente desconectada, branch inexistente, OAuth revocado y usuario sin permiso.

### Fase 4 — release/reversión

1. Publicar el plugin aprobado y comprobar que listing/tools reflejan la versión real; después de cambios, solicitar/resolver escaneo y verificar actualización. No depender de Developer Mode ni de MCP privado de pago.
2. Confirmar CI, diff, revisión humana y autorización aplicable antes de merge.
3. Desplegar solo con autorización y compuertas de Khora; revisar la URL canónica y estado de producción.
4. Ejecutar prueba de humo no destructiva: health/lectura de fuentes; crear sesión real solo en fuente/rama aprobada.
5. **Rollback:** si una regresión afecta el endpoint MCP común, detener nuevas acciones Jules, revocar/deshabilitar scopes Jules en la app/tokens según la capacidad existente, revertir el commit mediante el procedimiento de Khora y comprobar que las herramientas previas funcionan. No borrar sesiones o PR creados. Si hay sospecha de clave comprometida, rotarla en el proveedor/entorno autorizado y verificar sin imprimirla.
6. Rehabilitar escritura solo después de releer el despliegue, descubrir las herramientas desde ChatGPT Free y pasar smoke. Ante abuso, revocar sujeto/OAuth/scopes o publicación.

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
| REQ-17 ChatGPT Free cliente obligatorio | §§2/11, ADR-13/16 | T15/T23/T24 | Definido; prueba real pendiente |
| REQ-18 Distribución plugin MCP público | §11.3, ADR-12 | T26/T31 | Diseñado; publicación pendiente |
| REQ-19 OAuth y autorización por recurso | §11.4, ADR-15, §21 | T27 | Definido; contrato KHORA por reconciliar |
| REQ-20 Exclusión Codex/GPT Actions | §§4/11, ADR-13/14 | T29/T30 | Restricción expresa y documentada |

## 24. Cierre verificable de la Fase 1

**Resultado de planeación: COMPLETO como especificación integral que guía las cuatro fases del resultado MCP Jules v1.0.** Esta revisión R2 incorpora el requisito del operador: desarrollar repositorios desde ChatGPT Free y no utilizar Codex en el futuro previsible. La completitud del diseño no afirma que el código exista, que OpenAI haya aprobado el plugin o que Free haya demostrado escritura.

### Decisiones cerradas

- Producto: integración bidireccional para delegación, aprobación, ejecución, feedback y verificación.
- Cliente final: ChatGPT Free en chat normal.
- Distribución: plugin MCP público del directorio oficial; no conexión privada MCP para un cliente cuyo plan no la admita.
- Transporte: servidor MCP central KHORA /api/mcp, siete herramientas.
- Identidad: OAuth 2.1, sujeto autenticado y permisos por fuente/repositorio/rama.
- Credencial Jules: JULES_API_KEY únicamente en servidor.
- Flujo: aprobación humana forzada, AUTO_CREATE_PR, respuesta en misma sesión y verificación independiente.
- Robustez: validación source/branch, pageToken, retry seguro, recuperación de escritura ambigua y estados.
- Seguridad: scopes mínimos, aislamiento por sujeto/recurso, salida Jules no confiable, errores saneados.
- Operación: cuotas Free, checkpoints y reanudación; sin worker permanente.
- Exclusiones: Codex, GPT Actions, aprobación automática, autorespuesta ilimitada, auto-merge y auto-deploy.
- Aceptación: 31 pruebas/gates; incluye plugin público, OAuth/aislamiento y prueba real desde Free.
- Secuencia posterior exacta: Fase 2 reconciliación e implementación; Fase 3 validación integrada real; Fase 4 release y replicación controlada.

### Gates que no pueden pasar por decisión documental

1. Plugin MCP conectado, escaneado, aprobado y publicado en el directorio.
2. Instalación y escritura demostradas en una cuenta Free real, en la región/superficie objetivo, sin Developer Mode ni plan pagado.
3. OAuth y autorización granular comprobados; ningún sujeto ve recursos ajenos.
4. JULES_API_KEY validada por llamada real sin revelar su valor.
5. Deltas de implementación corregidos y CI ejecutado contra head vigente.
6. E2E completo en repositorio sandbox con evidencia por transición.
7. Release autorizado, smoke y rollback verificados.

Ninguno se declara PASS sin evidencia. La disponibilidad general del directorio no prueba escritura del plugin en Free. Si Free bloquea el plugin o la escritura, el objetivo queda BLOCKED y se requiere nueva decisión arquitectónica; no se sustituye silenciosamente por plan pagado, GPT Actions, Codex o relevo manual.

**Estado de Fase 1:** cerrada como diseño integral y trazable. **Siguiente fase autorizable:** Fase 2 — reconciliación e implementación, comenzando por el gate temprano de plugin público/ChatGPT Free y autorización OAuth. No autoriza aún merge, publicación ni despliegue productivo.
