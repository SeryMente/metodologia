# GOV-TASK-013 — Medición objetiva y optimización del tiempo de procesamiento de ciclos

**Estado:** en_curso · **Tipo:** tarea propia de Gobernanza · **Responsabilidad:** Gobernanza 2 (asiento corresponsable activo `SES-20261101-GV8E89D1FF`, generación 12), por delimitación operativa expresa del operador. Esta atribución no transfiere la titularidad primaria del frente ni modifica su control.

## Delimitación de responsabilidades

- **Gobernanza 2:** responsable de GOV-TASK-013 y de su diseño de medición, instrumentación, captura, análisis, línea base y experimentos de optimización. También conserva GOV-TASK-012 dentro de su ámbito propio.
- **Gobernanza 1:** titular primario y responsable exclusivo de la DTC (Dinámica Trilateral por Ciclo), incluida GOV-TASK-011, el sprint DTC, la coordinación interfrente, sus ciclos, cursores, solicitudes, integración, dependencias y aceptación.
- **Límite de esta tarea:** GOV-TASK-013 no abre, procesa ni cierra ciclos DTC; no opera cursores o mensajes EP/MCP-OCP; no emite solicitudes interfrente ni modifica GOV-TASK-011, tableros o artefactos de coordinación pertenecientes a Gobernanza 1.
- Si una medición revela una dependencia interfrente, Gobernanza 2 documenta el hallazgo y lo canaliza a Gobernanza 1. No ejecuta por sustitución el trabajo del titular DTC.
- Esta separación es una asignación funcional de tareas; no altera el roster, la titularidad ni el control común del frente.

## Objetivo

Medir de manera reproducible la duración observable del ciclo completo de interacción con ChatGPT en el uso personal del operador y permitir comparar mejoras sin introducir espera en la respuesta. El contrato de eventos será semántico y portable a otras plataformas; la primera integración objetivo es ChatGPT. No se declarará cobertura de una plataforma hasta disponer de un adaptador real y verificable.

## Restricciones de diseño vigentes · instrucción del operador 2026-11-02 y decisiones aclaratorias 2026-11-07

1. **Una sola magnitud primaria:** duración observable del ciclo completo. No desplegar KPIs adicionales, latencias por herramienta, conteos operativos, tokens/costo, first-token, tasas de error ni reintentos como métricas de desempeño, salvo nueva decisión expresa.
2. **Clasificación:** conservar una categoría del ciclo únicamente para poder contar la frecuencia de cada clase. No crear taxonomía por iniciativa propia; el catálogo queda pendiente de definición.
3. **Checkpoint inicial común:** evento semántico `cycle.accepted` en el límite de entrada del entorno que recibe y admite la interacción, antes de iniciar procesamiento específico del proveedor/modelo. No usar la primera acción interna o detectiva del modelo.
4. **Checkpoint final común:** evento semántico `cycle.completed` cuando termina el ciclo completo y la salida final queda disponible para el consumidor, después de las iteraciones de herramientas y orquestación que pertenezcan a ese mismo ciclo.
5. **Portabilidad:** los nombres anteriores pertenecen al contrato común, no son nombres de API impuestos a proveedores. Cada adaptador debe mapear señales nativas verificables. Si falta cualquiera de los dos límites, registrar `NOT_MEASURED` y el motivo; no inferir ni sustituir checkpoints.
6. **Reloj:** calcular duración con reloj monotónico cuando el adaptador controle ambos extremos. Guardar las marcas UTC, fuente y precisión del reloj para auditoría. No calcular duración restando relojes de pared susceptibles de ajuste.
7. **Aislamiento de la ruta crítica:** capturar los timestamps y calcular la duración localmente con trabajo mínimo. No efectuar llamadas de red, escrituras remotas ni esperas de persistencia antes de que la respuesta final haya sido entregada. La medición/persistencia no debe retrasar la resolución ni la entrega del ciclo.
8. **Persistencia desacoplada:** después de entregar la respuesta, enviar el registro compacto a persistencia. La primera versión no utilizará Cloudflare Queues; añadir una cola solo se reconsiderará si pruebas reales demuestran una necesidad de durabilidad/reintentos que no pueda resolverse con el mecanismo mínimo. La estrategia de recuperación ante fallos se debe especificar antes de declarar fiable la captura.
9. **Integración conversacional/AT:** relacionar el resultado con el UUIDv7 local de conversación, la identidad local del ciclo y las referencias de registro A/B y AT cuando existan. No inventar IDs nativos, folios ni referencias. No duplicar el texto A/B ni crear un registro por herramienta.
10. **Ámbito físico:** reutilizar el OCP transversal existente `ambitos/gestion-conversacional/` para el contrato común y sus referencias; no crear una copia de telemetría por frente. Cada frente conserva únicamente las referencias que le correspondan.
11. **Contenido:** conservar A/B literal según ART-024, sin razonamiento interno oculto ni secretos. La captura automática no se presume: requiere adaptador real, permisos y prueba de lectura de vuelta.
12. **Persistencia y destino:** antes de añadir PostgreSQL, evaluar el mecanismo de persistencia central ya disponible a través de la integración Harmonia/MCP y el OCP correspondiente. Neon/PostgreSQL queda como alternativa, no como decisión ni requisito de la primera versión. No crear bases, buckets ni servicios nuevos si el destino MCP/OCP existente puede cumplir persistencia, acceso y lectura de vuelta. Cualquier recurso nuevo requiere decisión y autorización expresa.
13. **FOL1:** continúa PREPARADO_PENDIENTE_ACTIVACION_IPZ. No asignar folios nuevos ni declarar activación desde esta tarea; respetar la compuerta vigente de IPZ y nueva conversación.

## Verificación documental inicial de OpenAI

