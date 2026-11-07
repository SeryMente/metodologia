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

