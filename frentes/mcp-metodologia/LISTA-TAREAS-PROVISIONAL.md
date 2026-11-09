<!-- LIST_VERSION=0.7; LIST_STATUS=PROVISIONAL; NOT_A_CANONICAL_OBJECT=true -->
# Lista provisional de tareas · MCP-OCP

> **ESTADO: PROVISIONAL · NO ES UN OCP NI UN CONTROL ADICIONAL.** Esta lista es una vista auxiliar enlazada desde el único núcleo MCP-OCP. El estado vivo y las decisiones de alcance permanecen en `MCP-METODOLOGIA.md`; la titularidad permanece exclusivamente en `CONTROL-RESPONSABILIDAD.json`. Las tareas y dependencias de otros frentes se enlazan sin apropiarse de sus objetos, controles o permisos.

- **Frente:** MCP-OCP.
- **Repositorio propietario:** `SeryMente/metodologia`.
- **Ruta OCP:** `frentes/mcp-metodologia/`.
- **Versión de la lista:** 0.7 (provisional; consolidación del sprint Sink + panel local en tres frentes).
- **Última actualización:** 2026-11-09.
- **Gobierno leído:** Samantha v386 · NX-386m; Metacanon 1.29; GOW 2.18; DUG commit `82843bca9493a522405d840393c229d2af363342`; blob `22dca684830a36dff019b47811d9b800cc9bea0a`. §ARR y P037 revisados; CNP P001/P004/P005/P038/P043 considerado.
- **Núcleo enlazado:** [MCP-OCP · objeto canónico](MCP-METODOLOGIA.md), v0.1.26; esta lista v0.7 es su backlog auxiliar vigente.
- **Control:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). Las generaciones y sesiones son metadatos de auditoría y no bloquean trabajo autorizado.
- **MCP-NORMATIVO:** DESACTIVADO.
- **Producto vs. documento:** MCP-OCP-v0.1.26 es la versión documental vigente; la versión de software objetivo es 1.0.0. La candidata ejecutable 0.1.0 y su recibo histórico no constituyen una versión actualizada ni aceptada del producto.
- **Principio de custodia:** no guardar claves, access/refresh tokens, datos privados de usuario, contenido sensible de repositorios ni secretos en esta lista, artefactos, manifests o logs. Utilizar fixtures sintéticos y evidencia minimizada.

## Decisión de alcance operativa vigente

El servidor MCP de Metodología pertenece exclusivamente al frente MCP-OCP y a su repositorio propietario. **No forma parte del servidor ni del producto Khora.** Su misión es ofrecer herramientas locales para leer fuentes canónicas, inspeccionar repositorios y apoyar desarrollo/gobernanza de OCP sometidos a la Metodología.

- **MCP-OCP local:** proceso local controlado por el operador, preferentemente MCP stdio. No levanta listener de red por defecto; si una capacidad HTTP local resultara imprescindible, deberá quedar limitada a loopback y tener prueba de no exposición LAN/WAN. Sin Vercel público, túneles ni listener de Internet.
- **Khora-MCP:** conserva el servidor de capacidades de la prótesis y la integración de Jules en su único endpoint existente `/api/mcp`. No se duplica ni se traslada a MCP-OCP.
- **Jules:** se consume mediante el puente local RDC/stdio implementado en Khora y autenticado por OAuth 2.1/PKCE. La API key de Jules sigue exclusivamente en Khora Production. MCP-OCP no almacena, recibe ni replica `JULES_API_KEY`, refresh tokens ni access tokens.
- **Relación entre ambos:** ChatGPT/RDC puede operar el cliente MCP-OCP local y, separadamente, el cliente puente de Jules. La coexistencia de ambos clientes y el flujo completo se deben probar; no se presume una conexión nativa de ChatGPT Free a un servidor stdio local.
- **EP:** el paquete debe poder construirse y entregarse antes de que EP concluya B2. La instalación y operación dentro del host EP pertenecen a EP y requieren su preflight/consentimiento. No se instala en EP desde este frente sin autorización operativa del propietario del host.
- **MCP-NORMATIVO y Sink:** `MCP-NORMATIVO` permanece DESACTIVADO. Sink local por stdio fue autorizado directamente por el operador; las lecturas individuales devuelven texto solicitado y trazable, pero no infieren metadatos faltantes ni emiten evaluación normativa automática.

