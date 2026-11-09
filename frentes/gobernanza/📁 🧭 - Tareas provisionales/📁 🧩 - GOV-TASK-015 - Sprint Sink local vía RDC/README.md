# GOV-TASK-015 · Plan integrado del sprint Sink local vía RDC

**Naturaleza:** tarea provisional del frente Gobernanza; no es un frente independiente ni crea control, sesión o folio propio.  
**Estado de la tarea:** `en_curso` — planificación integrada persistida.  
**Estado del sprint:** `PLANIFICADO_CON_BLOQUEOS_DE_AUTORIZACIÓN_Y_HOST`; ninguna implementación de Sink ha comenzado en este ciclo.  
**Responsabilidad:** hereda el control de Gobernanza, generación 17.  
**Evento de planificación:** `C-GOBERNANZA-SINK-SPRINT-PLAN-01` (identificador local de evento; no es folio global).  
**Fuente rectora:** Samantha v384 · NX-384m; `SeryMente/metodologia/main`.

## 1. Resultado que debe entregar el sprint

Implementar y aceptar la consulta normativa local de dos capas mediante:

`IPZ → RDC → MCP-OCP local (stdio) → fuente DUG importada/cifrada → respuesta verificable`

Identificadores operativos:
- `GOW:ARR`: recuperar §ARR.
- `DUG`: verificar el documento fuente, su versión/firma/procedencia y el inventario completo de 43 IDs/MDP.
- `SINK:P001` … `SINK:P043`: recuperar únicamente el texto desarrollado del principio solicitado, con su procedencia y huella individual.

La respuesta no debe entregar los 43 textos desarrollados como catálogo inicial. Un MDP solo orienta la detección de pertinencia; no sustituye la consulta Sink obligatoria antes de aplicar un principio pertinente. La frecuencia mide recuperación/acceso registrado, no lectura consciente ni aplicación.

## 2. Arquitectura y límites congelados para este sprint

**Incluido**
- Proceso MCP-OCP local por stdio, invocado/administrado desde RDC.
- Consulta puntual y agrupada de principios, manteniendo un resultado, huella y evento de frecuencia por principio.
- Catálogo de 43 IDs/nombres/MDP y recuperación del texto desarrollado exacto.
- Pin de DUG (versión, firma, commit, blob SHA y SHA-256 del archivo) y SHA-256 de cada texto devuelto.
- Manifiesto exacto y ordenado del conjunto solicitado y su hash reproducible.
- Validación fail-closed ante IDs desconocidos, fuente no importada/obsoleta, integridad inválida, proceso no disponible o respuesta incompleta.
- Pruebas unitarias, de contrato, negativas, integración stdio/RDC, build reproducible, paquete y recibo.
- Instalación únicamente en perfil/host aceptado por EP y por el operador.

**Excluido**
- Endpoints HTTP, listeners LAN/públicos, túneles, Cloudflare, Vercel o DNS.
- MOD-SYNC, enlaces cortos HTTP, `sync_bundle` de OCPMSP y Sink público.
- Backblaze B2, backup portable/cross-host y restore MCP-OCP-09.
- Jules/OAuth, Khora y cualquier secreto de esos productos.
- Activación de `MCP-NORMATIVO` o inferencia de metadatos de selección ausentes.
- Activación FOL1 por inferencia. FOL1 solo se considerará en un corte separado, después del read-back de la IPZ nativa y con su compuerta correspondiente.

## 3. Tareas seleccionadas por frente

### A. Gobernanza — contrato, integración y aceptación

