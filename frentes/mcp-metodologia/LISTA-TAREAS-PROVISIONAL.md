<!-- LIST_VERSION=0.9; LIST_STATUS=PROVISIONAL; NOT_A_CANONICAL_OBJECT=true -->
# Lista provisional de tareas · MCP-OCP

> **ESTADO: PROVISIONAL · NO ES UN OCP NI UN CONTROL ADICIONAL.** Esta lista es una vista auxiliar enlazada desde el único núcleo MCP-OCP. El estado vivo y las decisiones de alcance permanecen en `MCP-METODOLOGIA.md`; la titularidad permanece exclusivamente en `CONTROL-RESPONSABILIDAD.json`. Las tareas y dependencias de otros frentes se enlazan sin apropiarse de sus objetos, controles o permisos.

- **Frente:** MCP-OCP.
- **Repositorio propietario:** `SeryMente/metodologia`.
- **Ruta OCP:** `frentes/mcp-metodologia/`.
- **Versión de la lista:** 0.9 (provisional; consolidación del sprint Sink + panel local en tres frentes).
- **Última actualización:** 2026-11-10.
- **Gobierno leído:** Samantha v388 · NX-388m; Metacanon 1.29; GOW 2.18; DUG commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. ART-027 rebaselined para Sink local STDIO/RDC; §ARR y P037 revisados; CNP P001/P004/P005/P038/P043 considerado.
- **Núcleo enlazado:** [MCP-OCP · objeto canónico](MCP-METODOLOGIA.md), v0.1.28; esta lista v0.9 es su backlog auxiliar vigente.
- **Control:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). Las generaciones y sesiones son metadatos de auditoría y no bloquean trabajo autorizado.
- **MCP-NORMATIVO:** DESACTIVADO.
- **Producto vs. documento:** MCP-OCP-v0.1.28 es la versión documental vigente; la versión de software objetivo es 1.0.0. La candidata ejecutable 0.1.0 y su recibo histórico no constituyen una versión actualizada ni aceptada del producto.
- **Principio de custodia:** no guardar claves, access/refresh tokens, datos privados de usuario, contenido sensible de repositorios ni secretos en esta lista, artefactos, manifests o logs. Utilizar fixtures sintéticos y evidencia minimizada.

## Decisión de alcance operativa vigente

El servidor MCP de Metodología pertenece exclusivamente al frente MCP-OCP y a su repositorio propietario. **No forma parte del servidor ni del producto Khora.** Su misión es ofrecer herramientas locales para leer fuentes canónicas, inspeccionar repositorios y apoyar desarrollo/gobernanza de OCP sometidos a la Metodología.

- **MCP-OCP local:** proceso local controlado por el operador, preferentemente MCP stdio. No levanta listener de red por defecto; si una capacidad HTTP local resultara imprescindible, deberá quedar limitada a loopback y tener prueba de no exposición LAN/WAN. Sin Vercel público, túneles ni listener de Internet.
- **Khora-MCP:** conserva el servidor de capacidades de la prótesis y la integración de Jules en su único endpoint existente `/api/mcp`. No se duplica ni se traslada a MCP-OCP.
- **Jules:** se consume mediante el puente local RDC/stdio implementado en Khora y autenticado por OAuth 2.1/PKCE. La API key de Jules sigue exclusivamente en Khora Production. MCP-OCP no almacena, recibe ni replica `JULES_API_KEY`, refresh tokens ni access tokens.
- **Relación entre ambos:** ChatGPT/RDC puede operar el cliente MCP-OCP local y, separadamente, el cliente puente de Jules. La coexistencia de ambos clientes y el flujo completo se deben probar; no se presume una conexión nativa de ChatGPT Free a un servidor stdio local.
- **EP:** el paquete debe poder construirse y entregarse antes de que EP concluya B2. La instalación y operación dentro del host EP pertenecen a EP y requieren su preflight/consentimiento. No se instala en EP desde este frente sin autorización operativa del propietario del host.
- **MCP-NORMATIVO y Sink:** `MCP-NORMATIVO` permanece DESACTIVADO. Sink local por stdio fue autorizado directamente por el operador; las lecturas individuales devuelven texto solicitado y trazable, pero no infieren metadatos faltantes ni emiten evaluación normativa automática.

