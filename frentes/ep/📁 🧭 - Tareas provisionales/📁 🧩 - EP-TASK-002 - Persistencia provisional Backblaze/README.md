# 📝 EP-TASK-002 · Persistencia provisional con Backblaze B2 para datos de usuario y continuidad de la sesión canónica

**Naturaleza:** tarea provisional del frente Entorno Persistente; materialización auxiliar del registro de tareas, no un OEP nuevo, no un frente independiente y no una decisión de arquitectura canónica.  
**Estado:** `en_curso` — auditoría remota/documental parcial; inventario local NO ACEPTADO por restricción vigente; implementación técnica, transferencias y restauración NO INICIADAS.  
**Responsabilidad:** vinculada a `frentes/ep/`; sin control, sesión, titularidad ni folio global propios.  
**task_id:** `EP-TASK-002` (identificador local estable; no es folio global).  
**scope_ref:** `frentes/ep/`  
**Origen:** instrucción directa del operador recibida el 2026-10-31: crear un objeto provisional para habilitar persistencia remota con Backblaze, centrada en los datos de usuario de aplicaciones portables y continuidad de la sesión de trabajo canónica a través de distintas ubicaciones; priorizar confiabilidad y automatización sobre cifrado avanzado.  
**Relación con el OEP:** desarrolla provisionalmente necesidades dentro de OEP; no lo sustituye ni modifica sus §§23–26, ni crea un almacén paralelo de estado metodológico, autorización o bitácora.

## 1. Enunciado

Diseñar, preparar, implementar y verificar un mecanismo provisional de persistencia remota utilizando Backblaze B2 como destino de almacenamiento para que los datos de usuario de aplicaciones portables y los artefactos necesarios para reanudar la sesión de trabajo canónica sobrevivan al cierre de una sesión local, pérdida o sustitución del equipo y cambio de ubicación. El sistema debe identificar de manera explícita qué datos se conservan, asociarlos a rutas lógicas estables independientes del host, sincronizar automáticamente los cambios después de una activación inicial, mantener una copia recuperable en B2 y restaurarla en un nuevo entorno sin reconstrucción manual ordinaria. La prioridad funcional es **confiabilidad, integridad, recuperación, idempotencia y mínima intervención del operador**; el cifrado avanzado no es el objetivo principal de esta etapa, aunque las credenciales de acceso y los secretos no deben exponerse ni almacenarse accidentalmente en el conjunto de datos. La tarea comprende inventario de aplicaciones y datos, auditoría del B2/CLI ya disponible, definición de mapeo de rutas, política de sincronización y conflictos, automatización de captura/subida/verificación, recuperación en otra ubicación, pruebas de interrupción y aceptación extremo a extremo. NCL es una capacidad complementaria: no es requisito para sincronizar archivos ordinarios, pero podrá ser necesario para preservar o reconstituir datos de navegador/sesiones autenticadas cuando se demuestre que esos datos forman parte del alcance y que su captura es segura y coherente.

## 2. Necesidad y resultado operativo

El resultado buscado no es una copia manual ocasional ni una carpeta subida una sola vez. Es una continuidad operativa donde:

- Los datos de usuario relevantes de aplicaciones portables estén respaldados fuera del equipo donde se está trabajando.
- La ubicación física del equipo no determine la identidad del conjunto de datos; cada aplicación/área debe tener un identificador lógico y un mapeo reproducible a su ruta local real.
- Los cambios locales se detecten y sincronicen sin requerir que el operador copie archivos manualmente en cada sesión.
- Una ubicación nueva pueda recuperar el último estado remoto íntegro y continuar el trabajo.
- Las transferencias interrumpidas se puedan reintentar sin corromper el último estado bueno ni duplicar operaciones lógicas.
- Los conflictos entre ubicaciones se detecten y preserven; nunca se resuelvan sobrescribiendo silenciosamente una copia válida.
- El sistema indique de forma verificable cuándo el conjunto local está sincronizado, pendiente, degradado o no recuperable.
- El operador no tenga que intervenir en los ciclos ordinarios después de que el sistema esté configurado y habilitado. La configuración inicial de cuenta, permisos o selección de datos puede requerir una autorización puntual si la plataforma la exige; no prometer automatización sin intervención antes de conocer esos requisitos.

**Criterio rector:** persistencia remota + materialización local adaptable + sincronización automática + restauración verificable entre ubicaciones.

## 3. Alcance de datos candidatos

El inventario inicial debe identificar para cada aplicación su producto/versión, portabilidad real, ruta de ejecutable, ruta de datos, tamaño, patrón de escritura, método seguro de snapshot, criticidad, sensibilidad, dependencias y método de restauración.

### 3.1 Candidatos a incluir

- Configuración y preferencias de usuario de aplicaciones portables.
- Bases de datos locales y archivos de estado que puedan copiarse mediante un snapshot consistente.
- Documentos de trabajo, proyectos no cubiertos por un remoto confiable, recursos locales del workspace y archivos creados por el usuario.
- Perfiles/configuraciones de herramientas necesarias para reconstruir el entorno, siempre que no contengan secretos que deban excluirse o custodiarse por otro mecanismo.
- Manifiesto de sesión y referencias necesarias para recuperar repositorios, aplicaciones, versiones, rutas, preferencias y estado de trabajo; no reemplazar con esto los objetos canónicos ni los registros de autorización existentes.

### 3.2 Exclusiones por defecto hasta decisión y prueba específicas

- Ejecutables y dependencias reinstalables, salvo que se demuestre que la distribución portable concreta no puede recuperarse de su fuente.
- Cachés, temporales, logs de alta frecuencia regenerables y archivos de compilación, salvo necesidad demostrada.
- Tokens, contraseñas, claves privadas, cookies y secretos de autenticación. No agregarlos al conjunto general de B2 por conveniencia.
- Archivos de bloqueo, sockets, WAL/SHM o archivos de bases abiertas copiados sin mecanismo de snapshot consistente.
- Perfil completo de Chrome y bases activas de navegador. La persistencia de sesiones autenticadas, cookies y estado de NCL requiere análisis específico, prueba controlada y decisión explícita; no se deduce del permiso para respaldar datos portables ordinarios.
- Repositorios que ya tienen un remoto canónico y verificable, salvo cambios locales no publicados que se decida preservar. B2 no sustituye Git ni los remotos de código.

### 3.3 Relación con OEP y sistemas existentes

OEP §§23–26 ya describe persistencia remota, libro mayor de eventos `ep_sessions`, `ep_bootstrap_tokens` y `ep_events`, así como encadenamiento de integridad SHA-256. Antes de construir, adquirir la implementación actual y comprobar qué existe realmente. Backblaze no debe reemplazar, duplicar ni contradecir el libro mayor, la continuidad de Git o el estado OEP. Su función provisional primaria es persistencia de archivos/datos de usuario y artefactos recuperables, salvo decisión posterior con evidencia.

## 4. Modelo funcional propuesto

**Estado local de usuario → snapshot coherente → inventario/manifiesto → sincronización B2 → comprobación remota → recibo de sincronización → restauración en ubicación nueva → verificación de integridad y apertura funcional.**

El manifiesto deberá registrar, como mínimo, identificador lógico del conjunto, versión del esquema, host/ubicación de origen sin usarlo como identidad del conjunto, fecha del snapshot, ruta lógica, tamaño, SHA-256 local, versión/identificador remoto cuando esté disponible, estado de transferencia y resultado de verificación. No guardar secretos ni rutas que identifiquen otros perfiles ajenos.

La restauración debe resolver el Escritorio y las carpetas locales mediante las rutas reales del usuario/host; no fijar rutas de una ubicación anterior ni sobrescribir contenido existente sin comparar, respaldar y verificar.

## 5. Política de confiabilidad y sincronización

