# 📝 Registro de tareas provisionales del frente Entorno Persistente

**Estado:** materialización operativa provisional; no modifica ni sustituye el OEP, no crea un ámbito funcional ni canoniza un sistema general de gestión de tareas.  
**Contenedor:** `frentes/ep/📁 🧭 - Tareas provisionales/`  
**OCP padre y fuente de contexto:** `frentes/ep/OEP.md`  
**Evento de creación:** instrucción directa del operador en esta conversación · 2026-10-31.  
**Fuente normativa consultada:** DUG Samantha v388 · NX-388m · Metacanon 1.29 · GOW 2.18, en `main`; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.

## Naturaleza y límites

Este contenedor agrupa objetos provisionales de tarea del frente EP. Cada tarea tiene identificador local estable, directorio y núcleo propio. Las tareas no son frentes independientes, no crean un OCP funcional nuevo ni adquieren titularidad, autorización, control, sesión o folio global independientes.

La responsabilidad de seguimiento se vincula al frente EP y a su objeto OEP. La creación de una tarea no transfiere ni formaliza por sí sola la titularidad del frente y no amplía permisos de producto o de entorno.

El patrón de materialización sigue el registro de tareas provisionales de Gobernanza: índice de frente y un README por objeto de tarea. Se conserva la práctica de Custodia de mantener explícito el estado provisional y enlazar la lista desde el frente. Este registro no declara ratificado un estándar universal de tareas.

## Registro ejecutivo

| ID local | Estado | Tarea | Núcleo |
| EP-TASK-001 | `en_curso · NCL_PREFLIGHT_PARTIAL · OCP_PROFILE_36_CONFIRMED · PLAYWRIGHT_EXTENSION_PRESENT_0.4.0 · KEEPASSXC_BROWSER_PRESENT_1.10.4.1 · EXTENSION_ENABLEMENT_UNVERIFIED · NATIVE_MESSAGING_REGISTRY_UNVERIFIED · KEEPSHARE_ROTATION_PENDING` | Profile 36 OCP y Playwright 0.4.0 confirmados. KeePassXC-Browser 1.10.4.1 materializada y host manifests presentes; habilitación y registro Native Messaging no verificados. KeePassXC no estaba ejecutándose; rotación KeeShare y revisión P012/P013 pendientes. | [núcleo](./📁%20🧩%20-%20EP-TASK-001%20-%20Integración%20NCL/README.md) |
| EP-TASK-002 | `en_curso · P0 · B2_V6_HISTORICAL_OBJECT_VERIFIED · B2_V7_CURRENT_FORMAL_3352B_UPLOAD_READBACK_SHA_PASS · ISOLATED_DECRYPT_HMAC_AES_PASS_30_VARIABLES · CROSS_HOST_PENDING` | B2 v7 actualizado: 3.352 B, read-back SHA exacto y SSE-B2/AES256 PASS; copia aislada descargada y descifrada (HMAC/AES), 30 variables y cinco nombres B2 presentes. Cross-host sigue pendiente: no hay segundo host físico en línea. | [núcleo](./📁%20🧩%20-%20EP-TASK-002%20-%20Persistencia%20provisional%20Backblaze/README.md) |
| EP-TASK-003 | `en_curso · DISEÑO_ACEPTADO · BITLOCKER_GATE_FAIL · LOCATION_UNCLASSIFIED` | C: XTS-AES128/100 %/Protection Off/sin protectores; W: descifrado 0 %/sin protectores; checkout sin .git; no mutaciones. | [núcleo](./📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md) |
| EP-TASK-004 | `en_curso · LOCAL_SYNTHETIC_PASS · UNMANIFESTED_DRIFT · H10_PENDING` | Suite local PASS 118,79 s; Core/GUI/XAML difieren del manifest; CLI 3600 rechazado; pestaña y botones sin handlers/disabled; PR #21 abierta. | [núcleo](./📁%20🧩%20-%20EP-TASK-004%20-%20Reconstrucción%20de%20bóveda/README.md) |
| EP-TASK-005 | `pendiente · BLOCKED_EP003_STORAGE_AND_P004_PACKAGE_MCP_03_04` | No instalación/bootstrap/STDIO; C:/W: no protegidos; checkout local sin .git; PR #27 OPEN/DRAFT. | [núcleo](./📁%20🧩%20-%20EP-TASK-005%20-%20Instalación%20y%20aceptación%20de%20MCP-OCP%20local/README.md) |
| EP-TASK-006 | `en_curso · VERCEL_KHORA_WEB_52_CURRENT_MATCH · ENTRY_READBACK_9 · NOT_IMPORTED_1 · BLOCKED_42 · EP_VAULT_FORMAL_3352B_PRESENT · SESSION_CLOSED · VAULT_NAME_RECONCILIATION_PENDING` | Live Vercel metadata coincide 52/52 con snapshot; 9 entradas STOR​ED_READBACK_VERIFIED, 1 NOT_IMPORTED y 42 BLOCKED. Contador resumen local declara 10, discrepancia documentada. Vault formal presente (3.352 B), descifrado aislado PASS; sesión actual cerrada, adaptadores pendientes. | [núcleo](./📁%20🧩%20-%20EP-TASK-006%20-%20Centralización%20de%20variables%20de%20entorno/README.md) |
| EP-TASK-007 | `en_curso · INVENTORY_PARTIAL_READ_ONLY · BITLOCKER_GATE_FAIL · GUARDIAN_NOT_RUN` | Inventario Fila4 actualizado; C: Protection Off/sin protectores; W: descifrado; ubicación UNCLASSIFIED; lease/trigger/crypto-erasure no ejecutados. | [núcleo](./📁%20🧩%20-%20EP-TASK-007%20-%20Guardián%20de%20sesión%20efímera%20e%20inventario%20del%20host/README.md) |
## Estado de continuidad · 2026-10-31

EP-TASK-001 permanece `pendiente`. No debe iniciarse mientras siga activo el trabajo prioritario de alojamiento de OCP MCP en EP. Puede retomarse cuando ese trabajo haya concluido o cuando el operador dé una instrucción expresa para alterar el orden.

## Regla de mantenimiento

1. Cada tarea conserva identificador local, enunciado, origen recuperable, estado, alcance, restricciones y criterio de cierre.
2. Estados provisionales admitidos por este registro: `pendiente`, `en_curso`, `completada` y `cancelada`.
3. No añadir fechas límite, prioridades ni responsables individuales como propiedades universales por anticipación.
4. Ninguna tarea crea control de responsabilidad, sesión o folio propios; conserva la referencia al frente propietario.
5. La creación y existencia del objeto no autorizan la ejecución de sus fases técnicas.
6. El cierre requiere atender el enunciado y conservar evidencia recuperable y lectura de vuelta en la fuente que corresponda.

## Referencias

- [OEP — Objeto Canónico de Persistencia de Entorno](../OEP.md)
- [DUG v373 · NX-373m](../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html)
- [Criterios y núcleo EP-TASK-001](./📁%20🧩%20-%20EP-TASK-001%20-%20Integración%20NCL/README.md)


## Regla obligatoria de avance y documentación por ciclo

Esta regla se aplica a **EP-TASK-001 (NCL), EP-TASK-002 (Backblaze) y toda tarea provisional futura que se incorpore a este registro**. No altera por sí sola la prioridad, permisos, responsables ni criterios técnicos de cada tarea.

1. Al cierre de cada ciclo sustantivo que produzca hallazgos, decisiones, cambios, pruebas o bloqueos, actualizar el README de la tarea correspondiente antes de declarar cerrado el ciclo.
2. Mantener en ese mismo README una crónica acumulativa y cronológica. Cada ciclo agrega una entrada nueva; no sobrescribe ni elimina entradas anteriores. Las correcciones se incorporan como rectificaciones identificadas y con procedencia.
3. Cada entrada será suficientemente detallada para que una conversación nueva pueda reanudar la tarea sin depender de la memoria de esta conversación: fecha/fuente; objetivo del ciclo; estado previo; hallazgos y datos observados; decisiones y su autoridad; trabajo realizado; archivos/rutas y cambios; evidencia, SHA/read-back cuando aplique; pruebas y resultados; limitaciones; bloqueos; viabilidad; estimación del siguiente hito y del cierre solo si existe base; pendientes y siguiente acción.
4. Separar siempre dato observado, reporte del operador, reporte de otro agente, inferencia, propuesta, decisión aceptada y resultado verificado. Las pruebas no ejecutadas quedan explícitamente como pendientes.
5. Registrar ciclos sin cambios sustantivos como NO-OP únicamente cuando se haya comprobado que no hubo delta; explicar qué fuentes se revisaron.
6. No crear por defecto una bitácora, tablero u objeto de estado paralelo. El README de cada tarea es su núcleo y crónica acumulativa única; el índice de este registro solo resume identidad, estado y enlace.
7. Antes de escribir, releer HEAD y el archivo objetivo, conservar cambios concurrentes y comprobar lectura de vuelta. Un ciclo no queda documentalmente persistido hasta comparar el contenido guardado y su SHA de Git.
8. La regla es documental: no convierte una instrucción de seguimiento en autorización para instalar, ejecutar, transferir, borrar, configurar cuentas o modificar datos.

