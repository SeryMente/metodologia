# EP-TASK-005 · Instalación y aceptación de MCP-OCP local por stdio

**Estado:** `pendiente` · **Frente:** Entorno Persistente · **OCP padre:** `frentes/ep/OEP.md`
**Origen:** planificación interfrente por instrucción directa del operador · 2026-11-09.
**Registro:** tarea provisional; no crea control, titularidad, sesión, generación ni folio independiente.

## Propósito

Recibir el artefacto MCP-OCP renovado y efectuar su instalación, bootstrap y aceptación en un perfil Windows real y confiable, exclusivamente después de que el destino, el almacenamiento y el canal local estén verificados. La instalación conserva MCP stdio; no requiere servicio Windows, listener HTTP, túnel ni endpoint público.

## Alcance

1. Destino vigente designado por el operador: terminal **Fila 4**, correspondiente a la única sesión RDC disponible. Última identidad técnica conocida (no lectura viva): Device ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`, perfil `CENTRAL\\fila4`, SessionId 4. Verificar hostname, Device ID, sesión, usuario/SID, USERPROFILE, rutas y permisos en vivo. La ubicación física se verifica por separado; no inferir CECEQ ni LOC-OTHER. PC 7 queda supersedido y no es fallback.
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
- Última identidad documentada: RDC Device ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`, sesión interactiva `CENTRAL\\fila4`, SessionId 4. Es la última observación de EP-TASK-003, no preflight en vivo de este ciclo.
- Revalidar en vivo hostname/Device ID, conexión, sesión, usuario/SID, `%USERPROFILE%`, permisos y privilegios antes de materializar o instalar.
- Perfil físico de ubicación: PENDIENTE_DE_VERIFICACIÓN. No inferir CECEQ o LOC-OTHER por la etiqueta Fila 4. El dead-man se exige solo si la ubicación efectiva es distinta de CECEQ; en CECEQ rige la conservación cifrada prevista.
- Checkout: `%USERPROFILE%\\Desktop\\SeryMente\\Repositorios\\Metodologia\\metodologia\\`.
- Programa piloto: `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\piloto-sink\\`.
- Release final 1.0.0: `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\`.
- Datos/DB/DPAPI/fuentes/logs/backups: `%USERPROFILE%\\Desktop\\SeryMente\\Datos\\Metodologia\\MCP-OCP\\`, fuera del checkout, dentro del volumen efectivamente protegido.

### Gates previos

La última observación disponible de Fila 4 registró C: `FullyEncrypted/100 %`, `ProtectionStatus=Off`, `XtsAes128`; no acredita protección activa y debe repetirse en vivo. Git y GitHub CLI se observaron instalados (2.45.2/2.52.0), pero la autenticación del perfil `CENTRAL\\fila4` no estaba verificada. No heredar credenciales, VHDX, W:, recuperación, DPAPI ni workspace de PC-14 u otro host.

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