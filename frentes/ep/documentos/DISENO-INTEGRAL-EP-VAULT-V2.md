# Diseño integral · EP Vault v2

**Frente:** Entorno Persistente (EP)  
**Módulo propietario:** MOD-EPVAULT  
**Versión del diseño:** 2.0.0-draft  
**Estado:** INTEGRATED_DESIGN_DRAFT · P012_P013_REVIEW_REQUIRED · BUILD_NOT_DISPATCHED  
**Fecha de corte:** 2026-11-13  
**Fuente rectora:** OEP; este documento desarrolla el diseño y no lo sustituye.

## 1. Decisión de producto y alcance

**EP Vault continúa siendo el único producto de custodia de secretos de EP.** EP Vault v2 es una evolución del módulo existente, no un producto adicional.

Novelocker no se incorpora: no se ha verificado un producto concreto con ese nombre ni una referencia técnica que permita compararlo. Se toman como criterios de calidad prácticas verificables de gestión de secretos, no la supuesta paridad con Novelocker.

El objetivo de v2 es conservar variables y notas cifradas, permitir su configuración local por CLI y permitir que un modelo solicite operaciones autorizadas sin recibir el valor secreto. La interfaz puede cerrarse mientras exista una sesión local autorizada; la bóveda criptográficamente bloqueada no puede prestar secretos.

### Incluido

- Custodia local de variables formales y notas efímeras.
- CLI para configuración y administración del almacén sin imprimir valores secretos.
- Un proceso local de custodia de sesión, sin ventana, integrado en MOD-EPVAULT.
- Uso delegado de secretos por operaciones autorizadas, sin token bearer ni valor secreto en el contexto del modelo.
- Sesiones vinculadas al tipo de ubicación EFIMERA o NO_EFIMERA.
- Pausa manual y sellado automático por inactividad a los 120 segundos.
- Integración del ciclo de apertura/bloqueo con Cryptomator CLI cuando la bóveda del workspace esté involucrada.
- Auditoría sin valores, rotación/revocación y migración versionada del almacén.

### Fuera de alcance de este sprint

- Un segundo gestor de secretos, Novelocker, una segunda bóveda lógica o un OCP adicional.
- Un broker genérico para administrar todo el filesystem de SeryMente. El controlador de custodia forma parte de EP Vault; no sustituye ni implementa el Access Broker general propuesto en OEP §144.
- Servicios cloud de secretos, Codex Personal Vault, Agents API Vault, OAuth o infraestructura externa.
- Implementar proveedores/servicios que el operador no haya identificado como consumidores concretos.
- Backblaze, Rclone y respaldo integral del workspace: continúan bajo EP-TASK-002. EP Vault v2 no crea un flujo de backup paralelo.
- Migrar el workspace completo, mover la bóveda Cryptomator real, limpiar VHDX/W: o borrar respaldos existentes.
- Conformidad certificada FIPS, OWASP, SOC 2 u otra certificación. Las guías son criterios de diseño y prueba, no una certificación del producto.

## 2. Auditoría de v1.0.0 y baseline disponible

La auditoría se hizo sobre el código local disponible, los contratos y el manifiesto de la release. Se distinguen el baseline que coincide con el manifiesto y la carpeta local que se etiqueta como v1.0.0, pero diverge.

### 2.1 Capacidades comprobadas en el baseline que coincide con el manifiesto

El paquete sintético EP-SYNTHETIC-V1.0.0-DB4138\src contiene los cuatro archivos de producto cuyos Git blob SHA coinciden con el MANIFEST.json local de v1.0.0. El script de pruebas y los dos WAV de interfaz también coinciden con sus hashes declarados.

Se ejecutó Test-EPVault.ps1 en una copia temporal aislada formada con esos archivos de producto y el harness coincidente. Resultado: EP_VAULT_VALIDATION_PASS, código de salida 0, tiempo 113,04 s. Pasaron:

