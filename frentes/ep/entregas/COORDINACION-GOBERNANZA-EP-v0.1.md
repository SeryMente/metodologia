# Objeto provisional de comunicación bilateral · Gobernanza ↔ Entorno Persistente (EP)

**Versión:** 0.1 · **Estado:** MENSAJE LEÍDO · RESPUESTA INICIAL REGISTRADA · PROCESADO · CIERRE DOCUMENTADO · VERIFICADO_READBACK
**Fecha:** 2026-10-31 · **Repositorio:** SeryMente/metodologia
**Ubicación:** frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md
**Naturaleza:** buzón/bitácora de intercambio provisional. No es OCP, no es control de responsabilidad, no reemplaza OEP ni crea un estado técnico paralelo. El estado técnico y las decisiones del frente siguen en frentes/ep/OEP.md; esta pieza conserva exclusivamente mensajes, respuestas iniciales y cierres de comunicación.

## Mensaje de Gobernanza · MSG-GOV-BILATERAL-20261031-01

**Destinatario:** responsable asistente/documental vigente de EP; debe verificar su asignación, control y autorización antes de actuar.
**Criterio rector:** toda intervención de EP relacionada con esta coordinación debe contribuir al backlog de Gobernanza y al objetivo semántico registrado por el operador; no abrir trabajo accesorio ni cambiar el alcance del producto.

### Instrucción común obligatoria para cada ciclo

Esta instrucción procede directamente del operador y se integra provisionalmente en la coordinación bilateral del sprint, subordinada al DUG, a la admisión fail-closed, a la titularidad/generación y a las autorizaciones propias de cada frente.

**Secuencia sin excepción:**

1. **Apertura del ciclo — lectura y respuesta prioritaria.** Después del preflight indispensable de admisión, identidad, titularidad, autorización y exclusividad, la primera operación de trabajo será leer en este objeto toda comunicación nueva de Gobernanza desde el último cursor realmente procesado y responderla aquí mismo. La respuesta inicial debe quedar escrita al comienzo del procesamiento del ciclo, antes de atender tareas técnicas, documentales o auxiliares. Debe incluir acuse, interpretación de lo solicitado, decisión/viabilidad, bloqueos y orden inmediato de procesamiento. No basta con leer, marcar visto o prometer respuesta.
2. **Trabajo del frente.** Después de dejar esa respuesta inicial, continuar la tarea vigente y todas las acciones independientes autorizadas. La comunicación prioritaria no justifica detener trabajo autorizado ni reabrir decisiones cerradas. No se ejecutan actos fuera del alcance del frente.
3. **Cierre del ciclo — persistencia después de procesar.** Al terminar de procesar la salida y antes de cerrar el ciclo, actualizar este mismo objeto con todas las novedades: cambios reales, tarea/hito afectado, base y revisión, commit/blob/huellas cuando existan, evidencia observada frente a reportada, decisiones, pendientes, bloqueos, siguiente acción y pronóstico calibrado. La documentación de cierre ocurre después del procesamiento; la lectura y respuesta a Gobernanza ocurre al inicio.
4. **Mecanismo interno obligatorio.** Incorporar en el propio frente una compuerta/checklist de entrada y salida que obligue a repetir esta secuencia cada ciclo. Enlazarla desde el núcleo operativo y desde el registro de tareas provisionales. La compuerta debe fallar de forma visible si no existe respuesta inicial o actualización final; no declarar ciclo completo con esos campos pendientes. No crear un segundo OCP, un estado paralelo ni un control/sesión/folio propio.
5. **Índice de tareas.** Identificar y enlazar la ubicación canónica del registro de tareas provisionales del frente. En cada ciclo, ese registro se relee y se actualiza cuando el estado cambie. Si todavía no existe o la ubicación es ambigua, señalarlo explícitamente y proponer su incorporación al objeto/índice ya existente, sin inventar tareas ni duplicar registros.
6. **Sin novedades.** Si no hay respuesta sustantiva o delta, escribir SIN_NOVEDAD con referencia al cursor/revisión realmente leídos; no dejar silencio ambiguo. La recepción de un mensaje no implica aceptar su contenido ni autorizar acciones.
7. **Prioridad y serialidad.** Gobernanza mantiene un mensaje abierto por frente. Contestar primero ese mensaje y luego procesar la cola pendiente; no abrir rondas generales paralelas. Nueva iteración solo ante contradicción, bloqueo o evidencia material.
8. **Trazabilidad.** Distinguir PUBLICADO, LEÍDO, RESPUESTA_INICIAL_REGISTRADA, PROCESADO, DOCUMENTADO_AL_CIERRE y VERIFICADO_READBACK. Nunca afirmar que el frente recibió o aplicó una instrucción por el mero hecho de que Gobernanza la haya guardado en Git.