| Tarea provisional | Papel en el sprint | Entregable / condición de salida |
|---|---|---|
| GOV-TASK-015 (esta tarea) | Plan integrado, dependencias, secuencia, control de bloqueos y aceptación trilateral | Respuestas/compromisos de MCP-OCP y EP, plan ejecutable y matriz de aceptación cerrada |
| GOV-TASK-008 | Contrato de dos capas y consulta Sink | Respuesta individual, procedencia, frecuencia y manifiesto coherentes con ART-027 |
| GOV-TASK-001 | Calidad semántica del catálogo | 43 MDP validados estructuralmente (11–16 palabras) y semánticamente; no se confunde con aplicación |
| GOV-TASK-009 | Validación de §ARR | `GOW:ARR` devuelve vocabulario inicial correcto y compatible con DUG |
| GOV-TASK-010 | Admisión fail-closed | Frente/control/titularidad/generación/autorización/exclusividad y rechazo de trabajo sustantivo fuera del frente |
| GOV-TASK-007 | Preparación final de IPZ | Texto completo menor a 1.500 caracteres en UTF-16 y puntos de código; conserva todas las salvaguardas de v0.7; instalación nativa y read-back en fase final |
| GOV-TASK-003 | Aceptación E2E | Flujo real desde ChatGPT/IPZ por RDC, pruebas positivas/negativas, hashes y fallo cerrado |
| GOV-TASK-013 | Medición de resolución | Medición específica `ipz.resolve.rdc.duration_ms`, expresamente delimitada en esa tarea; mínimo 10 resoluciones completas para línea base preliminar; no se añaden KPIs genéricos |
| GOV-TASK-011 | DTC trilateral | Cada frente conserva su propio control y objeto; apertura, respuesta, procesamiento, cierre y read-back trazables |

**No se reabren** GOV-TASK-002 (cancelada), GOV-TASK-004, GOV-TASK-005, GOV-TASK-006, GOV-TASK-012 ni GOV-TASK-014 como dependencias de construcción del MVP. Backblaze, la incubación de Tareas y la reconciliación general no deben bloquear este sprint.

### B. MCP-OCP — implementación y paquete

Titular observado: generación 5 · sesión `SES-20261106-CDF82783`. Control: `1fcf4178d58b39cecc3028c92493932b2ca7ab60`.

| Tarea provisional existente | Trabajo dentro del sprint | Condición de salida |
|---|---|---|
| MCP-OCP-02 | Reconciliar candidata local con main; verificar branch/worktree y resolver discrepancias entre tabla ejecutiva y fichas | Base de código, branch, pin y estado del artefacto identificados sin reutilizar recibos históricos como prueba actual |
| MCP-OCP-05 | Extender herramientas de fuentes para `GOW:ARR`, `DUG` y `SINK:Pxxx` | Contratos de respuesta e integridad implementados; no se exponen 43 textos en el catálogo |
| MCP-OCP-03 | Build y suite renovada | Build nuevo contra DUG v384 y core vigente; unitarias, contrato, negativos, integración stdio, seguridad y hashes PASS |
| MCP-OCP-04 | Perímetro y ejecución RDC | `initialize`, `tools/list`, `tools/call`, shutdown y respuesta real por stdio/RDC; sin listener público |
| MCP-OCP-10 | Pines y recibo | Manifest con commits/blobs/SHA-256, SDK/RID, pruebas, tamaño del paquete y limitaciones; read-back |
| MCP-OCP-07 | Paquete y runbook | ZIP verificado, instrucciones de arranque/parada, importación, rollback y diagnóstico |
| MCP-OCP-12 | Bootstrap del perfil definitivo | ZIP verificado, importación cifrada con DPAPI CurrentUser y consentimiento interactivo del operador para `REGISTER <SID>` |
| MCP-OCP-08 | Handoff de instalación a EP | Paquete, pin, ACL/rutas/startup/rollback y criterios de aceptación entregados; EP ejecuta la instalación |

**Subhito obligatorio de MCP-OCP-05:** implementar recuperación de §ARR, manifest del DUG y texto desarrollado individual. La invocación agrupada debe conservar el orden pedido y producir resultado/huella/evento individual por principio. Para evitar proliferar IDs, se recomienda mantenerlo como subhito de MCP-OCP-05; el titular puede crear un ID nuevo solo si su registro lo exige.

**Gate de autoridad:** el control vigente excluye explícitamente Sink productivo. Antes de modificar código para esta función, el titular MCP-OCP debe registrar una ampliación expresa y acotada del control, limitada a Sink local por stdio dentro de `frentes/mcp-metodologia/`, pruebas, build, paquete y documentación. No incluye DUG/IPZ, host EP, credenciales externas, B2, exposición pública, Khora ni activación normativa.

**Reconciliación obligatoria:** la tabla de LISTA-TAREAS-PROVISIONAL.md declara PASS históricos mientras algunas fichas detalladas siguen PENDIENTE. MCP-OCP-02 debe reconciliar la tabla con las fichas y distinguir `PASS_HISTORICO`, `VERIFICADO_CON_PIN_ACTUAL`, `PENDIENTE` y `BLOQUEADO`. La candidata/paquete histórica fija DUG v377 y core v0.1.20; no acredita v384/core actual.

