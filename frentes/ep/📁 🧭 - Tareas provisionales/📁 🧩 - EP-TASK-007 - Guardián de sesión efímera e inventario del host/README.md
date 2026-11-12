# EP-TASK-007 · Guardián de sesión efímera e inventario del host

**Estado:** `en_curso · HOST_INVENTORY_PARTIAL_READ_ONLY · CRYPTOMATOR_LOCK_UNMOUNT_NOT_RUN · APP_DATA_CONFINEMENT_PENDING · LOCATION_UNCLASSIFIED · GUARDIAN_NOT_RUN · LEASE_NOT_RUN · SESSION_CLEANUP_NOT_RUN`
**Prioridad:** P0 para protección de sesión después del hito de persistencia mínima; P1 para inventario extendido y optimización.  
**Responsable:** frente Entorno Persistente (EP).  
**OEP padre:** `frentes/ep/OEP.md`.  
**Coordinación:** GOV-TASK-015 · OCP MCP 1.0.  
**Objeto:** tarea provisional EP; no crea OCP, control, titularidad, sesión ni folio independientes.

## Rectificación vigente · OEP §137

EP-TASK-007 no utiliza BitLocker ni VHDX. El workspace persistente se abre y cierra mediante Cryptomator; el cierre de una sesión EP debe bloquear/desmontar la bóveda según el contrato aprobado y comprobar que la ruta lógica deja de exponer los datos. La limpieza de sesión solo alcanza datos temporales/efímeros creados para esa sesión. No se elimina, volatiliza ni modifica el workspace persistente ni datos de proyecto para ejecutar un cierre. Inventario de host solo identifica dependencias y verifica que las aplicaciones no persisten datos de usuario fuera de SeryMente.

## 1. Objetivo

Implementar un ciclo de sesión local segura que inicie automáticamente desde la GUI del Entorno Persistente, inspeccione el equipo en modo read-only, obtenga el workspace completo cifrado, mantenga un lease renovable y cierre/borrado criptográfico local cuando ocurra un trigger terminal.

Esta tarea es distinta del gate de materialización/protección física de Fila 4 en EP-TASK-003. No lo reemplaza, no lo cierra y no permite saltarlo. El dead-man de sesión se aplica a toda instancia OCP declarada efímera, cualquiera que sea la ubicación física; no depende de la clasificación CECEQ/LOC-OTHER. No elimina ni volatiliza el workspace raíz persistente de EP ni afecta B2. El gate EP-TASK-003 continúa regulando por separado la protección del host/workspace persistente de Fila 4.

## 2. Decisiones expresas del operador

- México como jurisdicción operativa declarada.
- El operador declara tener autorización para inspeccionar cualquier máquina donde opere. Se respetarán los permisos del sistema operativo y requisitos legales aplicables; no se evadirán controles de ubicación, elevación o administración del host.
- Inventario robusto por defecto, incluida ubicación GPS y contexto de red cuando estén disponibles por interfaces soportadas y no produzcan lentitud o problemas.
- Duración renovable aprobada: heartbeat/renovación cada 60 s; lease de 30 min; aviso previo; cierre por 10 min de inactividad; duración absoluta máxima de 8 h.
- Una sesión RDC activa por defecto; una segunda solo por excepción explícita. Máximo simultáneo: dos, cada una aislada.
- Workspace completo descargado en cada instancia; datos locales cifrados.
- Todo cifrado, incluidas conversaciones, adjuntos, telemetría identificable y snapshots.
- Al cerrar: intentar checkpoint primero, pero el borrado tiene prioridad; presupuesto de intento inicial 30 s, configurable y medible. Emergencia/sospecha de compromiso no espera al respaldo.
- Retención indefinida de datos cifrados útiles del proyecto, sujeta a obligaciones legales, solicitudes válidas y políticas aprobadas.

## 3. Inventario de sesión y host

Recolectar una vez al inicio y cuando cambie significativamente el contexto, sin sondeos costosos:

1. SO, edición, versión/build, arquitectura, idioma, zona horaria, hora UTC, elevación y capacidades del entorno.
2. Fabricante/modelo de equipo y familias CPU/GPU; RAM y recursos disponibles.
3. Unidades, modelo/familia, capacidad, bus/interfaz, HDD/SSD/UNKNOWN, volúmenes, sistema de archivos, espacio libre, estado de cifrado observable, suspensión/hibernación y capacidades relevantes.
4. Interfaces de red, IPv4/IPv6 local cuando sea necesario para diagnóstico, IP pública observada, ASN/operador y geolocalización aproximada por IP.
5. Ubicación GPS con precisión, fuente, timestamp y estado, mediante API/servicio del sistema operativo cuando esté habilitado. Si está deshabilitado, no disponible o requiere una autorización no concedida, registrar el motivo; no evadir ni modificar políticas.
6. Estado/versión de GUI EP, guardián, RDC, MCP-OCP y dependencias necesarias para el ciclo.
7. Rendimiento de preflight: medir duración y no bloquear instanciación con búsquedas externas lentas. GPS/IP pueden obtenerse en paralelo y fuera del camino crítico cuando corresponda.

Cada campo debe tener fuente, timestamp, precisión y estado AVAILABLE/UNAVAILABLE/DENIED/ERROR. No inventar valores ni convertir IP/hostname/serial en identidad técnica. La identidad interna usa UUIDv7 y pseudónimos; identificadores de hardware en claro no se conservan por defecto. Captura extendida queda sujeta a aviso/consentimiento y requisitos legales aplicables.

## 4. Guardián, lease y triggers

La GUI EP inicia automáticamente el guardián al crear cada sesión. El guardián debe tener vida independiente suficiente para reaccionar si la GUI principal o un proceso OCP falla.

| Parámetro | Valor inicial aprobado |
|---|---:|
| Renovación/heartbeat | 60 s |
| Ventana lease | 30 min |
| Inactividad terminal | 10 min |
| Duración absoluta máxima | 8 h |
| Presupuesto inicial de checkpoint normal | 30 s |
| Sesiones simultáneas | 1 normal; 2 solo por excepción explícita |

Triggers: vencimiento de lease, inactividad, terminación inesperada de GUI/proceso principal, pérdida del heartbeat del cliente, cierre explícito del operador, límite absoluto y activación manual de emergencia. Los triggers se clasifican como normales o de emergencia.

La expiración o inactividad normal intenta un único checkpoint cifrado durante un máximo inicial de 30 s. Si no termina y se verifica, no extiende la sesión: bloquea, desmonta y destruye la clave efímera local. La emergencia/sospecha de host comprometido bloquea y ejecuta crypto-erasure sin esperar a B2.

La caída de energía no puede ejecutar código de limpieza en el instante del corte. Por ello, la clave de sesión no se persistirá en claro ni se hará recuperable desde el perfil local; al perderse la memoria volátil el contenedor sigue cifrado e inaccesible, y la recuperación depende de la copia persistente autorizada.

## 5. Cierre criptográfico y limpieza

- Detener solo procesos y servicios iniciados por la sesión OCP.
- Bloquear/cerrar aplicaciones propias y desmontar el volumen/contenedor cifrado.
- Invalidar/destruir la clave efímera local y material derivado en memoria/almacén temporal que pertenezca a OCP.
- Limpiar cachés, temporales, manifiestos de trabajo, mounts y artefactos creados por OCP fuera del contenedor.
- En SSD/UNKNOWN usar crypto-erasure; no confiar en sobrescritura convencional ni ejecutar utilidades de borrado sobre el disco completo.
- Nunca borrar disco anfitrión, perfil Windows, datos de terceros, historial global, cookies ajenas ni versiones/backups B2.
- Emitir recibo local cifrado/saneado, sin secretos: trigger, timestamps, checkpoint intentado/resultado, desmontaje, clave invalidada, limpieza, residuos no eliminables y estado final.

## 6. Dependencias

- EP-TASK-002: B2, checkpoint, carga/descarga y restore.
- EP-TASK-003: gates físicos de workspace/host y protección de Fila 4; no se omiten.
- EP-TASK-004 y EP-TASK-006: bóveda y cobertura de variables organizacionales.
- EP-TASK-005: instalación/aceptación local, solo tras sus gates.
- MCP-OCP-14: contrato de snapshot/checkpoint y ciclo de persistencia.
- MCP-OCP-15: IDs, eventos y esquema de telemetría.
- MCP-OCP-16: sesión RDC, autenticación y entrega segura de credenciales en su hito posterior.

## 7. Criterios de aceptación