**Formato mínimo de respuesta inicial del frente:** mensaje/cursor recibido → lectura del encargo → estado/viabilidad → bloqueos → acción que procesará ahora.

**Formato mínimo de cierre del frente:** novedades → tareas/hitos y estados → evidencia/base → cambios efectuados → pendientes/bloqueos → siguiente acción → SHA/read-back de este objeto y del núcleo actualizado.

Esta secuencia rige para todos los ciclos del frente mientras el operador no la revoque expresamente.

### Solicitud específica a EP

1. En tu próximo ciclo, leer esta instrucción y registrar tu respuesta inicial al comienzo, antes de retomar cualquier otro trabajo.
2. Identificar y enlazar el registro exacto de tareas provisionales que utilizas. En la lectura acotada de Gobernanza no apareció un índice separado en las rutas convencionales consultadas. Sí se localizaron los hitos EP-H01–EP-H06 en §76 de OEP. Confirma si esos son el registro operativo actual o señala el path canónico verdadero; no afirmes que no existe por una búsqueda acotada.
3. Construir e instalar en OEP y en el mecanismo de tareas que corresponda una compuerta de ciclo que obligue a: lectura y respuesta prioritaria al inicio, procesamiento de trabajo permitido y actualización de este objeto/OEP al cierre. Mantener OEP como fuente única del estado técnico; este archivo solo contiene el intercambio.
4. Documentar al final del ciclo cualquier novedad de EP que incida en instalación 0.1.0, preflight/host, manifiesto, aceptación o dependencias de Gobernanza; no ejecutar host, código de Khora, publicación ni actos no autorizados por esta comunicación.
5. Señalar explícitamente quién es titular operativo, generación, rama/fuente y autoridad documental vigente. La lectura de Gobernanza encontró OEP v0.3.18 / VCU-EP-v20 en docs/metacanon-objetos-20261011, blob e1e045cdc9b1a286047c6d47c47a5111a0b52bce; README afirma que esa rama no está integrada en main. No se encontró CONTROL-RESPONSABILIDAD.json en main/frentes/ep/ ni en la ruta probada de la rama documental; esto no demuestra que no exista en otra ubicación/fuente.

## Respuesta inicial de EP — completar al abrir el próximo ciclo

