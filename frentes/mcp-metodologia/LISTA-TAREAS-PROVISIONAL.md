<!-- LIST_VERSION=0.1; LIST_STATUS=PROVISIONAL; NOT_A_CANONICAL_OBJECT=true -->
# Lista provisional de tareas · MCP-OCP

> **ESTADO: PROVISIONAL · NO ES UN OCP NI UN CONTROL ADICIONAL.** Esta lista es una vista auxiliar enlazada desde el único núcleo MCP-OCP. El estado vivo y las decisiones de alcance permanecen en `MCP-METODOLOGIA.md`; la titularidad permanece exclusivamente en `CONTROL-RESPONSABILIDAD.json`. Las tareas y dependencias de otros frentes se enlazan sin apropiarse de sus objetos, controles o permisos.

- **Frente:** MCP-OCP.
- **Repositorio propietario:** `SeryMente/metodologia`.
- **Ruta OCP:** `frentes/mcp-metodologia/`.
- **Versión de la lista:** 0.1 (provisional; primer desglose operativo del MVP local).
- **Última actualización:** 2026-11-06.
- **Gobierno leído:** Samantha v377 · NX-377m; Metacanon 1.28; GOW 2.17; DUG blob `54064c8fe00f872023a455f06596061ed69062ae`. §ARR consultado; cascada revisada manualmente; CNP P001/P004/P005/P038/P043 considerado.
- **Núcleo enlazado:** [MCP-OCP · objeto canónico](MCP-METODOLOGIA.md), v0.1.19 al inicio de esta materialización.
- **Control:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json), generación 5. Esta lista no modifica el control.
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
| 1 | MCP-OCP-01 | P0 | Cerrar contrato de producto local y frontera OCP/Khora/Jules | EN CURSO | Decisión escrita en núcleo y tareas; ningún servidor, secreto, control o herramienta duplicada. |
| 2 | MCP-OCP-02 | P0 | Reconciliar candidata 0.1.0 y actualizarla contra main vigente | PENDIENTE | Matriz de delta y rama de producto identificada; pins DUG/core actuales; código revisado. |
| 3 | MCP-OCP-03 | P0 | Construir candidata local renovada, ejecutar pruebas y emitir recibo | PENDIENTE | Build reproducible, unit/integration/smoke/security PASS con hashes y read-back. |
| 4 | MCP-OCP-04 | P0 | Verificar ejecución local, transporte y perímetro | PENDIENTE | stdio operativo; proceso termina limpiamente; ausencia de listener; loopback-only si se justifica HTTP local. |
| 5 | MCP-OCP-05 | P0 | Verificar acceso a fuentes OCP/metodología y herramientas de desarrollo | PENDIENTE | Lecturas reales no sensibles; controles fail-closed; pruebas de permisos y trazabilidad. |
| 6 | MCP-OCP-06 | P0 | Probar coexistencia ChatGPT/RDC: MCP-OCP local + puente Jules independiente | PENDIENTE | Flujo de lectura de OCP y listing Jules autenticado, sin duplicar servidor ni credenciales. |
| 7 | MCP-OCP-07 | P1 | Entregar paquete preliminar y guía de uso para operador | PENDIENTE | ZIP/artefactos con hashes, manifiesto, instalación local fuera de EP documentada y rollback. |
| 8 | MCP-OCP-08 | P1 | Definir y ejecutar handoff de instalación en EP | BLOQUEADO_DEPENDENCIA_EP | OEP aprueba destino, usuario, instalación, ACL, launcher, servicio/proceso y aceptación. |
| 9 | MCP-OCP-09 | P2 | Cerrar backup local y recuperación portable/cross-host | BLOQUEADO_P012_P013_Y_HOST_DESTINO | Revisión de seguridad/arquitectura y host destino; tests reales, no solo fixture. No bloquea el paquete preliminar sin backup portable. |
| 10 | MCP-OCP-10 | P1 | Reconciliar recursos de gobernanza y evidencia de aceptación | PENDIENTE | DUG actual consultado; fuentes y permisos declarados; no activar MCP-NORMATIVO; read-back completo. |
| 11 | MCP-OCP-11 | P1 | Ejecutar ciclo de desarrollo de prueba mediante Jules en un repositorio sandbox | BLOQUEADO_HASTA_MCP_JULES_03_06 | Sesión creada solo tras configuración, OAuth y confirmación de plan; PR revisable y pruebas verificadas. |

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
