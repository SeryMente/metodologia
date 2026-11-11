<!-- LIST_VERSION=0.13; LIST_STATUS=PROVISIONAL; NOT_A_CANONICAL_OBJECT=true -->
# Lista provisional de tareas · MCP-OCP

> **ESTADO: PROVISIONAL · NO ES UN OCP NI UN CONTROL ADICIONAL.** Esta lista es una vista auxiliar enlazada desde el único núcleo MCP-OCP. El estado vivo y las decisiones de alcance permanecen en `MCP-METODOLOGIA.md`; la titularidad permanece exclusivamente en `CONTROL-RESPONSABILIDAD.json`. Las tareas y dependencias de otros frentes se enlazan sin apropiarse de sus objetos, controles o permisos.

- **Frente:** MCP-OCP.
- **Repositorio propietario:** `SeryMente/metodologia`.
- **Ruta OCP:** `frentes/mcp-metodologia/`.
- **Versión de la lista:** 0.13 (provisional; coordinación del Sprint SINK-P004 y producto MCP-OCP 1.0.0).
- **Última actualización:** 2026-11-11.
- **Gobierno leído:** Samantha v388 · NX-388m; Metacanon 1.29; GOW 2.18; DUG commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. ART-027 rebaselined para Sink local STDIO/RDC; §ARR y P037 revisados; CNP P001/P004/P005/P038/P043 considerado.
- **Núcleo enlazado:** [MCP-OCP · objeto canónico](MCP-METODOLOGIA.md), v0.1.31; esta lista v0.13 es su backlog auxiliar vigente.
- **Control:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). Las generaciones y sesiones son metadatos de auditoría y no bloquean trabajo autorizado.
- **MCP-NORMATIVO:** DESACTIVADO.
- **Producto vs. documento:** MCP-OCP-v0.1.31 es la versión documental vigente; la versión de software objetivo es 1.0.0. La candidata ejecutable 0.1.0 y su recibo histórico no constituyen una versión actualizada ni aceptada del producto.
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
| 1 | MCP-OCP-01 | P0 | Contrato de producto y frontera OCP/Khora/Jules | VERIFICADO_EN_NUCLEO_V0.1.29 | Un servidor local STDIO; panel acompañante read-only en el producto final; dominios separados. |
| 2 | MCP-OCP-02 | P0 · CRÍTICO AHORA | Rama limpia y reconciliación selectiva desde main | PORTACIÓN SELECTIVA EN RAMA LIMPIA; BUILD ACTUAL PENDIENTE | Nueva rama desde HEAD de main; pin DUG v388 cotejado; inventario REUSE/ADAPT/REWRITE/DROP y SDK/RID. |
| 3 | MCP-OCP-05 | P0 · SIGUIENTE | Corte vertical GOW:ARR → DUG → SINK:P004 | P004 PORTADO; BUILD DE RAMA ACTUAL PENDIENTE | Respuesta individual completa, pin v388/commit/blob/SHA-256 y fail-closed. Fixtures antes de EP; importación privada tras EP PASS. |
| 4 | MCP-OCP-03 | P0 | Suite mínima de contrato del piloto P004 | 18/18 P004 + 23/23 MONITOR PASS HISTÓRICO POR BLOBS; REEJECUCIÓN PENDIENTE | Preparar contrato y casos ID/fuente/pin/hash/fallo cerrado/cierre ahora; repetir con fuente real tras EP PASS. |
| 5 | MCP-OCP-04 | P0 | Transporte y E2E IPZ → RDC → STDIO para P004 | HARNESS PORTADO; REEJECUCIÓN SMOKE PENDIENTE; E2E IPZ PENDIENTE | Preparar harness/smoke; E2E exige P004 instalado y respuesta visible desde contexto IPZ. Consola sola no basta. |
| 6 | MCP-OCP-05 (fase posterior) / 03 | P0 | Generalización Sink P001–P043 y lotes | PENDIENTE_POST_PILOTO | 43 respuestas, orden, hashes/eventos y controles negativos PASS. |
| 7 | MCP-OCP-13 | P1 | Panel local de observabilidad visual | ESPECIFICADO · IMPLEMENTACIÓN_PENDIENTE | Obligatorio en 1.0.0; se implementa tras congelar schema, en paralelo con la generalización, y no bloquea el piloto SINK:P004. |
| 8 | MCP-OCP-10 | P1 | Pins, manifiesto y evidencia final | PENDIENTE_EVIDENCIA_ACTUAL | Pins DUG v388/core vigente, SDK/RID, servidor+panel, tests y hashes. |
| 9 | MCP-OCP-07 | P1 | Paquete reproducible 1.0.0 | PENDIENTE_PAQUETE_ACTUAL | ZIP final servidor+panel, configuración, manifest/SHA y read-back. |
| 10 | MCP-OCP-12 | P1 | Bootstrap local en Fila 4 | BLOQUEADO_GATES_EP | Piloto/instalación dentro de checkout; datos externos protegidos; REGISTER interactivo. |
| 11 | MCP-OCP-08 | P1 | Handoff y aceptación EP | PENDIENTE_EP_TASK_003_005 | Verificación de ruta, root, panel EP ACTIVE, hashes, cierre y rollback. |
| 12 | MCP-OCP-14 | P0 · H2/H3 | Contrato de persistencia rápida: journal, snapshots cifrados y workspace completo | CONFIGURADA · IMPLEMENTACIÓN PENDIENTE | Persistencia mínima desde el inicio; B2 único backend inicial; manifest/SHA, checkpoint acotado, download y restore del workspace completo. |
| 13 | MCP-OCP-15 | P1 · H4 | Identidad y telemetría integral de sesión/dispositivo/ubicación/ciclo | CONFIGURADA · SCHEMA/IMPLEMENTACIÓN PENDIENTES | UUIDv7 + etiquetas secuenciales, eventos correlacionados, IP/GPS disponibles, tiempos monotónicos, contenido conversacional cifrado y retención prevista indefinida. |
| 14 | MCP-OCP-16 | P1 · H7 | Integración de bóveda con autenticación RDC y credenciales just-in-time | DIFERIDA · NO IMPLEMENTAR AHORA | RDC autentica al iniciar; una sesión activa por defecto y segunda excepcional; canal seguro auditado antes de implementar. |
| 15 | MCP-OCP-17 | P2 · POST-1.0.0 | Evaluación de medio/proveedor alternativo de persistencia | DIFERIDA · NO PROVISIONAR AHORA | Diseñar fallback adicional sin sustituir B2 ni bloquear release; solo evaluación después de estabilidad B2. |
| — | MCP-OCP-06 / 11 | Fuera | Coexistencia/desarrollo por Jules | PAUSADO_POR_OPERADOR | No es dependencia del MVP local. |
| — | MCP-OCP-09 | Fuera | PPR/restauración portable cross-host | P2_FUERA_DEL_SPRINT | No bloquear release local. |