1. Inicio GUI → guardián iniciado automáticamente → evento session.started con IDs y hora UTC.
2. Preflight reproducible, read-only, con estados para datos no disponibles y duración medida.
3. Pruebas de renovación, inactividad, expiración, límite 8 h, cierre normal, cierre forzado, GUI caída, pérdida heartbeat y emergencia.
4. El cierre normal demuestra checkpoint acotado; fallo o timeout conduce al crypto-erasure local.
5. La emergencia no espera B2 y destruye la clave efímera.
6. El contenedor local no puede descifrarse después del cierre; la clave persistente de recuperación no se destruye.
7. Las operaciones solo afectan artefactos propios de OCP; pruebas negativas demuestran que no se toca el disco/perfil de terceros.
8. Recibo de cierre, timestamps, IDs y estado de limpieza pasan read-back sin secretos.
9. Prueba de caída abrupta/reinicio: ciphertext permanece inaccesible localmente sin la clave volátil; restore autorizado desde B2 es una prueba separada.
10. Rendimiento del inicio y preflight medido; tareas de GPS/IP no bloquean la apertura del workspace.

## 8. Restricciones

No efectuar cambios sobre Fila 4, BitLocker/VHDX, perfiles, almacenamiento o montaje hasta superar los gates vigentes de EP-TASK-003 y su aceptación. No extraer credenciales del chat, no exponer valores de EP Vault en logs ni crear una segunda bóveda. No alterar los controles EP generación 3, MCP-OCP generación 5 o Gobernanza generación 17.

**Resultado del presente asiento:** tarea configurada documentalmente. Acuse y ejecución pertenecen a EP; no se declara guardian, inventario, lease, borrado ni pruebas ejecutados.


---

## Acuse de ejecución EP · inventario read-only Fila 4 · 2026-11-10 · 15:33 America/Mexico_City

El operador instruyó al frente EP a revisar y resolver sus tareas según la secuencia programada. Se inició el hito de inventario, sin implementar todavía el Guardián.

### Evidencia

- Inventario ejecutado bajo token propietario Fila 4, no elevado, a las 2026-11-10T21:33:46.2515973Z.
- OS: Windows 11 Pro, versión/build 10.0.26200, 64 bits; zona Central Standard Time (Mexico).
- Equipo observado: HP ProDesk 400 G4 DM; RAM 17.015.545.856 bytes; CPU Intel Core i7-8700T, 6 cores/12 logical processors; GPU Intel UHD Graphics 630.
- Discos detectados: disco virtual Microsoft 30 GiB y HS-SSD-WAVE(S) 256 GB. No se retuvieron seriales, hostname, MAC, IP ni IDs de sesión.
- Adaptador Realtek PCIe GbE, Up, 1 Gbps. IP pública, IP local y geolocalización no consultadas. GPS no disponible/no solicitado; ubicación física sigue UNCLASSIFIED.
- GUI EP Vault presente/responsiva; el estado de bóveda se comprobó por separado y permanece SELLADA. B2 CLI presente.
- Archivo de evidencia local: `EP/local-state/run-logs/ep-task-007-host-inventory.json`, 4.253 bytes, SHA-256 `E0B2FF98A70DF35E2B572638E5E3CFE39D629781852C2F5FBE03A4C4B39FD673`; lectura de vuelta realizada.
- Copia documental saneada y cotejada en [EP-FILA4-READONLY-PREFLIGHT-20261110-1530.json](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/entregas/EP-FILA4-READONLY-PREFLIGHT-20261110-1530.json), blob `88dd663df4345df343a51ad2800f0ad79953c60d`.

### Estado del hito

`HOST_INVENTORY=PARTIAL_READ_ONLY_VERIFIED` · `GPS=NOT_REQUESTED` · `IP=NOT_COLLECTED` · `LOCATION=UNCLASSIFIED`.

No se instaló ni inició Guardian, no se creó lease/heartbeat/tarea programada de guardia, no se registraron triggers, no se montó/desmontó volumen y no se ejecutó crypto-erasure. Los contratos MCP-OCP-14/15/16 y las dependencias EP-TASK-002/003/004/006 siguen abiertos. El inventario no equivale a aceptación de seguridad ni a autorización de runtime.


## Reporte individual obligatorio por tarea
Al resolver esta tarea, el responsable debe agregar el informe individual en este mismo núcleo siguiendo [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md), completar todos sus campos y actualizar el índice padre solo después del read-back. No marcar como completada sin criterios PASS, evidencia ejecutada, integridad verificada y aceptación exigible. Si termina parcial/bloqueada, dejar igualmente el informe con bloqueantes, preocupaciones, riesgos y condición objetiva de desbloqueo. Informar al operador con enlace al informe. Esta instrucción no altera titularidad, generación, permisos ni controles.