- Responses API streaming documenta eventos de ciclo de vida como `response.created`, `response.completed` y `error`; son señales de una respuesta API y solo pueden mapearse al ciclo externo cuando la arquitectura confirma esa equivalencia: https://developers.openai.com/api/docs/guides/streaming-responses
- La exportación ordinaria de ChatGPT entrega una copia descargable del historial; no es un hook de captura en vivo por turno: https://help.openai.com/en/articles/7260999-exporting-your-chatgpt-history-and-data
- La Compliance Platform se limita a espacios Enterprise/Edu elegibles y permisos administrativos; no se presume disponible en una cuenta personal ni constituye un hook universal: https://help.openai.com/en/articles/9261474-openai-compliance-platform-for-enterprise-and-edu-customers

**Bloqueo técnico vigente:** existe una extensión de observabilidad de ChatGPT dentro de Khora que constituye una ruta candidata de captura, pero el código publicado y la evidencia de uso natural revisados no demuestran todavía los dos checkpoints semánticos de ciclo. Los eventos de Responses API tampoco prueban por sí solos que exista captura de ciclos de ChatGPT UI. No implementar un adaptador basado en suposiciones o señales detectivas distintas.

## Integración transversal mediante Khora/Harmonia · aclaración del operador 2026-11-07

### Límite de propiedad y uso

El operador aclara que Khora no forma parte del OCP MCP; no obstante, la extensión mantenida en el repositorio Khora podrá utilizarse como capa integradora transversal de los sistemas construidos por el operador y como cliente/adaptador para propósitos de MCP.

Esta autorización de uso no convierte al repositorio Khora en parte del OCP MCP, no traslada la propiedad del código, no crea un OCP adicional y no autoriza a esta tarea a modificar el repositorio Khora. El contrato y el destino de persistencia siguen bajo el OCP correspondiente; la extensión actúa como componente externo de integración.

### Componentes identificados en Khora

1. **Sombrilla modular de integraciones:** `SeryMente/khora/khora-web/extension/harmonia/`. Su README actual la presenta como **Aisthesis (Halcon)**, una extensión Chrome MV3 que hospeda módulos enchufables; el contrato de módulos permite agregar `modules/<id>/`, scripts de fondo, content scripts y permisos específicos. Los secretos se mantienen en almacenamiento local de Chrome y los módulos deshabilitados no se cargan. Fuentes inspeccionadas: `README.md` blob `56cfd787f47a0b59f56b5f8e1b97b1e636bfec61`; `MODULE-CONTRACT.md` blob `375b4d61238071b983181e38564baf5a8b266921`; `manifest.json` blob `9bf22c96d7f399a16f67d03dc8da02ea74b87e61`.
2. **Observador específico de ChatGPT:** `SeryMente/khora/apps/harmonia-observability/extension/`, manifiesto MV3 v0.3.0, limitado a `chatgpt.com` y colector local. Su content script actual emite `ui.surface.scan` con huellas y metadatos estructurales; puede reconocer rasgos como presencia del compositor o del estado de streaming, pero no emite transiciones de inicio/final por ciclo ni captura texto de mensajes. El service worker filtra los eventos entrantes a `ui.surface.scan`; el colector admite `ui.surface.scan`, `ui.surface.reused` y `capture.*`, no `cycle.accepted` ni `cycle.completed`. Fuentes inspeccionadas: `manifest.json` blob `5c2dd6d616c4ba19541d03df8fbc4abc6f0a11b6`; `content.js` blob `600f2bfb742aeb6f481fbb36ac762fd0d6907088`; `service-worker.js` blob `49d65381accdc33ce501eca6c4b5f2dd47a014b2`; `collector/server.js` blob `34b98945da3db4604e62a3c9baa367ce024a0a5c`.

### Evidencia y límites de aceptación

- El OCP Harmonia en main es v0.43. La traza real publicada de observación tiene 627 eventos: 10 `capture.started`, 611 `console.observed` y 6 `capture.stopped`; cero eventos de escaneo estructural y cero eventos de mensajes visibles. La fixture de 11 eventos es sintética y no demuestra captura natural. La extensión no está aceptada funcionalmente en Chrome.
- La PR #353 de Khora propone persistencia local-first (outbox IndexedDB, colector JSONL append-only/fsync, ledger, reintentos y ACK). Permanece en borrador y sin merge; conserva el content script v0.3.0 y explícitamente no incorpora captura de texto de mensajes. La validación local reportada es 8/8 sintaxis y 10/10 pruebas, pero GitHub Actions falló sin pasos/logs disponibles y la aceptación Chrome/EP sigue pendiente. Esta candidata mejora la capa de persistencia; no resuelve la semántica de inicio/final de cada ciclo.
- La diferencia de nombres entre la sombrilla ubicada en `khora-web/extension/harmonia/` (README: Aisthesis) y el observador `apps/harmonia-observability/` se conserva como hecho documental; esta tarea no renombra ni reconcilia productos dentro de Khora.

### Arquitectura autorizada como dirección de integración, no como implementación

`ChatGPT UI → observador/adaptador de Harmonia → persistencia local-first → cliente MCP → OCP/registro conversacional central`.

- Harmonia podrá servir de puente de integración con MCP aunque su código permanezca en el repositorio Khora.
- El módulo de medición debe ser mínimo: observar solo transiciones verificables de entrada/salida, registrar tiempo monotónico local y referencias de correlación. No ejecutar escaneos DOM/CSS extensos en cada transición ni capturar cuerpos de mensajes para medir duración.
- La entrega de la respuesta no espera a la persistencia ni al ACK remoto. La telemetría se entrega después mediante la outbox/cola local durable que esté aceptada y disponible.
- La persistencia final debe reutilizar primero el OCP/MCP autorizado y su mecanismo de read-back. No asumir que la outbox local equivale a persistencia central verificada.
- El adaptador de interfaz solo podrá mapear a `cycle.accepted` y `cycle.completed` tras pruebas naturales que demuestren que las señales observadas representan esos límites. Si solo se puede medir desde el envío visible hasta el fin visible de la generación, deberá registrarse como medida de cliente distinta; no etiquetarla como aceptación del servidor.

