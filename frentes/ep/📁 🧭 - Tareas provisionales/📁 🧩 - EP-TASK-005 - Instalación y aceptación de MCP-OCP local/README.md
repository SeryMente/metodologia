# EP-TASK-005 · Instalación y aceptación de MCP-OCP local por stdio

**Estado:** `pendiente` · **Frente:** Entorno Persistente · **OCP padre:** `frentes/ep/OEP.md`
**Origen:** planificación interfrente por instrucción directa del operador · 2026-11-09.
**Registro:** tarea provisional; no crea control, titularidad, sesión, generación ni folio independiente.

## Propósito

Recibir el artefacto MCP-OCP renovado y efectuar su instalación, bootstrap y aceptación en un perfil Windows real y confiable, exclusivamente después de que el destino, el almacenamiento y el canal local estén verificados. La instalación conserva MCP stdio; no requiere servicio Windows, listener HTTP, túnel ni endpoint público.

## Alcance

1. Destino vigente designado por el operador: terminal **Fila 4**, correspondiente a la única sesión RDC disponible. La identidad técnica efímera no se conserva. Antes de una operación local, revalidar que la conexión corresponde al alias Fila 4, el perfil efectivo, privilegios, rutas y permisos; no persistir hostname, Device ID, sesión ni cuenta/SID. La ubicación física se verifica por separado; no inferir CECEQ ni LOC-OTHER. PC 7 queda supersedido y no es fallback.
2. Confirmar en Fila 4 que workspace, runtime, DB y respaldos están en un volumen de trabajo protegido. La última observación histórica de Fila 4 indicó FullyEncrypted/100 %, ProtectionStatus=Off y XtsAes128; no acredita protección efectiva. Repetir en vivo y obtener XTS-AES256, Protection On, FullyEncrypted/100 %, protector recuperable custodiado por EP Vault y read-back SHA-256. No heredar W:, VHDX, RecoveryPassword ni DPAPI de PC-14/PC 7.
3. Resolver el root de datos del servidor desde el perfil interactivo Fila 4: `%USERPROFILE%\\Desktop\\SeryMente\\Datos\\Metodologia\\MCP-OCP\\`, fuera del checkout y dentro del volumen protegido. Confirmar la ruta en preflight; no asumir W: ni heredar rutas de otra sesión.
4. Recibir solo un paquete nuevo, construido y verificado contra DUG Samantha v388/NX-388m y el núcleo MCP-OCP vigente; rechazar paquetes/manifiestos fijados a v386 o anteriores. Verificar SHA-256, manifiesto, RID y resultados de pruebas antes de extraer.
5. Si se necesita clonar/actualizar el repositorio privado desde ese perfil, comprobar autenticación local. Si falta, el propietario realiza `gh auth login --web` de forma interactiva en ese Windows; el token permanece en el almacén local. La autenticación GitHub del conector de ChatGPT no se transfiere al equipo.
6. Ejecutar `import-sources` contra un checkout con los commits/blobs vigentes; verificar resultado y 43 IDs/MDP. No importar fuentes con pins antiguos.
7. Ejecutar `OcpMcp.exe provision-operator` de forma interactiva. El operador confirma en esa consola escribiendo exactamente `REGISTER <SID>` con el SID que muestre el proceso. No capturar ni transmitir el SID o claves por chat.
8. Configurar el cliente para iniciar el proceso MCP stdio desde la ruta protegida. Verificar `initialize`, `tools/list`, `tools/call`, respuesta completa, shutdown y reinicio limpio a través del mismo recorrido RDC que utilizará el operador.
9. La ubicación física de Fila 4 está PENDIENTE_DE_VERIFICACIÓN. Si el preflight confirma CECEQ, conservar el workspace cifrado al cierre. Si confirma una ubicación distinta de CECEQ, no dejar runtime persistente hasta que EP-TASK-003 implemente y pruebe el dead-man específico, con bloqueo, desmontaje, eliminación limitada al contenedor EP y recuperación verificados.
10. Aceptar solo con read-back de paquete, fuentes importadas, `operator_provisioned=true`, root de datos protegido, transporte probado y recibo E2E enlazado a GOV-TASK-003.


## Integración del panel visual en el ciclo de sesión EP · release MCP-OCP 1.0.0

Por instrucción directa del operador, la aceptación EP incluye la apertura automática del panel local MCP-OCP cuando la sesión persistente de este perfil esté realmente vigente.