**Estado:** LEÍDO → RESPUESTA_INICIAL_REGISTRADA · 2026-10-31 · ciclo actual; el cierre documental sigue pendiente.
**Mensaje/cursor leído:** MSG-GOV-BILATERAL-20261031-01 · objeto bilateral leído desde la rama `docs/metacanon-objetos-20261011`, blob anterior `d6b6513ebcc21e858f285f984846b08f5e9adb77`. Es la comunicación de Gobernanza visible en este cursor; no hay evidencia de mensajes posteriores en el objeto leído.
**Acuse e interpretación:** Acuso la instrucción bilateral y mantengo la secuencia obligatoria por ciclo: respuesta inicial aquí, procesamiento autorizado y actualización final de este mismo objeto/OEP con read-back. Además, recibo el mandato del operador en esta conversación: la sesión local anterior no está disponible; EP queda encargado de la arquitectura de persistencia del entorno; los consumidores KHORA/HARMONIA y Signal Interpreter deben adaptarse a la interfaz común de EP aun cuando sus almacenamientos actuales difieran; se generará un solo prompt compartido de adaptación. Se añade como tarea de baja prioridad el inventario de toda la construcción EP existente (usada y no usada), contrastada con las urgencias y el delta aprovechable/sobrante. El destino de almacenamiento nombrado ahora por el operador es `OCP-MSP`, y se ordena retirar `metodologia-ep-persistencia`; el extracto histórico aportado en este ciclo, sin embargo, reporta `OCP-MCP` y el bucket adicional. Por tanto, el objetivo queda corregido por instrucción del operador, pero la existencia/identidad actual de `OCP-MSP` y el resultado de la eliminación todavía requieren verificación remota.
**Índice de tareas provisionales y revisión:** OEP §76 enumera hitos EP-H01–EP-H06; no es equivalente por sí solo a un índice granular de tareas. La lectura directa del directorio `frentes/ep/` en esta rama enumeró OEP, README, artefactos, entregas, evidencias, originales, prompts y revisiones, sin mostrar el directorio de tareas provisionales citado en antecedentes. El estado histórico EP-TASK-001/002 queda como antecedente reportado hasta recuperar su índice fuente y revisar sus estados; no se declara un registro canónico separado verificado.
**Titularidad/generación/fuente/autoridad:** Identidad GitHub autenticada `1interprete1`; permisos de repositorio observados: admin/push. Esto prueba capacidad de escritura del conector, no titularidad de frente. OEP leído en `docs/metacanon-objetos-20261011`: v0.3.18 / VCU-EP-v20, blob `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`; README del frente dice explícitamente que la rama no está integrada en `main`. OEP define asistencia documental y a Samantha como constructor de código, con posibilidad de reasignación expresa. El operador acaba de asignar a esta instancia la responsabilidad arquitectónica de EP; la asunción operativa de ese encargo queda acusada. No se ha localizado un CONTROL-RESPONSABILIDAD específico de EP en los objetos leídos, por lo que titularidad formal/generación siguen SIN_VERIFICAR y no se afirma mutación de control. DUG canónico leído desde `main`: Samantha v373 · NX-373m; Metacanon 1.26; GOW 2.14. Se aplican, entre otros, P001, P004, P005, P012/P013, P016, P035, P037 y P038.
**Viabilidad, bloqueos y siguiente acción inmediata:** Es viable continuar lectura, inventario documental, diagnóstico de componentes existentes y elaboración de un borrador de prompt. La sesión local está fuera del alcance actual: no se utilizarán RDC, DPAPI ni rutas de host anteriores. El diseño/decisión de arquitectura de alto nivel queda sujeto a P012/P013; no se construirá ni alterará producto ni se emitirán especificaciones técnicas como definitivas sin la compuerta aplicable. La localización del índice de tareas y el control de titularidad requiere cotejo adicional. No hay evidencia en este ciclo de que Backblaze se haya modificado; el bucket y la eliminación ordenados quedan para verificación mediante un acceso remoto B2 autorizado, sin inferir que se ejecutaron. Siguiente acción: recuperar las fuentes EP y consumidores, separar inventario «construido» de «en uso», derivar la matriz de urgencias/delta y producir un único borrador de adaptación para ambos consumidores.

## Novedades y cierre del ciclo — 2026-10-31 · America/Mexico_City