**Estado operativo:** Harmonia identificado como capa de integración reutilizable por autorización expresa del operador; el observador específico de ChatGPT existe en Khora, pero no implementa ni demuestra todavía medición canónica de ciclos. No se modificó Khora, no se conectó un destino MCP, no se habilitó transporte remoto y no se desplegó persistencia nueva.

## Registro mínimo por ciclo

Incorporar un único bloque `performance` al registro del ciclo existente; no crear una bitácora paralela ni una entrada por cada llamada.

Campos mínimos del bloque:

- `measurement_status`: `MEASURED` o `NOT_MEASURED`.
- `start_event`: `cycle.accepted`, con marca UTC, fuente y precisión.
- `end_event`: `cycle.completed`, con marca UTC, fuente y precisión.
- `duration_ms`: duración calculada con reloj monotónico; solo presente cuando ambos extremos sean verificables.
- `clock_source` y `clock_precision`.
- `conversation_uuid` y `cycle_id` locales, además de referencias existentes a A/B, OCP y AT cuando estén disponibles.
- `category`: referencia a una categoría del catálogo aprobado, cuando exista; no inventarla.
- `coverage_reason`: motivo cuando el estado sea `NOT_MEASURED`.

No conservar payloads, secretos ni contenido conversacional duplicado dentro de la telemetría. Las marcas inexistentes se registran como no medidas; nunca se estiman, reemplazan por cero ni completan retrospectivamente.

## Línea base y comparación

- Iniciar la línea base únicamente con ciclos que tengan ambos checkpoints capturados desde el comienzo.
- Reunir al menos 10 ciclos completos comparables antes de fijar una referencia inicial; con menos datos, informar la línea base como preliminar.
- Utilizar la mediana de `duration_ms` como resumen inicial de la única magnitud primaria. Informar siempre el tamaño de muestra y la cobertura.
- Comparar ciclos de la misma categoría cuando el catálogo esté aprobado. No atribuir causalidad a una diferencia aislada.
- Acreditar una mejora solo cuando se repita en ciclos comparables y no degrade exactitud, seguridad, autorización, trazabilidad ni disponibilidad de la respuesta.
- No fijar metas numéricas antes de disponer de una línea base observada.

## Decisión de arquitectura: extensión propia del OCP · 2026-11-08

**Decisión expresada por el operador:** el OCP de Gestión conversacional tendrá su propia extensión de navegador para instrumentar el uso personal de ChatGPT. La extensión será un componente del OCP transversal existente; no se creará un OCP duplicado ni una extensión genérica que altere el comportamiento funcional de ChatGPT.

### Contrato de medición de cliente

La extensión medirá explícitamente **tiempo de ciclo observado en el cliente**, no tiempo interno de procesamiento del servidor.

- **Inicio observable:** señal de interfaz verificable que indique que el mensaje del usuario fue enviado y el ciclo visible comenzó. La señal concreta debe probarse contra la interfaz vigente; no asumir que un clic, por sí solo, confirma envío.
- **Final observable:** señal de interfaz verificable que indique que la respuesta final terminó y está disponible para el usuario. La señal concreta debe probarse; no confundir tokens parciales, cambios intermedios del DOM o finalización de una solicitud auxiliar con respuesta final.
- **Duración:** diferencia calculada localmente mediante reloj monotónico del navegador, con ambas señales capturadas por la misma instancia de extensión.
- **Persistencia:** fuera de la ruta de interacción. La extensión no debe esperar confirmación de red ni de base de datos para permitir que ChatGPT continúe mostrando o recibiendo la interacción.
- **Identidad y correlación:** utilizar identificadores locales propios y referencias disponibles de conversación/ciclo/OCP/AT. No fabricar IDs nativos ni folios. No duplicar contenido A/B; recolectar solo los metadatos mínimos autorizados.
- **Cobertura:** ciclos en los que no pueda identificarse inequívocamente uno de los dos límites deben quedar como `NOT_MEASURED`, con motivo. No inferir duración ni rellenar marcas faltantes.

### Alcance y límites de autorización

Esta decisión autoriza diseñar la extensión como parte del OCP y ajustar el contrato de medición de GOV-TASK-013. No autoriza por sí sola instalarla, publicarla, desplegar servicios, provisionar PostgreSQL, cambiar permisos, capturar cuerpos de mensajes ni modificar el OCP compartido o su esquema central. Esas acciones requieren sus controles y autorizaciones correspondientes.

### Pruebas obligatorias antes de declarar implementación

1. Verificar las señales de inicio y final sobre la interfaz real de ChatGPT, incluyendo regeneración, respuestas con herramientas, interrupciones, errores y conversaciones largas.
2. Demostrar que las señales seleccionadas corresponden al ciclo visible completo y no a actividad interna parcial.
3. Demostrar que la instrumentación no bloquea ni retrasa la interacción y que la persistencia ocurre después.
4. Verificar que solo se recolectan metadatos mínimos y que no se capturan cuerpos de mensajes, credenciales, tokens o datos no autorizados.
5. Verificar manejo de duplicados, eventos incompletos, navegación/cierre de pestaña y fallos de persistencia.
6. Validar compatibilidad con el esquema central antes de escribir en el OCP compartido; la brecha de `performance` en A/B v1.1 continúa abierta y no se resuelve mediante esta decisión.

**Estado después de la decisión:** arquitectura de extensión aprobada conceptualmente por el operador; diseño técnico detallado, pruebas de señales, implementación, instalación y persistencia todavía pendientes. La magnitud queda definida como tiempo de ciclo observado en el cliente.