- Parser PowerShell, XML/XAML y contrato de nombres de UI.
- Self-test PBKDF2-HMAC-SHA256, AES-256-CBC, HMAC-SHA256, round-trip, contraseña incorrecta y rechazo de manipulación.
- Job Object, alcance de procesos y terminación por timeout.
- Las ocho duraciones de sesión incluidas por el test.
- Migración sintética KDF de 200.000 a 600.000 iteraciones con read-back.
- Allowlist de variables sin herencia al proceso padre.
- Notas DPAPI: metadatos, revelación y eliminación; operaciones bloqueadas fallan cerradas.
- CRUD sintético, manipulación, preservación del backup, expiración absoluta y redacción del log.
- Reutilización y revocación de sesión compartida entre GUI y CLI.

Este PASS valida ese corte sintético. No acredita una bóveda real, aislamiento del agente, dead-man de 120 s, CLI de Cryptomator sobre la bóveda real, migración de datos reales ni aceptación H10/P012/P013.

### 2.2 Divergencia de la carpeta local etiquetada v1.0.0

El directorio Metodologia/frentes/ep/modulos/MOD-EPVAULT/v1.0.0 no coincide íntegramente con su propio manifiesto:

| Archivo | Git blob esperado en MANIFEST | Git blob de la carpeta local |
|---|---|---|
| src/EP.Vault.Core.psm1 | c7dc353c4aba5b6b7759b359698c4b94446b31b2 | ba5df2ceef45682e5c6e7b6fbbfc28b147444f66 |
| src/EP-Vault.GUI.ps1 | a065f1086e01ddc2142f7341ccf28cbea65e7ddf | e7a072bc94adcd2ef8fde99168883c654439495e |
| src/EP-Vault.Window.xaml | 0d692a2b1cb9b0ee53ce6b480a35ff3a9a9799d3 | 24949e3daf4de2024cd30934ce25eb1bec322230 |
| src/EP.Vault.CLI.ps1 | f485bc116df503aaab5d6f96d885d36197439496 | f485bc116df503aaab5d6f96d885d36197439496 |
| tests/Test-EPVault.ps1 | e324872966131ad0ba0a65b0fe666785dcd6ef1d | e324872966131ad0ba0a65b0fe666785dcd6ef1d |

El paquete sintético sí coincide con los blobs esperados de Core, GUI, XAML y CLI. La copia de trabajo Metodologia no tiene .git; no se usa para afirmar que exista un checkout sincronizado. La ruta de producto frentes/ep/modulos/MOD-EPVAULT/v1.0.0/ tampoco está publicada en main al momento de esta auditoría (consulta de contenido devuelve 404). Por ello, la release exacta debe conservarse como baseline por manifiesto y no identificarse automáticamente con la carpeta local divergente.

### 2.3 Hallazgos de seguridad funcional en el código disponible