## Orden de ejecución · sprint vigente 2026-11-09

La tabla sustituye los PASS/estados de recibos históricos para la implementación Sink actual. Un PASS histórico no equivale a PASS con DUG v386 ni demuestra instalación/perfil/E2E actuales.

| Orden | ID | Prioridad | Tarea | Estado vigente | Condición principal de salida |
|---:|---|---|---|---|---|
| 1 | MCP-OCP-01 | P0 | Contrato de producto y frontera OCP/Khora/Jules | VERIFICADO_EN_NUCLEO_V0.1.26 | Un servidor local MCP-OCP por stdio más panel acompañante de solo lectura; Khora/Jules separados; sin endpoints públicos. |
| 2 | MCP-OCP-02 | P0 | Reconciliar código fuente remoto con main y pins actuales | PENDIENTE_SPRINT | Comparar ramas históricas con main; nueva base desde main; clasificar REUSE/ADAPT/REWRITE/DROP y fijar SDK/RID. |
| 3 | MCP-OCP-05 | P0 | Fuentes, GOW:ARR, DUG, Sink y proyección de observabilidad | PENDIENTE_IMPLEMENTACION | Implementar ARR/DUG/SINK P001–P043, lotes ordenados y estado/eventos locales saneados para el panel. |
| 4 | MCP-OCP-13 | P0 | Panel local de observabilidad visual | ESPECIFICADO · IMPLEMENTACIÓN_PENDIENTE | Abrir en sesión EP ACTIVE; mostrar proceso, protocolo, fuentes, operador, root, actividad y errores; cerrar con sesión EP. |
| 5 | MCP-OCP-03 | P0 | Build y suite renovada de servidor + panel | PENDIENTE_BUILD_ACTUAL | Build limpio; suites MCP y panel PASS; pruebas de readiness, eventos, cierre, integridad, ACL y no exposición. |
| 6 | MCP-OCP-04 | P0 | Transporte MCP STDIO y recorrido RDC | HISTORICAL_SMOKE_ONLY · E2E_ACTUAL_PENDIENTE | Recorrido real initialize/tools/list/tools/call; panel observa sin interponerse; shutdown y reinicio; sin listener. |
| 7 | MCP-OCP-10 | P1 | Pins, manifiesto y evidencia | PENDIENTE_EVIDENCIA_ACTUAL | Manifest incluye servidor, panel, schema de observabilidad, fuentes, SDK/RID, pruebas y hashes. |
| 8 | MCP-OCP-07 | P1 | Paquete y runbook actuales | PAQUETE_HISTORICO_NO_RECUPERABLE | ZIP nuevo con servidor+panel, configuración de ejemplo, extracción/read-back y manifest/SHA. |
| 9 | MCP-OCP-12 | P1 | Bootstrap del perfil local | PENDIENTE_HOST_Y_CONSENTIMIENTO_LOCAL | Instalar servidor y panel en `instalacion-local/`; root protegido externo; importación y REGISTER interactivo. |
| 10 | MCP-OCP-08 | P1 | Handoff/instalación EP | PENDIENTE_EP_TASK_003_005 | EP instala y abre el panel solo tras sesión ACTIVE y gates; confirma hash, ruta, ACL, cierre y rollback. |
| — | MCP-OCP-06 / 11 | Fuera | Coexistencia/desarrollo por Jules | PAUSADO_POR_OPERADOR | No es dependencia del MVP local. |
| — | MCP-OCP-09 | Fuera | PPR/restauración portable cross-host | P2_FUERA_DEL_SPRINT | No bloquear release local. |

## Fichas de tareas

### MCP-OCP-01 — Contrato de producto local y frontera OCP/Khora/Jules
**Prioridad:** P0 · **Estado:** VERIFICADO_EN_NUCLEO_V0.1.26 · **Responsable:** MCP-OCP dentro de su autoridad.

**Objetivo:** fijar sin ambigüedad que el servidor de Metodología es un producto propio del OCP, ejecutado localmente y separado de Khora. La palabra «MSP» del propósito original se conserva como dictado histórico; la identidad técnica vigente del frente es MCP-OCP.