- **Responsabilidad MCP-OCP:** entregar `OcpMcp.Panel.exe`, contrato `PANEL-OBSERVABILIDAD.md`, schema de estado/eventos, hashes y pruebas.
- **Responsabilidad EP:** escribir atómica y leer de vuelta `monitor/session.json` con `sessionState=ACTIVE`, `sessionStartedAtUtc`, `protectionState` y `protectionCheckedAtUtc`; abrir el panel como proceso hijo del controlador de sesión solo después de validar la sesión/manifest y completar los gates de seguridad aplicables, incluido el dead-man cuando la ubicación física confirmada sea distinta de CECEQ. El archivo no contiene SID ni secretos.
- La ventana permanece abierta como aplicación mientras EP continúe ACTIVE. X/Alt+F4 la minimiza a la barra de tareas para evitar cierres accidentales; el operador puede restaurarla. Al finalizar la sesión EP, el controlador la cierra limpiamente y verifica que no quede proceso huérfano.
- El panel puede abrir antes que el servidor; debe mostrar “Sesión activa · esperando servidor MCP”. Si el servidor se cae pero EP permanece ACTIVE, la ventana sigue abierta y muestra el estado detenido/desconectado.
- La apertura no se configura como tarea programada, servicio Windows ni arranque genérico de inicio de sesión. No iniciar panel si el perfil/sesión/volumen/gates EP no están verificados.
- El panel solo lee `monitor/session.json` (escrito por EP), `monitor/state.json` y `monitor/events.jsonl` (escritos por MCP-OCP) del root protegido. EP conserva ACL y protección del almacenamiento; no se copian secretos ni datos de fuente al panel. El estado de protección se muestra con la hora de la verificación EP; no se sondea BitLocker en segundo plano.
- Esta integración no modifica EP-TASK-003: el dead-man conserva su contrato específico y no se convierte en heartbeat/monitor general.

**Prueba de aceptación EP:** EP escribe/coteja session.json ACTIVE → panel abre visible; server ausente → “esperando servidor”; X minimiza/restaura; fin EP → cierre limpio; server iniciado por cliente STDIO → estados separados de proceso/protocolo/readiness; server terminado → desconectado; fin EP → panel se cierra sin huérfanos. Verificar hashes del binario y del manifest instalado.

## Dependencias y límites

- **MCP-OCP:** MCP-OCP-07 (paquete/runbook), MCP-OCP-12 (bootstrap), MCP-OCP-08 (handoff) y pins actuales.
- **Gobernanza:** GOV-TASK-003 (aceptación E2E), GOV-TASK-007 (IPZ/read-back/FOL1 separado), GOV-TASK-008 (contrato Sink) y GOV-TASK-013 (medición RDC).
- **EP:** EP-TASK-003 (workspace protegido en Fila 4 y dead-man según ubicación verificada).
- EP-TASK-004 (reconstrucción visual de la bóveda) no bloquea el build Sink ni el bootstrap DPAPI del servidor. Solo se incorpora si una operación concreta del handoff requiere esa GUI.
- EP-TASK-002 / Backblaze, NCL, Jules, PPR cross-host y Khora quedan fuera de este handoff.
- Esta tarea no autoriza por sí sola operaciones remotas ni cambios de BitLocker/ACL/Registro. La instrucción del operador autoriza el trabajo descrito, pero no sustituye permisos técnicos ni el consentimiento local interactivo.

## Bloqueos conocidos al planificar

- Los 195 archivos y 11 directorios del workspace seguían en staging; no había copia a W:, manifiesto de destino ni segundo read-back. No borrar el origen hasta el cotejo íntegro.
- La última evidencia EP reportó `remote_calls_left_pct = 0`. No eludir el límite por otro canal; se requiere capacidad RDC para la operación remota.
- El código recuperable usa LocalAppData por defecto. La configuración del root de datos cifrado debe resolverse antes de instalar.
- Destino vigente Fila 4; identidad técnica y ubicación física pendientes de preflight vivo. La designación anterior PC 7/LOC-OTHER quedó supersedida.
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

**Estado actual:** Fila 4 designada por el operador; preflight vivo, ubicación física, checkout/root protegidos, dead-man si corresponde, piloto, instalación y aceptación siguen pendientes.


## Designación inicial del destino · 2026-11-09 · HISTÓRICA, SUPERSEDIDA POR FILA 4

El operador designó **perfil Windows PC 7**, asociado a su dispositivo RDC, con ubicación **LOC-OTHER**. Esta decisión sustituye la pregunta pendiente sobre destino y clasificación. No se ha adquirido todavía el hostname/ID técnico del dispositivo ni se ha observado la sesión PC 7 en vivo.

**Bloqueo material actualizado:** LOC-OTHER obliga a completar EP-TASK-003 y verificar el dead-man específico antes de runtime persistente. Las evidencias previas de cifrado, W:, custodia y workspace no se trasladan por inferencia al nuevo perfil. La instalación, bootstrap, `provision-operator`, `REGISTER <SID>` y aceptación siguen pendientes; no se ha operado el equipo mediante esta actualización.


## Plan inicial de instalación del release 1.0.0 · 2026-11-09 · PC 7 SUPERSEDIDO

El entregable del sprint debe quedar instalado localmente dentro del checkout Metodología de Fila 4, después de superar los gates EP descritos en la rectificación vigente al final.

- **Checkout único:** `SeryMente/Repositorios/Metodologia/metodologia/`.
- **Carpeta local obligatoria del programa:** `frentes/mcp-metodologia/instalacion-local/`.
- **Contenido:** ejecutable y runtime/dependencias necesarios, launcher, configuración de ejemplo sin secretos, manifest de archivos y SHA-256.
- **Exclusión Git:** la carpeta de ejecutables instalados/binarios generados queda ignorada por Git; se conserva código fuente y pruebas en el flujo versionado.
- **Root de datos:** SQLite, claves DPAPI CurrentUser, fuentes sensibles importadas, logs operativos y backups quedan fuera del checkout, en una raíz independiente dentro del volumen efectivamente protegido y verificado por EP. No usar LocalAppData por defecto sin verificar cifrado y Protection On.