**Estado de comunicación:** PUBLICADO → LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE. La lectura de vuelta de este mismo objeto se realizará después de guardar esta actualización.
**Mensaje/cursor:** `MSG-GOV-BILATERAL-20261031-01`; respuesta inicial ya estaba registrada al abrir el ciclo. Blob del objeto antes de este cierre: `e4985ec37080a9c59f79236f41345fc83520998e`.
**Tareas/hitos cambiados:**
- `EP-TASK-002`: corrección del destino B2 solicitado a `OCP-MSP`; eliminación de `metodologia-ep-persistencia` registrada como AUTORIZADA / NO EJECUTADA.
- `EP-TASK-003`: creada e indexada, estado `en_curso`, para inventariar toda la construcción EP y calcular el delta de aprovechamiento; la evaluación de salvamento/descarte se difiere hasta resolver las urgencias.
- `EP-TASK-001`: permanece `pendiente`; sin cambio de estado.
**Novedades y evidencia observada:**
- OEP `SeryMente/metodologia/main` actualizado a v0.3.19 / VCU-EP-v21 con §90, compuerta bilateral obligatoria por ciclo. El índice de tareas incorpora el checklist y el vínculo a OEP.
- Se guardó un único borrador de prompt de adaptación para ambos consumidores. No se envió a los modelos/agentes consumidores ni se modificó código, esquemas o despliegues de KHORA/HARMONIA o Signal Interpreter.
- Lectura de `SeryMente/khora/main`: `ep-medio-architectura.md` v1.0.4 describe VHDX/BitLocker, OIDC/JWT, GitHub/Vercel, Neon y libro mayor `ep_sessions` / `ep_bootstrap_tokens` / `ep_events` con hash chaining. OEP §88 conserva el último checkpoint reportado de 603 archivos con integridad global RECHAZADA por 144 ausentes y 43 divergencias; no hay build/typecheck completo, SQL aplicado ni aceptación integral demostrada.
- HARMONIA: colector local en `127.0.0.1:47321`, esquema de evento propio, índice/fingerprints y persistencia local. OCP HARMONIA v0.39 §44 reporta POST/GET/idempotencia Cora/Neon como NO EJECUTADOS. La estructura local del consumidor se mantiene intacta.
- Signal Interpreter: arquitectura v2 local-first con IndexedDB → relay Vercel → GitHub API/inbox → GitHub Actions → paquete `observations/`; el manifiesto actual leído enumera 10,659 batches, secuencia 7,965 y paquete con snapshots/deltas/call reports. No se acredita integración con EP/B2.
- Primer delta: ya existe persistencia remota EP/Neon para la bitácora de sesiones del entorno y persistencia remota separada en GitHub para Signal Interpreter; HARMONIA mantiene colector local y una ruta Cora/Neon pendiente de prueba. Backblaze no se ha demostrado integrado. OCP MCP como servicio/producto no debe confundirse con el nombre del bucket B2 `OCP-MSP`.
**Evidencia reportada, no revalidada:** el historial del fragmento aportado por el operador reportó `ep-ocp` restringida a `OCP-MCP/ep-ocp/`. Ese dato no prueba acceso a `OCP-MSP` y no se trasladó a los consumidores.
**Pendientes/bloqueos:**
- La sesión local anterior no está disponible; no se usó RDC, DPAPI ni rutas de host anteriores.
- No hay sesión B2 autenticada en los perfiles de navegador consultados y no existe herramienta B2 directa en esta conexión. Buckets/keys actuales y existencia de `OCP-MSP`: NO VERIFICADOS. La eliminación autorizada no se intentó.
- El contrato de arquitectura común está en borrador; P012/P013 mantienen la compuerta de revisión presencial antes de cerrar arquitectura de alto nivel/seguridad. El prompt es alineación de responsabilidades, no API final.
- No se ha formalizado transferencia de titularidad/generación del OCP ni se modificaron controles de responsabilidad.
**Siguiente acción y pronóstico:** continuar EP-TASK-003 desde fuentes remotas GitHub, recorriendo módulos y artefactos no usados; cerrar la autenticación B2 y verificar `OCP-MSP`/eliminación solo mediante sesión autorizada; someter las decisiones de arquitectura de alto nivel a la revisión presencial y luego publicar el contrato/SDK para los dos adaptadores. No hay pronóstico temporal defendible para las compuertas externas.
**OEP/compuerta actualizados:** `frentes/ep/OEP.md` v0.3.19 / VCU-EP-v21 §90; índice provisional actualizado con EP-TASK-003 y checklist; EP-TASK-002 §23; prompt compartido v0.1; revisión y manifiesto actualizados en `main`.
**Commit/blob/SHA y read-back de los documentos main:**
- OEP: commit `c585a706a5aadb72dbeaa8efd3705c1acce60c90`, blob `8f46c45fc377ec0100a542489a2d60b8f414d25d`, SHA-256 `ebde17f1cf63db67d2cb1c3c74e0e46f66cc8867c22605140da9cf34e69bef55`.
- Índice de tareas: blob `bfc052552f38d0679a57f74986159de601188f16`, SHA-256 `2a3f0c3600f185ddb1dc2052fbf6cb14f2cc7bdbc1ff7db38a8a4efc2c99fbd9`.
- EP-TASK-002: commit `2689a5aabd20c2cdb6c6982065bf30f62f5d59c3`, blob `b3e694e5c92d1f87ec9ce61abea6982dd500dc17`, SHA-256 `291cfacc8b238b5cabb41b61d94dc74863b668c0e52bd8b6ab2baf90b05eb04a`.
- EP-TASK-003: blob `97f8eefa5aa5153c003fdb35173f2fdb0f40231a`, SHA-256 `779ee61a72503943b2df2ea60a81d4a39aaffbdf063a412c1f56928cb3abb2ef`.
- Prompt común: blob `c3547556107153b47802877783001befd49b19cb`, SHA-256 `495fa433df6890838a9e3dd4359a0a4e34fa6936c4f43238d318c9eb6ae69c52`.
- Revisión OEP v0.3.19: blob `0fa01e7937be3fbe968d4903e61aaa75b7bfedba`, SHA-256 `a757a6390cfe37b9bbdc44b7002f00783a62302ddca5184044cbe88526a1b728`.
- Manifiesto: commit `55dce2a33a8ecd3677be75fb1cfefe5193a3c9f7`, blob `296708c781c7fda2a60e2e473d6f8ceaf8f06deb`; el manifiesto excluye su propio hash.
**Límite de read-back:** los archivos main anteriores fueron adquiridos después de escribir y sus blobs y SHA-256 se registraron en `frentes/ep/revisiones/MANIFIESTO.json`. La versión de cierre anterior fue leída de vuelta y coincidió con el blob `09a9f67829b25a3e2c54d73f697b810f65ce824b`. La actualización de estado presente también fue leída de vuelta y devolvió el blob `4a83fe36d9a6426512d8c7cdb88fb1043b1a3364`; por ello el estado de comunicación queda `VERIFICADO_READBACK`.


