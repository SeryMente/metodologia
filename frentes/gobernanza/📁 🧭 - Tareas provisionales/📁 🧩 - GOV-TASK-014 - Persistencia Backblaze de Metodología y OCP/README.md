# GOV-TASK-014 — Integración y aceptación de persistencia Backblaze para Metodología y OCP

**Estado:** en_curso · **Tipo:** tarea integradora propia de Gobernanza · **Responsabilidad:** heredada del OCP Gobernanza, generación 13. No crea FT, OCP, control, sesión ni folio independiente.

## 1. Objetivo

Integrar en el OCP general del sprint la dependencia técnica EP-TASK-002 y la continuidad recuperable de dos planos: (1) documentos y artefactos versionados de Metodología/OCP, cuya fuente canónica sigue siendo GitHub; y (2) estado y datasets operativos del servidor MCP-OCP que su titular técnico identifique como necesarios para reanudación funcional. El resultado separará backup local, persistencia remota B2 y restauración cross-host; no asumirá que uno demuestra los otros. Gobernanza integra criterios y aceptación; EP ejecuta transporte/persistencia de entorno bajo su OEP; MCP-OCP define y valida su mecanismo nativo y sus datos. Esta tarea no duplica EP-TASK-002 ni transfiere la autoridad técnica de ninguno de los dos frentes.

## 2. Fuente técnica y trazabilidad

- **Frente ejecutor:** Entorno Persistente, OCP `frentes/ep/`.
- **Tarea técnica fuente:** [EP-TASK-002 — Persistencia provisional con Backblaze B2](../../../ep/📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-002%20-%20Persistencia%20provisional%20Backblaze/README.md).
- **OEP:** [Objeto Canónico de Persistencia de Entorno](../../../ep/OEP.md).
- **Comunicación DTC EP:** [COORDINACION-GOBERNANZA-EP-v0.1.md](../../../ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md).
- **Repositorio canónico de Metodología:** `SeryMente/metodologia/main`; GitHub permanece fuente canónica de documentos, gobierno, tareas y código versionado.
- **Objeto MCP-OCP:** `frentes/mcp-metodologia/`; conserva su propio OCP y control. La persistencia B2 no sustituye ni altera ese OCP.

## 3. Alcance integrado

1. Precisar con EP qué artefactos de Metodología/OCP deben tener copia recuperable en B2 y cuáles deben permanecer únicamente en sus fuentes canónicas.
2. Mantener GitHub como autoridad de versiones y procedencia. B2 es una copia complementaria de persistencia/recuperación; no es un segundo repositorio canónico, no sustituye Git y no se convierte en almacén de autorización, control, folios o bitácoras.
3. Reconciliar los artefactos de OCP elegibles con sus propietarios: OEP y documentación EP; documentación y artefactos de MCP-OCP; documentos de Gobernanza. No copiar secretos, credenciales, tokens, perfiles autenticados ni datos excluidos por EP.
4. Verificar que el destino configurado sea únicamente el bucket `OCP-MCP`; el prefijo históricamente reportado para EP es `ep-ocp/`, sujeto a verificación autenticada de cuenta, región, bucket, key y permisos.
5. Mantener como destinos inválidos `OCP-MSP` y `metodologia-ep-persistencia`. La eliminación de este último figura autorizada en el historial de EP, pero no se considera ejecutada: EP debe verificar cuenta, identidad y contenido antes de actuar.
6. Obtener evidencia de carga de muestra no sensible, lectura de vuelta, SHA-256, restauración aislada y verificación funcional en una segunda ubicación, bajo las autorizaciones y compuertas de EP.
7. Integrar el resultado en el checklist del sprint, separando diseño, preparación local, autenticación, operación remota, sincronización, restauración y aceptación.
8. Para MCP-OCP, incluir datasets/estado operativo elegibles, consistencia de captura, backup nativo, manifiesto/índice portable, dependencias de clave y validación funcional por su titular. El bucket B2, el prefijo y el alcance de la key se aceptarán únicamente después de que EP verifique el `namePrefix` y los permisos efectivos.

## 4. Estado de entrada observado

**Fuente EP-TASK-002, blob leído:** `eefd01300376dab55593e2a35196f7eaf66fc350`.

- Tarea EP-TASK-002: `en_curso`.
- Backblaze CLI v5.0.2 descargada e instalada localmente en PC-8; SHA-256 del ejecutable verificado: `543aa2e36d3cbe06cf2c3e59287ce58b0a7d1507af87f147ff2f7d9406879662`.
- Comandos `version`, `--help`, `sync --help`, `bucket get --help` y `bucket list --help`: exit code 0, según recibo persistido de EP.
- `account get`: exit code 1; estado clasificado por EP como `NOT_AUTHORIZED_OR_NO_CACHED_SESSION`.
- Autenticación B2, cuenta/región, existencia/privacidad del bucket, key, prefijo y permisos efectivos: no verificados.
- No hay evidencia de listado de buckets, carga, descarga, sincronización, borrado, SHA remoto ni restauración. No se declara ninguna operación remota ejecutada.
- EP registra que P012/P013 requieren revisión presencial del operador antes de construir el motor, contactar la cuenta B2 o realizar operaciones remotas. La instalación local del CLI no supera esa compuerta.
- EP ya documentó que GitHub `SeryMente/metodologia/main` es la fuente canónica y que B2 debe ser persistencia complementaria, no un segundo núcleo de OEP/tareas/autorización/bitácora.

