# Procedimiento canónico de arranque CLI Windows y clonación de repositorios

**Estado:** CANÓNICO  
**Versión:** v1.0.0  
**Fecha:** 2026-10-09  
**Ámbito:** Terminales Windows operadas por Remote Desktop Commander (RDC), incluidas terminales individuales de CIBERCAFE.

## 1. Secuencia obligatoria

Identificar terminal → adquirir y verificar SI por SHA → leer bootstrap y registros RDC → descubrir dispositivos ONLINE en todas las cuentas accesibles → seleccionar por cuenta + device_id → hacer ping → validar dependencias → operar exclusivamente por CLI → probar el resultado real → persistir por terminal → actualizar índices y registros globales → verificar cada publicación con SHA y read-back.

Un proceso iniciado, una ventana abierta o un archivo creado no prueban que el objetivo real esté listo.

## 2. Identidad y preflight

La identidad persistente de una computadora es CIBERCAFE + PC-N. La identidad de una sesión RDC es cuenta RDC + device_id. No se intercambian ni una PC nueva reemplaza otra sesión automáticamente.

En Windows, resuelve el hostname por varias fuentes; no dependas únicamente de la variable de entorno:

    $hostName = [System.Net.Dns]::GetHostName()
    $computer = Get-CimInstance Win32_ComputerSystem
    $os = Get-CimInstance Win32_OperatingSystem
    [pscustomobject]@{
        Hostname = $hostName
        SystemName = $computer.Name
        User = $env:USERNAME
        Desktop = [Environment]::GetFolderPath('Desktop')
        OS = $os.Caption
        Build = $os.BuildNumber
    } | Format-List

En esta terminal, COMPUTERNAME llegó vacío en un proceso RDC aunque el hostname DNS y Win32_ComputerSystem.Name devolvieron PC-4. Cuando existan discrepancias, registra ambas observaciones y utiliza el valor verificado por el sistema.

Comprueba Git, GitHub CLI, Node.js/npm y las aplicaciones por separado. La falta de gh no impide clonar repositorios públicos; la autenticación de GitHub no demuestra que git.exe esté instalado. Antes de utilizar gh auth setup-git, verifica por separado que Git existe y funciona.

En CIBERCAFE se aplica PRESUPUESTO-REINICIO = 0: no reiniciar, apagar, resetear ni programar reinicios. No realizar cambios de BIOS/UEFI, firmware o reparación offline. Registrar lo que requiere reboot como BLOQUEADA-REINICIO y continuar con alternativas live.

## 3. Comandos de arranque de esta conversación

### Remote Desktop Commander

En Windows PowerShell, el comando correcto es:

    npx.cmd @wonderwhy-er/desktop-commander@latest remote

No uses npx sin extensión si PowerShell resuelve npx.ps1 y la política de ejecución bloquea scripts. Aplica la misma regla a npm: utiliza npm.cmd cuando corresponda. Mantén abierta la terminal RDC y espera el handshake. Valida cuenta, dispositivo, device_id, estado ONLINE y ping antes de depender de esa terminal.

No declares éxito por la sola aparición de “Starting”, por el proceso iniciado ni por un nombre visible.

### winget

Especifica fuente y acuerdos en operaciones no interactivas:

    winget.exe install --id Git.Git -e --source winget --accept-source-agreements --accept-package-agreements --silent

No omitas --source winget. Una consulta de paquete sin fuente puede activar msstore y abrir una solicitud de acuerdos; no aceptes una fuente distinta por inercia. Tras instalar, confirma existencia y versión mediante ruta/ejecutable, porque PATH puede no actualizarse en el proceso PowerShell actual.

### PowerShell 5.1 y ejecutables nativos

Con ErrorActionPreference en Stop, PowerShell 5.1 puede convertir stderr de un ejecutable nativo en NativeCommandError. Captura salida y verifica LASTEXITCODE sin confundir el texto de stderr con la causa del fallo:

    $previousPreference = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        $nativeOutput = @(& $executable @nativeArguments 2>&1)
        $nativeExitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousPreference
    }
    $nativeOutput | ForEach-Object { Write-Output ([string]$_) }
    if ($nativeExitCode -ne 0) {
        throw "NATIVE_COMMAND_FAILED: exit=$nativeExitCode"
    }

No uses Out-String.Trim como si fuera un cmdlet. Utiliza una expresión válida como ($value | Out-String).Trim() o valida directamente el arreglo devuelto. Aísla las consultas cuyo fallo sea un estado esperado; no permitas que el stderr de una comprobación aborta la acción correctiva prevista.

Si un script de configuración debe ignorar la política del shell padre, ejecútalo en un proceso hijo explícito con powershell.exe -NoProfile -ExecutionPolicy Bypass -File. No cambies la política global a Unrestricted.

## 4. Descargar repositorios al Escritorio

**Destino obligatorio en CECEQ:** si el proceso se ejecuta desde el perfil de MantenimientoRCI, las rutas derivadas de `$env:USERPROFILE`, `[Environment]::GetFolderPath('Desktop')`, `TEMP` o `AppData` pueden señalar su propio árbol. Antes de clonar, actualizar, instalar o guardar datos, asegúrate de que el destino resuelto esté dentro del árbol completo de `C:\\Users\\fila4\\...`. Nunca escribir dentro de `C:\\Users\\MantenimientoRCI\\...`. Esta aclaración regula únicamente la ruta de trabajo; no exige cambiar de identidad ni crear una sesión o procedimiento adicional.

