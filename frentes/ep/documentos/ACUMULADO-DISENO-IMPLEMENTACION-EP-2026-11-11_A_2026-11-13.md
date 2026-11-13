# Acumulado de diseño e implementación · Entorno Persistente (EP)

**Corte documental:** 13 de noviembre de 2026  
**Ventana reconstruida:** 11–13 de noviembre de 2026; el diseño específico de Cryptomator y la reorganización del workspace se concentran el 12 de noviembre.  
**Clase de documento:** reconstrucción acumulativa, técnica y de procedencia; documento complementario no normativo.  
**Frente propietario:** Entorno Persistente (EP).  
**Fuente rectora:** [OEP.md](../OEP.md), único objeto canónico vivo del frente.  
**Tareas relacionadas:** EP-TASK-002, 003, 004, 005, 006, 007 y 008; EP-TASK-001 se mantiene como línea NCL independiente y diferida.  
**Estado global al corte:** diseño consolidado en gran parte; implementación parcial; migración criptográfica integral y aceptación de EP pendientes.

> Este documento reúne la evolución del diseño y la implementación observada en las conversaciones del sprint. No sustituye al OEP, no crea otro OCP ni modifica por sí solo decisiones normativas. Cuando una afirmación histórica difiera del último estado canónico verificado, prevalece el OEP vigente y la ficha de tarea correspondiente. Se conserva la procedencia de decisiones supersedidas para que no se confundan con instrucciones actuales.

---

## 1. Propósito y resultado ejecutivo

El trabajo reconstruido no fue solamente «instalar Cryptomator». El objetivo acumulado es convertir SeryMente en un espacio de trabajo persistente, protegido y recuperable, con aplicaciones y datos confinados, custodia de secretos separada, acceso remoto controlado, respaldo remoto del ciphertext y capacidad para reanudar el trabajo desde otras terminales.

La arquitectura de destino tiene estas capas:

1. **Workspace:** SeryMente es la única raíz lógica de trabajo; contiene repositorios, frentes, ámbitos, módulos, datos por terminal y espacio temporal. Se utiliza a través del montaje de una bóveda Cryptomator.
2. **Cifrado del workspace:** Cryptomator cifra los archivos, nombres y estructura del árbol. El almacenamiento físico contiene ciphertext y queda fuera del punto de montaje para evitar recursión.
3. **Confinamiento de aplicaciones:** perfiles, configuración, extensiones, cookies/sesiones, cachés, logs, temporales, bases locales, descargas y demás datos de usuario de cada aplicación deben permanecer dentro de SeryMente, normalmente bajo el módulo propietario.
4. **Secretos:** EP Vault conserva valores individuales, variables formales y notas efímeras; es una bóveda separada de la bóveda Cryptomator. DPAPI protege sesiones/notas por identidad Windows y no se comparte automáticamente entre terminales.
5. **Acceso del modelo:** ChatGPT coordina y opera mediante RDC. El futuro EP Access Broker debe mediar una concesión temporal, sin dar al modelo una credencial bearer o la llave maestra. El diseño aún no está implementado.
6. **Respaldo remoto:** Backblaze B2 conserva ciphertext generado en el lado cliente. Rclone se propone como motor de transferencia; RDC es el canal de ejecución, no el motor de transferencia.
7. **Toolchain de ingeniería:** BMAD 6.12.4, OpenCode 1.19.5 y Groq se probaron como cadena de trabajo complementaria. Esta integración no equivale a aceptar el workspace cifrado ni su confinamiento integral.
8. **Continuidad:** cada terminal debe tener identidad individual, credenciales locales propias, dependencias verificadas y un procedimiento de incorporación/recuperación. Dos conexiones RDC al mismo PC no son dos terminales físicas.

**Resultado inequívoco al 13-11-2026:** Cryptomator Desktop está instalado; existe una bóveda real llamada «entorno-persistente» y se verificó su bloqueo; la llave de recuperación quedó formalizada en EP Vault con lectura de vuelta; una prueba CLI sintética pasó; BMAD/OpenCode/Groq produjeron inferencia real; el ciphertext formal de EP Vault tiene un respaldo B2 v7 con lectura de vuelta y descifrado aislado. Sin embargo, el workspace SeryMente completo —inventario preliminar de 22.890 archivos y 2.125.828.543 bytes— **no se migró a Cryptomator y sigue en claro**. El montaje graceful de Cryptomator en Windows, la prueba de CLI oficial estable contra la bóveda real, el confinamiento integral de aplicaciones, el respaldo B2 del workspace, la recuperación cross-host y el Access Broker siguen pendientes.

---

## 2. Alcance de la reconstrucción y fuentes revisadas

### 2.1 Exportaciones de conversación examinadas de extremo a extremo

Se revisaron los tres exports del frente EP que cubren la secuencia reconstruida. Se leyeron todos sus tramos, no solo los primeros mensajes ni la salida final.

| Export original en Downloads | Rango de conversación | Líneas | Bytes | SHA-256 |
|---|---|---:|---:|---|
| ChatGPT-EP (1)-20261112-1127.md | Creada 11-11-2026 17:18; actualizada 12-11-2026 11:26; exportada 12-11-2026 11:27 | 1.619 | 64.269 | A858D82807A7F08B4B1B4CAF828136224F22AD8A086284BF9CE65B2DD5BA6F56 |
| ChatGPT-EP (1)-20261112-1632.md | Creada 12-11-2026 12:34; actualizada 12-11-2026 16:30; exportada 12-11-2026 16:32 | 1.926 | 99.410 | 9A64A7265901B70D92DBB2752BB23E273915B99CEC3D98115979660766FCF617 |
| ChatGPT-EP-20261113-0958.md | Creada 12-11-2026 17:01; actualizada 13-11-2026 09:55; exportada 13-11-2026 09:58 | 899 | 42.368 | 17E8F33F3425C7B2DF2ADC859EEC36D02D8B956FEC1B9247AEDA4C3955E7380A |
| **Total** | **11–13 de noviembre de 2026** | **4.444** | **206.047** | **Hashes individuales arriba** |