## Fichas de tareas

### MCP-OCP-01 — Contrato de producto local y frontera OCP/Khora/Jules
**Prioridad:** P0 · **Estado:** VERIFICADO_EN_NUCLEO_V0.1.29 · **Responsable:** MCP-OCP dentro de su autoridad.

**Objetivo:** fijar sin ambigüedad que el servidor de Metodología es un producto propio del OCP, ejecutado localmente y separado de Khora. La palabra «MSP» del propósito original se conserva como dictado histórico; la identidad técnica vigente del frente es MCP-OCP.

**Incluye:** transporte preferente stdio; operación por RDC; ausencia de listener público; herramientas de lectura/desarrollo/gobernanza; relación con Git local/GitHub; protección fail-closed; límites de escritura y consentimiento.

**Excluye:** capacidades de dictados/audio/MP3/grafo de Khora; servidor Jules duplicado; API key de Jules o secretos de Khora; endpoint público/Vercel; activación de MCP-NORMATIVO; cambios DUG/Sink.

**Cierre del baseline histórico v0.1.29/v0.10:** núcleo y lista de aquel corte reflejaban la frontera de app acompañante read-only, sin segundo MCP ni red. Este estado fue supersedido por MCP-OCP-v0.1.30 y LIST v0.11; las pruebas de implementación siguen pendientes.

### MCP-OCP-02 — Reconciliación de código ejecutable contra main
**Prioridad:** P0 · **Estado:** PENDIENTE_SPRINT.

**Objetivo:** obtener una rama de trabajo limpia cuyo padre sea el HEAD vigente de main; conservar solo componentes históricos que pasen revisión contra el núcleo y los contratos actuales. Las ramas candidatas históricas son referencias de lectura, no bases de merge.