1. **Primera carga no destructiva:** comenzar con una copia de prueba aislada y un prefijo dedicado del bucket. No usar `--delete` ni ejecutar operaciones de borrado remoto en el MVP inicial.
2. **Identidad estable:** mapear cada conjunto de datos a un ID lógico independiente de nombre de máquina, unidad o ruta física. Mantener los destinos locales como perfiles por ubicación.
3. **Integridad:** construir manifiesto SHA-256 de los archivos elegibles; verificar conteos, tamaños y hashes después de la subida y después de la restauración. Los checksums del proveedor/CLI son útiles, pero no sustituyen el manifiesto de aceptación.
4. **Consistencia de aplicaciones:** cerrar la aplicación de forma controlada o usar su API/backup nativo/snapshot transaccional cuando la base esté activa. No copiar bases vivas por simple enumeración.
5. **Idempotencia:** repetir una sincronización sin cambios no debe alterar el resultado lógico ni producir conflicto artificial. Registrar operaciones y recibos de manera que una respuesta perdida pueda reconciliarse.
6. **Interrupciones:** mantener el último checkpoint confirmado, detectar transferencias incompletas, reintentar de forma limitada y no marcar sincronizado hasta verificar objeto remoto y manifiesto.
7. **Versiones y recuperación:** comprobar la política actual de versiones y lifecycle del bucket antes de configurarla. Preservar versiones durante la etapa inicial; no introducir retención destructiva sin una decisión y prueba de restauración.
8. **Conflictos entre ubicaciones:** detectar cambios divergentes con base en contenido/hash y metadatos; preservar ambas variantes en cuarentena o ramas de estado hasta resolver. Nunca elegir ganador solo por reloj local.
9. **Cambios/borrados:** una desaparición local no se propaga como borrado remoto en el MVP. El borrado lógico necesita tombstone, retención y una aceptación distinta.
10. **Modo offline:** almacenar una cola local duradera, reanudar al recuperar conectividad y mostrar el estado pendiente; no perder cambios locales por falta de red.
11. **Concurrencia:** un mismo conjunto no puede admitir escrituras concurrentes no coordinadas desde dos ubicaciones. Debe existir lock/lease o detección de conflicto antes de actualizar el estado canónico.
12. **Observabilidad:** informar último snapshot, último upload confirmado, diferencias pendientes, conflictos, errores y estado recuperable sin exponer credenciales.

## 6. Automatización extremo a extremo

La automatización pretendida comprende:

1. Descubrir y verificar CLI, versión, conectividad, variables/credenciales disponibles y permisos mínimos sin imprimir sus valores.
2. Confirmar cuenta/bucket/prefijo autorizados y obtener el inventario de configuración no sensible.
3. Descubrir los datos de usuario de aplicaciones elegibles a partir de rutas y manifiestos declarados; no escanear perfiles privados indiscriminadamente.
4. Crear snapshots coherentes y manifiestos deterministas.
5. Transferir solo cambios elegibles a B2.
6. Verificar existencia remota, tamaños, versiones e integridad del conjunto.
7. Emitir recibo/estado persistente y conservar cola local de cambios no confirmados.
8. En una ubicación nueva, detectar la ausencia del estado local, recuperar el manifiesto y restaurar a rutas locales correctas.
9. Validar hashes y ejecutar pruebas de apertura/lectura funcional de las aplicaciones elegidas.
10. Reanudar sincronización ordinaria sin que el operador tenga que gestionar manualmente archivos en cada cambio de ubicación.

La automatización se considera habilitada solo después de demostrar el ciclo completo en dos ubicaciones. Antes de ello, cualquier referencia a automatización es diseño o implementación parcial. La fase inicial puede requerir una autorización puntual para conceder acceso B2 o confirmar el conjunto de datos; después, el objetivo es operación desatendida dentro de permisos previamente aceptados.

## 7. Relación con NCL

- La sincronización de documentos, configuración y archivos ordinarios no depende de NCL.
- NCL puede ser necesario para automatizar la restauración/validación de aplicaciones cuya configuración o estado solo se administra mediante una sesión web autenticada.
- El perfil de Chrome, cookies y sesiones vivas no se deben considerar datos ordinarios. Se mantienen fuera del alcance inicial hasta que NCL y la política de custodia demuestren una vía de captura/restauración coherente y autorizada.
- La tarea no cambia EP-TASK-001 ni adelanta automáticamente su prioridad. La dependencia real se decidirá por aplicación y dato concreto, no por asociación general.

## 8. Herramientas y opciones técnicas por evaluar

- CLI oficial `b2` de Backblaze: candidata directa para autorización, consulta de buckets, `b2 sync`, operaciones de versiones y lifecycle.
- `rclone` con backend B2: alternativa a comparar por manejo de sincronización, filtros, reintentos y checksums.
- PowerShell como orquestador en Windows: descubrimiento de rutas, inventario, snapshot, manifiesto, coordinación, programación al inicio/salida de sesión cuando esté autorizada, y restauración.
- Git para código y configuración reproducible; no versionar secretos ni estado privado de usuario.
- Mecanismos de snapshot específicos de SQLite/u otras aplicaciones cuando aplique.

La elección final de CLI se hace tras leer la configuración local existente y ejecutar una prueba pequeña, reversible y aislada. No instalar ambas herramientas por anticipación. No asumir que las variables B2 existen o son válidas hasta comprobar su presencia, origen, alcance y respuesta del proveedor sin revelar valores.

## 9. Seguridad mínima compatible con la prioridad funcional

El operador indica que el cifrado avanzado no es una prioridad de esta etapa. La aceptación inicial se enfoca en continuidad e integridad. Aun así:
- Bucket privado y clave con permisos mínimos sobre el bucket/prefijo de esta tarea.
- Credenciales no incluidas en Git, manifiestos, logs, salida de terminal o archivos de estado en claro.
- Almacenar credenciales localmente mediante un mecanismo apropiado al entorno; no pegarlas en el chat.
- No cambiar configuración, lifecycle, permisos o visibilidad del bucket sin registrar el estado previo y tener autorización.
- No activar Object Lock, reglas de borrado o políticas complejas por anticipación.
- No se exige implantar cifrado cliente adicional como criterio de aceptación del MVP, pero debe documentarse cualquier protección provista por la plataforma y los límites de acceso.

## 10. Hallazgos y estado inicial · ciclo de apertura 2026-10-31

### 10.1 Fuentes adquiridas

- OEP `frentes/ep/OEP.md`, v0.3.18 / VCU-EP-v20, rama declarada `docs/metacanon-objetos-20261011`; blob Git `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`. Los §§23–26 describen continuidad remota, registro local y libro mayor remoto. No se identificó en esos bloques una decisión de Backblaze como proveedor canónico.
- Metacanon `METACANON-OBJETOS-CANONICOS.md`, 1.5 / METACANON-OBJETOS-v1.5, blob `32c7a65ff2e83b3b76752ba2160427bd6e851a8f`, rama documental indicada. Aplican adquisición verificable, delta, documentación por ciclo y molde de tareas/objetos según ámbito.
- Registro provisional en `main`: `frentes/ep/📁 🧭 - Tareas provisionales/README.md`, blob previo `8ec4d4c1bdc597bac1b8561564df288bdedcff77`.
- NCL existente `EP-TASK-001`, blob previo `3b6a3c836b32cb9afa697c79c09542597b367683`; registra arquitectura y pendientes de navegador. Se incorpora regla documental común de ciclo a ciclo sin alterar alcance ni pruebas NCL.
- Documentación oficial de Backblaze B2 Sync, guía actualizada 2024-12-16: https://help.backblaze.com/hc/en-us/articles/226937867-How-do-I-use-the-b2-sync-command
- Documentación oficial de lifecycle y versiones: https://www.backblaze.com/docs/en/cloud-storage-lifecycle-rules
- Guía CLI oficial B2: https://github.com/Backblaze/B2_Command_Line_Tool
- Backend B2 de rclone: https://rclone.org/b2/

### 10.2 Hallazgos técnicos documentales

- Backblaze documenta `b2 sync` en ambos sentidos entre ruta local y prefijo B2, y admite `--delete`; el borrado requiere exclusión deliberada del MVP para evitar propagación accidental. La guía describe comparación por defecto basada en nombre/tiempo de modificación, con alternativas; por tanto el MVP no debe usar fecha/tamaño como única prueba de integridad.
- Backblaze B2 conserva por defecto versiones anteriores de objetos; las Lifecycle Rules pueden ocultarlas y borrarlas. La regla real del bucket debe inspeccionarse antes de habilitar sincronización; no asumir que se conserva todo indefinidamente si el bucket tiene reglas personalizadas.
- rclone documenta soporte del backend B2 y verificación de SHA-1 para transferencias compatibles. Se conserva como alternativa candidata, no como selección ya aprobada.
- La continuidad de OEP ya tiene un modelo de libro mayor remoto; la nueva tarea debe reutilizar lo existente donde corresponda y mantener la separación entre datos de usuario/archivos y estado de gobierno/autorización.
- NCL no es dependencia para respaldar archivos portables ordinarios. Sí podría ser una dependencia de una fase futura que requiera interactuar con estado web autenticado.

### 10.3 Estado de entorno y credenciales

**NO VERIFICADO en este ciclo:** existencia actual de CLI `b2` o `rclone` en el equipo; cuenta Backblaze; bucket/prefijo; variables de entorno; validez/alcance de credenciales; volumen de datos; rutas y portabilidad real de aplicaciones; adaptador de subida; sincronización automática; restauración desde B2; disponibilidad de un segundo host/ubicación.

Un antecedente conversacional previo mencionó variables B2 ya configuradas, pero no se ha revalidado la fuente ni su validez. No tratarlo como hecho operativo.

**No ejecutado:** no se llamó a Backblaze, no se inspeccionaron valores secretos, no se instaló CLI, no se creó bucket, no se subió/descargó archivo, no se modificó entorno ni dato de usuario y no se probó restauración.

