# EP Vault — contrato de acceso headless y CLI para modelos

**Ámbito:** interfaz de línea de comandos local para modelos/agentes que operen la bóveda mediante un proceso PowerShell autorizado.  
**Estado:** documentación inicial del wrapper Hito 0 existente; no certifica una futura UI ni sustituye pruebas de integración.  
**Fuente de estado:** EP-TASK-004 / OEP de Entorno Persistente.

## 1. Principios de operación

- La GUI no es un requisito para listar notas, leer una nota autorizada, promoverla, eliminarla o ejecutar el self-test. Las acciones se invocan directamente desde PowerShell 5.1.
- El agente no recibe ni solicita la contraseña maestra por conversación, argumento, variable de entorno, archivo temporal ni historial de comandos.
- Cuando una operación necesita desbloqueo, el prompt seguro se atiende localmente por el operador. El agente nunca escribe la contraseña en el proceso.
- El listado de notas devuelve metadatos (identificador y expiración), nunca el contenido.
- La lectura del contenido exige el switch explícito `-Reveal`. Utilizarlo solo cuando el valor sea estrictamente necesario para la operación solicitada.
- El resultado de `-Reveal` es información sensible: no copiarlo a otra conversación, ticket, log, archivo, salida de diagnóstico ni comando posterior. No activar transcripción de consola ni captura de stdout para esa operación.
- Los valores formales y el archivo cifrado de la bóveda no pertenecen al repositorio Git. El repositorio solo puede contener código, contratos, pruebas y nombres no secretos de variables.

## 2. Preparación de la CLI

La ubicación local actual del wrapper es:

```powershell
$cli = Join-Path $env:LOCALAPPDATA 'SeryMente\OCP MCP\tools\ep-env-vault\EP-Vault-CLI.ps1'
if (-not (Test-Path -LiteralPath $cli -PathType Leaf)) {
    throw 'EP_VAULT_CLI_NOT_FOUND'
}
```