---

### Informe de revalidación parcial read-only · EP-TASK-007 · 2026-11-10 · 15:49 America/Mexico_City

- **Frente / responsable:** Entorno Persistente (EP).
- **Estado anterior → resultante:** HOST_INVENTORY_PARTIAL_READ_ONLY_VERIFIED → mismo estado; se agrega evidencia de volúmenes/VHDX y árbol de trabajo.
- **Corte de fuente:** SeryMente/metodologia/main; núcleos EP-TASK-002/003/007; OEP §125–§126; DUG Samantha v388 · NX-388m.
- **Objetivo y resultado:** mantener inventario de host de solo lectura y sus dependencias, sin introducir aún Guardian, lease ni crypto-erasure. Resultado: se revalidaron de forma separada el árbol de trabajo (token propietario) y el estado de BitLocker/VHDX (contexto administrativo usado exclusivamente para lectura).
- **Cómo se revalidó:** se ejecutaron dos enumeraciones recursivas idénticas del workspace y consultas de solo lectura de volúmenes, protectores y DiskImage. No se consultaron IP, GPS, ASN ni ubicación.
- **Cambios realizados:** ninguno en el host. Se actualiza únicamente este registro documental.
- **Validación y evidencia:**
  | Criterio | Estado | Evidencia |
  |---|---|---|
  | Enumeración del workspace | PASS en dos lecturas | 3.127 archivos, 660 directorios, 179.138.515 bytes, 0 errores, 0 reparse points |
  | C: | OBSERVADO / GATE FAIL | XtsAes128, 100 %, Protection Off, 0 protectores |
  | W: | OBSERVADO / GATE FAIL | FullyDecrypted, método None, Protection Off, 0 protectores; NTFS |
  | VHDX de preparación | OBSERVADO | Adjunto, 30 GiB; archivo en AppData 171.966.464 bytes |
  | Equipo/SO | ÚLTIMO INVENTARIO VÁLIDO | Windows 11 Pro build 10.0.26200, HP ProDesk 400 G4 DM, Intel Core i7-8700T, Intel UHD 630; no se repitió inventario de hardware en este subciclo |
  | Ubicación/IP/GPS | NOT_VERIFIED | Ubicación UNCLASSIFIED; datos de IP/GPS no recopilados |
  | Guardian/lease/trigger/crypto-erasure | NOT_RUN | Ningún componente implementado ni activado |
- **Read-back e integridad:** resultados devueltos por las consultas y dos recorridos del workspace; no se escribió evidencia local nueva ni se cambiaron las protecciones.
- **Bloqueantes/dependencias:** EP-TASK-002/003/004/006 y contratos MCP-OCP-14/15/16. No instalar el Guardián antes de los gates y la aceptación de EP-TASK-003.
- **Preocupaciones/riesgos y mitigaciones:** el volumen actual de workspace sigue desprotegido por BitLocker activo; no alterar el VHDX viejo ni los volúmenes existentes. No inferir ubicación física a partir de red. Las operaciones administrativas fueron de consulta.
- **Pendientes/diferidos:** inventario extendido/GPS/IP cuando esté permitido y no ralentice el preflight; Guardian, lease renovable, triggers, cierre, crypto-erasure y recibo; pruebas de fallos/timeout y restauración.
- **Rollback/recuperación:** no hubo mutaciones y por tanto no se requiere rollback del ciclo. Los mecanismos futuros siguen NO_VERIFICADOS.
- **Aceptación:** PENDIENTE; inventario parcial no equivale a aceptación de seguridad.
- **Siguiente acción:** permanecer bloqueado hasta B2 restore, EP-TASK-003 PASS, bóveda validada y contratos MCP-OCP-14/15/16.
- **Conclusión:** PARCIAL. Se amplió la evidencia read-only; Guardian y borrado criptográfico continúan no implementados.


## Plan de diseño, verificación y aceptación del ciclo de sesión · 2026-11-11

**Estado:** inventario del host parcial read-only; Guardian/lease/triggers/crypto-erasure continúan NOT_RUN. Este plan no activa monitoreo, Guardian ni operaciones destructivas.

### Límites de responsabilidad