1. **Sesión DPAPI compartida:** el registro ep-env-vault.session.dpapi.json contiene el material de clave envuelto con DPAPI CurrentUser. Cualquier proceso con la misma identidad Windows puede solicitar a DPAPI desenvolverlo. Esto protege frente a otros usuarios, no a un agente ejecutado bajo la misma identidad.
2. **TTL inconsistente:** el XAML incluye 1 hora; parte de la lógica de creación admite 1.800/3.600 segundos, pero Import-EpSharedSession y el parámetro de duración del CLI v1.0.0 admiten solo hasta 900 segundos. Hay un hotfix separado para 1.800/3.600 que no está integrado ni aceptado. No se hereda como comportamiento v2.
3. **Revelación directa:** RevealVariable -Reveal y ReadNote -Reveal imprimen texto claro en stdout. No pueden exponerse al modelo ni a su identidad de ejecución.
4. **Ejecución genérica:** Run recibe ejecutable y argumentos seleccionados por quien invoca y entrega variables autorizadas al proceso hijo. El Job Object limita el ciclo de vida del proceso, pero no restringe su red, filesystem ni destino de exfiltración. No es seguro como herramienta genérica de modelo.
5. **Auditoría no obligatoria:** Write-EpVaultEvent registra eventos JSONL bajo la raíz privada, pero absorbe errores de escritura. Un uso delegado no puede considerarse aceptado si no deja evidencia de auditoría.
6. **Memoria:** la conversión de SecureString a String administrada crea una representación de texto claro cuya eliminación física no puede garantizarse asignando $null. v2 debe reducir copias, limpiar buffers mutables y no prometer zeroization forense.
7. **Inactividad:** la GUI tiene temporizador de expiración absoluta y monitor de sesión compartida; no se encontró lógica de inactividad de usuario de 120 segundos ni recepción de eventos de voz.
8. **Documentación/código:** CaptureNote exige sesión local en el código leído, aunque una sección antigua del contrato headless afirma que no requiere desbloqueo. En v2 prevalece el comportamiento probado, y el contrato se debe reconciliar.
9. **Rutas de lanzamiento:** Core resuelve %LOCALAPPDATA%\Khora\secrets. Los EPVault-CLI.cmd, EPVault-GUI.cmd y wrappers del instalador leídos no configuran por sí mismos la redirección por proceso a data\Fila4; el resolver de almacenamiento no queda fijado por el nombre de la carpeta de instalación.

### 2.4 Dos almacenes cifrados locales distintos

Se observaron dos archivos ep-env-vault.enc.json, sin leer su contenido:

| Ruta | Bytes | Última escritura UTC | SHA-256 |
|---|---:|---|---|
| MOD-EPVAULT/v1.0.0/data/Fila4/Khora/secrets/ | 2.624 | 2026-11-12 23:38:47Z | 55CD00CF9ADA189B6DB2317DD6A0A704DCEED404F25E0A39CCC514A80FA7B8AF |
| EP/local-state/Khora/secrets/ | 3.352 | 2026-11-11 01:50:16Z | 3122C544012F989F0501BD0E82EA920A93F19A42034D83FA682BCC2290891E82 |

Los hashes y tamaños son distintos. El segundo coincide con el ciphertext v7 cuyo upload/read-back B2 se registró anteriormente; esto no demuestra que sea la copia activa. La raíz %LOCALAPPDATA%\Khora\secrets del perfil consultado no existe. Hay backups en ambas ubicaciones.

**Decisión de preservación:** ninguna copia se sobrescribe, combina, mueve o elimina hasta construir un inventario de procedencia, identificar cuál fue la última escritura válida y verificar cada candidato con contraseña local/read-back bajo autorización. No se vuelve a ejecutar Initialize como reparación.

## 3. Arquitectura objetivo de v2

La arquitectura se expresa como propuesta completa para revisión presencial. No está aceptada ni despachada a construcción.

### 3.1 Un solo producto y cuatro superficies

1. **EP Vault Store:** archivo local cifrado autenticado con variables formales y metadatos mínimos.
2. **EP Vault Host:** proceso local de custodia, sin ventana, integrado en MOD-EPVAULT. Mantiene la clave descifrada y el estado de autorización únicamente en memoria durante una sesión. No crea un segundo almacén ni un servicio cloud.
3. **GUI del operador:** se abre para ingresar contraseñas, capturar notas, definir el tipo/duración/expiración y pausar/reanudar. Puede cerrarse después del desbloqueo; no es el proceso que sostiene la sesión.
4. **CLI y canal de agente:** la CLI del operador administra secretos. El modelo solicita operaciones predefinidas por un canal local autenticado; no accede a archivos, memoria, stdout de secretos ni una operación genérica GetSecret.

El Host se inicia al autenticar al operador y continúa sin ventana. Si el Host se reinicia o termina, la autorización en memoria desaparece; nunca se restaura una sesión reutilizable desde un blob DPAPI compartido.

### 3.2 Frontera obligatoria entre el modelo y la custodia

La identidad que ejecuta el modelo/RDC debe ser un usuario Windows separado, estándar y no administrador. No puede leer:

- el almacén EP Vault, notas, backups, logs o raíz de datos;
- la bóveda física Cryptomator ni su directorio de ciphertext;
- el proceso y memoria del EP Vault Host;
- el volumen montado por Cryptomator.

El Host expone un Named Pipe local con ACL de Windows, aceptando únicamente el SID del agente autorizado y las operaciones incluidas en el contrato. Cada llamada se valida por identidad de cliente, consumidor, secreto, operación, destino y expiración. Microsoft documenta PipeSecurity y reglas ACL para Named Pipes; su uso debe probarse con la identidad concreta.

**Bloqueo actual:** las conexiones RDC observadas tienen allowedDirectories=[] y shell PowerShell. La conexión Fila4 ejecuta con la identidad propietaria del workspace. Eso no es confinamiento. Mientras el modelo pueda ejecutar PowerShell/filesystem irrestricto con la misma identidad que abre EP Vault, cualquier intermediación puede saltarse y no se puede prometer secreto no revelado. No se habilita acceso de secretos al modelo hasta cambiar esa frontera o retirar el bypass de shell/filesystem. Si el aislamiento no puede hacerse efectivo en RDC, la función de uso delegado queda bloqueada; no se simula seguridad.

El modelo no recibe bearer token, clave de sesión ni contraseña. La autorización reside en el Host. El modelo solo ve herramientas con operaciones enumeradas y su resultado permitido. Se permite RequestLock; no se permite Unlock ni reanudar después de bloqueo sin autenticación local del operador.

### 3.3 Uso de secretos sin revelarlos

Flujo:

1. El operador desbloquea EP Vault e inicia una concesión local.
2. El Host conserva la clave de descifrado en memoria; el operador puede cerrar la GUI.
3. El modelo solicita una operación nombrada y entrega solo parámetros no secretos.
4. El Host verifica concesión, identidad agente, secreto asignado, operación, destino permitido y caducidad.
5. Un adaptador interno construye la solicitud/proceso permitido e introduce la credencial directamente en su punto de consumo.
6. El adaptador devuelve un resultado saneado; nunca devuelve headers de autorización, variables de entorno, token ni valor secreto.
7. El Host registra la operación sin registrar el valor.

No se expone al modelo una operación genérica Reveal, ReadNote -Reveal, GetSecret, Run con ejecutable/argumentos arbitrarios ni un HTTP proxy de URL libre. Un adaptador futuro solo podrá ejecutar operaciones nominadas, con host HTTPS, método, ruta/esquema de parámetros y tamaño de respuesta permitidos. No se agregan proveedores que el operador no haya requerido. Si una herramienta exige que el modelo reciba la credencial en claro, esa integración no satisface el requisito de v2.

Una acción solicitada que devuelve información de un servicio puede entregar esa información al modelo; lo que no entrega es la credencial usada para obtenerla. El contenido autorizado que el modelo ve sigue siendo susceptible de ser copiado o transmitido por el propio modelo.

### 3.4 Contrato de CLI

**CLI local del operador:**

| Acción | Comportamiento |
|---|---|
| Status | Estado, ubicación lógica y vencimiento; sin valores |
| Unlock | Prompt local protegido; no admite contraseña por argumento, entorno o archivo |
| List | Nombres y metadatos permitidos |
| SetFromClipboard / Set interactivo | Configura el valor desde interacción local; no imprime ni registra el valor |
| Remove | Eliminación formal explícita, con read-back |
| CaptureNote / ListNotes / PromoteNote / DeleteNote | Ciclo de notas con TTL y operaciones explícitas |
| Authorize | Concesión local sobre secreto/consumidor/operación/duración |
| Revoke | Revoca la concesión |
| Lock | Invalida sesión, cierra Host y bloquea Cryptomator según el estado |

**CLI/capacidad del agente:** ListOperations, Use <operationId> y RequestLock, únicamente mediante el Named Pipe. No enumera valores secretos ni acepta ejecutable, script, URL o encabezado libre. RevealVariable y ReadNote -Reveal quedan reservados a una acción local visible del operador; no forman parte del contrato agente. Run genérico se retira del contrato de agente.