## Compatibilidad con el esquema conversacional existente · 2026-11-07

Se inspeccionó en main `ambitos/gestion-conversacional/ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json` (blob `29fa613da5baec41180a12f87f5a6e08edf44599`) y su guía operativa v1.1 (blob `1e917ff6c2a33c9e0fcfc87ddefad665d1385e35`).

- El esquema actual modela cada registro A y B por separado y establece `additionalProperties: false`.
- No define actualmente un campo `performance`; por tanto, el bloque mínimo propuesto en esta tarea todavía no es válido contra el esquema A/B v1.1.
- La guía confirma que el OCP es la materialización central de Gestión conversacional, que FOL1 permanece PREPARADO y que no existe captura automática presumida.
- Para mantener una sola evidencia por ciclo y no crear una bitácora paralela, la opción de menor impacto que se evaluará es alojar el bloque de duración una sola vez en el registro B del ciclo, que representa la salida final. No es una decisión de modificación del OCP ni autoriza una escritura allí.
- Cualquier ampliación del esquema central requiere la autorización y el procedimiento de cambio correspondientes. Esta tarea no modificó el OCP compartido, su esquema, la guía, el registro maestro ni FOL1.

**Resultado:** contrato de duración definido en GOV-TASK-013; compatibilidad física pendiente de una ampliación versionada y autorizada del esquema central. No crear esquema duplicado dentro de esta tarea.

## Criterio de aceptación

1. Existe un adaptador autorizado que captura ambos checkpoints reales de la plataforma objetivo; no se aceptan señales inferidas.
2. La duración se calcula localmente con reloj monotónico.
3. La respuesta final se entrega sin esperar llamadas de red ni persistencia de telemetría.
4. Existe una estrategia probada para conservar/reintentar registros cuando la persistencia no esté disponible.
5. El bloque mínimo se integra con Gestión conversacional y referencias AT sin duplicar contenido ni bitácoras.
6. Los registros incompletos quedan explícitamente como `NOT_MEASURED`.
7. Una prueba demuestra que la instrumentación no introduce espera perceptible ni bloquea la respuesta.

## Bitácora de decisiones y persistencia

- **2026-11-07 · Reconciliación de diseño:** se elimina la instrumentación ampliada por herramienta/operación/espera y se consolida una sola magnitud primaria: duración observable del ciclo completo. Se mantienen categorías solo para frecuencia. Se fija la entrega de respuesta antes de persistencia y se descarta Cloudflare Queues para la primera versión. PostgreSQL administrado permanece como candidato, sin provisionamiento.
- **2026-11-07 · Estado de captura:** continúa pendiente identificar y verificar un adaptador que observe `cycle.accepted` y `cycle.completed` en la interfaz personal de ChatGPT. No hay implementación activa ni datos de línea base.
- Cada avance futuro de esta tarea debe actualizar esta bitácora en el mismo cambio documental que registre el resultado. Distinguir siempre decisión, propuesta, implementación, prueba y verificación; no declarar persistencia o aceptación sin read-back.

## Fuentes y relación

- Norma: [DUG v377 · NX-377m](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), [Metacanon §52](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-52), [§4](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-4), [§28](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-28), [P020](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P020) y [P043](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P043).
- Análisis y optimización: [GOV-TASK-012](../📁%20🧩%20-%20GOV-TASK-012%20-%20Fluidez%20y%20desempe%C3%B1o%20del%20marco/README.md).
- Incorporación al ciclo recurrente: [GOV-TASK-011](../📁%20🧩%20-%20GOV-TASK-011%20-%20Coordinaci%C3%B3n%20bilateral%20recurrente/README.md), bajo responsabilidad exclusiva de Gobernanza 1 para el DTC.

**Siguiente acción:** evaluar el módulo mínimo de observación de ciclo dentro de la extensión Harmonia de Khora y verificarlo mediante uso natural en Chrome. Mantener la compuerta de captura cerrada hasta demostrar los checkpoints; después conectar persistencia al destino MCP/OCP existente, sin desplegar una base nueva por anticipado.

## Verificación de factibilidad de captura en ChatGPT personal · 2026-11-07

### Evidencia pública revisada

- La documentación de OpenAI para Responses API define eventos de streaming como `response.created` y `response.completed`. Son eventos disponibles para el cliente que consume directamente esa API; su documentación no acredita que la interfaz web personal de ChatGPT los exponga a extensiones ni que correspondan al ciclo externo completo de la interfaz: https://developers.openai.com/api/reference/resources/responses/streaming-events y https://developers.openai.com/api/docs/guides/streaming-responses
- Chrome `webRequest` permite observar el ciclo de solicitudes de red. `onBeforeRequest` ocurre antes de establecer una conexión TCP y `onCompleted` indica que una solicitud terminó correctamente; no son por sí mismos los eventos semánticos de aceptación y finalización del ciclo. La API tampoco expone los mensajes individuales que circulan por una conexión WebSocket establecida: https://developer.chrome.com/docs/extensions/reference/api/webRequest
- Chrome permite inyectar content scripts en páginas coincidentes, pero estos se ejecutan por defecto en un mundo aislado. La documentación de extensiones no define la estructura DOM de ChatGPT como una interfaz estable de telemetría: https://developer.chrome.com/docs/extensions/reference/manifest/content-scripts
- La API de OpenAI y ChatGPT tienen sistemas de facturación separados. Usar directamente Responses API no equivale a utilizar la suscripción personal de ChatGPT y puede generar cargos de API: https://help.openai.com/en/articles/9039756-managing-billing-for-the-chatgpt-and-api-platform

### Resultado y decisión