### C. Entorno Persistente (EP) — custodia, perfil e instalación

Titular observado: generación 3 · sesión `SES-20261109-E032FC60`. OEP observado: §114 y estado de trabajo v0.3.46.

| Tarea provisional | Trabajo del sprint | Condición de salida |
|---|---|---|
| EP-TASK-003 | Resolver seguridad del workspace y preparar perfil local aceptado | RecoveryPassword rotado sin salida del secreto; guardado en EP Vault con read-back en memoria; protector potencialmente expuesto retirado; metadatos BitLocker XTS-AES256/On/100%; migración por hashes completada |
| EP-TASK-003 / nuevo subhito de handoff (propuesto) | Instalar/arrancar MCP-OCP en el perfil de ejecución aceptado y probar acceso RDC | Perfil, ruta, ACL, usuario, launcher, logs redactados, shutdown y rollback verificados |
| EP-TASK-004 | Solo la función mínima de EP Vault requerida para custodiar el protector de recuperación | No implica rediseño de GUI, ni cierre global de la bóveda |
| MCP-OCP-08 (dependencia externa a EP) | Recibir paquete y contrato desde MCP-OCP | Handoff documentado, pins cotejados y criterios de instalación aceptados por EP |

**Necesidad de formalización:** EP no tiene una tarea provisional dedicada al handoff/instalación de MCP-OCP. Se recomienda que su titular cree `EP-TASK-005 — Instalación y aceptación local de MCP-OCP`, o incorpore formalmente un subhito equivalente en EP-TASK-003. Este plan no crea ni modifica tareas dentro del OEP ajeno.

**No incluido:** EP-TASK-001/NCL y EP-TASK-002/Backblaze. El dead-man trigger de EP-TASK-003 no se puede omitir si el host elegido es `LOC-OTHER`; se puede evitar esa dependencia escogiendo un host de confianza en `LOC-CECEQ` que cumpla la política ya documentada. La clasificación de PC-14 como cibercafé/LOC-OTHER permanece vigente hasta una rectificación explícita del operador.

## 4. Secuencia optimizada y paralelismo

| Fase | Gobernanza | MCP-OCP | EP | Dependencia que desbloquea |
|---|---|---|---|---|
| 0 · Decisión de arranque | Congelar contrato, límites y pruebas | Titular registra ampliación de alcance | Titular confirma perfil/host y gates | Autorizaciones y host definidos |
| 1 · Preparación en paralelo | Congelar fixture MDP/ART-027 y matriz | MCP-OCP-02/05; PoC stdio/RDC con un principio | Resolver protector y perfil protegido | PoC posible y datos custodiados |
| 2 · Construcción | Preparar pruebas de aceptación | MCP-OCP-03/04/10: implementar, build, probar y manifestar | Preparar launcher/ACL/rollback, sin instalar aún | Artefacto reproducible PASS |
| 3 · Bootstrap/handoff | Verificar pins y checklist | MCP-OCP-07/12/08: ZIP, importación y transferencia | Instalar en perfil aprobado; read-back | Instancia real ejecutable |
| 4 · Aceptación | GOV-TASK-003/001/009/010 y GOV-TASK-013 | Corregir defectos del resolver | Prueba de ciclo de vida/rollback | E2E PASS y evidencia |
| 5 · Cierre | Presentar texto IPZ y hacer read-back nativo; FOL1 queda como gate separado | Read-back final del artefacto | Read-back final del perfil instalado | Aceptación del operador |

La preparación de código y la custodia del host pueden avanzar en paralelo después de la fase 0. La instalación se serializa después del build; la prueba E2E después de la instalación. No esperar a Backblaze, Jules ni restore cross-host.

## 5. Contrato técnico mínimo para que las tareas sean ejecutables

### Respuestas
- `GOW:ARR`: contenido de §ARR, revisión y pin de DUG.
- `DUG`: versión/firma, commit/blob, SHA-256 del archivo, conteos (43 principios/22 anexos) y catálogo 43 IDs/MDP. No entregar automáticamente el cuerpo HTML de ~1 MB al modelo.
- `SINK:Pxxx`: ID/título, texto desarrollado íntegro del principio, versión/firma/commit/blob del DUG y SHA-256 del texto.
- Lote: arreglo ordenado de IDs y respuestas por principio; un evento de frecuencia por cada recuperación completa exitosa.

