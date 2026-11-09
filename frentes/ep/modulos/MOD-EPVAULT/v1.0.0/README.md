# MOD-EPVAULT — EP Vault v1.0.0

**Frente:** Entorno Persistente (EP)  
**Módulo:** MOD-EPVAULT  
**Versión:** 1.0.0  
**Estado:** candidata funcional PC 7; H10 visual pendiente; merge a main pendiente  
**Propietario documental:** OEP de frentes/ep/OEP.md, §120  
**Directorio canónico:** frentes/ep/modulos/MOD-EPVAULT/v1.0.0/

## Propósito

EP Vault es la bóveda local de variables de entorno y notas efímeras del Entorno Persistente. Permite guardar credenciales y valores de configuración localmente con cifrado autenticado y ACL de Windows, mantener una sesión corta de desbloqueo compartida entre GUI y CLI, capturar notas protegidas desde el portapapeles y ejecutar procesos con una allowlist explícita de variables.

Es una herramienta de Metodología/EP. No es una extensión Chrome, no requiere carpeta extension/, no es la bóveda PAT web de Khora y no sustituye el sistema de persistencia remota de datos de usuario.

## Componentes

- src/EP.Vault.Core.psm1: núcleo criptográfico, persistencia atómica, ACL, sesiones, notas DPAPI, portapapeles y ejecución administrada.
- src/EP.Vault.CLI.ps1: interfaz headless para operaciones automatizables y uso por modelos.
- src/EP-Vault.GUI.ps1 y src/EP-Vault.Window.xaml: interfaz WPF, ejecutada en STA.
- tests/Test-EPVault.ps1: suite sintética aislada.
- Install-EPVault-PC7.ps1: preflight, pruebas, consulta de estado formal de solo lectura y creación de lanzadores visibles.
- assets/audio/: recursos de apertura/cierre de interfaz.
- MODEL-CLI-HEADLESS.md: límites de uso desde modelos.
- DESIGN-CLEAN-ROOM.md y UI-PULIDO-METAL-REALISTA.md: diseño y guía de aceptación visual.

## Modelo de seguridad

**Datos formales:** el archivo de bóveda se ubica fuera del workspace en %LOCALAPPDATA%/Khora/secrets/ep-env-vault.enc.json. La ubicación exacta se resuelve en cada perfil Windows; el archivo no se versiona, copia ni sincroniza.

**Nuevas bóvedas:** PBKDF2-HMAC-SHA256, 600.000 iteraciones, sal aleatoria de 16 bytes, derivación de 64 bytes.

**Formato:** AES-256-CBC + HMAC-SHA256 encrypt-then-MAC; el HMAC se valida antes de descifrar. Sobres de 200.000 iteraciones se leen solo tras autenticación correcta y se actualizan a 600.000 con escritura atómica y read-back.

**Permisos:** DACL protegida para usuario Windows efectivo y LocalSystem. Los directorios/archivos sensibles rechazan reparse points.

**Sesión:** DPAPI CurrentUser, TTL absoluto no deslizante de 15/30/60/120/180/300/600/900 segundos (300 s por defecto). Lock revoca la sesión compartida entre GUI/CLI.

**Notas efímeras:** DPAPI CurrentUser, 1–240 minutos (30 por defecto); listado de metadatos, reveal explícito y promoción deliberada. La expiración lógica no equivale a borrado forense.

**Portapapeles:** leer, persistir y hacer read-back antes de limpiar; el contenido nuevo del portapapeles no se borra si cambió durante la operación.

**Procesos/modelos:** usar Run con allowlist obligatoria y Job Object. No pasar secretos en argumentos, logs o contexto de modelo; no usar RevealVariable como integración normal.

## Operación

Desde PowerShell 5.1:

- Install-EPVault-PC7.ps1: valida parser/XAML, ejecuta la suite sintética por defecto, consulta Status en solo lectura y crea lanzadores en el Escritorio.
- EPVault-GUI.cmd: inicia GUI en STA.
- EPVault-CLI.cmd -Action Version: devuelve identidad y versión del producto.
- EPVault-CLI.cmd -Action Status: devuelve estado saneado; no inicializa.
- EPVault-CLI.cmd -Action Initialize: pide al operador contraseña maestra dos veces localmente. No pasar la contraseña como argumento/chat.
- EPVault-CLI.cmd -Action CaptureNote -NoteTtlMinutes 30: requiere sesión y texto copiado al portapapeles.
- EPVault-CLI.cmd -Action Run -ExecutablePath RUTA -Names VAR1,VAR2: permite solo las variables listadas al proceso hijo.
- TEST-EPVault.cmd: ejecuta pruebas sintéticas en sandbox.

La instalación del software nunca inicializa automáticamente la bóveda formal. Crear la bóveda es una decisión separada del operador.

## Reglas de mantenimiento

La fuente única de producto de esta release es este directorio versionado. No editar el snapshot de EP-TASK-004 como si fuera el producto activo. Cada release futura debe crear un nuevo directorio versionado, actualizar su MANIFEST.json, repetir parser/tests, leer de vuelta hashes y actualizar OEP §120.

No añadir datos reales, secretos, valores de variables, notas o DPAPI blobs a este directorio ni a Git. El manifiesto registra solo fuentes no sensibles y hashes.

## Validación y limitaciones

La candidata de endurecimiento previa a la etiqueta v1.0.0 ejecutó la suite E2E sintética en PC 7 con exit code 0 en 77,21 s. La versión etiquetada añade identidad/version gate en CLI, Status y XAML; el test v1.0.0 debe repetirse sobre esta ruta exacta antes de declarar PASS de release.

H10 permanece pendiente: inspección visual/interactiva presencial, DPI, teclado, accesibilidad, movimiento reducido y ciclo real de cierre/expiración. Una carga de XAML y una suite automatizada no sustituyen esa aceptación. El merge a main permanece bloqueado por las compuertas de DUG P012/P013 mientras H10 no esté aceptada.

El almacén formal no estaba inicializado en el preflight de PC 7. BitLocker/VHDX/dead-man de LOC-OTHER y respaldo/recuperación de Datos son controles separados; no se declaran cubiertos por el cifrado del archivo de bóveda.