**Incluye:** transporte preferente stdio; operación por RDC; ausencia de listener público; herramientas de lectura/desarrollo/gobernanza; relación con Git local/GitHub; protección fail-closed; límites de escritura y consentimiento.

**Excluye:** capacidades de dictados/audio/MP3/grafo de Khora; servidor Jules duplicado; API key de Jules o secretos de Khora; endpoint público/Vercel; activación de MCP-NORMATIVO; cambios DUG/Sink.

**Cierre:** núcleo v0.1.26, esta lista v0.7 y README reflejan la misma frontera; la especificación del panel identifica su separación como app acompañante read-only, sin segundo MCP ni red. La revisión documental de contrato está verificada; las pruebas de implementación permanecen pendientes.

### MCP-OCP-02 — Reconciliación de código ejecutable contra main
**Prioridad:** P0 · **Estado:** PENDIENTE_SPRINT.

**Objetivo:** obtener una rama de trabajo limpia cuyo padre sea el HEAD vigente de main; conservar solo componentes históricos que pasen revisión contra el núcleo y los contratos actuales. Las ramas candidatas históricas son referencias de lectura, no bases de merge.

**Trabajo:** verificar ramas/commits; comparar estructura y contratos; clasificar por componente REUSE / ADAPT / REWRITE / DROP; portar selectivamente el código a rama nueva; fijar .NET/SDK/RID compatible y reproducible; revisar dependencias, licencias y secretos.

**Salida de cierre:** rama candidata desde main con base documentada; mapa de portabilidad; diff acotado; build inicial sin secretos; pruebas históricas clasificadas como antecedentes, nunca como PASS de 1.0.0.
### MCP-OCP-03 — Calidad, pruebas y build de release (servidor + panel)
**Prioridad:** P0 · **Estado:** PENDIENTE.

**Objetivo:** demostrar el comportamiento del producto nuevo con pruebas repetibles, no solo compilarlo.

**Pruebas mínimas:** build limpio; unitarias y contrato; initialize/tools/list/tools/call; health/readiness; ARR/DUG/catálogo; Sink individual y lote ordenado; hash correcto; entradas inválidas; fuente ausente/obsoleta/alterada; traversal/ACL; logs sin secretos; shutdown/restart; ausencia de listeners no autorizados. Reutilizar harness existente cuando siga válido y ampliar solo lo necesario. Añadir pruebas de schema/reader/writer del panel, estados EP ACTIVE sin servidor, readiness parcial, caída del proceso, ACL/JSON inválidos y ciclo de cierre de UI.

**Salida:** recibo ligado al commit de código y al main base, pins DUG/core, SDK/RID, comandos, conteos, PASS/FAIL, limitaciones y hashes. Release solo cuando suite y paquete pasen; no convertir resultados de candidata antigua en evidencia nueva.
### MCP-OCP-04 — Transporte MCP STDIO y recorrido RDC
**Prioridad:** P0 · **Estado:** PENDIENTE.

**Objetivo:** verificar el canal que se utilizará realmente en el perfil final.

**Trabajo:** iniciar proceso local mediante cliente MCP/RDC autorizado; comprobar initialize, tools/list, tools/call/respuesta completa, cancelación/cierre, EOF y reinicio. Verificar stdin/stdout reservados al protocolo, logs únicamente saneados en stderr/archivo protegido, permisos mínimos y que no se crea listener HTTP/TCP, túnel o endpoint público.

**Salida:** recibo de smoke real del ejecutable de release y configuración del cliente, con ruta de binario y evidencia del perímetro. El smoke temporal histórico no cuenta como E2E instalada. El panel recibe la proyección por archivos locales y no se interpone en stdin/stdout.
### MCP-OCP-05 — Fuentes canónicas, herramientas de lectura, Sink y estado observable
**Prioridad:** P0 · **Estado:** PENDIENTE_IMPLEMENTACION.

**Objetivo:** construir el conjunto mínimo de herramientas de lectura necesarias para MCP-OCP 1.0.0.