## Orden de ejecución · sprint vigente 2026-11-10

La tabla sustituye los PASS/estados de recibos históricos para la implementación Sink actual. Un PASS histórico no equivale a PASS con DUG v388 ni demuestra instalación/perfil/E2E actuales.

| Orden | ID | Prioridad | Tarea | Estado vigente | Condición principal de salida |
|---:|---|---|---|---|---|
| 1 | MCP-OCP-01 | P0 | Contrato de producto y frontera OCP/Khora/Jules | VERIFICADO_EN_NUCLEO_V0.1.27 | Un servidor local STDIO; panel acompañante read-only en el producto final; dominios separados. |
| 2 | MCP-OCP-02 | P0 · CRÍTICO | Rama limpia y reconciliación selectiva desde main | EJECUTADO · VERIFICADO POR READ-BACK | `feat/mcp-ocp-p004-rebaseline-20261110-cycle02`, base `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd`; pin v388, inventario REUSE/ADAPT/REWRITE/DROP, SDK 10.0.403 y RID final win-x64 registrados. Build/pruebas aún pendientes. |
| 3 | MCP-OCP-05 | P0 · SIGUIENTE | Corte vertical GOW:ARR → DUG → SINK:P004 | IMPLEMENTACIÓN CANDIDATA · NO COMPILADA | Servidor/lector/pin P004 escritos; respuesta, blob y SHA-256 implementados en código; requiere build, pruebas y smoke con evidencia CI. |
| 4 | MCP-OCP-03 | P0 | Suite mínima de contrato del piloto P004 | ESCRITAS · 18 ESCENARIOS / 0 EJECUTADOS | Fixtures sintéticos positivos/negativos, negociación, P004, pins, hashes, errores, telemetría y EOF; ejecución pendiente de runner .NET con logs. |
| 5 | MCP-OCP-04 | P0 | Transporte y E2E IPZ → RDC → STDIO para P004 | HARNESS/CI ACTUALIZADOS · SIN SMOKE VERIFICADO | CI incluye build servidor, 18 tests P004, 23 tests de monitor/readiness, build WPF y smoke STDIO; run CI falla sin steps/logs/artifacts, por lo que ninguna etapa está acreditada. E2E IPZ espera gates EP. |
| 6 | MCP-OCP-05 (fase posterior) / 03 | P0 | Generalización Sink P001–P043 y lotes | PENDIENTE_POST_PILOTO | 43 respuestas, orden, hashes/eventos y controles negativos PASS. |
| 7 | MCP-OCP-13 | P1 | Panel local de observabilidad visual | IMPLEMENTACIÓN CANDIDATA · 23 TESTS ESCRITOS / 0 EJECUTADOS | WPF + reader/writer/evaluator de monitorización y 23 pruebas sintéticas publicados; `READY` exige atestación EP `Protection On` además de proceso/protocolo/fuentes/operador/root. Build, pruebas, revisión visual Windows e integración de ciclo EP pendientes. Obligatorio para 1.0.0; no bloquea P004. |
| 8 | MCP-OCP-10 | P1 | Pins, manifiesto y evidencia final | PIN/METADATOS DE BUILD FIJADOS · RECIBO PENDIENTE | DUG v388/NX-388m, commit/blob, SDK 10.0.403, dependencias externas 0, piloto sin RID y release win-x64 self-contained; faltan hashes finales y recibo. |
| 9 | MCP-OCP-07 | P1 | Paquete reproducible 1.0.0 | PENDIENTE_PAQUETE_ACTUAL | ZIP final servidor+panel, configuración, manifest/SHA y read-back. |
| 10 | MCP-OCP-12 | P1 | Bootstrap local en Fila 4 | BLOQUEADO_GATES_EP | Piloto/instalación dentro de checkout; datos externos protegidos; REGISTER interactivo. |
| 11 | MCP-OCP-08 | P1 | Handoff y aceptación EP | PENDIENTE_EP_TASK_003_005 | Verificación de ruta, root, panel EP ACTIVE, hashes, cierre y rollback. |
| — | MCP-OCP-06 / 11 | Fuera | Coexistencia/desarrollo por Jules | PAUSADO_POR_OPERADOR | No es dependencia del MVP local. |
| — | MCP-OCP-09 | Fuera | PPR/restauración portable cross-host | P2_FUERA_DEL_SPRINT | No bloquear release local. |