**Estado de verdad:** CLI local instalada/verificada según evidencia de EP; cuenta B2 y operaciones remotas no verificadas/no ejecutadas. La tarea integradora de Gobernanza no certifica los resultados técnicos de EP.

### 4.1 Evidencia actual del plano operativo MCP-OCP

EP comunicó en el objeto DTC, ciclo local `C-EP-MOD-SCRIPTPWS-20261101-03`, que la candidata MCP-OCP v0.1.0 utiliza `SqliteStore`/WAL y `BackupService` con SQLite Online Backup API, `PRAGMA quick_check`, SHA-256 y paquetes `.ocpbak` AES-256-GCM; la clave se envuelve mediante DPAPI `CurrentUser` y el índice `backup_points/package_path` reside dentro de SQLite. El recibo de la candidata informa 31/31 pruebas unitarias, 29/29 integración y 200/200 componentes cotejados, con estado `MVP_TECNICO_VERIFICADO_NOT_INTEGRATED_NOT_INSTALLED_NOT_ACCEPTED`.

Esta evidencia acredita la candidata bajo su escenario de build, no su integración/instalación, operación B2 ni restauración entre usuarios/equipos. DPAPI `CurrentUser` está ligado al perfil/SID de origen; no se copiará ese blob para fingir portabilidad. La recuperación cross-host requiere que MCP-OCP determine un mecanismo autorizado de re-enveloping/recuperación de clave y un manifiesto externo con rutas transferibles. Gobernanza no prescribe ni modifica el código o esquema de MCP-OCP.

## 5. Criterios de aceptación integrados

- [ ] Operador revisa y decide presencialmente el perímetro de datos, arquitectura, custodia de credenciales y flujo de recuperación exigido por P012/P013.
- [ ] EP verifica de forma autenticada cuenta/región, bucket privado `OCP-MCP`, key/prefijo `ep-ocp/` y permisos mínimos, sin revelar secretos.
- [ ] EP inspecciona el bucket erróneo `metodologia-ep-persistencia`; solo lo elimina si identidad, nombre y contenido se verifican y se preserva cualquier dato que deba conservarse.
- [ ] EP define manifiesto de artefactos elegibles y exclusiones, con rutas lógicas estables; GitHub sigue siendo fuente canónica de los archivos versionados.
- [ ] Una muestra sintética/no sensible se carga en prefijo autorizado y se verifica por lectura de vuelta, conteos, tamaños y SHA-256.
- [ ] Se demuestra restauración aislada en una segunda ubicación sin sobrescritura destructiva y con hashes coincidentes.
- [ ] Se demuestra sincronización idempotente, recuperación ante interrupción y detección/preservación de conflictos, conforme al alcance MVP de EP.
- [ ] EP actualiza EP-TASK-002/OEP y su objeto DTC con evidencia, limitaciones, commits/blobs, hashes y read-back.
- [ ] Gobernanza verifica la evidencia fuente y actualiza el estado integrado sin duplicar el detalle técnico.
- [ ] MCP-OCP identifica desde su OCP los datasets/estado operativo que necesita para continuidad, su fuente de verdad y el mecanismo nativo consistente para capturarlos, sin incluir secretos ni material de autorización.
- [ ] Se acredita por separado el backup local MCP-OCP (SQLite Online Backup/validación), el transporte remoto B2 y el restore cross-host; ningún estado se infiere de otro.
- [ ] MCP-OCP y EP acuerdan un manifiesto/índice portable con rutas relativas y una estrategia autorizada de recuperación/re-enveloping de la clave, sin trasladar el DPAPI blob `CurrentUser` del host origen.
- [ ] En host/perfil de destino aislado, el titular MCP-OCP valida autenticidad AES-GCM, SHA-256, `PRAGMA integrity_check`, readiness y una prueba funcional del servicio después de restaurar.
- [ ] EP confirma que bucket, prefijo y `namePrefix` efectivo permiten exactamente los conjuntos autorizados; no amplía permisos ni scopes por inferencia.
- [ ] El operador acepta expresamente el resultado integrado.

## 6. Dependencias, límites y decisiones

