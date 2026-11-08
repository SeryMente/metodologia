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