**Secuencia de instalación:** EP-TASK-003 entrega checkout íntegro; MCP-OCP-07 entrega paquete con manifest/SHA; comparar SHA antes de extraer; extraer dentro de la ruta obligatoria; leer de vuelta y comprobar ejecutable/dependencias; configurar root de datos externo protegido; importar fuentes v388 y verificar commit/blob/SHA, pins y 43 MDP; comprobar health de readiness (proceso, protocolo, fuentes, hashes y operador por separado); solicitar consentimiento y presencia local para `provision-operator`/ `REGISTER <SID>`; conectar cliente MCP STDIO/RDC; ejecutar la prueba funcional instalada y cierre/reinicio.

**Gate histórico del destino PC 7:** supersedido por Fila 4 y por la compuerta dinámica de ubicación física, protección del volumen y dead-man aplicable descrita en la rectificación vigente al final.

**Criterio de cierre:** producto instalado en la ruta local indicada; SHA/manifest coinciden; fuentes importadas vigentes; readiness real; operador provisionado solo con consentimiento; stdio/RDC funciona; sin listener ni secretos; evidencia y read-back en EP-TASK-005, índice EP y OEP. El build o un smoke temporal no equivalen a instalación/aceptación.

---

## Rectificación del destino y fast-path SINK/IPZ · 2026-11-10

Esta entrada supersede, para el sprint MCP-OCP, las designaciones anteriores de PC 7/LOC-OTHER registradas arriba. El destino seleccionado por el operador es **Fila 4**, el dispositivo correspondiente a la única sesión RDC disponible. PC 7 no queda como destino alternativo ni fallback.

### Destino confirmado por instrucción; identidad técnica por revalidar

