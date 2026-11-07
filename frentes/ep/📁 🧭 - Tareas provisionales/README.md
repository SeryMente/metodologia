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
| EP-TASK-003 | en_curso | Workspace Ser y Mente con todos los repositorios, extensiones Chrome, perfiles de ubicación y volatilidad | [núcleo](./📁%20🧩%20-%20EP-TASK-003%20-%20Mapa%20integral%20de%20construcción%20EP/README.md) |

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

La entrada INSTRUCCION-MATERIALIZACION-UBICACIONES-20261107.txt actualiza el reparto provisional:

- EP-TASK-002: persistencia de datos de usuario OCP en Backblaze B2; GitHub queda para código y objetos canónicos. La segunda unidad/equipo físico deja de ser una condición de cierre.
- EP-TASK-003: raíz workspace Ser y Mente, materialización dinámica de todos los repositorios actuales de SeryMente, sincronización obligatoria de extension/ para extensiones Chrome, perfiles de ubicación y reutilización del Guardian/hombre muerto.
- EP-TASK-001 permanece pendiente y sin cambio. No se crea otra tarea ni se autoriza implementación local, activación del Guardian, borrado o cambios en los repositorios consumidores por esta actualización documental.
