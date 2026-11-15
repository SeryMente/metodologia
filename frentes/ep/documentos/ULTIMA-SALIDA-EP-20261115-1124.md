## Estado de contingencia - `PC10RCIF4EI4`

(Acceso RDC confirmado) (Respaldo todavía no iniciado)

Queda excluido `01RENTA02` de toda operación: no ejecutaré descargas, restauraciones, montajes ni descifrados allí. El trabajo queda restringido a `PC10RCIF4EI4`\.

La inspección confirma\:

- `C:\Users\fila4\Desktop\SeryMente` contiene el workspace en claro, incluidos `Metodologia-EP-RETOMA-20261114`, `MOD-EPVAULT\v2.0.0-alpha`, `MOD-EP-AHK`, `EP`, `KHORA`, `Temporal`, `_backups` y `_staging`\.
- La bóveda física Cryptomator está en `C:\Users\fila4\entorno-persistente`, con formato 8. No está montada en una unidad visible; no hay proceso Cryptomator activo.
- La bóveda de secretos deprecada está en `SeryMente\EP\local-state\Khora\secrets`; el archivo observado mide 3,352 bytes. El archivo activo canónico de 2,624 bytes aún no está localizado en el árbol visible.
- El cliente B2 disponible es `b2-windows.exe`, versión 5.0.2. `rclone.exe` no apareció en las rutas habituales examinadas.
- `C:` tiene aproximadamente 16 GB libres; `W:` tiene 30 GB y está rotulada `EP-FILA4`\. Aún falta identificar la naturaleza y procedencia de `W:` antes de usarla como staging.

No se ha desbloqueado ninguna bóveda, leído ninguna credencial, creado un archivo de respaldo ni transferido datos.

### Inventario y raíces EP Vault verificadas

El escaneo de solo lectura de `SeryMente` registra **155,862 archivos, 19,244 directorios y 7,966,874,188 bytes** \(aprox. 7.42 GiB). Incluye el contenido versionado y no versionado, los directorios `.git`, respaldos, staging, herramientas, perfiles, caches y logs que están dentro de ese árbol.

He verificado por SHA-256 ambas bóvedas de EP Vault\:

| Raíz | Tamaño | SHA-256 |
|--------|--------|--------|
| Activa `MOD-EPVAULT\v1.0.0\data\Fila4\Khora\secrets` | 2,624 B | `55CD00CF9ADA189B6DB2317DD6A0A704DCEED404F25E0A39CCC514A80FA7B8AF` |
| Deprecada `EP\local-state\Khora\secrets` | 3,352 B | `3122C544012F989F0501BD0E82EA920A93F19A42034D83FA682BCC2290891E82` |

Ambos archivos están bajo `SeryMente`, por lo que entran en el alcance del respaldo. También entran sus archivos de eventos, bloqueos y respaldos `.bak`, además del código `MOD-EPVAULT\v2.0.0-alpha` y las dos ubicaciones de `MOD-EP-AHK`\.

El repositorio principal de metodología conserva **19 entradas locales modificadas o no versionadas** \(10 rastreadas y 9 no rastreadas). También detecté cambios sin commit en `KHORA` \(90), `KHORA-harmonia-omm-fut-009-0.6.0` \(4), su copia `main-sync` \(8) y `signal-interpreter` \(53). Esos cambios se incluirán como archivos, sin reset, checkout ni limpieza.

### Alcance exacto de la copia cifrada

Se incluirá el contenido completo de `C:\Users\fila4\Desktop\SeryMente`, no solo los repositorios Git\:

- Todos los directorios raíz enumerados en el inventario: `EP`, `EP-AgentData`, `EP-Vault`, `GDP`, `Herramientas`, `KHORA`, las dos copias `KHORA-harmonia`, `KHORA-NOTAS-WORK-20261114`, `Metodologia`, `Metodologia-EP-RETOMA-20261114`, `RAP`, ambas carpetas de `signal-interpreter`, `Temporal`, `_backups` y `_staging`\.
- Archivos ocultos, `.git`, archivos rastreados y no rastreados, cambios locales sin commit, pruebas, logs, paquetes, perfiles, caches y respaldos que estén dentro de esas carpetas.
- La raíz activa `MOD-EPVAULT\v1.0.0`, la fuente `MOD-EPVAULT\v2.0.0-alpha` no versionada de la copia de retoma, y `MOD-EP-AHK` en las dos ubicaciones observadas.
- Los dos archivos EP Vault con sus hashes exactos ya verificados.

**Exclusión técnica\:** el elemento `EP\Runtime\Cryptomator\ipc.socket` es un socket IPC efímero, no contenido de usuario; se excluirá. No se hará limpieza de `.git`, backups, staging ni archivos temporales del workspace. Los originales permanecerán intactos.

### Estrategia de cifrado y capacidad

La ruta Cryptomator existente es `C:\Users\fila4\entorno-persistente`\. Contiene ahora solo 2,855 bytes de estructura física y no está montada. La configuración de Cryptomator apunta a esa bóveda. La opción de menor cambio es utilizarla como contenedor exterior y copiar `SeryMente` a un **nuevo subdirectorio dentro del volumen montado**, sin sobrescribir su contenido existente. Después se desmontará limpiamente y se transferirá exclusivamente su almacenamiento físico cifrado.

La capacidad requiere control: `C:` tiene aproximadamente 15.2 GiB libres y la fuente ocupa 7.42 GiB. No conviene mantener simultáneamente dos copias completas. El ciclo previsto es\:

1. Copiar a Cryptomator y comparar conteos, tamaños y SHA-256 del contenido copiado.
2. Desmontar y verificar que el volumen y sus procesos hayan cerrado.
3. Subir el almacén físico cifrado con `rclone copy`; ejecutar `rclone check`\.
4. Descargar objetos desde B2 a un directorio temporal aislado de `PC10RCIF4EI4`, de forma secuencial, comparar SHA-256 y retirar cada archivo temporal tras validarlo.
5. Eliminar el directorio temporal de verificación al terminar. No se tocará el workspace original ni se utilizará `01RENTA02`\.