La configuración por portapapeles conserva el modo de trabajo local existente, pero se trata como canal de entrada sensible: el historial/sincronización del portapapeles puede mantener copias. El CLI no afirma borrado de esos servicios; ofrece prompt local seguro como alternativa.

### 3.5 Formato criptográfico y ciclo de datos

- Mantener un lector de compatibilidad para el sobre v1.0.0; jamás sustituir el original durante la migración.
- Introducir un sobre versionado v2 con serialización canónica de metadatos autenticados, identificador de formato/KDF, salt aleatorio, IV/nonce según el cifrador, ciphertext y MAC/tag.
- Como baseline compatible con el runtime actual, conservar PBKDF2-HMAC-SHA256 de 600.000 iteraciones y AES-256-CBC + HMAC-SHA256 en esquema Encrypt-then-MAC, con claves derivadas separadas y verificación de MAC antes del descifrado. Esto no se declara certificación FIPS.
- No cambiar automáticamente a Argon2id ni a AES-GCM por moda o por nombre de estándar. OWASP favorece Argon2id para almacenamiento de contraseñas; PBKDF2-HMAC-SHA256 con 600.000 iteraciones es la referencia que señala cuando se requiere FIPS-140. Como la bóveda necesita derivar una clave de cifrado y el runtime actual es PowerShell 5.1/.NET Framework, cualquier cambio exige benchmark, dependencia auditable y migración compatible en una tarea separada.
- Escritura atómica; preservar la versión previa; reabrir y verificar integridad/read-back antes de cambiar el puntero activo.
- Metadata por secreto estrictamente necesaria: nombre/id, versión, creación/actualización y expiración si aplica. La concesión guarda secreto, consumidor, operación/destino, vencimiento, estado y límite de uso si la operación lo requiere.
- Logs de auditoría protegidos por ACL e integridad verificable. No incluyen valores, contraseñas, headers, argumentos sensibles ni cuerpos de solicitud. Para Use/Authorize, si no puede escribirse el evento de seguridad, se deniega la operación. Lock siempre intenta sellar aunque falle la escritura de auditoría y reporta la incidencia.
- Rotar significa reemplazar la credencial con autorización y read-back. Revocar una concesión local bloquea usos posteriores; si la credencial pudo salir al exterior, también debe revocarse/rotarse en el proveedor correspondiente.

## 4. Tipos de ubicación y sesión

Los tipos son una propiedad del **perfil de ubicación**, no identidad de terminal, nivel de confianza ni autorización. La identidad de cada terminal permanece separada; cada almacén local queda delimitado por terminal y ubicación. No se guardan Device IDs ni SessionIds efímeros de RDC en la norma.

### 4.1 Registro mínimo

- session_id: identificador técnico aleatorio de runtime, no folio administrativo.
- location_id: perfil de ubicación.
- terminal_id: identidad canónica de la terminal, separada de la ubicación.
- persistence_type: EFIMERA o NO_EFIMERA, heredado del perfil.
- opened_at_utc y expires_at_utc.
- state: OPEN, PAUSED, SEALING, LOCKED, EXPIRED, ENDED o LOCK_FAILED.
- scope: secretos/operaciones autorizadas durante esa sesión.

No se crea folio por defecto. La ubicación no sustituye la identidad de terminal ni prueba que un host sea confiable.

### 4.2 EFIMERA

- Sesión volátil.
- La GUI ofrece el dropdown ya presente con 15 s, 30 s, 1 min, 2 min, 3 min, 5 min, 10 min y 15 min, más entrada manual dentro del límite de política. Predeterminado: 5 min. La opción de 1 hora del XAML actual no se hereda porque el CLI/Core v1.0.0 no la aceptan de forma consistente.
- Los secretos/notas y artefactos creados en esa ubicación viven en un subárbol temporal controlado por sesión/terminal. Al vencer o dispararse el dead-man, se sella, elimina ese subárbol EP y verifica su ausencia.
- La eliminación es lógica/controlada de los datos pertenecientes a esa ubicación efímera. No se promete borrado forense de bloques SSD, snapshots, memoria, pagefile ni copias de terceros.
- La pausa manual sella acceso y exige reautenticación para reanudar; conserva el subárbol cifrado mientras la sesión no haya vencido. El dead-man por inactividad o expiración finaliza la sesión y lo elimina.