- EP es responsable de la implementación, credenciales, CLI, host, bucket, transferencias, restauración y evidencia técnica, bajo su control y compuertas.
- Gobernanza es responsable de integrar la dependencia, fijar criterios de aceptación del sprint, revisar la trazabilidad y elevar decisiones al operador.
- MCP-OCP conserva la autoridad técnica de su servidor, código, pruebas y empaquetado. La persistencia B2 no autoriza a Gobernanza o EP a modificar su OCP/control/código.
- MCP-OCP determina datasets, consistencia, exportación nativa, clave y aceptación funcional de sus restauraciones. EP no lee ni copia bases vivas por inferencia; Gobernanza no modifica el OCP, control, código o host MCP-OCP.
- No crear un bucket alternativo, un segundo OCP, un mirror canónico independiente ni una bitácora paralela.
- No imprimir, almacenar en Git ni enviar al chat claves, tokens, contraseñas o secretos.
- No ejecutar `--delete`, cambios lifecycle, cambios ACL o transferencias masivas sin compuerta y autorización específica.
- La disponibilidad de un CLI o la presencia de variables en otro proyecto no demuestra que B2 esté autenticado, configurado o operativo para Metodología.
- El estado de esta tarea no se completa por el cierre de un ciclo DTC ni por la instalación del CLI; requiere todos los criterios de aceptación aplicables.

## 7. Comunicación y actualización por ciclo

La comunicación de Gobernanza con EP se mantiene exclusivamente en el objeto existente `COORDINACION-GOBERNANZA-EP-v0.1.md`. En cada ciclo real de cualquiera de los frentes:

1. Leer el último cursor del objeto y responder en la misma entrada antes de otro trabajo sustantivo.
2. Permitir intercambios múltiples dentro del mismo ciclo mediante sondeo adaptativo en hitos, decisiones, antes de escribir, tras tramos largos y antes del cierre; no imponer temporizador fijo.
3. Registrar solo novedades materiales: emisor, cursor/blob, delta, respuesta/acción, estado y pendiente.
4. Antes de cada escritura, releer la revisión y comprobar SHA; serializar escrituras y reconciliar ante cambios concurrentes.
5. Cerrar el ciclo una sola vez, tras atender mensajes pendientes, documentar resultados y comprobar read-back.

La comunicación con MCP-OCP permanece en su objeto existente `COORDINACION-SPRINT-OCP-MCP-v0.1.md`, sin trasladar instrucciones EP ni abrir canales alternativos. La coordinación no afirma recepción/aplicación hasta que el mensaje figure y sea respondido en ese objeto.

## 8. Estado y siguiente acción

**Estado actual:** `EN_CURSO`. La ampliación de EP sobre continuidad del propio servicio MCP-OCP fue recibida en el objeto DTC existente y respondida por Gobernanza dentro del ciclo EP-03. Blob de EP antes de la respuesta `ce7e80aef47224f83c7e82892c44473b30bdf9db`; respuesta publicada/read-back en blob `0db054c79abebe40d7a6a686744e2adcd566b69b`. La tarea distingue ahora artefactos versionados y datos operativos MCP-OCP. No se declara autenticación B2, carga, sincronización remota ni restauración cross-host.

**Siguiente acción material:** MCP-OCP debe definir y validar su inventario de datasets, consistencia de backup, manifiesto portable y recuperación de clave/restauración funcional; EP integra la matriz y continúa EP-TASK-002 bajo P012/P013. Antes de cualquier operación remota B2 sigue siendo obligatoria la revisión/decisión presencial del operador.

**Cierre:** solo cuando la evidencia de EP satisfaga los criterios anteriores, Gobernanza haga read-back de las fuentes y el operador acepte el resultado integrado.

**Vigencia:** tarea provisional del sprint actual; no canoniza un estándar general ni modifica el DUG.

## Actualización ejecutiva de estado DTC · reinstanciación EP y solicitud MCP-OCP · 2026-11-01 19:18 America/Mexico_City

Esta actualización supersede solo la fotografía operativa previa de PC-8; no elimina el registro histórico ni cambia el alcance técnico de EP-TASK-002.

### EP · fuente actual

- EP-TASK-002 continúa `en_curso`; §34 fue releída desde `main`, blob `a45103468c109d3bbc0503ec3f77c1b29ac84aee` (commit `7a79ac7f14b346646f84349935e0da1d59f88757`). El entorno operativo nuevo es RDC `015RENTA01`; PC-8/PID histórico `7232` no se reutiliza.
- B2 CLI v5.0.2 está instalada localmente y su SHA-256 coincide con `543aa2e36d3cbe06cf2c3e59287ce58b0a7d1507af87f147ff2f7d9406879662`. Esto acredita la herramienta local, no una sesión de cuenta.
- Estado explícito: `PHYSICAL_PRESENCE_GATE_PENDING` · `AUTHORIZATION_NOT_STARTED` · `B2_PREFLIGHT_NOT_RUN` · `E2E_NOT_STARTED` · `UPLOAD_NOT_EXECUTED` · `RESTORE_NOT_EXECUTED`. Cuenta, bucket, key, `namePrefix` y capacidades efectivas siguen sin verificación.
- EP añadió a OEP §94 y al mismo DTC EP-03 nuevas incidencias de preflight/recurrencia. Gobernanza respondió a cinco incidencias dentro del mismo objeto; commit `1f934f1254620cc6e60339afa812c53469241819`, blob/read-back `312c3e7a328e726c88b43c38e37e99d67125cef4`. EP-03 sigue abierto a la espera de corrección, procesamiento y cierre/read-back del propio frente.
- La persistencia de continuidad MCP-OCP permanece dentro de EP-TASK-002; no queda suspendida por el subciclo MOD-SCRIPTPWS.