### Manifiesto
Incluye exactamente el orden solicitado, ID, pin de DUG y SHA-256 individual de cada texto. El hash del paquete se calcula sobre serialización canónica UTF-8. Un hash de la lista de IDs por sí solo no es suficiente.

### Fallo cerrado
ID desconocido, fuente no importada/obsoleta, firma/blob/hash discordante, texto ausente, RDC sin respuesta, proceso equivocado o resultado parcial ⇒ `METODOLOGÍA NO VERIFICADA`; no aplicar el principio ni sustituir la lectura por memoria/MDP.

### Telemetría
- ART-027: solo frecuencia de consulta por principio; nunca inferir aplicación o comprensión.
- GOV-TASK-013: `ipz.resolve.rdc.duration_ms`, medición de resolución completa iniciada desde IPZ por RDC, bajo su alcance específico ya aprobado. No añadir métricas por herramienta ni retrasar la entrega para persistir el evento.

## 6. Pruebas de aceptación obligatorias

1. `GOW:ARR` recupera §ARR y su hash coincide con la fuente fijada.
2. `DUG` identifica exactamente v384/NX-384m y el commit/blob/SHA-256 del artefacto importado; el catálogo contiene los 43 IDs y MDP.
3. Todos los 43 `SINK:Pxxx` devuelven el texto exacto correspondiente a ese ID (prueba masiva contra el DUG fijado); no hay intercambio ni contaminación entre principios.
4. Casos de muestra en una sesión real: P001, P004, P005, P038 y P043; cada respuesta coincide con la fuente humana/renderizada y con la proyección estructurada.
5. Recuperación agrupada: orden preservado, texto separado por ID, SHA individual, un evento de frecuencia por cada item exitoso.
6. Negativos: ID inexistente, DUG viejo, blob/hash alterado, fuente no importada, registro corrupto, proceso desconectado, JSON-RPC parcial y respuesta sin texto.
7. El transporte real ChatGPT→RDC→proceso stdio queda probado con `initialize`, `tools/list` y `tools/call`; no basta el smoke local aislado.
8. Sin listener público, sin URL HTTP, sin token/secretos en argumentos, logs, repositorio ni respuesta.
9. La herramienta no activa `MCP-NORMATIVO` ni completa metadatos ausentes.
10. La latencia se registra solo con ambos extremos observables y reloj monotónico; al menos diez muestras completas para una línea base preliminar, sin objetivo temporal arbitrario.
11. Host instalado tiene bootstrap, estado, arranque, parada, rollback y permisos verificados; read-back del artefacto/paquete y perfil.
12. La IPZ final mide menos de 1.500 caracteres (UTF-16 y puntos de código), conserva las seis distinciones de estado y salvaguardas de v0.7; el campo nativo se modifica y lee de vuelta solo en la fase autorizada final. FOL1 no se activa antes.

## 7. Obstáculos y tratamiento preventivo

| Riesgo/bloqueo | Evidencia actual | Mitigación / regla de parada |
|---|---|---|
| MCP-OCP no autorizado para Sink | Control gen5 excluye Sink productivo | No tocar código Sink hasta que el titular amplíe el control con el scope local acotado |
| Estado MCP contradictorio | Tabla ejecutiva vs fichas de LISTA-TAREAS-PROVISIONAL.md no concuerdan | Resolver en MCP-OCP-02 antes de dar PASS actuales |
| Código candidato no transferido | Candidata local 0.1.0 y ZIP están en PC10; branch histórica no se publicó en GitHub | Confirmar branch/worktree/HEAD/dirty state y preservar la fuente; no reconstruir ni reemplazar hasta saber qué existe |
| Pins antiguos | Recibo histórico usa DUG v377/core v0.1.20; actual DUG v384/core v0.1.21 | Rebuild completo, nuevos tests y recibo con pins actuales |
| RecoveryPassword potencialmente expuesto | OEP §114; write/read-back en EP Vault no ejecutado | Rotar con stdout/logs suprimidos, guardar/read-back en memoria y retirar protector viejo después de validar el nuevo |
| Host PC-14 no confiable para persistencia | PC-14 está clasificado `LOC-OTHER` (cibercafé); dead-man no verificado | Preferir host de confianza/CECEQ. Si PC-14 es obligatorio, dead-man LOC-OTHER debe ser parte del gate previo |
| GitHub privado sin autenticación local | PC-14 `gh auth status` previamente sin sesión; el perfil destino no ha importado fuentes reales | Login interactivo del propio usuario Windows, sin copiar ni revelar tokens; importar solo tras validar host |
| Bootstrap del operador | MCP-OCP-12 exige `REGISTER <SID>` local | El operador confirma en consola; nunca automatizar ni enviar por pipe |
| RDC/stdio no conectado al cliente | El runbook prueba stdio local/RDC, pero la aceptación debe usar el mismo flujo que invocará el IPZ | Spike de protocolo al principio y prueba ChatGPT→RDC; si el cliente no recibe herramientas/resultados, detener y corregir el bridge antes de desplegar 43 aliases |
| FOL1 prematuro | Sigue PREPARADO_PENDIENTE_ACTIVACION_IPZ | Read-back de IPZ nativa primero; FOL1 en gate separado |