Los SHA-256 se calcularon sobre los archivos fuente locales mediante lectura de solo metadatos/contenido; no se modificaron los exports. Los archivos fuente permanecen en Downloads. Este documento no afirma que las tres conversaciones originales se hayan copiado a Git ni que exista una preservación byte-exacta remota de ellas.

### 2.2 Fuentes canónicas de contraste en main

Se leyeron y cotejaron, entre otras, las siguientes fuentes de SeryMente/metodologia:

- [OEP.md](../OEP.md), versión v0.3.92 al iniciar esta reconstrucción; blob leído: `ffb6d42cecfc546c3772b4e58adeab752dbc4e2f`. Se revisaron en particular §§136–144.
- [EP-TASK-002 · Persistencia Backblaze](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-002%20-%20Persistencia%20provisional%20Backblaze/README.md), blob `3264575224030ffffd60ce0dfc64a785e968124b`.
- [EP-TASK-003 · Workspace Cryptomator](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcci%C3%B3n%20EP/README.md), blob `0b1626fa6bc3d34a34c19c6acab26fc74511dcb4`.
- [EP-TASK-004 · EP Vault](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-004%20-%20Reconstrucci%C3%B3n%20de%20b%C3%B3veda/README.md), blob `a6bb595e4403220aa4fb2f01fd3c68c95555b500`.
- [EP-TASK-005 · MCP-OCP local](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-005%20-%20Instalaci%C3%B3n%20y%20aceptaci%C3%B3n%20de%20MCP-OCP%20local/README.md), blob `73affa4ac74604fdb523ed8666742f838c925b2c`.
- [EP-TASK-006 · Variables de entorno](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-006%20-%20Centralizaci%C3%B3n%20de%20variables%20de%20entorno/README.md), blob `48d4e861d872990059caabee19947e3de8324d70`.
- [EP-TASK-007 · Sesión/Guardian](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-007%20-%20Guardi%C3%A1n%20de%20sesi%C3%B3n%20ef%C3%ADmera%20e%20inventario%20del%20host/README.md), blob `69eb211b5ab4ebbc9b7c3f39919beac652e112d2`.
- [EP-TASK-008 · Product Design](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-008%20-%20vMAT%20Product%20Design%20-%20Captura%20verbatim%20y%20tareas%20ejecutables%20con%20Superpowers/README.md), blob `7bd3aeed1b509d7a0d1d100a7b19a282ef96d353`.
- [Índice de tareas provisionales](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/README.md), blob `85196180677ed827fa50d184deedfc7227224687`.
- [README del frente EP](../README.md), blob `052a835d7d3e0b997a790ba2f7ad647d64bf4683`.

Los blobs citados son las revisiones leídas antes de esta actualización; no son hashes del presente documento ni prueba de una nueva implementación.

### 2.3 Límite de alcance

El frente de trabajo reconstruido es EP. Los hilos independientes de Harmonia/Loop/telemetría y Product Design que aparecen en otros exports de Downloads no se fusionan aquí como si fueran el mismo sprint. Se conserva su relación real: EP-TASK-008 y MOD-EP-PRODUCT-DESIGN consumen BMAD/OpenCode y pertenecen a EP, pero la implementación de Harmonia, Loop y su telemetría tiene su propio frente/objeto y aceptación. No se incorporan al alcance de cifrado del workspace.

---

## 3. Cronología reconciliada

### 11 de noviembre de 2026 · reanudación y backlog

El export EP iniciado a las 17:18 recupera el orden de trabajo y el problema de almacenamiento existente. En ese punto aparecían diseños y observaciones anteriores de VHDX/BitLocker, el volumen W: vacío/descifrado, y gates de MCP-OCP. Se aclaró repetidamente que el estado del host debía distinguirse de la propuesta documental y que el usuario no quería reiniciar diagnósticos o repetir autorizaciones innecesarias.

El orden histórico de ejecución ya había sido reorganizado como EP-TASK-002 → EP-TASK-003 → EP-TASK-005 → EP-TASK-001, dejando NCL al final. Las tareas EP-TASK-004, 006 y 007 conservan sus alcances independientes y sus relaciones de dependencia; no se cancelan por no pertenecer a la cola inmediata.

### 12 de noviembre de 2026 · cambio de paradigma de cifrado

Por la mañana se convirtió en especificación un requisito explícito: proteger el árbol completo C:\Users\fila4\Desktop\SeryMente con contraseña maestra independiente de Windows, cifrando contenido, nombres y estructura; no desarrollar criptografía propia. Se adoptó Cryptomator como motor existente.

La decisión sustituyó el diseño EP anterior que proponía VHDX/BitLocker como mecanismo de protección del workspace. No se debía crear un archivo 7z como sustituto ni cifrar W: vacío pensando que eso protegía SeryMente. VHDX y BitLocker quedan fuera del mecanismo de protección de EP; cualquier residuo legado se conserva hasta inventario y limpieza verificada. BitLocker puede mantenerse como defensa del disco anfitrión, pero no es requisito funcional del workspace.

En paralelo, el operador corrigió la estructura de la raíz SeryMente y exigió que las herramientas de sesión EP se instalaran bajo sus módulos y que todo dato de usuario de las aplicaciones quedara dentro del workspace protegido.

### 12 de noviembre de 2026 · CLI, módulos y toolchain

Se estableció CLI como régimen ordinario. Se identificó que la CLI estable 0.6.2 no ofrecía creación inicial en el alcance documentado; se examinó la rama oficial develop con el subcomando create y se compiló un build local desde un commit upstream firmado. Esa build fue etiquetada como SNAPSHOT/local, no como release estable oficial.

En paralelo se materializaron BMAD 6.12.4 y OpenCode 1.19.5, se corrigió la integración Groq retirando un adaptador OpenAI-compatible personalizado y usando el proveedor Groq nativo, y se probó una inferencia real. Chrome existente fue reutilizado con un perfil EP separado. La instalación y prueba de estas herramientas es una línea paralela de trabajo; no sustituye la migración criptográfica.

### 12 de noviembre de 2026 · creación real y cierre parcial de la bóveda