### MCP-OCP · dependencia de datos operativos

- Ciclo local 06: `CUMPLE_VERIFICADO` y cerrado; no equivale a integración, instalación ni aceptación del producto.
- Solicitud DTC §30 del objeto MCP, blob `3ea63f4c18de6f185430617add5bd2df67f15258`: `PUBLICADO`, pendiente de respuesta del titular MCP-OCP. Requiere inventario de datasets/estado operativo, captura consistente, manifiesto portable, estrategia autorizada de recuperación de clave, prueba aislada cross-host y estados independientes.
- No abrir otra solicitud mientras §30 permanezca pendiente. MCP-OCP conserva la autoridad sobre sus datasets, backup nativo, esquema, clave y aceptación funcional.

### Estado integrado y próxima condición

**GOV-TASK-014:** `EN_CURSO`. **B2 remoto:** `NO_VERIFICADO`. **Backup local MCP-OCP:** candidato reportado/cotejado en código, no instalado ni aceptado. **Restore cross-host:** `NO_VERIFICADO`. **DTC global:** `EN_CURSO_RECURRENT`.

**Siguiente hito:** recibir y procesar la respuesta MCP-OCP a §30; en paralelo EP continúa EP-TASK-002 bajo sus compuertas. Tras los acuses de datasets y el preflight autorizado de EP, definir snapshot/manifiesto, namespaces y prueba B2 no destructiva; solo declarar recuperable cada plano después de su propia lectura de vuelta y restauración funcional. Ninguna operación B2 se declara ejecutada.

## Delta EP · reanudación de inventario local de solo lectura · 2026-11-01 19:22 America/Mexico_City

EP registró una nueva respuesta inicial dentro del ciclo existente `C-EP-MOD-SCRIPTPWS-20261101-03` para retomar EP-TASK-002. Gobernanza respondió en el mismo DTC y leyó de vuelta la respuesta. Estado del acuse: commit `5cc770d0e6fab673bb900d942ddef2ba4efaaaae`, blob `e156ff79745b9835e7562d5050eafec378cf4e90`.

**Fase permitida ahora:** inventario/reconciliación de solo lectura en `015RENTA01`: confirmar dispositivo, CLI B2 y su versión/hash local; comprobar existencia de cachés y nombres de variables sin revelar valores; identificar fuentes/candidatas disponibles. No autenticar, llamar `account get`, descifrar bóvedas, leer secretos, crear/rotar claves, modificar scope, tocar lifecycle ni llamar al proveedor.

**Compuerta:** P012/P013 `PHYSICAL_PRESENCE_GATE_PENDING` para 015RENTA01. La declaración presencial de PC-8 no se hereda. El estado remoto B2 sigue `AUTHORIZATION_NOT_STARTED` / `B2_PREFLIGHT_NOT_RUN` / `E2E_NOT_STARTED`; no hay upload ni restore.

**Aceptación integrada:** mantener separados backup local por propietario, B2 remoto y restore cross-host. El plano MCP-OCP necesita acuse y definición del titular en §30; no se abre una solicitud duplicada. La persistencia del servicio MCP-OCP sigue siendo parte de EP-TASK-002/GOV-TASK-014 y del sprint.

**Estado:** `EN_CURSO`. La lectura de solo lectura puede producir un inventario candidato, pero no cierra EP-TASK-002 ni prueba persistencia remota. Esperar el delta documentado/read-back de EP y la respuesta §30 del propietario MCP-OCP.


## Actualización integrada DTC · ciclo local MCP-OCP 08 y nueva respuesta EP · 2026-11-01, 19:45:00 America/Mexico_City

**Criterio de actualización:** solo se incorporan hechos visibles en los objetos propietarios y sus read-backs. No se cambia el estado técnico de la tarea por cierre documental DTC; no se infiere autorización, operación o aceptación.

### Fuentes y cursores cotejados

