# EP-TASK-003 · Materialización del workspace y dead-man trigger fuera de CECEQ

**Naturaleza:** tarea provisional vinculada al frente EP; no crea un frente, OCP, titularidad, sesión ni folio global propio.  
**Estado:** `en_curso` — alcance reducido; diseño del disparador delimitado, implementación pendiente.  
**Identificador:** `EP-TASK-003` (local al registro provisional).  
**Responsabilidad de seguimiento:** frente EP, bajo su OEP.  
**Origen:** instrucción directa del operador en esta conversación, 2026-10-31.  
**OCP padre:** [OEP](../../OEP.md).

## 1. Enunciado

Construir un mapa exhaustivo y recuperable de todo lo que se ha diseñado, construido, documentado, probado, desplegado o preparado dentro del ámbito Entorno Persistente, aunque actualmente no se utilice. El mapa debe incluir arquitectura, código, servicios, extensiones, contratos, APIs, MCP, bases de datos, almacenamiento local y remoto, colectores, SDK/clientes, scripts, paquetes, pruebas, artefactos, procesos de sincronización, recuperación, observabilidad y documentación. Después debe cotejarse ese inventario con las necesidades urgentes y con los consumidores que realmente utilizarán la persistencia de EP, para calcular el delta entre lo ya construido y utilizado, lo construido pero no usado, lo parcialmente aprovechable, lo duplicado, lo obsoleto y lo que todavía falta. El análisis de rescate, simplificación o descarte de componentes de baja prioridad queda expresamente diferido hasta que las urgencias estén resueltas; nada se borra ni se abandona por inferencia.

## 2. Objetivos y entregables

### 2.1 Mapa de construcción «as-built»

Un catálogo único, con referencias a fuentes exactas, que identifique por componente:

- nombre, función, alcance y proyecto/repositorio;
- fuente canónica, branch/ref, commit y rutas;
- blob SHA y SHA-256 cuando sea posible;
- estado: observado en fuente actual, reportado históricamente, ejecutado con evidencia, desplegado, en uso, parcialmente construido, sin uso demostrado, sustituido o desconocido;
- dependencias y fronteras de seguridad;
- contrato/interfaz y consumidores;
- datos que produce/recibe y su persistencia;
- pruebas existentes y qué prueban exactamente;
- resultado actual de disponibilidad y uso real (no inferir por presencia de código);
- restricciones, bloqueos y riesgos de recuperación.

### 2.2 Matriz de utilización

Para cada elemento, clasificarlo como:

- usado actualmente y necesario;
- usado parcialmente;
- construido pero no utilizado;
- preparado pero nunca integrado;
- antecedente sustituido o descontinuado;
- duplicado de otra capacidad;
- pendiente de verificación.

### 2.3 Cotejo con urgencias y delta

Comparar el mapa con la ruta urgente vigente de EP:

1. fijar la arquitectura común de persistencia bajo responsabilidad de EP y su compuerta de aprobación;
2. dejar operativo el recurso B2 correcto: exclusivamente `OCP-MCP`; conservarlo como destino y verificar el estado real de acceso;
3. retirar `metodologia-ep-persistencia` únicamente después de identificar inequívocamente el bucket y confirmar que no contiene datos que deban preservarse;
4. implementar la interfaz común versionada de EP, sus mecanismos de autenticación/autorización, lectura/escritura, integridad y recuperación;
5. construir el cliente/adaptador reusable de EP;
6. incorporar HARMONIA y Signal Interpreter mediante adaptadores propios, respetando sus estructuras locales diferentes;
7. demostrar sincronización, aislamiento, idempotencia, read-back SHA-256 y restauración.

El mapa debe producir un delta accionable: capacidad que existe y puede reutilizarse, capacidad que requiere adaptación, capacidad duplicada o ya sustituida, y capacidad ausente. No presuponer el stack definitivo: documentar el hecho construido y separar la propuesta de integración.

## 3. Perímetro inicial de búsqueda

El inventario debe cubrir, como mínimo:

- OEP, hitos EP-H01–EP-H06, tareas provisionales, prompts de asistencia/constructor, originales, revisiones, manifiestos, evidencia y entregables del repositorio `SeryMente/metodologia`;
- arquitectura normativa y código del Entorno Persistente Medio en `SeryMente/khora`, incluidos bootstrap, VHDX/BitLocker, workspace, identidad/OIDC, tokens, sesiones, logs, Neon, APIs, MCP, continuidad multi-repositorio, cleanup/hombre muerto, UI, herramientas, migraciones SQL, scripts y pruebas;
- HARMONIA dentro de KHORA: extensión, colector, JSONL, índice, catálogo, fingerprints, token/seguridad local, sincronización de código, Cora/Neon, OCP y pruebas;
- Signal Interpreter: extensión, IndexedDB, outbox/cola, batches, relay Vercel, GitHub Actions, paquete `observations/`, manifests, snapshots, deltas, call reports, auditorías, scripts y documentación;
- Backblaze B2: cuenta/región/buckets/keys/permisos/prefijos, custodia, clientes y cualquier integración existente, distinguiendo lo reportado de lo observado;
- entregables históricos, prototipos y componentes que no se encuentran enlazados desde el camino actual.

Este perímetro se ampliará solo cuando una fuente examinada indique una dependencia adicional. No tratar un directorio ausente en una rama como prueba de que no existe en otra.

## 4. Método

1. Resolver y registrar fuente, rama, commit, blob y fecha de revisión.
2. Construir el inventario por repositorio y por subsistema, no solo por nombre de archivo.
3. Relacionar documentos con implementación y pruebas; marcar divergencias y versiones.
4. Distinguir el estado de código de su despliegue y uso efectivo.
5. Marcar componentes sin fuente actual como `fuente no recuperada`, no como inexistentes.
6. Construir una matriz de trazabilidad: requisito urgente → capacidad existente → evidencia → brecha → adaptación pendiente → prueba de aceptación.
7. Calcular delta de reutilización: ya aprovechable, aprovechable con adaptación, duplicado/solapado, no utilizado, sustituido y faltante.
8. Entregar hallazgos con enlaces/paths y evidencia suficiente para reanudar el trabajo desde otra conversación.
9. Mantener un único catálogo/índice dentro de los objetos canónicos EP; no crear un tablero paralelo.

## 5. Límites

- La sesión local anterior y sus credenciales no están disponibles en esta ubicación. No asumir acceso a la máquina, perfil Windows, DPAPI, archivos locales ni servicios iniciados allí.
- No solicitar ni publicar secretos. No copiar credenciales de B2 a consumidores.
- No borrar buckets, archivos, paquetes, ramas, servicios o código durante el inventario.
- La autorización para retirar el bucket sobrante se registrará en EP-TASK-002, pero solo se ejecutará tras autenticación y verificación de identidad del bucket/datos.
- No modificar código de los consumidores ni apagar sus mecanismos actuales en la fase de inventario.
- La revisión de salvamento/descarte de lo no usado es fase posterior, condicionada a que se resuelvan las urgencias y a decisión/aceptación del operador.
- Las decisiones de arquitectura de alto nivel y seguridad pasan por la compuerta de Gobernanza aplicable; este mapa no las aprueba por anticipado.

## 6. Criterio de cierre de esta tarea

La fase de inventario/delta se cierra cuando:

- las fuentes y superficies definidas han sido recorridas o sus límites se han documentado;
- el catálogo distingue «construido», «desplegado», «en uso», «sin uso demostrado» y «desconocido»;
- los componentes tienen referencias de versión/commit/blob/path y evidencia disponible;
- los requisitos urgentes están cotejados con capacidades existentes;
- el delta de reutilización, adaptación, duplicidad y carencia está calculado;
- los bloqueos de acceso local/B2 se muestran como no verificados;
- la lectura de vuelta de los artefactos del mapa se ha verificado.

La evaluación de salvamento, simplificación o descarte de los componentes no utilizados **no forma parte de este cierre**: queda en reserva para después de las urgencias.

## 7. Primera entrada de crónica · 2026-10-31

**Estado inicial:** tarea en curso; inventario global no terminado.

**Fuentes observadas en este ciclo:**