Se preparó inicialmente C:\Users\fila4\EP\modulos\MOD-EP-CRYPTO\vault-store\ como almacenamiento físico fuera de la futura raíz montada. El operador eligió finalmente otra ubicación durante la creación: C:\Users\fila4\entorno-persistente\. Esa ubicación real debe conservarse; la carpeta vault-store preparada quedó vacía. No se debe mover, duplicar ni reemplazar la bóveda real solo para ajustarla a la ruta de diseño sin inventario, preservación y read-back.

La bóveda se creó con Cryptomator Desktop y se observó la estructura formal (vault.cryptomator, masterkey.cryptomator y árboles cifrados). Se añadió un archivo lateral, se comparó su SHA-256 con el del archivo dentro de la bóveda y se retiró la copia lateral tras cotejarla. El cierre de la ventana no desmontó correctamente el volumen; se terminó el árbol de procesos y se comprobó que D: desapareció y que ya no quedaban procesos Cryptomator. Eso prueba ausencia posterior del montaje, pero **no** un desmontaje graceful.

La llave de recuperación se capturó como nota efímera y se promovió después a la variable formal EP_WORKSPACE_CRYPTOMATOR_RECOVERY_KEY. EP Vault devolvió PROMOTED_READBACK_VERIFIED_NOTE_REMOVED; ListVariables confirmó el nombre, la nota fue retirada y EP Vault quedó bloqueada. El valor no se incorporó a este documento.

### 12–13 de noviembre de 2026 · diseño de persistencia remota y autorización delegada

Se estudió la separación RDC/Rclone/Git, el flujo de copia del ciphertext Cryptomator a Backblaze B2, la recuperación desde otro host, y la posibilidad de una estación Windows cloud. Se determinó que el trial de Kamatera no cumple el requisito de gratuidad sin tarjeta ni depósito; no se creó cuenta ni servidor.

Se diseñó EP Access Broker V0.1 como concesión de sesión de baja fricción iniciada desde EP Vault, con TTL y alcance explícitos, pero sin emitir un bearer token al modelo. Se identificó que el broker no sería una barrera de seguridad real si el proceso del agente conserva shell o acceso directo al filesystem bajo la identidad dueña del workspace. Este hallazgo es un gate central del diseño y no debe perderse.

---

## 4. Decisiones de diseño vigentes

### 4.1 Cryptomator sustituye VHDX/BitLocker para el workspace

- Motor: formato de bóveda Cryptomator oficial.
- Contenido: archivos, nombres y estructura de directorios cifrados.
- Contraseña: exclusiva de la bóveda y distinta de la contraseña Windows.
- Almacén físico: carpeta separada de SeryMente montada, para evitar recursión.
- Montaje: SeryMente lógico y accesible como filesystem solo mientras la bóveda está desbloqueada.
- Bloqueo: detener escrituras, cerrar handles, desmontar de forma graceful y comprobar que el punto montado desapareció.
- Clave de recuperación: custodia separada en EP Vault, no junto al ciphertext, no en Git, logs, variables de entorno ni chat.

No se promete «inmunidad absoluta». Si la bóveda está desbloqueada, el contenido se presenta en claro al sistema y a las aplicaciones autorizadas. Malware, administradores del host o procesos con permisos suficientes pueden acceder a ese contenido mientras está montado. Si atacante obtiene también la contraseña maestra o una llave utilizable, el ciphertext puede dejar de ser confidencial.

### 4.2 Árbol lógico de SeryMente

La raíz única es SeryMente/. Los repositorios viven como hijos directos de esa raíz; cada repositorio mantiene sus frentes canónicos; cada frente tiene ambitos/ y modulos/; cada módulo separa como mínimo app/, data/<terminal>/, config/, cache/, temp/, logs/ y downloads/. Temporal/ pertenece también a SeryMente y no es una salida para guardar datos operativos en claro fuera del workspace.

No debe reaparecer SeryMente/Repositorios/ como carpeta agregadora. No inventar frentes, ámbitos ni módulos para conseguir simetría. Los repositorios con contenedor canónico frentes/ —como Metodología— conservan su propia organización.

### 4.3 Confinamiento integral de aplicaciones

La obligación no se satisface instalando solo el ejecutable dentro del módulo. Deben quedar bajo SeryMente los perfiles, configuración, plugins/extensiones, cookies/sesiones, preferencias, caches, historial, bases locales, logs, temporales, descargas, backups, crash dumps y demás persistencia de usuario.

Los launchers pueden asignar rutas de proceso mediante variables y opciones del producto (APPDATA, LOCALAPPDATA, HOME, XDG_*, TEMP, TMP, --user-data-dir, etc.), pero esto no demuestra por sí solo confinamiento. Se requiere observar escrituras reales, leerlas de vuelta y confirmar que no quedan nuevas escrituras de usuario en perfiles Windows u otras rutas externas. Si una aplicación no puede confinar datos, aplica fail closed: no se utiliza en la sesión EP hasta resolverlo o sustituirla.

### 4.4 Bootstrap mínimo previo al unlock

Cryptomator necesita existir antes de abrir la bóveda que contiene SeryMente. Por tanto, se admite un bootstrap externo mínimo para desbloquearla. La excepción no incluye perfiles, contraseñas, claves, logs, cachés, temporales o datos de usuario. Una vez montado el workspace, configuración y registros operativos deben quedar confinados dentro.

WinFsp es una dependencia del sistema para el montaje nativo en Windows; sus drivers/servicios administrados por el sistema deben inventariarse. No se confunde la ubicación del driver con autorización para persistir perfiles o datos de usuario fuera del workspace.

### 4.5 Régimen CLI y excepción GUI expresa

El régimen predeterminado es CLI. Una instrucción explícita e inequívoca del operador para abrir o utilizar una GUI concreta autoriza esa aplicación y el alcance solicitado, conforme a OEP §138.1. La autorización para una GUI no permite automatizar clicks no pedidos, revelar contraseñas o saltarse pruebas de integridad, autenticación y confinamiento.

La GUI de Cryptomator se utilizó por orden expresa del operador para crear personalmente la bóveda real. Para la operación ordinaria se mantiene CLI como objetivo. No volver a imponer el segundo monitor como veto de una instrucción expresa; tampoco asumir que la GUI queda autorizada permanentemente.

### 4.6 EP Vault es distinta de Cryptomator