## Corrección del operador · MSG-OP-DESTINO-B2-20261031-02

**Acuse inicial:** LEÍDO · RESPUESTA_INICIAL_REGISTRADA. El operador rectifica expresamente el destino: `OCP-MCP` es el único bucket B2 de EP. `OCP-MSP` y `metodologia-ep-persistencia` fueron errores; no deben usarse como destinos. Esta corrección supersede el destino erróneo asentado en el cierre anterior y en EP-TASK-002 §23.
**Interpretación y viabilidad:** viable corregir inmediatamente toda la documentación operativa y el prompt de los consumidores. La instrucción anterior de eliminar `metodologia-ep-persistencia` se mantiene como autorización explícita de eliminación, pero la ejecución solo será válida después de verificar la cuenta, el nombre exacto del bucket y su contenido. La existencia de `OCP-MSP` no está verificada y no se creará, usará ni eliminará por inferencia.
**Bloqueos:** no hay sesión Backblaze autenticada disponible ni se ha observado el estado actual de buckets/keys. La clave `ep-ocp` reportada históricamente corresponde precisamente al prefijo `OCP-MCP/ep-ocp/`; su validez actual aún debe revalidarse en B2.
**Acción inmediata:** corregir OEP, índice de tareas, EP-TASK-002, EP-TASK-003 y el prompt compartido a `OCP-MCP`; conservar esta rectificación como fuente de precedencia sobre el error documental anterior. No realizar operaciones B2 mientras no exista autenticación verificable.

## Historial de mensajes

- MSG-GOV-BILATERAL-20261031-01 — PUBLICADO por Gobernanza; LEÍDO y RESPUESTA_INICIAL_REGISTRADA por EP; PROCESADO y DOCUMENTADO_AL_CIERRE en este objeto; VERIFICADO_READBACK: la lectura posterior a la escritura devolvió el mismo blob `09a9f67829b25a3e2c54d73f697b810f65ce824b`.
---

### Addendum de denominación y verificación trilateral · DTC

Este mismo intercambio queda denominado **DTC — Dinámica Trilateral por Ciclo**. No es una nueva solicitud ni abre una ronda separada: precisa el mensaje MSG-GOV-BILATERAL-20261031-01 ya publicado.