- `SeryMente/metodologia/main`: OEP v0.3.18 / VCU-EP-v20, blob `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`; revisión del núcleo y §§76–90 en proceso. DUG Samantha v373 / NX-373m; Metacanon 1.26; GOW 2.14 y §ARR adquiridos en `main`.
- `SeryMente/khora/main`: `ep-medio-architectura.md` v1.0.4, blob `382e4a929a984a96926fd6f9080f80bedd109a0b`; especificación del medio con VHDX/BitLocker, OIDC, JWT de sesión, GitHub/Vercel, Neon y bitácora remota encadenada; `EP-ARCHITECTURE.md` es redirección de compatibilidad.
- HARMONIA en `SeryMente/khora/main`: `apps/harmonia-observability/collector/server.js`, blob `34b98945da3db4604e62a3c9baa367ce024a0a5c`, y `extension/service-worker.js`, blob `49d65381accdc33ce501eca6c4b5f2dd47a014b2`; existe colector local en 127.0.0.1:47321 con raíz local, JSONL/índice/fingerprints y eventos `harmonia.event.v1`. El objeto canónico HARMONIA es v0.39, blob `4c55a0942ba08274caadf1af11f4ea81de0dfed7`; la persistencia provisional anonimizada hacia Cora/Neon continúa con pruebas POST/GET/idempotencia no ejecutadas según §44; el NCL es auxiliar opt-in y desconectado por defecto según §45.
- `SeryMente/signal-interpreter/main`: arquitectura de observabilidad v2, blob `8a492f763c17bc15920f02614c37a15c30dc8a66`; relay Vercel → GitHub API → inbox → GitHub Actions → paquete de observabilidad. Contrato de paquete v1, blob `caedf6d6f1d21e6c085a68d9784a5543cf6d590e`; protocolo de delta v1, blob `8a7d33fd6a0e4e40fab059256d8ac1b9bf3fd758`; manifiesto actual blob `34c23121f60c2420c5994e893bd91fc535581d97`, total reportado por el propio manifiesto 10,659 batches, 1,918 observations, 1,897 deltas, 14 identities, extension 0.10.36, manifest generatedAt 2026-10-31T20:58:25.342Z y lastSequence 7965. Estos contadores son contenido del manifiesto leído; no son una medición independiente de cada batch.
- Tareas provisionales en `SeryMente/metodologia/main`: EP-TASK-001 pendiente (NCL) y EP-TASK-002 en curso (OCP MCP/B2), índice blob `74aceb5fef4814011ebdd393a36e1191469ea328`; no hay EP-TASK-003 hasta materializar esta entrada.

**Primer delta observado:** el medio EP ya incluye persistencia local cifrada y bitácora remota Neon con hash chaining para sesiones de entorno; HARMONIA y Signal Interpreter tienen subsistemas de observabilidad autónomos y muy diferentes; Signal Interpreter ya persiste su paquete remoto en GitHub mediante Vercel, HARMONIA tiene colector local y evidencia histórica Cora/Neon pero su prueba real de escritura/lectura/idempotencia sigue pendiente. Backblaze aparece como tarea de persistencia provisional, sin integración central demostrada. Por tanto, no se debe tratar Backblaze como si fuera la primera o única persistencia ya construida; el reto es definir qué responsabilidad nueva cubre EP y cómo incorpora sin duplicar Neon/Historial GitHub ni eliminar la persistencia local.

**No observado/no verificado:** estado actual de host/local y cualquier clave DPAPI; estado actual de login de B2; buckets y keys en cuenta B2; conexión de HARMONIA en un host vivo; sesiones Vercel actuales; uso/aceptación de producción por cada consumidor; restauración real multiubicación; inventario exhaustivo de Khora, MCP y artefactos históricos.

**Siguiente acción:** ampliar el mapa por árbol de KHORA y Signal Interpreter, completar la reconciliación de EP-TASK-002 con la orden OCP-MCP, crear el prompt común no normativo para los consumidores y calcular el delta provisional frente a los requisitos urgentes. No se descarta ni modifica componente alguno.


## 8. Nueva arquitectura de materialización, extensiones y perfiles de ubicación · 2026-11-07

### 8.1 Entrada rectora

Fuente literal preservada: INSTRUCCION-MATERIALIZACION-UBICACIONES-20261107.txt. Evidencia minimizada del host/perfil candidato: PERFIL-CSEC-PREFLIGHT-20261107.json. Esta entrada actualiza los diseños previos de workspace/selección de repositorios del OEP; no modifica código ni activa el bootstrap.