**Trabajo:** verificar ramas/commits; comparar estructura y contratos; clasificar por componente REUSE / ADAPT / REWRITE / DROP; portar selectivamente el código a rama nueva; fijar .NET/SDK/RID compatible y reproducible; revisar dependencias, licencias y secretos.

**Salida de cierre:** rama candidata desde main con base documentada; mapa de portabilidad; diff acotado; build inicial sin secretos; pruebas históricas clasificadas como antecedentes, nunca como PASS de 1.0.0.


**Resultado de reconciliación 2026-11-11:** rama `feat/mcp-ocp-p004-reconciled-20261111-7ab0c555`; padre directo de portación `7ab0c555b774adc5b930aad700f101ab2660b79a`; sincronizada con main `07e51261ad6c08ef1327826bbe7af66815ce28bd` mediante merge `85902f86a13cb809c38a9cf6b288b1ece08cccc9`. El inventario REUSE/ADAPT/DROP/DEFER está en [RECONCILIACION-20261111.md](piloto-sink/RECONCILIACION-20261111.md). SDK `10.0.403`; piloto `net10.0`, framework-dependent, sin RID. El build de la rama actual sigue pendiente.
### MCP-OCP-03 — Calidad, pruebas y build de release (servidor + panel)
**Prioridad:** P0 · **Estado:** PENDIENTE.

**Objetivo:** demostrar el comportamiento del producto nuevo con pruebas repetibles, no solo compilarlo.

**Pruebas mínimas:** build limpio; unitarias y contrato; initialize/tools/list/tools/call; health/readiness; ARR/DUG/catálogo; Sink individual y lote ordenado; hash correcto; entradas inválidas; fuente ausente/obsoleta/alterada; traversal/ACL; logs sin secretos; shutdown/restart; ausencia de listeners no autorizados. Reutilizar harness existente cuando siga válido y ampliar solo lo necesario. Añadir pruebas de schema/reader/writer del panel, estados EP ACTIVE sin servidor, readiness parcial, caída del proceso, ACL/JSON inválidos y ciclo de cierre de UI.

**Salida:** recibo ligado al commit de código y al main base, pins DUG/core, SDK/RID, comandos, conteos, PASS/FAIL, limitaciones y hashes. Release solo cuando suite y paquete pasen; no convertir resultados de candidata antigua en evidencia nueva.


**Evidencia disponible 2026-11-11:** las suites portadas tienen 18 casos P004 y 23 monitor/readiness. Los blobs de lector, servidor, programa, pin, pruebas y harness coinciden con la ejecución local histórica en Windows/.NET SDK 10.0.403 (restore/build PASS, 18/18 + 23/23 PASS, smoke STDIO/EOF PASS). Esto es antecedente de los mismos blobs, no ejecución en esta rama. En este entorno no hay `dotnet` ni `pwsh`; la reejecución ligada al commit reconciliado permanece pendiente. Ver [RECONCILIACION-20261111.md](piloto-sink/RECONCILIACION-20261111.md).
### MCP-OCP-04 — Transporte MCP STDIO y recorrido RDC
**Prioridad:** P0 · **Estado:** PENDIENTE.

**Objetivo:** verificar el canal que se utilizará realmente en el perfil final.

**Trabajo:** iniciar proceso local mediante cliente MCP/RDC autorizado; comprobar initialize, tools/list, tools/call/respuesta completa, cancelación/cierre, EOF y reinicio. Verificar stdin/stdout reservados al protocolo, logs únicamente saneados en stderr/archivo protegido, permisos mínimos y que no se crea listener HTTP/TCP, túnel o endpoint público.

**Salida:** recibo de smoke real del ejecutable de release y configuración del cliente, con ruta de binario y evidencia del perímetro. El smoke temporal histórico no cuenta como E2E instalada. El panel recibe la proyección por archivos locales y no se interpone en stdin/stdout.


**Estado 2026-11-11:** el harness STDIO/EOF está portado, pero el smoke no se reejecutó en el commit reconciliado. La aceptación IPZ E2E requiere instalación válida por EP y respuesta visible desde contexto IPZ; permanece pendiente.
### MCP-OCP-05 — Fuentes canónicas, herramientas de lectura, Sink y estado observable
**Prioridad:** P0 · **Estado:** PENDIENTE_IMPLEMENTACION.