La regla se adopta para tareas provisionales de este contenedor por instrucción directa del operador recibida el 2026-10-31. **No se afirma que haya sido propagada a otros repositorios o tareas fuera de este registro.**


## Compuerta obligatoria de comunicación y documentación por ciclo

**Esta secuencia se ejecuta en todos los ciclos de EP. Un ciclo que omita cualquiera de las dos escrituras requeridas permanece incompleto.**

### Apertura obligatoria — antes de cualquier trabajo

- [ ] Completar el preflight aplicable de identidad, fuente, titularidad, generación, autorización y exclusividad de escritor.
- [ ] Leer el objeto bilateral de Gobernanza correspondiente a EP y localizar mensajes nuevos desde el último cursor realmente procesado.
- [ ] Escribir en ese mismo objeto la respuesta inicial: acuse, interpretación del encargo, viabilidad, bloqueos y siguiente acción inmediata.
- [ ] Registrar el cursor/revisión/commit/blob efectivamente leídos; si no hay mensaje nuevo, escribir `SIN_NOVEDAD` con esa evidencia.
- [ ] Releer el índice canónico de tareas provisionales y seleccionar las tareas afectadas.
- [ ] No iniciar tareas técnicas/documentales auxiliares antes de registrar la respuesta inicial.

### Procesamiento

- [ ] Ejecutar únicamente trabajo dentro de la autorización y la compuerta aplicable.
- [ ] Distinguir observado en fuente, reportado, inferido, propuesto, autorizado, intentado, ejecutado, verificado y aceptado.
- [ ] Mantener un escritor por recurso compartido y detener solo la escritura afectada ante una colisión.

### Cierre obligatorio — después de procesar el trabajo

- [ ] Actualizar el mismo objeto de comunicación de Gobernanza con novedades, cambios reales, tareas/hitos afectados, fuentes y revisiones, commits/blobs/hashes, evidencia observada frente a reportada, decisiones, bloqueos, siguiente acción y pronóstico.
- [ ] Actualizar el OEP o el núcleo de tarea que realmente haya cambiado; conservar la crónica append-only del registro de tareas.
- [ ] Hacer lectura de vuelta del objeto bilateral y de cada documento operativo modificado; comparar el contenido exacto y el SHA de Git.
- [ ] Marcar cada tramo según la secuencia `PUBLICADO → LEÍDO → RESPUESTA_INICIAL_REGISTRADA → PROCESADO → DOCUMENTADO_AL_CIERRE → VERIFICADO_READBACK`.
- [ ] Si falta respuesta inicial o documentación final, declarar `CICLO_INCOMPLETO`; no cerrar por silencio, por guardar un prompt o por una respuesta en el chat.

**Objeto de coordinación DTC canónico en `main`:** [COORDINACION-GOBERNANZA-EP-v0.1.md](../entregas/COORDINACION-GOBERNANZA-EP-v0.1.md).  
**OEP:** [OEP.md](../OEP.md) §90–§93.  
**Índice provisional:** `frentes/ep/📁 🧭 - Tareas provisionales/README.md`.  
**No crear:** un OCP alternativo, un tablero/bitácora paralelos, control de responsabilidad independiente, sesión/folio propios ni un segundo objeto de estado.


## Reorientación de tareas por instrucción rectora · 2026-11-07

- EP-TASK-002: persistencia de datos de usuario OCP en Backblaze B2; GitHub queda para código y objetos canónicos. La segunda unidad/equipo físico no es condición de cierre.
- EP-TASK-003: workspace `Ser y Mente`, repositorios actuales y carpetas `extension/` para extensiones Chrome; además, únicamente dead-man trigger fuera de CECEQ, ligado a la terminación del proceso que mantiene abierta la sesión EP.
- EP-TASK-001 permanece pendiente y sin cambio.

## Alcance austero vigente · 2026-11-07

BitLocker es obligatorio en toda ubicación y utiliza la misma contraseña maestra de la bóveda canónica de variables de entorno. CECEQ conserva el workspace cifrado al cierre. En ubicaciones distintas de CECEQ, la terminación del proceso de control de la sesión EP dispara el bloqueo BitLocker, desmontaje y eliminación exclusiva del contenedor/carpeta de trabajo EP.

Se revisó el diseño histórico de KHORA OEP §28–§30 y sus módulos asociados; se retiene solo el evento de terminación del proceso de control. Quedan fuera de esta versión Guardian como subsistema, vigilancia anti-exfiltración, heartbeat, polling, inactividad, monitoreo, VS Code/IDE y tareas programadas. La actualización es documental: el disparador aún no está implementado ni activado.


## Reconciliación de tareas por instrucción rectora del workspace SeryMente · 2026-11-09

**Fuente:** instrucción directa del operador del 2026-11-09, reconciliada con OEP §108 y los núcleos individuales. La raíz de trabajo se llama exactamente `SeryMente`, sin espacios. La fotografía de repositorios accesibles hoy es de 11, pero la materialización futura volverá a descubrir la organización GitHub dinámicamente. En frentes Chrome MV3, el paquete cargable local se denominará `Extensión`; la recomendación de mantener `Observabilidad` como carpeta hermana y local-first queda pendiente de ratificación expresa y se enlaza a EP-TASK-002/003. La bóveda es un producto/frente de trabajo de `SeryMente/metodologia`, no una extensión Chrome; EP-TASK-004 conserva su seguimiento provisional.

### Estado ejecutivo vigente

| ID | Estado | Evidencia/alcance al 2026-11-09 | Siguiente dependencia material |
|---|---|---|---|
| EP-TASK-001 | `pendiente` | NCL continúa sin activación ni nueva ejecución. No cambió por la instrucción del workspace. | Esperar la condición de activación vigente o instrucción expresa del operador. |
| EP-TASK-002 | `en_curso` | Persistencia B2 EP: pareja Master dedicada migrada a EP Vault y read-back verificado; autenticación B2 y respaldo remoto actual pendientes | [núcleo](./📁%20🧩%20-%20EP-TASK-002%20-%20Persistencia%20provisional%20Backblaze/README.md) |
| EP-TASK-003 | `en_curso` | Root `Desktop\SeryMente` creado en PC-14 por RDC; 11 scaffolds vacíos y `WORKSPACE-STATUS.md` verificado. Excepción provisional en claro autorizada solo para código/documentación no sensible. | Clones reales y clasificación de frentes; autorización de autenticación GitHub local; migración posterior a VHDX + BitLocker XTS-AES256, protección activa/100 %; dead-man LOC-OTHER. |
| EP-TASK-004 | `en_curso` | Bóveda EP: pareja Master EP promovida desde notas efímeras y verificada; H10 y aceptación integral pendientes | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-004%20-%20Reconstrucci%C3%B3n%20de%20b%C3%B3veda/README.md) |
| EP-TASK-006 | `en_curso` | Centralización: nombres Master B2 EP normalizados y leídos de vuelta; cobertura mult proveedor sigue incompleta | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-006%20-%20Centralizaci%C3%B3n%20de%20variables%20de%20entorno/README.md) |

**Regla de estado:** no promover tareas a `completada` por documentación, diseño aprobado, pruebas sintéticas parciales o archivos instalados. Los hitos internos sí mantienen sus estados parciales/completados dentro de cada núcleo. El índice resume identidad y estado; el detalle y la crónica permanecen en el README individual.

### Límites de PC-14 en este ciclo

El dispositivo RDC autenticado es `PC-14`, ID `4fc35a07-2192-4b88-81ec-96cb450d565e`; la consola activa es `PC-14\PC 13`, perfil `C:\Users\PC 13`, Desktop `C:\Users\PC 13\Desktop`. C: está sin BitLocker (0 %, Off). No se creó `SeryMente`, no se creó VHDX ni se clonó ningún repositorio. La discrepancia con la directriz operativa anterior de utilizar `fila4` bloquea cualquier escritura en ese host hasta que el propietario del perfil quede expresamente resuelto. El operador declaró la ubicación como cibercafé; clasificación provisional `LOC-OTHER`. No se activa volatilización porque el dead-man trigger todavía no existe.