### 8.2 Raíz del workspace y repositorios

La raíz solicitada para la materialización local es:

    <Escritorio efectivo del usuario Windows activo>/Ser y Mente/

En cada instancia, el bootstrap debe consultar los repositorios existentes en la organización GitHub SeryMente y materializar sus carpetas bajo esa raíz. La selección estática o el inventario histórico de EP deja de ser el universo por defecto: la fuente debe ser el catálogo actual de la organización. Cada carpeta debe registrar repositorio, rama, commit/SHA y estado de sincronización para hacer reconstruible la materialización.

La materialización se hace dentro del perímetro local protegido/efímero definido por EP. Antes de crear la raíz, resolver y validar el Escritorio real de la sesión Windows interactiva; no usar el Desktop del proceso RDC si pertenece a otra identidad.

### 8.3 Contrato de extensiones Chrome

Para cada repositorio que corresponda a una extensión Chrome debe existir dentro de la carpeta del repositorio una carpeta cargable denominada extension/. Esa carpeta es la ruta que el operador carga o refresca en Chrome.

Después de cualquier modificación de la extensión, independientemente de su origen —complemento nativo de GitHub en ChatGPT, cambios directos en GitHub o puente con Jules cuando su servidor MCP esté disponible— debe actualizarse también la carpeta extension/ local. La actualización debe cotejar los archivos y el SHA contra el commit fuente; no dar por actualizada la extensión porque cambió el repositorio remoto. No se presume que el MCP/Jules ya esté conectado o disponible.

### 8.4 Perfiles de ubicación

La instrucción declara dos tipos de perfil, pero identifica expresamente uno: CSEC. Se registra de forma provisional:

- LOC-CSEC: ubicación declarada por el operador como centro comunitario habitual; terminal HP ProDesk 400 G4 DM PC10RCIF4EI4, sesión de consola CENTRAL/fila4, perfil cargado C:/Users/fila4.
- LOC-OTHER: categoría de trabajo fuera de CSEC o ubicación no reconocida. Es una interpretación del segundo tipo implícito, pendiente de confirmación; no se crean por ahora perfiles adicionales.

El dictado escribió CSEC, pero su deletreo fue C-E-C-E-Q; la identidad nominal queda pendiente de validación por el operador.

### 8.5 Huella de ubicación adquirida sin identificadores invasivos

En el host activo se observaron: dispositivo RDC PC10RCIF4EI4; equipo PC10RCIF4EI4; HP ProDesk 400 G4 DM; Windows 11 Pro, build 26200; PowerShell 5.1.26100.9711; consola activa CENTRAL/fila4, sesión 4; perfil C:/Users/fila4; interfaz Ethernet, categoría de red 2 e IPv4 connectivity 4. No se capturaron dirección MAC, número de serie, SSID, dirección IP ni GPS.

La asociación física a CSEC procede de la declaración del operador; estos atributos identifican el host/sesión y ayudan a detectar cambios, pero no constituyen geolocalización ni prueba única de presencia física. La evidencia se conserva como perfil candidato, no como autenticación definitiva de ubicación.

**Conflicto de Escritorio:** en el perfil cargado de fila4, el registro User Shell Folders señala C:/Users/MantenimientoRCI/Desktop, mientras que el valor legado Shell Folders señala C:/Users/fila4/Desktop. El proceso RDC corre bajo CENTRAL/MantenimientoRCI; su GetFolderPath(Desktop) devuelve la primera ruta. La ruta efectiva del Escritorio para la sesión interactiva fila4 no está validada. No crear Ser y Mente hasta resolver esta discrepancia.

### 8.6 Reutilización del hombre muerto histórico

No rediseñar desde cero. Se localizaron y adquirieron como antecedentes:
- OEP histórico de SeryMente/khora, §§28–30, blob 362f878237045e6a88e905b8e561c9dba4e0c4d9.
- scripts/khora/modules/10-guardian.ps1, blob df9aba72f53915a75d20edf8888edd3a4b1d1950.
- scripts/khora/modules/11-cleanup.ps1, blob c01643f665a667d040f8ec3fa16da30c93afb871.
- ep-medio-architectura.md, blob 382e4a929a984a96926fd6f9080f80bedd109a0b, §§5, 10 y 15.