- **Cryptomator:** protege el workspace persistente.
- **EP Vault:** protege valores individuales, variables formales y notas efímeras.
- **DPAPI CurrentUser:** protege notas y sesiones vinculadas a una identidad Windows local; no hace esas credenciales portables a otra terminal.
- **Llave de recuperación Cryptomator:** se formalizó bajo EP_WORKSPACE_CRYPTOMATOR_RECOVERY_KEY, con read-back verificado y sin mostrar su valor.
- **Contraseña maestra Cryptomator:** no se presume igual a la llave de recuperación ni a la contraseña maestra de EP Vault. El mecanismo CLI debe recibir la contraseña local mediante stdin y nunca desde chat, argumentos visibles o archivos.

EP Vault v1.0.0 documenta un sobre con PBKDF2-HMAC-SHA256 y 600.000 iteraciones, separación de claves AES/HMAC, AES-256-CBC y HMAC-SHA256. La validación HMAC debe preceder al descifrado. Las notas efímeras usan DPAPI CurrentUser y tienen TTL independiente del TTL de sesión de Vault. El documento de EP Vault registra una incompatibilidad entre la duración de sesión de 3.600 s permitida por la GUI y el límite de importación CLI que llega a 900 s; existe un hotfix de trabajo, pero no se considera release integrada/aceptada.

### 4.7 Respaldo B2 y función de cada herramienta

- **RDC:** canal de ejecución remota y recuperación de resultados.
- **Rclone:** motor de transferencia/sincronización hacia backends como Backblaze B2.
- **Git:** reconstrucción y versionado de repositorios; no respalda por sí mismo todo el workspace ni archivos sin seguimiento.
- **Robocopy:** candidato para la migración local inicial desde la fuente en claro al montaje Cryptomator, después de inventario y revisión de reparse points.
- **Cryptomator:** ya genera ciphertext. No añadir rclone crypt sin un requisito adicional aprobado.

La secuencia objetivo para respaldo consiste en detener escrituras, cerrar handles, bloquear y desmontar de forma graceful, copiar el ciphertext físico con Rclone copy, comprobar mediante Rclone check y guardar recibo. Rclone copy no elimina excedentes; Rclone sync sí puede borrar y no se acepta como rutina automática sin dry-run, revisión y retención. La sincronización nunca debe operar sobre una bóveda abierta para escritura en dos ubicaciones simultáneas. Una sola ubicación escritora activa.

### 4.8 EP Access Broker V0.1

Diseño propuesto, aún no implementado:

1. El operador desbloquea EP Vault localmente y crea una concesión con nombre, alcance y duración.
2. El broker recibe la autorización por canal local protegido y conserva el estado en memoria.
3. El modelo recibe herramientas o una referencia de sesión no secreta; no recibe el token bruto ni la clave maestra.
4. El alcance inicial considerado es SeryMente/ con lectura/escritura/creación, excluyendo EP Vault, contraseñas, recovery keys, tokens y perfiles/secretos por terminal.
5. EP Vault puede cerrarse después de emitir la concesión. El broker mantiene la concesión hasta TTL o revocación.
6. Reiniciar broker/host invalida la concesión y requiere autorización nueva.
7. Al vencer/revocar se bloquean nuevas operaciones, se drenan escritores/handles, se cierran procesos autorizados, se desmonta Cryptomator y se verifica ausencia del volumen.

**Gate técnico indispensable:** el agente debe ejecutarse bajo una identidad Windows separada, no administradora y sin lectura directa del almacén físico, EP Vault o claves. Si el modelo conserva shell directo y filesystem amplio, puede eludir el broker. La configuración RDC observada con allowedDirectories=[] no limita el acceso al workspace y no equivale a confinamiento.

Cryptomator expone el namespace completo de la bóveda montada a la identidad con acceso al montaje. El broker puede restringir lógicamente las rutas/operaciones que ofrece, pero no consigue que una carpeta se descifre criptográficamente de forma aislada dentro de la misma bóveda. Compartimentos criptográficos genuinos requerirían bóvedas separadas. El broker tampoco impide que un modelo copie o transmita contenido que ya está autorizado a leer ni protege frente a un administrador hostil del equipo.

### 4.9 Servicios de secretos de OpenAI: límites de aplicabilidad

Se identificaron tres superficies diferentes:

- ChatGPT Connected Apps / OAuth: puede autorizar un proveedor y exponer herramientas sin mostrar el valor del token al modelo; la disponibilidad de custom MCP OAuth en ChatGPT depende del plan y del soporte de refresh/offline tokens.
- Codex Cloud Personal vault: aplica a tareas de Codex Cloud; una variable de entorno es visible para la tarea que la recibe, mientras que un network secret se puede inyectar mediante proxy para destinos permitidos sin exponer el valor crudo al proceso. No entrega automáticamente secretos a un Windows self-hosted operado vía RDC.
- OpenAI Agents API Vault: administra secretos fuera de instrucciones/configuración para sesiones API, MCP y entornos alojados compatibles; un host self-hosted sigue necesitando un proxy/broker propio.

No son sustitutos intercambiables de EP Vault ni integraciones automáticas con RDC.

### 4.10 Windows cloud / Kamatera

El host observado en Fila 4 fue un HP ProDesk 400 G4 DM, Intel i7-8700T (6C/12T), RAM 15.8 GB, SSD reportado 238.5 GB y 23.1 GB libres en C: al corte de §143. W: era un disco virtual de 30 GB, no un segundo SSD físico.

La prueba de Kamatera observada exige tarjeta válida o, en su defecto, depósito reembolsable por PayPal; por tanto no satisface el requisito actual de probar sin tarjeta ni depósito. No se creó cuenta ni servidor. La configuración objetivo para evaluación se dejó como candidato 8 vCPU/16 GB/256 GB NVMe Tipo B, sin cotización final ni benchmark. La motivación principal del cloud desktop es aislamiento, administración y movilidad, no una superioridad de rendimiento que todavía no se ha medido.

---

## 5. Implementación efectivamente observada

### 5.1 Cryptomator y EP-CRYPTO