- Etiqueta del equipo: Fila 4.
- Última referencia: alias funcional Fila 4; los datos efímeros de RDC y de la cuenta/sesión no se conservan. Es antecedente del preflight de EP-TASK-003, no lectura viva nueva.
- Revalidar en vivo hostname/Device ID, conexión, sesión, usuario/SID, `%USERPROFILE%`, permisos y privilegios antes de materializar o instalar.
- Perfil físico de ubicación: PENDIENTE_DE_VERIFICACIÓN. No inferir CECEQ o LOC-OTHER por la etiqueta Fila 4. El dead-man se exige solo si la ubicación efectiva es distinta de CECEQ; en CECEQ rige la conservación cifrada prevista.
- Checkout: `%USERPROFILE%\\Desktop\\SeryMente\\Repositorios\\Metodologia\\metodologia\\`.
- Programa piloto: `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\piloto-sink\\`.
- Release final 1.0.0: `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\`.
- Datos/DB/DPAPI/fuentes/logs/backups: `%USERPROFILE%\\Desktop\\SeryMente\\Datos\\Metodologia\\MCP-OCP\\`, fuera del checkout, dentro del volumen efectivamente protegido.

### Gates previos

La última observación disponible de Fila 4 registró C: `FullyEncrypted/100 %`, `ProtectionStatus=Off`, `XtsAes128`; no acredita protección activa y debe repetirse en vivo. Git y GitHub CLI se observaron instalados (2.45.2/2.52.0), pero la autenticación local en el perfil operativo de Fila 4 no estaba verificada. No heredar credenciales, VHDX, W:, recuperación, DPAPI ni workspace de PC-14 u otro host.

Antes de importar DUG o fuentes privadas, crear DB, ejecutar `provision-operator` o dejar un runtime persistente, EP-TASK-003 debe entregar checkout completo/sincronizado y volumen de trabajo XTS-AES256/Protection On/FullyEncrypted 100 %, protector recuperable en EP Vault, read-back SHA-256 y dead-man probado cuando la ubicación lo requiera. Confirmar permiso local y presencia del operador para `REGISTER <SID>`; no automatizarlo.

### Secuencia en dos hitos para reducir la espera de IPZ

**Hito A · piloto utilizable SINK:P004 (antes del panel y de 1.0.0):**

1. MCP-OCP construye el primer corte vertical mínimo con `GOW:ARR`, `DUG` y `SINK:P004`, con texto íntegro, pin/version/firma/commit/blob y SHA-256.
2. Suite mínima de contrato/errores y smoke de `initialize`, `tools/list`, `tools/call`, EOF/cierre.
3. Una vez que los gates de workspace/root de Fila 4 estén PASS, extraer el piloto en `instalacion-local/piloto-sink/`, cotejar paquete/manifest/SHA y configurar el root de datos protegido.
4. GOV-TASK-007 prepara el IPZ compacto que indique `GOW:ARR` → `DUG` → MDP → `SINK:Pxxx`; el primer test de recuperación será `SINK:P004`. La instalación del texto nativo IPZ y su read-back se documentan separadamente; no se afirma cambio del campo nativo por esta tarea.
5. Probar el camino que realmente usará el modelo: IPZ → invocación RDC autorizada → MCP-OCP STDIO → respuesta visible con pin/hash. Un envío JSON-RPC desde consola, sin retorno al contexto IPZ, solo cuenta como smoke de transporte.
6. Solo tras ese E2E P004, declarar **PILOTO_SINK_IPZ=VERIFICADO**; antes, estados separados (compilado, instalado, smoke, IPZ E2E) permanecen individualmente pendientes.

**Hito B · release MCP-OCP 1.0.0:**

Generalizar a los 43 principios, lotes ordenados, controles negativos, manifiesto final, panel WPF, pruebas combinadas, ZIP reproducible, extracción/read-back, bootstrap, instalación final en `instalacion-local/` y aceptación completa. El panel MCP-OCP-13 no bloquea el Hito A; sí es parte del producto final 1.0.0.

FOL1 conserva su compuerta independiente y no bloquea el piloto P004. No se activa MCP-NORMATIVO ni se modifica DUG/ART-025/ART-027/Khora.

**Estado de esta rectificación:** destino documental Fila 4 actualizado; preflight del host, checkout protegido, piloto, instalación, IPZ nativo/read-back y aceptación no ejecutados.


## Prioridad P0 · piloto SINK:P004 · rebaseline DUG v388 · 2026-11-10

**Prioridad:** P0 para el tramo EP local del primer piloto; el estado técnico permanece `pendiente` hasta ejecutar gates y obtener read-back. Esta tarea no debe esperar al panel ni al release 1.0.0 para el piloto P004.

### Secuencia inmediata

1. Esperar a que EP-TASK-003 declare `PREFLIGHT_FILA4=PASS` con evidencia de identidad/sesión/perfil, ubicación física, checkout completo/sincronizado, volumen XTS-AES256/Protection On/FullyEncrypted 100 %, protector recuperable/read-back SHA-256 y root de datos protegido. El dead-man es compuerta solo si la ubicación comprobada es distinta de CECEQ.
2. Recibir del frente MCP-OCP el paquete piloto P004 y verificar SHA-256, manifiesto, fuente/commit de código, SDK/RID y pin del DUG v388/NX-388m. DUG fuente: commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. Rechazar pin v386.
3. Extraer únicamente el piloto en `frentes/mcp-metodologia/instalacion-local/piloto-sink/` dentro del checkout validado; confirmar rutas, archivos y hash/read-back. No instalar el producto final 1.0.0 en esta fase.
4. Configurar el root `%USERPROFILE%\\Desktop\\SeryMente\\Datos\\Metodologia\\MCP-OCP\\` fuera del checkout y sobre el volumen protegido; verificar permisos y persistencia. Solo entonces importar las fuentes canónicas fijadas a v388 y comprobar procedencia/43 IDs/MDP.
5. Ejecutar el smoke funcional instalado y el transporte real STDIO/RDC; separar proceso iniciado, protocolo conectado, fuentes verificadas y readiness. El recorrido E2E de IPZ solo se acepta cuando la invocación desde el contexto IPZ devuelve al modelo el resultado P004 con pin/hash.
6. La provisión `provision-operator`/`REGISTER <SID>` es un acto separado, interactivo, con presencia y consentimiento del operador. No transmitir SID ni claves por chat.

### Dependencias exactas y límites

- **Bloqueadores de esta tarea:** EP-TASK-003 preflight/checkout/root protegido; paquete piloto P004 de MCP-OCP-05; pruebas de contrato mínimas MCP-OCP-03; smoke STDIO/RDC MCP-OCP-04. La instalación del piloto no se inicia si cualquiera de esos gates está ausente.
- **En paralelo:** MCP-OCP puede avanzar con rama/código no sensible y fixtures; esta tarea no exige detener ese trabajo hasta que el paquete esté disponible.
- **No son bloqueadores del piloto:** panel MCP-OCP-13, generalización P001–P043, lotes, release final 1.0.0, EP-TASK-004 GUI de bóveda, EP-TASK-002/Backblaze, Jules y PPR cross-host. El panel sí es obligatorio para el release completo 1.0.0.
- **Gobernanza:** GOV-TASK-007 prepara el candidato IPZ después de congelar respuesta P004; GOV-TASK-003 acepta la E2E real. La escritura/read-back de IPZ nativa no se presume ni se ejecuta por esta tarea. FOL1 no bloquea P004 y conserva su gate separado.
- **MCP-NORMATIVO:** permanece `DESACTIVADO`; Sink recupera texto íntegro, no realiza selección normativa automática.

### Estado de evidencia

El único cambio ejecutado en este asiento es documental: pin v388, orden, prioridad y dependencias explicitados. No se hizo preflight Fila 4, extracción, importación, bootstrap, `REGISTER`, instalación, telemetría runtime ni E2E. EP-TASK-005 permanece `pendiente`.
---

## Rectificación de compuertas locales y ruta de almacenamiento · 2026-11-10

EP-TASK-005 permanece `pendiente`. La instalación del piloto está bloqueada por el estado real de EP-TASK-003 y por la entrega de un paquete P004 verificable; la pausa operativa sobre almacenamiento prevalece sobre cualquier plan anterior de extraer en una unidad visible.

- **Destino de programa:** se conserva la ruta ya acordada dentro del checkout Fila 4: `frentes/mcp-metodologia/instalacion-local/piloto-sink/`. El producto final 1.0.0 servidor + panel permanece en `frentes/mcp-metodologia/instalacion-local/`.
- **Destino de datos:** `%USERPROFILE%\Desktop\SeryMente\Datos\Metodologia\MCP-OCP\`, fuera del checkout y dentro del almacenamiento que EP verifique como protegido.
- **Estado local:** EP-TASK-003=PARTIAL_FAIL. El VHDX de preparación está vacío, GPT/NTFS y `W:` fue su último punto de acceso observado; BitLocker no está activado. No debe usarse `W:` como ubicación final ni instalar allí.
- **Ruta del workspace:** la intención es conservar `%USERPROFILE%\Desktop\SeryMente\` como ruta de trabajo. El montaje del volumen protegido en esa misma ruta es solo una propuesta técnica no aceptada; falta resolverla antes de copiar, cifrar o cambiar el punto de montaje.
- **Dependencias del piloto:** EP-TASK-003 PASS + paquete P004 de MCP-OCP-05 con manifest/SHA y pin DUG v388 + pruebas contractuales mínimas MCP-OCP-03 + smoke STDIO/RDC MCP-OCP-04. No ejecutar extracción, importación, DB, `REGISTER <SID>` ni runtime persistente antes de esos PASS.
- **No bloquean el piloto:** panel MCP-OCP-13, generalización P001–P043, release 1.0.0, EP-TASK-004 GUI de Vault y EP-TASK-002/Backblaze, salvo dependencia material demostrada.

La pausa de almacenamiento detiene únicamente operaciones locales de host; MCP-OCP puede seguir con código remoto no sensible y fixtures sintéticos. No se realizó instalación, extracción, bootstrap, importación, provisión ni E2E en este ciclo documental.


---

## Relevo de ejecución EP · piloto SINK-P004 · 2026-11-10

**Responsable de ejecución:** frente EP. El operador ha liberado a EP para retomar sus tareas; la sesión centralizadora solo ordena el sprint y verifica dependencias. No se modifica el control EP generación 3.

### Entradas obligatorias antes de instalar

1. EP-TASK-003 `PASS`, incluyendo ruta de workspace preservada, volumen XTS-AES256/Protection On/100 %, protector recuperable/read-back, checkout completo/sincronizado, root de datos protegido y dead-man PASS únicamente si la ubicación física confirmada es distinta de CECEQ.
2. Artefacto P004 de MCP-OCP-05, manifest y SHA-256 cotejados; pin DUG v388/NX-388m; SDK/RID y commit del código declarados.
3. MCP-OCP-03 pruebas contractuales mínimas PASS y MCP-OCP-04 smoke STDIO/RDC PASS. El E2E desde IPZ aún es aceptación conjunta posterior.

### Secuencia de ejecución

- Recibir paquete sin reconstruirlo ni cambiarlo silenciosamente; verificar manifest, hashes, fuente y versión.
- Extraer el piloto solo en `frentes/mcp-metodologia/instalacion-local/piloto-sink/` dentro del checkout completo y protegido.
- Configurar datos SQLite/DPAPI/fuentes/logs/backups en `%USERPROFILE%\Desktop\SeryMente\Datos\Metodologia\MCP-OCP\`, fuera del checkout y dentro del volumen protegido.
- Importar exclusivamente DUG v388 con pins exactos y verificar `GOW:ARR`, catálogo y `SINK:P004`.
- Ejecutar readiness, initialize/tools/list/tools/call, cierre y reinicio limpios en STDIO/RDC; separar proceso iniciado de protocolo, fuente, integridad y readiness.
- `provision-operator` / `REGISTER <SID>` es un paso separado, interactivo y con consentimiento/presencia local; no se automatiza ni se transmite SID/secretos por chat.
- Emitir recibo de instalación con hash, rutas, versiones, resultado y rollback. No declarar aceptación E2E IPZ: esa salida corresponde a GOV-TASK-003 junto con MCP-OCP-04.

### No bloqueadores

Panel MCP-OCP-13, generalización P001–P043, release final 1.0.0, FOL1 y EP-TASK-004 no bloquean la instalación del piloto P004 salvo dependencia técnica demostrada. El panel sí es obligatorio para el paquete 1.0.0.

`EP_TASK_005=WAIT_EP_TASK_003_PASS_AND_MCP_P004_PACKAGE` · `EP_EXECUTION_OWNER=EP` · `CENTRAL_COORDINATION=GOV-TASK-015` · `EP_ACKNOWLEDGEMENT=PENDING`.


## Reporte individual obligatorio por tarea
Al resolver esta tarea, el responsable debe agregar el informe individual en este mismo núcleo siguiendo [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md), completar todos sus campos y actualizar el índice padre solo después del read-back. No marcar como completada sin criterios PASS, evidencia ejecutada, integridad verificada y aceptación exigible. Si termina parcial/bloqueada, dejar igualmente el informe con bloqueantes, preocupaciones, riesgos y condición objetiva de desbloqueo. Informar al operador con enlace al informe. Esta instrucción no altera titularidad, generación, permisos ni controles.


## Plan de instalación y aceptación por contratos · 2026-11-11

**Estado:** sigue pendiente y bloqueada por sus dependencias registradas. Este plan ordena la instalación del piloto P004 sin anticipar gates ni convertir el paquete en autorización para operar Fila 4.

### Secuencia

1. **Preflight del destino.** Comprobar conexión RDC activa y que corresponde a Fila 4, perfil Windows efectivo, privilegios, ubicación física y rutas absolutas. Si RDC no está activo, no ejecutar operaciones locales. Resolver EP-TASK-003 PASS: volumen XTS-AES256/100 %/Protection On, recovery protector custodiado/read-back, checkout íntegro y root de datos protegido; dead-man PASS solo si la ubicación verificada lo exige.
2. **Congelar entradas del paquete.** Registrar origen, commit, rama, versión, RID, manifiesto, tamaño y SHA-256. Cotejar paquete y pins DUG v388/NX-388m antes de extraer. Rechazar fuentes/pins obsoletos; no reconstruir ni cambiar silenciosamente el paquete recibido.
3. **Verificar contrato del servidor.** Ejecutar pruebas MCP-OCP-03 y smoke MCP-OCP-04 en entorno de prueba; exigir initialize, tools/list, tools/call, respuesta completa, shutdown y reinicio limpio vía STDIO/RDC. Separar proceso iniciado, protocolo disponible, importación de fuentes, readiness y función real.
4. **Instalar en el destino piloto.** Solo tras PASS previos, extraer en frentes/mcp-metodologia/instalacion-local/piloto-sink/. Resolver el root de datos en %USERPROFILE%\Desktop\SeryMente\Datos\Metodologia\MCP-OCP\, fuera del checkout y dentro del volumen protegido. No usar W: ni LocalAppData por defecto sin preflight explícito.
5. **Importar fuentes y provisionar.** Ejecutar import-sources contra checkout con commits/blobs vigentes y verificar GOW:ARR, DUG v388, catálogo y 43 MDP. Ejecutar provision-operator de forma interactiva; REGISTER <SID> solo se escribe localmente por el operador. No capturar, transmitir ni persistir el SID o claves en el chat.
6. **Validar el panel y el ciclo de vida.** Comprobar session.json ACTIVE antes de abrir el panel; probar espera del servidor, conectado/desconectado, minimización/restauración, cierre al terminar EP y ausencia de procesos huérfanos. El panel no lee secretos ni realiza sondeos no autorizados.
7. **Emitir recibo y aceptar.** Registrar rutas, versiones, SHA, fuentes importadas, resultado, evidencia, fallos, rollback y aceptación. El piloto P004 no equivale a aceptación E2E IPZ ni al release final 1.0.0.

### Review Focus

Paquete/manifiesto/pins exactos; destino y almacenamiento protegidos; root de datos separado del checkout; autenticación GitHub local no transferida desde el conector; consentimiento local para REGISTER; sin listener HTTP, túnel, firewall, endpoint público ni secretos en logs. Un gate fallido impide la etapa dependiente, no justifica un bypass.

### Rollback

Conservar el paquete original y su SHA; aislar instalación en piloto; antes de cambios de datos, snapshot/read-back. Ante fallo, detener el proceso, retirar solo el directorio piloto creado por este ciclo y devolver cliente/configuración a la versión anterior. No borrar datos ni fuentes compartidas para resolver una instalación fallida.

---

## Revalidación de gates del piloto SINK-P004 · 2026-11-11

**Estado operativo:** pendiente · BLOQUEADA_EP003_STORAGE_AND_P004_PACKAGE_MCP_CONTRACTS.

### Entradas y bloqueos observados

- PR #27 SINK-P004 continúa OPEN/DRAFT, NOT MERGED y mergeable=false. No se declaró paquete validado ni se realizó checkout de la PR en Fila4.
- La ruta local histórica de Metodología no contiene .git; no puede utilizarse para import-sources ni como checkout de instalación.
- El gate de almacenamiento no pasa: C: XTS-AES128/100 %/Protection Off/sin protectores; W: descifrado/0 %/sin protectores. El root de datos del servidor no quedó acreditado dentro de un volumen protegido.
- No se instaló, extrajo, importó, ejecutó provision-operator, registró operador, configuró cliente STDIO ni abrió panel. MCP-OCP-03/04 no se ejecutaron desde EP en este ciclo.

### Secuencia de desbloqueo

Esperar EP-TASK-003 PASS con ruta y volumen protegidos, checkout Git válido, root de datos protegido, paquete P004/manifiesto/SHA correctos y MCP-OCP-03/04 PASS. Después efectuar instalación aislada, importación de fuentes, provisionamiento interactivo por el operador y smoke STDIO/RDC. Mantener ausencia de listener público y secretos en logs. La PR en estado draft no es prueba de paquete ni autorización de instalación.

 
## Revalidación de PR #27 y gate de instalación · 2026-11-11 · 14:54 America/Mexico_City

Consulta read-only de GitHub: PR #27, “Draft: SINK-P004 · piloto STDIO sobre main vigente”.

- Estado: `OPEN`; `draft=true`; `merged=false`; `mergeable=true` en la consulta actual.
- Última actualización reportada por GitHub: `2026-11-10T23:19:23Z`.
- Archivos cambiados reportados: 36.
- La condición `mergeable=true` solo describe la posibilidad técnica de integrar la rama en GitHub; no equivale a aprobación, merge ni a aceptación del paquete o de la instalación.
- EP-TASK-003 sigue bloqueada: C: XTS-AES128/100 %/Protection Off/sin protectores; W: FullyDecrypted/0 %/Protection Off/sin protectores; ubicación UNCLASSIFIED.
- El contrato MCP-OCP-14 conserva estado PROPUESTO/NO RATIFICADO según la evidencia documentada; aceptación MCP-OCP-03/04 desde EP y el paquete P004 recibido/verificado siguen siendo gates independientes.

**No ejecutado:** merge, checkout de la rama en Fila 4, extracción, instalación, importación de fuentes, DB, provision-operator, `REGISTER <SID>`, configuración STDIO, apertura de panel o E2E IPZ.

**Siguiente gate:** EP-TASK-003 PASS + paquete P004 con manifiesto/SHA cotejados + MCP-OCP-03/04 PASS y revisión contractual aplicable. EP-TASK-005 permanece `pendiente`.


---

## Revalidación del candidato SINK:P004 · PR #28 · 2026-11-11 · 15:48 America/Mexico_City

### Estado actual observado

- PR #28: OPEN / DRAFT / NOT MERGED; HEAD `86e58cff0e58a2452361ff8abe031917dc9a5b11`; base `9ec698fbe27fd087c2cc9939b3afd604984e6154`; 29 archivos; compare 52 ahead / 0 behind; GitHub devuelve `mergeable=false`. Causa de mergeability: NO VERIFICADA. No hay reviews ni hilos en las respuestas consultadas.
- PR #27 queda como antecedente OPEN/DRAFT no integrado; #28 es la candidata documental más nueva.
- Recibo local ligado al source commit `f8973a1958fb1e6d259786c2828a19dae05aeee6`: restore/build PASS; 0 warnings/0 errors; 18/18 pruebas P004 y 23/23 monitor/readiness PASS; smoke STDIO/EOF PASS; extracción/read-back del ZIP y smoke del ejecutable extraído PASS.
- Paquete candidato: `MCP-OCP-SINK-P004-f8973a19-candidate.zip`, 137.784 bytes, SHA-256 `705716c7aa581a98817869eb281b87500b591c4e811653c3a6825e1ceb59a3d2`; manifest SHA-256 `03ef3b75d21a153d6b659056c4e401ca65fd6e7f2355cc57d48ed6e71746f750`; recibo SHA-256 `b068287641fa908d56bc2196dad2a4e840a0120eacf6538c74914e1bc1fdcffd`. Estado CANDIDATE_NOT_ACCEPTED.
- GitHub-hosted CI: NOT_VERIFIED. Los workflows consultados en el HEAD terminaron FAILURE con `steps=null` y `logs_url=null`; no se demuestra que iniciaran build/test. Causa del fallo NO VERIFICADA.

### Bloqueo documental del paquete

- SOURCE-PIN, recibo y reconciliación §10 identifican main `9ec698fbe27fd087c2cc9939b3afd604984e6154` y merge `720fc22ecad3ecdcfe3087778472e51aaa939068`.
- RUNBOOK.md identifica otra sincronización (`446e69251335a51fe8d4c01495c3738b11d5808c` / `8d22bff7fae4a23ac224b984576205841abeda9c`).
- RUNBOOK es parte del paquete manifestado. Corregirlo sin regenerar ZIP, manifest, SHA sums y recibo rompería la integridad. **No se edita el RUNBOOK dentro del paquete actual.** Reemitir el paquete tras resolver la procedencia exacta y repetir read-back/smoke.

### Gates EP y decisión

EP-TASK-003 sigue FAIL: C cifrado XTS-AES128/100 %, Protection Off y cero protectores; W completamente descifrado. Por tanto, root protegido/checkout destino no están habilitados. Runtime destino y .NET 10.x persistente NO VERIFICADOS. No hubo handoff, extracción, instalación, DB, import-sources, REGISTER, configuración STDIO ni E2E IPZ; esta última permanece NOT_RUN/NOT_ACCEPTED.

**Decisión:** candidato técnicamente validado en local, pero no aceptado ni instalado; PR #28 no lista para merge en el estado observado. Mantener bloqueo hasta regenerar paquete documentalmente consistente y superar EP-TASK-003. MCP-NORMATIVO DESACTIVADO.


---

## Revalidación viva de destino y candidato P004 · 2026-11-11 · 16:43 America/Mexico_City

**Estado:** `pendiente · EP003_STORAGE_GATE_FAIL · PACKAGE_PIN_STALE · PACKAGE_DOC_MISMATCH · DOTNET10_MISSING · INSTALL_NOT_PERFORMED · IPZ_E2E_NOT_RUN`.

### Host destino

- Identidad operativa verificada: `CENTRAL\fila4`, perfil `C:\Users\fila4`, sesión no administradora.
- Único SDK/runtimes observados en el perfil: .NET SDK `8.0.425`, runtime `Microsoft.NETCore.App 8.0.31`; .NET 10.0.x x64 no está presente. El candidato framework-dependent exige `Microsoft.NETCore.App 10.0.x x64`.
- El checkout local de Metodología bajo `Desktop\SeryMente\Repositorios\Metodologia\metodologia` no tiene `.git`; no se usó como source-root. W: no es un destino válido: está descifrado y solo contiene System Volume Information.
- No se descargó ni extrajo el candidato, no se creó DB/configuración, no se importaron fuentes, no se hizo provision-operator/REGISTER, no se instaló el servidor ni se configuró STDIO.

### Revisión del PR #28 y pin

- PR #28 continúa OPEN / DRAFT / NOT MERGED; rama `feat/mcp-ocp-p004-reconciled-20261111-7ab0c555`; HEAD `86e58cff0e58a2452361ff8abe031917dc9a5b11`; merge-base/base incorporada `9ec698fbe27fd087c2cc9939b3afd604984e6154`.
- Compare contra main actual `39ee30a211cd40bca9f3588470bbed36bc19f018`: `52 ahead / 12 behind`, estado `diverged`. No se actualizó la rama ni se fusionó.
- El candidato sigue siendo `MCP-OCP-SINK-P004-f8973a19-candidate.zip`, 137,784 bytes, SHA-256 `705716c7aa581a98817869eb281b87500b591c4e811653c3a6825e1ceb59a3d2`; estado `CANDIDATE_NOT_ACCEPTED`. Los resultados de restore/build, 18/18 P004, 23/23 monitor/readiness, smoke STDIO/EOF, extracción/read-back y smoke del ejecutable constan en el recibo histórico asociado al source commit `f8973a1958fb1e6d259786c2828a19dae05aeee6`; no se reejecutaron aquí. GitHub-hosted CI continúa `NOT_VERIFIED`.
- El paquete y `SOURCE-PIN.json` fijan DUG v388/NX-388m, commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`, blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. El DUG actual de main es v389/NX-389m, commit `39ee30a211cd40bca9f3588470bbed36bc19f018`, blob `bcd99e72113f444a045d7f1c91b4ad36865b8ea8`. El texto normativo P004 coincide en el texto leído, pero la versión/fuente completa y el pin del paquete son anteriores; no se declara compatible el paquete sin actualizar fixtures/pin y volver a validar.
- Persisten discrepancias dentro de los documentos del candidato: `RUNBOOK.md` registra main `446e69251335a51fe8d4c01495c3738b11d5808c` / merge `8d22bff7fae4a23ac224b984576205841abeda9c`; SOURCE-PIN/manifest/recibo registran main `9ec698fbe27fd087c2cc9939b3afd604984e6154` / merge `720fc22ecad3ecdcfe3087778472e51aaa939068`. RUNBOOK está incluido en el ZIP/manifest; no se edita en sitio ni se corrige solo su copia textual.
- El candidato también queda detrás del main actual por 12 commits. Antes de emitir otra candidata se debe reconciliar la rama con main actual, comprobar solapamientos, ejecutar restore/build/tests/smoke con SDK 10, actualizar pin v389, regenerar RUNBOOK/manifest/ZIP/SHA256SUMS/recibo y leer de vuelta el paquete exacto.