**Alcance funcional:** diagnóstico que diferencie proceso activo de readiness; importación/validación de fuentes; recuperación GOW:ARR; identidad y procedencia DUG (versión, firma, commit, blob SHA, SHA-256, adquisición y estado); catálogo 43 MDP; SINK:P001..P043 individual; lote de IDs que respete orden; lectura acotada de documentos/OCP bajo allowlist de repositorio/rutas. No crear herramientas MCP de escritura en 1.0.0 salvo necesidad expresa posterior.

**Integridad:** respuesta individual con ID/título/pin exacto/hash de texto. Evento de frecuencia solo por recuperación íntegra satisfactoria. Hash de lote sobre serialización UTF-8 canónica de IDs ordenados, pins y hashes individuales. Fuente desactualizada, ausente, alterada, no importada, parámetro inválido o ruta fuera de allowlist ⇒ rechazo explícito; nunca fallback a memoria o MDP.

**Salida:** operaciones/schemas implementados, ejemplos de respuesta y pruebas de contrato. Metadatos de aplicabilidad ausentes no se infieren; MCP-NORMATIVO queda DESACTIVADO.
### MCP-OCP-06 — Coexistencia con Jules por puente RDC independiente
**Prioridad:** P0 · **Estado:** PENDIENTE · **Dependencia:** MCP-Jules y Khora-MCP.

La coexistencia debe ser dos clientes/canales locales claramente separados: servidor MCP-OCP por stdio y puente Jules por stdio/RDC hacia Khora `/api/mcp`. El primer test autenticado de Jules es solo lectura (tools/list, fuentes, sesiones/actividades); no crea sesiones. No se supone que un proceso MCP stdio sea automáticamente visible para ChatGPT; se documenta el mecanismo efectivo de invocación a través de RDC.

### MCP-OCP-07 — Paquete reproducible MCP-OCP 1.0.0
**Prioridad:** P1 · **Estado:** PENDIENTE.

**Objetivo:** generar un paquete local autosuficiente, reconstruible desde GitHub y fácil de instalar.

**Contenido:** ejecutable MCP, panel Windows, recursos/dependencias necesarias, launcher de sesión, configuración de ejemplo sin secretos, schema de observabilidad, manifiesto de archivos, SHA-256, instrucciones de extracción/ejecución y runbook. Elegir publish mode/RID después del baseline, no por suposición.

**Salida:** paquete nuevo disponible desde la ruta de entrega MCP-OCP; tamaño, RID, build commit, source commit, pins DUG/core y SHA-256. Extraer en root de prueba, cotejar archivos y repetir smoke. Esta tarea entrega paquete; no declara instalada la copia en checkout ni en EP.
### MCP-OCP-08 — Handoff de paquete a EP y recepción de instalación
**Prioridad:** P1 · **Estado:** BLOQUEADO_DEPENDENCIA_EP.

**Objetivo:** entregar paquete/runbook e información suficiente para que EP realice la instalación en el perfil designado. MCP-OCP no opera BitLocker, ACL, Registro, procesos persistentes ni root de datos EP.

**Salida MCP:** SHA del paquete, manifest, versión, pins, guía y pruebas; ruta de entrega y recibo de transferencia/read-back. **Recepción EP:** EP-TASK-005 confirma identidad host, ruta instalada, archivos/hash, configuración STDIO/RDC, importación y aceptación. La instalación final queda en frentes/mcp-metodologia/instalacion-local/ dentro del checkout local de Metodología.
### MCP-OCP-09 — Respaldo y recuperación portable
**Prioridad:** P2 · **Estado:** BLOQUEADO_P012_P013_Y_HOST_DESTINO.

La propuesta portable de §8.2 permanece separada del MVP local. No implementar el re-enveloping/cambio de custodia de claves hasta la revisión de seguridad/arquitectura aplicable y presencia requerida; cross-host exige host/perfil autorizado. No bloquear MCP-OCP-02/03/04/07 por esta dependencia.

### MCP-OCP-10 — Pins, manifiesto y evidencia reproducible
**Prioridad:** P1 · **Estado:** PENDIENTE_EVIDENCIA_ACTUAL.

**Objetivo:** hacer que producto, fuentes, build y paquete se puedan auditar sin reconstrucción manual.