| Elemento | Estado al corte | Alcance real |
|---|---|---|
| Cryptomator Desktop | INSTALADO | 1.19.6.6588; firma Authenticode válida de Skymatic GmbH. |
| WinFsp | INSTALADO | Dependencia Windows para montaje; versión observada 2.1.25156. |
| Módulo EP-CRYPTO | DISEÑO DOCUMENTADO / CONSOLIDACIÓN PENDIENTE | OEP define MOD-EP-CRYPTO y sus responsabilidades; la instalación previa bajo Herramientas no equivale a consolidación completa en app/ y cli/. |
| CLI local | BUILD LOCAL / NO RELEASE ESTABLE | Construida desde upstream firmado; versión SNAPSHOT/local, no tag estable. |
| Pruebas CLI locales | PASS SINTÉTICO | 12 unitarias y 5 de integración; create/unlock sintético y round-trip de 37 bytes mediante fallback WebDAV. |
| CLI oficial estable | 0.6.2 IDENTIFICADA | Acepta password por stdin y montaje, pero su tag estable examinado no tenía create; no se probó contra la bóveda real. |
| Vault real | CREADA Y BLOQUEADA | Nombre entorno-persistente, ruta C:\Users\fila4\entorno-persistente\, formato observado 8. |
| Workspace completo | NO MIGRADO | Sigue en C:\Users\fila4\Desktop\SeryMente, en claro. |
| Desmontaje graceful Windows | NO VERIFICADO | La unidad D: desapareció tras terminar el árbol de procesos; no se acredita cierre graceful. |

La build local probó create/unlock sintéticos y ausencia de nombres/contenido sintético en el árbol físico. La prueba se hizo con un fallback WebDAV y no demuestra el montaje nativo WinFsp de producción. El wrapper reproducible PowerShell 5.1, limpieza del staging sintético, comportamiento del CLI estable sobre formato 8 y desmontaje graceful Windows continúan pendientes.

### 5.2 Bóveda real y datos del workspace

La bóveda real se encontró en C:\Users\fila4\entorno-persistente\. La ubicación preparada C:\Users\fila4\EP\modulos\MOD-EP-CRYPTO\vault-store\ quedó vacía. La bóveda física contiene metadatos y árboles ciphertext de Cryptomator. Solo se confinó un archivo lateral (IMPORTANTE.rtf) con SHA-256 cotejado; el almacén total seguía siendo de pocos KB al corte.

El origen SeryMente conserva un inventario preliminar de 22.890 archivos y 2.125.828.543 bytes. Se registró un reparse point cuyo objetivo/ruta no quedó resuelto en el preflight. No existe todavía manifiesto exhaustivo final ni verificación de archivos excluidos/objetivos de reparse points. No se ha copiado el árbol completo a la bóveda. El original permanece intacto en claro y no se debe borrar, mover ni sobrescribir antes de una migración verificada y aceptación.

### 5.3 EP Vault y custodia de recuperación

La variable formal EP_WORKSPACE_CRYPTOMATOR_RECOVERY_KEY fue promovida desde una nota DPAPI con resultado PROMOTED_READBACK_VERIFIED_NOTE_REMOVED. La consulta de metadatos confirmó el nombre de la variable; el núcleo verificó la lectura de vuelta del valor y retiró la nota. EP Vault terminó bloqueada. El valor de la llave no se conserva en este documento.

La sesión EP Vault y el TTL de la nota son temporizadores distintos. La nota puede vencer aunque la sesión siga abierta, y la sesión puede cerrarse antes que la nota. DPAPI CurrentUser liga las notas/sesiones a la identidad Windows local; dos conexiones RDC a diferentes usuarios Windows del mismo equipo no convierten DPAPI en credenciales compartidas ni equivalen a dos equipos.

### 5.4 Reorganización de SeryMente

En Fila 4 se materializó una reorganización inicial: GDP, KHORA, RAP, Metodología y signal-interpreter pasaron a carpetas directas bajo SeryMente; el contenedor intermedio Repositorios quedó retirado; se crearon ambitos/ y modulos/ en frentes identificados; y se actualizó SeryMente/README.md. Una copia anterior de signal-interpreter se preservó en Temporal/Staging antes de promover la copia que contiene .git.

Quedaron residuos estructurales SeryMente/EP y SeryMente/Herramientas que no se movieron mientras Cryptomator estaba en uso. La materialización local de Metodología no tenía .git; la fuente canónica sigue siendo el repositorio remoto SeryMente/metodologia en main. La reorganización física inicial no prueba que toda la estructura esté dentro de la bóveda ni que el confinamiento esté aceptado.

### 5.5 BMAD, OpenCode, Groq y Chrome

| Componente | Resultado observado |
|---|---|
| BMAD | 6.12.4 instalado en MOD-EP-BMAD; módulos core y bmm confirmados en proyecto aislado. BMAD v7 se mantuvo fuera por ser preview alpha. |
| Skills y comandos | 29 skills y 29 comandos generados en proyecto de humo; no significa que todos los flujos hayan sido aceptados. |
| OpenCode | 1.19.5 instalado como release autónoma verificada; rutas principales redirigidas al módulo. Auditoría completa de escrituras/subprocesos pendiente. |
| Groq | Proveedor nativo configurado; modelo groq/openai/gpt-oss-120b reconocido. |
| API key Groq | Se capturó en nota DPAPI efímera y se inyectó al proceso OpenCode como GROQ_API_KEY solo en memoria; no se guardó en auth.json/config/Git/logs/conversación. |
| Inferencia | PASS observado: OpenCode autenticó, reconoció BMAD Core/BMM y bmad-help, devolvió marcador BMAD_GROQ_E2E_OK y exit code 0. |
| BMAD write/read-back | NOT VERIFIED: el segundo ensayo de creación de archivo no produjo artefacto verificable. |
| Chrome | Chrome 157.0.8103.51 fue reutilizado con perfil EP separado en MOD-EP-CHROME; se observaron escrituras de perfil y caché allí. No equivale a auditoría de todo Chrome ni traslado del binario global. |
| Multi-terminal | NOT VERIFIED; solo Fila 4 fue probado. |