## 11. Plan de trabajo por hitos

1. **Inventario y auditoría no destructiva:** localizar los datos de usuario, CLI y configuración B2 existente; confirmar privacidad y alcance sin revelar credenciales.
2. **Diseño de mapping:** definir IDs lógicos, fuentes elegibles, exclusiones y rutas de restauración para cada aplicación.
3. **Prueba B2 aislada:** prefijo de prueba con dataset sintético/no sensible, upload, read-back, checksum, versionado y recuperación.
4. **Motor inicial:** automatizar snapshot, manifiesto, sincronización incremental, cola offline, recibos y detección de conflictos.
5. **Integración con aplicaciones portables:** activar primero una aplicación no crítica, después grupos de aplicaciones conforme a resultados.
6. **Restauración entre ubicaciones:** instalar/reutilizar el motor en un segundo entorno, restaurar sin sobreescribir datos y verificar apertura de aplicación y valores de usuario.
7. **Automatización de ciclo:** arranque, detección de cambios, sincronización periódica o por eventos, salida limpia, recuperación tras interrupción y resolución de conflictos.
8. **Aceptación extremo a extremo:** probar continuidad completa, fallos de red, cambio de ubicación, corrupción controlada, rollback y reanudación automática.
9. **Cierre documental:** registrar comandos, versiones, configuración no sensible, inventario final, hashes, pruebas, límites, restaurador y arquitectura real en EP.

No fijar plazos ni ciclos de cierre hasta conocer inventario, volumen, estado de las credenciales y disponibilidad del segundo entorno.

## 12. Criterios de aceptación

| ID | Criterio |
|---|---|
| B2-01 | CLI y versión elegidas verificadas, con una sola herramienta instalada/reutilizada según necesidad |
| B2-02 | Cuenta, bucket y permisos mínimos confirmados sin exponer secretos |
| B2-03 | Inventario completo de datos elegibles y excluidos, asociado a rutas lógicas |
| B2-04 | Snapshot consistente de cada aplicación incluida |
| B2-05 | Primer upload a prefijo aislado sin borrado de objetos |
| B2-06 | Manifiesto local/remoto y verificación de integridad reproducibles |
| B2-07 | Cambios incrementales idempotentes; sin retransferir datos sin cambio |
| B2-08 | Interrupción de red y reanudación sin pérdida ni falso estado de sincronizado |
| B2-09 | Versiones anteriores recuperables; lifecycle real inspeccionado y compatible |
| B2-10 | Conflictos entre dos ubicaciones detectados y preservados sin sobrescritura silenciosa |
| B2-11 | Estado offline persistente hasta confirmar upload remoto |
| B2-12 | Restauración completa desde B2 en una segunda ubicación |
| B2-13 | Hashes y conteos coincidentes después de restaurar |
| B2-14 | Aplicaciones seleccionadas abren y conservan el estado de usuario recuperado |
| B2-15 | Cierre/reinicio/reinstanciación no requieren intervención manual ordinaria |
| B2-16 | Fallos de B2/CLI se muestran claramente y no destruyen el último estado válido |
| B2-17 | El mecanismo no interfiere con Git, OEP, OCP MCP ni libro mayor remoto existente |
| B2-18 | Documentación y recibos permiten repetir una restauración desde otra conversación/ubicación |

La tarea no se completa con una subida exitosa: debe demostrar restauración en una segunda ubicación y continuidad funcional.

## 13. Riesgos y bloqueos potenciales

- **Credenciales no válidas o inexistentes:** bloquea transferencias, no el inventario ni el diseño independiente.
- **Cuenta/bucket desconocidos o permisos insuficientes:** requiere autorización/corrección de cuenta; no crear recursos ni ampliar permisos por inferencia.
- **Aplicaciones con archivos abiertos o bases activas:** bloquea snapshot directo; identificar mecanismo consistente.
- **Dos ubicaciones modificando el mismo conjunto simultáneamente:** requiere exclusión o conflicto; sin ello no puede prometerse sync bidireccional automático confiable.
- **Perfil de navegador/sesiones autenticadas:** queda fuera del backup genérico hasta validación NCL y autorización específica.
- **Lifecycle con eliminación de versiones:** puede reducir recuperación; no modificar sin autorización, pero tratar como P0 del alcance si afecta la restauración.
- **Falta de segundo host:** impide demostrar el criterio de continuidad entre ubicaciones, aunque permite completar inventario, pruebas sintéticas y motor local.
- **Cambios del OEP o del metacanon:** adquirirlos por ciclo y calcular delta antes de actuar; la tarea sigue siendo provisional.

## 14. Regla de documentación acumulativa por ciclo

Este objeto es la fuente única de estado y crónica de EP-TASK-002. Cada ciclo sustantivo agregará al final de este README una sección numerada y fechada, sin sobrescribir secciones previas, con:

- Fuentes adquiridas (URL/ruta, rama, revisión/commit/blob SHA y frescura).
- Objetivo del ciclo y estado previo.
- Hallazgos nuevos, separados por observados/reportados/inferidos.
- Decisiones adoptadas y fuente de autorización.
- Trabajo efectivamente realizado (o NO-OP), archivos/recursos afectados y comandos resumidos no sensibles.
- Evidencia conservable: recibos, manifiestos, conteos, tamaños, SHA-256, read-back y resultados.
- Pruebas previstas, ejecutadas, fallidas, bloqueadas o pendientes.
- Cambios en viabilidad y ruta crítica.
- Pendientes, causa exacta, siguiente acción.
- Estimación del siguiente hito y del cierre solo con muestras suficientes; si no, NO ESTIMABLE con razones.

Si un ciclo no produce cambios, registrar NO-OP y las fuentes cotejadas. No escribir valores de claves B2, tokens, passwords, cookies ni datos personales de usuario. Corregir una entrada histórica mediante nota de rectificación con procedencia; no reescribir silenciosamente la historia.

## 15. Control, permisos y estado de ejecución

La instrucción actual autoriza la creación y mantenimiento documental de esta tarea provisional. **No es autorización automática para**:
- inspeccionar, revelar o copiar valores de credenciales;
- autenticar una cuenta, modificar permisos, buckets, claves o lifecycle;
- instalar software o cambiar variables del host;
- transferir datos reales de usuario;
- sobrescribir/restaurar directorios de aplicaciones;
- sincronizar o borrar objetos;
- alterar OEP, arquitectura de producto, OCP MCP, repositorios de aplicación o despliegues.

Cada una de esas acciones deberá estar cubierta por las autorizaciones vigentes y el alcance concreto del ciclo. Las lecturas no sensibles pueden avanzar cuando exista acceso legítimo y se respeten las compuertas.

## 16. Cronología y avances

### Ciclo de apertura · 2026-10-31

**Estado:** definición documental y alcance inicial elaborados; no existe aún prueba de producto.

**Nuevo en este ciclo:** el operador precisa que la persistencia debe centrarse en datos de usuario de aplicaciones portables y otros artefactos que sostengan la sesión canónica entre ubicaciones; la prioridad es confiabilidad y automatización de extremo a extremo, no cifrado avanzado. Se confirma que la tarea debe producir una habilitación en la que la intervención del operador quede reducida a la activación/autorizaciones puntuales inevitables, con operación ordinaria automática.

**Cotejo del repositorio:** el objeto OEP v0.3.18 / VCU-EP-v20 ya define persistencia remota, materialización local efímera y libro mayor remoto; no nombra Backblaze como proveedor canónico. La nueva tarea queda como trabajo provisional subordinado, no como cambio de arquitectura aprobado. El registro provisional y NCL se encontraban en `main`; el OEP declara `docs/metacanon-objetos-20261011` como rama canónica del OEP. Este objeto sigue expresamente siendo un registro de tarea provisional y no una integración del OEP ni de ambas ramas.

**Hallazgo técnico externo:** la CLI oficial B2 ofrece `b2 sync` local↔bucket; la documentación de Backblaze señala que las actualizaciones de objetos pueden conservar versiones previas y que Lifecycle Rules controlan su retención. La documentación indica que la comparación por defecto de `b2 sync` usa nombre y hora de modificación, por lo que esta tarea exige manifiesto/hash independiente antes de aceptar integridad. rclone ofrece backend B2 y queda como alternativa a comparar.

**Dependencias:** NCL no hace falta para archivos ordinarios; su integración puede ser necesaria únicamente para datos web autenticados o perfil del navegador, que quedan excluidos por defecto. El trabajo prioritario de alojamiento de OCP MCP permanece separado y no se reordena automáticamente.

**Evidencia de este ciclo:** OEP blob `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`; Metacanon 1.5 blob `32c7a65ff2e83b3b76752ba2160427bd6e851a8f`; registro provisional previo `8ec4d4c1bdc597bac1b8561564df288bdedcff77`; NCL previo `3b6a3c836b32cb9afa697c79c09542597b367683`. Documentación oficial consultada: B2 Sync y Lifecycle Rules, enlaces en §10. Ningún archivo de usuario ni recurso B2 fue leído o modificado.