Las reglas recuperadas contemplan cierre manual/solicitud cleanup.request, muerte del launcher/supervisor, cierre de VS Code, inactividad (15 minutos por defecto), vigilancia periódica y reinicio inesperado. El Guardian anterior sondeaba cada dos segundos y registraba heartbeat cada sesenta segundos. Para reinicio, una tarea AtStartup bajo SYSTEM y privilegio máximo limpia el contenedor exterior; permanece armada si quedan residuos y solo se desregistra cuando confirma su ausencia.

La secuencia histórica de limpieza es: aceptar cierre; detener procesos de trabajo; intentar guardar perfil y continuidad remota; purgar secretos/variables y blobs DPAPI del Guardian; bloquear BitLocker; retirar el enlace del Escritorio; desmontar el VHDX; eliminar el contenedor y carpeta exterior; retirar la tarea solo tras verificar ausencia; cerrar el estado remoto. Si falla la persistencia, prevalece la confidencialidad y no se retiene una sesión sensible para intentar salvar cambios indefinidamente.

### 8.7 Límite de “sin dejar rastro” y alcance seguro

El requisito operativo se formula como: no dejar datos de usuario ni workspace en claro en las carpetas locales ordinarias; cifrar la instancia, eliminar de forma verificable los artefactos bajo control de EP, purgar credenciales y bloquear/desmontar el volumen. No se promete ausencia forense absoluta de todo metadato de Windows, registros del sistema, paginación, telemetría de seguridad o infraestructura externa. EP no alterará registros del sistema, datos ajenos, auditorías del host, archivos fuera de su contenedor ni medios que no controle.

La instrucción de sesiones efímeras se registra como requisito. No se activó el Guardian, no se creó una tarea programada, no se borró ningún archivo ni se materializó el workspace. Las rutinas antiguas se reutilizarán solo después de validar su alcance contra el nuevo root Ser y Mente y obtener la validación del operador.

### 8.8 Siguiente gate de esta tarea

Validar con el operador: (1) nombre/código exacto de la ubicación CSEC/CECEQ; (2) categoría genérica de todas las demás ubicaciones; (3) ruta efectiva del Escritorio de fila4; (4) parámetros del Guardian anterior que se conservan, en particular los quince minutos de inactividad y los triggers de cierre; (5) el nivel de señal suficiente para asociar automáticamente el host a CSEC. Hasta esa validación, todo lo anterior es requisito documentado/propuesta de interpretación, no política local activada.


## 9. Política vigente de BitLocker, CECEQ y Guardian independiente de IDE · 2026-11-07

### 9.1 Regla ubicua de cifrado

Toda instancia y en toda ubicación, incluida CECEQ, debe tener su workspace completo dentro de un volumen VHDX protegido con BitLocker XTS-AES-256, protección activa y 100% cifrado antes de materializar repositorios o datos. No existe fallback en claro. Si BitLocker, elevación o comprobación criptográfica falla, EP bloquea la materialización.

La contraseña maestra de la bóveda canónica de variables de entorno es la misma raíz secreta para desbloquear el workspace BitLocker. El operador introduce una sola contraseña maestra. Se conserva la derivación de protector por sesión PBKDF2-HMAC-SHA256, 200.000 iteraciones y sal vinculada al ID de sesión; no se solicita ni se almacena otra contraseña maestra ni se escribe la contraseña original en claro.

### 9.2 Perfiles de ubicación y excepción de CECEQ

La ubicación declarada y corregida por el operador es CECEQ. El perfil provisional previo LOC-CSEC queda supersedido; no se borra su registro histórico. Se adopta LOC-CECEQ para la terminal previamente identificada con PC10RCIF4EI4 y cuenta activa CENTRAL/fila4. La asociación a CECEQ se apoya en la declaración del operador de que esa terminal y ese usuario son los que ocupa regularmente en el centro; no se declara geolocalización independiente.

LOC-OTHER representa cualquier otra ubicación. La excepción es única: en CECEQ la carpeta/contenedor de trabajo no se elimina automáticamente. En LOC-OTHER, la carpeta y el contenedor sí se eliminan automáticamente al cerrar o perder control de la sesión, conforme al Guardian. La política de cifrado no cambia entre perfiles.