### 4.3 NO_EFIMERA

- Sesión semipermanente con fecha y hora de expiración elegida por el operador.
- Pausa manual, dead-man o expiración revocan autorización, cierran acceso y bloquean Cryptomator.
- Los datos cifrados locales y sus backups controlados no se eliminan por pausa o expiración. El vencimiento de sesión no equivale a borrar el almacén formal.

### 4.4 Pausa y dead-man de 120 segundos

La detección corre en EP Vault Host, no en el modelo ni únicamente en la ventana WPF.

- La pausa manual desde el switch de la GUI empieza el sellado inmediatamente.
- El dead-man se dispara tras 120 segundos sin actividad del operador.
- Teclado/ratón se observan en la sesión interactiva del operador mediante la API de entrada de Windows.
- La voz solo reinicia actividad mediante un evento explícito del cliente de voz cuando capture/reciba entrada del operador. Tener un micrófono abierto no prueba que el operador hable. No se almacena ni transcribe audio para esta función.
- La actividad generada por el modelo/procesos no reinicia el temporizador. Solo actividad del operador mantiene la sesión.
- GetLastInputInfo es específico de la sesión Windows que la consulta; no cubre todas las sesiones Windows del equipo. Por ello el monitor debe residir en la sesión interactiva propietaria y la aceptación debe probar el escenario multiusuario/RDC.
- Secuencia de sellado: bloquear nuevas operaciones → revocar concesiones → drenar solicitudes/escritores/handles → solicitar cierre graceful de procesos autorizados → enviar señal de cierre a Cryptomator CLI → verificar desaparición del montaje → retirar claves/credenciales de memoria y temporales de sesión → aplicar política EFIMERA/NO_EFIMERA.
- Si Cryptomator informa GRACEFUL UNMOUNT FAILED, hay handles abiertos o el volumen sigue visible, el estado es LOCK_FAILED; no se declara sellado ni se inicia backup/sync. El operador debe resolver el handle y repetir la verificación.
- La contraseña maestra local es obligatoria para reanudar. No hay Unlock por token del modelo ni reutilización de una concesión anterior.

## 5. Arranque y relación con Cryptomator

EP Vault y Cryptomator son dos bóvedas distintas:

- Cryptomator cifra el workspace completo.
- EP Vault cifra variables y notas.
- La llave de recuperación de Cryptomator (EP_WORKSPACE_CRYPTOMATOR_RECOVERY_KEY) no es la contraseña maestra de apertura.
- La contraseña maestra de Cryptomator no puede existir únicamente dentro del EP Vault alojado en la misma bóveda: eso crea una dependencia circular.

Secuencia mínima:

1. Un bootstrap pequeño, no secreto, permite abrir la interfaz local antes del montaje. No contiene contraseñas ni ciphertext del almacén formal.
2. El operador introduce localmente la contraseña maestra de Cryptomator. El controlador la entrega al CLI mediante stdin, nunca como argumento, variable de entorno persistente o archivo.
3. Cryptomator CLI monta el workspace con WinFsp; se verifica el volumen.
4. Se inicia EP Vault desde el workspace protegido y el operador autentica su bóveda formal EP Vault.
5. EP Vault Host conserva la clave de sesión en memoria. El operador puede cerrar la ventana y continuar mediante las operaciones headless autorizadas.
6. En pausa/caducidad se bloquea primero la concesión, se drenan operaciones, se desmonta Cryptomator graceful y se verifica ausencia del volumen.
7. Para reabrir, el operador vuelve a introducir localmente la contraseña de Cryptomator y la autenticación de EP Vault. Son secretos diferentes; no se fusionan ni se guardan uno dentro del otro.