- DUG Samantha v377 / NX-377m: blob `54064c8fe00f872023a455f06596061ed69062ae`.
- EP DTC `COORDINACION-GOBERNANZA-EP-v0.1.md`: blob tras la respuesta de Gobernanza `347ef5d037394644a65484121d8739c089b3aa47`; commit de esta respuesta `0c16f20f710424d876de5d9568a94b87831f44aa`.
- EP-TASK-002: blob `9bedc2a8d8956a912fb01b698569d99cf6e39de4`.
- MCP-OCP DTC `COORDINACION-SPRINT-OCP-MCP-v0.1.md`: blob tras la rectificación de Gobernanza `dc041dfa626ff649d76a12e067dad5357484c9e1`; commit `5af20eafeee1308f1c73d7f14f21cb3c0fbdcb8d`.
- Núcleo MCP-OCP: `MCP-OCP-v0.1.18`, generación 4, blob `9c2cdc01b2f5be3b39ee49ce179084f4fb75b436`.
- Control MCP-OCP: generación 4, `owned`, blob `ecb27b04aaba04025ef596b3f0ed6c049bc2420d`.

### Estado EP · EP-03 y compuerta de custodia

- El ciclo local `C-EP-MOD-SCRIPTPWS-20261101-03` permanece `OPEN`; EP informó `DTC_CYCLE_STATUS=OPEN` y `EP-TASK-002_STATUS=en_curso`. La respuesta de EP a la retroalimentación de Gobernanza está publicada; la nueva respuesta de Gobernanza solicita el read-back antes del cierre.
- EP-TASK-002 continúa `en_curso`. B2 sigue sin autenticación verificada, bucket/scope comprobados, upload, read-back remoto ni restore. La presencia de `015RENTA01` fue reportada por EP como declaración del operador; Gobernanza no la verificó presencialmente en esta conversación.
- EP reportó que `secrets/env-vault.enc.json` está versionado en una rama remota de KHORA, 3.656 bytes, SHA-256 `6D3648E0E434250794DABA89F0682451CBCB5EEAF1CF1A93A3324B6914CA683F`, con nueve nombres cifrados y sin valores descifrados. El `.gitignore` de `main` no excluye expresamente el archivo principal y la visibilidad histórica del repositorio sigue sin determinarse según el registro EP/Custodia.
- Esto justifica mantener bloqueada la incorporación de nuevas credenciales a esa copia y elevar la revisión al titular de Custodia. **No demuestra exposición de valores en claro ni compromiso de claves.** No se borra/reescribe el archivo, historial, ACL o ramas por inferencia.
- El procedimiento de captura/almacenamiento de credenciales sigue `PROPUESTO`, no autorizado ni ejecutado. EP reporta que el control de Custodia gen. 6 excluye cambios de credenciales y de seguridad/configuración efectiva del bucket. EP no puede ampliar ese mandato.

### Estado MCP-OCP · cierre local 08 y bloqueo longitudinal

- MCP-OCP documentó en §32 el procesamiento del requerimiento, la actualización de su backlog, la propuesta de Portable Recovery Package y el cierre documental/read-back del ciclo local 08. La clasificación del frente para ese ciclo es `CUMPLE_VERIFICADO`; Gobernanza separa ese cierre de la ruta técnica, que permanece `BLOCKED_PENDING_OPERATOR_SECURITY_REVIEW_AND_SECOND_HOST`.
- El núcleo vigente `MCP-OCP-v0.1.18` ya refleja generación 4. Una mención gen3 en material histórico anterior no se mantiene como discrepancia vigente del núcleo actual.
- El recibo de candidata 0.1.0 permanece ligado a core v0.1.16; no es evidencia fresca de v0.1.18. En el ciclo 08 no se hicieron cambios de código ni build/test nuevo; no se justificó repetir el build antiguo sin delta causal.
- Portable Recovery Package (manifest externo, snapshot SQLite, envelope de recuperación y re-enveloping): **propuesta documental únicamente**, no aprobada ni implementada. P012/P013 y la falta de un segundo host/perfil autorizado impiden la construcción/validación cross-host descrita. No hubo B2, acceso a credenciales, restore, PR/merge ni instalación.

### Retroalimentación DTC y estado integrado

- Gobernanza publicó retroalimentación basada en la desviación procedimental `account get`, en la separación entre ciclo DTC y tarea técnica, y en la relectura obligatoria de cursor antes de operaciones sustantivas. EP respondió y aplicó explícitamente la separación de estados; el nuevo read-back sigue pendiente.
- Gobernanza publicó retroalimentación a MCP-OCP sobre la separación entre ciclo local y estado técnico. Tras detectar que su primera lectura de §32 era incompleta, publicó una rectificación con acuse del cierre local 08 y read-back exacto. El siguiente acuse de MCP-OCP queda pendiente; no se reabre ciclo 08.
- **Estado de esta tarea:** `EN_CURSO`. Persistencia documental Git y análisis de propuesta no demuestran B2 remoto, backup real, restore cross-host, integración, instalación ni aceptación. No se cambia ningún criterio de aceptación técnico.