## Fichas de tareas

### MCP-OCP-01 — Contrato de producto local y frontera OCP/Khora/Jules
**Prioridad:** P0 · **Estado:** VERIFICADO_EN_NUCLEO_V0.1.26 · **Responsable:** MCP-OCP dentro de su autoridad.

**Objetivo:** fijar sin ambigüedad que el servidor de Metodología es un producto propio del OCP, ejecutado localmente y separado de Khora. La palabra «MSP» del propósito original se conserva como dictado histórico; la identidad técnica vigente del frente es MCP-OCP.

**Incluye:** transporte preferente stdio; operación por RDC; ausencia de listener público; herramientas de lectura/desarrollo/gobernanza; relación con Git local/GitHub; protección fail-closed; límites de escritura y consentimiento.

**Excluye:** capacidades de dictados/audio/MP3/grafo de Khora; servidor Jules duplicado; API key de Jules o secretos de Khora; endpoint público/Vercel; activación de MCP-NORMATIVO; cambios DUG/Sink.

**Cierre:** núcleo v0.1.27, esta lista v0.8 y README reflejan la misma frontera; la especificación del panel identifica su separación como app acompañante read-only, sin segundo MCP ni red. La revisión documental de contrato está verificada; las pruebas de implementación permanecen pendientes.

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

**Alcance funcional en dos fases:** **Fase A (primero):** diagnóstico mínimo, importación/validación, GOW:ARR, identidad/procedencia DUG y recuperación individual SINK:P004 para habilitar el piloto IPZ. **Fase B (después de verificar el piloto):** catálogo completo 43 MDP, SINK:P001..P043 individual, lotes ordenados, eventos/frecuencia y lectura acotada de documentos/OCP bajo allowlist. No crear herramientas MCP de escritura en 1.0.0.

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

**Objetivo:** instalar primero el piloto SINK:P004/IPZ y, después de su aceptación, el release final servidor+panel dentro del checkout local de Fila 4.

**Ruta obligatoria del programa:** checkout `%USERPROFILE%\\Desktop\\SeryMente\\Repositorios\\Metodologia\\metodologia\\` de Fila 4; piloto en `frentes/mcp-metodologia/instalacion-local/piloto-sink/`; release final en `frentes/mcp-metodologia/instalacion-local/`. No instalar el programa únicamente en LocalAppData. Añadir exclusión Git; binarios/configuración instalada no se versionan.

**Datos separados:** DB SQLite, claves DPAPI CurrentUser, fuentes sensibles, logs y backups van a root independiente protegido, fuera del checkout y verificado por EP. No usar LocalAppData sin demostrar protección efectiva.

**Secuencia:** paquete verificado → checkout completo/sincronizado → extracción en ruta obligatoria → root de datos protegido → import-sources con pins actuales → health/readiness real → consentimiento local y presencia para provision-operator/REGISTER <SID> → cliente STDIO/RDC → read-back. La carpeta instalada incluye el panel en `panel/OcpMcp.Panel.exe`; la apertura durante EP ACTIVE se delega a EP-TASK-005 y solo ocurre después de sus gates. No sustituye EP-TASK-003/005 ni puede pasar por encima de sus gates.

**Salida:** recibo host/perfil, ruta local, versión, commit/blob, SHA instalado, estado importación, readiness y bootstrap. Sin consentimiento, reportar pendiente; no simular registro.

### MCP-OCP-13 — Panel local de observabilidad visual
**Prioridad:** P1 de secuencia · **Estado:** ESPECIFICADO · IMPLEMENTACIÓN PENDIENTE · **Autoridad:** MCP-OCP para la app; EP para el ciclo de vida de sesión.

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


## Alineación de origen · 2026-11-09 · HISTÓRICA, SUPERSIDIDA POR LA RECTIFICACIÓN DEL 2026-11-10

DUG vigente: Samantha v386 · NX-386m; main base `82843bca9493a522405d840393c229d2af363342`; blob `22dca684830a36dff019b47811d9b800cc9bea0a`. El operador autorizó directamente Sink local por stdio, pruebas, build, paquete, manifiesto y documentación dentro de este OCP. No se necesita aprobación del titular anterior ni generación de control. GitHub privado se consulta mediante el conector autenticado; `gh auth login` local no es requisito. La instalación persistente EP y sus operaciones de custodia permanecen separadas. MCP-NORMATIVO sigue DESACTIVADO.