La CLI oficial de Cryptomator documenta --password:stdin y WinFsp en Windows. También advierte que handles abiertos pueden impedir el desmontaje graceful. La versión exacta de CLI a fijar debe seleccionarse y probarse contra una copia de bóveda, no actualizarse durante este diseño.

## 6. Interfaz mínima

Una sola GUI local de EP Vault, sin dashboard ni panel administrativo independiente.

- Pantalla de apertura/autenticación local.
- Selector de ubicación/perfil; el tipo se muestra como propiedad heredada, no se cambia por sesión si no se edita el perfil.
- Para EFIMERA: dropdown existente y entrada personalizada con validación.
- Para NO_EFIMERA: fecha/hora exacta de expiración, mostrada localmente y almacenada UTC.
- Un switch de pausa/sellado.
- Estado, tiempo restante y resultado de bloqueo/unmount.
- Campos locales para contraseña y notas efímeras.
- La ventana puede cerrarse sin bloquear si Host mantiene una sesión vigente.
- Reabrir la ventana no renueva automáticamente el TTL ni reactiva una sesión bloqueada.
- No se reutiliza la GUI legacy. La GUI clean-room existente se conserva como baseline visual solo si el retest exacto y la revisión presencial H10 lo aceptan; no se declara aceptada por el test de nombres/XAML.

## 7. Seguridad, límites y calidad verificable

Referencias de ingeniería: OWASP Secrets Management Cheat Sheet y Password Storage Cheat Sheet. Aplicación: mínimo privilegio, ciclo de creación/rotación/revocación/expiración, auditoría protegida, transmisión TLS y nunca registrar secretos. No se declara certificación OWASP.

Límites de amenaza:

- Protege el ciphertext local frente a lectura por usuarios/procesos sin autorización y protege credenciales frente al contexto del modelo si el aislamiento de identidad se cumple.
- No protege contra administrador local hostil, kernel comprometido, malware con privilegios equivalentes al operador ni exfiltración del resultado que el modelo está autorizado a recibir.
- No es posible garantizar que un modelo que ejecuta shell arbitrario bajo la identidad dueña de la bóveda no pueda leerla. Si se mantiene ese bypass, no se habilita el uso delegado de secretos.
- El zeroization de memoria administrada y el borrado físico de SSD no pueden prometerse. El criterio verificable es revocar, terminar procesos autorizados, retirar referencias/buffers mutables, desmontar y comprobar ausencia de acceso.

## 8. Pruebas y aceptación

No se acepta v2 hasta superar como mínimo:

1. Compatibilidad de lectura v1 y migración no destructiva v1→v2, backup previo, lectura de vuelta y restauración.
2. Contraseña incorrecta, modificación del envelope, MAC inválido, salt/IV duplicado, escritura interrumpida, backup anterior preservado y fallo de log.
3. La identidad agente no puede abrir ciphertext, notas, backups, logs, volumen Cryptomator ni inspeccionar Host; no tiene shell/FS de bypass.
4. Reveal, ReadNote -Reveal, Run arbitrario y salida de valores fallan para el agente.
5. Operación autorizada funciona a través del Host; secreto ausente en prompt, stdout, stderr, argumentos, entorno del agente, logs y respuestas.
6. Caducidad, revocación, límite de uso, ubicación y consumidor se verifican en pruebas positivas y negativas.
7. Cerrar GUI mantiene solo una sesión autorizada; matar/reiniciar Host invalida autorización y obliga a autenticar.
8. Switch manual, 120 s de inactividad, teclado, ratón y evento de voz; no se reinicia el timer por actividad del modelo.
9. EFIMERA purga exclusivamente el subárbol de su ubicación/terminal; NO_EFIMERA conserva el ciphertext en pausa y vencimiento.
10. Cryptomator mount/unmount en Windows con WinFsp; handles abiertos; error de graceful unmount; volumen ausente antes de declarar sellado.
11. Prueba en dos identidades Windows y, posteriormente, dos terminales físicas; DPAPI y los datos locales no se comparten accidentalmente.
12. Aceptación visual presencial y lectura de vuelta de artefactos, hashes y documentación.