**Contenido:** manifest de fuentes (DUG/Metacanon/GOW y revisión importada), commit/blob/SHA-256, schema/protocolo, SDK/RID, commit código/base, versión producto 1.0.0, herramientas expuestas, pruebas, archivos de paquete y limitaciones. Un evento de telemetría Sink cuenta solo recuperación exitosa; latencia RDC se registra aparte vía GOV-TASK-013.

**Salida:** manifest determinista, SHA-256 de manifest/paquete, recibo estructurado y lectura de vuelta. No incluir secretos, texto privado innecesario ni telemetría de aplicación normativa.
### MCP-OCP-11 — Ciclo sandbox mediante Jules
**Prioridad:** P1 · **Estado:** BLOQUEADO_HASTA_CONFIGURAR_MCP_JULES.

Una vez configuradas y aceptadas las tareas del frente MCP-Jules, se prepara una sesión de prueba contra sandbox OCP, no contra producción ni ramas protegidas. Jules debe devolver plan; el operador confirma ese plan específico; solo entonces se permite aprobación. Resultado exigido: PR verificable, pruebas, lectura de vuelta y cierre documental. La creación de sesión no equivale a ejecución ni aceptación.



### MCP-OCP-12 — Materialización local y bootstrap del producto
**Prioridad:** P1 · **Estado:** BLOQUEADO_GATES_EP_Y_CONSENTIMIENTO_LOCAL.

**Objetivo:** instalar la copia local del servidor dentro del checkout de Metodología y preparar la instancia real de usuario.

**Ruta obligatoria del programa:** checkout SeryMente/Repositorios/Metodologia/metodologia/; ejecutable/runtime en frentes/mcp-metodologia/instalacion-local/. No instalar el programa únicamente en LocalAppData. Añadir exclusión Git; binarios/configuración instalada no se versionan.

**Datos separados:** DB SQLite, claves DPAPI CurrentUser, fuentes sensibles, logs y backups van a root independiente protegido, fuera del checkout y verificado por EP. No usar LocalAppData sin demostrar protección efectiva.

**Secuencia:** paquete verificado → checkout completo/sincronizado → extracción en ruta obligatoria → root de datos protegido → import-sources con pins actuales → health/readiness real → consentimiento local y presencia para provision-operator/REGISTER <SID> → cliente STDIO/RDC → read-back. La carpeta instalada incluye el panel en `panel/OcpMcp.Panel.exe`; la apertura durante EP ACTIVE se delega a EP-TASK-005 y solo ocurre después de sus gates. No sustituye EP-TASK-003/005 ni puede pasar por encima de sus gates.

**Salida:** recibo host/perfil, ruta local, versión, commit/blob, SHA instalado, estado importación, readiness y bootstrap. Sin consentimiento, reportar pendiente; no simular registro.

### MCP-OCP-13 — Panel local de observabilidad visual
**Prioridad:** P0 · **Estado:** ESPECIFICADO · IMPLEMENTACIÓN PENDIENTE · **Autoridad:** MCP-OCP para la app; EP para el ciclo de vida de sesión.

**Objetivo:** entregar una ventana Windows liviana, profesional y muy visual que esté abierta mientras la sesión EP persistente esté en estado `ACTIVE`, permitiendo entender en segundos el estado real de MCP-OCP.

**Contrato detallado:** [PANEL-OBSERVABILIDAD.md](PANEL-OBSERVABILIDAD.md).

**Implementación delimitada:** app WPF/C# separada del proceso MCP, proyecto pequeño en la solución .NET, controles nativos y gráficos vectoriales; fijar target framework con el SDK/RID que resulte del MCP-OCP-02. Lee de forma read-only `monitor/state.json` y `monitor/events.jsonl` en el root protegido. EP publica y coteja `monitor/session.json` antes de abrir la UI; el servidor publica `monitor/state.json` y `monitor/events.jsonl`. La UI combina las tres fuentes con lectura de solo lectura. Muestra estado global, etapa EP/proceso/STDIO/fuentes/readiness, tarjetas de salud, operación actual, actividad reciente y un único siguiente paso cuando hay bloqueo. La protección del volumen se etiqueta con el timestamp de la última comprobación EP, sin sondeo de BitLocker.