**Pendientes inmediatos:** auditar existencia/versión de CLI; comprobar presencia y origen de credenciales sin imprimirlas; confirmar bucket/prefijo y reglas actuales; inventariar aplicaciones y datos; determinar tamaño y frecuencia de cambios; definir segundo entorno de prueba.

**Viabilidad preliminar:** técnicamente plausible con una solución de sincronización de archivos y orquestador local; no está demostrada para este entorno ni para todas las aplicaciones. El principal condicionante no es NCL, sino identificar fuentes de datos coherentes, credenciales vigentes, conflictos y una restauración real en una segunda ubicación. No es responsable estimar tiempo o ciclos de cierre sin inventario.

**Siguiente acción propuesta:** realizar auditoría no destructiva del entorno B2/CLI y crear inventario inicial de datos candidatos, sin leer valores de secretos ni transferir datos reales.


### Ciclo de auditoría remota y diagnóstico local interrumpido · 2026-10-31

**Estado del ciclo:** PARCIALMENTE RESUELTO. Auditoría documental/remota de configuración y código terminada; inventario local invalidado por restricción de acceso; ninguna implementación ni transferencia realizada.

#### 16.1 Fuentes y revisiones adquiridas

- OEP: `SeryMente/metodologia`, rama `docs/metacanon-objetos-20261011`, v0.3.18 / VCU-EP-v20, blob `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`. Los §§23–26 sitúan la persistencia remota, continuidad Git y libro mayor EP. No se encontró decisión que declare Backblaze proveedor canónico.
- Metacanon: versión 1.5 / `METACANON-OBJETOS-v1.5`, misma rama documental, blob `32c7a65ff2e83b3b76752ba2160427bd6e851a8f`.
- DUG: Samantha v373 / NX-373m, `SeryMente/metodologia/main`, blob `cac4525de77d4f47a8a59c25201968ecf2056b90`.
- KHORA: `SeryMente/khora/main`, HEAD observado `4463009fdf8ebd7f5e6e0fd493dba93efa9868d6`.
- Frente Harmonia: `docs/frentes/harmonia/OBJETO-CANONICO.md`, blob `15b37bc71b4bedfa13785d9adfd3d88f8caf3704`, objeto v0.38, corte 2026-10-31.
- Código actual de rutas de audio en KHORA/main:
  - `khora-web/app/api/audio/route.ts`, blob `0711b9e720d3b3df50f3101f5e684adc78095cc9`.
  - `khora-web/lib/server/audio-mp3.ts`, blob `8c5250010556ec1ddcf7c78b6ac8402dd697e395`.
  - `khora-web/app/api/transcribir/archivo/route.ts`, blob `d4500d6ecf38ec9f4b380e0020c9bd1765202669`.
  - `khora-web/app/api/audio/importar/procesar/route.ts`, blob `02731043d98d18539e3aaac5d2ede3240deaff75`.
  - `khora-web/package.json`, blob `9d3124a7a0cbd231d7eb5451b541c501d2b407f5`.
- Estado de PR #346 de Harmonia: abierta, borrador, no fusionada; base `main`; head `feat/harmonia-cora-provisional-persistence-20261030`, SHA `4ef43b4dacb9d230c62f31fe09ee419c3d9d12ae`; actualización remota observada 2026-10-31T01:25:00Z. Su persistencia provisional Cora corresponde a telemetría estructural anonimizada y no equivale al respaldo general de datos de usuario pedido en EP-TASK-002.

#### 16.2 Hallazgos remotos observados

**Configuración Vercel:** mediante lectura de metadatos de variables del proyecto `khora-web` (team `victorhugotorresmendez-8991s-projects`, plan Hobby), usando `decrypt=false`, se observaron las siguientes entradas, sin recuperar ni divulgar valores:

| Variable | Tipo/visibilidad observada | Entorno | Última actualización observada (UTC) |
|---|---|---|---|
| `KHORA_B2_BUCKET_NAME` | sensitive / secret | production | 2026-10-31 17:58:21.973 |
| `KHORA_B2_BUCKET_ID` | sensitive / secret | production | 2026-10-31 17:58:19.289 |
| `KHORA_B2_APPLICATION_KEY` | sensitive / secret | production | 2026-10-31 17:58:16.410 |
| `KHORA_B2_KEY_ID` | sensitive / secret | production | 2026-10-31 17:56:28.378 |
| `KHORA_OBJECT_STORAGE` | sensitive / secret | production | 2026-10-20 18:47:29.721 |
| `BLOB_READ_WRITE_TOKEN` | encrypted | production, preview, development | 2026-07-29 17:40:56.832 |

La presencia de esas variables demuestra configuración declarada en Vercel, **no** que los valores sean válidos, estén vigentes, no estén vacíos, que el bucket responda o que la aplicación escriba en Backblaze. Los valores no fueron descifrados, copiados ni utilizados. No se llamó al API de Backblaze ni se consultó el contenido de ningún bucket.

**Código de producción:** las cuatro rutas de audio examinadas importan `@vercel/blob`; la búsqueda de los nombres `KHORA_B2_*` y de referencias directas a Backblaze en el código actual no encontró llamadas B2. Por tanto, el código consultado apunta a Vercel Blob y no acredita una ruta de escritura B2. Esto es consistente con el original de Harmonia `docs/frentes/harmonia/originales/ChatGPT-HARMONIA-20261030-1915.txt`, que reporta que el almacén `khora-audio` estaba suspendido por cuota, con 636 objetos y 1,010,497,194 bytes, mientras la ruta activa usaba Vercel Blob. Esa cifra es un **reporte histórico**, no una lectura actual del bucket ni un estado revalidado.

**Separación de proyectos:** PR #346 no es una solución de respaldo general. Su propósito es telemetría estructural anonimizada a Cora; no autoriza ni satisface el respaldo de archivos de usuario de aplicaciones portables. El contrato existente `khora-web/docs/observability-services.md`, blob `1311c77b623ad923703bc6313479711aeb21aeeb`, también diferencia observabilidad de frontera y almacenamiento durable de eventos; no debe duplicarse ni reemplazarse con B2.

#### 16.3 Inspección local: desviación procedimental y exclusión de resultados

Se inició una inspección de metadatos locales de solo lectura en un equipo que apareció conectado como PC10. **Después de esa inspección**, la adquisición del OCP vigente de Harmonia reveló en §7 una prohibición explícita sobre la raíz de perfil Windows utilizada: no consultar, leer, crear, mover, copiar ni borrar archivos bajo esa raíz, y no reutilizar copias anteriores. §44.2 registra también la instrucción del operador de asumir perdido el entorno local anterior y mantener esa restricción.

En consecuencia:

- La inspección se registra como **desviación procedimental**: se empezó antes de adquirir el OCP de Harmonia aplicable.
- No se leyeron contenidos de bases de datos, archivos de usuario, contraseñas, cookies, tokens ni secretos. No se escribió, movió, copió, subió ni borró archivo alguno.
- **Todos los resultados de esa inspección local quedan invalidados y excluidos como base de inventario, mapeo de respaldo, manifiesto, diseño de sincronización o selección de datos.** No reproducir sus rutas, tamaños ni listados en esta tarea.
- Se detuvo toda inspección local adicional. No volver a invocar acceso remoto para este alcance mientras el destino/raíz y la autoridad operativa no se resuelvan conforme al OCP.
- Cualquier futura inspección de entorno deberá comenzar desde cero, en una ubicación distinta a la raíz restringida, expresamente autorizada y cotejada con el OCP y el perfil operativo vigente. No asumir que PC10 reemplaza a PC-14 ni heredar identidades/ubicaciones históricas.

Esta constancia es correctiva y no convierte la lectura anterior en autorización retroactiva.

#### 16.4 Qué quedó demostrado y qué no

**Demostrado por fuentes remotas:** hay cuatro entradas de configuración B2 secretas en Vercel dirigidas a producción; el proyecto también tiene `BLOB_READ_WRITE_TOKEN`; el código actual de las cuatro rutas de audio usa Vercel Blob; la PR #346 de Harmonia sigue abierta en borrador y no equivale a persistencia general de aplicaciones portables.

**No verificado:** validez o no vacío de credenciales B2; acceso efectivo al bucket; nombre/ID del bucket descifrados; reglas lifecycle/versionado actuales; objetos existentes; tamaño y composición del almacenamiento B2; presencia de CLI en un host autorizado; rutas elegibles de aplicaciones portables; snapshot seguro; sincronización automática; restauración; segundo entorno y continuidad real entre ubicaciones.

**No ejecutado:** instalación de CLI; autenticación B2; consulta de buckets; cambios de permisos o lifecycle; creación de bucket/prefijo; subida, descarga o borrado de datos; cambios de variables Vercel; modificaciones de código, despliegues o fusiones.