**Objetivo:** construir el conjunto mínimo de herramientas de lectura necesarias para MCP-OCP 1.0.0.

**Alcance funcional en dos fases:** **Fase A (primero):** diagnóstico mínimo, importación/validación, GOW:ARR, identidad/procedencia DUG y recuperación individual SINK:P004 para habilitar el piloto IPZ. **Fase B (después de verificar el piloto):** catálogo completo 43 MDP, SINK:P001..P043 individual, lotes ordenados, eventos/frecuencia y lectura acotada de documentos/OCP bajo allowlist. No crear herramientas MCP de escritura en 1.0.0.

**Integridad:** respuesta individual con ID/título/pin exacto/hash de texto. Evento de frecuencia solo por recuperación íntegra satisfactoria. Hash de lote sobre serialización UTF-8 canónica de IDs ordenados, pins y hashes individuales. Fuente desactualizada, ausente, alterada, no importada, parámetro inválido o ruta fuera de allowlist ⇒ rechazo explícito; nunca fallback a memoria o MDP.

**Salida:** operaciones/schemas implementados, ejemplos de respuesta y pruebas de contrato. Metadatos de aplicabilidad ausentes no se infieren; MCP-NORMATIVO queda DESACTIVADO.


**Estado del corte P004 2026-11-11:** lector y servidor portados sobre main actual; pin DUG v388/NX-388m, §ARR y P004 cotejados. El código conserva fail-closed. Falta reejecutar build/suite y regenerar paquete; generalización P001–P043 sigue posterior a la aceptación P004.
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

### MCP-OCP-14 — Persistencia mínima, snapshots cifrados y workspace completo por instancia

**Prioridad:** P0/H2–H3 · **Responsable:** MCP-OCP; ejecución B2 y host bajo EP-TASK-002/003/007.

**Objetivo:** definir e implementar un contrato estable de persistencia que permita empezar con una versión cruda inmediatamente y evolucionar sin interrupción hacia snapshots rápidos, incrementales y restaurables.

**Incluye:**
- Journal local de sesión/checkpoints y estado de último snapshot confirmado.
- Dataset organizacional: workspace completo, proyectos/repositorios/cambios elegibles, conversaciones y adjuntos, bóveda cifrada y datos operativos OCP. Todo se cifra en origen; contenido de conversación nunca aparece en telemetría/logs en claro.
- Descarga del workspace completo en cada nueva instancia; manifest versionado, inventario de archivos, tamaños, algoritmo/identidad de cifrado y SHA-256.
- Checkpoint normal acotado por EP-TASK-007 a un presupuesto inicial de 30 s; entregar resultado confirmado/no confirmado. En emergencia el llamador puede saltar la persistencia y cerrar criptográficamente.
- Estados separados: LOCAL_DURABLE, REMOTE_UPLOADED, REMOTE_VERIFIED y RESTORE_VERIFIED.
- Respaldo remoto solo en Backblaze durante este sprint. Medio alternativo queda MCP-OCP-17 post-release.
- Retención esperada indefinida para ciphertext útil, sin políticas de expiración automáticas introducidas por esta tarea.
- Eficiencia: empezar con snapshots completos y journal mínimo; después introducir deduplicación/chunks/incrementales/compresión y caché cifrada, manteniendo el contrato y la restaurabilidad.

**No incluye:** provisionar un nuevo proveedor/DB/cola/servicio; manipular credenciales o bucket; borrar versiones; cambiar lifecycle/ACL; ejecutar B2 desde MCP-OCP si el contrato asigna operación a EP.

**Aceptación:** round-trip workspace completo entre dos instancias autorizadas, manifest/SHA correctos, restore aislado, recibos read-back, recuperación separada de la clave efímera de sesión y evidencia de que una falla de persistencia no prolonga el cierre del dead-man.

### MCP-OCP-15 — Identidad, metadatos y telemetría integral de sesión

**Prioridad:** P1/H4 · **Responsable:** MCP-OCP define schema y almacenamiento; EP recopila datos del host/ubicación; Gobernanza acepta semántica y privacidad.

**Nomenclatura:** UUIDv7 será la identidad técnica canónica. Etiquetas humanas secuenciales sugeridas: ORG-000001, WSP-000001, SES-YYYYMMDD-000001, LOC-000001, DEV-000001, NET-000001, CONV-000001, CYC-000001 y EVT-000001. Los consecutivos se asignan atómicamente cuando exista persistencia; UUIDv7 permite registro offline y reconciliación posterior. IDs no contienen IP, nombre, hostname, MAC, serie o dirección.