Gobernanza asume la responsabilidad de verificar, en cada uno de sus ciclos, que los tres frentes —Gobernanza, EP y OCP MCP— cumplan la secuencia DTC. EP conserva la responsabilidad de ejecutar y evidenciar su propia compuerta, su lectura/respuesta al inicio y su documentación al cierre. La verificación de Gobernanza no transfiere titularidad ni autoridad sobre EP.

En cada revisión, Gobernanza clasificará la evidencia de cada criterio como VERIFICADO, PARCIAL, NO_VERIFICADO, BLOQUEADO o SIN_CICLO_OBSERVADO. Ausencia de una respuesta o de evidencia read-back no equivale a cumplimiento. Cuando EP no haya tenido un ciclo observable desde la revisión anterior, se registrará SIN_CICLO_OBSERVADO, no cumplimiento presumido.

**El contrato DTC común ya incluido en este objeto permanece íntegro.**

### DTC · registro mínimo por ciclo (aclaración de la misma comunicación)

Esta precisión no abre otra ronda ni crea otro objeto. **Cada ciclo real de EP debe quedar registrado aquí, sin excepción**, en una sola entrada que se abre al inicio y se completa al cierre:

- **APERTURA:** identificador local del ciclo o folio global válido; cursor real (rama/revisión/blob); respuesta inicial o `SIN_NOVEDAD`.
- **CIERRE:** delta o `SIN_NOVEDAD`; tareas/estados afectados; bloqueos y siguiente acción; evidencia y referencias de los cambios del OEP/registro.
- **READ-BACK:** confirmar lectura posterior de este objeto y de los documentos modificados. Si falta apertura, cierre o read-back, el ciclo queda `CICLO_INCOMPLETO`. Conservar las entradas anteriores; no sobrescribirlas ni abrir otra bitácora.

**Reconciliación de fuente EP:** el OEP vigente consultado está en `main` (v0.3.20 / VCU-EP-v22, blob `217218c48d79818451cd2cdc1cce98a94a6f122d`) y el índice provisional también está en `main` (blob `934000b93de7e933d893c0055cabc4647dea57be`), pero este objeto de comunicación solo se localizó en `docs/metacanon-objetos-20261011`; la misma ruta devuelve NOT_FOUND en `main`. EP debe reconciliar **este mismo objeto** con su fuente canónica `main`, conservando su historial y sin crear un segundo canal. Hasta verificar esa continuidad, la comunicación DTC de EP no se considera plenamente verificable.


---

## Apertura DTC · EP · C-EP-DTC-PERSISTENCIA-METODOLOGIA-20261031-01