La cadena ChatGPT → RDC → Fila 4 → launcher → OpenCode → Groq → respuesta quedó demostrada en un escenario acotado. ChatGPT no adquiere por ello los workflows BMAD como capacidades nativas; OpenCode los ejecuta localmente y ChatGPT inspecciona sus resultados por RDC.

### 5.6 Backblaze B2

Se conserva un resultado histórico sólido pero de alcance limitado: el ciphertext formal de EP Vault (3.352 bytes en el corte v7) fue subido a OCP-MCP/ep-ocp/vault/2026-11-11/204115282Z-92db986d/ep-env-vault.enc.json; la descarga de vuelta coincidió en tamaño y SHA-256 3122C544012F989F0501BD0E82EA920A93F19A42034D83FA682BCC2290891E82; SSE-B2/AES256 fue confirmado; una copia aislada pasó HMAC/AES y contó 30 propiedades, con los cinco nombres EP B2 esperados. No se mostró ningún valor secreto.

Esto no es un backup del workspace ni restauración cross-host. El inventario P1 anterior contabilizó 4.123 archivos y 362.011.264 bytes en un corte distinto y encontró cero conjuntos de datos elegibles en Datos/. Ese inventario no debe compararse directamente con el inventario posterior de 22.890 archivos/2.125.828.543 bytes: corresponden a momentos y alcances de escaneo diferentes. No hubo upload de un archivo completo de SeryMente a B2.

Los ZIP históricos R2/R3/R4 sin cifrado cliente no se aceptan como solución de respaldo del workspace. SSE-B2 protege el objeto en el almacenamiento del proveedor, pero no sustituye la obligación de enviar únicamente ciphertext generado por Cryptomator. EP-TASK-002 sigue en_curso.

### 5.7 Estado de las tareas provisionales

| Tarea | Estado observado | Relación con el acumulado |
|---|---|---|
| EP-TASK-001 · NCL | en_curso; preflight parcial, datos/perfiles no migrados, handshake Native Messaging y KeeShare pendientes. | Línea independiente de navegador compartido/gestor de credenciales; fue diferida al final en la cola de noviembre. |
| EP-TASK-002 · Backblaze | en_curso; Vault ciphertext v7 upload/read-back y descifrado aislado PASS; workspace backup cliente, cross-host e idempotencia pendientes. | Persistencia remota del ciphertext y continuidad. |
| EP-TASK-003 · Workspace Cryptomator | en_curso; vault real creada/bloqueada, contenido parcial; recovery key read-back verificado; migración no iniciada; CLI local y tests sintéticos PASS. | Núcleo del cifrado y confinamiento del workspace. |
| EP-TASK-004 · EP Vault | en_curso; reconstrucción de bóveda, GUI/CLI/headless, TTL, seguridad y confinamiento; aceptación integral pendiente. | Custodia separada de variables/notas y fuente formal de concesiones futuras. |
| EP-TASK-005 · MCP-OCP | pendiente/bloqueada; espera storage Cryptomator aceptado y paquete v389 reconciliado; instalación no ejecutada, IPZ E2E no ejecutada. | Runtime MCP-OCP depende del workspace protegido y del artefacto correcto. |
| EP-TASK-006 · Variables | en_curso; 52 entradas del proyecto Vercel cotejadas por metadatos; 9 read-back verificados, 1 no importada (GROQ_API_KEY) y 42 valores no recuperables; adaptadores pendientes. | Centralización y distribución segura de credenciales. |
| EP-TASK-007 · Sesión/Guardian | en_curso; inventario parcial read-only; Guardian, lease, triggers, lock/unmount y limpieza no ejecutados; ubicación sin clasificar. | Ciclo de vida de sesión y cierre seguro; no debe confundirse con Access Broker. |
| EP-TASK-008 · Product Design | en_curso; captura verbatim y configuración Superpowers v7.0.2 descargada; runtime discovery no verificado. | Línea paralela de ingeniería/producto que consume BMAD/OpenCode; no es gate de cifrado del workspace. |

Los estados anteriores son snapshots de las fichas leídas en main en este ciclo. No modifican las fechas ni declaran pruebas nuevas.

---

## 6. Riesgos, límites y bloqueos decisivos

1. **Riesgo principal actual:** el workspace completo permanece en claro. La bóveda real protege solo una cantidad mínima de datos.
2. **Ruta física divergente:** vault-store fue la ruta de diseño inicial, pero la bóveda real existe en C:\Users\fila4\entorno-persistente\. No se debe mover por consistencia estética; primero inventario, preservación y read-back.
3. **CLI contra bóveda real:** la build local pasó pruebas sintéticas, pero la CLI oficial estable 0.6.2 no se probó contra la bóveda real en formato 8. La build SNAPSHOT local no debe rotularse como release oficial.
4. **Cierre Windows:** ausencia de D: después de terminar procesos no es una prueba de desmontaje graceful. La implementación final debe cerrar handles, drenar escrituras y desmontar con el mounter nativo WinFsp.
5. **Reparse point:** existe un reparse point en el inventario preliminar del origen. Sin conocer destino y política de inclusión no hay manifiesto de migración aceptable.
6. **Confinamiento de aplicaciones:** OpenCode y Chrome tienen redirecciones observadas, pero no hay auditoría integral de todas las herramientas ni de todas las escrituras. La política fail-closed no está satisfecha a nivel de host.
7. **Acceso del modelo:** RDC fue observado con allowedDirectories=[]; no es confinamiento. Un broker no aporta seguridad efectiva mientras el proceso del agente conserve filesystem/shell amplio.
8. **Credencial Groq:** una inferencia real se hizo con una nota efímera que expiró. No hay prueba de disponibilidad persistente de GROQ_API_KEY en futuras sesiones, ni debe convertirse en almacenamiento en claro para lograrlo.
9. **B2:** el ciphertext formal de EP Vault sí tiene un backup probado; el workspace completo no está cifrado ni respaldado de esa forma. No confundir SSE-B2 con cifrado cliente.
10. **Multi-terminal:** no hay restauración/cambio de terminal probado. DPAPI CurrentUser es local y no sustituye el aprovisionamiento independiente de credenciales.
11. **Ubicación:** Fila 4 identifica el equipo/perfil, no la ubicación física. La ubicación permanece sin clasificar en el material revisado; no inferir CECEQ ni LOC-OTHER.
12. **Cloud:** Kamatera se difirió por la exigencia de tarjeta/depósito. No existe servidor cloud ni benchmark.
13. **Sesión canónica:** todavía no se ha decidido si el formalismo actual del marco basta para delimitar sesiones EP ni cuál será el formato canónico mínimo.
14. **Datos del host y tiempo:** los inventarios de hardware/almacenamiento son snapshots del 13-11-2026, no una lectura viva realizada al escribir este documento. Deben revalidarse antes de aprovisionar.