**Resultado:** con la documentación pública revisada no queda acreditado un hook autorizado y estable que permita a un adaptador personal de ChatGPT UI capturar exactamente `cycle.accepted` y `cycle.completed` según el contrato de esta tarea.

**No se autoriza inferir equivalencia** a partir del clic de envío, mutaciones del DOM, el inicio/cierre de una solicitud HTTP ni endpoints privados no documentados. Una extensión podría experimentar con señales de interfaz para medir tiempo percibido por el usuario, pero eso sería otra definición de medición y no se registrará como cumplimiento del checkpoint `cycle.accepted`.

Se conservan estas rutas posibles, sin implementar ninguna ni cambiar el contrato por inferencia:

1. Mantener el contrato original y esperar/identificar una fuente soportada que exponga ambos checkpoints de ChatGPT UI.
2. Solicitar una decisión explícita para sustituir la medición estricta por tiempo de ciclo observado en el cliente, con inicio y final claramente renombrados y cobertura/limitaciones documentadas.
3. Utilizar un cliente propio basado en Responses API, aceptando que es una integración distinta de la interfaz personal y que su facturación es independiente.

**Estado operativo:** adaptador ChatGPT UI NO IMPLEMENTADO; captura exacta NO VERIFICADA; línea base NO INICIADA. No generar mediciones ficticias ni presentar un experimento DOM/red como telemetría canónica.

## Decisión de arquitectura vigente: ampliar la extensión Harmonia existente · 2026-11-08

**Instrucción vigente del operador:** la medición en tiempo real se añadirá a la extensión Harmonia que ya existe en KHORA. No se creará una segunda extensión. La decisión anterior de §98–126 —extensión propia del OCP— queda **SUPERSEDIDA** por esta elección; se conserva como antecedente y no como instrucción de implementación.

### Componente existente y frontera correcta

- Repositorio: `SeryMente/khora`.
- Componente que se ampliará: `apps/harmonia-observability/extension/`, Manifest V3 v0.3.0 en el último corte inspeccionado.
- Content script existente: reconoce regiones y roles de mensajes, detecta presencia del compositor y ciertos indicadores de generación, observa mutaciones y calcula huellas estructurales. Mantiene fuera de captura el texto de mensajes, el borrador del compositor, los valores de campos, el HTML bruto y las URLs completas.
- Service worker existente: administra pestañas `chatgpt.com`, sesiones de captura y envío de eventos al colector local.
- Colector existente: `apps/harmonia-observability/collector/server.js`, escucha localmente en `127.0.0.1:47321` y conserva eventos JSONL e índice local.
- No confundir este observador con la sombrilla modular `khora-web/extension/harmonia/` (documentada como Aisthesis/Halcón). No se renombra, sustituye ni amplía esa sombrilla para resolver esta tarea.
- El barrido estructural actual aplica debounce de 1.6 s y limitación de frecuencia de 4 s. Por diseño no sirve para cronometrar un ciclo. La nueva captura será un observador estrecho, independiente y orientado a transiciones; no se acelerará el barrido global ni se ejecutarán escaneos completos en cada mutación.

### Semántica de medición aprobada

La única magnitud primaria será **duración del ciclo conversacional observado en el cliente**, en milisegundos. No representa latencia del servidor, tiempo interno del modelo ni equivalencia con `cycle.accepted`/`cycle.completed` del contrato de proveedor.

Se emplearán eventos propios, inequívocamente diferenciados:

1. `client.cycle.started`: primer instante en que el observador confirma que una nueva intervención del usuario está representada como un nuevo turno visible dentro de la región principal de conversación.
2. `client.cycle.completed`: fin observable del turno del asistente asociado, una vez que la interfaz deja de mostrar generación/actividad y la respuesta permanece estable durante la ventana de asentamiento definida y probada.

Reglas de señal:

- Al inicializarse, el observador establece una línea base de los turnos ya renderizados. El historial preexistente, una recarga o una reconstrucción del DOM no deben disparar ciclos retroactivos.
- El inicio exige la aparición de un nuevo nodo de turno de usuario, identificado únicamente por atributos estructurales/roles ya expuestos por la interfaz y su posición cronológica. No leer su texto, su contenido ni el valor del compositor. Un clic o una tecla de envío por sí solos no confirman un turno y no constituyen el checkpoint.
- El final exige que exista un turno de asistente posterior al inicio, que no permanezcan señales visibles conocidas de generación/actividad (por ejemplo, estado busy/streaming, control de detener o progreso visible de herramienta/agente) y que el área de respuesta permanezca sin mutaciones relevantes durante una ventana de asentamiento. La ventana inicial candidata es **1,500 ms**, sujeta a validación natural; el constructor deberá mantenerla como constante documentada y justificar cualquier ajuste mediante pruebas, no añadir retardos a la respuesta de ChatGPT.
- El timestamp final de medición corresponde a la última transición relevante observada que deja la interfaz inactiva y estable; la ventana de asentamiento sirve para confirmar el estado, no se suma artificialmente a `duration_ms`.
- Si se detecta una nueva intervención antes de concluir el ciclo activo, si se cierra/navega la pestaña, se reinicia el observador o no puede verificarse cualquiera de los límites, el ciclo queda incompleto y se representa como `NOT_MEASURED` con una razón técnica. No estimar ni completar marcas ausentes.
- La primera versión cubre nuevos turnos de usuario representados como nodos nuevos. Regenerar una respuesta, editar y reenviar un turno existente, reintentos sin nuevo turno visible y modos de voz cuyo patrón no haya sido validado quedan fuera de la cobertura medida; no reinterpretarlos como ciclo nuevo por inferencia.

### Reloj, identidad y correlación

