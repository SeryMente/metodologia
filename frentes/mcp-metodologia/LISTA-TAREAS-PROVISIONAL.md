<!-- LIST_VERSION=0.5; LIST_STATUS=PROVISIONAL; NOT_A_CANONICAL_OBJECT=true -->
# Lista provisional de tareas · MCP-OCP

> **ESTADO: PROVISIONAL · NO ES UN OCP NI UN CONTROL ADICIONAL.** Esta lista es una vista auxiliar enlazada desde el único núcleo MCP-OCP. El estado vivo y las decisiones de alcance permanecen en `MCP-METODOLOGIA.md`; la titularidad permanece exclusivamente en `CONTROL-RESPONSABILIDAD.json`. Las tareas y dependencias de otros frentes se enlazan sin apropiarse de sus objetos, controles o permisos.

- **Frente:** MCP-OCP.
- **Repositorio propietario:** `SeryMente/metodologia`.
- **Ruta OCP:** `frentes/mcp-metodologia/`.
- **Versión de la lista:** 0.5 (provisional; reconciliación del sprint Sink local en tres frentes).
- **Última actualización:** 2026-11-09.
- **Gobierno leído:** Samantha v385 · NX-385m; Metacanon 1.29; GOW 2.18; DUG commit `7dcdac6c62f9e8a27ce11f8fa0e4fc379a3d12f8`; blob `72cd2e8e4e6a594b300ba1868baeabc2472beb97`. §ARR y P037 revisados; CNP P001/P004/P005/P038/P043 considerado.
- **Núcleo enlazado:** [MCP-OCP · objeto canónico](MCP-METODOLOGIA.md), v0.1.24; esta lista v0.5 es su backlog auxiliar vigente.
- **Control:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json). Las generaciones y sesiones son metadatos de auditoría y no bloquean trabajo autorizado.
- **MCP-NORMATIVO:** DESACTIVADO.
- **Producto vs. documento:** MCP-OCP-v0.1.19 es versión documental. La candidata ejecutable 0.1.0 y su recibo histórico no constituyen una versión actualizada ni aceptada del producto.
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

La tabla sustituye los PASS/estados de recibos históricos para la implementación Sink actual. Un PASS histórico no equivale a PASS con DUG v385 ni demuestra instalación/perfil/E2E actuales.

| Orden | ID | Prioridad | Tarea | Estado vigente | Condición principal de salida |
|---:|---|---|---|---|---|
| 1 | MCP-OCP-01 | P0 | Contrato de producto y frontera OCP/Khora/Jules | VERIFICADO_EN_NUCLEO_V0.1.22 | Un solo servidor local MCP-OCP por stdio; Khora/Jules separados; sin endpoints públicos. |
| 2 | MCP-OCP-02 | P0 | Reconciliar código fuente remoto con main y pins actuales | PENDIENTE_SPRINT | Comparar ramas remotas `integration/ocp-mcp-0.1.0-selective-20261101` y `build/ocp-mcp-mvp-0.1.0` con main; no utilizar ZIP ni pin v377 como fuente vigente. |
| 3 | MCP-OCP-05 | P0 | Fuentes, GOW:ARR, DUG y herramientas Sink | PENDIENTE_IMPLEMENTACION | Importar fuentes actuales; resolver GOW:ARR, DUG, SINK:P001..P043 y lote ordenado con hash/evento por recuperación. |
| 4 | MCP-OCP-03 | P0 | Build y suite renovada | PENDIENTE_BUILD_ACTUAL | Build limpio con DUG v385/core actual; pruebas unitarias, contrato, negativos, integración stdio, data-root protegido y hash. No reutilizar 50/30/200 históricos. |
| 5 | MCP-OCP-04 | P0 | Transporte RDC/stdio y perímetro | HISTORICAL_SMOKE_ONLY · E2E_ACTUAL_PENDIENTE | Mismo recorrido que usará el operador: initialize, tools/list, tools/call, respuesta completa, desconexión y reinicio; sin listener. |
| 6 | MCP-OCP-10 | P1 | Pins, manifiesto y evidencia | PENDIENTE_EVIDENCIA_ACTUAL | Commits/blobs/SHA-256 DUG/core, SDK/RID, pruebas, paquete y limitaciones con read-back. |
| 7 | MCP-OCP-07 | P1 | Paquete y runbook actuales | PAQUETE_HISTORICO_NO_RECUPERABLE | ZIP nuevo, verificación de extracción, manifest/hash y runbook actualizado. |
| 8 | MCP-OCP-12 | P1 | Bootstrap del perfil local | PENDIENTE_HOST_Y_CONSENTIMIENTO_LOCAL | Import-sources en la DB real y `provision-operator` con `REGISTER <SID>` interactivo. |
| 9 | MCP-OCP-08 | P1 | Handoff/instalación EP | PENDIENTE_EP_TASK_003_005 | EP acepta host/perfil, volumen/data-root protegido, launcher, read-back y rollback. |
| — | MCP-OCP-06 / 11 | Fuera | Coexistencia/desarrollo por Jules | PAUSADO_POR_OPERADOR | No es dependencia del MVP Sink local. |
| — | MCP-OCP-09 | Fuera | PPR/restauración portable cross-host | P2_FUERA_DEL_SPRINT | No bloquear código, build ni instalación local de una sola ubicación. |