---

## 7. Secuencia integrada propuesta para completar el diseño

La secuencia mantiene lo que ya se probó y evita repetir tests sintéticos que no resuelven el bloqueo real.

### Fase 1 · Preparar una migración reproducible
- Revalidar espacio libre local y ruta efectiva de la fuente.
- Inventariar todo SeryMente: rutas relativas, tipo, tamaño, hash, atributos, reparse points, errores de acceso y exclusiones expresas.
- Resolver el reparse point observado; no seguirlo sin política, no descartarlo sin registro.
- Preservar la fuente y producir manifiesto inmutable con conteos, tamaños y hashes.
- Confirmar la bóveda real, su versión/formato, ruta física y ausencia de solapamiento con el punto de montaje.

### Fase 2 · Cerrar el camino de acceso Cryptomator
- Probar CLI oficial estable 0.6.2 en lectura y montaje sobre una copia aislada de la bóveda real de formato 8.
- Si se necesita CLI create, evaluar la build firmada upstream como build local reproducible, no presentarla como estable oficial.
- Verificar WinFsp nativo, password por stdin, apertura, escritura, lectura y bloqueo.
- Implementar y probar desmontaje graceful en Windows, incluyendo archivos abiertos y procesos auxiliares.
- No introducir la llave de recuperación como sustituto implícito de la contraseña maestra.

### Fase 3 · Migrar SeryMente
- Preparar punto de montaje vacío y destino dentro del contenedor Cryptomator.
- Copiar desde la fuente mediante Robocopy u otro método con log saneado y reintentos controlados.
- Comparar lista relativa, conteo, tamaños y SHA-256 de cada archivo, resolviendo atributos y exclusiones.
- Releer y probar repositorios Git, módulos y aplicaciones esenciales desde el montaje.
- Conservar la fuente en claro intacta hasta el cotejo completo, recuperación y aceptación explícita; no borrarla antes.

### Fase 4 · Confinar herramientas y datos
- Instalar/consolidar módulos bajo la jerarquía SeryMente.
- Redirigir perfiles, configuración, extensiones, cache, TEMP, logs, bases locales, descargas y volcados.
- Ejecutar una prueba representativa de cada aplicación y observar escrituras reales del filesystem.
- Bloquear la aplicación que persista datos de usuario fuera del perímetro hasta resolverla.
- Separar datos compartibles y datos específicos de terminal.

### Fase 5 · Integrar el ciclo de sesión y el Access Broker
- Formalizar identidad de agente separada y no administradora.
- Eliminar el bypass de shell/filesystem directo a la bóveda y EP Vault.
- Definir concesión no secreta, TTL, alcance, revocación y cierre.
- Implementar drenaje de operaciones y desmontaje graceful al vencer/revocar.
- Verificar que, al cerrar EP Vault después de emitir concesión, la sesión del broker sigue según diseño, y que reiniciar broker/host invalida la concesión.
- Hacer pruebas negativas de bypass y acceso a EP Vault, recovery key y perfiles de terminal.

### Fase 6 · Persistir en B2
- Una vez estable la bóveda local, bloquearla y copiar exclusivamente el ciphertext físico mediante Rclone copy.
- Ejecutar rclone check, descargar una copia independiente, comparar objeto/carpeta y guardar recibo.
- Aplicar versionado/retención y políticas de coste; no usar sync destructivo como rutina.
- Restaurar en un workspace limpio/otra terminal y verificar desbloqueo, conteos, hashes y funcionamiento.
- Mantener una sola ubicación escritora activa y registrar conflictos/recuperación.

### Fase 7 · Cerrar dependencias de runtime y continuidad
- Reconciliar EP-TASK-005 y el paquete MCP-OCP con DUG v393 y su manifiesto/ZIP/recibo exactos antes de instalar.
- Probar escritura/read-back BMAD con artefacto sintético, no solo descubrimiento/inferencia.
- Resolver la persistencia de credenciales por EP Vault y por terminal sin exponerlas.
- Completar EP-TASK-006/007, el alta de una terminal nueva y las pruebas de restauración.
- Hacer benchmark local vs cloud antes de seleccionar y pagar VM.

---

## 8. Criterios de aceptación integrales

El sprint no queda terminado por crear una bóveda, instalar paquetes o actualizar OEP. La aceptación debe demostrar conjuntamente:

- [ ] Manifestación exhaustiva del workspace fuente y resolución del reparse point.
- [ ] Bóveda real correcta, contraseña fuerte separada, formato verificado y almacenamiento físico fuera del montaje.
- [ ] Migración total con conteos, tamaños, hashes y read-back coincidentes; fuente original preservada hasta aceptación.
- [ ] Prueba de que el ciphertext físico no revela contenido ni nombres de archivos sin credencial válida, con límites documentados.
- [ ] CLI oficial o build local claramente etiquetada, reproducible, probada contra bóveda real, con WinFsp nativo y montaje/cierre graceful de Windows.
- [ ] Desaparición de unidad y ausencia de procesos/handles/escrituras tras bloqueo y revocación.
- [ ] Aplicaciones esenciales confinadas con pruebas reales de filesystem y sin persistencia de usuario fuera de SeryMente.
- [ ] EP Vault recuperable y formalización de la llave de recuperación verificada sin revelar el valor.
- [ ] Access Broker aislado de shell directo, sin acceso a vault-store/EP Vault/keys, con TTL/revocación y pruebas negativas.
- [ ] B2 recibe solo ciphertext cliente; upload, read-back, check y restore independiente pasan.
- [ ] Una segunda terminal física puede recuperar su entorno con aprovisionamiento local y sin compartir DPAPI.
- [ ] Toolchain BMAD/OpenCode/Groq con escritura/read-back reproducible, sesión nueva y credenciales temporales/persistentes según política.
- [ ] OEP, fichas, índice y manifiestos se leen de vuelta; el operador acepta expresamente el resultado integral.