**Siguiente paso material:** mantener EP-TASK-002 en pausa para operaciones B2/credenciales hasta resolver las autorizaciones y custodia correspondientes; continuar trabajo documental permitido. MCP-OCP conserva la propuesta para revisión P012/P013 y debe esperar un segundo host autorizado para la prueba cross-host. Gobernanza actualizará esta tarea únicamente ante nuevos deltas verificables; no repetirá las mismas solicitudes pendientes.


## Delta integrado EP · divergencia del working tree de bóveda · 2026-11-01, 19:47:31 America/Mexico_City

**Cursor EP de entrada:** `frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md`, `main`, blob `1b5ce2c98316757889a5160c0267c15ffd85b198`. Commit de la respuesta de Gobernanza al delta: `1eac442432dc893b88840c84ee50a86cb87ff32d`; blob/read-back `1b5ce2c98316757889a5160c0267c15ffd85b198`.

### Evidencia reportada por EP

- `secrets/env-vault.enc.json` figura en el índice Git local con object ID `9d30e8cdab83a1c54d8dc6cb7d46d1c80cab302f`, coincidente con el blob reportado en la rama remota `feat/khora-mcp-module-jules-20261101`.
- El working tree actual produce Git blob `912bf1a0a5e84b0b5cb93268272bfb1ce27c3b43`, distinto del índice y la versión remota.
- Tamaños reportados: working tree 3.656 bytes; remoto 3.607 bytes; diferencia de 49 bytes.
- EP no inspeccionó valores/campos, no determinó el contenido del cambio y no estableció su causa. Estado semántico: `NO_VERIFICADO`.

### Clasificación y controles

`LOCAL_WORKTREE_MODIFIED_UNCOMMITTED` · `INDEX_REMOTE_DIVERGENCE` · `SEMANTIC_DIFF_UNKNOWN`.

El dato demuestra divergencia entre working tree, índice y rama remota; no demuestra alteración maliciosa, exposición en claro, compromiso criptográfico ni cuál versión es correcta. El delta de tamaño no se interpreta como contenido.

Gobernanza respondió en el mismo EP-03 y estableció preservación no destructiva: no `checkout/restore/reset/clean/stash/add/commit/push`, sincronización, copia, movimiento, descifrado, exportación, reescritura o eliminación sin autorización competente; mantener `B2_CREDENTIAL_HANDLING=BLOCKED`. La preservación byte-exacta fuera de Git requiere procedimiento autorizado por Custodia y operador. La autorización del control Custodia gen. 6 no cubre cambios de credenciales ni seguridad efectiva del bucket.

**Estado actual integrado:** EP-03 `OPEN`; EP-TASK-002 `en_curso`; respuesta más reciente de Gobernanza `PUBLICADA`, read-back/acuse EP pendiente. `CREDENTIAL_STORAGE_AUTHORIZATION=PENDING`; `B2_ACCOUNT_AUTHORIZATION=NOT_STARTED`; `REMOTE_OPERATION_AUTHORIZATION=NOT_GRANTED`. No hay operación B2, lectura de secretos, modificación de bóveda/ACL/historial, upload o restore.

**Criterio de cierre:** el ciclo EP solo cambia a `CLOSED_VERIFIED` cuando EP lea de vuelta la última respuesta y procese cualquier mensaje posterior, documentando el estado del ciclo por separado de EP-TASK-002. Esta actualización no cierra el ciclo ni la tarea técnica.



## Delta MCP-OCP · read-back de evidencia del ciclo 08 · 2026-11-01, 19:49:25 America/Mexico_City

**Cursor DTC actual:** objeto MCP-OCP `main`, blob `b0eaed6102861e17026a55f1bd28dbd9f7268a30`; commit `c4f3a8b0c08924dd33e2bd999caf53889a035d70` (`docs(mcp-ocp): align cycle 08 evidence final read-back`).

La comparación literal con el blob previo `dc041dfa626ff649d76a12e067dad5357484c9e1` muestra una actualización de la tabla de read-back del cierre §32: el diálogo A/B local 08 ahora referencia commit `b7d268b6ca85d4ba1308ea952068fb9ac48dbc9d` / blob `8cea32d002445336641a87b3c5b5e041dd82cd96`; la evidencia estructurada local 08 referencia commit `249e1f9fb2b74c6398d35ffab66a31c9c374ebf7` / blob `60e702b12ee54a291895727d48ec38ba7fdf3106`, descrita como portadora de la separación de estados y la rectificación posterior de Gobernanza.

**Contenido B leído:** MCP-OCP registra `DTC_CYCLE_STATUS=CLOSED_VERIFIED` y `MCP_TECHNICAL_STATUS=BLOCKED_PENDING_OPERATOR_SECURITY_REVIEW_AND_SECOND_HOST`; además, documenta que el mensaje posterior al cierre de Gobernanza fue publicado y que el acuse formal del modelo se difiere al siguiente ciclo. Esto confirma la separación de estados y la conservación de la rectificación, pero **no constituye el acuse formal** que el propio registro declara pendiente.

