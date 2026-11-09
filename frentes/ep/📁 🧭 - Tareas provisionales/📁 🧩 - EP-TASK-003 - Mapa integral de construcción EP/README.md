# EP-TASK-003 · Materialización del workspace y dead-man trigger fuera de CECEQ

**Naturaleza:** tarea provisional del frente EP; sin titularidad, control, sesión ni folio propios.  
**Estado:** `en_curso` — alcance delimitado; implementación del disparador pendiente.  
**Responsabilidad:** frente EP.  
**OEP padre:** [OEP](../../OEP.md), especialmente §106.

## Alcance

1. Materializar el root `SeryMente` en el Escritorio efectivo de la sesión Windows, con los repositorios actuales de la organización SeryMente.
2. En los repositorios que sean extensiones de Chrome, mantener la carpeta cargable `Extensión` sincronizada con el commit fuente.
3. Cifrar el workspace completo con BitLocker en todas las ubicaciones. Se usa la misma contraseña maestra de la bóveda canónica de variables de entorno.
4. En **CECEQ**, conservar el workspace cifrado al cierre; no aplicar volatilización automática.
5. En ubicaciones **distintas de CECEQ**, implementar exclusivamente un dead-man trigger ligado a la terminación del proceso que mantiene abierta la sesión EP. Al dispararse: bloquear BitLocker, desmontar el volumen y eliminar únicamente el contenedor/carpeta de trabajo EP.

## Diseño histórico revisado: solo el disparador

Fuentes consultadas en KHORA, commit histórico `1db42a7fac9f154ac1afbeffc23ff06ea07b1384`:

- [OEP §28–§30](https://github.com/SeryMente/khora/blob/1db42a7fac9f154ac1afbeffc23ff06ea07b1384/OEP.md): pérdida de control autorizado como condición para volatilizar la instancia local.
- [10-guardian.ps1](https://github.com/SeryMente/khora/blob/1db42a7fac9f154ac1afbeffc23ff06ea07b1384/scripts/khora/modules/10-guardian.ps1): se retiene únicamente el evento de terminación del proceso de control. El resto de señales de ese módulo no se incorpora.
- [11-cleanup.ps1](https://github.com/SeryMente/khora/blob/1db42a7fac9f154ac1afbeffc23ff06ea07b1384/scripts/khora/modules/11-cleanup.ps1): se toma solo como referencia histórica para bloquear/desmontar antes de retirar el contenedor. No se porta su flujo amplio.

## Exclusiones expresas

No implementar ni incluir en el backlog de esta versión: Guardian como subsistema; vigilancia anti-exfiltración; monitoreo de procesos, archivos, red o actividad; heartbeat; polling/sondeo; temporizador de inactividad; cierre de VS Code o de cualquier IDE; tareas programadas, AtStartup, telemetría o vigilancia en segundo plano.

## Estado de ejecución

La actualización documental está publicada. El dead-man trigger todavía no está codificado ni activado. Esta actualización no modificó scripts, tareas de Windows, volúmenes ni perfiles locales.



## Rectificación y estandarización del workspace SeryMente · 2026-11-09

**Fuente rectora:** instrucción directa del operador en esta conversación; OEP §108. Esta entrada rectifica las menciones anteriores a `Ser y Mente` y `extension/` como nombres de destino. Se conserva la crónica anterior como procedencia histórica, no como criterio vigente.

### Contrato de directorios

La raíz exacta es `%USERPROFILE%\Desktop\SeryMente` (resuelta desde la sesión Windows propietaria, nunca desde el token del agente). En ella se clona directamente cada repositorio visible de la organización GitHub `SeryMente`; dentro de cada clon se mantienen sus frentes de trabajo.

En el frente que corresponda a una extensión Chrome MV3, el paquete cargable se materializa en la carpeta exacta `Extensión` (con acento y E mayúscula). Chrome debe cargar esa carpeta y no el repositorio contenedor ni el directorio de observabilidad. El paquete es derivado de la fuente de GitHub: cada modificación del commit fuente debe actualizar el paquete local, cotejar su manifiesto, sus rutas relativas, la revisión de origen y los SHA-256. No crear una carpeta `Extensión` en frentes que no sean extensiones.

**Observabilidad local:** recomendación técnica registrada, pendiente de ratificación: crear `Observabilidad` como carpeta hermana de `Extensión` dentro del mismo frente, con `Local\`, `Cola\` y `Exportaciones\`. La ruta local recibe cada evento de forma append-first/durable antes de cualquier envío de red. Un proceso/cola independiente podrá sincronizar los conjuntos elegibles a B2 después de validar integridad y política. Los logs de alta frecuencia y datos sensibles no se suben por defecto; selección, redacción, retención y destino se definen en EP-TASK-002. La carpeta de observabilidad jamás forma parte del paquete que Chrome carga.

### Inventario dinámico observado

El listado GitHub disponible el 2026-11-09 expuso 11 repositorios: `khora`, `serymente`, `otrogranprograma`, `GDP`, `khora-effectif`, `signal-interpreter`, `metodologia`, `tercer-ambito`, `personal`, `filo-sangriento` y `Language`. La instancia futura vuelve a consultar la organización; no fijar este conjunto de 11 en el código.

Los árboles recursivos `main` de los 11 repositorios se consultaron sin truncamiento. Se identificaron candidatos MV3:
- `GDP/manifest.json` — MV3, candidato de Gestor de Procesos.
- `khora-effectif/manifest.json` — MV3.
- `signal-interpreter/manifest.json` — MV3; su README confirma que Chrome carga la raíz que contiene el manifiesto y que `extension/` contiene código interno referenciado por él. Para el estándar local `Extensión`, el paquete debe conservar la raíz y las rutas relativas referidas, no cargar únicamente `extension/`.
- `khora/apps/harmonia-observability/extension/manifest.json` — MV3.
- `khora/khora-web/extension/harmonia/manifest.json` — MV3.
- `khora/khora-web/public/manifest.json` es manifiesto PWA, no extensión Chrome.
- `tercer-ambito/etica/manifest.json` es un manifiesto documental, no extensión Chrome.

La clasificación final y el mapeo fuente → frente → carpeta `Extensión` debe contrastarse con el OCP/README del frente de cada repositorio antes de producir paquetes instalables. La presencia de un manifiesto MV3 no autoriza a cargarlo en Chrome ni sustituye la prueba funcional/aceptación de cada extensión.

### Cifrado y volatilidad

El workspace completo debe residir en un VHDX de datos, montado en `Desktop\SeryMente`; el archivo VHDX permanece fuera del punto de montaje, bajo una ruta de estado local validada. Antes de clonar el primer repositorio, el volumen interno deberá tener BitLocker `XtsAes256`, protector de contraseña ligado a la misma contraseña maestra de la bóveda canónica (introducida únicamente de forma local/segura), protector de recuperación separado custodiado en esa bóveda, `ProtectionStatus=On` y `EncryptionPercentage=100`. No materializar clones ni frentes en claro. El estado BitLocker de C: no acredita el cifrado del VHDX.

- CECEQ: al finalizar, bloquear y desmontar; conservar el VHDX cifrado.
- Cualquier otra ubicación / `LOC-OTHER`: al terminar el proceso que controla la sesión EP, bloquear, desmontar y eliminar únicamente el contenedor del workspace.
- Se excluyen Guardian genérico, polling, heartbeat, inactividad, cierre de IDE y tareas programadas; OEP §106 retiene únicamente la terminación del proceso de control EP.

El disparador todavía no está implementado ni activado.

### Preflight y estado real PC-14 · 2026-11-09

RDC autenticado: PC-14 Online, ID `4fc35a07-2192-4b88-81ec-96cb450d565e`. La sesión de consola observada es `PC-14\PC 13`, SessionId 1, `USERPROFILE=C:\Users\PC 13`, Escritorio `C:\Users\PC 13\Desktop`. El token RDC tiene privilegio de Administradores. El volumen C: está `FullyDecrypted`, protección `Off`, 0 %, método `None`. No existía `Desktop\SeryMente` y no se creó: no hay VHDX, clones, carpetas ni cambios BitLocker realizados en este ciclo.

El operador declara la ubicación como cibercafé, por lo que se trata provisionalmente como `LOC-OTHER`. La discrepancia entre la directriz previa de ejecutar en el usuario Windows `fila4` y la única sesión de PC-14 (`PC 13`) bloquea la escritura hasta que el operador resuelva cuál es el perfil propietario. P012/P013 requieren además presencia/revisión presencial del operador en el ciclo para acciones de cifrado/seguridad; la autenticación RDC no es prueba independiente de presencia física.

### Estado ejecutivo

| Componente | Estado |
|---|---|
| Nombre raíz `SeryMente` y jerarquía repo → frentes | RECIBIDO Y DOCUMENTADO |
| Inventario de 11 repositorios accesibles y tree recursivo | INSPECCIONADO |
| Mapeo de todos los frentes y paquetes Chrome MV3 | EN CURSO · falta revisar contratos canónicos de cada frente |
| Carpeta cargable `Extensión` | DISEÑO DEFINIDO · materialización pendiente |
| `Observabilidad` hermana de `Extensión` | RECOMENDACIÓN · pendiente de ratificación |
| Captura local append-first y cola B2 | REQUISITO REGISTRADO · implementación/retención pendiente en EP-TASK-002 |
| VHDX / BitLocker XTS-AES256 | PENDIENTE · no creado ni cifrado |
| Dead-man trigger LOC-OTHER | DOCUMENTADO · no implementado ni activado |
| Materialización en PC-14 | BLOQUEADA · discrepancia de usuario, P012/P013 y bóveda maestra no lista |

**Resultado:** EP-TASK-003 continúa `en_curso`. La rectificación documental no convierte en materializado, cifrado, sincronizado ni efímero el workspace.


## Preparación de herramientas Git/CLI en PC-14 y Fila 4 · 2026-11-09

**Autorización:** el operador declaró presencia física ante PC-14 y autorizó usar también el dispositivo Fila 4 para instalar CLI/herramientas de desarrollo necesarias en ambos equipos. La mención «CI» se interpretó como «CLI», por el contexto de instalación de herramientas para trabajar con repositorios.

### PC-14

Dispositivo RDC Online `4fc35a07-2192-4b88-81ec-96cb450d565e`; identidad interactiva `PC-14\PC 13`. Se intentó instalar Git for Windows 2.56.0.4 y GitHub CLI 2.103.3 mediante WinGet en alcance de máquina.

Verificación final:
- `C:\Program Files\Git\cmd\git.exe` existe; ejecución directa informa `git version 2.56.0.windows.4`.
- `C:\Program Files\GitHub CLI\gh.exe` existe; ejecución directa informa `gh version 2.103.3 (2026-10-26)`.
- `winget list --source winget` confirma Git 2.56.0.4 y GitHub CLI 2.103.3.
- El PATH persistente de máquina contiene `C:\Program Files\Git\cmd` y `C:\Program Files\GitHub CLI\`. El proceso RDC heredó un entorno previo y no resolvió los comandos por nombre en shells nuevos; la invocación por rutas absolutas sí quedó verificada. Puede requerirse abrir una nueva terminal de usuario para refrescar el PATH heredado.
- `gh auth status` responde que no hay sesión autenticada para ningún host GitHub. No se ejecutó `gh auth login`, no se generó token, ni se almacenó/transferió credencial.
- La instalación de Git devolvió primero `0x80070020` (archivo en uso); el proceso posterior dejó los binarios y el paquete registrados en las versiones indicadas, leídos de vuelta. GitHub CLI terminó con código 0. La transcripción PowerShell no inició porque el host no admitió Start-Transcript en esa sesión; no se presenta un log de transcripción inexistente.

### Fila 4

Dispositivo RDC Online `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`; la sesión interactiva real sigue siendo `CENTRAL\fila4`, SessionId 4. El preflight ya verificaba Git 2.45.2 y GitHub CLI 2.52.0 en `C:\Program Files`. Permanecen instalados y disponibles en el host; la actualización a las versiones actuales no se ejecutó porque el proceso RDC disponible opera como `CENTRAL\MantenimientoRCI` y el intento de preparar ejecución auxiliar bajo fila4 fue bloqueado por los controles de herramienta antes de alcanzar el host. No se creó tarea auxiliar ni se modificó el perfil fila4. Se mantiene como actualización pendiente, no como fallo de instalación.

### Dependencias y límites

- La presencia de Git y gh no equivale a autenticación del usuario. Para clonar repositorios privados se requiere una autorización de `gh auth login` en cada perfil Windows que vaya a usarlos; no reutilizar ni copiar el token de otro perfil.
- No se ejecutó login, no se consultaron ni transfirieron tokens existentes, no se modificaron archivos de credenciales.
- No se materializó ningún repositorio ni se creó `Desktop\SeryMente`; el preflight previo sigue siendo el estado de workspace.
- PC-14 C: permanece FullyDecrypted/0%/Protection Off. Fila 4 C: FullyEncrypted/100%/Protection Off/XtsAes128. BitLocker sigue fuera de conformidad.
- EP-TASK-003 continúa `en_curso`. La materialización se mantiene bloqueada hasta aceptar la bóveda canónica, disponer de la contraseña maestra y protector de recuperación, y completar el VHDX BitLocker XTS-AES256 con protección activa y cifrado al 100 %.

## Ejecución provisional en PC-14 · 2026-11-09

El operador autorizó priorizar RDC e instanciar el directorio aunque temporalmente no esté cifrado, para comenzar frentes no sensibles. La excepción no modifica el diseño permanente de workspace protegido.

**Resultado ejecutado y verificado**
- Host: PC-14 · RDC ID `4fc35a07-2192-4b88-81ec-96cb450d565e`.
- Identidad Windows: `PC-14\PC 13`.
- Root: `C:\Users\PC 13\Desktop\SeryMente`.
- Once scaffolds vacíos: khora, serymente, otrogranprograma, GDP, khora-effectif, signal-interpreter, metodologia, tercer-ambito, personal, filo-sangriento y Language.
- `WORKSPACE-STATUS.md`: 37 líneas, SHA-256 `3B03FE0507903B7B42BA538B55D2954E9241A7C4A5F3746FB8D4C091117063EF`, leído de vuelta.
- C: sigue FullyDecrypted/0 %/Protection Off/EncryptionMethod None.

**Clasificación:** root y scaffolds CREADOS; NO hay clones Git. No se creó VHDX ni se cambió BitLocker. No hubo `gh auth login`, consulta/transferencia de tokens ni escritura de secretos.

**Uso permitido:** código y documentación técnica no sensible. Prohibidos: bóveda formal, contraseñas, protector de recuperación, tokens, claves B2, variables con secretos, material DPAPI y notas de Custodia.

**Persistencia fuente:** la exportación `ChatGPT-EP (1)-20261109-1031.md` está archivada en [main](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/entregas/ChatGPT-EP%20(1)-20261109-1031.md); 82,367 bytes, 1,645 líneas, SHA-256 `B08DEE8C0317EC2DDC28CD5D98925A975F1C571A1CC6B3C9852319CC945CF001`, commit `7260b1d398904f7dc13a76858d9f6f3c661831a7`, blob `0be706ff04bfe9158c0f33b2f984c3952a6d03e4`; read-back exacto.

**Secuencia siguiente:** autorización explícita para GitHub auth en el perfil PC-14\PC 13; clonar repositorios reales; validar frente y paquete MV3 antes de generar `Extensión`; ratificar `Observabilidad` como hermana; terminar y aceptar la bóveda; migrar a VHDX + BitLocker XTS-AES256/Protection On/100 %; implementar después dead-man LOC-OTHER.

**Estado:** `en_curso`. La instancia provisional no cierra EP-TASK-003.

---

## Continuidad operativa PC-14 · VHDX y BitLocker · 2026-11-09

**Fuente documental recibida:** ChatGPT-EP-20261109-1104.md, preservada en frentes/ep/entregas/ChatGPT-EP-20261109-1104.md; 999 líneas, 38.069 bytes UTF-8, SHA-256 de origen B032A6033BABC0B1061C2823D5B3C64C3A041DC842978E73B6D26216977805D4, Git blob f14febd7b5f673d9b2f7b1226603eb1243758ea0; lectura de vuelta exacta.

### Estado real observado en PC-14

- Equipo RDC 4fc35a07-2192-4b88-81ec-96cb450d565e; usuario PC-14\PC 13, SessionId 1; PowerShell elevado.
- Workspace C:\Users\PC 13\Desktop\SeryMente; conserva los 11 directorios raíz canónicos.
- La inspección actual encontró 195 archivos (2.877.377 bytes), todos bajo signal-interpreter; los otros diez directorios raíz no contienen archivos. El árbol completo se mantuvo intacto.
- No se encontraron rutas por nombre que coincidan con patrones típicos de credenciales, claves privadas, almacenes de contraseñas o bases de datos; no se inspeccionó contenido de archivos para clasificar secretos.
- C: sigue sin BitLocker (FullyDecrypted, 0 %, protección Off). No se modificó.

### Preparación del volumen

- Se creó C:\Users\PC 13\AppData\Local\Khora\workspace\containers\SeryMente.vhdx, VHDX expandible de 100 GB, con GPT y volumen NTFS SeryMente, montado temporalmente como W:.
- DiskPart informó creación, attachment, inicialización GPT, partición, formato y asignación de W: con código de salida 0. No se ha añadido ningún dato al VHDX.
- BitLocker aún no está activado en W: (VolumeStatus FullyDecrypted, EncryptionMethod None, ProtectionStatus Off). La consola nativa manage-bde -on W: -password -usedspaceonly -encryptionmethod XTS_AES256 -skiphardwaretest está abierta en SessionId 1 y espera la introducción local de la contraseña maestra de EP Vault (12 letras). El secreto no se ha transmitido al chat, a argumentos de proceso ni a archivos.
- La bóveda formal PC-14 se verificó por API local como ep-env-vault/1, 448 bytes, sesión activa, cero variables formales y cero notas. No se abrió ni reveló contenido. La variable EP_WORKSPACE_BITLOCKER_RECOVERY_PASSWORD todavía no existe.
- La clave de recuperación debe generarse como protector BitLocker y almacenarse por el núcleo EP Vault mediante una escritura local con lectura de vuelta verificada. Esto no se ha ejecutado aún.

### Compuertas para continuar

1. El operador introduce directamente en la consola local el mismo secreto maestro que desbloquea EP Vault.
2. Leer solo metadatos BitLocker: método XtsAes256, protección On, estado FullyEncrypted, 100 %.
3. Crear y registrar en la bóveda formal la contraseña de recuperación; verificar lectura de vuelta sin mostrarla ni registrarla.
4. Copiar los 195 archivos y los 11 directorios de Desktop\SeryMente al volumen protegido, con manifiestos de tamaño/SHA-256 de origen y destino.
5. Sustituir el directorio ordinario por el punto de montaje Desktop\SeryMente; verificar de nuevo el árbol, conservar temporalmente la fuente hasta el read-back y retirarla solo tras confirmar la migración íntegra.

**Estado:** en_curso. El VHDX existe y está vacío; el workspace actual continúa fuera del volumen. No declarar cifrado, protegido ni migrado hasta que todas las verificaciones anteriores estén completas.
---

## Incidencia de custodia de BitLocker y bloqueo de migración · 2026-11-09

El volumen W: permanece cifrado XTS-AES256, Protection On, 100 %, con protector Password y RecoveryPassword. El cmdlet de creación del protector RecoveryPassword emitió el número en la salida del proceso remoto. Se clasifica por prudencia ese protector como POTENTIALLY_EXPOSED; no se debe confiar en él como único mecanismo de recuperación.

La escritura automática en EP Vault como EP_WORKSPACE_BITLOCKER_RECOVERY_PASSWORD fue bloqueada por los controles de la herramienta antes de ejecutarse. No existe evidencia de variable guardada ni read-back. La bóveda formal conserva 0 variables según última lectura anterior a la incidencia.

Siguiente secuencia: crear un nuevo protector RecoveryPassword con salida suprimida y valor solo en memoria; guardar/leer de vuelta en EP Vault sin stdout/log/chat/clipboard; verificar Password+RecoveryPassword y estado On/100; retirar el protector potencialmente expuesto; después migrar los 195 archivos por SHA-256. Mientras tanto no mover, borrar ni modificar Desktop\SeryMente.

---

## Actualización de custodia BitLocker · 2026-11-09 · posterior a §114 OEP v0.3.48

Esta actualización supersede los estados anteriores de este README que marcaban la custodia del protector como pendiente o no verificada.

- W: mantiene `XtsAes256`, `Protection On`, `FullyEncrypted`, `100 %`.
- Se creó el protector RecoveryPassword nuevo `{4D46BB4B-932D-4E56-89EB-7A177DBD1C84}`.
- EP Vault confirmó `VAULT_WRITE_READBACK_VERIFIED` para `EP_WORKSPACE_BITLOCKER_RECOVERY_PASSWORD`; el secreto no se incluyó en la salida.
- Después de esa verificación se retiró el protector potencialmente expuesto `{3654D7BC-6BB7-492B-A346-6762969E90D1}`. Se confirmó un único protector RecoveryPassword nuevo y un protector Password.
- El portapapeles se limpió y verificó sin leer su contenido: `CLEARED_TEXT_FORMATS_VERIFIED`.

**Pendiente:** los 195 archivos/11 directorios siguen en `Desktop\SeryMente`. No hay copia a W:, manifiesto SHA-256, montaje en la ruta del Escritorio ni eliminación del origen. RDC informa 0 % de llamadas restantes; por eso la migración no se ejecutó. Mantener el origen intacto y EP-TASK-003 en `en_curso` hasta completar la copia, ambos read-backs SHA-256 y la aceptación.


---

## Reconciliación de exportación ChatGPT-EP-20261109-1230 · 2026-11-09

La exportación original se adquirió desde el perfil/almacenamiento Windows `PC 13` dentro del equipo RDC `PC-14`, ruta `C:\Users\PC 13\Downloads\ChatGPT-EP-20261109-1230.md`. Se preservó byte por byte en `frentes/ep/entregas/ChatGPT-EP-20261109-1230.md`: 40.832 bytes, 853 líneas, SHA-256 `045FD76745669E2AD08A4A0F517FCB042B5CD2C3B3320AB5AD2E83F0972EF674`, Git blob `1be5a3b2a19dec4dd819648302664606654a4761`, commit `163138cc5a6113279fbc42eccbec036df424f8e4`. Read-back Base64 sin espacios coincide exactamente con el original.

La exportación repite un rótulo de progreso que dice «Migrado el espacio de trabajo», pero la respuesta explícita que sigue indica que RDC llegó a 0 % y no pudo ejecutar copia ni montaje. OEP §114 y la verificación canónica confirman que no existe copia a W:, manifiesto SHA-256 de destino ni sustitución del punto de montaje. **La frase de progreso no se toma como evidencia de ejecución.**

Estado que prevalece:
- W: permanece cifrado XTS-AES256, Protection On, FullyEncrypted/100 %.
- RecoveryPassword nuevo custodiado en EP Vault mediante `VAULT_WRITE_READBACK_VERIFIED`; protector anterior potencialmente expuesto retirado; un Password protector conservado; portapapeles limpiado/verificado.
- Los 195 archivos y 11 directorios siguen en `Desktop\SeryMente`, fuera de W:.
- EP-TASK-003 permanece `en_curso`; no borrar ni mover el origen hasta copiar y verificar rutas/tamaños/SHA-256, montar W: como `Desktop\SeryMente` y hacer un segundo read-back íntegro.


## Designación del destino del sprint Sink local · 2026-11-09

**Decisión posterior del operador:** destino Windows definitivo = perfil/usuario Windows `PC 7`; dispositivo RDC asociado a ese perfil según declaración del operador; clasificación de ubicación = `LOC-OTHER`.

- `PC 7` identifica el nuevo usuario/perfil Windows. No se interpreta como hostname ni como ID RDC.
- El nombre/ID técnico del dispositivo RDC, el estado de conexión, SID, usuario efectivo, rutas y permisos se obtendrán por preflight vivo. No se reutilizan identificadores históricos ni se presume continuidad de almacenamiento.
- La evidencia anterior de W:, BitLocker y workspace se mantiene atribuida al host/perfil donde fue observada. No prueba el estado del destino PC 7 hasta lectura de vuelta en ese destino.
- Por ser `LOC-OTHER`, el dead-man trigger es **OBLIGATORIO** antes de dejar persistente workspace o runtime MCP-OCP. Estado actual: diseñado/documentado; **NO IMPLEMENTADO / NO PROBADO / NO ACTIVADO**.
- Se conserva el alcance mínimo aprobado: terminación del proceso de control EP → bloquear BitLocker → desmontar → eliminar exclusivamente el contenedor EP. Sin Guardian genérico, polling, heartbeat, inactividad, tareas programadas ni borrado fuera del perímetro.
- La migración de los 195 archivos/11 directorios sigue pendiente: primero identificar la fuente vigente, comparar manifiestos SHA-256 y conservar el origen hasta read-back íntegro en el volumen protegido.

### Gate actualizado para LOC-OTHER / PC 7

No se inicia una instalación persistente hasta completar y leer de vuelta: (1) vínculo RDC↔PC 7 y usuario/SID efectivos; (2) almacenamiento XTS-AES256, Protection On, FullyEncrypted/100 % y custodia recuperable; (3) migración/verificación del workspace si aplica; (4) dead-man implementado y probado en el perfil real; (5) runtime/DB/respaldos dentro del perímetro cifrado. La designación documental no equivale a preflight, permiso técnico, ejecución ni aceptación.


---

## Organización canónica del workspace — PC 7 · 2026-11-09

**Fuente de autoridad:** DUG v386 / NX-386m, ART-030; OEP v0.3.54 §119. Esta decisión sustituye el árbol plano de repositorios directamente bajo `SeryMente/` registrado históricamente en §108.2–§108.3.

### Árbol vigente

```text
SeryMente/
├── Repositorios/
│   ├── Signal Interpreter/
│   │   └── signal-interpreter/
│   ├── Gestor de Procesos/
│   ├── Khora/
│   └── Metodologia/
│       └── metodologia/
├── Datos/
│   ├── Signal Interpreter/
│   ├── Gestor de Procesos/
│   ├── Khora/
│   └── Metodologia/
└── Temporal/
    └── Sesiones/
```

La ruta local observada ya fue reestructurada con esos directorios. La carpeta Signal Interpreter y la materialización local de metodologia se reubicaron sin borrar sus contenidos. La materialización metodologia sigue siendo parcial y no debe presentarse como clon íntegro ni sincronizado. Los otros frentes tienen carpetas de agrupación; no se afirma que sus repositorios estén clonados.

### Reglas de trabajo

- Un checkout por repositorio remoto, dentro de la carpeta del frente propietario/principal: `Repositorios/<Frente>/<repo>/`.
- Si el repo es extensión Chrome, el estándar nuevo requiere `extension/manifest.json` como raíz cargable, sin imponer esa carpeta en proyectos no-extension.
- Signal Interpreter es excepción heredada: su manifiesto sigue en la raíz del repo y sus rutas apuntan a `extension/`; no cambiarlo sin migración completa y pruebas.
- Código y documentos técnicos dentro de repositorios; datos operativos bajo `Datos/<Frente>/<Proyecto>/`; caché, staging, logs saneados y sesiones bajo `Temporal/`; secretos y almacén formal de Vault fuera del workspace.
- La persistencia de datos no se habilita por crear el directorio. Cada proyecto requiere política de clasificación, retención, cifrado, respaldo y restauración.
- PC 7 está clasificado LOC-OTHER. VHDX+BitLocker XTS-AES256/Protection On/100 % y dead-man EP siguen siendo compuertas independientes. La estructura lógica observada no demuestra el perímetro cifrado ni recuperación.

**Estado:** organización lógica MATERIALIZADA; protección física, respaldos y aceptación NO VERIFICADOS.