**Ciclo documental:** DTC de apertura anexado y leído de vuelta; OEP §108, EP-TASK-002, EP-TASK-003 y EP-TASK-004 actualizados en `main` con lectura de vuelta posterior. EP-TASK-001 se conserva sin modificación. La implementación física del workspace y el cierre técnico de EP permanecen pendientes.

### Delta operativo · 2026-11-09 · PC-14

El operador autorizó una instancia provisional en claro por RDC para avanzar en frentes no sensibles. Root creado: `C:\Users\PC 13\Desktop\SeryMente`, identidad `PC-14\PC 13`; 11 scaffolds vacíos (no clones); `WORKSPACE-STATUS.md` SHA-256 `3B03FE0507903B7B42BA538B55D2954E9241A7C4A5F3746FB8D4C091117063EF`. C: continúa FullyDecrypted/0 %/Protection Off.

La exportación íntegra se archivó en [ChatGPT-EP (1)-20261109-1031.md](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/entregas/ChatGPT-EP%20(1)-20261109-1031.md): SHA-256 original `B08DEE8C0317EC2DDC28CD5D98925A975F1C571A1CC6B3C9852319CC945CF001`, commit `7260b1d398904f7dc13a76858d9f6f3c661831a7`, blob `0be706ff04bfe9158c0f33b2f984c3952a6d03e4`, 82,367 bytes / 1,645 líneas y read-back exacto. No se hizo `gh auth login`, no se leyeron/trasladaron tokens ni se almacenaron secretos.

EP-TASK-003 sigue `en_curso`; la excepción no sustituye la migración posterior a VHDX/BitLocker ni el dead-man LOC-OTHER. EP-TASK-001 `pendiente`; EP-TASK-002 y EP-TASK-004 `en_curso`.

## Delta de continuidad y ejecución · 2026-11-09

- Exportación ChatGPT-EP-20261109-1104.md preservada en frentes/ep/entregas/, 999 líneas/38.069 bytes, SHA-256 de origen B032A6033BABC0B1061C2823D5B3C64C3A041DC842978E73B6D26216977805D4, blob f14febd7b5f673d9b2f7b1226603eb1243758ea0, read-back exacto.
- EP-TASK-003: VHDX expandible de 100 GB creado y montado temporalmente como W:, sin cifrar y vacío; contraseña solicitada localmente; migración y recovery protector pendientes. Workspace actual contiene 195 archivos bajo signal-interpreter y se preserva.
- EP-TASK-004: diseño hiperrealista v2 congelado antes de la implementación; GUI 3D WPF, pruebas sintéticas completas PASS y PC-14 actualizado. PR #20 sigue draft/no fusionada; H10 y aceptación visual humana pendientes.
- EP-TASK-001 continúa pendiente; EP-TASK-002/003/004 permanecen en_curso.
## Transferencia de titularidad primaria · 2026-11-09

- Operación `TRANSFER_RESPONSIBILITY` registrada y verificada: generación 3.
- Titular activo: alias `chatgpt-C-EP-TRANSFER-RESPONSIBILITY-20261109-01-SES-20261109-E032FC60`, folio `SES-20261109-E032FC60`, UUIDv7 local `01a1c16c-f0fa-7273-a0f8-a1dde032fc60`.
- Titular previo generación 1: relevado; asiento e historial preservados en el control. La corresponsabilidad temporal de generación 2 se cerró al promover la sesión receptora.
- Control: blob `b76614cb71c7c9f0090e1c7205dc582ae2e79ec6`; OEP v0.3.46, §113. No se activa FOL1 ni se crea control de tarea separado.

## Reconciliación de tareas por OEP §114 · 2026-11-09 · 12:31 America/Mexico_City

**Fuentes vigentes:** OEP `v0.3.48` §§112–114, DUG `v384 · NX-384m`, control EP generación 3. Esta entrada corrige los resúmenes históricos anteriores sin borrar su cronología.

| Tarea | Estado provisional | Reconciliación sustentada | Siguiente acción |
|---|---|---|---|
| EP-TASK-001 | `pendiente` | Sin novedad ni ejecución nueva; se conserva intacta. | Mantener en espera hasta que se cumpla su condición de activación o el operador cambie expresamente el orden. |
| EP-TASK-002 | `en_curso` | Persistencia B2 EP: pareja Master dedicada migrada a EP Vault y read-back verificado; autenticación B2 y respaldo remoto actual pendientes | [núcleo](./📁%20🧩%20-%20EP-TASK-002%20-%20Persistencia%20provisional%20Backblaze/README.md) |
| EP-TASK-003 | `en_curso` | W: está protegido con XTS-AES256, `Protection On`, `FullyEncrypted`, 100 %. El nuevo RecoveryPassword está bajo `EP_WORKSPACE_BITLOCKER_RECOVERY_PASSWORD` en EP Vault con `VAULT_WRITE_READBACK_VERIFIED`; el protector anterior potencialmente expuesto fue retirado y el portapapeles se limpió/verificó. Los 195 archivos/11 directorios permanecen en `Desktop\SeryMente`; no existe copia/hash verificado en W: ni cambio del punto de montaje. RDC informó 0 % de cuota disponible. El dead-man `LOC-OTHER` sigue sin implementar/activar. | Cuando RDC permita operaciones, inventariar origen/destino, copiar, cotejar rutas/tamaños/SHA-256, cambiar el montaje solo tras PASS y eliminar staging únicamente tras segundo read-back íntegro. Después abordar el dead-man según OEP. |
| EP-TASK-004 | `en_curso` | Bóveda EP: pareja Master EP promovida desde notas efímeras y verificada; H10 y aceptación integral pendientes | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-004%20-%20Reconstrucci%C3%B3n%20de%20b%C3%B3veda/README.md) |



**Aclaración de continuidad:** las entradas históricas de 2026-11-09 en §§143/161 sobre un VHDX/volumen `W:` protegido y un RecoveryPassword en EP Vault son snapshots de una ejecución anterior. No acreditan ni se transfieren al VHDX de preparación creado después en Fila 4. Para Fila 4, el estado más reciente prevalente es el de OEP §123: VHDX 30 GiB, GPT/NTFS, vacío, sin BitLocker ni protector, último punto de acceso observado `W:`; workspace original preservado y ninguna copia. No reutilizar el protector, volumen, ruta ni DPAPI de aquellos snapshots históricos.

**Corrección importante:** la custodia del protector de recuperación ya no es un bloqueo. El bloqueo actual de EP-TASK-003 es operativo: RDC agotó la cuota de llamadas antes de ejecutar la migración. No se intentó eludir ese límite por un canal alternativo. La copia original sigue intacta.

**Exportación solicitada:** `ChatGPT-EP-20261109-1230.md` no estuvo disponible en archivos de conversación, Biblioteca ni `main`; por tanto, no se registra como leída ni persistida. Su pregunta final sigue pendiente de acceso al documento. No se infiere ni se sustituye su contenido por las exportaciones 1031/1104.



## Rectificación documental · adquisición posterior de ChatGPT-EP-20261109-1230 · 2026-11-09

La nota previa que indicaba que `ChatGPT-EP-20261109-1230.md` no estaba disponible reflejaba correctamente la búsqueda de las 12:31, pero fue supersedida cuando el operador aclaró que PC-14 es el equipo y `PC 13` el perfil/almacenamiento. El archivo se localizó en `C:\Users\PC 13\Downloads\ChatGPT-EP-20261109-1230.md`, se leyó y se preservó byte por byte en `frentes/ep/entregas/`: 40.832 bytes, 853 líneas, SHA-256 `045FD76745669E2AD08A4A0F517FCB042B5CD2C3B3320AB5AD2E83F0972EF674`, Git blob `1be5a3b2a19dec4dd819648302664606654a4761`, commit `163138cc5a6113279fbc42eccbec036df424f8e4`; read-back Base64 exacto.

La pregunta final del archivo queda respondida: BitLocker funciona; el bloqueo es la migración que aún no se ejecutó. Los 195 archivos/11 directorios siguen fuera de W:. El rótulo de actividad «Migrado el espacio de trabajo» dentro de la exportación contradice la respuesta explícita de cuota RDC 0 % y no prevalece sobre OEP §114, que confirma ausencia de copia, hash de destino y cambio de montaje.

