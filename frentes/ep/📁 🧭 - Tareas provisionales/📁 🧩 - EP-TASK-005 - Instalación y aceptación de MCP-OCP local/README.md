# EP-TASK-005 · Instalación y aceptación de MCP-OCP local por stdio

**Estado:** `pendiente` · **Frente:** Entorno Persistente · **OCP padre:** `frentes/ep/OEP.md`
**Origen:** planificación interfrente por instrucción directa del operador · 2026-11-09.
**Registro:** tarea provisional; no crea control, titularidad, sesión, generación ni folio independiente.

## Propósito

Recibir el artefacto MCP-OCP renovado y efectuar su instalación, bootstrap y aceptación en un perfil Windows real y confiable, exclusivamente después de que el destino, el almacenamiento y el canal local estén verificados. La instalación conserva MCP stdio; no requiere servicio Windows, listener HTTP, túnel ni endpoint público.

## Alcance

1. Destino ya designado por el operador: perfil Windows `PC 7`, asociado al equipo RDC correspondiente, ubicación `LOC-OTHER`. Al iniciar la operación, comprobar en vivo que el usuario Windows, SID efectivo, equipo RDC, rutas y permisos coinciden con esa designación. La designación no sustituye el preflight ni autoriza a reutilizar datos de sesiones temporales anteriores.
2. Confirmar en el destino PC 7 que workspace, runtime, base de datos y respaldos están dentro de un volumen protegido. El estado XTS-AES256/Protection On/FullyEncrypted 100 % y RecoveryPassword custodiado observado en otro perfil/host no se hereda: repetir la lectura de vuelta en el dispositivo RDC asociado a PC 7. EP-TASK-003 debe completar la migración y ambos read-backs SHA-256 antes de mover allí el runtime.
3. Resolver el root de datos del servidor. El código recuperable de MCP-OCP usa por defecto `%LOCALAPPDATA%\SeryMente\OCP MCP`; debe quedar dentro del perímetro cifrado o debe probarse cifrado completo del volumen que aloja ese perfil. MCP-OCP habilitará una configuración explícita y validada del root de datos/respaldos. La ruta concreta se elegirá en el preflight del perfil PC 7 y deberá estar dentro del volumen protegido que EP verifique en ese mismo host; no asumir W: ni heredar rutas de otra sesión.
4. Recibir solo un paquete nuevo, construido y verificado contra DUG Samantha v386/NX-386m y el núcleo MCP-OCP vigente. Verificar SHA-256, manifiesto, RID y resultados de pruebas antes de extraer.
5. Si se necesita clonar/actualizar el repositorio privado desde ese perfil, comprobar autenticación local. Si falta, el propietario realiza `gh auth login --web` de forma interactiva en ese Windows; el token permanece en el almacén local. La autenticación GitHub del conector de ChatGPT no se transfiere al equipo.
6. Ejecutar `import-sources` contra un checkout con los commits/blobs vigentes; verificar resultado y 43 IDs/MDP. No importar fuentes con pins antiguos.
7. Ejecutar `OcpMcp.exe provision-operator` de forma interactiva. El operador confirma en esa consola escribiendo exactamente `REGISTER <SID>` con el SID que muestre el proceso. No capturar ni transmitir el SID o claves por chat.
8. Configurar el cliente para iniciar el proceso MCP stdio desde la ruta protegida. Verificar `initialize`, `tools/list`, `tools/call`, respuesta completa, shutdown y reinicio limpio a través del mismo recorrido RDC que utilizará el operador.
9. El destino está clasificado como `LOC-OTHER`: no instalar ni dejar runtime persistente hasta que EP-TASK-003 tenga implementado y probado el dead-man trigger específico, con cierre/volatilización y recuperación verificados.
10. Aceptar solo con read-back de paquete, fuentes importadas, `operator_provisioned=true`, root de datos protegido, transporte probado y recibo E2E enlazado a GOV-TASK-003.


## Integración del panel visual en el ciclo de sesión EP · release MCP-OCP 1.0.0

Por instrucción directa del operador, la aceptación EP incluye la apertura automática del panel local MCP-OCP cuando la sesión persistente de este perfil esté realmente vigente.

