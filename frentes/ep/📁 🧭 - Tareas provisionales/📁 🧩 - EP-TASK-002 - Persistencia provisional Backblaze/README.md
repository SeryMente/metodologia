# 📝 EP-TASK-002 · Persistencia provisional con Backblaze B2 para datos de usuario y continuidad de la sesión canónica

**Naturaleza:** tarea provisional del frente Entorno Persistente; materialización auxiliar del registro de tareas, no un OEP nuevo, no un frente independiente y no una decisión de arquitectura canónica.  
**Estado:** `en_curso` — definición documental e inventario inicial; implementación técnica NO INICIADA.  
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