**Clasificación integrada:** ciclo local 08 cerrado documentalmente; E2E técnico sigue bloqueado; rectificación posterior de Gobernanza pendiente de acuse en el siguiente ciclo MCP-OCP. No reabrir ni renumerar el ciclo 08.



---

## OCP MCP 1.0 · extensión de persistencia y recuperación · 2026-11-10

El alcance integrador contempla workspace completo clasificado, bóveda de variables de entorno y datos de usuario/operación de OCP. No sustituye EP-TASK-002 ni transfiere a Gobernanza la ejecución B2.

### Conjuntos a inventariar

1. Workspace: documentos, proyectos, repositorios y cambios del usuario que deban sobrevivir al cambio de equipo.
2. Bóveda: ciphertext y metadatos autorizados; nunca valores secretos en claro ni claves maestras junto al ciphertext.
3. Datos OCP: bases, snapshots coherentes, índices, configuración no secreta, estado operativo y artefactos de continuidad.
4. Código/documentos versionados: GitHub sigue siendo la fuente canónica; B2 es copia complementaria.
5. Excluir perfiles/cookies autenticados de terceros, secretos en claro, temporales ajenos, cachés regenerables y datos de otros usuarios. La inclusión de .git y cambios no publicados exige clasificación explícita.

### Criterios añadidos

- Cifrado del lado del cliente antes de B2.
- Claves efímeras de sesión distintas de las claves de persistencia/recuperación.
- Manifiesto sin secretos, con rutas lógicas, tamaño, identificación de cifrado y SHA-256.
- Upload, descarga, cotejo SHA y restore aislado: carga aceptada no equivale a recuperación.
- Retención/versionado B2 separados de la limpieza local de la sesión efímera.
- La expiración local no destruye las claves ni versiones que permiten restaurar el workspace persistente.

### Discrepancia de evidencia

El operador informa que la persistencia reciente terminó. No obstante, el último read-back EP-TASK-002 consultado en main registró vaultSessionActive=false, variableCount=0, cinco variables B2 ausentes, ciphertext de 2.200 bytes, workers/wrapper con análisis sintáctico PASS, recibo remoto ausente y sin autenticación/upload/descarga/SHA/restore acreditados en ese ciclo.

Estado integrado: B2_REMOTE=NOT_VERIFIED_PENDING_EP_RECONCILIATION. EP debe aportar recibo y lectura de vuelta recientes. No se declara éxito ni fallo absoluto por inferencia. No se autoriza desde Gobernanza cambiar bucket, ACL, lifecycle, retención o borrar versiones remotas.


---

## OCP MCP 1.0 · criterios aprobados de persistencia y cierre con prioridad de borrado · 2026-11-10

**Prioridad coordinada:** H2 P0 (persistencia mínima + bóveda) y H3 (workspace completo recuperable). EP sigue siendo ejecutor de B2; MCP-OCP define datasets/contrato; Gobernanza integra y acepta.

### Dataset obligatorio

- Workspace completo de Ser y Mente que haya sido clasificado para continuidad, descargado en cada instancia.
- Conversaciones, adjuntos y artefactos conversacionales, siempre cifrados como parte del workspace; nunca texto en claro dentro de logs/eventos de telemetría.
- EP Vault completa: variables de KHORA, OCP, infraestructura, integraciones y proveedores, separadas por producto y entorno, con los valores sensibles cifrados.
- Datos de usuario/OCP y snapshots coherentes requeridos para reinstanciar/resolver sesiones.
- Código/documentación versionados siguen teniendo GitHub como fuente canónica; B2 es persistencia complementaria, no reemplaza Git.

### Secuencia

1. H2: journal/checkpoint de sesión mínimo, catálogo de bóveda y snapshot cifrado de Vault; upload, download, hash y restore aislado.
2. H3: snapshot del workspace completo y datasets OCP; cada sesión descarga la totalidad, valida manifest/SHA y abre copia cifrada local.
3. Optimización progresiva sin cambiar el contrato: checkpoints incrementales, deduplicación/chunks, compresión y cache cifrada solo después de la primera restauración completa.
4. H9 posterior: evaluar segundo medio/proveedor. No provisionar ahora; B2 es el único backend remoto inicial.

### Política de cierre

Ante trigger normal, intentar un único checkpoint con presupuesto máximo inicial de 30 s. Si se confirma la persistencia, registrar su recibo; si falla o expira el presupuesto, no alargar la exposición: cerrar/desmontar y destruir criptográficamente la clave efímera local. Ante emergencia/sospecha de compromiso, omitir el intento y ejecutar crypto-erasure inmediato. La clave persistente de recuperación y los snapshots B2 no se destruyen en el cierre de sesión.

### Retención y criterios

Retención prevista indefinida de datasets cifrados útiles, de acuerdo con la instrucción del operador y las obligaciones legales aplicables. Verificar versionado/lifecycle efectivo antes de afirmar retención remota indefinida; no cambiar ACL/bucket/lifecycle ni purgar versiones en esta tarea.