`rclone` no está instalado. La versión oficial actual identificada es **1.76.0**, distribuida como ejecutable portable para Windows. Su configuración puede mantenerse solo en memoria con `--config NUL`; el backend B2 admite credenciales mediante variables de entorno del proceso, sin escribir `rclone.conf`\. \[[Rclone downloads](https://rclone.org/downloads/?utm_source=chatgpt.com); [Releases · rclone/rclone](https://github.com/rclone/rclone/releases?utm_source=chatgpt.com); [Documentation](https://rclone.org/docs/?utm_source=chatgpt.com); [B2](https://rclone.org/b2/?utm_source=chatgpt.com)\]

### Llave restringida B2 y arranque en frío

(Restricción soportada por B2)

La API B2 permite restringir una llave al bucket `OCP-MCP`, al prefijo `ep-ocp/`, a capacidades concretas y a una duración definida. \[[b2\_create\_key](https://www.backblaze.com/apidocs/b2-create-key?utm_source=chatgpt.com); [Cloud Storage Application Key Capabilities](https://www.backblaze.com/docs/cloud-storage-application-key-capabilities?utm_source=chatgpt.com)\]

La propuesta de llaves es\:

| Uso | Capacidades previstas | Alcance |
|--------|--------|--------|
| Escritura temporal del respaldo | `listBuckets`, `listFiles`, `readFiles`, `writeFiles` | `OCP-MCP`, prefijo `ep-ocp/` |
| Arranque en frío / recuperación | `listBuckets`, `listFiles`, `readFiles` | `OCP-MCP`, prefijo `ep-ocp/` |

Ninguna necesita `deleteFiles`\. La llave de recuperación se conservaría **fuera de EP Vault**, en un gestor de contraseñas controlado por el operador o en un medio físico cifrado y bajo su custodia. No se guardará en `PC10RCIF4EI4`, en el bucket ni en `01RENTA02`\.

Hay una condición de privilegios: crear llaves exige `writeKeys`\. Backblaze advierte que esa capacidad concede autoridad para crear llaves en la cuenta, por lo que la credencial que la tenga es de alto privilegio, aunque las llaves nuevas se creen restringidas. \[[b2\_create\_key](https://www.backblaze.com/apidocs/b2-create-key?utm_source=chatgpt.com); [Cloud Storage Application Key Capabilities](https://www.backblaze.com/docs/cloud-storage-application-key-capabilities?utm_source=chatgpt.com)\] El cliente B2 local confirma que soporta `key create --bucket` y `--name-prefix`, pero **no está verificado** que la credencial actualmente guardada en EP Vault tenga `writeKeys` ni que la cuenta permita usarla. No intentaré elevar permisos ni crear una llave privilegiada si no existe esa autorización.

### Prompt interactivo local en RDC

La ruta correcta de EP Vault activo ya está localizada y su SHA-256 cotejado. EP Vault v1.0.0 resuelve la bóveda desde `%LOCALAPPDATA%\Khora\secrets`; el perfil de esta máquina debe apuntarse **solo dentro del proceso** al directorio activo\:

```powershell
$env:LOCALAPPDATA = 'C:\Users\fila4\Desktop\SeryMente\Metodologia\frentes\ep\modulos\MOD-EPVAULT\v1.0.0\data\Fila4'
Import-Module 'C:\Users\fila4\Desktop\SeryMente\Metodologia\frentes\ep\modulos\MOD-EPVAULT\v1.0.0\src\EP.Vault.Core.psm1' -Force
$master = Read-Host 'EP Vault master password - enter locally only' -AsSecureString
```

Cuando autorices, abriré una nueva ventana visible de PowerShell en `PC10RCIF4EI4`\. El operador tecleará ahí; **no** enviaré esa entrada con `interact_with_process`, no la pondré en argumentos ni en el chat. El proceso usará las funciones internas de EP Vault para recuperar únicamente la credencial B2 en memoria, sin imprimir el valor ni emitirlo a los logs; luego bloqueará la sesión y liberará las referencias sensibles. No usaré la acción CLI `RevealVariable`, porque imprime el valor en stdout.

El desbloqueo de Cryptomator será un prompt local separado si su contraseña no coincide con la de EP Vault. No asumiré que ambas contraseñas son iguales.

### Límites de seguridad y estado de ejecución

Una advertencia material: `Read-Host -AsSecureString` evita que el secreto aparezca en esta conversación, en los argumentos del comando o en un archivo temporal. **No garantiza confidencialidad frente al administrador, kernel, EDR o un keylogger del propio `PC10RCIF4EI4`**, que no es un equipo confiable. Tampoco protege el plaintext de `SeryMente` que actualmente ya reside en esa máquina. El respaldo en B2 quedará cifrado por cliente, pero no convierte el host de origen en confiable.

Estado real a este momento\:

| Acción | Estado |
|--------|--------|
| Inventario y hashes de las dos raíces EP Vault | **Verificado** |
| Prompt local definido | **Preparado para lanzar; no abierto** |
| Contraseña maestra introducida | **No** |
| Credencial B2 extraída | **No** |
| Llave restringida creada o validada en cuenta | **Pendiente de autenticación** |
| `rclone` descargado y verificado | **Pendiente** |
| Copia Cryptomator, desmontaje y subida B2 | **No ejecutados** |
| Read-back SHA-256 desde B2 en PC10 | **No ejecutado** |
| Operaciones en `01RENTA02` desde tu ajuste | **Ninguna** |

**Siguiente acción\:** responde `AUTORIZO PROMPT LOCAL EN PC10` para que abra la ventana visible y el operador introduzca la contraseña directamente allí. No necesito que compartas ningún secreto en el chat.