**Campos de sesión:** session_id, workspace_id, location_id, device_id, network_snapshot_id, started_at_utc, ended_at_utc, IANA timezone, UTC offset, monotonic duration_ms, lease timestamps, end_reason, termination_status, schema_version y source/precision/status de cada observación.

**Eventos mínimos:** session.started, session.heartbeat, session.lease.renewed, session.idle.warning, session.locked, session.ended, session.deadman.triggered, session.persistence.checkpoint, session.workspace.restored, session.cleanup.completed, session.device.inventory.completed, session.network.observed, conversation.linked, cycle.started, cycle.completed y cycle.not_measured. Correlación por session_id + conversation_id + cycle_id + event_id.

**Inventario robusto:** consumir el resultado EP de SO/hardware/storage/filesystem/encryption/permissions/resources, IP pública y local, ASN/operador, GPS y geolocalización con fuente/precisión/estado. Si GPS o IP no está disponible, se registra UNAVAILABLE/DENIED/ERROR, sin bloquear la sesión ni fabricar un valor. No evadir permisos del sistema operativo.

**Tiempo:** marcas UTC para auditoría y reloj monotónico para duración; nunca restar tiempos de pared. Las métricas de ciclo existentes en GOV-TASK-013 y la resolución IPZ/RDC mantienen su semántica propia y se correlacionan sin redefinirlas.

**Cifrado/retención:** eventos y metadatos identificables cifrados en reposo y en backup; contenido completo de conversaciones y adjuntos vive en workspace cifrado, no duplicado en logs/eventos. Retención prevista indefinida conforme a la instrucción del operador, sujeta a obligaciones aplicables y revisión legal. La telemetría no añade contenido oculto de conversaciones.

**Aceptación:** schema versionado, UUIDv7 y secuencias idempotentes, eventos inicio/final, ubicación y dispositivo observados, IP/GPS con estado y fuente, correlación conversación/ciclo, duración monotónica, cifrado, read-back y pruebas de no bloqueo del camino crítico.

### MCP-OCP-16 — Bóveda a RDC: autenticación inicial y credenciales just-in-time

**Prioridad:** P1/H7 · **Diferida por instrucción del operador; no ejecutar en H2.**

RDC autentica al inicio de sesión. La política es una sesión activa por defecto; una segunda solo por excepción explícita y máximo dos, con session_id, lease, clave y contexto aislados. En el hito posterior, auditar la versión RDC y sus mecanismos soportados para consumir credenciales desde EP Vault de forma just-in-time. No seleccionar el canal hasta demostrar que el secreto no aparece en línea de comandos, variables heredadas, archivos, portapapeles, logs o telemetría. Preferir interfaz de secretos soportada, Credential Manager o IPC protegido de vida breve. No crear credenciales, rotarlas ni leer valores durante H2.

**Aceptación:** flujo de prueba con secreto sintético, alcance de proceso, autenticación/renovación, expiración, revocación, no exposición en logs/procesos y read-back saneado.

### MCP-OCP-17 — Medio alternativo de persistencia

**Prioridad:** P2 · posterior a MCP-OCP 1.0.0. Evaluar segundo proveedor/medio independiente para reducir dependencia de B2; no provisionar ni transferir datos en el sprint presente. La decisión se basará en análisis de disponibilidad, coste, compatibilidad, cifrado, restaurabilidad, retención y riesgo común. B2 sigue siendo el único backend remoto inicial.

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

## Antecedente de destino y orden inicial · 2026-11-10 · LIST v0.8 · supersedido por LIST v0.10/§Sprint SINK-P004

**Destino funcional:** Fila 4, designado por el operador; PC 7 queda supersedido y no es fallback. Este asiento conserva el antecedente de designación. Conforme a ART-013, no se almacenan Device IDs, cuentas, hostnames ni SessionIds efímeros. El preflight vigente y la ubicación física se consultan en OEP §§122–124 y EP-TASK-003; la clasificación sigue `UNCLASSIFIED`.

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

**Estado de esta rectificación:** tareas y orden documental alineados; rama, build, pruebas, piloto, IPZ nativa, preflight Fila 4, instalación y aceptación siguen pendientes.


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

---