## Reconciliación de ejecución · 2026-11-09 · DUG v386

- **Autorización Sink:** directa del operador y registrada en CONTROL-RESPONSABILIDAD.json; ningún titular anterior, generación ni folio es compuerta.
- **Fuente candidata:** hay código C# recuperable en ramas remotas de GitHub; no está integrado en main. El código de esas ramas es base histórica para port/revisión, no release.
- **Estado de implementación:** el código candidato ofrece SourceImporter y PrincipleCatalog para IDs/MDP; Sink de texto individual no está desplegado en main. PrincipleCatalog reconoce 43 IDs/MDP pero deja metadata applicability/activation/dependencies incompleta; no inferirla.
- **Root de datos:** Program.cs usa `%LOCALAPPDATA%\\SeryMente\\OCP MCP` por defecto. Antes del handoff se debe configurar un root de datos/backup dentro del volumen cifrado o demostrar que el volumen del perfil está protegido.
- **Autenticación:** el conector GitHub de ChatGPT está autenticado para operaciones de repositorio desde esta conversación. La autenticación GitHub local del perfil Windows no se hereda; se valida por separado si build/import local lo necesita.
- **Dependencias EP:** EP-TASK-003 para workspace protegido y dead-man según ubicación física verificada; EP-TASK-005 para piloto, instalación y aceptación. EP-TASK-004 no bloquea compilar Sink ni el trust root DPAPI del servidor.


## Designación inicial de destino EP · 2026-11-09 · SUPERSEDIDA POR FILA 4

La designación original de PC 7/LOC-OTHER quedó supersedida el 2026-11-10 por Fila 4. Se preserva solo como antecedente. El destino vigente, identidad técnica última conocida y ubicación física pendiente se registran en la rectificación de 2026-11-10 al final de este backlog.

Para MCP-OCP, el preflight del destino actual **no bloquea** la reconciliación ni el desarrollo remoto de código no sensible. El uso de fuentes privadas y cualquier instalación/bootstrap sí esperan checkout/root protegidos en Fila 4 y el régimen de protección/dead-man que determine su ubicación física. No heredar estados de otro perfil.


## Contrato de release 1.0.0 e instalación local dentro de Metodología · 2026-11-09

**Objetivo de producto:** MCP-OCP 1.0.0 funcional, reconstruible e instalado en checkout local. La versión de este backlog es 0.8; la versión documental del núcleo es 0.1.27; no son el número del producto.

**Instalación obligatoria:** checkout `SeryMente/Repositorios/Metodologia/metodologia/`, carpeta `frentes/mcp-metodologia/instalacion-local/`. Instalar allí binario, runtime, launcher, configuración de ejemplo y manifiesto. La carpeta generada se excluye de Git y no contiene datos sensibles. SQLite, claves DPAPI, fuentes sensibles, logs y backups quedan fuera del checkout en root protegido que EP verifica.

**Criterios de 1.0.0:** diagnóstico real, GOW:ARR, DUG/pins, catálogo 43, Sink individual y batch ordenado, hash individual y global, lectura documental OCP bajo allowlist, rechazos fail-closed, protocolo MCP STDIO, shutdown limpio y no exposición de red. Pruebas automatizadas y E2E en la ruta instalada, recibo de build, paquete y SHA-256, extracción/read-back, runbook y reconstrucción desde GitHub.

**Ejecutable vs. instalación:** MCP-OCP entrega código, build y paquete; MCP-OCP-12 materializa la copia en la ruta local y ejecuta bootstrap solo tras gates; MCP-OCP-08/EP-TASK-005 acepta host e instalación EP. No declarar 1.0.0 aceptado con solo build o smoke de root temporal.

**Secuencia crítica vigente:** 02 → 05 corte P004 → 03/04 contrato y E2E IPZ/RDC/STDIO del piloto → GOV-007/003 aceptan el uso IPZ → 05 generalización 43 → 13 panel en paralelo (obligatorio para 1.0.0, no bloquea P004) → 10/07 manifest y paquete → 12/08 instalación/handoff → aceptación final. Gobernanza prepara en paralelo; EP prepara Fila 4 sin detener el desarrollo remoto.