- Tomar ambos tiempos en la misma instancia de documento mediante reloj monotónico del navegador (`performance.now()`). Guardar marcas UTC de auditoría, fuente del reloj y precisión disponible; calcular `duration_ms` solo con la diferencia monotónica. No restar timestamps de pared.
- Cada ciclo recibe un `cycle_id` UUIDv7 local. Cada contexto conversacional observado recibe un `conversation_id` UUIDv7 local. Los identificadores nativos de ChatGPT, rutas completas, parámetros de URL, IDs de cuenta y contenido no se copian al registro de telemetría.
- Mantener los `eventId` y `sessionId` históricos de Harmonia con su compatibilidad actual; introducir los UUIDv7 locales solo para las identidades nuevas que los requieren. Probar el generador UUIDv7 y evitar colisiones/reutilización.
- Un ciclo debe poder correlacionarse por `conversation_id` + `cycle_id` entre inicio y final, incluso si hay varios ciclos en una conversación. No generar folios FOL1 ni IDs nativos.

### Ruta de eventos y persistencia

- El content script detecta transiciones y captura marcas monotónicas/UTC con trabajo mínimo; el service worker valida y enruta los nuevos tipos; el colector aplica allowlist y saneamiento estricto específico para `client.cycle.started` y `client.cycle.completed`.
- El colector debe conservar únicamente los campos mínimos de telemetría aprobados. Su rama actual de saneamiento para eventos distintos de superficies/captura reduce el payload a un motivo genérico; por tanto, no basta con emitir nombres nuevos: se debe ampliar expresamente el contrato del colector y comprobar que los campos permitidos se escriben y se leen de vuelta.
- Guardar ambos límites en el almacén local JSONL existente y emparejarlos por `cycle_id`. Una consulta acotada `-Cycles` en el script de consulta puede presentar el registro emparejado y marcar inicios sin final como `NOT_MEASURED`; no crear un dashboard ni rediseñar el popup.
- La persistencia no interviene en la ruta de respuesta de ChatGPT. Ningún envío remoto, MCP, red, base de datos o ACK debe bloquear el renderizado o la interacción.
- La PR #353 de KHORA contiene una propuesta local-first con outbox IndexedDB, reintentos y ACK, pero permanece borrador/no fusionada y su rama estaba rezagada respecto de `main` en el último metadato consultado (2026-11-02). El constructor debe inspeccionarla y reconciliarla antes de reutilizar cualquier pieza; no asumir que sigue integrable, no fusionarla ni modificarla por arrastre y, sobre todo, no crear una segunda outbox/cola paralela. Si no puede aprovecharse sin ampliar el alcance, dejar explícito el límite de durabilidad y no inventar otro subsistema.
- El destino actual de esta tarea es el almacén local de Harmonia. No provisionar Neon/PostgreSQL, Cloudflare Queues, B2, servicios, endpoints ni credenciales. No conectar persistencia remota.

### Privacidad y no regresión

Se conserva y refuerza la política vigente de Harmonia:

- No capturar ni transmitir texto de mensajes del usuario/asistente, borradores, valores de inputs, texto de nodos, `textContent`, `innerText`, `innerHTML`, `outerHTML`, HTML bruto, contenido de atributos que pueda contener texto conversacional, cuerpos de red/WebSocket, cookies, tokens, credenciales, URLs completas o identificadores nativos de conversación.
- No añadir permiso `debugger`, interceptación de red, endpoints privados, scripts remotos ni permisos de host nuevos. El alcance permanece `https://chatgpt.com/*` y el colector local existente.
- El observador de ciclo puede usar MutationObserver sobre cambios estructurales, atributos de estado y cambios de nodos de texto **solo para registrar el instante de la mutación**; nunca leer ni conservar el valor del nodo ni el texto anterior. La prueba de privacidad debe verificar expresamente esta separación.
- No realizar clasificación semántica basada en el contenido. La taxonomía de categorías sigue pendiente; no añadir categoría hasta que exista catálogo aprobado.
- No añadir métricas de herramienta, first-token, tokens/costo, tasa de error, reintentos, conteos de actividad, latencia de persistencia ni otros KPIs. Los estados y razones de cobertura son metadatos de integridad de la medición, no magnitudes de desempeño adicionales.

### Pruebas y aceptación del constructor

El constructor trabajará solo sobre una rama nueva basada en el `main` vigente, luego de releer los archivos y SHAs actuales. No usará RDC, no instalará ni cargará la extensión en Chrome y no afirmará aceptación natural/E2E.

Pruebas mínimas:

1. Línea base inicial sin falsos ciclos; nuevo turno de usuario produce exactamente un inicio.
2. Streaming parcial, múltiples mutaciones de respuesta, desaparición/reaparición de señales busy, llamadas de herramientas y progreso de agente no generan final prematuro.
3. Solo se emite final cuando hay turno de asistente posterior y se cumplen las condiciones de inactividad/estabilidad; la duración usa reloj monotónico y no incluye artificialmente la ventana de asentamiento.
4. Segundo envío antes del final, regeneración, edición/reenvío, navegación, cierre de pestaña y reinicio del observador no producen emparejamientos falsos; quedan no medidos cuando corresponda.
5. Duplicados/replay conservan identidad e idempotencia; inicios sin final son detectables como incompletos.
6. El contrato del colector acepta los dos tipos de evento, rechaza campos extra/no permitidos y conserva mediante read-back las marcas, identidades y duración necesarias.
7. Pruebas de privacidad demuestran ausencia de contenido, borradores, valores, rutas completas, credenciales y datos de red, incluida la observación de mutaciones characterData sin lectura de su valor.
8. Regresión de las funciones actuales de Harmonia: mapeo estructural, fingerprint, sesiones por pestaña, colector, consulta, privacidad y almacenamiento.
9. La prueba automatizada usa fixtures sintéticas y declara esa limitación. La aceptación real requiere después una prueba natural autorizada en Chrome; no se simula ni se declara desde el constructor.

