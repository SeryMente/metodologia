# KHORA Workstation Bootstrap · OCP provisional

**Estado:** PROVISIONAL · AUDITORÍA ABIERTA · NO ACEPTADO COMO BOOTSTRAP FINAL  
**Versión del objeto:** v0.1.1  
**Evento de inicialización:** C-KHORA-WORKSTATION-BOOTSTRAP-01  
**Transferencia vigente:** `C-KHORA-WORKSTATION-BOOTSTRAP-TRANSFER-20261101-01` · UUIDv7 local `01a19945-ec5e-75ff-88e4-c5bd06857f9c`  
**Titular vigente:** `chatgpt-C-KHORA-WORKSTATION-BOOTSTRAP-TRANSFER-20261101-01` · generación 2  
**OCP:** `frentes/khora-workstation-bootstrap/`  
**Única fuente ejecutable:** `scripts/khora-workstation-bootstrap-v6.ps1`  
**Fuente documental:** `SeryMente/metodologia/main`

## 1. Control e identidad

- Titular operativo vigente: `chatgpt-C-KHORA-WORKSTATION-BOOTSTRAP-TRANSFER-20261101-01`; instancia: `chatgpt-khora-workstation-bootstrap-transfer-20261101-01`. Son alias operativos, no IDs nativos.
- Generación vigente: 2. La titularidad previa y generación 1 se conservan en `ownership_history` del control.
- Folio SES: NO ASIGNADO. FOL1 está PREPARADO, no ACTIVO.
- UUIDv7 local del ciclo de inicialización: `01a18f9a-a9ac-7e72-8da7-4ad78ccf3b3e`.
- Script base V6: commit `aa45426ece7374e9812868e04e0ce5f783cebf4d`; blob SHA `862e63bd00a84cdbe5c2d913794cc17de373356a`; SHA-256 `dd71b638fab3694e89ae58d7faf265941cd6a289ecbf9602bf0d434837635d7b`.
- V5 se conserva como antecedente. V6 es la base de auditoría, no la versión definitiva aceptada.

## 2. LEER PRIMERO

Este OCP mantiene **un único script PowerShell**. El archivo fuente permanece en GitHub; el lanzador obtiene el contenido privado mediante GitHub CLI, verifica blob SHA, tamaño y SHA-256, y ejecuta el ScriptBlock en memoria. No crear una copia persistente local del `.ps1`.

**No es una aplicación Next.js ni un proyecto web.** No debe instalar, invocar ni requerir Next.js, una interfaz web, un servidor de desarrollo, un build web ni un despliegue. El script V6 fue escaneado y no contiene referencias a Next/Next.js. El proceso Next.js observado en el historial de PC-14 procedía de otra orden explícita y otro directorio; véase §11.

Distinguir las autorizaciones:
1. **GitHub:** login/device authorization del usuario GitHub con alcance suficiente para acceder al repositorio privado. Debe comprobarse el acceso real al repositorio, no solo que `gh auth status` responda correctamente.
2. **Vercel:** autenticación separada que V6 hereda de V5. Su necesidad debe confirmarse antes de retirarla o consolidarla; no equivale a GitHub.
3. **Desktop Commander/RDC:** autorización de dispositivo remoto separada, con `--no-persist-session` y handshake completo. No equivale a autorizar GitHub.

No modificar el DUG, Metacanon ni OCP ajenos. Cumplir Metacanon §24: el RDC solo se usa cuando sea imprescindible y dentro de su restricción de GUI.

## 3. Referencia metodológica

Fuente releída en `main`:
- DUG v373 · NX-373m; blob SHA `cac4525de77d4f47a8a59c25201968ecf2056b90`.
- Metacanon 1.26 · `METACANON-OBJETOS-v1.26`.
- GOW 2.14; §ARR revisado.
- Principios pertinentes: P001, P004, P005, P037, P038 y P043.
- Metacanon §§3–4, 22, 24, 26–28, 39, 42–43 y 46–51.

El DUG no se modificó. La escritura del OCP se limita a este frente nuevo y las referencias del inventario.

## 4. Propósito y alcance

### Propósito original del operador · verbatim

> Es uns cript de pwoershell, nada mas que almacenado en github ok? Y por eos en la secuencia debe de poder pedir login y autorizar dispositov en github para pdoer accdeer al resto ok?

> documentalo en un OCP provisional para este script en metodolopgia para que lo trabajes con persistencia.

Los mensajes completos se conservan en `conversaciones/C-KHORA-WORKSTATION-BOOTSTRAP-01-dialogo.jsonl`.

### Lectura operativa separada

Mantener y endurecer un solo bootstrap PowerShell, almacenado en el repositorio privado Metodología, que pueda solicitar autenticación/autorización GitHub cuando falte, comprobar acceso al contenido privado y continuar con las dependencias CLI y sesión RDC acordadas, sin convertirse en aplicación web ni persistir una copia local del script fuente.

### Dentro del alcance