#### 16.5 Decisiones y siguiente acción

1. No instalar `b2` ni `rclone` en el host anterior ni reutilizar resultados de esa inspección.
2. No descifrar credenciales Vercel para mostrarlas o transportarlas a un host. La existencia de las cuatro variables permite plantear una comprobación autenticada con salida saneada, pero antes hay que fijar quién autoriza el uso de la cuenta/proyecto, qué proceso puede consumirlas y qué entorno destino está permitido.
3. Continuar por la vía remota e independiente: cotejar contrato de almacenamiento, configuración B2 declarada, código que debería consumirla y documentación de recuperación, sin leer valores secretos ni modificar producción.
4. Para la persistencia general de datos de usuario, definir un inventario nuevo en un host/raíz expresamente autorizados. NCL no es una dependencia de archivos ordinarios; perfil de navegador y sesiones autenticadas siguen fuera de la inclusión por defecto.
5. No iniciar transferencias reales hasta que el mapeo de datos, snapshot coherente, conflictos y restauración estén definidos y aprobados.

**Viabilidad actualizada:** la reutilización de variables ya declaradas en Vercel es una vía plausible para evitar pedir credenciales al operador, pero todavía no demuestra que exista una integración funcional B2. La ruta de audio activa examinada permanece en Vercel Blob. El objetivo de persistencia entre ubicaciones continúa técnicamente plausible, pero su ejecución en el host queda bloqueada por la restricción de acceso descubierta y por la falta de un destino operativo autorizado. No es responsable estimar tiempo ni ciclos de cierre.

**Estado de cierre del ciclo:** auditoría remota parcial completada; auditoría local invalidada por desviación; cero cambios de producto o almacenamiento. La siguiente acción es resolver el destino de ejecución permitido y continuar la verificación remota no sensible de la configuración B2.


## 17. Coordinación central, respaldo del servidor OCP MCP y revisión del nuevo informe local · 2026-10-31 · 13:03 · America/Mexico_City

**Estado de cierre del ciclo:** DOCUMENTACIÓN ACTUALIZADA. Se incorpora al alcance provisional de EP-TASK-002 el respaldo recuperable del servidor OCP MCP dentro del Entorno Persistente. El informe de inventario local recibido fue analizado y sus resultados quedan excluidos por conflicto con la restricción vigente del frente Harmonia. No se ejecutó ninguna transferencia, instalación, modificación de configuración ni restauración.

### 17.1. Fuentes y controles cotejados

- Registro de tareas provisionales EP, `main`, blob `74aceb5fef4814011ebdd393a36e1191469ea328`: confirma que EP-TASK-001 y EP-TASK-002 ya existen y que la documentación acumulativa por ciclo aplica a ambas y a las tareas futuras de este contenedor.
- EP-TASK-001 — NCL, `main`, blob `82cf0b736601892b763e1b74346232140f21aba1`: conserva su regla específica de bitácora acumulativa en la sección 16. Su estado continúa `pendiente`; no hubo implementación ni pruebas NCL en este ciclo.
- OEP, `frentes/ep/OEP.md`, rama `docs/metacanon-objetos-20261011`, v0.3.18 / VCU-EP-v20, blob `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`. Se conserva como fuente del frente EP; no se modificó. El README del frente confirma que esta rama no está integrada en `main`.
- DUG, Samantha v373 / NX-373m, `main`, blob `cac4525de77d4f47a8a59c25201968ecf2056b90`.
- OCP Harmonia, `SeryMente/khora/main:docs/frentes/harmonia/OBJETO-CANONICO.md`, v0.38, blob `15b37bc71b4bedfa13785d9adfd3d88f8caf3704`; control de responsabilidad, generación 11, blob `80a0f7d4b4662c95e79d17c3c49d5f3db189ab1f`.
- OCP MCP, `frentes/mcp-metodologia/CONTROL-RESPONSABILIDAD.json`, `main`, generación 2, blob `4a4742a51f0517a1b152a9c04ac6c185de024389`. Su alcance autoriza al OCP MCP a construir, compilar, probar y empaquetar el servidor dentro de su propio frente y a reportar a coordinación central/EP; excluye instalarlo u operarlo en el host persistente EP y modificar configuración local de EP.
- Protocolo de coordinación del sprint OCP MCP, `frentes/mcp-metodologia/entregas/COORDINACION-SPRINT-OCP-MCP-v0.1.md`, `main`, blob leído `1cac3a438cc316b9bb98859ccebeced66410adc5`. Mantiene la separación entre construcción OCP MCP, integración/entorno EP y coordinación central.
- Base de `main` observada antes de esta escritura: commit `9728ebf600ed245cee43f9a1f82a147d046addbe`, fechado 2026-10-31T19:03:37Z. Ese commit ya había incorporado la crónica precedente de la sección 16; no se duplicó.

### 17.2. Instrucción del operador y ampliación del objetivo

El operador informó que ya instruyó al modelo EP para investigar persistencia de datos del Entorno Persistente y precisó que el almacenamiento remoto de ese entorno también será el destino del **respaldo del servidor OCP MCP**. Esa investigación de EP se encuentra EN EJECUCIÓN según el reporte del operador; no se atribuye a esta conversación haberla iniciado ni ejecutado.

Queda fijada para esta tarea la siguiente relación funcional:

- **OCP MCP construye el servidor**, genera sus entregables y reporta a EP los hitos, artefactos, manifiestos, hashes, pruebas y necesidades de restauración.
- **EP organiza el Entorno Persistente completo**, incluyendo la solución de almacenamiento y recuperación que alojará el respaldo del servidor OCP MCP, además de los datos de usuario de las aplicaciones portables.
- **Coordinación central** recibe y coteja los reportes de OCP MCP y EP, mantiene la continuidad de la tarea y conduce la integración y aceptación.
- El operador conserva la dirección general y la aceptación final.

Esta ampliación no transfiere titularidad ni cambia permisos de OCP o EP. El control OCP MCP generación 2 confirma la responsabilidad de construcción y sus exclusiones de host. La investigación de EP debe definir la solución de almacenamiento dentro de su ámbito autorizado; esta tarea provisional no modifica el OEP canónico.

### 17.3. Componentes candidatos del respaldo OCP MCP

El respaldo del servidor debe tratarse como un conjunto recuperable y verificable, no como una copia indiscriminada de una carpeta activa. Los siguientes elementos quedan como inventario candidato que OCP MCP y EP deben cotejar contra la implementación real:

1. **Artefacto de versión:** paquete ejecutable inmutable de la versión aceptada (inicialmente 0.1.0), manifiesto, entrypoint/argumentos declarados, arquitectura, versión del runtime, commit de origen y SHA-256 de cada componente.
2. **Datos persistentes:** backup SQLite coherente que incluya las tablas y registros necesarios para recuperar el estado aceptado. Debe generarse mediante mecanismo compatible con SQLite/WAL o cierre controlado; no copiar una base abierta como si fuera un archivo estático.
3. **Contenido asociado:** fuentes canónicas importadas, snapshots y demás objetos cuyo contenido resida fuera de la base, con manifiesto que permita comprobar referencias, conteos y hashes.
4. **Trazabilidad funcional:** eventos, recibos, telemetría y metadatos necesarios para reconstruir el estado operativo y verificar la cadena de integridad, según el esquema que finalmente entregue OCP MCP.
5. **Configuración no secreta:** versión de esquema, parámetros no sensibles, identificador lógico de instalación, versión de producto y datos suficientes para reinstanciar la integración con el harness Copilot en una ubicación nueva.
6. **Procedimiento de recuperación:** instrucciones reproducibles para restaurar el artefacto y los datos, validar integridad, reconciliar versión/esquema y volver a conectar el servidor mediante el harness propietario del ciclo de vida `stdio`.

**Exclusiones y cautelas:** no incluir tokens, claves de aplicación B2, contraseñas, cookies ni secretos. Las claves protegidas mediante DPAPI CurrentUser tampoco deben copiarse sin más ni considerarse automáticamente recuperables en otro equipo. El contrato OCP usa protección local DPAPI; por ello, la recuperación de contenido que dependa de esas claves exige un procedimiento de continuidad de clave expresamente definido y una prueba real de restauración en otra ubicación. No se da por resuelto ese punto ni se amplía aquí el requisito general de cifrado de EP. Backblaze conserva archivos y objetos; no mantiene vivo el proceso MCP. El proceso deberá reinstanciarse en el nuevo entorno mediante EP y el harness Copilot.

### 17.4. Análisis del informe de inspección local recibido