Entregables del constructor: diagnóstico breve de `main` y de PR #353; diseño de señales finalmente seleccionado con evidencia del código; diff limitado a los archivos necesarios; tests y salidas reales; lista de escenarios soportados/no soportados; límites de privacidad; instrucciones para la prueba natural autorizada; SHA de los artefactos y lectura de vuelta del commit de la rama. No modificar el OCP Harmonia, su control de responsabilidad, DUG, el esquema central A/B, FOL1 ni otros frentes.

**Estado:** decisión de reutilizar Harmonia y alcance de diseño aprobados por el operador. Este registro documenta la especificación que deberá convertirse en el prompt del constructor. No se ha implementado ni probado el observador de ciclo; no se ha modificado KHORA ni se ha instalado la extensión.



## Extensión expresa del alcance · medición de resolución IPZ por RDC · 2026-11-09

**Instrucción expresa del operador:** cuando Sink/IPZ esté implementado mediante el servidor local MCP-OCP invocado a través de Remote Desktop Commander (RDC), medir cuánto tarda una resolución iniciada desde el IPZ.

### Magnitud acotada

- **Identificador:** `ipz.resolve.rdc.duration_ms`.
- **Qué mide:** duración observable de extremo a extremo de una consulta iniciada por una referencia IPZ —`GOW:ARR`, `DUG` o `SINK:Pxxx`— desde el despacho de la llamada RDC hasta la recepción y validación de la respuesta completa del MCP-OCP local en el cliente ChatGPT.
- **Incluye:** transporte/orquestación RDC, espera de la llamada y ejecución local necesaria para resolver la referencia. No se presentará como tiempo puro de SQLite, tiempo interno del modelo ni latencia aislada del servidor.
- **Exclusividad:** solo aplica a las resoluciones IPZ→RDC→MCP-OCP. No habilita latencias genéricas por herramienta, métricas de todas las operaciones MCP, first-token, costes, errores ni reintentos.
- **Separación:** es una medición operativa secundaria y específica. No sustituye ni altera la magnitud primaria `cycle.duration_ms` de esta tarea, ni amplía la telemetría normativa de ART-027, que permanece limitada a frecuencia de consulta por principio.

### Captura y registro

- Tomar el tiempo con reloj monotónico del adaptador/orquestador que observe ambos límites. Se preferirá el dato de duración del propio adaptador RDC únicamente después de verificar su semántica, reloj y cobertura; no inferir que una duración local del proceso equivale al round-trip RDC.
- El inicio es inmediatamente antes de despachar la llamada RDC. El final es cuando el resultado íntegro de OCP MCP llega al cliente y supera la validación mínima de respuesta. No incluir persistencia posterior del evento.
- Campos mínimos: `measurement_status`, `reference_kind`, `principle_id` cuando sea una consulta individual o `principle_ids` como arreglo ordenado cuando una sola llamada RDC resuelva varios principios, `transport=RDC`, `duration_ms` si es verificable, `clock_source`, `clock_precision`, `dug_version`, `source_blob_sha` y un identificador local de evento/resolución. Las identidades locales de conversación/ciclo se vinculan solo cuando existan y estén verificadas.
- Si falta uno de los límites, el reloj no es monotónico o el adaptador no entrega una duración verificable del round-trip, registrar `NOT_MEASURED` con motivo. No calcular por resta de relojes de pared, no usar cero y no reconstruir retrospectivamente.
- Persistir el registro en el almacenamiento local ya existente de OCP MCP, reutilizando `telemetry_events` solo tras verificar que su esquema admite estos campos; cualquier migración queda en el OCP MCP y requiere pruebas/read-back. No crear un segundo servicio, base de datos, cola remota ni dependencia de GitHub Actions.
- La captura no leerá ni almacenará el texto del principio, el prompt, URLs, secretos ni payloads conversacionales. El ID Pxxx y la clase de referencia bastan para identificar el destino medido.
- La persistencia se realiza fuera de la ruta crítica de entrega: el cronómetro termina antes de escribir el evento. Una falla al persistir no debe bloquear ni retrasar la devolución del principio.

### Verificación y línea base

La medición queda **PENDIENTE DE IMPLEMENTACIÓN** hasta que OCP MCP entregue el resolver individual y EP haya instalado/validado el proceso local con RDC. La aceptación exige prueba positiva de `GOW:ARR`, `DUG` y al menos un `SINK:Pxxx`; caso negativo de referencia inexistente/fuente obsoleta; comprobación del round-trip y lectura de vuelta del registro. No se fijará objetivo temporal antes de obtener muestras reales. La línea base se declarará preliminar hasta contar con al menos diez resoluciones completas y comparables; resumir esta única magnitud con mediana y tamaño de muestra, sin crear KPIs adicionales.

**Responsabilidades:** Gobernanza define esta medición y acepta su evidencia; MCP-OCP implementa el resolver, el evento y el contrato local; EP instala/ejecuta el host y el transporte RDC. Esta ampliación no transfiere titularidad, no cambia controles de EP/MCP-OCP, no autoriza instalación, provisión del operador ni activación de `MCP-NORMATIVO`.


---

## OCP MCP 1.0 · correlación de sesión, dispositivo, ubicación y telemetría · 2026-11-10

**Alcance aprobado por el operador:** incorporar metadatos de sesión y contexto del host al sprint OCP MCP 1.0. Esta extensión no redefine las magnitudes de medición ya fijadas aquí.

### Identidad y nomenclatura

Usar UUIDv7 como identidad técnica canónica y etiquetas secuenciales legibles por entidad, generadas atómicamente y reconciliables tras sesiones offline:

- ORG-000001 · organización
- WSP-000001 · workspace persistente
- SES-YYYYMMDD-000001 · sesión
- LOC-000001 · ubicación/alias
- DEV-000001 · dispositivo observado
- NET-000001 · snapshot de red
- CONV-000001 · contexto de conversación local
- CYC-000001 · ciclo
- EVT-000001 · evento

No incrustar IP, nombre, dirección, hostname, MAC o serial en identificadores. La etiqueta humana nunca reemplaza UUIDv7; no reutilizar folios FOL1 ni IDs nativos de plataforma.

### Metadatos de sesión

Registrar ID de sesión/workspace/ubicación/dispositivo/red, inicio y final UTC, zona IANA/offset, duración monotónica, fuente/precisión de reloj, renovación/heartbeat, finalización, motivo y estado de cierre. Contexto de ubicación: alias LOC, GPS cuando API del SO lo permita sin ralentizar, IP pública/local, IPv4/IPv6, operador/ASN y geolocalización IP aproximada con fuente/precisión. Los datos no disponibles quedan explícitamente marcados, nunca estimados.

### Inventario robusto del dispositivo

Integrar los resultados EP de SO/build/arquitectura, CPU/GPU familia, RAM, fabricante/modelo, almacenamiento HDD/SSD/UNKNOWN, modelo/bus/capacidad/volúmenes/sistema de archivos/espacio libre, cifrado observable, suspensión/hibernación, permisos/elevación, red/conectividad y versiones de OCP/EP/RDC. Inventario al inicio y al cambiar contexto relevante, no polling costoso. Identificadores de hardware destinados a correlación persistente se seudonimizan con HMAC/rotación; evitar almacenar seriales en claro cuando no sean necesarios. IP/GPS y metadatos identificables se cifran en reposo y al respaldar.

La captura GPS se intenta por interfaces soportadas; si no hay permiso o dispositivo, registrar DENIED/UNAVAILABLE/ERROR con fuente y motivo. No evadir controles del sistema operativo. El operador declara autorización para inspeccionar los equipos donde opera y México como única jurisdicción de operación; esta declaración no elimina avisos/consentimientos u obligaciones legales que resulten aplicables.

### Eventos y correlación

El esquema de evento debe llevar event_id, schema_version, event_type, occurred_at_utc, session_id, workspace_id y referencias opcionales location_id, device_id, network_snapshot_id, conversation_id, cycle_id. Familias iniciales: session.started, session.heartbeat, session.lease.renewed, session.idle.warning, session.locked, session.ended, session.deadman.triggered, session.persistence.checkpoint, session.workspace.restored, session.cleanup.completed, session.device.inventory.completed, session.network.observed, conversation.linked, cycle.started, cycle.completed y cycle.not_measured.

Correlacionar GOV-TASK-013 (cycle.duration_ms) y la métrica ya delimitada ipz.resolve.rdc.duration_ms sin redefinir límites, añadir KPIs de desempeño no aprobados o retrasar la entrega. La escritura del evento es posterior a la medición y fuera de la ruta crítica.

### Conversaciones y retención

Todo el contenido de conversaciones y adjuntos queda dentro del workspace cifrado y se incluye en snapshots cifrados. Los eventos y registros de telemetría contienen IDs/metadatos, no copias en texto claro del diálogo. Metadatos sensibles se cifran también. Retención solicitada: indefinida para información útil cifrada, sin expiración automática introducida por este sprint, sujeta a deberes legales y derechos de titulares.

La referencia legal de implementación para México es la LFPDPPP publicada el 20-03-2025, texto vigente con última reforma DOF 14-11-2025. El tratamiento debe documentar finalidad, proporcionalidad, aviso, consentimiento cuando corresponda, seguridad, confidencialidad y mecanismo de atención de derechos; no interpretar la autorización de inspección del equipo como exención general de protección de datos. Fuente oficial: https://www.diputados.gob.mx/LeyesBiblio/pdf/LFPDPPP.pdf.

### Criterios de aceptación

1. Inicio/fin de sesión con UUIDv7 + etiqueta secuencial, UTC y duración monotónica.
2. Ubicación/dispositivo/red vinculados con fuente, precisión y estados de disponibilidad; GPS y IP no bloquean apertura.
3. Lease/heartbeat/trigger y eventos de persistencia/restore/cleanup correlacionados.
4. Dos sesiones excepcionales no comparten claves, IDs de sesión, workspace montado ni lease.
5. Contenido conversacional permanece cifrado; tests demuestran que no se filtra en JSONL, logs, manifests ni eventos.
6. Telemetría cifrada y retenida según política; read-back íntegro.
7. GOV-TASK-013 cycle.duration_ms e ipz.resolve.rdc.duration_ms conservan su semántica y medición monotónica, sin espera de red/persistencia antes de la respuesta.

**Responsabilidad:** MCP-OCP-15 implementa schema/store; EP-TASK-007 captura inventario/ubicación/lease; Gobernanza 2 mantiene GOV-TASK-013 y correlación de medición. Gobernanza 1 conserva la coordinación y aceptación interfrente según control vigente.


## Reporte individual obligatorio de resolución/cierre
Al resolver, completar, bloquear o cancelar esta tarea, registrar su propio informe en este README usando [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md). Explicar objetivo y resultado, cómo se solucionó, decisiones verificables, cambios/rutas/commits/blobs/SHA, criterios y pruebas ejecutadas con logs/artefactos, read-back, bloqueantes/dependencias, preocupaciones/riesgos, pendientes, rollback y aceptación. Declarar NINGUNO_VERIFICADO o NO_VERIFICADO donde corresponda; nunca ocultar campos. No marcar completada sin criterios PASS, evidencia y read-back. Actualizar el índice padre después de verificar este informe y entregar al operador el enlace individual y síntesis de solución, evidencia, bloqueantes y preocupaciones. No incluir secretos ni datos sensibles.
