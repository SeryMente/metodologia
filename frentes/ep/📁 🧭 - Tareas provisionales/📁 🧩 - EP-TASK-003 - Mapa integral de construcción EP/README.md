# EP-TASK-003 · Materialización del workspace y dead-man trigger fuera de CECEQ

**Naturaleza:** tarea provisional del frente EP; sin titularidad, control, sesión ni folio propios.  
**Estado:** `en_curso` — alcance delimitado; implementación del disparador pendiente.  
**Responsabilidad:** frente EP.  
**OEP padre:** [OEP](../../OEP.md), especialmente §106.

## Alcance

1. Materializar la carpeta `Ser y Mente` en el Escritorio efectivo de la sesión Windows, con los repositorios actuales de la organización SeryMente.
2. En los repositorios que sean extensiones de Chrome, mantener la carpeta cargable `extension/` sincronizada con el commit fuente.
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