**Ciclo de vida:** EP-TASK-005 abre el panel visible como hijo de la sesión al confirmar `ACTIVE`, incluso si el servidor todavía no inició; X/Alt+F4 lo minimiza a la barra de tareas mientras EP siga activa, y solo el cierre de EP termina el panel. Si MCP cae mientras EP sigue activa, el panel permanece abierto mostrando desconexión. EP-TASK-003 y su dead-man no se modifican.

**Exclusiones:** no es un servidor/cliente MCP, no intercepta STDIO, no abre red/HTTP, no tiene herramientas de escritura ni autoriza acciones, no incorpora servicios/tareas programadas/heartbeat general, no registra payloads/secretos/contenido privado y no requiere MCP Studio/Inspector en producción.

**Cierre:** build Windows x64; launch/close real desde EP ACTIVE; estados diferenciados de proceso/protocolo/fuentes/operador/root; actividad con ID, resultado y duración sin contenido; caída del servidor y cierre de EP probados; schema/ACL resistentes; manifest/SHA incluido en el ZIP 1.0.0 y read-back de extracción.

## Dependencias entre frentes y límite de autonomía

| Dependencia | Fuente de verdad | MCP-OCP puede | MCP-OCP no puede |
|---|---|---|---|
| Herramientas y cliente Jules | OCP MCP-Jules en Metodología + servidor Khora en SeryMente/khora | Definir contrato de consumo y solicitar evidencia | Modificar código Khora, credenciales, ACL o control Khora |
| Titularidad y tareas Jules | OCP y control propios de MCP-Jules | Modificar provisionalmente tareas/plan/aceptación bajo autorización puntual del operador, dejando trazabilidad | Transferir titularidad, reescribir su control o fusionar PR documental sin gate |
| Host/instalación EP | OEP y control EP | Entregar paquete y handoff | Operar host, instalar servicios, cambiar ACL o configuración |
| Gobernanza global | DUG, Metacanon, GOW y OCP de Gobernanza | Consultar y enlazar | Cambiar reglas, activar MCP-NORMATIVO o asumir GOV-TASK |
| Persistencia B2 | OEP y control EP | Definir contrato de cliente cuando se autorice | Leer secretos, hacer upload/restore o abrir permisos |

## Política de actualización de esta lista

- Cada tarea cambia de estado solo con fuente, revisión, commit/blob/SHA, prueba y lectura de vuelta cuando corresponda.
- El estado `PENDIENTE`, `BLOQUEADO` o `EN CURSO` no se convierte en PASS por tener código o plan escrito.
- Las tareas de MCP-OCP son auxiliares a un solo OCP. El registro DTC continúa en el objeto de coordinación existente.
- Los IDs no se reciclan ni se eliminan: se archiva el antecedente si una tarea se retira.
- Esta lista se revisa al inicio/cierre de cada ciclo y permanece PROVISIONAL hasta que el núcleo y la aceptación del producto reflejen los resultados comprobados.


## Alineación vigente · 2026-11-09

DUG vigente: Samantha v386 · NX-386m; main base `82843bca9493a522405d840393c229d2af363342`; blob `22dca684830a36dff019b47811d9b800cc9bea0a`. El operador autorizó directamente Sink local por stdio, pruebas, build, paquete, manifiesto y documentación dentro de este OCP. No se necesita aprobación del titular anterior ni generación de control. GitHub privado se consulta mediante el conector autenticado; `gh auth login` local no es requisito. La instalación persistente EP y sus operaciones de custodia permanecen separadas. MCP-NORMATIVO sigue DESACTIVADO.


## Reconciliación de ejecución · 2026-11-09 · DUG v386