- Un archivo fuente PowerShell en `scripts/`; un lanzador PowerShell que recupera ese archivo desde GitHub privado y lo ejecuta desde memoria.
- GitHub CLI/device flow con alcance `repo`, comprobación del acceso efectivo al repositorio y reautorización recuperable ante cuenta/scope incorrectos.
- Preparación/verificación de Node.js, npm/npx, Git y GitHub CLI.
- Revisión de Vercel CLI/login heredado, sin retirarlo silenciosamente.
- Desktop Commander/RDC con `--no-persist-session`, autorización humana y handshake verificable.
- Logs/temporales de ejecución, pruebas, evidencia y continuidad documental.

### Fuera del alcance

- Next.js, UI web, servidor web, API web, builds web, preview o deploy.
- Guardar una copia persistente local del `.ps1`.
- Cambiar otros OCP, el DUG, cuentas, credenciales o permisos ajenos.
- Revocar sesiones o terminar procesos de terceros sin autorización.

## 5. Roles y colaboración

- Operador: dicta la intención y realiza los pasos de autorización de cuenta/dispositivo que el flujo requiera.
- Asistente titular vigente (alias de generación 2): audita, modifica el único archivo mediante GitHub, verifica hash/read-back y mantiene este OCP.
- Constructor separado: NO ASIGNADO. No inventar un segundo rol.
- No utilizar GUI compartida sin autorización concreta conforme a §24.

## 6. Autoridad

- El OCP es provisional y subordinado al DUG/Metacanon.
- Solo el operador puede ampliar el alcance o ratificar la retirada de componentes heredados.
- La instrucción vigente delimita el producto a PowerShell almacenado en GitHub; cualquier interpretación como app Next.js queda excluida.
- No sustituir V6 hasta documentar delta, pruebas, read-back y preservar la revisión previa.
- Vercel CLI/login continúa provisionalmente por herencia; falta ratificar si forma parte del requisito definitivo.

## 7. Perfil de entorno

PC-14 observado durante las pruebas:
- PowerShell 5.1.26100.9711.
- Node.js v26.13.0; npm 11.20.0.
- Git 2.56.0.windows.4; GitHub CLI 2.103.3.
- Vercel CLI 65.9.0; Desktop Commander 0.3.1.
- Chrome presente.
- GitHub auth existente y Git HTTPS credential fill verificados; Vercel `whoami` exit 0.

La fuente del script no se conserva como archivo local persistente. El flujo sí usa TEMP para logs/stdout/stderr y las herramientas instaladas pueden conservar configuración de autenticación, cachés npm y estado de CLI; no confundir esto con guardar el script fuente. No se documentan tokens ni identificadores de cuenta.

## 8. Estado vivo

### V6 bajo auditoría

- Vercel 65.9.0 y Desktop Commander 0.3.1 están fijados.
- Node.js/Git/GitHub CLI se instalan mediante IDs winget LTS/latest y no están fijados a patch exacto.
- El lanzador verifica tipo, encoding, tamaño, blob SHA y SHA-256 antes de ejecutar en memoria.
- La protección fail-closed evita lanzar otro RDC si ya hay procesos Desktop Commander; el handshake tiene límite de cinco minutos.

### Evidencia ya obtenida

1. PowerShell parser real en PC-14: cero errores sintácticos y cero nombres de funciones duplicados.
2. Escaneo del archivo V6: cero referencias a Next/Next.js.
3. `-SelfTest`: PASS (secuencia de tonos, muestras de cadenas y vector SHA-256).
4. `-PreflightOnly`: exit code 0; Node/npm, Git, autenticación GitHub ya existente, Git HTTPS credential fill, Vercel 65.9.0 y `vercel whoami`.
5. Desktop Commander 0.3.1 `remote --help` confirma `--no-persist-session`.
6. El lanzador privado completó `-SelfTest` y comprobó integridad antes de ejecutar.

### No demostrado

- Prueba fría del lanzador el 2026-10-30: FALLÓ antes del login. `gh auth status` escribió su diagnóstico normal en `stderr`; el lanzador lo redirigió con `*> $null` bajo `$ErrorActionPreference='Stop'`, PowerShell lo elevó a `NativeCommandError` y abortó antes de evaluar `$LASTEXITCODE`. No se solicitó device code, no se accedió a la API privada y V6 no se descargó ni ejecutó. El bloque del lanzador se corrigió en el inventario; falta verificarlo en el equipo.
- Login GitHub inicial desde estado limpio/sin token anterior.
- Recuperación cuando `gh auth status` es válido pero el token es de otra cuenta o carece de `repo`/acceso al repositorio.
- Arranque RDC fresco completo con autorización del dispositivo, `Device ready`, estado Online y read-back SHA.
- Rama de login Vercel desde estado no autenticado.
- Prueba en instalación Windows limpia.

## 9. Aceptación y viabilidad