En CECEQ, el Guardian detiene procesos, persiste lo autorizado cuando sea posible, purga credenciales y secretos efímeros, bloquea BitLocker y desmonta el volumen; conserva el contenedor y carpeta de trabajo cifrados para una siguiente materialización. No conserva procesos, sesiones autenticadas ni secretos de sesión. En las demás ubicaciones ejecuta además eliminación verificada del contenedor y carpeta exterior.

Si el clasificador de ubicación no reconoce CECEQ, aplica LOC-OTHER. La retención automática solo se habilita al coincidir el perfil CECEQ validado. No se usa una ubicación de red/IP como única señal.

### 9.3 Guardian actualizado; sin dependencia de Visual Studio Code

Visual Studio Code ya no forma parte del entorno operativo vigente. Toda regla anterior que dispare limpieza por cierre de VS Code queda expresamente supersedida. Tampoco se requiere que un IDE concreto permanezca abierto.

Se conservan del mecanismo histórico los disparadores y señales neutrales:
- cierre manual o solicitud explícita cleanup.request;
- salida/muerte del launcher o supervisor observado;
- pérdida del heartbeat/vigilancia del supervisor;
- inactividad del host, conservando 15 minutos como valor histórico por defecto;
- reinicio o apagado inesperado, con tarea de arranque que aplica el perfil de ubicación antes de cualquier borrado.

Se conserva como referencia la frecuencia histórica del Guardian (sondeo cada 2 segundos; heartbeat cada 60 segundos), su protección DPAPI/BitLocker, el registro remoto y la secuencia de cierre. Cualquier ajuste por la evolución del launcher se probará en el backlog técnico; no se sustituye por un proceso de aplicación/IDE.

### 9.4 Secuencia de cierre por perfil

Común a todos los perfiles: aceptar motivo; detener procesos de trabajo; intentar persistir únicamente los datos autorizados; purgar secretos, credenciales y blobs transitorios; bloquear BitLocker; desmontar el volumen; confirmar estado remoto de cierre cuando la conexión esté disponible.

CECEQ: después de la secuencia común, conservar el VHDX/contenedor y la carpeta de trabajo cifrados. No ejecutar la etapa de eliminación automática.

LOC-OTHER: después de la secuencia común, retirar el punto de montaje/enlace y eliminar contenedor y carpeta exterior bajo control de EP; verificar su ausencia. Mantener armada la tarea de limpieza al reinicio mientras exista cualquier residuo; desarmarla solo tras read-back de ausencia.

La tarea AtStartup existente debe adaptarse para reconocer CECEQ y preservar el contenedor cifrado en ese perfil. No puede borrar primero y clasificar después. En ubicación desconocida/no reconocida, la regla operativa es LOC-OTHER. La política no autoriza borrar logs del sistema, auditorías, telemetría ni datos fuera del perímetro EP.

### 9.5 Estado

- Política ubicua BitLocker: decisión explícita del operador; implementación pendiente.
- Raíz maestra de vault para BitLocker: decisión explícita; derivación de protector heredada, validación de unlock end-to-end pendiente.
- LOC-CECEQ: perfil declarado; prueba automatizada de coincidencia pendiente.
- LOC-OTHER: perfil de todas las demás ubicaciones.
- CECEQ conserva contenedor cifrado al cierre: decisión explícita; código pendiente.
- Resto de ubicaciones volatiliza contenedor/carpeta automáticamente: decisión explícita; código pendiente.
- Trigger de cierre de VS Code: retirado/supersedido.
- Guardian/cleanup y AtStartup: deben actualizarse, probarse y verificarse; todavía no activados por este cambio documental.


## 10. Rectificación de denominación y regla final de cierre · 2026-11-07

La denominación confirmada por el operador es **CECEQ**. Se fija como perfil canónico LOC-CECEQ. Las variantes LOC-CSEC y LOC-CCEC quedan supersedidas; se conservan solo como trazabilidad histórica de errores de transcripción. No volver a solicitar ni inferir otra grafía.