EP-TASK-003 protege y materializa el workspace persistente raíz de EP, con política CECEQ/LOC-OTHER y su dead-man específico. EP-TASK-007 gobierna el ciclo de cada sesión efímera OCP (inventario, lease, checkpoint, trigger y cierre criptográfico). No se duplican ni se usan una tarea para saltar el gate de la otra.

### Secuencia

1. **Definir entradas verificables.** Enumerar propiedades del host/sesión, fuente, timestamp, precisión, permisos y costo del preflight. GPS/IP solo se consultan por interfaces soportadas y con autorización; registrar NO_DISPONIBLE/NO_AUTORIZADO en lugar de inferir ubicación.
2. **Congelar política de sesión.** Preservar los parámetros aprobados: renovación 60 s, lease 30 min, aviso previo, inactividad 10 min y máximo absoluto 8 h. Mantener estos parámetros separados del TTL de desbloqueo EP Vault. Toda modificación requiere trazabilidad y evaluación de impacto.
3. **Diseñar el modelo de estados y contratos.** Especificar estados, transiciones, eventos terminales, responsables y recibos de inventario/checkpoint/cierre. La máquina de estados es propuesta técnica a revisar bajo P013 si cambia arquitectura o perímetro de seguridad; no asumir que labels o transiciones sugeridas ya son canónicas.
4. **Resolver precedencia del cierre.** El checkpoint se intenta primero dentro del presupuesto inicial de 30 s, pero la prioridad de borrado en emergencia/sospecha de compromiso se mantiene. Especificar los resultados para checkpoint PASS/FAIL/timeout, bloqueo BitLocker FAIL, pérdida de red, lease vencido, reloj inconsistente y terminación forzada del controlador.
5. **Implementar por adaptadores pequeños.** Separar inventario read-only, renovación de lease, decisión de trigger, bloqueo/desmontaje, crypto-erasure y recibo. Cada módulo consume estado comprobado; no iniciar el siguiente paso con datos incompletos o contradictorios. Respetar las exclusiones: sin vigilancia general, sondeos costosos ni mecanismos no aprobados.
6. **Probar en laboratorio aislado.** Fixtures para expiración, falta de renovación, host suspendido, clock skew, pérdida de red, B2 no disponible, checkpoint parcial, proceso terminado, permisos insuficientes, volumen ajeno y recuperación. Los tests destructivos solo se realizan sobre contenedores desechables; nunca sobre el workspace real.
7. **Validar extremo a extremo.** Probar inicio, inventario, lease, checkpoint, trigger terminal, bloqueo/desmontaje, eliminación limitada, recibo y ausencia de procesos huérfanos. Medir tiempos reales y falsos positivos; no usar una simulación como evidencia de operación real.

### Review Focus y criterios de cierre

- Sesión de una o dos instancias conforme al límite aprobado; aislamiento entre instancias.
- Inactividad y máximo absoluto no se confunden con el TTL de Vault.
- Cada trigger tiene condición positiva, condición negativa, fuente y evidencia.
- Emergency/suspicion no espera al backup; el intento de checkpoint respeta el presupuesto y no posterga el borrado prioritario.
- Crypto-erasure afecta únicamente al contenedor efímero declarado; no toca workspace persistente ni B2.
- Inventario respeta permisos, fuente, precisión y costo; ninguna ubicación se infiere.
- Cierre: contratos congelados, pruebas de laboratorio PASS, pruebas reales autorizadas de bloqueo/desmontaje/borrado/recuperación, métricas, recibos y aceptación del operador.

### Rollback y seguridad

En desarrollo, rollback a configuración/build previo y destrucción solo de fixtures temporales. En host real, no existe rollback ficticio del borrado criptográfico: por ello las pruebas destructivas se separan del entorno productivo y requieren compuertas y autorización específicas. Si una condición de seguridad no se verifica, el resultado es BLOCKED/FAIL, nunca PASS por defecto.

---

## Revalidación de host y protección de volúmenes · 2026-11-11 · 10:38 America/Mexico_City

**Estado operativo:** en_curso · HOST_INVENTORY_PARTIAL_READ_ONLY · BITLOCKER_GATE_FAIL · LOCATION_UNCLASSIFIED · GUARDIAN_NOT_RUN.

### Identidad y contexto de ejecución

Se verificó la sesión RDC de trabajo CENTRAL/fila4, perfil C:/Users/fila4. El token de Fila4 no está elevado. La conexión administrativa CENTRAL/MantenimientoRCI se utilizó solo para consulta manage-bde read-only; no se escribieron archivos en ese perfil ni se modificó la configuración del equipo.