### Decisión

EP-TASK-005 permanece BLOQUEADA. No se instala un artefacto con pin v388 y documentación interna divergente sobre una base que ha quedado 12 commits detrás; no se instala sobre un checkout sin .git ni sobre W: descifrado. El runtime .NET 10 requerido tampoco está presente. La aceptación IPZ E2E exige invocación desde el contexto IPZ real y respuesta visible; no se ejecutó ni se simula.

**Conclusión:** revalidación de destino y procedencia completada; instalación y aceptación no ejecutadas. Mantener el piloto aislado como candidato no aceptado.


## Reconciliación de PR #28 contra main vigente · 2026-11-11

**Corte:** `SeryMente/Metodologia/main` HEAD `b3c468ce7522dee34631d065011801d6a7efeb1f`; PR #28 conserva HEAD `86e58cff0e58a2452361ff8abe031917dc9a5b11`, base antigua `9ec698fbe27fd087c2cc9939b3afd604984e6154`, estado OPEN/DRAFT/NOT MERGED y `mergeable=false`.

**Comparación actual:** `main...feat/mcp-ocp-p004-reconciled-20261111-7ab0c555` devuelve `diverged`, 52 commits ahead y 29 behind, con merge-base `9ec698fbe27fd087c2cc9939b3afd604984e6154`. La rama no está actualizada contra main actual. Los 29 archivos de PR #28 siguen siendo nuevos bajo `frentes/mcp-metodologia/`; la comparación no se utilizó para rebase/merge ni para escribir código.

**Integridad de candidato:** se conservan las observaciones previas: pin DUG v388 frente a v389 actual; discrepancia de procedencia RUNBOOK vs SOURCE-PIN/manifest/recibo; el ZIP actual incluye RUNBOOK y no debe corregirse in situ; requiere regeneración completa del paquete, manifest, SHA256SUMS y recibo. Los tests 18/18 y 23/23 son históricos; CI alojada no verificada. .NET 10 no está instalado en perfil fila4. No instalar ni ejecutar el candidato.

**Límite de autoridad:** EP recibe/verifica el handoff e instala tras sus gates; el código, fixtures, contratos y paquete son competencia del frente MCP-OCP según OEP §93. EP no rebasa ni modifica PR #28, no reconstruye P004 en nombre de MCP-OCP ni declara sus pruebas PASS.

**Dependencias:** EP-TASK-003 PASS y artefacto MCP-OCP-05 consistente + MCP-OCP-03/04 PASS siguen siendo precondiciones de instalación. EP-TASK-005 permanece `pendiente/BLOCKED`; no extracción, instalación, DB, provisionamiento, STDIO ni IPZ E2E.
