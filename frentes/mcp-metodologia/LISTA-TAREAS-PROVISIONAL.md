<!-- LIST_VERSION=0.3; LIST_STATUS=PROVISIONAL; NOT_A_CANONICAL_OBJECT=true -->
# Lista provisional de tareas · MCP-OCP

> **ESTADO: PROVISIONAL · NO ES UN OCP NI UN CONTROL ADICIONAL.** Esta lista es una vista auxiliar enlazada desde el único núcleo MCP-OCP. El estado vivo y las decisiones de alcance permanecen en `MCP-METODOLOGIA.md`; la titularidad permanece exclusivamente en `CONTROL-RESPONSABILIDAD.json`. Las tareas y dependencias de otros frentes se enlazan sin apropiarse de sus objetos, controles o permisos.

- **Frente:** MCP-OCP.
- **Repositorio propietario:** `SeryMente/metodologia`.
- **Ruta OCP:** `frentes/mcp-metodologia/`.
- **Versión de la lista:** 0.2 (provisional; estados de reconciliación/build/readiness actualizados con evidencia local).
- **Última actualización:** 2026-11-06.
- **Gobierno leído:** Samantha v377 · NX-377m; Metacanon 1.28; GOW 2.17; DUG blob `54064c8fe00f872023a455f06596061ed69062ae`. §ARR consultado; cascada revisada manualmente; CNP P001/P004/P005/P038/P043 considerado.
- **Núcleo enlazado:** [MCP-OCP · objeto canónico](MCP-METODOLOGIA.md), v0.1.19 al inicio de esta materialización.
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
- **MCP-NORMATIVO y Sink:** no activar MCP-NORMATIVO ni inferir los metadatos normativos faltantes. Las lecturas se documentan como inspección/fuente, no como verificación normativa automática.

## Orden de ejecución

| Orden | ID | Prioridad | Tarea | Estado | Condición principal de salida |
|---:|---|---|---|---|---|
| 1 | MCP-OCP-01 | P0 | Cerrar contrato de producto local y frontera OCP/Khora/Jules | VERIFICADO_EN_NUCLEO_V0.1.20 | Producto local stdio propiedad exclusiva OCP; Khora y puente Jules separados; decisión leída de vuelta. |
| 2 | MCP-OCP-02 | P0 | Reconciliar candidata 0.1.0 y actualizarla contra main vigente | COMPLETADA_LOCAL_NO_TRANSFERIDA | Rama local feature/mcp-ocp-local-mvp-0.1.0-20261106; pin DUG v377 y core v0.1.20; commit local 587a82d1…; no push. |
| 3 | MCP-OCP-03 | P0 | Construir candidata local renovada, ejecutar pruebas y emitir recibo | PASS_LOCAL_BUILD_50_30_200 | .NET 10.0.403; 50/50 unitarias; 30/30 integración; 200 componentes; ZIP SHA-256 37b85444…; recibo C-MCP-OCP-LOCAL-MVP-BUILD-20261106. |
| 4 | MCP-OCP-04 | P0 | Verificar ejecución local, transporte y perímetro | PASS_STDIO_RDC_SMOKE_NO_INSTALL | Ejecutable empaquetado inicializa, lista 10 tools, health READY y EOF exit 0 vía RDC; scan C# no encontró tipos listener; perfil normal no instalado. |
| 5 | MCP-OCP-05 | P0 | Verificar acceso a fuentes OCP/metodología y herramientas de desarrollo | PASS_TEST_ROOT_REAL_PROFILE_PENDING | Build smoke importó 2 fuentes, listó 43 principios y bloqueó metadatos incompletos; perfil normal del usuario aún no ha importado fuentes. |
| 6 | MCP-OCP-06 | P0 | Probar coexistencia ChatGPT/RDC: MCP-OCP local + puente Jules independiente | BLOQUEADO_PAUSA_MCP_JULES | No usar Jules hasta que el operador retome el frente; OAuth/listing autenticado/E2E no se han ejecutado. |
| 7 | MCP-OCP-07 | P1 | Entregar paquete preliminar y guía de uso para operador | PAQUETE_LOCAL_Y_RUNBOOK_VERIFICADOS | ZIP local SHA 37b85444…; runbook OPERACION-LOCAL-MCP-OCP.md y mcp-servers.example.json persistidos; no extracción/instalación en perfil definitivo aún. |
| 8 | MCP-OCP-08 | P1 | Definir y ejecutar handoff de instalación en EP | BLOQUEADO_DEPENDENCIA_EP | OEP aprueba destino, usuario, instalación, ACL, launcher, servicio/proceso y aceptación. |
| 9 | MCP-OCP-09 | P2 | Cerrar backup local y recuperación portable/cross-host | FIXTURES_PPR_PASS_CROSSHOST_BLOCKED | PPR incluye pruebas sintéticas dentro de 50/50; restore cross-host real sigue NOT_VERIFIED y bloqueado por P012/P013/host destino. |
| 10 | MCP-OCP-10 | P1 | Reconciliar recursos de gobernanza y evidencia de aceptación | PINS_Y_EVIDENCIA_VERIFICADOS | DUG/core pin fresh; recibo local de build y runbook con read-back; MCP-NORMATIVO sigue DESACTIVADO y Sink fuera de alcance. |
| 11 | MCP-OCP-11 | P1 | Ejecutar ciclo de desarrollo de prueba mediante Jules en un repositorio sandbox | BLOQUEADO_PAUSA_Y_OAUTH | Tareas documentales configuradas; el operador mantiene pausado el uso; sesión sandbox y OAuth aún no autorizados/ejecutados. |
| 12 | MCP-OCP-12 | P1 | Instalar y bootstrap del servidor en el perfil local definitivo | BLOQUEADO_CONSENTIMIENTO_OPERADOR | Extraer en ruta estable, importar fuentes en DB real y provisionar trust root solo tras consentimiento interactivo del operador. Separado de EP. |

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