- **Responsabilidad MCP-OCP:** entregar `OcpMcp.Panel.exe`, contrato `PANEL-OBSERVABILIDAD.md`, schema de estado/eventos, hashes y pruebas.
- **Responsabilidad EP:** escribir atómica y leer de vuelta `monitor/session.json` con `sessionState=ACTIVE`, `sessionStartedAtUtc`, `protectionState` y `protectionCheckedAtUtc`; abrir el panel como proceso hijo del controlador de sesión solo después de validar la sesión/manifest y completar los gates de seguridad aplicables, incluido el dead-man LOC-OTHER ya exigido por esta tarea. El archivo no contiene SID ni secretos.
- La ventana permanece abierta como aplicación mientras EP continúe ACTIVE. X/Alt+F4 la minimiza a la barra de tareas para evitar cierres accidentales; el operador puede restaurarla. Al finalizar la sesión EP, el controlador la cierra limpiamente y verifica que no quede proceso huérfano.
- El panel puede abrir antes que el servidor; debe mostrar “Sesión activa · esperando servidor MCP”. Si el servidor se cae pero EP permanece ACTIVE, la ventana sigue abierta y muestra el estado detenido/desconectado.
- La apertura no se configura como tarea programada, servicio Windows ni arranque genérico de inicio de sesión. No iniciar panel si el perfil/sesión/volumen/gates EP no están verificados.
- El panel solo lee `monitor/session.json` (escrito por EP), `monitor/state.json` y `monitor/events.jsonl` (escritos por MCP-OCP) del root protegido. EP conserva ACL y protección del almacenamiento; no se copian secretos ni datos de fuente al panel. El estado de protección se muestra con la hora de la verificación EP; no se sondea BitLocker en segundo plano.
- Esta integración no modifica EP-TASK-003: el dead-man conserva su contrato específico y no se convierte en heartbeat/monitor general.

**Prueba de aceptación EP:** EP escribe/coteja session.json ACTIVE → panel abre visible; server ausente → “esperando servidor”; X minimiza/restaura; fin EP → cierre limpio; server iniciado por cliente STDIO → estados separados de proceso/protocolo/readiness; server terminado → desconectado; fin EP → panel se cierra sin huérfanos. Verificar hashes del binario y del manifest instalado.

## Dependencias y límites

- **MCP-OCP:** MCP-OCP-07 (paquete/runbook), MCP-OCP-12 (bootstrap), MCP-OCP-08 (handoff) y pins actuales.
- **Gobernanza:** GOV-TASK-003 (aceptación E2E), GOV-TASK-007 (IPZ/read-back/FOL1 separado), GOV-TASK-008 (contrato Sink) y GOV-TASK-013 (medición RDC).
- **EP:** EP-TASK-003 (workspace protegido, migración y dead-man según ubicación).
- EP-TASK-004 (reconstrucción visual de la bóveda) no bloquea el build Sink ni el bootstrap DPAPI del servidor. Solo se incorpora si una operación concreta del handoff requiere esa GUI.
- EP-TASK-002 / Backblaze, NCL, Jules, PPR cross-host y Khora quedan fuera de este handoff.
- Esta tarea no autoriza por sí sola operaciones remotas ni cambios de BitLocker/ACL/Registro. La instrucción del operador autoriza el trabajo descrito, pero no sustituye permisos técnicos ni el consentimiento local interactivo.

## Bloqueos conocidos al planificar

- Los 195 archivos y 11 directorios del workspace seguían en staging; no había copia a W:, manifiesto de destino ni segundo read-back. No borrar el origen hasta el cotejo íntegro.
- La última evidencia EP reportó `remote_calls_left_pct = 0`. No eludir el límite por otro canal; se requiere capacidad RDC para la operación remota.
- El código recuperable usa LocalAppData por defecto. La configuración del root de datos cifrado debe resolverse antes de instalar.
- El perfil/host están designados como PC 7 + equipo RDC asociado / LOC-OTHER; falta comprobar en vivo identidad, acceso y estado de seguridad.
- La autenticación GitHub del conector de ChatGPT no equivale a autenticación local del perfil Windows.

## Criterios de cierre