## Fichas de tareas

### MCP-OCP-01 — Contrato de producto local y frontera OCP/Khora/Jules
**Prioridad:** P0 · **Estado:** EN CURSO · **Responsable:** MCP-OCP dentro de su autoridad.

**Objetivo:** fijar sin ambigüedad que el servidor de Metodología es un producto propio del OCP, ejecutado localmente y separado de Khora. La palabra «MSP» del propósito original se conserva como dictado histórico; la identidad técnica vigente del frente es MCP-OCP.

**Incluye:** transporte preferente stdio; operación por RDC; ausencia de listener público; herramientas de lectura/desarrollo/gobernanza; relación con Git local/GitHub; protección fail-closed; límites de escritura y consentimiento.

**Excluye:** capacidades de dictados/audio/MP3/grafo de Khora; servidor Jules duplicado; API key de Jules o secretos de Khora; endpoint público/Vercel; activación de MCP-NORMATIVO; cambios DUG/Sink.

**Cierre:** núcleo, esta lista y README reflejan la misma frontera y la separación se valida por revisión de rutas/dependencias.

### MCP-OCP-02 — Reconciliación de la candidata ejecutable
**Prioridad:** P0 · **Estado:** PENDIENTE.

La rama histórica `integration/ocp-mcp-0.1.0-selective-20261101` contiene una candidata .NET 10 / `net10.0` / `win-x64`, transporte stdio, con recibo histórico 31/31 unitarias, 29/29 integración y 200 componentes. Ese recibo está anclado al núcleo v0.1.16 y al commit base `419be285373ce5390be2020a954d382f11803674`; no es evidencia contra MCP-OCP v0.1.19. Se debe comparar el código y sus contratos con el núcleo actual, preservar historial y trabajar en una rama candidata; no integrar a `main` por inferencia.

### MCP-OCP-03 — Build y pruebas renovadas
**Prioridad:** P0 · **Estado:** PENDIENTE.

Actualizar SDK/dependencias fijadas según el proyecto; validar compilación, unitarias, integración stdio, smoke, seguridad, negative tests, redacción de secretos, fail-closed, shutdown y hashes del paquete. El recibo nuevo identifica commit de código, commit de base, DUG/core blob, SDK, RID, tamaño, SHA-256, conteos de pruebas y limitaciones. No reutilizar resultados históricos.

### MCP-OCP-04 — Transporte y perímetro local
**Prioridad:** P0 · **Estado:** PENDIENTE.

Preferir stdio sin servidor HTTP. Si una dependencia concreta impone HTTP, abrir solo loopback, validar la dirección efectiva con prueba negativa desde LAN, y no instalar túneles/proxies/firewall rules ni publicar URL. RDC administra el equipo; no cambia el perímetro del producto. La ruta de inicio/cierre, cuenta ejecutora, permisos de archivos y logs deben documentarse.

### MCP-OCP-05 — Fuentes y herramientas locales
**Prioridad:** P0 · **Estado:** PENDIENTE.

Probar lectura de DUG/Metacanon/GOW vigentes, núcleo/control OCP, archivos de repositorio, estado Git y evidencia de pruebas. Separar fuente observada, inferencia y estado no verificado. Cualquier operación de escritura exige scope/permiso específico y confirmación aplicable; nunca convertir lectura de fuentes en autorización ni estado MCP-NORMATIVO.

### MCP-OCP-06 — Coexistencia con Jules por puente RDC independiente
**Prioridad:** P0 · **Estado:** PENDIENTE · **Dependencia:** MCP-Jules y Khora-MCP.

La coexistencia debe ser dos clientes/canales locales claramente separados: servidor MCP-OCP por stdio y puente Jules por stdio/RDC hacia Khora `/api/mcp`. El primer test autenticado de Jules es solo lectura (tools/list, fuentes, sesiones/actividades); no crea sesiones. No se supone que un proceso MCP stdio sea automáticamente visible para ChatGPT; se documenta el mecanismo efectivo de invocación a través de RDC.

### MCP-OCP-07 — Paquete preliminar
**Prioridad:** P1 · **Estado:** PENDIENTE.

Generar paquete portable local con manifest, hashes, launcher y guía. La entrega puede preceder al cierre de EP/B2. No presentarlo como instalado en EP ni aceptado por operador hasta el gate correspondiente. No incluir credenciales, tokens ni datos del usuario.

### MCP-OCP-08 — Instalación EP
**Prioridad:** P1 · **Estado:** BLOQUEADO_DEPENDENCIA_EP.

EP define host, usuario, rutas, ACL, startup, servicios/procesos y actualización/rollback. MCP-OCP entrega artefactos e instrucciones; no cambia el host EP ni instala/arranca servicios bajo el control de otro frente sin autorización exacta.

### MCP-OCP-09 — Respaldo y recuperación portable
**Prioridad:** P2 · **Estado:** BLOQUEADO_P012_P013_Y_HOST_DESTINO.