**BitLocker ubicuo:** el workspace completo debe estar cifrado con BitLocker en toda ubicación, sin excepción, antes de materializar repositorios o datos. El operador utiliza una sola contraseña maestra: la misma contraseña que abre la bóveda canónica de variables de entorno sirve como entrada para desbloquear el workspace cifrado. Se mantiene la derivación por sesión del diseño histórico (PBKDF2-HMAC-SHA256, 200.000 iteraciones, sal ligada al identificador de sesión); no se crea una segunda contraseña maestra ni se guarda la contraseña original en claro. Esta contraseña no es la Master Application Key de Backblaze.

**Excepción CECEQ:** el cierre automático detiene los procesos, persiste únicamente datos autorizados, purga secretos efímeros, bloquea BitLocker y desmonta el volumen, pero conserva el contenedor y la carpeta de trabajo cifrados. No se activa la eliminación automática del workspace en CECEQ. Fuera de CECEQ se ejecuta la volatilización automática del contenedor/carpeta EP tras el intento de persistencia. Cualquier ubicación desconocida se clasifica como LOC-OTHER y recibe la regla de eliminación automática.

**Guardian sin IDE:** Visual Studio Code y su cierre dejan de ser señales operativas. El mecanismo permanece ligado a solicitud explícita de cierre, salida/muerte del launcher o supervisor, pérdida de heartbeat, inactividad conforme al valor definitivo que valide el backlog y reinicio/apagado inesperado. El sondeo de 2 segundos y heartbeat de 60 segundos se conservan como parámetros del diseño anterior hasta su contraste de implementación. El valor histórico de 15 minutos no queda activado como umbral definitivo por esta corrección.

Estado: regla documental corregida y registrada; activación del Guardian, programación AtStartup y prueba completa de lock/dismount/preserve-vs-delete permanecen pendientes del backlog técnico. No se han borrado archivos ni se han modificado volúmenes Windows durante esta actualización.


**Fuente de perfil y política vigentes:** INSTRUCCION-BITLOCKER-CECEQ-20261107.txt y PERFIL-CECEQ-POLITICA-20261107.json. Estos artefactos superseden la grafía errónea LOC-CSEC/LOC-CCEC y formalizan BitLocker en todas las ubicaciones con conservación cifrada exclusiva de CECEQ.


## 11. Alcance vigente reducido por instrucción expresa · 2026-11-07

Esta sección supersede para el trabajo activo los objetivos de inventario, Guardian y vigilancia de las secciones anteriores. Se conserva lo anterior únicamente como antecedente; no se ejecutarán sus actividades más amplias.

- Workspace: carpeta `Ser y Mente` en el Escritorio efectivo de la sesión Windows, con los repositorios actuales de la organización SeryMente. Los repositorios que sean extensiones Chrome mantienen su carpeta cargable `extension/`, sincronizada con el commit fuente.
- Cifrado: BitLocker obligatorio en toda ubicación. Se utiliza la misma contraseña maestra de la bóveda canónica de variables de entorno.
- CECEQ: conservar el workspace cifrado al cierre; no volatilizarlo automáticamente.
- Ubicaciones distintas de CECEQ: revisar e implementar únicamente un dead-man trigger ligado a la terminación del proceso que mantiene abierta la sesión EP. Al dispararse: bloquear BitLocker, desmontar y eliminar exclusivamente el contenedor/carpeta de trabajo EP.
- Diseño anterior consultado: KHORA OEP §28 (concepto de pérdida de control autorizado), §§29–30 como contexto de limpieza; `10-guardian.ps1` y `11-cleanup.ps1` como antecedentes. Se reutiliza solo el evento de terminación del proceso de control; no se porta el Guardian completo ni su secuencia histórica extensa.

**Exclusiones explícitas de esta versión:** vigilancia anti-exfiltración; monitoreo de procesos, archivos, red o actividad; heartbeat; polling/sondeo; temporizador de inactividad; cierre de VS Code o de cualquier IDE; tarea AtStartup o tareas programadas; telemetría o vigilancia en segundo plano. No implementar, activar ni dejar estos componentes en el backlog de esta tarea.

**Estado de ejecución:** actualización documental solamente. El dead-man trigger aún no está codificado ni activado. No se modificaron scripts, tareas de Windows, volúmenes ni archivos de trabajo.