Aceptar por estados separados: local durable; remoto cargado; remoto verificado por read-back/hash; restore verificado en entorno aislado. La instancia solo se declara completa cuando se ha descargado y validado el workspace completo esperado. Si B2 no se encuentra disponible, registrar bloqueo y no inventar fallback: el medio alternativo está pendiente para H9.

**Estado:** criterios de Gobernanza configurados. La autenticación/transferencia/restore B2 actual continúan pendientes de recibo EP reciente; no se declara persistencia remota PASS por este documento.


## Reporte individual obligatorio de resolución/cierre
Al resolver, completar, bloquear o cancelar esta tarea, registrar su propio informe en este README usando [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md). Explicar objetivo y resultado, cómo se solucionó, decisiones verificables, cambios/rutas/commits/blobs/SHA, criterios y pruebas ejecutadas con logs/artefactos, read-back, bloqueantes/dependencias, preocupaciones/riesgos, pendientes, rollback y aceptación. Declarar NINGUNO_VERIFICADO o NO_VERIFICADO donde corresponda; nunca ocultar campos. No marcar completada sin criterios PASS, evidencia y read-back. Actualizar el índice padre después de verificar este informe y entregar al operador el enlace individual y síntesis de solución, evidencia, bloqueantes y preocupaciones. No incluir secretos ni datos sensibles.

## Reconciliación con evidencia EP · Backblaze R2 · 2026-11-10 · 17:08 America/Mexico_City

**Estado actualizado:** EP-TASK-002 reporta transferencia remota y read-back SHA-256 PASS de cuatro objetos en OCP-MCP. Gobernanza acepta únicamente el estado «remoto cargado y verificado por descarga/hash»; restore cross-host y persistencia completa siguen pendientes.

| Dataset | Resultado | Evidencia |
|---|---|---|
| Workspace provisional R2 | `UPLOAD_READBACK_PASS` | ZIP 119.076.640 B; SHA-256 `9D511614FC6B4001DBA5F8CAAF69ED06107F8B5F5111165F186BE7B2C5C06E09`; descarga cotejada. |
| Ciphertext EP Vault | `UPLOAD_READBACK_PASS` | 2.200 B; SHA-256 `4CC2EE09974C9FBF3CF22C28A5A46C8286EB501F59268DBBB2B7BD6D61E8C590`; descarga cotejada. |
| Manifest | `UPLOAD_READBACK_PASS` | 1.029.594 B; SHA-256 `D258A5E1F312C80C31A26206F7B0FF0309B86FE962C1EA8D3CF5344D56A0AC37`. |
| Checksum | `UPLOAD_READBACK_PASS` | 112 B; SHA-256 `E4D436B75F4A5CE3454AF43BE350F376BB165B6B2BC54604A082205C49420210`. |

Los cuatro objetos muestran SSE-B2/AES256 y están bajo prefijos privados ep-ocp/workspace y ep-ocp/vault. El recibo EP terminó exit 0, sin errores, y limpió la caché temporal.

**Excepción de urgencia:** el ZIP fue cargado sin cifrado cliente por instrucción directa del operador; SSE-B2 no sustituye ese control. La aceptación integrada H2/H3 permanece parcial hasta restore aislado, bootstrap de credenciales B2 y delimitación de notas/sesiones DPAPI. No modificar ACL, bucket, lifecycle o retención a consecuencia de este asiento.

**Siguiente gate:** EP valida extracción del ZIP y descifrado de una copia de Vault en entorno aislado; Gobernanza solo acepta restauración cuando manifest/SHA, estructura recuperada y capacidad de apertura quedan demostrados. No declarar continuidad cross-host por el mero upload.


## Reconciliación · restore aislado R2 workspace · 2026-11-10 · 17:12

EP-TASK-002 evidencia que el ZIP R2 (idéntico por SHA al objeto descargado de B2) fue extraído en `C:\\R2R`: 3.289/3.289 archivos verificados, 159.547.658 bytes, cero errores e inesperados, exit 0. Se acepta `WORKSPACE_ISOLATED_RESTORE=SAME_HOST_PASS`, no cross-host.

El ciphertext Vault remoto tiene read-back SHA PASS; descifrado aislado y bootstrap B2 independiente están `NOT_RUN`. La sesión DPAPI CurrentUser no es portable. ZIP sin cifrado cliente por excepción de urgencia; SSE-B2/AES256 no reemplaza ese control.

Estado: `B2_UPLOAD_READBACK=PASS_4_OF_4` · `WORKSPACE_ISOLATED_RESTORE=SAME_HOST_PASS` · `VAULT_DECRYPT_RESTORE=NOT_RUN` · `CROSS_HOST_RESTORE=NOT_RUN`. Se puede reanudar desarrollo sintético P004 en el ciclo MCP-OCP existente; no equivale a aceptación integral de persistencia.