### Estado de cifrado observado

- C: cifrado al 100 % por espacio usado, XTS-AES128, Protection Off y sin protectores.
- W: EP-FILA4, 29.98 GB, completamente descifrado, 0 %, método None, Protection Off y sin protectores.
- Ubicación CECEQ/LOC-OTHER sigue UNCLASSIFIED; no se recogieron GPS ni IP para inferirla.
- La CLI EP Vault no está inicializada en su ubicación formal y sessionActive=false.

### Estado de Guardian y cierre

No se implementó ni ejecutó Guardian, lease, heartbeat, trigger terminal, bloqueo/desmontaje ni crypto-erasure. No se borró ni modificó workspace, ciphertext, volumen ni archivos. El inventario actualiza el diagnóstico, pero no satisface el gate de protección de EP-TASK-003 ni las dependencias MCP-OCP-14/15/16. Las pruebas destructivas continúan limitadas a contenedores sintéticos desechables hasta que existan almacenamiento, custodia y aceptación requeridos.

 
## Revalidación de BitLocker y custodia de host · 2026-11-11 · 14:54 America/Mexico_City

**Resultado:** `HOST_INVENTORY_PARTIAL_READ_ONLY_VERIFIED`; la barrera de almacenamiento continúa FAIL.

- Consulta con `Get-BitLockerVolume` en sesión RDC independiente `CENTRAL\MantenimientoRCI`; la consulta desde `CENTRAL\fila4` resultó `Acceso denegado`. No se eludió el control ni se elevó la sesión propietaria.
- `C:`: XTS-AES128, 100 %, FullyEncrypted, Protection Off, cero protectores.
- `W:`: FullyDecrypted, método None, 0 %, Protection Off, cero protectores.
- Ubicación permanece `UNCLASSIFIED`; GPS/IP no fueron consultados.
- Revalidación EP Vault separada: ciphertext formal presente (3.352 B); B2 v7 read-back SHA y SSE-B2/AES256 PASS; copia aislada descifrada HMAC/AES PASS. La sesión formal CLI está actualmente cerrada por TTL; no se afirma que la bóveda esté ausente ni NOT_INITIALIZED.
- Guardian, lease, heartbeat, triggers, bloqueo/desmontaje, crypto-erasure y pruebas destructivas siguen `NOT_RUN`.

**Límites:** no se instalaron servicios, tareas programadas ni procesos de vigilancia; no se modificó BitLocker, VHDX, workspace, ACL, Vault ni B2. EP-TASK-007 permanece `en_curso` y no puede avanzar a una prueba destructiva hasta superar EP-TASK-003 y sus controles de aceptación.

 
## Revalidación de BitLocker y custodia de host · 2026-11-11 · 14:54 America/Mexico_City

**Resultado:** `HOST_INVENTORY_PARTIAL_READ_ONLY_VERIFIED`; la barrera de almacenamiento continúa FAIL.

- Consulta con `Get-BitLockerVolume` en sesión RDC independiente `CENTRAL\MantenimientoRCI`; la consulta desde `CENTRAL\fila4` resultó `Acceso denegado`. No se eludió el control ni se elevó la sesión propietaria.
- `C:`: XTS-AES128, 100 %, FullyEncrypted, Protection Off, cero protectores.
- `W:`: FullyDecrypted, método None, 0 %, Protection Off, cero protectores.
- Ubicación permanece `UNCLASSIFIED`; GPS/IP no fueron consultados.
- Revalidación EP Vault separada: ciphertext formal presente (3.352 B); B2 v7 read-back SHA y SSE-B2/AES256 PASS; copia aislada descifrada HMAC/AES PASS. La sesión formal CLI está actualmente cerrada por TTL; no se afirma que la bóveda esté ausente ni NOT_INITIALIZED.
- Guardian, lease, heartbeat, triggers, bloqueo/desmontaje, crypto-erasure y pruebas destructivas siguen `NOT_RUN`.

**Límites:** no se instalaron servicios, tareas programadas ni procesos de vigilancia; no se modificó BitLocker, VHDX, workspace, ACL, Vault ni B2. EP-TASK-007 permanece `en_curso` y no puede avanzar a una prueba destructiva hasta superar EP-TASK-003 y sus controles de aceptación.