El reporte aportado por el operador indica que se consultó el equipo visible `PC10RCIF4EI4` y que la identidad Windows efectiva era `CENTRAL\\MantenimientoRCI`. El control vigente de Harmonia generación 11 vincula ese nombre de dispositivo al UUID exacto `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc` y registra el perfil asociado a la identidad `MantenimientoRCI`. El OCP Harmonia §7 prohíbe consultar, leer, escribir, mover, copiar o borrar archivos bajo la raíz de ese perfil; §44.2 conserva la restricción de pérdida asumida y no reutilización del entorno anterior.

Por consiguiente:

- La coincidencia de nombre de dispositivo, UUID registrado e identidad reportada vincula el informe con el ámbito restringido de Harmonia; el permiso RDC de ese dispositivo es específico a Harmonia y no elimina la prohibición de §7.
- El orden narrado sitúa la inspección local antes de adquirir el OCP Harmonia vigente. Se registra una nueva **desviación de secuencia de adquisición**: se inspeccionó primero y se cotejó la restricción después.
- Se reconoce que el ejecutor detuvo la inspección al consolidar los hallazgos. La detención evita que el alcance continúe, pero no valida retroactivamente las lecturas previas.
- **Se excluyen íntegramente los resultados locales de ese informe** como evidencia de inventario, selección de datos, rutas, tamaños, portabilidad, CLI disponible, variables locales, configuración o preparación de sincronización. No se reproducen aquí sus rutas, listados ni tamaños.
- No se considera demostrado que `b2` o `rclone` estén ausentes del entorno autorizado, ni que Backblaze no esté habilitado en otro host. Tampoco se concluye que las variables locales no existan.
- No se autoriza repetir la inspección bajo ese perfil ni reutilizar sus resultados. Una futura inspección solo podrá efectuarse en un destino distinto, previamente identificado por UUID y perfil y expresamente permitido por los controles aplicables.

### 17.5. Evidencia remota y límites de la información recibida

El reporte enumera búsquedas y consultas en GitHub, Khora, Vercel, documentación de Harmonia, almacenamiento de objetos y PR #346, pero el resumen recibido no adjunta sus resultados concretos, URLs por consulta, SHAs de cada artefacto ni salidas de lectura. Por tanto, no se incorporan como nuevos hechos verificados los resultados de esas acciones remotas.

La base documental previamente registrada en §16 permanece vigente como antecedente: existencia declarada de variables B2 sensibles en Vercel, uso de Vercel Blob en las rutas de audio examinadas y ausencia de evidencia de una escritura B2 efectiva en ese código. La presencia declarada de variables no prueba validez de credenciales ni acceso al bucket. No se ha demostrado una llamada efectiva a la API B2, upload, download, versionado, lifecycle, restauración ni continuidad entre ubicaciones.

### 17.6. Relación con NCL y otras tareas provisionales

El registro general ya establece la documentación acumulativa por ciclo para EP-TASK-001, EP-TASK-002 y futuras tareas provisionales. El README de NCL conserva esta regla en §16. En este ciclo se cotejó ese objeto, pero no hubo actividad técnica nueva de NCL; permanece `pendiente` y no se le atribuye ningún avance.

NCL sigue sin ser requisito para respaldar archivos ordinarios o los artefactos del servidor. Los perfiles completos de navegador, cookies y sesiones autenticadas continúan excluidos de la sincronización general hasta disponer de una vía autorizada, coherente y específicamente probada.

### 17.7. Estado, decisiones y siguiente acción

**Demostrado en esta revisión documental:** existencia del objeto EP-TASK-002 y del protocolo de crónica por ciclo; OEP vigente en rama separada; control Harmonia generación 11 y prohibición del perfil; control OCP MCP generación 2 con alcance de construcción y reporte a EP; instrucción expresa del operador para que EP investigue persistencia y aloje el respaldo del servidor OCP MCP.

**Reportado, pero no aceptado como evidencia local:** inspección del host PC10, identidad local y resultados de inventario. Sus resultados quedan excluidos por la restricción de Harmonia.

**No verificado:** acceso B2, bucket/prefijo, validez de credenciales, política de versiones/lifecycle, volumen de datos, selección definitiva de datasets, CLI disponible en un host permitido, snapshot consistente del servidor, continuidad de claves DPAPI, restore en segunda ubicación, sincronización automática y apertura funcional de aplicaciones.

**No ejecutado por esta coordinación:** llamadas a Backblaze; descifrado o uso de secretos Vercel; instalación de CLI; configuración de bucket; transferencias; modificación de datos locales; instalación/ejecución de OCP MCP en EP; restauración o pruebas entre ubicaciones.

**Siguiente acción:** recibir y analizar la respuesta de EP a la investigación de persistencia que el operador informó como activa; comprobar que su propuesta cubre expresamente el respaldo del artefacto y los datos persistentes de OCP MCP. En paralelo, OCP MCP debe entregar a EP el inventario real de componentes respaldables y el método de snapshot/restore cuando esos entregables existan. No se prepara una nueva solicitud redundante a EP mientras su investigación actual siga en ejecución. No estimar fecha de habilitación hasta conocer el proveedor, la ruta autorizada, el inventario real y el resultado de una restauración.

**Resultado del ciclo:** alcance funcional de EP-TASK-002 ampliado documentalmente para incluir el respaldo recuperable de OCP MCP; hallazgos locales excluidos; ningún producto o almacenamiento modificado; la implementación de persistencia continúa pendiente.

## 18. Cambio de modelo operativo OCP local, perfil Cibernet/Deep Freeze y objetivo de disponibilidad antes de las 15:00 · 2026-10-31 · 13:13 · America/Mexico_City

**Estado del ciclo:** DECISIÓN DE ALCANCE DOCUMENTADA; PLAN DE MVP Y BLOQUEOS IDENTIFICADOS. No se configuró Backblaze, no se instalaron componentes, no se realizó acceso local/RDC, no se recuperó ni ejecutó el servidor y no se realizó transferencia. El objetivo temporal expresado por el operador es disponer de una versión funcional del Entorno Persistente con Backblaze configurado antes de las 15:00 locales del 31-10-2026, para poder recuperar y abrir el MVP del servidor OCP MCP desde otra computadora el domingo 01-11-2026.

### 18.1. Instrucción del operador y resultado que persigue

El operador prioriza conseguir, antes de las 15:00 hora de `America/Mexico_City`, una primera materialización funcional de persistencia remota Backblaze para conservar artefactos y estado que ya deben sobrevivir a la pérdida de una sesión local. El primer conjunto de importancia es el **MVP del servidor OCP MCP de Metodología** y los datos mínimos que permitan reanudarlo en otro equipo. La meta no consiste en respaldar indiscriminadamente la computadora ni en copiar el perfil completo de Windows; consiste en un conjunto de artefactos seleccionados, identificados, íntegros, recuperables y vinculados a una versión verificable.

El operador solicita que el contenido de esta entrada y los próximos hallazgos sustantivos sobre persistencia queden incorporados en este objeto provisional o en el mínimo número de objetos necesarios. Se reutiliza `EP-TASK-002`; no se crea `EP-TASK-003`, `EP-TAGS-100002` ni una bitácora adicional. `EP-TASK-002` sigue siendo un identificador local de tarea, no un folio global.

### 18.2. Separación de dominios: OCP MCP local frente a Khora/Cora

El operador ratifica como dirección de arquitectura que el servidor MCP que atiende los objetos canónicos de persistencia (OCP) pertenece al dominio de Metodología y debe ejecutarse en un entorno **local**, accesible por `localhost` y/o administrado mediante una conexión RDC autorizada. No forma parte del MSP/MCP de la prótesis cognitiva Khora/Cora. En consecuencia, para arrancar, autenticar y operar la parte OCP del servidor **no se debe depender de bearer tokens de Cora, sesiones de Cora, endpoints de Vercel ni de la infraestructura de Khora**. Esta separación no modifica ni desactiva el MCP propio de Khora/Cora: son dos dominios y autorizaciones distintos.

La lectura canónica del OCP de Metodología conserva la denominación **MCP de Metodología / OCP MCP**. El dictado del operador usó también la forma «MSP»; por continuidad con la identidad documental existente, este ciclo lo interpreta como una referencia oral al servidor MCP de Metodología, sin crear un segundo producto ni reescribir el dictado histórico.

Backblaze B2 se considera aquí un **destino de persistencia y recuperación de archivos/artefactos**, no un host de ejecución del servidor, no un endpoint MCP y no una sustitución de Git como remoto de código. La operación del servidor sigue siendo local. Las variables B2 encontradas previamente en el proyecto Vercel de Khora no se consideran credenciales reutilizables para este ámbito: pertenecen a otro proyecto/dominio, sus valores no se leyeron y su funcionamiento nunca quedó demostrado. No se autoriza inferir, copiar o reutilizar secretos entre Khora y Metodología.

### 18.3. Reutilización del objeto y perfil de ubicación informado

Se reutiliza el perfil de ubicación que ya aparece en el OEP como candidato `LOC-LUIS-PASTEUR`; no se crea todavía otro OEP ni un perfil canónico paralelo. La descripción aportada por el operador en este ciclo es:

- **Ubicación/alias existente a cotejar:** `LOC-LUIS-PASTEUR`.
- **Establecimiento:** cibercafé Cibernet, avenida Luis Pasteur, Querétaro (dirección exacta no precisada en este ciclo).
- **Tipo de entorno reportado:** sesiones Windows efímeras protegidas por un mecanismo tipo Deep Freeze.
- **Identificador de equipo dictado:** el operador dijo inicialmente `CSEQ` y lo deletreó después `C-E-C-E-Q` (`CECEQ`). Se conserva la discrepancia de transcripción; `CECEQ` es la forma deletreada, no una identidad técnica verificada.
- **Etiqueta adicional reportada:** `I1`; su semántica exacta (instancia, estación, perfil u otra) queda `NO VERIFICADA`.
- **Perfil Windows interactivo, SID, UUID nativo RDC, versión de Windows, privilegios, Escritorio físico y disponibilidad efectiva de escritura:** `NO VERIFICADOS`.

El operador establece para este perfil una regla conservadora de continuidad: cuando aporte al modelo los datos de una **nueva sesión RDC** de ese equipo/ubicación, deberá asumirse que la sesión local anterior se reinició y que el trabajo materializado localmente pudo perderse por Deep Freeze. La nueva sesión se tratará como una materialización limpia; no se reutilizarán archivos, cachés, procesos ni estados locales de la sesión previa como si fueran persistentes. Este es un supuesto operativo declarado por el operador, no una prueba independiente del reinicio, del mecanismo Deep Freeze o del UUID de equipo.

### 18.4. Regla de materialización en la sesión Windows correcta

Cuando exista una conexión RDC expresamente autorizada para el dispositivo concreto y el destino no esté bajo ninguna raíz prohibida, el bootstrap deberá instalar/materializar lo mínimo necesario en la carpeta `EP` bajo el **Escritorio real del usuario Windows interactivo desde cuya sesión trabaja el operador**. No se debe asumir que el usuario del proceso RDC, el usuario del servicio/conector, `$env:USERPROFILE` del proceso remoto o la sesión técnica coinciden con el usuario interactivo. Antes de escribir, el launcher debe resolver y mostrar de forma saneada identidad Windows, SID, sesión interactiva, perfil y Known Folder Desktop; si no puede demostrar la correspondencia, aborta sin escribir.

El destino se resolverá dinámicamente para cada host/sesión; no se fijará una ruta absoluta heredada de otra computadora ni se confiará en `Environment.GetFolderPath('Desktop')` ejecutado bajo un token RDC que pueda pertenecer a otro usuario. La ruta física final se registra solo después de una observación autorizada y se asocia al perfil de ubicación, no se convierte en identidad del conjunto remoto.

El uso de RDC debe respetar el OEP §89: RDC es una capacidad exclusiva del asistente y solo se usa para una misión necesaria, acotada y autorizada. La autorización de un dispositivo por RDC no reemplaza las restricciones de acceso aplicables a sus perfiles y carpetas. En particular, la prohibición vigente de Harmonia sobre `C:\Users\MantenimientoRCI\` continúa intacta; ningún equipo/perfil podrá operarse bajo esa raíz ni reutilizar materializaciones previas situadas allí. La etiqueta aportada `CECEQ`/`CSEQ` no se ha reconciliado con el UUID de PC10 u otro dispositivo y no permite inferir que sea un equipo distinto o autorizado.

### 18.5. Conjunto MVP que debe persistir en Backblaze

El primer conjunto de respaldo se limita al servidor OCP MCP y sus datos recuperables, sujeto al manifiesto real que entregue el constructor:

1. Paquete versionado del servidor, con versión, commit de procedencia, runtime/arquitectura declarados, entrypoint, manifiesto de archivos y SHA-256 por componente.
2. Base SQLite y datos de aplicación mediante snapshot consistente (backup API/SQLite Backup o cierre controlado), incluyendo el tratamiento de WAL; nunca copiar una base activa como un archivo plano sin garantizar consistencia.
3. Contenido asociado y fuentes de datos realmente referenciadas por la base, con IDs lógicos, conteos, tamaños y hashes.
4. Configuración no secreta, versión de esquema, identificador lógico de instalación y parámetros mínimos para reinstanciar el servidor local y conectarlo al harness/cliente MCP.
5. Recibo de snapshot y transferencia, estado de verificación, hora UTC, versión/objeto remoto cuando esté disponible, y resultado de una prueba de descarga/restauración.
6. Runbook breve de bootstrap/restore para una segunda computadora: materializar en Desktop/EP de la sesión interactiva correcta, recuperar el snapshot autorizado, validar hashes/esquema, iniciar el servidor local por el transporte realmente implementado y probar una operación de lectura.

Quedan excluidos tokens, bearer tokens Cora, credenciales de Vercel, application keys B2, contraseñas, cookies, secretos, llaves privadas, volcados completos de perfiles del navegador y datos no identificados. Los secretos necesarios para B2 deberán inyectarse por un mecanismo de credenciales separado y protegido; nunca se guardarán en Git, manifiestos, logs, objetos de conversación ni en el paquete de respaldo general. No copiar claves DPAPI `CurrentUser` como si fueran portables a otro SID/equipo.

### 18.6. Configuración Backblaze y criterio mínimo de seguridad

El bucket/prefijo concreto para este conjunto, su titularidad, estado, permisos, retención/versionado y credencial dedicada todavía están `NO VERIFICADOS`. El MVP debe utilizar un bucket privado existente expresamente autorizado o un bucket nuevo privado dedicado a EP/OCP; antes de seleccionar uno se verifica cuenta, bucket, región, lifecycle y permisos mínimos. No usar automáticamente el bucket histórico `khora-audio`, las variables B2 de Vercel/Khora ni el token `BLOB_READ_WRITE_TOKEN`.

La primera prueba debe ser no destructiva, con artefacto sintético o paquete no sensible, en prefijo dedicado: autorización B2, listado del destino, upload, lectura/listado de vuelta, descarga, SHA-256 y comparación byte a byte; después, snapshot real mínimo. `--delete`, borrado remoto, sincronización bidireccional automática, Object Lock, reglas lifecycle destructivas y modificación de políticas se excluyen del MVP de hoy. La ausencia de confirmación de upload o hash coincidente significa `NO SINCRONIZADO`, nunca éxito parcial.

### 18.7. Fuentes y evidencia adquiridas en este ciclo

- DUG: `SeryMente/metodologia/main:gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, Samantha v373 / NX-373m, blob `cac4525de77d4f47a8a59c25201968ecf2056b90`.
- OEP: `frentes/ep/OEP.md`, v0.3.18 / VCU-EP-v20, rama canónica documental `docs/metacanon-objetos-20261011`, blob `e1e045cdc9b1a286047c6d47c47a5111a0b52bce`. Su §4 ya contiene `LOC-LUIS-PASTEUR`; §5/§21 requieren descubrir el Escritorio dinámicamente; §73 fija la custodia del frente; §89 reserva RDC al asistente y exige adquisición/autorización verificables. No se modificó OEP.
- `EP-TASK-002` antes de este ciclo: `main`, blob `e0dbc2212cea7d1dd95af75ca87a700e2d99a61e`; sección 17 ya registraba el alcance de respaldo OCP MCP y la exclusión de resultados locales.
- `frentes/mcp-metodologia/MCP-METODOLOGIA.md`: `main`, blob `0dd9c4a7594833f99cb658e6108c8439464babd8`; identidad separada, transporte local aún por decidir en el texto base y no se declara servidor implementado en esa fuente.
- `frentes/mcp-metodologia/CONTROL-RESPONSABILIDAD.json`: `main`, generación 2, blob `4a4742a51f0517a1b152a9c04ac6c185de024389`; autoriza construcción/compilación/pruebas/paquete en `frentes/mcp-metodologia/`, pero excluye instalación/operación y configuración del host EP.
- Protocolo `COORDINACION-SPRINT-OCP-MCP-v0.1.md`, `main`, blob `1cac3a438cc316b9bb98859ccebeced66410adc5`; confirma la separación entre construcción OCP MCP y alojamiento/integración EP, la mediación de coordinación y la distinción entre prompt preparado, reenviado y recibido.
- Repositorio `SeryMente/metodologia/main`: HEAD adquirido `9d8a72c51bef93ecdd4a643c75441b9d2bf17f3e`, committer date `2026-10-31T19:06:43Z` (13:06:43 `America/Mexico_City`).
- Rama de construcción `build/ocp-mcp-mvp-0.1.0`: HEAD `e4243414b0099ede9b9556b3cfa0bb20bc706576`. El árbol consultado bajo `frentes/mcp-metodologia/` contiene el núcleo/control/documentos de coordinación y evidencias, pero ningún archivo de código/solución/paquete con extensiones de implementación consultadas (`.cs`, `.csproj`, `.sln`, `.json` ejecutable de artefacto, `.ps1`, `.ts`, `.js`, `.zip`, etc.). Esto demuestra únicamente que el árbol remoto de esa rama, en la ruta del frente, aún no expone un artefacto de implementación; no descarta un trabajo local no publicado o una entrega posterior.
- OCP Harmonia `SeryMente/khora/main:docs/frentes/harmonia/OBJETO-CANONICO.md`, blob `15b37bc71b4bedfa13785d9adfd3d88f8caf3704`, §7 y §44.2; control generación 11, blob `80a0f7d4b4662c95e79d17c3c49d5f3db189ab1f`. La restricción de raíz y la no reutilización del entorno previo siguen aplicando; el perfil/UUID `CECEQ` aún no se ha cotejado con dichos controles.