- **Autorización Sink:** directa del operador y registrada en CONTROL-RESPONSABILIDAD.json; ningún titular anterior, generación ni folio es compuerta.
- **Fuente candidata:** hay código C# recuperable en ramas remotas de GitHub; no está integrado en main. El código de esas ramas es base histórica para port/revisión, no release.
- **Estado de implementación:** el código candidato ofrece SourceImporter y PrincipleCatalog para IDs/MDP; Sink de texto individual no está desplegado en main. PrincipleCatalog reconoce 43 IDs/MDP pero deja metadata applicability/activation/dependencies incompleta; no inferirla.
- **Root de datos:** Program.cs usa `%LOCALAPPDATA%\\SeryMente\\OCP MCP` por defecto. Antes del handoff se debe configurar un root de datos/backup dentro del volumen cifrado o demostrar que el volumen del perfil está protegido.
- **Autenticación:** el conector GitHub de ChatGPT está autenticado para operaciones de repositorio desde esta conversación. La autenticación GitHub local del perfil Windows no se hereda; se valida por separado si build/import local lo necesita.
- **Dependencias EP:** EP-TASK-003 para workspace protegido y dead-man si LOC-OTHER; EP-TASK-005 para instalación/aceptación. EP-TASK-004 no bloquea compilar Sink ni el trust root DPAPI del servidor.


## Destino EP designado · 2026-11-09

El operador designó el perfil/usuario Windows `PC 7`, asociado a un dispositivo RDC, con ubicación `LOC-OTHER`. Esta designación sustituye la selección pendiente del host/perfil. El hostname/ID técnico del dispositivo, sesión, usuario/SID efectivos, rutas, permisos y almacenamiento deberán verificarse en vivo por EP.

Para MCP-OCP, este dato **no bloquea** reconciliar fuentes, implementar Sink, ejecutar pruebas ni generar el paquete. Sí bloquea handoff/bootstrap e instalación persistente hasta que EP complete EP-TASK-003: workspace/DB/runtime/respaldos protegidos y dead-man LOC-OTHER implementado, probado y leído de vuelta en el destino. El estado de cifrado observado previamente en otro perfil no se hereda.


## Contrato de release 1.0.0 e instalación local dentro de Metodología · 2026-11-09

**Objetivo de producto:** MCP-OCP 1.0.0 funcional, reconstruible e instalado en checkout local. La versión de este backlog es 0.6; la versión documental del núcleo es 0.1.25; no son el número del producto.

**Instalación obligatoria:** checkout `SeryMente/Repositorios/Metodologia/metodologia/`, carpeta `frentes/mcp-metodologia/instalacion-local/`. Instalar allí binario, runtime, launcher, configuración de ejemplo y manifiesto. La carpeta generada se excluye de Git y no contiene datos sensibles. SQLite, claves DPAPI, fuentes sensibles, logs y backups quedan fuera del checkout en root protegido que EP verifica.

**Criterios de 1.0.0:** diagnóstico real, GOW:ARR, DUG/pins, catálogo 43, Sink individual y batch ordenado, hash individual y global, lectura documental OCP bajo allowlist, rechazos fail-closed, protocolo MCP STDIO, shutdown limpio y no exposición de red. Pruebas automatizadas y E2E en la ruta instalada, recibo de build, paquete y SHA-256, extracción/read-back, runbook y reconstrucción desde GitHub.

**Ejecutable vs. instalación:** MCP-OCP entrega código, build y paquete; MCP-OCP-12 materializa la copia en la ruta local y ejecuta bootstrap solo tras gates; MCP-OCP-08/EP-TASK-005 acepta host e instalación EP. No declarar 1.0.0 aceptado con solo build o smoke de root temporal.

**Secuencia crítica:** 02 → 05 vertical → 03/04 pruebas/STDIO → 05 generalización 43 → 10 manifiesto → 07 paquete → 12 instalación local/bootstrapping → 08 handoff EP → GOV-003 E2E. GOV-001/008/009 definen/ejecutan validación en paralelo. EP-003 resuelve checkout y dead-man en paralelo; EP-005 instala después del paquete verificado.

**Gates bloqueantes únicamente del tramo instalado:** checkout PC 7 íntegro y sincronizado; protección BitLocker realmente activa; dead-man LOC-OTHER probado; root de datos fuera de checkout y protegido; consentimiento del operador para `REGISTER <SID>`. Estos gates no detienen reconciliación, código, pruebas y paquete desde GitHub.

`MCP-NORMATIVO=DESACTIVADO`; no modificar DUG/IPZ, Khora, secretos ni servicios externos. El código no añade herramientas MCP de escritura en este release.