| Requisito | Estado | Evidencia / hueco |
|---|---|---|
| Producto único PowerShell, sin Next | PASS estático | Parser y escaneo V6; cero referencias Next. |
| Fuente en GitHub, no copia local persistente | PASS mecánico acotado | Lanzador privado verificó SHA y ejecutó desde memoria. |
| Login GitHub device flow `repo` | PARCIAL | Codificado; no probado desde auth limpia. |
| Acceso real al repo privado y reauth ante scope/cuenta incorrectos | ABIERTO · ALTO | V6 puede fallar tras `gh auth status` exitoso sin reautorizar. |
| Preparación Node/Git/GH CLI | PARCIAL | Preflight en PC-14; no prueba instalación completa en equipo limpio. |
| Vercel CLI/auth | PARCIAL | Instalación y whoami probados; login frío y necesidad pendiente. |
| RDC `--no-persist-session` + handshake | PENDIENTE · ALTO | CLI/help probado; handshake V6 fresco no probado. |
| Parser RDC completo | PARCIAL | Autoprueba busca cadenas; falta validar conjuntamente GUID, User, Name, Online, Device ready y policy. |

No declarar “a prueba de fallos” ni “sin errores garantizado”. V6 es una base parcialmente verificada y no aceptada.

## 10. Formato de ciclo

Toda salida identifica DUG/Metacanon/GOW, revisión/commit, OCP/control/generación, versión y SHA del script, requisito literal, cambio, prueba/entorno, resultado, huecos, siguiente acción y read-back. UUIDv7 local: `01a18f9a-a9ac-7e72-8da7-4ad78ccf3b3e`. FOL1 no activo; folios NO ASIGNADOS.

## 11. Crónica y fuentes

- Originales: `conversaciones/C-KHORA-WORKSTATION-BOOTSTRAP-01-dialogo.jsonl`.
- Crónica: `cronica/C-KHORA-WORKSTATION-BOOTSTRAP-01.md`.
- Evidencia: `evidencias/C-KHORA-WORKSTATION-BOOTSTRAP-01.json`.
- Pendientes: `PENDIENTES.md`.
- Única fuente ejecutable: `../../scripts/khora-workstation-bootstrap-v6.ps1`.
- Lanzador documentado en `INVENTARIO-REPOSITORIOS-Y-FRENTES.md`.
- Gobernanza: `../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`.

### Incidente “Next”

El historial de PC-14 muestra un proceso separado (PID 22636) ejecutado desde otro directorio mediante una orden explícita `node_modules/next/dist/bin/next build --webpack`. El código V6 no contiene Next ni lo invoca. La zona horaria del reloj local del equipo no se verificó. No atribuir ese proceso al bootstrap.

## 12. Reinstanciación

Leer INICIO.md, DUG/GOW vigentes, este control y núcleo; comparar titularidad y generación; recuperar crónica/originales; leer V6 desde `main` y comprobar commit/blob/SHA antes de editar. Ejecutar autopruebas/preflight primero. No matar procesos RDC existentes ni revocar credenciales para forzar una prueba.

## 13. Persistencia y revisión

La única fuente ejecutable es `scripts/khora-workstation-bootstrap-v6.ps1` en `main`; este OCP documenta estado, procedencia y evidencia pero no duplica el .ps1. Los cambios de código se publican desde GitHub con comprobación de revisión, SHA/read-back. Aceptación final exige cubrir los bloqueos críticos de `PENDIENTES.md` y conservar evidencia reproducible.
## 14. Registro acumulativo de features del módulo

Los requisitos funcionales solicitados por el operador se conservan en esta lista del OCP. Cada alta recibe un identificador estable, redacción verificable, estado y criterios de aceptación. No se crean OCP independientes por feature.

### F-01 — Ejecución unattended sin preguntas Yes/No

**Estado:** REQUISITO REGISTRADO · IMPLEMENTACIÓN PENDIENTE · NO PROBADO.

**Requisito:** el bootstrap debe realizar automáticamente las instalaciones, configuraciones y comprobaciones previsibles, sin solicitar respuestas Yes/No, confirmaciones de consola ni decisiones rutinarias. Debe utilizar parámetros no interactivos, valores deterministas y opciones silenciosas compatibles con cada herramienta. No debe esperar indefinidamente entrada del operador. Las operaciones de riesgo que no puedan resolverse con una política segura deben fallar de forma controlada, nunca convertirse en una pregunta interactiva.

**Límite externo:** el requisito no autoriza a suplantar al operador ni a eludir autenticación, MFA o consentimiento de proveedores. Cuando una autorización externa sea obligatoria, el script no simulará su concesión: finalizará con timeout finito, código de salida y diagnóstico accionable. La ejecución completamente unattended se exige cuando las credenciales y permisos requeridos ya están provisionados.

**Criterios de aceptación:** ejecución en entorno limpio con dependencias y credenciales disponibles sin intervención ni entrada estándar; análisis del flujo completo sin confirmaciones interactivas alcanzables; operaciones CLI en modo silencioso/no interactivo; pruebas de credenciales ausentes o expiradas con salida finita y sin preguntas; registro de fase, código de salida y causa sin secretos; read-back de fuente y requisito tras cada cambio.