## Sprint SINK-P004 · estado y responsabilidades · 2026-11-10 · LIST v0.10

**Nombre operativo:** `SINK-P004`. Objetivo de esta fase: primera respuesta P004 íntegra desde el contexto IPZ real por RDC/STDIO. El objetivo de producto final sigue MCP-OCP 1.0.0 (servidor + panel).

### Estado rebaselined

- DUG vigente: Samantha v388/NX-388m; ART-027 local STDIO/RDC; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
- Baseline de esta sección: v0.1.29 / v0.10; supersedido por el núcleo v0.1.30 y backlog v0.11.
- La rama `feat/mcp-ocp-sink-p004-pilot-20261110` permanece anclada al commit histórico `1676901cc09af6fcec4d052800b031e4c2f1ab40`; no cumple el requisito de nueva rama desde el main vigente. No fusionar la rama completa ni contar su existencia como MCP-OCP-02 PASS.
- Control MCP-OCP generación 5: autorización directa para código local STDIO, pruebas, build, manifest, paquete y documentación dentro de este OCP; control sin cambios. Exclusiones host EP/Vault/recuperación/credenciales externas y cambios DUG/IPZ.
- EP no es una dependencia para desarrollar código no sensible ni probar con fixtures. EP sí es gate para importación privada, DB real, runtime persistente e instalación local.
- El frente EP reanuda sus propias tareas bajo OEP §124; no se modificó el control EP generación 3 ni se declara que EP haya aceptado el relevo.
- Gobernanza mantiene DUG/IPZ y aceptación E2E; no se atribuyen esas tareas a MCP-OCP.

### Secuencia operativa obligatoria

1. **MCP-OCP-02 (P0):** nueva rama desde HEAD actual de main; auditar código/ramas, mapa REUSE/ADAPT/REWRITE/DROP, SDK/TFM/RID y dependencias.
2. **MCP-OCP-05 (P0):** corte `GOW:ARR → DUG v388 → SINK:P004` con fixtures sintéticos primero. Respuesta íntegra y trazable con ID, título, pin, commit/blob y SHA-256; fail-closed.
3. **MCP-OCP-03 (P0 paralelo):** pruebas positivas/negativas de contrato sobre fixtures; repetir con fuente privada tras EP PASS.
4. **MCP-OCP-04 (P0 paralelo):** harness y smoke STDIO/RDC; initialize, tools/list, tools/call:P004, respuesta, cierre. Consola no equivale a E2E IPZ.
5. **EP-TASK-003 (P0 host, responsable EP):** revalidación de Fila 4, diseño de almacenamiento que conserve la ruta `%USERPROFILE%\Desktop\SeryMente`, aceptación expresa del operador antes de mutar, protección/recovery, copia+SHA, checkout íntegro, root protegido y dead-man condicional.
6. **GOV-TASK-007 (paralelo):** candidato IPZ compacto tras congelar el contrato de respuesta P004; no modificar IPZ nativa sin acto/autoridad separados.
7. **EP-TASK-005 + MCP-OCP-12 (P0 local, responsable EP):** solo con EP-TASK-003 PASS y paquete P004/manifest/SHA + pruebas MCP-OCP-03/04 PASS; instalar en `instalacion-local/piloto-sink/`, importar DUG v388 y comprobar readiness.
8. **GOV-TASK-003 + GOV-TASK-007 + MCP-OCP-04:** E2E real IPZ → RDC → STDIO → respuesta visible al modelo. Aceptación solo con texto íntegro, pin/hash y evidencia.
9. **Después de P004 PASS:** generalizar P001–P043/lotes; GOV-TASK-001 ejecuta matriz 43+8.
10. **Release 1.0.0:** MCP-OCP-13 panel WPF obligatorio (no bloquea P004), MCP-OCP-10/07 manifest/build/ZIP; MCP-OCP-12/08 y EP-TASK-005 instalación/handoff final.

### Estado

`MCP_OCP_02=OPEN` · `MCP_OCP_05=PENDING_DEPENDS_02` · `MCP_OCP_03=PARALLEL_FIXTURES` · `MCP_OCP_04=PARALLEL_HARNESS` · `EP_TASK_003=PARTIAL_FAIL` · `EP_TASK_005=PENDING` · `GOV_E2E=PENDING` · `PANEL_1_0_0=REQUIRED_POST_SCHEMA` · `FOL1=PREPARED_NOT_ACTIVE` · `MCP_NORMATIVO=DESACTIVADO`.