## 8. Insumos y decisiones del operador

Bloqueantes antes de iniciar la implementación:
1. **Host de ejecución definitivo:** confirmar un equipo/perfil Windows de confianza y su ubicación `LOC-CECEQ` o `LOC-OTHER`. PC-14 figura como cibercafé/LOC-OTHER; no recomiendo instalar allí el proceso persistente mientras el dead-man siga sin verificar. 015RENTA01 aparece Offline en la última consulta RDC; su disponibilidad no se presume. PC10 está Online, pero no se ha aprobado como host EP.
2. **Alcance MCP-OCP:** autorizar que el titular de generación 5 amplíe el control a implementar Sink local por stdio dentro de `frentes/mcp-metodologia/`, pruebas/build/package y documentación, sin endpoint público ni modificaciones de host EP/credenciales/B2/DUG/IPZ/MCP-NORMATIVO/Khora.
3. **Autenticación GitHub en el perfil elegido:** autorizar login local interactivo del usuario Windows propietario para clonar/importar la fuente privada. No compartir token ni contraseña en ChatGPT.
4. **Presencia local y EP Vault:** confirmar que el operador podrá introducir los secretos directamente en la consola local y ejecutar el registro del recovery protector/consentimiento `REGISTER <SID>`, sin mostrar el valor a RDC stdout/logs/chat.
5. **IPZ final:** revisar y aceptar el texto final en conversación antes de instalarlo en el campo nativo. El contenido candidato no se guarda como archivo en Git.

No se requieren credenciales B2, dominio, DNS, proveedor cloud, cuenta Cloudflare, GitHub Actions ni sesión Jules para este sprint.

## 9. Criterios de no inicio / suspensión

No iniciar implementación Sink si:
- el titular MCP-OCP no ha actualizado/autorizado su alcance;
- no se conoce el host/perfil de ejecución seguro;
- la fuente/candidata de código local no se puede recuperar con integridad;
- la prueba de transporte RDC/stdin/stdout no puede ejecutarse sin exposición pública;
- se necesita compartir credenciales/secreto por chat, logs o portapapeles.

Detener únicamente el tramo dependiente, no la preparación independiente autorizada. No borrar el workspace original ni el VHDX. No declarar aceptación por build, ZIP, health READY o lectura de un archivo sin la prueba E2E.

## 10. Estado y siguiente transición

**Plan integrado:** preparado y persistido por Gobernanza.  
**Tareas de Gobernanza:** identificadas; GOV-TASK-015 registra la coordinación y aceptación.  
**Tareas MCP-OCP:** seleccionadas; implementación Sink bloqueada hasta autorización del titular y reconciliación de tareas.  
**Tareas EP:** seleccionadas; preparación del host bloqueada por custodia del protector y selección de host/perfil; la tarea dedicada de handoff debe ser materializada por EP.  
**Código Sink:** NO INICIADO.  
**Instalación:** NO INICIADA.  
**Prueba E2E:** NO EJECUTADA.  
**FOL1 / MCP-NORMATIVO:** no activados.

La siguiente transición es recibir del operador la elección del host/perfil y autorización de alcance MCP-OCP; luego Gobernanza registra una solicitud DTC única a cada frente en sus objetos existentes y espera respuestas de sus titulares antes de abrir la fase de ejecución.