**Gates bloqueantes únicamente del tramo local con fuentes y runtime:** checkout Fila 4 íntegro/sincronizado; volumen de trabajo protegido XTS-AES256/Protection On/100 %; root de datos fuera del checkout y protegido; ubicación física verificada y dead-man PASS si está fuera de CECEQ; consentimiento del operador para `REGISTER <SID>`. Estos gates no detienen reconciliación ni desarrollo remoto no sensible.

`MCP-NORMATIVO=DESACTIVADO`; no modificar DUG/IPZ, Khora, secretos ni servicios externos. El código no añade herramientas MCP de escritura en este release.

---

## Rectificación de destino y orden de ejecución · 2026-11-10 · LIST v0.8

**Destino vigente:** Fila 4, por ser la terminal correspondiente a la única sesión RDC disponible indicada por el operador. PC 7 queda supersedido para este sprint y no es fallback. Última identidad técnica documentada: RDC `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`, sesión `CENTRAL\\fila4`, SessionId 4; preflight vivo pendiente. La ubicación física no se infiere: EP debe resolver CECEQ/otra ubicación y el dead-man que corresponda.

**Rutas bajo el perfil interactivo Fila 4:**
- Checkout: `%USERPROFILE%\\Desktop\\SeryMente\\Repositorios\\Metodologia\\metodologia\\`.
- Piloto temprano: `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\piloto-sink\\`.
- Instalación final servidor+panel 1.0.0: `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\`.
- Datos/DB/DPAPI/fuentes/logs/backups: `%USERPROFILE%\\Desktop\\SeryMente\\Datos\\Metodologia\\MCP-OCP\\`, fuera del checkout y de la instalación, dentro del volumen protegido verificado por EP.

### Camino crítico para empezar a usar SINK con IPZ

| Orden | Tarea | Alcance acotado | Gate de salida |
|---:|---|---|---|
| 1 | MCP-OCP-02 | Rama limpia desde main; inventario y port selectivo REUSE/ADAPT/REWRITE/DROP. | Rama y diff revisables; SDK/RID fijados. |
| 2 | MCP-OCP-05 · corte P004 | GOW:ARR + identidad DUG + texto desarrollado SINK:P004 con pin/commit/blob/SHA-256. | Respuesta exacta y fail-closed ante fuente/ID inválidos. |
| 3 | MCP-OCP-03/04 · piloto | Pruebas mínimas de contrato y transporte; initialize/tools/list/tools/call:P004/cierre por RDC/STDIO. | Smoke técnico PASS; luego E2E desde contexto IPZ por la vía real. |
| 4 | GOV-TASK-007 + EP-TASK-005 | Preparar IPZ candidato; preflight Fila 4, checkout/root protegido; materializar piloto separado. | IPZ dentro de 1.500 caracteres; host/root PASS; read-back de paquete. |
| 5 | GOV-TASK-003/007 + MCP-OCP-04 | Validar invocación real IPZ → RDC → STDIO → respuesta visible con pin/hash. | PILOTO_SINK_P004_IPZ=VERIFICADO. El smoke de consola no basta. |
| 6 | MCP-OCP-05/03 | Extender a P001–P043, lote ordenado, hashes/eventos y negativos. | 43 casos y lote íntegro; controles fail-closed PASS. |
| 7 | MCP-OCP-13 | Construir panel WPF liviano sobre schema congelado, en paralelo con la generalización. | Panel integrado y ciclo EP ACTIVE probado. Obligatorio para 1.0.0, no bloquea P004. |
| 8 | MCP-OCP-10/07 | Manifiesto, build reproducible y ZIP final servidor+panel. | SHA, extracción/read-back y smoke del paquete PASS. |
| 9 | MCP-OCP-12/08 + EP-TASK-003/005 | Bootstrap/instalación final dentro del checkout Fila 4 y datos en root protegido. | Preflight, ubicación/dead-man aplicable, consentimiento REGISTER, E2E y rollback PASS. |
| 10 | GOV-TASK-003 | Aceptación integral del producto 1.0.0. | Evidencia E2E y recibos por frente. |

El panel MCP-OCP-13 baja a P1 de secuencia, pero permanece como entregable obligatorio de la versión final 1.0.0. No se espera al panel, a los 43 principios ni a FOL1 para demostrar el primer piloto P004. FOL1 conserva su gate independiente.

### Reglas de ejecución actualizadas

- Desarrollo remoto de código no sensible puede avanzar mientras EP prepara Fila 4.
- No importar DUG/MDP privados, crear DB con fuentes, provisionar operador ni dejar runtime persistente hasta checkout y root de datos protegidos y verificados.
- La última evidencia histórica de Fila 4 informó C: FullyEncrypted/100 %, ProtectionStatus=Off, XtsAes128; debe repetirse en vivo. Git/gh instalados históricamente no prueban autenticación local.
- Si Fila 4 está en CECEQ, aplicar conservación cifrada; si está fuera, EP-TASK-003 implementa y prueba el dead-man antes de runtime persistente. No inferir la ubicación.
- No reutilizar W:, VHDX, RecoveryPassword, DPAPI ni staging de PC-14/PC 7.
- MCP-NORMATIVO permanece DESACTIVADO. MCP Studio no se incorpora. MCP Inspector queda opcional para diagnóstico, fuera del paquete final.

**Estado actual en rama ciclo02:** MCP-OCP-02 ejecutado y verificado por comparación/read-back; candidato P004 y 18 pruebas escritas sin ejecución; CI sin PASS observable; preflight EP de Fila 4 tiene evidencia parcial con resultado FAIL. Importación, instalación, IPZ nativa y E2E siguen pendientes.


## Rebaseline urgente del sprint · 2026-11-10 · DUG v388

**BLOQUEO CRÍTICO P0:** ART-027 se actualizó a Samantha v388/NX-388m. Este backlog y las candidatas históricas aún referían a v386; por tanto, no se debe compilar ni aceptar P004 con ese pin. Baseline de fuente: commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.

**Orden sin ambigüedad:**
1. MCP-OCP-02 (P0/CRÍTICO): rama limpia desde HEAD actual de `main`; reconciliar el núcleo y el código con DUG v388; mapa REUSE/ADAPT/REWRITE/DROP; fijar SDK/RID. No fusionar ramas históricas completas.
2. MCP-OCP-05 (P0): corte `GOW:ARR → DUG → SINK:P004`, con texto íntegro, ID/título, pin, commit/blob y SHA-256; fallar cerrado. El código no sensible puede usar fixtures antes del gate EP.
3. MCP-OCP-03 (P0, paralelo): contrato y negativos con fixtures sintéticos; asociar los resultados al commit de código. Repetir pruebas de fuente real tras importación autorizada.
4. MCP-OCP-04 (P0): preparar harness y smoke STDIO/RDC. El E2E IPZ requiere P004 instalado y respuesta visible en contexto IPZ; JSON-RPC de consola no basta.
5. EP-TASK-003 (P0 para tramo local): preflight vivo de Fila 4, checkout íntegro, volumen XTS-AES256/Protection On/100 %, protector/read-back y root protegido. Ubicación física separada; dead-man solo fuera de CECEQ. Esto bloquea importación privada, DB y runtime persistente, no la rama ni el desarrollo remoto no sensible.
6. EP-TASK-005 + MCP-OCP-12 (P0 para piloto local): tras EP PASS, cotejar paquete piloto/manifest/SHA, extraer en `instalacion-local/piloto-sink/`, configurar root protegido e importar fuentes actuales. `REGISTER <SID>` solo con consentimiento y presencia local.
7. GOV-TASK-007/003: congelar respuesta P004, preparar candidato IPZ compacto y aceptar el recorrido real IPZ → RDC → STDIO → respuesta visible. IPZ nativa/read-back es acto separado. FOL1 no bloquea P004.
8. Tras PASS P004: MCP-OCP-05/03 generalizan P001–P043, lotes, hashes/eventos y negativos; GOV-TASK-001 ejecuta matriz 43+8.
9. Release 1.0.0: MCP-OCP-13 panel obligatorio en paralelo tras schema; MCP-OCP-10/07 manifiesto/build/ZIP; MCP-OCP-12/08 y EP-TASK-005 instalación/handoff final.

**No bloquean P004:** EP-TASK-004 GUI de bóveda; EP-TASK-002/Backblaze; MCP-OCP-06/11 Jules; MCP-OCP-09 PPR/cross-host, salvo dependencia técnica nueva demostrada. No convertir los campos `applicability`, `activation_conditions`, `mandatory` y `dependencies` en requisito de Sink: ART-027 v388 define recuperación de texto, no selección normativa automática. `MCP-NORMATIVO` permanece `DESACTIVADO`.

**Estado observado:** el rebaseline documental no acredita rama nueva, código Sink, pruebas PASS, importación privada, paquete piloto, instalación Fila 4, IPZ nativa, E2E ni panel. Cada hito conserva su propia evidencia.

## Registro de ejecución y dependencia EP · 2026-11-10 · ciclo02

- **Main base actual:** `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd`; corresponde al commit EP de preflight parcial de Fila 4.
- **Rama MCP-OCP:** `feat/mcp-ocp-p004-rebaseline-20261110-cycle02`, creada directamente desde ese HEAD.
- **DUG v388:** commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. La lectura de ese commit y de main actual devuelve el mismo blob.
- **MCP-OCP-02:** rama limpia, inventario REUSE/ADAPT/REWRITE/DROP y pins SDK/RID documentados.
- **MCP-OCP-05:** implementación candidata P004 escrita; no compilada.
- **MCP-OCP-03:** 18 escenarios escritos; 0 ejecutados.
- **MCP-OCP-04:** harness y workflow CI escritos; smoke y E2E pendientes.
- **Preflight EP publicado en main:** evidencia `EP-FILA4-PREFLIGHT-PARCIAL-20261110.json`, commit `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd`, blob `8ebf0c2b54efc6d3fe597adfe0f9358e65e6acbe`; resultado `PREFLIGHT_PARTIAL_FAIL`. C: XTS-AES128/Protection Off/sin protectores; ubicación física UNCLASSIFIED; checkout Metodología parcial y sin `.git`. **EP-TASK-003 sigue en curso; MCP-OCP no modifica esa tarea ni el host.**
- **EP-TASK-005:** pendiente; no importación, instalación, DB, DPAPI ni REGISTER.
- **MCP-NORMATIVO:** DESACTIVADO. **FOL1:** no activado.


### Actualización de main posterior a la base de ciclo02 · 2026-11-10

Main avanzó desde `84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd` hasta `67b48bc041bee372c69389f0aa84ed1a6d19eff5` mediante cuatro commits exclusivos del frente EP (OEP, índice/tareas EP y evidencia de preflight). La comparación `84cc9ffc... → main` confirma que esos cuatro commits no modifican rutas MCP-OCP ni GOV-TASK-015. La rama ciclo02 conserva su base inicial verificada; la rama sigue divergente respecto a main; el conteo ahead/behind y de archivos se consulta en la PR #26 para conservar una única lectura vigente. No hay solapamiento con las cuatro rutas EP-only posteriores a la base. No se rebasea ni se importa contenido de EP a este frente.


## Implementación candidata de observabilidad · 2026-11-10 · ciclo02

**MCP-OCP-13:** se añadieron `src/OcpMcp.Monitoring/` (modelos, lector read-only, escritor best-effort y evaluador compuesto) y `src/OcpMcp.Panel/` (WPF nativo, dashboard de una pantalla, FileSystemWatcher y referencia de proceso PID+hora de inicio). El panel no contiene acciones, no controla el servidor y no accede a STDIO.

**Contrato de datos:** EP escribe `monitor/session.json`; MCP-OCP solo lo lee. El servidor escribe `monitor/state.json` y `monitor/events.jsonl` exclusivamente cuando recibe `--monitor-root <ruta-EP>`; no existe default, no elige/crea el root y no modifica ACL, BitLocker, Registro ni servicios. Los eventos no incluyen argumentos, contenido, texto de principios, hashes de payload, secretos, tokens ni SID. El primer estado es no listo: fuentes no importadas, integridad UNKNOWN, operador UNKNOWN y readiness `SOURCES_NOT_IMPORTED`.

**MCP-OCP-03:** 18 casos P004 escritos; 0 ejecutados. **MCP-OCP-13:** 23 casos de monitor/readiness escritos; 0 ejecutados. Se agregó evaluador fail-closed: READY exige `sessionState=ACTIVE` y `protectionState=Protection On` exacto, sin timestamps futuros, además del proceso RUNNING identificado por PID+inicio, protocolo INITIALIZED, fuentes importadas/VERIFIED/vigentes, operador provisionado y root disponible. El script CI se amplió para restore/build/run de ambas suites y build WPF Windows x64 con cross-targeting; conserva smoke real del ejecutable STDIO.

**Validación:** no compilado ni probado. El último run CI conocido de la revisión anterior terminó FAILURE sin job steps/logs/artifacts; no prueba fallo del código. El runner de contenedor disponible carece de `dotnet`. El PR ciclo02 sigue draft; los commits recientes requieren una nueva lectura de checks asociada a su HEAD.

**Límites:** no se ha empaquetado el panel, hecho smoke visual Windows, integrado apertura/cierre con EP-TASK-005, instalado ni materializado en Fila 4. El gate EP sigue `PREFLIGHT_PARTIAL_FAIL`; no se suministra monitor-root, fuente privada ni runtime persistente en el host.


### Corrección de inventario DUG · 2026-11-10

El lector ahora exige que el inventario sea exactamente `P001…P043` (43 IDs únicos), no solo 43 IDs únicos que incluyan P004. Se añadió un negativo con `P044` sustituyendo `P043`, blob repinneado y rechazo esperado. MCP-OCP-03 queda en 18 escenarios escritos / 0 ejecutados; build y CI siguen sin PASS.


### CI run 56 · 2026-11-10

HEAD con negativo de inventario: `9f66b1ae8e1969cf82c3f753ab30e31c2bd1a8c1`. Run `42868894554`, job `130014524745`: FAILURE, steps/logs/artifacts ausentes. No acredita ejecución. No hay build/test/smoke PASS. El entorno local disponible no tiene `dotnet`.


### Corrección de seguridad del estado compuesto · 2026-11-10

El evaluator `MonitorReadinessEvaluator` ahora impide READY si EP no declara exactamente `Protection On`; `Protection Off`, `UNKNOWN`, sesión no activa, timestamp futuro, proceso no identificado/detenido, protocolo pendiente, fuentes no íntegras/vigentes, operador no provisionado o root no disponible producen códigos de bloqueo. El panel consume ese resultado en vez de confiar solo en `state.json`.

Pruebas añadidas para las condiciones anteriores: 23 escenarios monitor escritos / 0 ejecutados. No se ha inventado una comprobación de BitLocker desde MCP; el estado sigue siendo atestación propiedad de EP.


La validación de tiempo también rechaza atestación de protección anterior al inicio de la sesión y snapshot de servidor con fecha futura. Suite monitor/readiness: 23 casos escritos / 0 ejecutados.


### Cobertura adicional del vínculo humano P004 · 2026-11-10

La suite del lector P004 aumenta a 18 casos. Dos negativos nuevos repinnean el blob para demostrar que falla si `[[P:P004]]` falta/se duplica o si el `content_markdown` de la tarjeta humana difiere del texto normativo. Ningún PASS se declara hasta ejecución real.

### Revisión estática y CI run 78 · 2026-11-10

- MCP-OCP CI run `42871039884` (#78), job original `130022076348`: FAILURE, sin pasos, logs ni artefactos. Se aceptó reintento; el nuevo job `130058287914` volvió a FAILURE con `steps=[]`, `logs_url=null` y cero artefactos. Descarga de logs: `BlobNotFound`.
- En el mismo commit, `validate-canonical-bootstrap` run `42871039938` y `Validate RDC Governance` run `42871039803` también finalizaron FAILURE sin pasos ni artefactos. No hay evidencia de que setup-dotnet, build, tests, WPF o smoke hayan comenzado; no atribuir el resultado al código.
- Revisión estática MCP-OCP-13: el runtime inicializa Sources/Operator/Readiness en estados bloqueados y no ofrece una ruta para actualizarlos; por tanto, el test positivo del evaluator no acredita que el proceso real pueda emitir READY. Además, el watcher del panel no observa la creación tardía de `monitor/`, aunque el contrato requiere que EP pueda abrir el panel antes de iniciar el servidor. Ambos bloqueos requieren cierre y pruebas; no se modifica `session.json` ni el contrato EP.
- Estado: 18 pruebas P004 + 23 de monitor/readiness escritas; 0 ejecutadas. Build, tests, smoke STDIO, build WPF y revisión visual Windows siguen NO VERIFICADOS.