El trabajo de MCP-OCP no está aceptado por tener documentos o rama; cada salida requiere código, prueba, evidencia y read-back propios.


## Rebaseline de hitos y órdenes del operador · OCP MCP 1.0 · 2026-11-10

### Secuencia vigente

- **H1 · SINK:P004:** P0 y en paralelo independiente; MCP-OCP-02 → 05, 03/04 en paralelo. No espera al panel, a la bóveda completa ni a la instalación EP para el desarrollo con fixtures.
- **H2 · Persistencia mínima + bóveda organizacional:** P0 inmediato. MCP-OCP-14 define journal/checkpoint/datasets; EP-TASK-004/006 inventarían la totalidad de variables KHORA/OCP/Ser y Mente; EP-TASK-002 inicia ciphertext B2, descarga y restore. Sin valores secretos en Git/chat/logs.
- **H3 · Workspace completo por instancia:** MCP-OCP-14 + EP-TASK-002/003/007; descarga íntegra, cifrado, integridad, checkpoints y restore.
- **H4 · Metadatos y telemetría:** MCP-OCP-15 define schema; EP-TASK-007 produce inventario de host/ubicación/red/GPS; GOV-TASK-013 integra ciclos/tiempos sin alterar su semántica.
- **H5 · Lease renovable y dead-man:** EP-TASK-007/GUI; renovación 60 s, lease 30 min, inactividad 10 min, aviso previo y máximo 8 h.
- **H6 · Limpieza adaptativa:** EP-TASK-007, crypto-erasure prioritaria y limpieza limitada a artefactos OCP; no sobrescritura SSD/UNKNOWN.
- **H7 · RDC/credenciales seguras:** MCP-OCP-16 con EP Vault, después de auditar canal seguro; RDC ya autentica al inicio; 1 sesión normal, 2 solo excepción explícita.
- **H8 · MCP-OCP 1.0.0:** panel, pruebas, manifest/build/paquete, instalación y aceptación integral.
- **H9 · Persistencia alternativa:** MCP-OCP-17, solo etapa posterior; no aprovisionar en este sprint.

### Instrucción literal como criterio de verdad

La instrucción completa se conserva verbatim en el anexo Gobernanza OCP MCP 1.0. Este backlog implementa su lectura normalizada sin corregir, sustituir ni abreviar el original. En caso de discrepancia, prevalece la instrucción literal del operador junto con controles de seguridad/legales aplicables; cualquier ajuste de alcance vuelve al operador.

**No se declara ejecución:** estas fichas configuran los trabajos; no acreditan que EP haya acusado recibo, que el código esté implementado, que B2 haya sincronizado/restaurado, que GPS/telemetría se hayan capturado o que el guardián esté activo.


## Informe individual obligatorio por tarea · LIST v0.12

Cada ficha MCP-OCP-XX debe incorporar su propio informe de resolución/cierre bajo el bloque de esa tarea en esta lista (o en su núcleo individual, cuando exista). Aplicar [la plantilla común obligatoria](../PLANTILLA-REPORTE-CIERRE-TAREA.md). El reporte debe detallar cómo se resolvió, cambios y decisiones, criterios PASS/FAIL/NOT_RUN, build/tests/smoke realmente ejecutados, workflows/runner/logs/artefactos, hashes/read-back, bloqueantes, preocupaciones/riesgos, pendientes, rollback y aceptación. No basta con modificar el estado de la tabla.

Una tarea queda COMPLETADA únicamente con criterios PASS, evidencia de ejecución reproducible y read-back del informe. Si falta runner, logs, artefactos, prueba, fixture real, aceptación o dependencia externa, registrar PARCIAL/BLOQUEADA con el dato exacto; no inferir causa raíz ni éxito. Actualizar el núcleo MCP-OCP y la lista solo después de verificar el informe; al operador se le entrega un enlace por tarea cerrada y un resumen con solución, evidencia, bloqueantes y preocupaciones. No incluir secretos ni contenido privado en los reportes.

Esta regla no cambia la asignación: MCP-OCP conserva código/schema/pruebas; EP conserva host/Vault/B2/instalación; Gobernanza conserva coordinación y aceptación E2E. Las tareas de otro frente no se declaran completadas desde esta lista.
