# 📝 Registro de tareas provisionales del frente Entorno Persistente

**Estado:** materialización operativa provisional; no modifica ni sustituye el OEP, no crea un ámbito funcional ni canoniza un sistema general de gestión de tareas.  
**Contenedor:** `frentes/ep/📁 🧭 - Tareas provisionales/`  
**OCP padre y fuente de contexto:** `frentes/ep/OEP.md`  
**Evento de creación:** instrucción directa del operador en esta conversación · 2026-10-31.  
**Fuente normativa consultada:** DUG v373 · NX-373m · Metacanon 1.26, en `main`.

## Naturaleza y límites

Este contenedor agrupa objetos provisionales de tarea del frente EP. Cada tarea tiene identificador local estable, directorio y núcleo propio. Las tareas no son frentes independientes, no crean un OCP funcional nuevo ni adquieren titularidad, autorización, control, sesión o folio global independientes.

La responsabilidad de seguimiento se vincula al frente EP y a su objeto OEP. La creación de una tarea no transfiere ni formaliza por sí sola la titularidad del frente y no amplía permisos de producto o de entorno.

El patrón de materialización sigue el registro de tareas provisionales de Gobernanza: índice de frente y un README por objeto de tarea. Se conserva la práctica de Custodia de mantener explícito el estado provisional y enlazar la lista desde el frente. Este registro no declara ratificado un estándar universal de tareas.

## Registro ejecutivo

| ID local | Estado | Tarea | Núcleo |
|---|---|---|---|
| EP-TASK-001 | pendiente | NCL — Navegador Compartido Local: integración de Playwright y KeePassXC | [núcleo](./📁%20🧩%20-%20EP-TASK-001%20-%20Integración%20NCL/README.md) |
| EP-TASK-002 | en_curso | Datos de usuario OCP en Backblaze B2; separación GitHub/B2 y recuperación por perfil | [núcleo](./📁%20🧩%20-%20EP-TASK-002%20-%20Persistencia%20provisional%20Backblaze/README.md) |
| EP-TASK-003 | en_curso | Materialización del workspace y dead-man trigger exclusivo para ubicaciones distintas de CECEQ | [núcleo](./📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md) |
| EP-TASK-004 | en_curso | Reconstrucción integral de la bóveda EP: UI nueva desde cero, mecanismos, sesión configurable y acceso CLI/headless | [núcleo](./%F0%9F%93%81%20%F0%9F%A7%A9%20-%20EP-TASK-004%20-%20Reconstrucci%C3%B3n%20de%20b%C3%B3veda/README.md) |

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
| EP-TASK-002 | `en_curso` | Prueba B2 sintética histórica conserva PASS; no demuestra sincronización automatizada, observabilidad real ni restore actual. Se añadió contrato local-first/cola B2 y separación estricta GitHub (código) / B2 (datos de usuario elegibles). | Inventario de datasets, clasificación y retención; credenciales locales disponibles por bóveda segura; automatizar cola, subida, read-back y restore. |
| EP-TASK-003 | `en_curso` | Root `Desktop\SeryMente` creado en PC-14 por RDC; 11 scaffolds vacíos y `WORKSPACE-STATUS.md` verificado. Excepción provisional en claro autorizada solo para código/documentación no sensible. | Clones reales y clasificación de frentes; autorización de autenticación GitHub local; migración posterior a VHDX + BitLocker XTS-AES256, protección activa/100 %; dead-man LOC-OTHER. |
| EP-TASK-004 | `en_curso` | Core/CLI/GUI y pruebas tienen avances históricos; UI premium rechazada; recurso de acero negro generado localmente en Fila 4 pero todavía no integrado. La bóveda queda en metodología y no es extensión Chrome. | Aceptar la bóveda canónica y su flujo local; después crear/activar VHDX con la misma contraseña y protector de recuperación. Cerrar H3–H10 con evidencia y aceptación. |

**Regla de estado:** no promover tareas a `completada` por documentación, diseño aprobado, pruebas sintéticas parciales o archivos instalados. Los hitos internos sí mantienen sus estados parciales/completados dentro de cada núcleo. El índice resume identidad y estado; el detalle y la crónica permanecen en el README individual.

### Límites de PC-14 en este ciclo

El dispositivo RDC autenticado es `PC-14`, ID `4fc35a07-2192-4b88-81ec-96cb450d565e`; la consola activa es `PC-14\PC 13`, perfil `C:\Users\PC 13`, Desktop `C:\Users\PC 13\Desktop`. C: está sin BitLocker (0 %, Off). No se creó `SeryMente`, no se creó VHDX ni se clonó ningún repositorio. La discrepancia con la directriz operativa anterior de utilizar `fila4` bloquea cualquier escritura en ese host hasta que el propietario del perfil quede expresamente resuelto. El operador declaró la ubicación como cibercafé; clasificación provisional `LOC-OTHER`. No se activa volatilización porque el dead-man trigger todavía no existe.

**Ciclo documental:** DTC de apertura anexado y leído de vuelta; OEP §108, EP-TASK-002, EP-TASK-003 y EP-TASK-004 actualizados en `main` con lectura de vuelta posterior. EP-TASK-001 se conserva sin modificación. La implementación física del workspace y el cierre técnico de EP permanecen pendientes.

### Delta operativo · 2026-11-09 · PC-14

El operador autorizó una instancia provisional en claro por RDC para avanzar en frentes no sensibles. Root creado: `C:\Users\PC 13\Desktop\SeryMente`, identidad `PC-14\PC 13`; 11 scaffolds vacíos (no clones); `WORKSPACE-STATUS.md` SHA-256 `3B03FE0507903B7B42BA538B55D2954E9241A7C4A5F3746FB8D4C091117063EF`. C: continúa FullyDecrypted/0 %/Protection Off.

La exportación íntegra se archivó en [ChatGPT-EP (1)-20261109-1031.md](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/entregas/ChatGPT-EP%20(1)-20261109-1031.md): SHA-256 original `B08DEE8C0317EC2DDC28CD5D98925A975F1C571A1CC6B3C9852319CC945CF001`, commit `7260b1d398904f7dc13a76858d9f6f3c661831a7`, blob `0be706ff04bfe9158c0f33b2f984c3952a6d03e4`, 82,367 bytes / 1,645 líneas y read-back exacto. No se hizo `gh auth login`, no se leyeron/trasladaron tokens ni se almacenaron secretos.

EP-TASK-003 sigue `en_curso`; la excepción no sustituye la migración posterior a VHDX/BitLocker ni el dead-man LOC-OTHER. EP-TASK-001 `pendiente`; EP-TASK-002 y EP-TASK-004 `en_curso`.