## 9. Propuesta normativa para DUG — no escrita

Lugar propuesto: ART-013, porque ya regula ubicación, identidad, selección y continuidad. No crear un anexo nuevo.

Texto propuesto:

> Todo perfil de ubicación EP declara un persistence_type obligatorio: EFIMERA o NO_EFIMERA. El tipo es una propiedad de persistencia de la ubicación; no identifica la terminal ni expresa confianza o autorización.
>
> La sesión hereda el tipo del perfil. EFIMERA usa estado y datos locales temporales por terminal/sesión; el vencimiento o dead-man sella el acceso y elimina el subárbol EP propio de esa sesión. NO_EFIMERA es semipermanente y requiere fecha/hora de expiración; al pausar o vencer se sella el acceso y se conserva el ciphertext local.
>
> Ambas sesiones admiten pausa manual. La ausencia de actividad del operador durante 120 segundos dispara el dead-man. Reanudar exige autenticación local; el modelo no puede reabrir una bóveda bloqueada.
>
> Identidad de terminal y perfil de ubicación se registran/se verifican por separado. La actividad del modelo no cuenta como actividad del operador.

**Estado normativo:** propuesta para revisión P012/P013; no insertada en DUG. P005 exige confirmación activa antes de modificar DUG, y P012/P013 exigen revisión presencial para decisiones de seguridad/arquitectura. No se declara aprobación por esta especificación.

## 10. Exclusiones y criterios de no-regresión

- No modificar ni eliminar la bóveda real, los backups existentes, variables, notas o credenciales durante el diseño.
- No actualizar el algoritmo, CLI de Cryptomator, WinFsp, WPF o PowerShell por reflejo.
- No usar Initialize sobre almacenes existentes.
- No mover a una única ruta ni elegir entre las dos copias detectadas hasta cerrar EV2-01.
- No añadir un nuevo OCP, servicio cloud, tablero, agente, monitor general ni sistema de folios.
- El producto sigue siendo MOD-EPVAULT, y EP-TASK-004 sigue siendo la tarea propietaria.

## 11. Estado de cierre del diseño

EP_VAULT_V2_DESIGN=INTEGRATED_DRAFT; V1_SYNTHETIC_BASELINE_TEST=PASS; LOCAL_V1_TREE=HASH_DIVERGENCE; LOCAL_VAULT_ROOTS=2_DISTINCT_CIPHERTEXTS_UNRESOLVED; AGENT_ISOLATION=REQUIRED_NOT_PRESENT; 120S_IDLE_DEADMAN=NOT_IMPLEMENTED; EFIMERA_NO_EFIMERA=DESIGN_DEFINED_DUG_PROPOSAL_PENDING; CRYPTOMATOR_REAL_MOUNT_INTEGRATION=NOT_TESTED; P012_P013_REVIEW=REQUIRED; BUILD=NOT_DISPATCHED.

**Conclusión:** el diseño objetivo está integrado para revisión. La implementación no debe empezar hasta superar la revisión presencial de seguridad/arquitectura y el gate de baseline/rutas. Ninguna característica futura se presenta como ya implementada o aceptada.

## Referencias técnicas

- [OWASP Secrets Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)
- [OWASP Password Storage Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)
- [Microsoft: GetLastInputInfo](https://learn.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getlastinputinfo)
- [Microsoft: NamedPipeServerStreamAcl](https://learn.microsoft.com/en-us/dotnet/api/system.io.pipes.namedpipeserverstreamacl)
- [Cryptomator CLI](https://github.com/cryptomator/cli)
- [Cryptomator: Volume Types](https://docs.cryptomator.org/desktop/volume-type/)