### 18.8. Estado verificado, reportado y no ejecutado

**Decisión/reportado por el operador:** meta de tener persistencia configurada antes de las 15:00 locales del 31-10-2026; apertura del MVP el domingo desde otra computadora; separación de dominio OCP local frente a Khora/Cora; no requerir bearer tokens Cora para esta operación; perfil temporal de cibercafé Cibernet/Avenida Luis Pasteur, sesiones tipo Deep Freeze; convención de considerar perdida la materialización local al aportar una nueva sesión RDC; materializar únicamente en Desktop del usuario interactivo de la sesión desde la que trabaja.

**Verificado en fuentes:** existe el perfil nominal `LOC-LUIS-PASTEUR` en el OEP; el OCP MCP tiene identidad y control separados; el control generación 2 autoriza construcción del artefacto pero no instalación/operación en el host EP; la rama remota de construcción observada todavía no contiene archivos de implementación en la ruta del frente; el OEP exige adquisición y autorización y reserva RDC al asistente.

**No verificado:** que `CECEQ`/`CSEQ` corresponda a un UUID RDC; qué significa `I1`; qué cuenta Windows interactiva se utiliza en Cibernet; si el dispositivo está autorizado y en línea; la ruta exacta de Desktop; si la sesión está elevada; efecto real de Deep Freeze; CLI B2 disponible; cuenta, bucket y prefijo B2; credencial válida; ACL/permisos; existencia de servidor ejecutable; esquema/DB real; snapshot consistente; upload, descarga y restauración; segunda computadora de destino.

**No ejecutado:** ninguna consulta al host CSEQ/CECEQ; ninguna operación RDC en esta sesión; ninguna lectura/escritura local; ninguna instalación; ninguna llamada a Backblaze; ningún descifrado/uso de secretos; ningún cambio Vercel; ninguna subida, borrado o modificación de bucket; ninguna ejecución/integración del servidor MCP.

### 18.9. Plan de trabajo priorizado para la ventana antes de las 15:00

El plazo restante no autoriza a omitir controles. La secuencia con mayor probabilidad de producir una entrega útil es:

1. **Gate de host y sesión (bloqueante):** identificar de forma inequívoca UUID RDC, nombre de dispositivo, identidad/SID Windows interactivo, perfil y Desktop real de Cibernet; cotejar el host contra la raíz prohibida de Harmonia y demás controles. Si coincide con la raíz prohibida, detener toda operación local. No reutilizar los resultados inválidos de la auditoría anterior.
2. **Gate de artefacto OCP MCP (bloqueante):** recibir el paquete 0.1.0 y su manifiesto/DB/contrato del constructor, o verificar una rama que ya los contenga. El árbol remoto revisado no expone todavía el código ni el paquete; hasta que llegue, no existe evidencia suficiente para respaldar el servidor como producto funcional.
3. **Gate de cuenta B2 (bloqueante):** disponer de acceso autorizado al account/key de Backblaze con permisos mínimos, sin pegar secretos en el chat. Seleccionar o crear de forma expresa un bucket privado y prefijo exclusivo EP/OCP; no utilizar credenciales ni recursos de Khora/Vercel.
4. **Prueba B2 mínima:** cargar un archivo de prueba no sensible, enumerar/listar, descargar y comparar SHA-256; conservar recibo. No ejecutar sincronización con `--delete` ni mover el dataset real antes del pase de esta prueba.
5. **Primer backup OCP:** generar snapshot coherente, paquete y manifiesto SHA-256; subir al prefijo aprobado; descargar a una ubicación de staging distinta y cotejar integridad. Marcar `RESPALDADO` únicamente después de leer de vuelta y verificar.
6. **Runbook de mañana:** dejar una instrucción reproducible de bootstrap/restore que detecte el Escritorio de la sesión interactiva, reconstruya localmente el runtime efímero, recupere el último snapshot confirmado, valide integridad y arranque el servicio mediante el transporte probado (stdio o localhost-loopback, según la implementación real).

**Criterio de corte a las 15:00:** si cualquiera de los gates 1–3 no está satisfecho, cerrar con documentación y un artefacto/runbook preparado, declarando explícitamente `MVP NO OPERATIVO / BACKUP NO VERIFICADO`; no crear una falsa versión funcional. Si se satisfacen, aceptar solo el resultado demostrado: CLI lista, acceso mínimo B2 confirmado, upload y download con SHA coincidente, artefacto/DB consistentes y arranque local con una prueba funcional. La recuperación en una segunda computadora seguirá `PENDIENTE` hasta ejecutarse realmente allí el domingo.

### 18.10. Próxima acción y cierre del ciclo

La siguiente acción documental es sincronizar esta especificación con la respuesta real del constructor OCP MCP sin duplicar solicitudes ni saltarse la regla serial del protocolo: primero determinar si ya existe una entrega o solicitud pendiente; después recibir el manifiesto/paquete 0.1.0 y sus instrucciones de snapshot/restore. En EP, mantener la tarea concentrada en la identificación del perfil autorizado y la preparación del flujo de B2. No cambiar OEP canónico, control de responsabilidad, DUG ni la arquitectura de Khora/Cora en este ciclo.

**Resultado:** la decisión de separación de dominios y el perfil provisional Cibernet/Deep Freeze quedan preservados en EP-TASK-002; el MVP de persistencia sigue sin estar configurado ni probado. No se ha prometido la disponibilidad antes de las 15:00 porque tres prerrequisitos materiales siguen sin evidencia.

### 18.11. Rectificación de identidad operativa Windows — aclaración directa del operador · 2026-10-31 · 13:15 · America/Mexico_City

El operador aclara expresamente: «Ignora a RCI, osea, es el usuario de la conexion, pero par atodo es como si fila4». Para interpretar el perfil de trabajo de esta operación, `RCI` se trata como la identidad técnica/de conexión y el contexto operativo del usuario se asocia a `fila4`. Esta aclaración rectifica la lectura anterior que podía tomar `CENTRAL\MantenimientoRCI` como si fuese el usuario interactivo del operador.

**Aplicación:** el destino deseado de la materialización es el Escritorio del contexto operativo `fila4`, no el Escritorio del usuario técnico de la conexión. En el bootstrap se separarán tres campos: (a) cuenta técnica del proceso/conector RDC; (b) usuario y sesión interactivos del operador (`fila4`, conforme a la aclaración); (c) ruta física/Known Folder Desktop obtenida y verificada en el host de destino.

**Límite que no cambia:** la prohibición de Harmonia §7 y §44.2 sobre `C:\Users\MantenimientoRCI\` permanece íntegra. La aclaración de que RCI es usuario de conexión no autoriza a leer, escribir, enumerar, mover, copiar ni borrar nada bajo esa raíz; tampoco valida ni rehabilita las inspecciones locales anteriores, que continúan excluidas. No se utilizarán `$env:USERPROFILE`, `Environment.GetFolderPath('Desktop')` ni rutas derivadas del contexto técnico RDC como sustituto del Escritorio interactivo.

**Verificación pendiente:** la equivalencia operativa declarada por el operador no aporta por sí sola SID, sesión interactiva, Known Folder Desktop, UUID RDC ni asociación entre `CECEQ`/`CSEQ`, `I1` y una estación específica de Cibernet. La identificación del destino concreto debe cotejarse por un procedimiento permitido, sin explorar archivos para adivinar identidad y sin entrar en la raíz prohibida. Hasta entonces, `fila4` es el perfil operativo declarado para diseñar el bootstrap, pero la ruta física final queda `NO VERIFICADA` y no se ejecuta escritura.

**Efecto sobre el plan:** el gate de host se redefine como «vincular conexión técnica RCI → sesión interactiva fila4 → Desktop efectivo de fila4 → dispositivo RDC exacto». No se elimina el gate ni se considera satisfecha la comprobación física del destino. La entrega antes de las 15:00 sigue condicionada a los gates de host, artefacto OCP MCP y acceso B2 descritos en §18.9; no se concede por esta aclaración ningún permiso adicional sobre el host ni sobre recursos de Khora/Vercel.