**Estados sin cambio:** EP-TASK-001 `pendiente`; EP-TASK-002, EP-TASK-003 y EP-TASK-004 `en_curso`. En EP-TASK-003 la custodia de recuperación está resuelta; la migración/aceptación permanece pendiente.


## Sprint Sink local · reconciliación de tres frentes · 2026-11-09

EP-TASK-003 y EP-TASK-005 son el carril EP de este sprint. EP-TASK-003 conserva la migración del workspace a W: y el dead-man cuando la ubicación sea LOC-OTHER. EP-TASK-005 controla el handoff, la ruta de datos protegida, el bootstrap DPAPI CurrentUser y la aceptación MCP stdio/RDC. EP-TASK-004 (UI de bóveda) y EP-TASK-002 (Backblaze) no bloquean el build Sink; solo se incorporan si se demuestra una dependencia técnica concreta. La autenticación GitHub del conector de ChatGPT no equivale a autenticación local del perfil Windows.


## Plan original de instalación Sink · 2026-11-09 · PC 7 SUPERSEDIDO POR FILA 4

- **EP-TASK-003:** entrega el checkout completo y sincronizado de `SeryMente/metodologia` en `SeryMente/Repositorios/Metodologia/metodologia/`; verifica integridad, permisos, BitLocker realmente activo y dead-man según ubicación física verificada en Fila 4. La materialización previa fue parcial y no era checkout Git; no está lista aún.
- **EP-TASK-005:** instala el release de software MCP-OCP 1.0.0 en `frentes/mcp-metodologia/instalacion-local/` dentro de ese checkout, compara SHA, extrae, lee de vuelta, configura el root de datos protegido fuera del checkout, importa fuentes y ejecuta pruebas STDIO/RDC. Registro local exige consentimiento presencial.
- **Ubicación de datos:** DB, claves DPAPI, fuentes sensibles, logs operativos y backups fuera de checkout; binarios locales en `instalacion-local/` excluidos de Git.
- **Gate del plan original PC 7:** supersedido por la rectificación vigente Fila 4. En Fila 4, preflight y protección efectiva pendientes; dead-man solo se exige si la ubicación confirmada es distinta de CECEQ. Esto no detiene el desarrollo remoto no sensible.
- **Fuera de sprint:** EP-TASK-002/B2 y EP-TASK-004/UI de bóveda, salvo dependencia concreta demostrada.

Estado documental: carril EP y destino exacto completados en diseño; preflight, checkout íntegro, dead-man, instalación y aceptación siguen pendientes.

---

## Reorientación del sprint MCP-OCP · Fila 4 · 2026-11-10

El operador sustituyó PC 7 por **Fila 4**, correspondiente a la única sesión RDC disponible que indica. La identidad técnica efímera de RDC no se conserva; el alias funcional Fila 4 es el único identificador persistente. El preflight parcial vigente está registrado en OEP §§122–123. La ubicación física queda sin clasificar hasta observación, por lo que el dead-man se determina según CECEQ/ubicación distinta y no por el nombre del equipo.