La propuesta portable de §8.2 permanece separada del MVP local. No implementar el re-enveloping/cambio de custodia de claves hasta la revisión de seguridad/arquitectura aplicable y presencia requerida; cross-host exige host/perfil autorizado. No bloquear MCP-OCP-02/03/04/07 por esta dependencia.

### MCP-OCP-10 — Gobernanza y evidencia
**Prioridad:** P1 · **Estado:** PENDIENTE.

Mantener pin de DUG/Metacanon/GOW, consulta contextual de principios y evidencias minimizadas. El servidor puede exponer datos/gates de estado; no se anuncia evaluación normativa automática mientras MCP-NORMATIVO esté DESACTIVADO y falten datos/aprobación canónica.

### MCP-OCP-11 — Ciclo sandbox mediante Jules
**Prioridad:** P1 · **Estado:** BLOQUEADO_HASTA_CONFIGURAR_MCP_JULES.

Una vez configuradas y aceptadas las tareas del frente MCP-Jules, se prepara una sesión de prueba contra sandbox OCP, no contra producción ni ramas protegidas. Jules debe devolver plan; el operador confirma ese plan específico; solo entonces se permite aprobación. Resultado exigido: PR verificable, pruebas, lectura de vuelta y cierre documental. La creación de sesión no equivale a ejecución ni aceptación.



### MCP-OCP-12 — Bootstrap del perfil local definitivo
**Prioridad:** P1 · **Estado:** BLOQUEADO_CONSENTIMIENTO_OPERADOR.

El paquete ya está compilado y probado en un root temporal de test. El bootstrap real debe hacerse sobre el perfil Windows que vaya a utilizar el servidor, con una ruta estable de extracción y un clon SeryMente/metodologia con los commits/blobs fijados. Después de verificar el ZIP, ejecutar import-sources para cifrar las fuentes canónicas con DPAPI CurrentUser. La provisión del operador crea claves criptográficas y enlaza el SID Windows, por lo que exige presencia y confirmación explícita en consola (`REGISTER <SID>`). No se ejecuta en esta fase documental ni se presume que el health READY de test equivale a perfil configurado. Esta tarea no instala en EP; el handoff EP continúa en MCP-OCP-08.

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

DUG vigente: Samantha v385 · NX-385m; commit `7dcdac6c62f9e8a27ce11f8fa0e4fc379a3d12f8`; blob `72cd2e8e4e6a594b300ba1868baeabc2472beb97`. El operador autorizó directamente Sink local por stdio, pruebas, build, paquete, manifiesto y documentación dentro de este OCP. No se necesita aprobación del titular anterior ni generación de control. GitHub privado se consulta mediante el conector autenticado; `gh auth login` local no es requisito. La instalación persistente EP y sus operaciones de custodia permanecen separadas. MCP-NORMATIVO sigue DESACTIVADO.


## Reconciliación de ejecución · 2026-11-09 · DUG v385

- **Autorización Sink:** directa del operador y registrada en CONTROL-RESPONSABILIDAD.json; ningún titular anterior, generación ni folio es compuerta.
- **Fuente candidata:** hay código C# recuperable en ramas remotas de GitHub; no está integrado en main. El código de esas ramas es base histórica para port/revisión, no release.
- **Estado de implementación:** el código candidato ofrece SourceImporter y PrincipleCatalog para IDs/MDP; Sink de texto individual no está desplegado en main. PrincipleCatalog reconoce 43 IDs/MDP pero deja metadata applicability/activation/dependencies incompleta; no inferirla.
- **Root de datos:** Program.cs usa `%LOCALAPPDATA%\\SeryMente\\OCP MCP` por defecto. Antes del handoff se debe configurar un root de datos/backup dentro del volumen cifrado o demostrar que el volumen del perfil está protegido.
- **Autenticación:** el conector GitHub de ChatGPT está autenticado para operaciones de repositorio desde esta conversación. La autenticación GitHub local del perfil Windows no se hereda; se valida por separado si build/import local lo necesita.
- **Dependencias EP:** EP-TASK-003 para workspace protegido y dead-man si LOC-OTHER; EP-TASK-005 para instalación/aceptación. EP-TASK-004 no bloquea compilar Sink ni el trust root DPAPI del servidor.


## Destino EP designado · 2026-11-09

El operador designó el perfil/usuario Windows `PC 7`, asociado a un dispositivo RDC, con ubicación `LOC-OTHER`. Esta designación sustituye la selección pendiente del host/perfil. El hostname/ID técnico del dispositivo, sesión, usuario/SID efectivos, rutas, permisos y almacenamiento deberán verificarse en vivo por EP.

Para MCP-OCP, este dato **no bloquea** reconciliar fuentes, implementar Sink, ejecutar pruebas ni generar el paquete. Sí bloquea handoff/bootstrap e instalación persistente hasta que EP complete EP-TASK-003: workspace/DB/runtime/respaldos protegidos y dead-man LOC-OTHER implementado, probado y leído de vuelta en el destino. El estado de cifrado observado previamente en otro perfil no se hereda.