PowerShell 5.1 está soportado. Si la política de ejecución bloquea el script, no cambies la política de máquina. Usa un proceso dedicado con bypass limitado a ese proceso:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
& $cli -Action Status
```

También puede invocarse desde un proceso nuevo usando `powershell.exe -NoProfile -ExecutionPolicy Bypass -File`. Captura el código de salida nativo inmediatamente; no trates stderr informativo como fallo si el proceso terminó con código cero.

## 3. Acciones disponibles

El wrapper valida `-Action` con este conjunto:

`Status`, `Capture`, `ListNotes`, `ReadNote`, `PromoteNote`, `DeleteNote`, `ListVariables`, `RemoveVariable`, `Load`, `Lock`, `SelfTest`.

| Acción | Uso | Autenticación/efecto |
|---|---|---|
| `Status` | `& $cli -Action Status` | Solo metadatos; no imprime valores. |
| `Capture` | `& $cli -Action Capture -TtlMinutes 30` | Captura el texto presente en el portapapeles en una nota DPAPI; devuelve identificador/expiración, no el valor. TTL permitido 1–240 min; predeterminado 30 min. |
| `ListNotes` | `& $cli -Action ListNotes` | Lista notas vigentes por metadatos, sin revelar contenido. |
| `ReadNote` | Ver flujo §4 | Requiere `-Reveal`; muestra el valor al proceso invocador. |
| `PromoteNote` | Ver flujo §5 | Prompt local de contraseña maestra; persiste en bóveda formal y verifica lectura de vuelta. |
| `DeleteNote` | Ver flujo §6 | Elimina la nota efímera seleccionada. |
| `ListVariables` | `& $cli -Action ListVariables` | Solicita desbloqueo local; devuelve nombres, no valores. |
| `RemoveVariable` | Ver flujo §7 | Destructivo; prompt local y verificación de ausencia mediante lectura de vuelta. |
| `Load` | `& $cli -Action Load` | Desbloquea y carga variables al entorno del proceso PowerShell actual; véase §8. |
| `Lock` | `& $cli -Action Lock` | Restaura/elimina las variables cargadas en ese proceso y termina la sesión de bóveda de ese proceso. |
| `SelfTest` | `& $cli -Action SelfTest` | Prueba sintética criptográfica; no necesita leer ni modificar la bóveda real. |

## 4. Leer una nota efímera

Primero lista los metadatos y selecciona el identificador requerido:

```powershell
& $cli -Action ListNotes
$noteId = Read-Host 'ID de la nota que se necesita'
& $cli -Action ReadNote -NoteId $noteId -Reveal
```

La segunda orden es el único paso que hace visible el valor. El agente debe procesarlo en memoria para la acción concreta y no reproducirlo en la conversación ni en otra herramienta. Si no necesita el valor, no ejecutar `ReadNote`.

## 5. Promover una nota a variable formal

```powershell
$noteId = Read-Host 'ID de la nota'
$name = Read-Host 'Nombre formal de la variable'
& $cli -Action PromoteNote -NoteId $noteId -Name $name
```

El backend solicita la contraseña maestra localmente, cifra la variable formal, descifra y compara la lectura de vuelta y solo después elimina la nota temporal. Si la variable ya existe, la operación se rechaza. Para una rotación/reemplazo intencional se requiere el switch explícito:

```powershell
$noteId = Read-Host 'ID de la nota'
$name = Read-Host 'Nombre formal de la variable a reemplazar'
& $cli -Action PromoteNote -NoteId $noteId -Name $name -Replace
```

No usar `-Replace` como opción por defecto ni como reintento ciego.

## 6. Eliminar una nota efímera

```powershell
$noteId = Read-Host 'ID de la nota que se eliminará'
& $cli -Action DeleteNote -NoteId $noteId
```

La eliminación de la nota no elimina una variable formal con el mismo nombre. Las notas y variables formales son objetos diferentes.

## 7. Eliminar una variable formal

```powershell
$name = Read-Host 'Nombre exacto de la variable formal'
& $cli -Action RemoveVariable -Name $name
```

Esta acción es destructiva. El backend solicita autenticación local, crea el nuevo sobre cifrado, lo escribe atómicamente, vuelve a leerlo y verifica que el nombre haya desaparecido. No ejecutar sin una solicitud explícita que identifique la variable.

## 8. Cargar variables para un proceso headless

`Load` no crea variables de sistema ni modifica permanentemente la shell padre. Las variables existen en el proceso PowerShell que ejecutó la acción y son heredables por sus procesos hijos. Por ello, el proceso que las carga debe permanecer vivo durante el trabajo:

```powershell
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -NoExit -File "$env:LOCALAPPDATA\SeryMente\OCP MCP\tools\ep-env-vault\EP-EnvVault.ps1" -Action Load
```

El operador atiende el prompt local de contraseña. La salida debe confirmar solo nombres y estado; nunca valores. Mantén esa misma ventana/proceso para iniciar los hijos que necesitan las variables. Al terminar:

```powershell
& (Join-Path $env:LOCALAPPDATA 'SeryMente\OCP MCP\tools\ep-env-vault\EP-EnvVault.ps1') -Action Lock
exit
```

Si se ejecuta `Load` en un proceso de corta vida que termina inmediatamente, las variables desaparecen con ese proceso y sus descendientes; no quedan cargadas en la shell que lo lanzó.

## 9. Seguridad y límites operativos

- La bóveda formal utiliza PBKDF2-HMAC-SHA256, AES-256-CBC y HMAC-SHA256 (Encrypt-then-MAC); el self-test comprueba round-trip, rechazo de contraseña incorrecta y manipulación.
- Las notas efímeras usan Windows DPAPI `CurrentUser` y ACL restringida al SID del usuario y LocalSystem. Su TTL predeterminado es 30 minutos; las notas expiradas se depuran durante operaciones de bandeja.
- El portapapeles de Windows puede tener historial, sincronización en nube o gestores de terceros. La limpieza del portapapeles de proceso no garantiza eliminar copias mantenidas por esos servicios.
- El host debe conservar su protección de disco independiente. En la última observación registrada, BitLocker C: estaba desactivado; no se debe afirmar cifrado integral del dispositivo.
- El archivo `ep-env-vault.enc.json`, sus respaldos, notas, valores y contraseñas nunca se incorporan a Git.
- La CLI de Hito 0 es una interfaz local para el proceso de trabajo. No es un endpoint remoto ni concede acceso a modelos que no tengan un proceso RDC/PowerShell autorizado en el host.
- Ningún resultado sintético demuestra por sí solo aceptación de producción ni seguridad de un diseño futuro.

## 10. Contrato esperado para el agente/modelo

1. Ejecutar `Status` o `ListNotes` sin abrir la GUI cuando solo se necesiten metadatos.
2. No solicitar ni revelar la contraseña maestra.
3. Consultar el índice de notas y solicitar `-Reveal` solo para el elemento estrictamente necesario.
4. No conservar valores en logs, transcripciones, ficheros temporales, argumentos ni contexto de larga duración.
5. Usar `PromoteNote` para convertir una nota en variable formal; no copiar/pegar valores por una vía alternativa.
6. No eliminar ni reemplazar variables formales sin una orden explícita.
7. Cerrar con `Lock` y terminar el proceso headless que tuvo acceso a los valores.
8. Reportar únicamente nombres, estados, códigos de resultado y evidencia de lectura de vuelta; nunca valores.



## 11. Límites conocidos del wrapper Hito 0

Los siguientes límites se observaron en el código actual y no deben confundirse con características ya resueltas de la futura versión:

- `Capture` toma la entrada del portapapeles de Windows; no acepta stdin/stream. Puede operar sin abrir la GUI de la bóveda, pero requiere un portapapeles disponible en la sesión del usuario. El historial del portapapeles, sincronización en nube y gestores de terceros están fuera del control de la aplicación.
- `Load` introduce **todas** las variables formales en el entorno del proceso PowerShell actual y las transmite a sus procesos hijos. No modifica la shell padre ni el entorno de máquina. El wrapper no permite restringir por nombre en esta versión.
- La sesión `Load` no vence automáticamente. Se mantiene hasta `Lock` o la terminación del proceso. La caducidad configurable solicitada debe cubrir también el flujo headless.
- Las acciones que desbloquean la bóveda requieren un prompt local interactivo. No existe un modo desatendido con contraseña recibida por argumento, archivo o variable de entorno; no crear uno que debilite esta propiedad.
- El archivo de eventos actual está fuera de la carpeta de secretos y su ACL observada no está protegida. No añadirle valores ni confiar en una redacción implícita; su rediseño y sus pruebas son pendientes de seguridad.
- Hay tres respaldos cifrados históricos junto al almacén formal; el wrapper no expone una política de retención/restauración. No borrarlos automáticamente.

La nueva interfaz headless deberá ofrecer mínimo privilegio, vencimiento de sesión, captura segura sin depender necesariamente del portapapeles y telemetría sin secretos, siempre después de la revisión de seguridad exigida por P012/P013.


---

## 12. Contrato de CLI de la reconstrucción clean-room

Este apartado describe la implementación nueva que se prepara en H3–H6. **No describe capacidades verificadas del wrapper Hito 0.** La implementación se conserva en rama hasta superar las pruebas Windows PowerShell 5.1.

### 12.1 Entrada y aislamiento del proceso

La nueva entrada es **src/EP.Vault.CLI.ps1**, respaldada por **src/EP.Vault.Core.psm1**. Debe ejecutarse en un proceso PowerShell 5.1 dedicado, no dot-sourced ni invocado desde la misma consola de trabajo:

~~~powershell
$cli = 'C:\ruta\EP.Vault.CLI.ps1'
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File $cli -Action Status
~~~

El script termina con un código de salida para el proceso CLI. Por eso no debe dot-sourcearse ni ejecutarse como **& $cli** desde la sesión interactiva que el operador quiera conservar: el comando **exit** finaliza el proceso anfitrión que lo ejecuta. El modelo debe lanzar un proceso separado, capturar su exit code y evitar registrar cualquier stdout de las acciones de revelación.

### 12.2 Acciones y parámetros nuevos

| Acción | Parámetros relevantes | Resultado / seguridad |
|---|---|---|
| Status | ninguno | Metadatos del sobre cifrado; no desbloquea ni revela valores. |
| Initialize | -DurationSeconds | Crea una bóveda vacía solo si no existe; pide dos veces la contraseña maestra en el prompt local. No sobrescribe una bóveda existente. |
| ListVariables | -DurationSeconds | Solicita autenticación local; devuelve nombres, no valores; bloquea al terminar. |
| RevealVariable | -Name, -Reveal, -DurationSeconds | Requiere el switch explícito -Reveal; stdout contiene el valor sensible. No capturar en logs/transcripciones. |
| SetFromClipboard | -Name, opcional -Replace, -DurationSeconds | Desbloquea localmente, valida nombre y duplicados antes de consumir el portapapeles; escribe atómicamente y verifica lectura de vuelta. |
| RemoveVariable | -Name, -ApproveRemove, -DurationSeconds | Destructivo; switch explícito obligatorio, autenticación local y verificación de ausencia. |
| CaptureNote | -NoteTtlMinutes | Captura el portapapeles en DPAPI CurrentUser. No necesita desbloquear la bóveda formal, pero sí una sesión Windows con portapapeles; no es stdin. |
| ListNotes | ninguno | Solo metadatos; no devuelve valores. |
| ReadNote | -NoteId, -Reveal | La revelación exige switch explícito; stdout es sensible. |
| PromoteNote | -NoteId, -Name, opcional -Replace, -DurationSeconds | Solicita contraseña local, promueve a la bóveda formal, lee de vuelta y solo entonces elimina la nota. |
| DeleteNote | -NoteId, -ApproveDelete | Eliminación explícita; el switch es obligatorio y se comprueba la ausencia. |
| Run | -ExecutablePath, -Names, opcional -ArgumentList, -DurationSeconds | Ejecuta un consumidor con una allowlist explícita de nombres de variables y dentro de un Job Object administrado. Solo devuelve exit code y metadatos; no captura stdout/stderr del consumidor. |
| SelfTest | ninguno | Usa valores sintéticos; prueba criptografía y el ejecutor de procesos. No necesita revelar ni modificar secretos formales. |
| Lock | ninguno | Invalida la sesión del proceso actual. |

### 12.3 Duración de sesión

**-DurationSeconds** acepta exactamente:

**15, 30, 60, 120, 180, 300, 600, 900**

El valor por defecto es **300 segundos (5 minutos)**. La sesión se vence por tiempo absoluto desde la autenticación; no se extiende con actividad. El núcleo verifica la expiración en cada operación protegida. Al concluir una acción CLI, el wrapper ejecuta Lock en finally.

### 12.4 Ejecución headless con mínimo privilegio

Ejemplo conceptual desde una segunda instancia PowerShell 5.1, para un consumidor que necesita exclusivamente una variable:

~~~powershell
$cli = 'C:\ruta\EP.Vault.CLI.ps1'
$exe = 'C:\Program Files\Vendor\worker.exe'
$command = "& '$cli' -Action Run -ExecutablePath '$exe' -Names @('VARIABLE_AUTORIZADA') -ArgumentList @('--batch') -DurationSeconds 300"
$process = Start-Process -FilePath (Join-Path $PSHOME 'powershell.exe') -ArgumentList @('-NoLogo','-NoProfile','-ExecutionPolicy','Bypass','-Command',$command) -Wait -PassThru
$exitCode = $process.ExitCode
~~~

El operador debe revisar las rutas y el ejecutable antes de autorizar el consumidor. No se deben incluir valores de secretos en -ArgumentList, en el nombre del ejecutable, ni en texto de comandos. La allowlist solo admite nombres validados; las variables formales no solicitadas no se descifran para el consumidor.

El Job Object se configura con KILL_ON_JOB_CLOSE. El proceso inicial se crea suspendido, se asigna al Job antes de reanudarlo y se espera su finalización dentro del TTL restante. Si vence o se produce timeout, se termina el árbol administrado. Los procesos no pueden desprenderse del Job y continuar tras la sesión.

El entorno del consumidor contiene una lista base explícita de variables de sistema (p. ej. SystemRoot, PATH, TEMP/TMP y perfiles necesarios para Windows) más los nombres de la allowlist. No copia indiscriminadamente las variables arbitrarias del proceso lanzador. El bloque de entorno nativo se limpia antes de liberar su memoria; las cadenas gestionadas por .NET no permiten prometer borrado perfecto, por lo que el código solo minimiza copias y tiempo de vida.

El ejecutor no captura salida del proceso hijo. La aplicación consumidora debe evitar registrar o imprimir secretos. No se debe activar transcripción de PowerShell ni diagnóstico de comandos sobre una operación sensible.

### 12.5 Códigos de resultado y errores

- Exit code 0: acción completada sin error; en Run, se devuelve el código del proceso consumidor.
- Exit code distinto de cero: error del CLI o código no-cero del consumidor.
- Prefijo de error no sensible: EP_VAULT_ERROR:.
- Códigos estables típicos: MASTER_PASSWORD_INVALID_OR_VAULT_TAMPERED, VAULT_SESSION_NOT_OPEN, VAULT_SESSION_EXPIRED, VARIABLE_ALREADY_EXISTS_USE_EXPLICIT_REPLACE, EXPLICIT_VARIABLE_ALLOWLIST_REQUIRED, CHILD_PROCESS_JOB_ASSIGN_FAILED, VAULT_WRITE_READBACK_VALUE_MISMATCH.
- Nunca devolver valores formales en error, status, listados, metadatos o eventos.

### 12.6 Pruebas de integración previstas

El workflow .github/workflows/validate-ep-vault.yml ejecuta el conjunto sintético en Windows con Windows PowerShell 5.1. Debe cubrir como mínimo:
- parser PowerShell para módulo, CLI y GUI;
- parseo XAML y presencia de todos los nombres de controles;
- escaneo de referencias para impedir dependencia de la GUI anterior;
- round-trip criptográfico, password incorrecta y tamper;
- ACL privada, DPAPI CurrentUser, listado sin valores, Reveal explícito y eliminación;
- persistencia atómica, lectura de vuelta y redacción de logs;
- aceptación de los ocho intervalos de sesión y vencimiento forzado;
- inyección de solo variables allowlisted, ausencia de herencia de variables arbitrarias del lanzador y terminación por timeout del Job Object;
- aislamiento total del almacén de pruebas y eliminación de la carpeta sintética al terminar.

Hasta que un runner Windows ejecute y reporte PASS, estos casos son **criterios de prueba**, no resultados aceptados. La aprobación de arquitectura/UX y el diseño H3 tampoco equivalen a CI, instalación en host real ni cierre H10.


## 13. Sesión compartida GUI / CLI

La GUI y el CLI consumen una única sesión lógica del mismo perfil Windows, sin duplicar el contrato criptográfico.

- Al desbloquear correctamente, Core publica `ep-env-vault.session.dpapi.json` junto al almacén formal, protegido mediante DPAPI `CurrentUser` y entropía asociada a la ruta canónica de la bóveda.
- El registro contiene la clave de sesión protegida, un `sessionId`, inicio, expiración absoluta y duración. No contiene la contraseña maestra en claro.
- Si existe una sesión válida, el CLI la reutiliza y no solicita otra contraseña. Si no existe, pide la contraseña en un prompt local `SecureString`; nunca se acepta por argumento.
- La GUI observa la sesión compartida cada segundo. Detecta sesiones abiertas desde el CLI y cierra su vista cuando detecta revocación, sustitución o vencimiento.
- `Lock` desde cualquiera de los dos front ends elimina el registro compartido y revoca la sesión para los demás procesos.
- La sesión es compartida únicamente entre procesos del mismo usuario Windows/DPAPI CurrentUser y el mismo perfil de bóveda. No se comparte entre cuentas Windows ni entre PC-14 y Fila4. Cada equipo conserva su almacén local independiente.
- Los intervalos de TTL continúan siendo absolutos y no deslizantes: 15 s, 30 s, 1, 2, 3, 5, 10 y 15 min.

**Prueba de aceptación interproceso:** el test sintético crea un almacén temporal, inicia un proceso CLI separado, verifica que ListVariables reutiliza la sesión sin prompt y comprueba que Lock desde ese proceso hace fallar Get-EpVaultSession en el proceso padre. Nunca utiliza la bóveda formal ni secretos reales.


## Reglas de uso seguro desde modelos

- La sesión se abre dentro del mismo perfil Windows/DPAPI CurrentUser. El modelo nunca recibe ni escribe la contraseña maestra en argumentos, variables de entorno, archivos, logs o chat. El prompt de CLI es local y de tipo SecureString.
- Para ejecutar una herramienta con secretos, preferir `-Action Run -ExecutablePath <ruta-absoluta> -Names <allowlist>`. La allowlist es obligatoria; el proceso hijo recibe únicamente los nombres autorizados además del entorno Windows mínimo y su árbol queda ligado a un Job Object. El CLI devuelve estado y código de salida, no imprime las variables.
- `RevealVariable` y `ReadNote -Reveal` muestran el valor literal en stdout. Son operaciones de revelado, no el mecanismo normal de integración con modelos. Usarlas solo con autorización explícita, cuando el destino de salida esté controlado y el valor sea estrictamente necesario.
- Las funciones de notas exigen sesión válida también en el núcleo: una importación directa del módulo no elude el bloqueo. Los TTL son absolutos, no deslizantes; la captura verifica lectura de vuelta y el listado devuelve solo metadatos.
- La captura desde portapapeles lee, persiste y verifica primero; después intenta borrar el mismo texto solo si el portapapeles no cambió. Si se copió otro contenido mientras se escribía, ese contenido nuevo no se borra y la respuesta indica `clipboardCleared=false`.
- Las notas DPAPI CurrentUser pertenecen al perfil Windows actual. No se sincronizan ni se trasladan entre PCs como si fueran portables.