Para un repositorio público, si Git está instalado y no existe aún el destino:

    git clone https://github.com/SeryMente/metodologia.git "$env:USERPROFILE\Desktop\metodologia"

Para las siguientes descargas o actualizaciones, usa el clonador canónico:

    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\Desktop\metodologia\scripts\clone-public-repo-to-desktop.ps1" -RepositoryUrl "https://github.com/SeryMente/khora.git"

Sustituye la URL por el repositorio requerido. El script instala Git mediante la fuente winget solo si hace falta, y luego verifica origin, rama, SHA de HEAD y árbol de trabajo.

Reglas de protección: si el destino existe pero no es repositorio Git, detenerse; si origin no coincide, detenerse; si hay cambios locales, detenerse sin sobrescribirlos; si está limpio y el origin coincide, actualizar únicamente con git pull --ff-only. No crear commits ni ejecutar push de manera automática. No abrir ventanas de login ni solicitar credenciales interactivamente. Los repositorios privados requieren autenticación CLI previa; un clon público no necesita gh.

Si Git no puede instalarse, un ZIP público extraído a un directorio nuevo solo produce una copia de lectura, sin historial Git ni git pull. No presentes un ZIP como un clon.

## 5. OBS y cámara virtual: evidencia de extremo a extremo

Inicia OBS por ruta ejecutable explícita, comprueba procesos y logs de Virtual Camera y valida el objetivo real con una captura de navegador que confirme el nombre OBS Virtual Camera y resolución/frecuencia recibidas. El log auxilia; la captura de navegador confirma disponibilidad.

No edites propiedades de Chrome Preferences suponiendo que nombres de claves manuales estén soportados o persistan. En esta terminal, las claves escritas manualmente no aparecieron en Preferences tras reiniciar Chrome. Prueba cada sitio que importe: detectar una cámara no concede permiso permanente a todos los sitios, pues los permisos dependen del origen y de la política de Chrome.

Si una prueba temporal requiere autorizar localhost, limita la política a ese URL y elimina la regla y el servidor al terminar. Verifica que ambos quedaron detenidos/eliminados.

## 6. Orden de persistencia

Para una terminal nueva, nunca clones el estado de otra PC. Descubre sus hechos y crea:

1. CIBERCAFE/PC-N/ESTADO.md.
2. CIBERCAFE/PC-N/EVENTOS-YYYY-MM.md.
3. Lee de vuelta ambos documentos y comprueba el contenido.
4. Añade la terminal a CIBERCAFE/REGISTRO-TERMINALES.md.
5. Registra la identidad RDC en HISTORIAL-RDC.md sin finalizar identidades distintas.
6. Actualiza ESTADO-RDC-ACTIVO.md con el último descubrimiento y ping verificados.
7. Tras cada escritura, comprueba commit/SHA y ejecuta read-back; solo entonces considera resuelto el cambio.

La telemetría frecuente permanece local. Los eventos persistentes registran cambios significativos, fallos relevantes, causa comprobada, corrección y resultado. Nunca guardes tokens, contraseñas ni credenciales en los eventos.

## 7. Contrato de éxito

Al cerrar una acción, reporta la terminal/device_id usada, el comando, la comprobación que demuestra el resultado, la persistencia realizada y los SHA/read-back correspondientes. Declara pendientes los puntos que no hayan quedado demostrados.

## 8. Un solo comando de bootstrap, anclado y verificado

No descargar el script de una URL móvil de \`main\`: durante una prueba, el servidor \`raw.githubusercontent.com\` devolvió una copia anterior mientras \`main\` ya había avanzado. Se usa un commit inmutable y se verifica SHA-256 antes de ejecutar:

    $u='https://raw.githubusercontent.com/SeryMente/metodologia/14756d289f1ddc4c74c6736f5aa021121158541c/scripts/bootstrap-cibercafe-cli.ps1'; $f=Join-Path $env:TEMP 'bootstrap-cibercafe-cli.ps1'; Invoke-WebRequest -UseBasicParsing -Uri $u -OutFile $f; if ((Get-FileHash -LiteralPath $f -Algorithm SHA256).Hash -ne '19D254602AEAA17F08D9E4D09B20B665DC48588C46EB41F1C9E53F2EF62E0154') { Remove-Item -LiteralPath $f -Force -ErrorAction SilentlyContinue; throw 'BOOTSTRAP_HASH_MISMATCH' }; $ps=Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'; & $ps -NoProfile -ExecutionPolicy Bypass -File $f -StartOBSVirtualCamera

El script identifica la terminal, instala/verifica Git y Node/npm/npx mediante la fuente explícita winget cuando faltan, clona o actualiza \`Desktop\\metodologia\` únicamente si el destino es seguro, verifica las cabeceras normativas y ejecuta el comando oficial de RDC en primer plano. Con \`-StartOBSVirtualCamera\`, intenta iniciar y verificar la cámara virtual. Si OBS falla, lo informa y continúa con RDC para conservar la vía de diagnóstico.

Mantén abierta la terminal donde queda ejecutándose \`npx.cmd ... remote\`. Si RDC solicita un código, autoriza el dispositivo y confirma que el código del navegador coincide con el de la terminal. La autenticación inicial depende de la aprobación del usuario y no puede garantizarse solo por comando.

El bootstrap no modifica permisos globales de cámara en Chrome, no otorga permisos universales a los sitios, no cambia automáticamente la cuenta del navegador, no crea commits/push y no reinicia el equipo. Si la descarga, la conexión, \`winget\` o una instalación elevada están bloqueados, debe detenerse o informar el fallo en vez de declarar éxito.