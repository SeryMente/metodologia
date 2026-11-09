# EP-TASK-005 · Instalación y aceptación de MCP-OCP local por stdio

**Estado:** `pendiente` · **Frente:** Entorno Persistente · **OCP padre:** `frentes/ep/OEP.md`
**Origen:** planificación interfrente por instrucción directa del operador · 2026-11-09.
**Registro:** tarea provisional; no crea control, titularidad, sesión, generación ni folio independiente.

## Propósito

Recibir el artefacto MCP-OCP renovado y efectuar su instalación, bootstrap y aceptación en un perfil Windows real y confiable, exclusivamente después de que el destino, el almacenamiento y el canal local estén verificados. La instalación conserva MCP stdio; no requiere servicio Windows, listener HTTP, túnel ni endpoint público.

## Alcance

1. Destino ya designado por el operador: perfil Windows `PC 7`, asociado al equipo RDC correspondiente, ubicación `LOC-OTHER`. Al iniciar la operación, comprobar en vivo que el usuario Windows, SID efectivo, equipo RDC, rutas y permisos coinciden con esa designación. La designación no sustituye el preflight ni autoriza a reutilizar datos de sesiones temporales anteriores.
2. Confirmar en el destino PC 7 que workspace, runtime, base de datos y respaldos están dentro de un volumen protegido. El estado XTS-AES256/Protection On/FullyEncrypted 100 % y RecoveryPassword custodiado observado en otro perfil/host no se hereda: repetir la lectura de vuelta en el dispositivo RDC asociado a PC 7. EP-TASK-003 debe completar la migración y ambos read-backs SHA-256 antes de mover allí el runtime.
3. Resolver el root de datos del servidor. El código recuperable de MCP-OCP usa por defecto `%LOCALAPPDATA%\SeryMente\OCP MCP`; debe quedar dentro del perímetro cifrado o debe probarse cifrado completo del volumen que aloja ese perfil. MCP-OCP habilitará una configuración explícita y validada del root de datos/respaldos para apuntar a W: sin heredar rutas de otra sesión.
4. Recibir solo un paquete nuevo, construido y verificado contra DUG v385 y el núcleo MCP-OCP vigente. Verificar SHA-256, manifiesto, RID y resultados de pruebas antes de extraer.
5. Si se necesita clonar/actualizar el repositorio privado desde ese perfil, comprobar autenticación local. Si falta, el propietario realiza `gh auth login --web` de forma interactiva en ese Windows; el token permanece en el almacén local. La autenticación GitHub del conector de ChatGPT no se transfiere al equipo.
6. Ejecutar `import-sources` contra un checkout con los commits/blobs vigentes; verificar resultado y 43 IDs/MDP. No importar fuentes con pins antiguos.
7. Ejecutar `OcpMcp.exe provision-operator` de forma interactiva. El operador confirma en esa consola escribiendo exactamente `REGISTER <SID>` con el SID que muestre el proceso. No capturar ni transmitir el SID o claves por chat.
8. Configurar el cliente para iniciar el proceso MCP stdio desde la ruta protegida. Verificar `initialize`, `tools/list`, `tools/call`, respuesta completa, shutdown y reinicio limpio a través del mismo recorrido RDC que utilizará el operador.
9. El destino está clasificado como `LOC-OTHER`: no instalar ni dejar runtime persistente hasta que EP-TASK-003 tenga implementado y probado el dead-man trigger específico, con cierre/volatilización y recuperación verificados.
10. Aceptar solo con read-back de paquete, fuentes importadas, `operator_provisioned=true`, root de datos protegido, transporte probado y recibo E2E enlazado a GOV-TASK-003.

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
- Sin listener, endpoint público, regla de firewall ni secretos en logs/salida/repositorio.
- Evidencia y read-back actualizados en esta ficha, el índice EP y OEP.

**Estado actual:** planificada, no iniciada. Destino designado: PC 7 / equipo RDC asociado / LOC-OTHER. Preflight, migración, dead-man, instalación y pruebas continúan pendientes. La creación de la tarea no modificó ningún equipo.


## Designación del destino · 2026-11-09

El operador designó **perfil Windows PC 7**, asociado a su dispositivo RDC, con ubicación **LOC-OTHER**. Esta decisión sustituye la pregunta pendiente sobre destino y clasificación. No se ha adquirido todavía el hostname/ID técnico del dispositivo ni se ha observado la sesión PC 7 en vivo.

**Bloqueo material actualizado:** LOC-OTHER obliga a completar EP-TASK-003 y verificar el dead-man específico antes de runtime persistente. Las evidencias previas de cifrado, W:, custodia y workspace no se trasladan por inferencia al nuevo perfil. La instalación, bootstrap, `provision-operator`, `REGISTER <SID>` y aceptación siguen pendientes; no se ha operado el equipo mediante esta actualización.