- **EP-TASK-003:** preparar en Fila 4 el checkout completo bajo `%USERPROFILE%\\Desktop\\SeryMente\\Repositorios\\Metodologia\\metodologia\\`, workspace VHDX protegido y read-back SHA-256. La última observación Fila 4 (histórica) informó C: 100 % cifrado, XTS-AES128, Protection Off; no acredita protección efectiva. No reutilizar staging/volúmenes de PC-14.
- **EP-TASK-005:** el programa se instala bajo `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\`; datos/DB/fuentes/DPAPI/logs/backups quedan en `Datos/Metodologia/MCP-OCP/` sobre el volumen protegido. El primer piloto `SINK:P004` puede aceptarse antes del panel y del release final, tras superar gates de workspace/root y probar la ruta IPZ→RDC→STDIO. El panel permanece obligatorio para 1.0.0.
- **Orden de dependencias:** código no sensible y suite piloto se desarrollan en paralelo con EP; importación de fuentes privadas y ejecución del piloto real esperan al checkout/root protegido. Dead-man solo es bloqueante si la ubicación efectiva es distinta de CECEQ.

No se ejecutó preflight, materialización, login, instalación ni piloto por esta actualización documental.



---

## Corte documental y reconciliación B2 EP · 2026-11-10 · 10:12 America/Mexico_City

**DUG vigente consultado:** v387 · NX-387m; GOW 2.18; fuente `SeryMente/metodologia/main`.  
**Instrucción atendida:** actualizar los objetos provisionales afectados por la rectificación explícita de titularidad y por el resultado efectivo de la promoción de las dos notas Master de EP.

| Tarea | Estado | Cambio sustentado | Pendiente material |
|---|---|---|---|
| EP-TASK-002 | `en_curso` | Procedencia EP confirmada; pareja Master EP promovida y read-back verificado; alias EP obsoleto retirado; namespaces Cora/Khora no mezclados. | Autenticación B2 posterior a migración; bucket, upload, download y hash remoto. |
| EP-TASK-004 | `en_curso` | Bóveda actualizada; dos notas retiradas tras read-back; ciphertext 2.156 bytes y SHA-256 asentados. | H10, aceptación integral de bóveda y E2E; no equiparar migración de secretos con aceptación del producto. |
| EP-TASK-006 | `en_curso` | Pareja Master de EP centralizada en los nombres canónicos; configuración de destino preservada y alias antiguo retirado. | Centralización y adaptadores para el resto de proyectos/proveedores. |

**Control de titularidad:** las dos notas pertenecían, por confirmación expresa del operador, a la cuenta Backblaze dedicada de EP. Cora conserva cuenta/credenciales independientes; las variables `KHORA_B2_*` se preservaron y no se modificaron.

**Evidencia de dispositivo:** `ep-b2-master-key-migration.json` (`MIGRATION_AND_READBACK_VERIFIED`, 2026-11-10T16:01:06Z) y `ep-b2-final-verification.json` (read-back final 2026-11-10T16:12:43Z). Ambos reportan que los valores no se emitieron. Ciphertext: 2.156 bytes; SHA-256 `F41FE765BCD30787C880C9105E3F6B3C4F6D00D67BA7AEAF70E55F3E7A96514C`.

**Límite:** no se ejecutó autenticación B2 posterior a la migración ni upload/download remoto; la persistencia del snapshot actual no queda declarada. El readiness `bucketAuthorized=False` es anterior a la migración y no sustituye una comprobación nueva.

**Lectura/cierre documental:** los núcleos individuales y este índice deben leerse de vuelta después de persistir en `main`; el asiento DTC registra el cierre y los commits/blob SHA de la escritura. No se crea folio global ni tarea nueva. EP-TASK-001, EP-TASK-003 y EP-TASK-005 conservan su estado.


## Urgencia del sprint MCP-OCP · gate EP local · 2026-11-10

**P0 de EP:** EP-TASK-003 es la dependencia operativa para importar fuentes privadas, crear DB y ejecutar el piloto local en Fila 4. Debe completar preflight vivo de identidad/sesión/perfil, ubicación física, checkout íntegro, volumen XTS-AES256/Protection On/100 %, protector recuperable/read-back SHA-256 y root de datos protegido. El dead-man es condicional: solo si la ubicación efectiva resulta distinta de CECEQ. Fila 4 ya está designada; no volver a pedir selección.

**EP-TASK-005 · P0 piloto:** depende de EP-TASK-003 PASS y de MCP-OCP-05/03/04 (artefacto P004, contrato, pruebas y smoke STDIO/RDC). Verificar manifest/SHA y pin DUG v388 antes de extraer `instalacion-local/piloto-sink/`; importar fuentes actuales solo con checkout/root protegidos. `REGISTER <SID>` exige presencia y consentimiento local. La E2E IPZ se acepta solo con respuesta visible al modelo.

**Qué no debe detenerse:** EP no necesita terminar Backblaze ni la GUI de bóveda para este piloto. MCP-OCP puede avanzar en rama/código no sensible y tests con fixtures mientras EP completa el gate; no importar fuentes privadas ni ejecutar runtime persistente antes de EP PASS. El panel y el release 1.0.0 son una fase posterior; el panel sí es obligatorio para 1.0.0, no para P004.

**Pin de referencia:** DUG Samantha v388/NX-388m; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. No se declara preflight, migración, instalación, importación ni E2E ejecutados por este asiento.

## Preflight vivo Fila 4 · 2026-11-10

- DUG: Samantha v388 / NX-388m.
- OEP: v0.3.57, §122.
- PREFLIGHT_FILA4: PARTIAL_FAIL. Alias funcional Fila 4; sesión interactiva activa en la observación del preflight; cuenta, ruta concreta del perfil e identificador de sesión efímeros omitidos; ubicación física sin clasificar.
- C: 100 % cifrado de espacio usado, XTS-AES128, Protection Off, sin protectores: no cumple el gate.
- Workspace existente preservado: 2,468 archivos / 545 directorios / 127,996,970 bytes.
- Checkout de Metodología: materialización parcial, solo frentes/, sin .git. Git y gh disponibles; autenticación gh del perfil Fila 4 verificada por keyring.
- EP-TASK-003 sigue en_curso. EP-TASK-005 sigue pendiente.
- Evidencia: EP-FILA4-PREFLIGHT-PARCIAL-20261110.json; commit 84cc9ffc1a2aa27c622c7e5de147d7460f3b5ecd; blob 8ebf0c2b54efc6d3fe597adfe0f9358e65e6acbe.


## Continuidad de almacenamiento Fila 4 y piloto SINK:P004 · 2026-11-10

El último estado observado después del preflight §122 es: VHDX de 30 GiB creado, GPT/NTFS, vacío, último acceso W:, BitLocker no activado y sin protectores. El directorio Desktop/SeryMente original permanece preservado y no se ha copiado ni cambiado de ruta. El montaje del volumen cifrado sobre la ruta original se considera una propuesta no aceptada; se mantiene la pausa operativa de almacenamiento. La presencia física del operador frente a Fila 4 fue reportada; CECEQ no fue confirmado y la ubicación sigue sin clasificar. EP-TASK-003 permanece en_curso/PARTIAL_FAIL; EP-TASK-005 permanece pendiente.

El bloqueo EP no detiene MCP-OCP-02/03/04 en remoto con código no sensible y fixtures sintéticos. Sí impide checkout protegido, importación privada, DB real, runtime e instalación piloto. La coordinación vigente se conserva en GOV-TASK-015.


## Relevo de ejecución para Sprint SINK-P004 · 2026-11-10

El operador instruyó que EP retome sus tareas; esta sesión deja de actuar como ejecutora del frente y conserva únicamente la coordinación interfrente. OEP v0.3.59 §124 contiene el encargo. No se cambia el control EP generación 3 y la aceptación del relevo por EP queda pendiente.

- **EP-TASK-003:** EP debe readquirir el estado vivo del VHDX y workspace; presentar al operador el método recomendado para proteger la ruta `Desktop/SeryMente`; no mutar almacenamiento hasta aceptación expresa; después completar cifrado, custodio/read-back, copia/manifest SHA, checkout íntegro, root protegido y dead-man únicamente si la ubicación confirmada es distinta de CECEQ.
- **EP-TASK-005:** EP espera EP-TASK-003 PASS y el paquete SINK:P004 probado por MCP-OCP-05/03/04; instala el piloto y acepta la ejecución local. El panel y 1.0.0 vienen después, no bloquean P004.
- **Estado al abrir el relevo:** EP-TASK-003=`PARTIAL_FAIL`; EP-TASK-005=`PENDING`; `EP_ACKNOWLEDGEMENT=PENDING`; no hay operación host nueva.


---

## Bitácora B2 EP · 2026-11-10 · 14:20 America/Mexico_City

EP-TASK-002 conserva el estado en_curso. Se guardó la transcripción literal del último tramo y la salida literal del modelo, además de dos comprobaciones de preflight repetidas que observaron la sesión CLI cerrada (0/5 variables) y el recibo de transferencia ausente. Los workers/wrappers PowerShell pasan análisis sintáctico; no se ejecutó autenticación ni transferencia remota. Evidencia y detalle: [ChatGPT-EP-20261110-1417-B2-ULTIMO-TRAMO.md](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/entregas/ChatGPT-EP-20261110-1417-B2-ULTIMO-TRAMO.md). El dato anterior de 775 segundos se conserva como antecedente literal, no como lectura vigente.


## OCP MCP 1.0 · asignaciones por hitos · 2026-11-10

| Hito | Tarea EP | Prioridad | Salida exigida | Dependencias |
|---|---|---|---|---|
| H2 | EP-TASK-004 + EP-TASK-006 | P0 | Inventario organizacional completo de variables KHORA/OCP/Ser y Mente; bóveda cifrada; primera persistencia B2 y restore aislado. | EP Vault y EP-TASK-002 |
| H2/H3 | EP-TASK-002 | P0 | Journal y checkpoint mínimo; B2 como backend único inicial; workspace completo cifrado, manifest/SHA, download y restore. | Credenciales B2 vía Vault; recibos/read-back |
| H3/H5 | EP-TASK-007 | P0/P1 | Host inventory, ubicación/IP/GPS disponibles, guardián GUI-autostart, lease, disparadores, crypto-erasure y recibo. | EP-TASK-002, EP-TASK-003, EP-TASK-004/006 y contratos MCP-OCP-14/15 |
| H3/P004 | EP-TASK-005 | P0 local | Instalar/aceptar solo tras gates de EP-TASK-003 y paquete P004 probado. | EP-TASK-003 PASS + paquete MCP-OCP |

**Orden operativo:** EP prioriza bóveda y primer checkpoint cifrado; después workspace completo por instancia. SINK:P004 continúa en paralelo con fixtures/harness sin datos privados. El guardián y la inspección extendida se implementan después de congelar contratos y verificar la restauración inicial. El suministro de credenciales Vault→RDC se difiere al hito MCP-OCP-16 y no se ejecuta ahora.

**Control de ejecución:** este índice configura el encargo documental. EP debe acusar recibo, revalidar el estado vivo y ejecutar bajo su OEP/control generación 3. No se afirma operación de host, GPS, lease, B2, bóveda ni borrado.


---

## EP-TASK-002 · diagnóstico GUI/CLI y preparación P0-C · 2026-11-10

OEP §91 y EP-TASK-002 fueron releídos. La inspección viva de EP Vault mostró la ventana GUI abierta pero en estado SELLADA; la sesión DPAPI compartida no está presente bajo la misma identidad propietaria y raíz EP que usa la CLI. No se encontró un fallo de ruta: GUI y CLI comparten el mismo Core y archivo de sesión.

Se preparó un worker/wrapper PowerShell nuevo para P0-C que subirá únicamente el ciphertext de EP Vault a OCP-MCP/ep-ocp/vault/, con bucket privado, revisión lifecycle, SSE-B2/AES256, descarga y SHA-256. Los scripts pasan parser y sus SHA quedan registrados en EP-TASK-002. No se ejecutó autenticación, upload ni descarga; el recibo sigue ausente. El workspace ZIP no se carga porque el hito vigente exige cifrado antes de enviarlo a B2. Detalle en el núcleo EP-TASK-002 y en el anexo conversacional.


---

## Reconciliación ejecutiva EP · 2026-11-10 · 15:36 America/Mexico_City

- **EP-TASK-002 (P0):** Vault GUI/CLI SELLADA/no activa en las lecturas de 21:34Z; 0/5 variables disponibles. El worker P0-C solo ciphertext está preparado, sin recibo. No se autenticó ni se subió a B2.
- **EP-TASK-003 (P0):** preflight read-only nuevo. Origen 3.103 archivos, 659 directorios, 159.162.208 bytes, dos errores de enumeración. VHDX GPT 30 GiB adjunto en W:, sin BitLocker/protector. C: XTS-AES128/Protection Off. Checkout parcial sin .git; Datos/MCP-OCP ausente. Diseño recomendado de montaje en el path original, aún no aceptado.
- **EP-TASK-004:** self-tests sintéticos criptográficos y job-runner PASS; parser de Core/CLI/GUI y XML de XAML PASS. H7/H8 integral y H10 humano siguen pendientes.
- **EP-TASK-005:** pendiente; depende de EP-TASK-003 PASS y paquete P004/manifest/SHA/MCP-OCP-03/04.
- **EP-TASK-006:** nombres Master EP normalizados/read-back; fase P1 de cobertura sigue detrás de P0 B2.
- **EP-TASK-007:** inventario parcial read-only terminado; Guardian/lease no implementados.
- **EP-TASK-001:** pendiente sin cambio.

Evidencia read-only: [EP-FILA4-READONLY-PREFLIGHT-20261110-1530.json](../entregas/EP-FILA4-READONLY-PREFLIGHT-20261110-1530.json), blob \`88dd663df4345df343a51ad2800f0ad79953c60d\`. No se cambió workspace, VHDX, BitLocker, checkout, root de datos, bóveda formal ni credenciales. No se declara PASS de host ni persistencia remota.


## Informe individual obligatorio por tarea

Regla para EP-TASK-001–007 y tareas futuras: cada resultado se documenta dentro del README de su tarea con [la plantilla común](../../PLANTILLA-REPORTE-CIERRE-TAREA.md). El informe debe explicar cómo se resolvió, resultado frente al objetivo, cambios, evidencia y pruebas ejecutadas, read-back/SHA, bloqueantes, preocupaciones/riesgos, pendientes, rollback y aceptación. Los campos sin incidencias deben decir NINGUNO_VERIFICADO; lo no examinado, NO_VERIFICADO.

El núcleo individual es el registro de cierre. El índice solo refleja estado y enlace, y se actualiza después de verificar el informe. No se cierran varias tareas con una única explicación conjunta. No declarar completada una tarea parcial, bloqueada o con aceptación pendiente. Tras cada cierre, enviar al operador el enlace individual y un resumen de solución, evidencia y asuntos pendientes.


---

## Reconciliación ejecutiva EP · 2026-11-10 · 15:49 America/Mexico_City

- **EP-TASK-002:** P0 sigue bloqueada. Status propietario 15:48:48: cámara no activa, ciphertext 2.200 bytes, recibo ausente; worker/wrapper íntegros por SHA-256; no se autenticó ni contactó B2.
- **EP-TASK-003:** el operador aceptó expresamente el diseño VHDX/BitLocker que conserva Desktop\SeryMente. Gate global permanece PARTIAL_FAIL. Dos enumeraciones recursivas independientes repitieron 3.127 archivos, 660 directorios, 179.138.515 bytes, cero errores y cero reparse points; la diferencia frente al conteo anterior sigue sin causa reconciliada. C: continúa XTS-AES128/Protection Off/sin protectores; W: sigue FullyDecrypted/sin protectores; checkout sin .git y root Datos/MCP-OCP ausente. No hubo mutación física.
- **EP-TASK-007:** inventario de host y almacenamiento revalidado en modo read-only. Ubicación UNCLASSIFIED; GPS/IP no consultados; Guardian/lease/crypto-erasure no implementados.
- **EP-TASK-004:** self-tests sintéticos parciales continúan siendo la última evidencia; H7/H8 integrales y H10 pendiente.
- **EP-TASK-005:** sigue bloqueada por EP-TASK-003 PASS y paquete P004/manifest/SHA/MCP-OCP-03/04.
- **EP-TASK-006:** P1 sigue detrás del snapshot/restore P0 B2.
- **EP-TASK-001:** pendiente, sin delta.

**Informes parciales individuales:** EP-TASK-002, EP-TASK-003 y EP-TASK-007 fueron agregados y leídos de vuelta antes de actualizar este índice. No se promueve ninguna tarea a completada. Siguiente gate: desbloqueo local de EP Vault; comprobar sesión y cinco nombres; ejecutar P0-C y demostrar descarga/hash/restore.


---

## Reconciliación ejecutiva EP · 2026-11-10 · 15:59 America/Mexico_City

- **EP-TASK-004:** seleccionada como siguiente ejecución independiente mientras EP-TASK-002 permanece bloqueada por Vault sellada. La suite exacta v1.0.0 de la rama feat/ep-vault-pc7-hardened-20261109 pasó completa (exit 0; 165,41 s). Cinco artefactos locales cotejaron sus Git blobs con MANIFEST.json; sandbox aislado fuera de AppData/workspace eliminado con read-back. H7/H8 sintéticos para esta candidata: PASS. H10 humano y merge a main: pendientes.
- **EP-TASK-002:** P0 continúa bloqueada; Status posterior de Vault formal: sessionActive=false, ciphertext 2.200 B, recibo B2 ausente. No se llamó B2.
- **EP-TASK-003:** diseño VHDX aceptado, pero gate físico no cambia; inventario del workspace no se congela mientras Temporal/SI-Reconcile-20261110-G14 mantiene actividad de escritura.
- **EP-TASK-007:** sin cambio funcional; no Guardian ni crypto-erasure.
- **EP-TASK-005/006/001:** conservan dependencias/orden previamente registrados.

Informe individual EP-TASK-004 publicado y leído de vuelta antes de este índice: commit df54e3521b0fb18dfef63d6c98c391549223ce70, blob 0f9acb4f105e3aa7ff4152a5b392bf365de24e41. No se promueve la tarea a completada.


---

## Reconciliación ejecutiva EP · 2026-11-10 · 16:09 America/Mexico_City

- **EP-TASK-002:** desbloqueo local temporal confirmado a las 16:01:13; los cinco nombres EP B2 presentes sin revelar valores. Dos ejecuciones P0-C autenticaron y detectaron OCP-MCP privado, pero fallaron durante preflight antes de upload: v1 `UNEXPECTED_WORKER_FAILURE`; v2 `WORKER_EXCEPTION_PropertyNotFoundException`. Recibos separados verificados; ninguno contiene objeto remoto/fileId/download. Se preservaron. Worker/wrapper v3 parser PASS preparados con clasificación de línea; no ejecutados porque la sesión volvió a sellarse a las 16:09. Requiere nuevo desbloqueo local. No se subió workspace.
- **EP-TASK-004:** suite E2E sintética exacta de la candidata v1.0.0 PASS (exit 0, 165,41 s); H10 y merge a main continúan pendientes.
- **EP-TASK-003:** diseño VHDX aceptado por operador, gate físico sigue PARTIAL_FAIL; workspace cambia mientras hay actividad concurrente en Temporal; no congelar ni copiar todavía.
- **EP-TASK-007:** sin cambio funcional; Guardian/lease/crypto-erasure no implementados.
- **EP-TASK-005/006/001:** dependencias y orden sin cambio.

Informe individual de EP-TASK-002 actualizado y leído de vuelta: commit 3dd266d2645cf7884a021a96573692b9c4b39f65, blob de810f529a59f4fea9768393430a07a5c1f8e86e. No se promueve la tarea a completada.

---

## Reconciliación ejecutiva EP · 2026-11-10 · retest independiente EP-TASK-004

- **EP-TASK-004:** además del PASS de 165,41 s informado previamente, se ejecutó una segunda corrida independiente de `MOD-EPVAULT/v1.0.0` en Fila 4 desde una copia temporal exacta del release commit `db4138ca2879148f2f22f159c7609f5fa3466924`. Exit 0, 142,61 s; log SHA-256 `D1D244ADAEA157AA8F295487CCCE9225207738F8865F4909771B5AED523416A1`. Cinco blobs de código y dos recursos WAV cotejados; sandbox eliminado; no se tocó Vault formal, GUI, BitLocker, B2 ni workspace.
- **Manifiesto de producto:** rama `feat/ep-vault-pc7-hardened-20261109`, commit de actualización `e165c0b867e20c9ae3156f6bad72c6f13ba8a5c5`, blob de read-back `4de6dcc0a5989a2671c8009226405d7f189fe7fe`; estado `EXACT_V1_0_0_RETEST_PASS`, manteniendo H10 y merge pendientes.
- **Núcleo individual actualizado:** commit `00c20d925711410a91f446fb943757c824765361`, blob final `fa31b43ab882e9e24d8e61b494b176c0d700ba25`. La adenda explicita el límite de procedencia: el checkout local bajo Desktop\SeryMente conserva blobs anteriores y no fue sobrescrito ni etiquetado como release.
- **EP-TASK-002:** mantener el estado más reciente del ciclo §128: dos preflights B2 fallidos antes de upload; v3 preparada, no ejecutada porque la Vault volvió a SELLADA. Requiere desbloqueo local; no existe objeto remoto.
- **EP-TASK-003:** diseño aceptado, preflight PARTIAL_FAIL; no copiar/congelar mientras haya escritura concurrente en Temporal y no exista restore B2 verificado.
- **EP-TASK-005:** continúa bloqueada por EP-TASK-003 PASS y el paquete P004/MCP-OCP.
- **Conclusión:** EP-TASK-004 permanece `en_curso`; H7/H8 sintéticos PASS para la candidata, H10 humano e integración del release en main pendientes.

## Reconciliación ejecutiva EP · 2026-11-10 · 17:08 America/Mexico_City

- **EP-TASK-002:** R2 local PASS (3.289 entradas verificadas, ZIP 119.076.640 bytes). B2 remoto PASS para cuatro objetos: ZIP, ciphertext Vault, manifiesto y checksum; los cuatro fueron descargados y SHA-256 cotejado; SSE-B2/AES256 confirmado. Recibo `ep-backblaze-r2-final-receipt-v1.json`; exit 0, caché temporal limpiada. Cross-host restore aún NOT_RUN.
- **EP-TASK-003:** conserva diseño VHDX aceptado y gate físico `PARTIAL_FAIL`. B2 verificado desbloquea la dependencia de copia remota mínima, pero no habilita creación/montaje/migración física sin superar los gates de BitLocker/checkout/consistencia.
- **EP-TASK-004:** dos corridas sintéticas exactas PASS (165,41 s y 142,61 s); H10 humano e integración a main pendientes.
- **EP-TASK-005:** pendiente; no instalar piloto hasta EP-TASK-003 PASS + paquete P004/manifest/SHA y MCP-OCP-03/04 PASS.
- **EP-TASK-006:** pasa a siguiente etapa P1 de inventario/centralización mult proveedor; todavía incompleta.
- **EP-TASK-007:** inventario read-only parcial; Guardian/lease/crypto-erasure no implementados.
- **EP-TASK-001:** pendiente.

**Orden EP actualizado por instrucción del operador:** EP-TASK-002 remoto ya transferido; siguiente gate es read-back/restore aislado y después EP-TASK-003. No iniciar desarrollo adicional hasta actualizar las tareas y leer la retroalimentación de Gobernanza y MCP-OCP.


## Reconciliación ejecutiva EP · 2026-11-10 · 17:12

- **EP-TASK-002:** cuatro objetos B2 cargados y descargados con SHA-256 idéntico; SSE-B2/AES256 confirmado. Restore aislado del ZIP en C:\\R2R: 3.289/3.289, cero errores/inesperados. Descifrado aislado de Vault y cross-host NOT_RUN.
- **EP-TASK-003:** `PARTIAL_FAIL`; gates físicos VHDX/BitLocker/checkout/consistencia pendientes.
- **EP-TASK-004:** suite sintética exacta PASS dos veces; H10 humano y merge pendientes.
- **EP-TASK-005:** instalación pendiente de EP-TASK-003 PASS y paquete P004/MCP-OCP-03/04 PASS.
- **EP-TASK-006:** P1 inventario/centralización multi-proveedor pendiente.
- **EP-TASK-007:** inventario read-only parcial; Guardian/lease/crypto-erasure no implementados. **EP-TASK-001:** pendiente.

**Orden:** Backblaze fue antepuesto y ejecutado. Informes/índice y retroalimentación interfrentes están reconciliados; habilitado reanudar el desarrollo sintético P004 dentro del ciclo MCP-OCP local 13 ya abierto. Instalación/aceptación EP continúa detrás de sus gates. No declarar descifrado Vault ni restore cross-host.

---

## Método local de planificación técnica incorporado al registro EP · 2026-11-11

**Procedencia:** piloto experimental [EP-App v1.1.0 — plan de implementación (Writing Plans)](https://github.com/SeryMente/metodologia/blob/main/docs/superpowers/plans/2026-11-11-ep-app-persistent-environment.md), commit bea10756135a0f657bf5112374f457027cb02143, blob 95b068e27e325a9d0341a864855bbdcf5c8c84bc.

**Alcance:** adaptación local al contenedor provisional EP por instrucción directa del operador. No crea una metodología universal, otro OCP, una bitácora paralela ni autoridad independiente. OEP y DUG prevalecen; cada README de tarea sigue siendo el único núcleo de estado/crónica/aceptación de esa tarea. Este método solo organiza la ejecución futura.

### Contrato mínimo para planes de trabajo sustantivos

Cuando una tarea requiera varias etapas, cambios de código/host, seguridad, integración o aceptación de terceros, su plan debe contener:

1. **Objetivo y alcance:** resultado verificable, exclusiones, condiciones que no se modifican y qué no autoriza el plan.
2. **Línea base:** repositorio, rama, HEAD/commit, versión, archivos, Git blobs/manifest y entorno exacto. Reportes del operador, resultados de otro agente y código inspeccionado se etiquetan por separado.
3. **Trazabilidad:** requisito/decisión de origen → archivo, función, interfaz o recurso → prueba → resultado esperado → evidencia de cierre.
4. **Descomposición ejecutable:** pasos pequeños en orden, indicando Read/Create/Modify/Test, precondiciones, entradas, salidas, interfaces y dependencias. No dejar una tarea amplia como una sola instrucción ambigua.
5. **Test-first y Review Focus:** pruebas de caracterización, casos positivos/negativos, límites, datos inconsistentes, regresión y salida/exit code esperado. Los fixtures son sintéticos y aislados salvo autorización específica.
6. **Composición de capacidades y gates:** no confundir selector/toggle visual con permiso/capacidad real; cada acción tiene precondiciones propias, se revalidan al ejecutarla y falla cerrada ante evidencia ausente. No usar un gate común más restrictivo que lo necesario si bloquea un primer ciclo legítimo.
7. **Revisión de discrepancias:** señalar contradicciones con los núcleos, OEP o código; registrar alternativas y dejar la decisión pendiente cuando exceda el mandato. Nunca reconciliar en silencio.
8. **Aceptación diferenciada:** verificar requisitos técnicos por pruebas reproducibles y validar el producto en su contexto real; aceptación humana/UI/seguridad no se infiere de tests sintéticos.
9. **Entrega recuperable:** manifiesto, SHA, read-back exacto, logs saneados, commit aislado, rollback y reporte de límites/bloqueos. La creación del plan no autoriza ejecución, instalación, despliegue, merge ni aceptación.

### Distribución a las siete tareas

| Tarea | Enfoque específico incorporado |
|---|---|
| EP-TASK-001 | Línea base Chrome/KeePassXC/Native Messaging/Playwright; delegación por pestaña; preservación de sesiones; control humano y smoke Cora read-only. |
| EP-TASK-002 | Estados separados de snapshot/cifrado/upload/read-back/restore; idempotencia; restore same-host vs cross-host; bootstrap independiente; excepción de ZIP sin cifrado cliente. |
| EP-TASK-003 | Preflight Fila 4/ubicación; manifiesto estable; BitLocker verificable; copia/hash; corte de ruta con rollback; dead-man según CECEQ/LOC-OTHER. |
| EP-TASK-004 | Línea base de ramas/versiones, TTL conflictivo, clean-room, gates independientes por acción, fail-closed, pruebas y H10. |
| EP-TASK-005 | Proveniencia de paquete, destino protegido, importación/pins, STDIO, provisionamiento interactivo, panel, recibo y rollback. |
| EP-TASK-006 | Inventario por namespace, adaptadores con read-back, entrega just-in-time, idempotencia, rotación/revocación y cobertura cuantificada. |
| EP-TASK-007 | Estados de sesión, lease, triggers, precedencia checkpoint/borrado, aislamiento de crypto-erasure y pruebas de fallos. |

### Mantenimiento y economía

- No crear un plan separado para una modificación trivial o de riesgo bajo: aplicar P043 y evitar duplicar documentación.
- Para un cambio sustantivo, el plan se vincula desde el núcleo de la tarea, y su resultado vuelve a ese mismo núcleo como crónica acumulativa.
- Cada ciclo revalida los archivos/commits actuales antes de escribir; los cambios son append-only salvo rectificación explícita; el índice se actualiza después de leer de vuelta los núcleos modificados.
- Los estados, prioridades, dependencias, titulares, autorizaciones y criterios ya existentes no cambian por incorporar este método.
- Todo plan puede quedar DRAFT/NO_AUTORIZA_IMPLEMENTACIÓN hasta que se cumplan sus gates propios.

---

## Corte semi-live de ejecución integral · 2026-11-11

**Orden del operador:** resolver EP-TASK-001–007 y reportar a cada ciclo. EP-TASK-001 queda reactivada; ninguna tarea se marca completada por este corte.

| Tarea | Estado del ciclo | Siguiente gate real |
|---|---|---|
| EP-TASK-001 | Preflight parcial; Profile 36 confirmado como OCP, Playwright presente, KeePassXC portable localizado. | Validar KeePassXC-Browser y Native Messaging bajo revisión P012/P013; rotar KeeShare key localmente antes de continuar. |
| EP-TASK-002 | Cuatro objetos B2 con read-back y restore same-host PASS. | Resolver divergencia entre ciphertext local 2.048 B y objeto B2 2.200 B; luego decrypt aislado y cross-host. |
| EP-TASK-003 | Diseño aceptado; gate BitLocker FAIL. | Custodia Vault, ubicación física y volumen XTS-AES256/Protection On con protector recuperable. |
| EP-TASK-004 | Suite sintética local PASS; árbol no manifiestado y UI persistente inerte. | Reconciliar release, CLI/Core/XAML/tests, TTL y handlers; H10 y P012/P013 pendientes. |
| EP-TASK-005 | Bloqueada por almacenamiento y paquete contractual. | EP-TASK-003 PASS + paquete P004/SHA + MCP-OCP-03/04 PASS. |
| EP-TASK-006 | 52 Vercel; 10 read-back; 42 valores no recuperables; Vault formal no inicializada. | Recuperar custodia formal y completar inventario/adaptadores sin extraer secretos por inferencia. |
| EP-TASK-007 | Inventario parcial read-only; volúmenes no protegidos. | Proteger workspace por EP-TASK-003; luego diseñar/validar Guardian y lease bajo gates. |

**Seguridad:** se registró de forma saneada una exposición contextual de material de clave privada KeeShare durante una lectura de configuración local; no se copió a documentos ni Git. Rotación por el propietario pendiente. No se modificó Chrome, KeePassXC, la base, Vault formal, B2, volúmenes ni procesos de sesión.

**Límite del corte:** el checkout local Metodología carece de .git; no es fuente de build. La fuente canónica continúa siendo main del repositorio remoto.

---

## Reconciliación ejecutiva EP · 2026-11-11 · 14:23 America/Mexico_City

**Decisión del ciclo:** EP-TASK-001 conserva prioridad general, pero su próximo paso exige rotación KeeShare local del propietario y revisión P012/P013. El trabajo material P0 que puede continuarse después de esa compuerta es EP-TASK-002; se avanzó en diagnóstico read-only y preparación del worker, sin declarar finalizada la tarea.

- **EP-TASK-002:** el objeto B2 v6 de 2.200 bytes mantiene read-back SHA y SSE-B2/AES256; el restore R2 same-host acredita 3.289/3.289. La versión formal actual en EP\local-state\Khora\secrets mide 3.352 bytes y SHA-256 3122C544012F989F0501BD0E82EA920A93F19A42034D83FA682BCC2290891E82; es posterior al objeto v6 y aún no está respaldada. La copia antigua de 2.048 bytes es otra ruta y no se usa.
- **Sesión compartida:** GUI/CLI sí comparten DPAPI CurrentUser; la GUI registró unlock 20:00:01Z y lock 20:15:02Z, consistente con TTL 900 s. La sesión actual está cerrada; los nombres de variables no son legibles sin reabrirla.
- **Preparación:** worker y wrapper v7 creados localmente, lectura de vuelta exacta y parser PASS; receipt v7 aún ausente; ejecución NOT_RUN. El v6 histórico no se sobrescribe.
- **Siguiente gate:** el operador desbloquea EP Vault desde la GUI por 15 minutos y confirma ABIERTA. Después se ejecuta v7 una sola vez con la identidad propietaria y se exige recibo, upload, download, tamaño/SHA idénticos, SSE-B2/AES256 y restore aislado. Decrypt y cross-host requieren después bootstrap independiente.
- **Sin cambios:** EP-TASK-003/004/005/006/007 y sus dependencias conservan su estado; no se instala MCP-OCP, no se modifican volúmenes/workspace ni se realiza crypto-erasure.

**Cierre de estado:** EP-TASK-002 continúa en_curso; no se declara completada por el B2 histórico, el restore same-host, la preparación v7 ni la documentación.

## Reconciliación ejecutiva EP · 2026-11-11 · 14:41 America/Mexico_City

- **EP-TASK-002:** B2 v7 cargó y descargó el ciphertext formal actual (3.352 B; SHA-256 `3122C544012F989F0501BD0E82EA920A93F19A42034D83FA682BCC2290891E82`) con coincidencia exacta; SSE-B2/AES256 confirmado. Recibo v7 SHA-256 `D8CDE84B90D6F923BD8A42DEA72A284078FACDE84E95E3674675E02B4A81D523`; exit 0, 0 errores, caché temporal limpia, sin secretos emitidos. El restore same-host R2 sigue PASS (3.289/3.289); descifrado aislado v7 y recuperación cross-host siguen NOT_RUN. La marca RESTORE_VERIFIED del worker significa read-back del ciphertext, no restore del workspace.
- **Alcance y límites:** no se repitió la carga v6 ni el restore R2; no se modificaron ciphertext local, recibos históricos, ACL, GUI, DPAPI o workspace. La excepción histórica del ZIP sin cifrado cliente permanece. EP-TASK-002 continúa `en_curso`; no se promueve ninguna tarea a completada. Las demás EP-TASK conservan sus estados previos.
- **Próximo gate:** descifrado aislado de una copia del objeto v7 y recuperación en un segundo host físico independiente con bootstrap B2 separado.

## Reconciliación ejecutiva EP · 2026-11-11 · 14:46 America/Mexico_City

- **EP-TASK-002:** B2 v7 upload/read-back y SSE-B2/AES256 PASS; copia exacta descargada a directorio aislado y descifrada mediante HMAC + AES: PASS, 30 propiedades, cinco nombres B2 presentes, faltantes 0. SHA-256 `3122C544012F989F0501BD0E82EA920A93F19A42034D83FA682BCC2290891E82`; archivo formal sin cambios, temporales eliminados y ningún valor secreto emitido.
- **Cross-host:** NOT_RUN. Solo PC10RCIF4EI4 está en línea; PC-8/PC-7/PC-1 están desconectados. Dos conexiones al mismo equipo no acreditan un host independiente.
- **Estado global:** EP-TASK-002 permanece `en_curso`; tareas restantes sin cambio. No se declara aceptación integral, sincronización automática/idempotente ni cifrado cliente de futuras capturas.

## Reconciliación ejecutiva EP · 2026-11-11 · 14:51 America/Mexico_City

- **EP-TASK-001:** revalidación read-only de Profile 36. KeePassXC-Browser 1.10.4.1 ya está materializada; su habilitación no se afirma porque el campo `state` no se encuentra en la entrada Secure Preferences consultada. Existen cuatro manifiestos host KeePassXC, ejecutable de host presente y origen de KeePassXC-Browser permitido. Registro NativeMessagingHosts no verificado; KeePassXC no estaba ejecutándose. No se alteraron Chrome, KeePassXC, registro ni base; rotación KeeShare/P012/P013 pendientes.
- **EP-TASK-002:** B2 v7 y descifrado aislado HMAC/AES permanecen PASS; cross-host pendiente por falta de segundo host físico conectado.
- **EP-TASK-003/004/005/006/007:** estados no modificados en esta reconciliación; siguiente investigación de solo nombres prevista en EP-TASK-006.
- **Límite normativo:** OEP v0.3.69 §135 conserva la secuencia anterior de desbloqueo y worker v7 ya ejecutada. No se corrige ese objeto normativo en este ciclo sin autorización expresa de escritura normativa; el índice y núcleos provisionales reflejan la evidencia posterior.

## Reconciliación ejecutiva EP · 2026-11-11 · 14:54 America/Mexico_City

- **EP-TASK-001:** KeePassXC-Browser 1.10.4.1 está materializada en Profile 36; habilitación/Native Messaging no verificados. Host manifests existentes; KeePassXC no estaba ejecutándose. P012/P013 y rotación KeeShare siguen pendientes.
- **EP-TASK-002:** B2 v7 y descifrado aislado HMAC/AES PASS (30 propiedades); cross-host pendiente por no disponer de segundo host físico en línea.
- **EP-TASK-006:** Vercel live metadata `decrypt=false` cotejada contra snapshot `EP-VERCEL-ENV-CATALOG-khora-web.json`: 52/52 identidades exactas, sin altas/bajas/cambio de tipo. Distribución actual: 42 sensitive, 7 encrypted, 3 plain. Estados de entrada del snapshot: 9 STORED_READBACK_VERIFIED, 1 NOT_IMPORTED (GROQ_API_KEY), 42 BLOCKED_VALUE_NOT_RETRIEVABLE. El campo resumen `storedAndReadbackVerified=10` contradice las entradas y permanece como discrepancia; no se modificó el snapshot ni se interpretó NOT_IMPORTED como PASS.
- **EP Vault:** ciphertext formal presente (3.352 B) y recuperable; sesión actual sellada por TTL. No se ejecutó ListVariables y no se compararon los nombres del Vault con el catálogo actual.
- **EP-TASK-003/004/005/007:** estados sin cambio; gates físicos, H10, paquete MCP-OCP y Guardian/lease/trigger/crypto-erasure permanecen pendientes según sus núcleos.
- **Límite normativo:** OEP v0.3.69 §135 no se modificó; requiere autorización expresa para actualizar su secuencia tras los hitos v7 y descifrado.