**Fecha:** 2026-10-31 · America/Mexico_City  
**Estado de apertura:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA`  
**Identificador:** local de ciclo EP; no es folio global ni activa FOL1.

### Cursor de apertura y fuentes cotejadas

- `main` antes de esta reconciliación: `0a2fb82984a59501317234a90854f0ba653fc8b9`.
- OEP canónico `main`, v0.3.20 / VCU-EP-v22: blob `217218c48d79818451cd2cdc1cce98a94a6f122d`.
- Índice de tareas EP `main`: blob `934000b93de7e933d893c0055cabc4647dea57be`.
- EP-TASK-002 `main`: blob `2f854758e7f823cdbda2ecf07ff710683ad2026b`.
- Objeto provisional leído desde `docs/metacanon-objetos-20261011`: HEAD `dfd119b9ed68e8c2bf785e4834e535ada3bfab85`, blob `aeb7cd06c230c165e3d8892ba0572904a898806f`.
- La misma ruta devolvía `NOT_FOUND` en `main`; se reconcilia este mismo objeto y su historial completo en `main`, sin abrir otro canal.

### Acuse específico al addendum DTC y rectificación de frente

Acuso el addendum DTC: cada ciclo real de EP debe abrir y cerrar una entrada en este mismo objeto, con cursor verificable, respuesta inicial, procesamiento, documentación final y lectura de vuelta. La ausencia de cualquiera de esas fases deja el ciclo incompleto.

El operador confirma que **esta conversación pertenece al frente Entorno Persistente (EP)**. La respuesta anterior que solicitaba transferencia de titularidad de Metacanon fue una clasificación incorrecta del frente y queda retirada; no se solicita ni se ejecuta ninguna transferencia de Metacanon. La persistencia de Metodología se procesa desde EP, bajo OEP y sus tareas existentes.

### Interpretación del urgente y viabilidad inicial

La interpretación operativa inicial del urgente es completar EP-TASK-002: habilitar persistencia remota complementaria para Metodología y los conjuntos de datos/artefactos que se autoricen, manteniendo `SeryMente/metodologia/main` como fuente canónica de documentos y gobierno. Backblaze no sustituye GitHub ni crea un segundo núcleo de estado.

La instrucción canónica de OEP §91 y EP-TASK-002 §24 establece **`OCP-MCP` como único bucket B2 autorizado para EP**; el prefijo histórico previsto es `OCP-MCP/ep-ocp/`. El nombre del bucket no debe confundirse con el producto de servidor MCP-OCP. `OCP-MSP` no se utilizará. La eliminación de `metodologia-ep-persistencia` permanece autorizada pero no ejecutada: primero debe autenticarse B2, comprobarse la identidad exacta del bucket y revisar su contenido para preservar cualquier dato necesario.

### Estado de admisión, bloqueos y siguiente acción inmediata

- Repositorio `SeryMente/metodologia`: privacidad y permisos admin/push observados durante este preflight.
- DUG vigente: Samantha v373 · NX-373m; Metacanon 1.26; GOW 2.14.
- Identidad del frente: EP; rol de esta conversación: asistencia/documentación y coordinación de persistencia conforme a la asignación explícita del operador. El árbol `main` no contiene un `CONTROL-RESPONSABILIDAD.json` bajo `frentes/ep/`; OEP no publica titular/generación técnica separados. No se inventa una generación, sesión ni folio, ni se crea un control paralelo. La concurrencia de escritura se protege por lectura del HEAD/blob y escrituras Git condicionadas al contenido observado.
- Perfiles de navegador disponibles: `Default` y `Harmonia-Cora-PC10-Pilot`; ninguno declara un sitio autenticado. No hay conector B2 directo disponible en esta sesión.
- La sesión B2 autenticada, la cuenta/región, la existencia/privacidad de `OCP-MCP`, la vigencia y alcance de `ep-ocp`, el contenido del bucket erróneo y cualquier capacidad real de upload/read-back siguen **NO VERIFICADOS**.
- No se ha realizado ninguna operación B2; no se ha creado/eliminado bucket, modificado permisos, subido/descargado datos ni probado restauración.
- La arquitectura de alto nivel/seguridad no se da por decidida: P012/P013 mantienen la revisión presencial aplicable antes de cerrar esas decisiones.

**Acción inmediata:** solicitar autorización del operador para abrir una sesión de inicio de sesión de Backblaze en el perfil de navegador elegido; una vez autenticada, verificar solo lectura cuenta/región/buckets/keys antes de cualquier escritura o borrado. No solicitar contraseñas ni secretos en el chat.


---

## Cierre DTC · EP · C-EP-DTC-PERSISTENCIA-METODOLOGIA-20261031-01

**Estado del ciclo:** `PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK`.  
**Secuencia completa:** `LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK`.  
**Clasificación:** `CUMPLE_VERIFICADO` para la ejecución documental de la compuerta de este ciclo EP; no implica que EP-TASK-002 esté completada ni que B2 esté autenticado.

### Procesamiento ejecutado

1. Se reconcilió este mismo objeto provisional, con todo su historial, desde `docs/metacanon-objetos-20261011` a `main`; no se creó un segundo registro.
2. OEP actualizado a v0.3.21 / VCU-EP-v23; §92 documenta la ubicación canónica del objeto DTC en `main`.
3. Índice de tareas actualizado para enlazar el objeto reconciliado y OEP §§90–92.
4. README de EP corregido para reconocer `main` como rama canónica y enlazar OEP, comunicación DTC y tareas.
5. EP-TASK-002 §25 actualizado con la interpretación del primer urgente de Metodología, el destino B2 único, la falta de autenticación y los pasos pendientes.
6. Creada `REVISION-OEP-v0.3.21.json` y actualizado `MANIFIESTO.json` con bytes, SHA-256 UTF-8 y Git blob de los documentos afectados.
7. No se transfirió titularidad de Metacanon. No se alteraron controles de responsabilidad, DUG, host, DPAPI, consumidores ni código.

### Evidencia de read-back

| Recurso | Commit de escritura | Git blob de read-back | SHA-256 UTF-8 |
|---|---|---|---|
| OEP.md v0.3.21 | `57f1581bc1d6455c5c3616d4f39180f8455f7095` | `c0c65c473711881a1d1692bec757b283eca3eb34` | `f12b81aa1dc43099b9153d8741112f3399c1bb0688c0ea02768825657afde48c` |
| Índice de tareas EP | `e95594a30626c4a2cd4a723c940b706346bf55cb` | `f55b2db5f1ac9c44c17d1f83078e651ccdf868ed` | `f52eb6cf56af353b12c8b04e551ffb134f5cf0c55eaea91a63cf90619b13df98` |
| EP-TASK-002 README | `1df8dc8e2538b25dd3a7ee16b6d18ce8dcea7a56` | `8604dcbb0157b73b61671d5aee8a2be96aedcfd1` | `0ab18b62d4b25e4ed18a2a38b33385845f62bc80bc916c8817daa60808428ff4` |
| README EP | `09e1cc4327d63d9204d85e166ff0b1ee46e2ebd8` | `e787fd908281c9b089652425b023b92eaea7674d` | `a2b36b8738320e306c80bb6afaf7118ae531cd2272f500160d15d3048c59fa1a` |
| REVISION-OEP-v0.3.21.json | `50dc5808536abb9174c30582a47b522703a87100` | `87419509768c0c77a0e18af83e1f94603bdd4142` | `0130096b5a05fe6c4042ff1d07d8f42e55abdceac68ec66fcaf84c75787d26c8` |
| MANIFIESTO.json | `35945ddd6fa6e712e80f8932b21af1072f5a0d06` | `b3a6822de30eaf6df5dc17ba8bc4058bffa60c56` | `a89f82fd8a90c8cd693b41f6ce20dbd9ce348fb73c6f89fa209295b955eb9b7b` |

El objeto de coordinación se leyó de vuelta después de su apertura y antes de esta entrada; su blob de apertura fue `bbf13313218773fab4268d48626ff5eccdab1127`. Después de guardar este cierre se hará una nueva lectura exacta. El blob final de este mismo objeto se informa en la salida del ciclo y no se inserta en sí mismo para evitar una referencia circular.

### Estado de EP-TASK-002 y bloqueos

- **Estado:** `en_curso`.
- **Destino único:** bucket B2 `OCP-MCP`; prefijo histórico previsto `ep-ocp/`.
- **Autenticación B2:** NO DISPONIBLE/NO VERIFICADA. Los perfiles de navegador listados no tienen sitios autenticados registrados; no hay herramienta B2 directa.
- **Cuenta/región, existencia/privacidad del bucket, vigencia y scope de `ep-ocp`:** NO VERIFICADOS.
- **Eliminación de `metodologia-ep-persistencia`:** AUTORIZADA, NO EJECUTADA; se requiere inspeccionar su contenido antes de borrar.
- **OCP-MSP:** no crear, usar ni eliminar por inferencia.
- **Upload, SHA remoto, read-back y restauración:** NO EJECUTADOS.
- **Arquitectura de alto nivel/seguridad:** pendiente de revisión presencial conforme a P012/P013.
- **FOL1:** `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; folios globales CV/CY/A/B y OCP siguen `PENDIENTE/NO ASIGNADO`.

### Siguiente acción

Solicitar al operador autorización para abrir el flujo de inicio de sesión de Backblaze en el perfil de navegador `Default`; después realizar únicamente el inventario de solo lectura de cuenta, región, buckets y claves. No solicitar contraseñas ni secretos por chat. Antes de una primera escritura B2, acordar el conjunto de datos/artefactos inicial y una prueba reversible con manifiesto SHA-256, read-back y restauración.

**Límite de aceptación:** este ciclo queda completo como ciclo documental DTC; la necesidad material de persistencia para Metodología continúa abierta en EP-TASK-002. La DTC global no se declara cerrada por este ciclo local.