Los puntos anteriores son criterios de aceptación propuestos por consolidación de requisitos ya presentes en las fuentes. Este documento no afirma que se hayan ejecutado.

---

## 9. Decisiones pendientes al cierre de esta reconstrucción

1. **Formato canónico mínimo de sesión EP:** decidir el esquema y evaluar si el marco metodológico ofrece formalismo suficiente. Candidatos de campos: identificador/folio cuando corresponda, operador, terminal, host, modelo/canal, apertura, expiración, permisos/alcance, fuente de autorización, estado, eventos de revocación/cierre y evidencia de read-back. No crear folio ni adoptar el esquema automáticamente.
2. **TTL de concesión Access Broker:** el borrador menciona sesión actual/8 h/24 h; la duración definitiva requiere pruebas y decisión.
3. **Identidad del agente:** separar al agente de la identidad propietaria del workspace y bloquear shell/FS de bypass.
4. **Ruta física definitiva:** no se resolvió si la bóveda real permanecerá en su ubicación actual o si se migra a vault-store. No moverla sin un plan verificado.
5. **CLI de producción:** decidir release estable 0.6.2 + operación compatible, o build local desde upstream firmado con mantenimiento propio; probar primero contra copia aislada.
6. **Contraseña maestra Cryptomator:** documentar el mecanismo local de desbloqueo por CLI; no confundirla con recovery key.
7. **Cloud desktop:** retomar Kamatera u otro proveedor cuando haya una opción que cumpla el límite de pago y se pueda ejecutar benchmark.
8. **Ubicación física de Fila 4:** clasificarla por separado del alias de terminal antes de activar políticas condicionales de permanencia/bloqueo.
9. **Scope de backup B2:** distinguir siempre el ciphertext formal EP Vault, los objetos de respaldo del workspace y los datasets pertenecientes a adaptadores/Harmonia/SI. El destino OCP-MCP/ep-ocp/ no se extrapola a consumidores sujetos al destino OCP-MSP de ART-028.
10. **Limpieza del legado:** inspeccionar VHDX, W:, carpetas EP/Herramientas residuales, bootstrap Desktop, staging y perfiles antiguos. No borrar ni desinstalar sin clasificación, preservación y verificación.

---

## 10. Conclusión de continuidad

El esfuerzo ha producido un diseño coherente de varias capas y avances reales de implementación, pero todavía no ha alcanzado el resultado principal: **todo SeryMente cifrado y utilizado exclusivamente desde el workspace Cryptomator, con perfiles de aplicaciones confinados y recuperación probada**.

La bóveda real existe y está bloqueada; la llave de recuperación está formalizada; la CLI local tiene pruebas sintéticas; Groq respondió mediante OpenCode; el ciphertext formal de EP Vault tiene una copia B2 verificada. Esos avances son válidos dentro de sus alcances respectivos.

Lo que no se ha completado es igualmente importante: la fuente SeryMente sigue en claro; la copia íntegra no existe en la bóveda; el cierre graceful Windows no se ha aceptado; la CLI oficial no se ha probado contra la bóveda real; el Access Broker no existe como implementación; Rclone no ha respaldado el workspace; no hay recuperación cross-host ni continuidad multi-terminal aceptada.

**Siguiente objetivo prioritario:** cerrar EP-TASK-003 mediante una migración criptográfica reproducible y verificada, sin destruir ni modificar el original hasta aceptación. EP-TASK-002 (backup B2) se completa sobre el ciphertext ya validado; EP-TASK-004 (EP Vault) provee la custodia; EP-TASK-007 y el Access Broker dependen de un ciclo de sesión seguro; EP-TASK-005 se libera cuando el workspace y el paquete MCP-OCP superen sus gates.

---

## 11. Referencias canónicas y técnicas

- [OEP §136 — decisión inicial Cryptomator y confinamiento](../OEP.md#1361-decisión-vigente-del-operador).
- [OEP §137 — especificación única del workspace y modelo de protección](../OEP.md#1371-decisiones-firmes).
- [OEP §138 — régimen CLI por defecto y excepción GUI expresa](../OEP.md#1381-regla-obligatoria-del-operador).
- [OEP §139 — módulo funcional MOD-EP-CRYPTO](../OEP.md#1391-identidad-subordinación-y-responsabilidad).
- [OEP §140 — jerarquía de SeryMente y confinamiento](../OEP.md#1401-regla-raíz-y-jerarquía-de-repositorios).
- [OEP §141 — BMAD, OpenCode, Groq y RDC](../OEP.md#1411-propósito-y-arquitectura).
- [OEP §142 — EP Vault y notas efímeras](../OEP.md#1421-identidad-finalidad-y-límites-del-módulo).
- [OEP §143 — B2/Rclone, cloud y Access Broker](../OEP.md#143-investigación-de-flujo-cifrado-persistencia-b2-windows-cloud-y-acceso-delegado--2026-11-13--1209-america-mexico_city).
- [OEP §144 — secretos OpenAI y concesión de sesión](../OEP.md#144-corrección-de-novelocker-custodia-de-secretos-y-sesión-autorizada-ep--2026-11-13--1209-america-mexico_city).
- [Índice de tareas provisionales](../%F0%9F%93%81%20%F0%9F%A7%AD%20-%20Tareas%20provisionales/README.md).
- [Repositorio Cryptomator CLI](https://github.com/cryptomator/cli) y [releases](https://github.com/cryptomator/cli/releases).
- [Arquitectura de seguridad Cryptomator](https://docs.cryptomator.org/security/architecture/).
- [Documentación CLI de Rclone](https://rclone.org/commands/).

**Nota final:** la presente consolidación refleja el estado documentado hasta el 13-11-2026 y no es una inspección técnica viva posterior de Fila 4. Para cualquier operación de escritura, migración, limpieza, instalación o despliegue debe revalidarse el estado del host y del repositorio antes de actuar.