- Host/perfil actual verificado en vivo, con ubicación y política EP aplicable.
- Workspace/runtime/DB/respaldos dentro de almacenamiento protegido.
- ZIP y manifiesto verificados por SHA-256; fuentes actuales importadas con pins aprobados.
- `operator_provisioned=true` después de consentimiento local interactivo; claves DPAPI CurrentUser ligadas al SID real.
- Prueba MCP stdio/RDC real: initialize, tools/list, tools/call de GOW:ARR, DUG y al menos un SINK:Pxxx, desconexión y reinicio.
- Panel MCP-OCP-13: session.json EP validado; apertura en EP ACTIVE, espera de servidor, observación de proceso/protocolo/readiness, caída del servidor, cierre de EP sin proceso huérfano y SHA del ejecutable/manifiesto cotejados.
- Sin listener, endpoint público, regla de firewall ni secretos en logs/salida/repositorio.
- Evidencia y read-back actualizados en esta ficha, el índice EP y OEP.

**Estado actual:** planificada, no iniciada. Destino designado: PC 7 / equipo RDC asociado / LOC-OTHER. Preflight, migración, dead-man, instalación y pruebas continúan pendientes. La creación de la tarea no modificó ningún equipo.


## Designación del destino · 2026-11-09

El operador designó **perfil Windows PC 7**, asociado a su dispositivo RDC, con ubicación **LOC-OTHER**. Esta decisión sustituye la pregunta pendiente sobre destino y clasificación. No se ha adquirido todavía el hostname/ID técnico del dispositivo ni se ha observado la sesión PC 7 en vivo.

**Bloqueo material actualizado:** LOC-OTHER obliga a completar EP-TASK-003 y verificar el dead-man específico antes de runtime persistente. Las evidencias previas de cifrado, W:, custodia y workspace no se trasladan por inferencia al nuevo perfil. La instalación, bootstrap, `provision-operator`, `REGISTER <SID>` y aceptación siguen pendientes; no se ha operado el equipo mediante esta actualización.


## Instalación obligatoria del release 1.0.0 en Metodología · 2026-11-09

El entregable de este sprint no es solo el ZIP: MCP-OCP 1.0.0 debe quedar instalado localmente en el checkout Metodología de PC 7.

- **Checkout único:** `SeryMente/Repositorios/Metodologia/metodologia/`.
- **Carpeta local obligatoria del programa:** `frentes/mcp-metodologia/instalacion-local/`.
- **Contenido:** ejecutable y runtime/dependencias necesarios, launcher, configuración de ejemplo sin secretos, manifest de archivos y SHA-256.
- **Exclusión Git:** la carpeta de ejecutables instalados/binarios generados queda ignorada por Git; se conserva código fuente y pruebas en el flujo versionado.
- **Root de datos:** SQLite, claves DPAPI CurrentUser, fuentes sensibles importadas, logs operativos y backups quedan fuera del checkout, en una raíz independiente dentro del volumen efectivamente protegido y verificado por EP. No usar LocalAppData por defecto sin verificar cifrado y Protection On.

**Secuencia de instalación:** EP-TASK-003 entrega checkout íntegro; MCP-OCP-07 entrega paquete con manifest/SHA; comparar SHA antes de extraer; extraer dentro de la ruta obligatoria; leer de vuelta y comprobar ejecutable/dependencias; configurar root de datos externo protegido; importar fuentes v386 y verificar pins/43 MDP; comprobar health de readiness (proceso, protocolo, fuentes, hashes y operador por separado); solicitar consentimiento y presencia local para `provision-operator`/ `REGISTER <SID>`; conectar cliente MCP STDIO/RDC; ejecutar la prueba funcional instalada y cierre/reinicio.

**Gate de seguridad PC 7 / LOC-OTHER:** no realizar instalación persistente hasta identidad de dispositivo/sesión/perfil verificada, BitLocker Protection On + FullyEncrypted 100 %, root de datos protegido, dead-man implementado/probado y rollback/read-back disponibles. La lectura previa `ProtectionStatus=Off` mantiene este gate abierto. Esta tarea no desbloquea dichos requisitos por sí misma.

**Criterio de cierre:** producto instalado en la ruta local indicada; SHA/manifest coinciden; fuentes importadas vigentes; readiness real; operador provisionado solo con consentimiento; stdio/RDC funciona; sin listener ni secretos; evidencia y read-back en EP-TASK-005, índice EP y OEP. El build o un smoke temporal no equivalen a instalación/aceptación.
