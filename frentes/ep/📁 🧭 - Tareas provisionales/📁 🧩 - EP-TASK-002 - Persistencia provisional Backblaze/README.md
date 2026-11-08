# 📝 EP-TASK-002 · Persistencia provisional con Backblaze B2 para datos de usuario y continuidad de la sesión canónica

**Naturaleza:** tarea provisional del frente Entorno Persistente; materialización auxiliar del registro de tareas, no un OEP nuevo, no un frente independiente y no una decisión de arquitectura canónica.  
**Estado:** `en_curso` — Master Application Key existente cotejada con las entradas cifradas de la bóveda (sin reescritura); descifrado de cuatro entradas, ACL, respaldo y limpieza de portapapeles PASS; autenticación Master B2 PASS con caché aislada; GET de `OCP-MCP` PASS; prueba sintética de 126 bytes con upload/download/read-back SHA-256 y SSE-B2/AES256 PASS. La compuerta de segundo equipo físico de §45 queda supersedida por la instrucción del operador del 2026-11-07: no es requisito para finalizar EP. La sincronización automatizada de datos de usuario, la recuperación por perfil, idempotencia, interrupción/reanudación y aceptación del consumidor siguen pendientes.
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
- **Identificador de equipo dictado:** `CECEQ`. Esta es la única denominación textual válida en la crónica; la correspondencia con el hostname técnico y el UUID RDC requiere evidencia independiente.
- **Etiqueta adicional reportada:** `I1`; su semántica exacta (instancia, estación, perfil u otra) queda `NO VERIFICADA`.
- **Perfil Windows interactivo, SID, UUID nativo RDC, versión de Windows, privilegios, Escritorio físico y disponibilidad efectiva de escritura:** `NO VERIFICADOS`.

El operador establece para este perfil una regla conservadora de continuidad: cuando aporte al modelo los datos de una **nueva sesión RDC** de ese equipo/ubicación, deberá asumirse que la sesión local anterior se reinició y que el trabajo materializado localmente pudo perderse por Deep Freeze. La nueva sesión se tratará como una materialización limpia; no se reutilizarán archivos, cachés, procesos ni estados locales de la sesión previa como si fueran persistentes. Este es un supuesto operativo declarado por el operador, no una prueba independiente del reinicio, del mecanismo Deep Freeze o del UUID de equipo.

### 18.4. Regla de materialización en la sesión Windows correcta

Cuando exista una conexión RDC expresamente autorizada para el dispositivo concreto y el destino no esté bajo ninguna raíz prohibida, el bootstrap deberá instalar/materializar lo mínimo necesario en la carpeta raíz `Ser y Mente` bajo el **Escritorio real del usuario Windows interactivo desde cuya sesión trabaja el operador**. No se debe asumir que el usuario del proceso RDC, el usuario del servicio/conector, `$env:USERPROFILE` del proceso remoto o la sesión técnica coinciden con el usuario interactivo. Antes de escribir, el launcher debe resolver y mostrar de forma saneada identidad Windows, SID, sesión interactiva, perfil y Known Folder Desktop; si no puede demostrar la correspondencia, aborta sin escribir.

El destino se resolverá dinámicamente para cada host/sesión; no se fijará una ruta absoluta heredada de otra computadora ni se confiará en `Environment.GetFolderPath('Desktop')` ejecutado bajo un token RDC que pueda pertenecer a otro usuario. La ruta física final se registra solo después de una observación autorizada y se asocia al perfil de ubicación, no se convierte en identidad del conjunto remoto.

El uso de RDC debe respetar el OEP §89: RDC es una capacidad exclusiva del asistente y solo se usa para una misión necesaria, acotada y autorizada. La autorización de un dispositivo por RDC no reemplaza las restricciones de acceso aplicables a sus perfiles y carpetas. En particular, la prohibición vigente de Harmonia sobre `C:\Users\MantenimientoRCI\` continúa intacta; ningún equipo/perfil podrá operarse bajo esa raíz ni reutilizar materializaciones previas situadas allí. La etiqueta aportada `CECEQ` no se ha reconciliado con el UUID de PC10 u otro dispositivo y no permite inferir que sea un equipo distinto o autorizado.

### 18.5. Conjunto MVP que debe persistir en Backblaze

El primer conjunto de respaldo se limita al servidor OCP MCP y sus datos recuperables, sujeto al manifiesto real que entregue el constructor:

1. Paquete versionado del servidor, con versión, commit de procedencia, runtime/arquitectura declarados, entrypoint, manifiesto de archivos y SHA-256 por componente.
2. Base SQLite y datos de aplicación mediante snapshot consistente (backup API/SQLite Backup o cierre controlado), incluyendo el tratamiento de WAL; nunca copiar una base activa como un archivo plano sin garantizar consistencia.
3. Contenido asociado y fuentes de datos realmente referenciadas por la base, con IDs lógicos, conteos, tamaños y hashes.
4. Configuración no secreta, versión de esquema, identificador lógico de instalación y parámetros mínimos para reinstanciar el servidor local y conectarlo al harness/cliente MCP.
5. Recibo de snapshot y transferencia, estado de verificación, hora UTC, versión/objeto remoto cuando esté disponible, y resultado de una prueba de descarga/restauración.
6. Runbook breve de bootstrap/restore para una segunda computadora: materializar en Desktop/Ser y Mente de la sesión interactiva correcta, recuperar el snapshot autorizado, validar hashes/esquema, iniciar el servidor local por el transporte realmente implementado y probar una operación de lectura.

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

**No verificado:** que `CECEQ` corresponda a un UUID RDC; qué significa `I1`; qué cuenta Windows interactiva se utiliza en Cibernet; si el dispositivo está autorizado y en línea; la ruta exacta de Desktop; si la sesión está elevada; efecto real de Deep Freeze; CLI B2 disponible; cuenta, bucket y prefijo B2; credencial válida; ACL/permisos; existencia de servidor ejecutable; esquema/DB real; snapshot consistente; upload, descarga y restauración; segunda computadora de destino.

**No ejecutado:** ninguna consulta al host CECEQ; ninguna operación RDC en esta sesión; ninguna lectura/escritura local; ninguna instalación; ninguna llamada a Backblaze; ningún descifrado/uso de secretos; ningún cambio Vercel; ninguna subida, borrado o modificación de bucket; ninguna ejecución/integración del servidor MCP.

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

**Verificación pendiente:** la equivalencia operativa declarada por el operador no aporta por sí sola SID, sesión interactiva, Known Folder Desktop, UUID RDC ni asociación entre `CECEQ`, `I1` y una estación específica de Cibernet. La identificación del destino concreto debe cotejarse por un procedimiento permitido, sin explorar archivos para adivinar identidad y sin entrar en la raíz prohibida. Hasta entonces, `fila4` es el perfil operativo declarado para diseñar el bootstrap, pero la ruta física final queda `NO VERIFICADA` y no se ejecuta escritura.

**Efecto sobre el plan:** el gate de host se redefine como «vincular conexión técnica RCI → sesión interactiva fila4 → Desktop efectivo de fila4 → dispositivo RDC exacto». No se elimina el gate ni se considera satisfecha la comprobación física del destino. La entrega antes de las 15:00 sigue condicionada a los gates de host, artefacto OCP MCP y acceso B2 descritos en §18.9; no se concede por esta aclaración ningún permiso adicional sobre el host ni sobre recursos de Khora/Vercel.

### 18.12. Rectificación adicional del modelo de elevación y destino Windows — corrección expresa del operador

El operador corrige la interpretación consignada en §18.11: `MantenimientoRCI` es la **cuenta de conexión/elevación**; para la operación del usuario debe tratarse el entorno como `fila4`. La instrucción expresa es que los archivos se escriban, las instalaciones se materialicen y las operaciones de trabajo se dirijan al entorno de `fila4`; `MantenimientoRCI` se utiliza como cuenta de elevación cuando la operación lo requiera, no como perfil de destino ni como propietario de los artefactos.

**Modelo de identidad operativo rectificado:**

1. **Identidad técnica de conexión/elevación:** `MantenimientoRCI` / `RCI`. Su función es proporcionar el contexto de conexión o privilegios elevados cuando proceda.
2. **Usuario/perfil de trabajo y destino de archivos:** `fila4`. Los repositorios de trabajo, runtimes, paquetes, manifiestos, logs y datos locales que deban materializarse para el operador pertenecen a este perfil y deben quedar en sus ubicaciones expresamente resueltas.
3. **Separación obligatoria de rutas:** ninguna instalación, salida temporal, transcripción, caché, log, staging o artefacto de trabajo debe terminar bajo `C:\Users\MantenimientoRCI\`. Cuando una operación elevada necesite escribir, deberá hacerlo mediante una ruta explícita permitida del entorno `fila4`; no se permitirá que el directorio actual, `%USERPROFILE%`, `$env:USERPROFILE`, rutas temporales por defecto o el perfil del proceso elevado desvíen la salida hacia el perfil RCI.

Esta instrucción **resuelve la ambigüedad semántica** entre cuenta de elevación y perfil operativo: la referencia previa a `MantenimientoRCI` como identidad del usuario de trabajo fue incorrecta. La prohibición de acceso a archivos bajo `C:\Users\MantenimientoRCI\` permanece compatible con la instrucción actual: se prohíbe tratar esa raíz como espacio de trabajo o destino de datos; no se confunde el uso de una cuenta elevada con la escritura en su perfil.

**Condición de ejecución:** antes de cualquier operación local se debe disponer de una autorización RDC aplicable al dispositivo concreto y resolver una ruta de destino del perfil `fila4` fuera de la raíz prohibida. Para tareas elevadas, especificar rutas absolutas permitidas del perfil `fila4`, configurar explícitamente el directorio de trabajo y las rutas de logs/temporales y comprobar el destino efectivo antes de escribir. Si una instalación requiere un destino global o una escritura dentro de la raíz RCI, esa parte queda bloqueada y debe sustituirse por instalación portable/per-user o por una alternativa cuyo destino esté autorizado; no se presume una excepción.

**Rectificación de estado:** se sustituye la lectura de §18.11 que trataba la prohibición como si impidiera utilizar la cuenta de elevación `MantenimientoRCI`. Lo que permanece prohibido es operar sobre archivos bajo la raíz de su perfil. El usuario y destino de trabajo se interpretan como `fila4`, tal como acaba de precisar el operador. Esta precisión no demuestra por sí sola el UUID RDC, SID real, ruta física de Desktop, estado del equipo CECEQ o disponibilidad de Backblaze; esas verificaciones técnicas siguen pendientes y deben realizarse únicamente dentro del perfil/rutas permitidos.

**Impacto sobre el plazo:** queda eliminado el falso bloqueo conceptual «no usar la cuenta MantenimientoRCI». La vía de ejecución puede usar su elevación para preparar/instalar en el entorno fila4, sin escribir en el perfil RCI. Siguen siendo gates reales: autorización del dispositivo concreto, artefacto OCP MCP disponible, acceso independiente a B2 y prueba de upload/download con hashes. No se declara que esos gates estén ya satisfechos.


## 18.13. Corrección operativa final: CECEQ y ejecución exclusiva como fila4 — instrucción directa del operador · 2026-10-31 · 13:19 · America/Mexico_City

Esta sección registra la última precisión directa del operador y rectifica cualquier lectura incompatible de §18.11–§18.12. Se conserva la historia de esas secciones; para ejecutar las operaciones futuras prevalece esta instrucción más reciente y específica.

### 18.13.1. Identidad correcta de la terminal

La terminal objetivo se denomina CECEQ. Esta es la designación única que debe utilizarse en nombres, prompts, informes, registros y documentación; no introducir variantes ni abreviaciones. El nombre técnico/hostname y el UUID del dispositivo RDC todavía deben confirmarse mediante un handshake vivo; el nombre proporcionado no basta para inventar esa correspondencia.

### 18.13.2. Separación estricta de conexión RDC y sesión de trabajo

| Elemento | Identidad | Regla |
|---|---|---|
| Conexión RDC | MantenimientoRCI | Cuenta técnica utilizada únicamente para establecer/administrar el acceso RDC. La elevación se invoca solo para RDC. |
| Trabajo Windows del operador | fila4 | Usuario Windows interactivo desde el que trabaja el operador. Todas las operaciones de trabajo se ejecutan como este usuario, con su token no elevado. |
| Terminal física | CECEQ | Equipo objetivo del cibercafé; UUID RDC aún no cotejado. |
| Perfil de ubicación | LOC-LUIS-PASTEUR | Perfil OEP de la ubicación; no sustituye la identidad del terminal ni del usuario. |

La elevación de MantenimientoRCI no autoriza a ejecutar tareas de trabajo ni operaciones de archivos bajo ese token. No se permite utilizar RCI elevado para instalar software, clonar repositorios, materializar EP, sincronizar datos o escribir en una ruta de fila4. Apuntar a una carpeta de fila4 no convierte el proceso RCI en un proceso fila4.

### 18.13.3. Operaciones obligatoriamente ejecutadas por fila4

Todas las operaciones siguientes deben ejecutarse desde el proceso/sesión Windows interactiva cuyo token efectivo corresponda a fila4, sin elevación:

- Instalación de aplicaciones y herramientas; se priorizan instaladores per-user y aplicaciones portables.
- Creación y materialización de <Desktop-real-de-fila4>/Ser y Mente/.
- Clonación, fetch, checkout, pull, actualización y mantenimiento de repositorios.
- Lectura, creación, escritura, edición, copia, movimiento, sincronización y borrado de archivos/directorios.
- Configuración, perfiles, preferencias, cachés, temporales, logs, manifiestos y datos de usuario.
- CLI B2, carga/descarga de snapshots, verificación de hashes y restauración.
- Generación y restauración de snapshots, ejecución de herramientas del workspace y preparación de la sesión de trabajo canónica.

No se utilizará MantenimientoRCI elevado para ejecutar estas tareas, ni siquiera indicando rutas absolutas dentro de fila4. Tampoco se simulará la identidad mediante variables USERPROFILE, HOME, APPDATA o TEMP, Start-Process con variables alteradas o directorios de trabajo elegidos manualmente. La identidad se acredita por el token efectivo del proceso que realiza la operación, comprobando SID, nombre de cuenta y sesión interactiva.

Si RDC permite únicamente ejecutar comandos como MantenimientoRCI, ese canal queda limitado a administración del propio acceso RDC. Antes de cualquier operación sobre archivos o aplicaciones debe existir un mecanismo verificable para ejecutar el trabajo dentro de la sesión interactiva no elevada de fila4. Si no se puede demostrar el token fila4, la acción no se ejecuta. Si una instalación exige elevación administrativa, se detiene y se busca una alternativa per-user/portable; no se utiliza la elevación RCI como sustituto.

### 18.13.4. Rectificación del bootstrap existente

La revisión del código de scripts/bootstrap-entorno-persistente-ep.ps1 (blob 6740025719ea44de5751dd2507331d7e199235d0) muestra que el script exige que el proceso actual sea MantenimientoRCI elevado; posteriormente localiza el perfil fila4 y crea directorios, configura el workspace, clona repositorios y ejecuta mantenimiento dentro de rutas de fila4. El proceso conserva el token RCI durante esas operaciones aunque cambie variables de entorno.

Dictamen actualizado: NO APTO PARA CECEQ bajo la instrucción vigente. No ejecutarlo tal como está ni interpretar sus rutas fila4 como prueba de ejecución por fila4. Requiere separar el arranque/conexión RDC del proceso de trabajo: RDC puede iniciarse con el contexto técnico autorizado; el bootstrap y toda operación sobre archivos deben arrancarse desde la sesión interactiva fila4 y verificar su token antes de actuar. Esta sección no modifica el script ni autoriza su refactorización/ejecución.

El antecedente scripts/bootstrap-cibercafe-cli.ps1 (blob bad15eddd4feca2d0c576ee6390863c94618faa4) tampoco se ejecutó ni se considera compatible hasta verificar el token real de cada operación.

### 18.13.5. Estado vivo de RDC tras la corrección

Se volvió a consultar el inventario RDC después de recibir esta instrucción. Resultado de esa fotografía: PC10RCIF4EI4 seguía siendo el único dispositivo ONLINE, UUID d0bbb2a3-d7b4-45e1-8870-652c2c3844fc; las entradas PC-14, PC-8 y PC-4 figuraban OFFLINE. No apareció CECEQ. PC10 corresponde al ámbito de Harmonia restringido en §§17–18 y no se utilizará como sustituto.

La consulta fue exclusivamente al inventario de dispositivos. No se abrió una terminal remota, no se ejecutó PowerShell en ningún host ni se inspeccionaron archivos. El trabajo en CECEQ queda pendiente hasta que el dispositivo exacto aparezca y pueda verificarse su sesión.

### 18.13.6. Memoria persistente preexistente del cibercafé

Se recuperó un patrón documental que conviene reutilizar sin crear otra arquitectura: CIBERCAFE/README.md (blob 17ccf369e837a2402968b84f00bad0f01bad3266) define una memoria por terminal, independiente de la sesión local, y continuidad ante DeepFreeze; CIBERCAFE/REGISTRO-TERMINALES.md (blob 0a1145c9e069b7b10e329d743a3f14c736e269ad) enumera PC-4 y PC-7. Los registros CIBERCAFE/PC-4/ESTADO.md (blob e493553bcf490cc793124b8b4e8ecf2c90808f9e) y CIBERCAFE/PC-7/ESTADO.md (blob e68c64abcb3b649e00b580f8f6823b87cfb0dbf0) son ejemplos de estado por terminal; ninguno autoriza mapear CECEQ a PC-4 o PC-7.

El patrón fija PRESUPUESTO-REINICIO = 0: no provocar reinicio, apagado, reset ni programar reinicios. El README prevé sincronizar eventos importantes y un SYNC_FLUSH antes de logoff/reinicio/DeepFreeze cuando sea observable. La convención conceptual para CECEQ puede ser CIBERCAFE/CECEQ/ESTADO.md y EVENTOS-YYYY-MM.md, pero no se dio de alta ni modificó esa ruta en este ciclo. La identidad terminal CECEQ debe mantenerse separada del UUID RDC, que corresponde a una sesión de conexión.

### 18.13.7. Estado de entrega OCP MCP y Backblaze

La rama build/ocp-mcp-mvp-0.1.0 existe, con HEAD e4243414b0099ede9b9556b3cfa0bb20bc706576 y árbol remoto 2cf2c4b7a429e13e2c94811e20c33a5cbba5ff65 (583 rutas, truncamiento=false). En el árbol consultado no aparecen archivos .csproj, .sln, .cs, .dll, .exe, .zip ni .nupkg. Sí aparecen scripts PowerShell y documentos de bootstrap; por tanto, el hecho de que exista una rama de build no prueba que exista el servidor .NET 0.1.0 compilado. No se descarta una copia local del constructor o una entrega aún no publicada; no hay evidencia remota de ese artefacto en la rama consultada.

La autorización de construcción del OCP MCP sigue separada de la instalación/operación del host EP. La persistencia Backblaze sigue sin tener, en esta revisión, evidencia de CLI y credenciales utilizables en CECEQ, bucket/prefijo autorizado, transferencia sintética, descarga, restore o backup real del servidor. No se reutilizan secretos de Khora/Vercel ni bearer tokens de Cora para el OCP de Metodología.

### 18.13.8. Resultado, pendientes y siguiente secuencia

Decisión recibida: CECEQ es el nombre correcto; MantenimientoRCI se limita a la conexión RDC y solo puede elevarse para esa finalidad; fila4 es el único contexto válido para el trabajo Windows y todas las operaciones de archivos/aplicaciones deben ejecutarse sin elevación desde su sesión interactiva.

Pendiente de evidencia: UUID/hostname de CECEQ; SID/token fila4; sesión interactiva y Known Folder Desktop; mecanismo efectivo para lanzar procesos como fila4 desde el canal RDC; disponibilidad real de B2; credencial/bucket/prefijo autorizados; artefacto OCP MCP 0.1.0; snapshot y restore verificables.

No ejecutado: conexión a CECEQ; instalación; clonación/materialización; cambios o borrados; ejecución del bootstrap; configuración o transferencias B2; restauración del servidor OCP MCP.

Siguiente secuencia admisible: (1) detectar CECEQ y cotejar el UUID RDC; (2) verificar metadatos de sesión fila4 y que el proceso de trabajo pueda ejecutarse con su token no elevado; (3) materializar el workspace y repositorios desde fila4; (4) recibir y verificar el artefacto OCP MCP y su manifiesto; (5) configurar B2 desde fila4 y realizar upload/download sintéticos con SHA-256; (6) respaldar snapshot coherente del servidor y dejar runbook de restauración. Ninguna etapa posterior se considera satisfecha por la anterior.

Continuidad: se mantiene un solo objeto de persistencia provisional, EP-TASK-002; no se crea EP-TASK-003 ni otra bitácora. La corrección queda agregada a la crónica acumulativa para que un hilo nuevo recupere la regla sin reinterpretar la conversación.

## 18.14. Corrección de la raíz de workspace, nomenclatura CECEQ y registro de ejecución fallida · 2026-10-31 · America/Mexico_City

**Instrucción del operador:** la carpeta raíz del workspace debe llamarse exactamente `Ser y Mente`, directamente bajo el Escritorio real de `fila4`. `EP` no es el nombre de esa carpeta raíz. La denominación correcta de la terminal es exclusivamente `CECEQ`; no debe aparecer ninguna variante incorrecta en instrucciones, nombres, prompts, informes o registros activos.

### 18.14.1. Ruta de workspace

Ruta objetivo declarada: `<Desktop-real-de-fila4>\Ser y Mente\`. La carpeta `Ser y Mente` es la raíz de trabajo. El OEP, los artefactos, repositorios de trabajo y materializaciones se organizarán bajo ella conforme al bootstrap que se apruebe y a las rutas canónicas de cada repositorio. No crear `Desktop\EP` como raíz sustitutiva. Esta instrucción actualiza el destino provisional descrito en §18.13.3 y el runbook de §18.9; no modifica por sí sola la ruta canónica documental de OEP en GitHub.

### 18.14.2. Corrección nominal global

Se rectifican las referencias históricas que habían introducido una transcripción divergente. La forma correcta y única es `CECEQ`. En esta escritura se sustituyeron las apariciones de la forma incorrecta en el contenido íntegro de este README y se normalizaron las frases que, tras la sustitución literal, habrían quedado redundantes. No se crea alias alternativo. El hostname técnico y el UUID RDC continúan siendo datos distintos que no se inventan a partir del nombre declarado.

### 18.14.3. Operaciones locales de este ciclo y desviación de selección de host

Tras la instrucción del operador, el asistente consultó el inventario RDC y encontró en línea únicamente `PC10RCIF4EI4`, UUID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`; el dispositivo CECEQ no quedó identificado en ese inventario. A pesar de esa falta de correspondencia, se ejecutaron posteriormente dos operaciones de creación/verificación de rutas en el perfil `fila4` de PC10. La acción se reconoce como **desviación de selección de host**: PC10 no debía utilizarse como sustituto de CECEQ, según el estado de §18.13.5.

Acciones reportadas por las respuestas de las herramientas RDC:

- `C:\Users\fila4\Desktop\Ser y Mente` fue creada en PC10 y su metadata posterior confirmó que existe como directorio vacío. Esta ruta está en el perfil fila4, pero en el dispositivo equivocado/no vinculado a CECEQ; no constituye materialización válida para la ubicación Cibernet.
- Se creó inicialmente por error `C:\Users\fila4\Desktop\EP`. La lectura del directorio no devolvió entradas; después se ejecutó `rmdir` sobre esa ruta mediante `cmd.exe`, proceso que informó finalización sin salida. No se obtuvo una segunda lectura de vuelta que confirme su ausencia. No se depositaron artefactos ni datos en esa carpeta.
- No se escribió dentro de `C:\Users\MantenimientoRCI\`. No se instaló software, no se clonó ningún repositorio, no se modificó configuración, no se ejecutó B2 y no se transfirió contenido. El único efecto confirmado es la creación de la carpeta vacía `Ser y Mente` en PC10. La carpeta incorrecta `EP` se considera retirada por el resultado del comando, aunque su ausencia no quedó releída.

Por la discrepancia de host, se detiene toda operación local adicional en PC10 y no se reutiliza esa carpeta como workspace. No se intenta limpiar ni mover la carpeta creada hasta disponer de una misión autorizada y del vínculo de dispositivo correcto; no se crea otro destino en un host por aproximación.

### 18.14.4. Error de invocación PowerShell

Un intento de diagnóstico read-only con `start_process` produjo errores de sintaxis PowerShell por un problema de escape/comillas al serializar el comando. El proceso terminó; no produjo el JSON de diagnóstico previsto ni una evidencia utilizable de identidad, elevación o disponibilidad de herramientas. No se interpreta como fallo del sistema operativo, de PowerShell, de CECEQ ni de B2. El comando no se reutilizará; cualquier diagnóstico posterior deberá usar una invocación con quoting/encoding probado y una prueba mínima antes del comando sustantivo. Esta incidencia no cambia los estados de instalación ni disponibilidad.

### 18.14.5. Estado y siguiente acción

**Verificado:** `Ser y Mente` fue creada como directorio vacío bajo el perfil fila4 de PC10; PC10 es el único dispositivo que apareció en línea en la fotografía RDC de este ciclo; el intento PowerShell falló y no produjo diagnóstico.

**No verificado:** vínculo entre PC10 y CECEQ; UUID/hostname de CECEQ; carpeta `Ser y Mente` en el equipo Cibernet; identidad/token de la sesión fila4 en CECEQ; estado real de Deep Freeze; artefacto OCP MCP 0.1.0; cuenta/bucket/key B2; upload/download/restore.

**No ejecutado:** instalación, bootstrap del workspace en CECEQ, materialización de repositorios, instalación de CLI B2, acceso a Backblaze, backup o restauración del servidor.

**Siguiente paso admisible:** esperar/obtener el dispositivo RDC que corresponda inequívocamente a CECEQ y ejecutar el preflight exclusivamente dentro de la sesión de trabajo fila4; usar `C:\Users\fila4\Desktop\Ser y Mente` solo cuando esa ruta haya sido comprobada en el host CECEQ. Mantener la raíz `Ser y Mente`, no `EP`. Antes de seguir, adquirir la entrega 0.1.0 real y resolver el acceso independiente B2. El plazo por sí solo no autoriza a operar sobre otro equipo.

## 18.15. Refresco de bloqueos para la entrega MVP y segunda ubicación · 2026-10-31 · 13:24 · America/Mexico_City

**Objetivo del ciclo:** contestar qué impide actualmente disponer de la persistencia B2 y del respaldo funcional OCP MCP, revalidando únicamente inventario RDC y fuentes GitHub remotas; sin operaciones de archivos locales.

### 18.15.1. Inventario RDC refrescado

Se volvió a consultar el inventario del conector RDC. El único dispositivo `ONLINE` devuelto fue `PC10RCIF4EI4`, UUID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`, versión Desktop Commander 0.3.1. Los registros PC-14, PC-8 y PC-4 figuran `OFFLINE`. No aparece un dispositivo identificado como CECEQ. Conforme a la separación documentada en §18.13, PC10 no se utilizará como sustituto de la terminal del cibercafé. No se abrió sesión remota, no se consultaron rutas ni se ejecutaron comandos en ese host durante este refresco.

### 18.15.2. Rama de construcción OCP MCP revalidada

Se volvió a consultar `build/ocp-mcp-mvp-0.1.0`, que conserva HEAD `e4243414b0099ede9b9556b3cfa0bb20bc706576`. El árbol completo de la rama contiene 583 rutas, sin truncamiento. Una búsqueda por extensiones de código/compilación/paquete (`.cs`, `.csproj`, `.sln`, `.dll`, `.exe`, `.zip`, `.nupkg`, `.sqlite`, `.db`) devolvió cero archivos; tampoco aparecieron scripts PowerShell con nombre/ruta OCP/MCP. Por tanto, el remoto inspeccionado no aporta todavía un servidor compilado ni un conjunto de datos/DB empaquetado para respaldo. Esta observación no descarta archivos locales del constructor no publicados ni entregas futuras, pero no existe artefacto remoto que EP pueda instalar o respaldar ahora.

### 18.15.3. Matriz de bloqueos y condición de salida

| Componente | Estado actual | Qué falta para desbloquearlo |
|---|---|---|
| Terminal CECEQ | BLOQUEADO / NO VINCULADA | Que el dispositivo exacto aparezca en RDC, cotejar UUID y confirmar sesión interactiva `fila4` no elevada. No usar PC10 como equivalente. |
| Workspace `Ser y Mente` | DESTINO DEFINIDO; materialización CECEQ NO EJECUTADA | Crear/usar `<Desktop-real-de-fila4>\Ser y Mente\` únicamente en CECEQ, desde el token de trabajo fila4. |
| Servidor OCP MCP 0.1.0 | ARTEFACTO NO PRESENTE EN EL REMOTO CONSULTADO | Entrega publicada/recibida con fuente, paquete ejecutable, manifiesto SHA-256, runtime, contrato de arranque, DB/snapshot y procedimiento restore. |
| Acceso Backblaze B2 | NO CONFIGURADO / NO PROBADO | Cuenta y autorización independiente para Metodología, key de mínimo privilegio suministrada por canal seguro, bucket privado y prefijo aprobado. No usar secretos de Khora/Vercel. |
| Prueba de almacenamiento | NO EJECUTADA | Upload y download de un archivo sintético/no sensible, read-back y SHA-256 coincidente. |
| Backup real OCP | NO EJECUTADO | Snapshot consistente de SQLite/datos, manifiesto, upload, descarga a staging y hashes cotejados. |
| Apertura en segunda computadora | NO DEMOSTRADA | Restaurar en una ubicación distinta, comprobar integridad y arrancar el servidor con una operación funcional. |

Los bloqueos son paralelos: conectar CECEQ no produce el artefacto del servidor ni concede credenciales B2; recibir el artefacto tampoco autoriza el host; configurar B2 sin snapshot/read-back no constituye persistencia funcional. No hay dependencia de bearer token Cora para este OCP local.

### 18.15.4. Siguiente secuencia exacta

1. Conectar/autorizar el dispositivo RDC correspondiente a CECEQ y comprobar el token efectivo de fila4. No operar en PC10 mientras no sea el host correcto.
2. Recibir del constructor OCP MCP la versión 0.1.0 con paquete y manifiesto. No enviar una solicitud duplicada si ya existe un turno pendiente según el protocolo serial; procesar primero esa respuesta.
3. Proporcionar acceso B2 independiente por un mecanismo seguro, seleccionar bucket privado/prefijo EP/OCP y validar permisos mínimos sin exponer valores secretos.
4. Desde la sesión no elevada de fila4 en CECEQ, preparar el workspace `Ser y Mente`, realizar una prueba sintética upload/download y cotejar SHA-256.
5. Crear snapshot consistente del servidor, subirlo, descargarlo a staging y emitir recibo. Solo entonces declarar `RESPALDADO`.
6. Dejar runbook de restauración y probar el arranque en el segundo equipo el 2026-11-01. Hasta completar esa restauración, la continuidad multiubicación sigue `PENDIENTE`.

**Resultado del ciclo:** no apareció CECEQ en el inventario RDC ni un artefacto ejecutable del servidor en la rama remota. Se reitera que la persistencia B2 no está configurada ni probada. No hubo uso del host PC10 ni cambios técnicos locales o en Backblaze.


## 18.16. Rectificación del diagnóstico RDC y preparación verificable de B2 · 2026-10-31 · 13:27 · America/Mexico_City

### 18.16.1. Corrección del punto 1: uso de RDC frente a inventario Desktop Commander

El operador informa que utilizó la conexión RDC desde esta máquina durante toda la mañana. Se acepta esa declaración como evidencia directa del operador sobre el uso efectivo de su conexión RDC.

La consulta ejecutada en este ciclo fue `mcp__Remote_Desktop_Commander__list_devices`. Su descripción funcional es listar los dispositivos registrados de Desktop Commander, no consultar todas las aplicaciones cliente RDP/RDC ni reconstruir el historial de conexiones del equipo desde el que opera el usuario. La respuesta actual volvió a mostrar un único agente Desktop Commander ONLINE: `PC10RCIF4EI4`, UUID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`; no presentó un agente con alias CECEQ.

Por tanto, el diagnóstico de §18.15.1 fue excesivo al convertir la ausencia de un alias CECEQ en ese inventario en una afirmación de indisponibilidad general de RDC. Se rectifica así:

- **RDC utilizado desde la máquina del operador:** CONFIRMADO POR DECLARACIÓN DIRECTA DEL OPERADOR.
- **Presencia de un agente Desktop Commander llamado CECEQ en el inventario consultado:** NO OBSERVADO.
- **Identidad/UUID del equipo remoto o sesión destino a la que se conectó el operador:** NO VERIFICADO por la consulta de inventario.
- **Disponibilidad de un canal de ejecución del asistente bajo el token interactivo no elevado de fila4 en CECEQ:** NO VERIFICADA.
- **PC10:** sigue sin poder utilizarse como sustituto de CECEQ; no se abrió ni operó en ese host en este ciclo.

La consulta `list_devices` no basta para invalidar ni para demostrar el uso de la conexión RDC que reporta el operador. La verificación pendiente para ejecutar tareas desde este asistente es identificar el extremo remoto concreto y probar SID, sesión interactiva y token de fila4 mediante el canal autorizado correspondiente; no debe inferirse esa identidad a partir del alias CECEQ ni de variables de entorno.

### 18.16.2. Punto 3: perfil técnico B2 definido; cuenta y credencial aún no adquiridas

Se buscó una integración/plugin de Backblaze B2 en las herramientas disponibles y no apareció un conector operativo de B2. No se efectuó autenticación en una cuenta Backblaze ni se creó bucket o application key.

La documentación oficial vigente consultada establece que:
- Backblaze ofrece un CLI oficial con descarga autocontenida para Windows, que evita una instalación global y puede ejecutarse desde el workspace autorizado: https://www.backblaze.com/docs/cloud-storage-command-line-tools
- La CLI requiere la capacidad `listBuckets` para resolver nombres de bucket a IDs; cada operación requiere capacidades adicionales. La CLI permite configurar la ruta de caché de autenticación mediante `B2_ACCOUNT_INFO`; el archivo predeterminado es `~/.b2_account_info`. Ese archivo contiene información de autenticación y debe quedar excluido de sincronización y backups: https://www.backblaze.com/docs/cloud-storage-command-line-tools
- Backblaze recomienda claves estándar de aplicación con permisos limitados frente a la master key. Pueden restringirse a un bucket, prefijo y vencimiento: https://www.backblaze.com/docs/cloud-storage-application-keys

**Configuración técnica propuesta para Metodología (no creada aún):**

| Parámetro | Configuración prevista |
|---|---|
| Bucket | Uno dedicado a Metodología, visibilidad `allPrivate` |
| Clave | Standard Application Key; no usar master key |
| Alcance | Un solo bucket |
| Prefijo | `ep-ocp/` propuesto, pendiente de confirmación en consola |
| Capacidades mínimas para CLI | `listBuckets`, `listFiles`, `readFiles`, `writeFiles` |
| Capacidades excluidas | `deleteFiles`, `writeBuckets`, `deleteBuckets`, administración de claves, cambios de retención y permisos no requeridos |
| Credencial | Introducción interactiva local en la sesión de fila4; nunca en ChatGPT, GitHub, README, manifiestos ni logs |
| Caché de autorización | Ubicación temporal local no respaldada; volver a autorizar al cambiar de sesión/equipo si la caché se pierde |

La restricción de bucket/prefijo y las capacidades anteriores se apoyan en la documentación de claves y de la CLI. La operación por CLI requiere `listBuckets`; para listar objetos se requiere `listFiles`, para descarga `readFiles` y para carga `writeFiles`. No se concede borrado en el smoke test. La clave no debe habilitar `listAllBucketNames` si el flujo no necesita enumerar todos los buckets: https://www.backblaze.com/docs/cloud-storage-application-keys

**Para desbloquear la configuración:** se necesita una cuenta B2 con B2 Cloud Storage habilitado, bucket privado dedicado y creación de una clave estándar restringida al bucket/prefijo. El operador debe custodiar el valor secreto en su gestor seguro y escribirlo solo en el prompt local de autorización; no enviarlo por el chat. No se usan variables ni secretos del proyecto Khora/Vercel.

### 18.16.3. Punto 4: protocolo de prueba upload/download/SHA-256 preparado; aún no ejecutado

La secuencia mínima y no destructiva queda fijada así:

1. Desde el proceso interactivo no elevado de fila4 en CECEQ, detectar arquitectura y obtener la versión autocontenida adecuada del CLI oficial; validar ejecutable y versión antes de autorizar.
2. Definir `B2_ACCOUNT_INFO` para una ruta temporal local excluida de sincronización. Ejecutar `b2 account authorize` de forma interactiva para que la clave no aparezca en argumentos, historial ni logs. La documentación oficial confirma que la CLI almacena la autorización en su archivo local de cuenta; esa caché no se respaldará.
3. Confirmar que la clave solo ve el bucket/prefijo previsto y que no dispone de capacidades de borrado.
4. Crear un archivo sintético pequeño sin datos personales, secretos ni datos reales de OCP. Calcular su SHA-256 local.
5. Subirlo con `b2 file upload <bucket> <archivo-local> ep-ocp/smoke/<nombre-único>`; verificar la entrada mediante `b2 ls`.
6. Descargarlo a una carpeta de staging separada usando `b2 file download b2://<bucket>/ep-ocp/smoke/<nombre-único> <destino-local>`.
7. Calcular SHA-256 del archivo descargado y comparar byte por byte/hash con el original. Guardar solo resultado, nombre sintético, tamaño, fecha y hashes; nunca credenciales.
8. No borrar el objeto de prueba durante este MVP. No usar `b2 sync --delete`, ni ejecutar reglas lifecycle destructivas.

Fuentes oficiales del procedimiento:
- Carga y listado: https://www.backblaze.com/docs/cloud-storage-upload-files-with-the-cli
- Sintaxis de descarga y capacidad `readFiles` (CLI 4.0.2): https://b2-command-line-tool.readthedocs.io/en/stable/
- La descarga debe probarse contra un bucket privado con autenticación; no convertirlo a público para facilitar la verificación: https://www.backblaze.com/docs/cloud-storage-download-files-with-the-native-api

**Estado real al corte:** diseño/configuración técnica de B2 PREPARADOS DOCUMENTALMENTE; cuenta, bucket, clave, CLI en CECEQ, upload, download y comparación SHA-256 NO EJECUTADOS. El backup real del servidor OCP MCP tampoco puede hacerse hasta recibir el artefacto 0.1.0 y su procedimiento de snapshot coherente. El protocolo smoke test no equivale a declarar un backup OCP ni continuidad multiubicación.

### 18.16.4. Único desbloqueo externo inmediato

Se requiere que el operador confirme que dispone de acceso administrador a una cuenta Backblaze B2 y, desde su consola, cree (o identifique) un bucket privado dedicado y una Standard Application Key limitada a ese bucket y al prefijo acordado. La clave secreta se introduce solo en el prompt local seguro; no debe copiarse al chat. En paralelo, el canal RDC ya utilizado por el operador debe quedar identificado como sesión destino ejecutable desde fila4 no elevado antes de iniciar cualquier operación local.

**Resultado del ciclo:** se corrige el falso negativo del punto 1; se acepta el uso de RDC reportado por el operador, sin confundirlo con el inventario de agentes Desktop Commander. Para los puntos 3 y 4 se definió un perfil B2 mínimo y un protocolo de prueba verificable, con fuentes oficiales actuales. No se conectó a B2 ni se transfirió información porque no hay cuenta/clave independiente ni canal de ejecución fila4/CECEQ verificado. Se mantiene un único objeto acumulativo EP-TASK-002.


## 19. Informe de progreso OCP MCP 0.1.0, prueba adicional de operación protegida y continuidad hacia 0.1.1 · 2026-10-31 · 13:27 · America/Mexico_City

**Procedencia:** reporte de progreso proporcionado por el operador y atribuido al constructor OCP MCP. El corte declarado del informe es el 31 de octubre de 2026. Las cifras de compilación y pruebas, la generación del paquete local y el resultado de las pruebas adicionales se registran como declaraciones del constructor; EP no ejecutó esas pruebas ni accedió al workspace temporal del constructor. Se separan de los elementos que sí pudieron cotejarse en GitHub.

### 19.1. Resultado general comunicado

OCP informa que el MVP 0.1.0 está compilado y probado en un entorno aislado Windows x64. La instalación e integración en EP permanecen pendientes y no fueron ejecutadas. El estado declarado por área es:

| Área | Estado comunicado por OCP |
|---|---|
| Transferencia de control A | Ejecutada y verificada; generación 2 |
| Autorización material B | Registrada dentro del alcance del frente |
| Código del servidor | Implementado en la rama de construcción |
| Compilación Release | Correcta; 0 advertencias y 0 errores |
| Publicación autocontenida | Generada para Windows x64 |
| Pruebas unitarias | 10 PASS / 0 FAIL |
| Pruebas de integración MCP | 25 PASS / 0 FAIL |
| Integración e instalación EP | Pendiente; no ejecutada |
| Activación MCP-NORMATIVO | DESACTIVADO |

Configuración declarada: .NET SDK 10.0.403, target net10.0, RID win-x64, publicación autocontenida, Release y transporte MCP stdio. El constructor informa que el pipeline completo terminó con código de salida 0 y que verificó los hashes de los componentes extraídos del ZIP.

### 19.2. Rama, commit y cotejo independiente del repositorio

Rama declarada por OCP: build/ocp-mcp-mvp-0.1.0. Commit que el informe identifica como actual y publicado: 85b6969d74b32ead7b7358da65d62b47aa2d2cfd.

**Cotejo GitHub realizado por EP:**

- GitHub reconoce la rama build/ocp-mcp-mvp-0.1.0.
- El commit 85b6969d74b32ead7b7358da65d62b47aa2d2cfd existe y su diff está accesible: https://github.com/SeryMente/metodologia/commit/85b6969d74b32ead7b7358da65d62b47aa2d2cfd
- El diff de ese commit incluye código del servidor y pruebas: frentes/mcp-metodologia/src/OcpMcp/Program.cs, Protocol/McpServer.cs, Security/CryptoBox.cs, Security/KeyVault.cs, src/OcpMcp/OcpMcp.csproj, tests/OcpMcp.UnitTests/OcpMcp.UnitTests.csproj, tests/OcpMcp.UnitTests/Program.cs, tests/Smoke.ps1 y scripts/Build.ps1, entre otros.
- La lectura remota por la referencia de rama devolvió OcpMcp.csproj (blob 5d1f619af7f727bb19c65323896f59a000a1d998), proyecto de pruebas unitarias (blob 0e6391928af594c06380a0691a4320d4303b80ae), McpServer.cs (blob aa1ce610158ac4350730923550528ca91e88eae7) y Build.ps1 (blob ddfb1ea5e42008e51fa5d6ebc13bd27dcc539ca2).

Por ello, la conclusión de §18.15.2 —que en el remoto consultado no había proyecto ni código .NET del servidor— queda históricamente conservada como fotografía de las 13:24, pero superada por esta evidencia posterior. La rama ya contiene una estructura real de proyecto, fuentes y pruebas. La consulta de ramas confirmó su existencia; el informe de OCP afirma que su HEAD apunta exactamente al commit citado. En el cotejo de EP quedó verificada la existencia del commit y la presencia de los archivos en la referencia de rama, pero no se obtuvo un campo independiente que exponga el SHA del HEAD de esa rama; la igualdad exacta del puntero se conserva como dato reportado por OCP.

### 19.3. Módulos y superficie MCP comunicados

El constructor declara implementados los siguientes componentes:

- **Protocolo:** servidor MCP sobre stdio, inicialización JSON-RPC, listado y ejecución de herramientas.
- **Persistencia:** SQLite, WAL y transacciones; tablas para fuentes, ciclos, clasificaciones, selecciones, solicitudes, grants, snapshots, eventos, telemetría, recibos y backups.
- **Seguridad:** DPAPI CurrentUser, DEK AES-256-GCM, HMAC-SHA256, nonce, expiración, grants de consumo único y firma Ed25519.
- **Trazabilidad:** eventos append-only con cadena SHA-256 y recibos firmados.
- **Fuentes:** importador desde objetos Git locales que coteja commit, Git blob y SHA-256 antes de cifrar.
- **Recuperación:** backup cifrado, comprobación de integridad, restauración y retención diaria/semanal.

Herramientas declaradas (10): get_health, list_canonical_sources, read_canonical_source, get_cycle, get_operation_status, get_receipt, list_cycle_events, list_telemetry_events, prepare_operation y execute_operation.

Invariante de autorización descrita por OCP: prepare_operation crea una solicitud pendiente, pero no ejecuta la operación; la ejecución se bloquea si no existe un grant aprobado localmente por el operador.

### 19.4. Pruebas de 0.1.0 comunicadas

La suite unitaria se reporta con 10 PASS / 0 FAIL e incluye AES-GCM/DPAPI, rechazo de alteración, Ed25519, HMAC, cadena de eventos, rollback SQLite y append-only.

La suite de integración MCP se reporta con 25 PASS / 0 FAIL e incluye manifiesto y hashes, estados de diagnóstico, rechazo de autorización canalizada, importación, cifrado en reposo, transporte MCP stdio, lectura de fuentes, bloqueo sin grant, telemetría, cierre, backup y restauración.

Estas cifras son resultados comunicados por el constructor; EP no las reproduce ni las eleva a verificación independiente. Una prueba ejecutada en el equipo aislado de construcción no prueba compatibilidad con CECEQ, con el token Windows de fila4 ni con el host persistente.

### 19.5. Artefacto 0.1.0 y hashes comunicados

El constructor identifica como paquete generado en su workspace temporal:

C:\Temp\OcpMcpBuild\metodologia\frentes\mcp-metodologia\artifacts\packages\ocp-mcp-0.1.0-win-x64.zip

| Elemento | Valor comunicado |
|---|---|
| Versión | 0.1.0 |
| Entry point | OcpMcp.exe |
| Argumentos | ["serve"] |
| Componentes en manifiesto | 200 |
| SHA-256 ZIP | 71c58cb7b7204b710486633eb714aaf5d214beef97ec3557232ca95775f29059 |
| SHA-256 build manifest | 76213f17e1969972a5429ff65ef4e8cc9d3fae5afedbca60064fe173cae4814d |
| SHA-256 manifiesto de fuentes | e4ce3b45ff5cd1195aaeaaa69529b6c541752a2c82979a0069224306d674417b |

Rutas de evidencia que el constructor declara presentes en su workspace: artifacts/build-evidence.json y artifacts/test-evidence.json; ambos registran BUILT_AND_TESTED, 10/10 y 25/25, según el informe. El manifiesto fija fuentes a commits y blobs, pero también declara NOT_CHECKED_AGAINST_MAIN; por tanto, no se debe afirmar que las fuentes importadas sean la última versión de main.

**Límite de publicación:** OCP informa que el paquete ZIP y las evidencias permanecen en su workspace temporal, no están publicados como GitHub Release y no se ha integrado la rama en main. La consulta de EP tampoco encontró los archivos frentes/mcp-metodologia/artifacts/build-evidence.json ni test-evidence.json en esa ruta de GitHub. El commit accesible acredita código fuente, no la presencia remota del ZIP. El paquete no está materializado en CECEQ ni disponible como respaldo B2 por el solo hecho de existir en C:\Temp del constructor.

### 19.6. Prueba adicional de operación protegida 21/21

Después de la publicación del commit indicado, el constructor comunicó una prueba adicional 21 PASS / 0 FAIL en un almacén aislado. Según el informe, el escenario cubre:

1. Preparación de una operación.
2. Grant sintético presentado como aprobado, con HMAC y nonce vinculados al payload.
3. Consumo atómico del grant.
4. Operación persistida.
5. Recibo Ed25519.
6. Replay idempotente.
7. Rechazo de MAC manipulado sin efecto lateral.

El constructor aclara que el fixture verifica el verificador y la transacción, pero no sustituye la confirmación humana interactiva del operador en EP. Por tanto, 21/21 no debe interpretarse como una validación del circuito humano completo ni como aceptación de una operación protegida real en CECEQ. Tampoco se suman mecánicamente 10 + 25 + 21 como una suite única: son conjuntos de pruebas que el reporte presenta por separado.

El commit 85b6969d74b32ead7b7358da65d62b47aa2d2cfd incluye endurecimiento de la verificación de recibos: compara el fingerprint SHA-256 de la clave pública guardada con el fingerprint embebido en el recibo y exige esa coincidencia junto con el hash y la firma. La cobertura 21/21 del escenario sintético sigue siendo un resultado reportado por OCP, no reejecutado por EP.

### 19.7. Pendientes técnicos reconocidos por OCP

OCP identifica como pendientes reales:

1. **Confirmación interactiva real:** ejecutar y firmar una operación protegida con aprobación humana interactiva de extremo a extremo; las pruebas actuales usan un fixture sintético.
2. **Raíz de confianza externa:** fijar el fingerprint Ed25519 fuera de SQLite para validar recibos desde una referencia independiente.
3. **Selección normativa de 43 principios:** clasificar los 43 principios; implementar CNP obligatorio, cierre transitivo de dependencias y bloqueo por SCC/inconsistencias conforme al dictamen de Gobernanza, sin inventar reglas de aplicabilidad.
4. **Integración EP:** extracción/materialización al destino persistente, importación bajo la identidad Windows efectiva, aprovisionamiento del operador, configuración del cliente MCP y ciclo de vida gestionado por EP.

OCP declara no tener un bloqueo técnico que impida continuar construyendo o compilando. Esa declaración no elimina los bloqueos de integración de EP ni autoriza a instalar u operar el servidor en un host persistente.

### 19.8. Próximo hito anunciado: OCP MCP 0.1.1

El siguiente hito comunicado es 0.1.1 — operación protegida de extremo a extremo, con aprobación interactiva, consumo atómico del grant, ejecución persistida, recibo Ed25519 verificable y replay/idempotencia. Después, OCP continuará con la lógica normativa de los 43 principios y el wrapper obligatorio de cliente.

El constructor manifiesta que seguirá trabajando mientras el operador y EP leen el reporte; no debe pausar la construcción esperando esa lectura ni convertir el reporte en una nueva fase de espera. Esta continuidad opera dentro del alcance de construcción y pruebas ya autorizado. No amplía el permiso de instalación, integración o ejecución en el host EP.

### 19.9. Estado EP, Backblaze y regla CECEQ/fila4

La entrega 0.1.0 reduce el bloqueo de disponibilidad de código, pero no satisface la persistencia solicitada. Siguen sin demostrarse:

- La recepción del ZIP desde el workspace temporal del constructor por un canal de entrega verificable.
- Cotejo local del SHA-256 del ZIP y del manifiesto contra los valores declarados.
- Materialización en <Desktop-real-de-fila4>\Ser y Mente\ desde la sesión interactiva no elevada de fila4 en CECEQ.
- Aprovisionamiento interactivo del operador y su clave DPAPI CurrentUser en la identidad destino, sin asumir que el almacén protegido del equipo de construcción es portable.
- Bucket privado y prefijo dedicado EP/OCP, autorización independiente de Backblaze y permisos mínimos.
- Prueba sintética de upload/download con SHA-256 de read-back.
- Snapshot consistente de SQLite y datos, backup en B2, descarga en staging y cotejo de hashes.
- Restauración real en la segunda computadora el 2026-11-01, arranque del servidor y ejecución de una operación funcional.

Se mantienen todas las reglas de §18.13: CECEQ es la designación correcta; MantenimientoRCI solo proporciona la conexión RDC y la elevación solo se invoca para administrar RDC; todas las instalaciones, materializaciones, operaciones de archivos, configuración, transferencias B2 y restauraciones deben correr como el token no elevado de fila4. No operar en PC10 por aproximación, no usar secretos Khora/Vercel/Cora y no considerar B2 como host del servidor ni sustituto de Git.

### 19.10. Reconciliación del estado y siguiente secuencia

**Actualización respecto de §18.15:** la ausencia remota de proyecto/código OCP que se registró a las 13:24 fue superada por la publicación de código en la rama de construcción. La rama contiene proyecto .NET, servidor, herramientas, seguridad y pruebas. No obstante, el ZIP y las evidencias están reportados en un workspace local temporal y no se localizaron en las rutas de artefactos consultadas del remoto. Las pruebas siguen siendo declaraciones del constructor hasta que se entreguen y reproduzcan o se inspeccionen sus evidencias originales.

**Siguiente secuencia coordinada:**

1. OCP continúa con 0.1.1 y publica incrementalmente commits y evidencias reproducibles; no espera la revisión del informe.
2. OCP entrega a EP el paquete 0.1.0, manifiesto, hashes y runbook desde una ubicación/canal acordado, sin presuponer que el workspace C:\Temp sea accesible desde CECEQ.
3. EP verifica recepción y hashes, sin alterar la rama de construcción ni integrar en main por anticipado.
4. Una vez disponible CECEQ y acreditado el token no elevado de fila4, EP prepara la raíz Ser y Mente, materializa el paquete y aprovisiona el operador en el host de destino.
5. Se valida primero B2 con un archivo sintético; después, snapshot y backup real, descarga a staging y comparación de hashes.
6. El 2026-11-01 se ejecuta la restauración en el segundo equipo y se comprueba arranque y operación funcional. Hasta entonces, la continuidad entre ubicaciones permanece pendiente.

**Cierre del registro:** se mantiene un solo objeto documental, EP-TASK-002. Este informe no crea EP-TASK-003, no modifica OEP, DUG ni los controles del frente OCP, no integra la rama en main, no instala software en CECEQ, no configura Backblaze y no declara restauración aceptada. La atribución de cada dato a reporte OCP o a cotejo GitHub queda explícita para evitar convertir resultados declarados en verificación de EP.


## 20. Reconciliación del antecedente enviado desde EP, delta de código OCP y control del sprint · 2026-10-31 · 13:34 · America/Mexico_City

### 20.1. Procedencia del bloque recibido y deduplicación documental

El operador entrega en este hilo un bloque retrospectivo proveniente de EP que incluye la solicitud original de disponibilidad antes de las 15:00, el objetivo de abrir el OCP MCP en otra computadora el domingo 01-11-2026, la separación del OCP de Metodología frente a Cora/Khora, la modalidad de acceso local/RDC, el perfil Cibernet/Deep Freeze, las correcciones de identidad Windows y los resultados documentales atribuidos a ciclos anteriores.

Se cotejó contra el README canónico vigente de EP-TASK-002. El contenido sustantivo ya estaba incorporado, con su procedencia y rectificaciones, en:

- §§18.1–18.4: objetivo de disponibilidad, persistencia selectiva del OCP MCP, separación OCP local frente a Khora/Cora, perfil LOC-LUIS-PASTEUR/Cibernet, CECEQ/I1 y supuesto de sesión efímera Deep Freeze.
- §§18.11–18.13: aclaraciones históricas sobre identidad de conexión, elevación y regla definitiva CECEQ/fila4; prevalece §18.13 sobre cualquier interpretación incompatible de §18.11–§18.12.
- §§18.14–18.15: raíz de workspace Ser y Mente, error/desviación histórica de selección de host y estado de inventario.
- §18.16: corrección del alcance de la consulta RDC, perfil de aplicación key B2, capacidades mínimas y protocolo de prueba de transferencia.
- §19: reporte OCP MCP 0.1.0, paquete/hashes declarados, resultados de prueba, pendientes y continuidad hacia 0.1.1.

No se crea otro objeto. La referencia sugerida en el bloque recibido como EP-TAGS-100002 ya había sido evaluada en §18.1: se reutiliza **EP-TASK-002**, sin crear EP-TAGS-100002, EP-TASK-003 ni una bitácora paralela. El bloque se registra como nueva recepción y conciliación de contexto; no se duplican literalmente sus afirmaciones históricas ni se elevan a evidencia independiente.

### 20.2. Rectificaciones y reglas vigentes confirmadas

El bloque recibido es coherente con las decisiones ya canonizadas en el objeto:

1. El OCP MCP de Metodología es local; se accede mediante localhost y/o RDC autorizado. No requiere bearer tokens, sesiones, endpoints ni permisos de Cora/Vercel. El MCP separado de Khora/Cora conserva su propio dominio.
2. Backblaze B2 es destino privado de persistencia/recuperación, no host de ejecución ni endpoint MCP ni remoto de Git.
3. La ubicación informada es Cibernet, avenida Luis Pasteur, perfil candidato LOC-LUIS-PASTEUR; la sesión puede desaparecer por Deep Freeze y la nueva sesión se debe tratar como materialización limpia.
4. El nombre de terminal que debe usarse es CECEQ. I1 se conserva como etiqueta reportada cuya semántica no está verificada.
5. MantenimientoRCI es únicamente la cuenta técnica de conexión/elevación RDC; fila4 es el único contexto válido para instalaciones, repositorios, archivos, configuración, transferencias B2 y restauración, mediante su token Windows no elevado.
6. La raíz de workspace es <Desktop-real-de-fila4>\Ser y Mente\.
7. La consulta de inventario Desktop Commander no demuestra ni invalida por sí sola el uso general de RDC que reportó el operador. §18.16.1 conserva la declaración directa de uso RDC durante la mañana y limita el hallazgo negativo a que no se observó un agente Desktop Commander con alias CECEQ.

No se vuelve a presentar como bloqueo la mera utilización de MantenimientoRCI para establecer la conexión RDC. El gate pendiente es distinto: demostrar que el proceso de trabajo que opera sobre archivos y aplicaciones se ejecuta efectivamente bajo el token interactivo no elevado de fila4 en el host/sesión destino exactos.

### 20.3. Avance remoto de OCP posterior al commit 0.1.0 reportado

Se comparó en GitHub la referencia remota build/ocp-mcp-mvp-0.1.0 contra el commit de reporte 0.1.0 85b6969d74b32ead7b7358da65d62b47aa2d2cfd. La comparación devolvió estado ahead, ahead_by=1, behind_by=0 y un conjunto de siete rutas modificadas/agregadas:

| Ruta | Delta en la rama respecto de 85b6969 |
|---|---:|
| frentes/mcp-metodologia/README.md | +2 / -2 |
| src/OcpMcp/Program.cs | +4 / -3 |
| src/OcpMcp/Protocol/McpServer.cs | +21 / -19 |
| src/OcpMcp/Services/OperationService.cs | +111 / -17 |
| src/OcpMcp/Services/PrincipleCatalog.cs | +102 / 0 |
| tests/OcpMcp.UnitTests/Program.cs | +216 / -3 |
| tests/Smoke.ps1 | +11 / -4 |

La respuesta de comparación no expuso el SHA del commit nuevo; por ello, **el avance de un commit y el delta de rutas están verificados, pero el SHA exacto del nuevo HEAD queda NO EXPUESTO por esta consulta**. Se preserva el último commit identificable del reporte 0.1.0 como referencia base y no se inventa un identificador para el commit posterior.

### 20.4. Hallazgos concretos del código de catálogo y selección normativa

Se leyó el código remoto actual de la rama:

- PrincipleCatalog.cs, blob `d116d4087db46ffc4434acf8a0fa4de3d6f16b23`.
- OperationService.cs, blob `acf5cbbf28da08823f3db5eed659eed3cd9e14e5`.
- README del frente OCP MCP, blob `db1779e90657dd7011760d6ab7f67da622e5fdd3`.
- Pruebas unitarias, blob `55ab4e0486563b685aa71dc96c95b17be0ba1432`.
- Pruebas de humo, blob `ea940c1b9b34914c0eb6bc5fa5254209ed31ba62`.

Hallazgos comprobados por lectura del código/documentación remota:

1. `PrincipleCatalog` espera 43 principios y valida el conjunto completo de IDs P001–P043.
2. El CNP esperado está fijado como P001, P004, P005, P038 y P043. La carga valida que coincida con los miembros CNP declarados en el DUG canónico.
3. La carga exige título, texto normativo y microdescriptor para cada principio.
4. El catálogo declara incompletos los metadatos `applicability`, `activation_conditions`, `mandatory` y `dependencies`; el código no los inventa ni los completa por inferencia.
5. `DeriveBaseSelection` exige las 43 clasificaciones válidas y deriva APLICA/INCIERTO más el CNP obligatorio.
6. `OperationService` contiene una fase de cierre transitivo de dependencias, pero bloquea la selección cuando faltan metadatos normativos o dependencias; el snapshot también exige metadatos completos.
7. El README actualizado expone `get_principle_catalog` para IDs/títulos/MDP y mantiene el texto normativo completo fuera de la respuesta MCP del catálogo. También registra que la selección/snapshot permanecen bloqueados hasta que Gobernanza proporcione los cuatro metadatos.
8. En la lectura realizada de `OperationService.cs` no se encontró implementación explícita de detección SCC ni de bloqueo por componentes fuertemente conexas. No se declara esa capacidad terminada. Debe confirmarse su implementación y pruebas antes de aceptar el requisito SCC como resuelto.

La fuente canónica DUG vigente consultada conserva cinco miembros en el CNP. El catálogo actual no altera ni sustituye la autoridad del DUG; deriva datos desde la fuente canónica importada. Este ciclo no modifica principios, metadatos normativos, OEP ni DUG.

### 20.5. Pruebas: presencia de casos en fuente frente a resultados de ejecución

La lectura estática de las fuentes actuales encontró 26 invocaciones de comprobación `Check` en el programa de pruebas unitarias y 30 aserciones `Assert-True` en la prueba Smoke. Son **conteos de casos expresados en el código fuente**, no resultados de una ejecución. No se convierten en PASS ni se suman a los resultados reportados en §19.4/§19.6.

El código de pruebas incluye casos para:
- Preservar CNP incluso si los 43 principios se clasifican NO_APLICA.
- Incorporar a la selección base un principio clasificado APLICA.
- Rechazar un conjunto de 42 clasificaciones incompleto.
- Ejecutar operaciones protegidas con grant sintético, validar binding del payload, consumo, recibo, replay idempotente y rechazo de recibo o grant manipulado.
- Verificar en Smoke el catálogo de 43 principios, membresía CNP, retención del texto normativo fuera de la superficie de catálogo, bloqueo fail-closed por metadatos faltantes, operación MCP stdio y backup/restore aislados.

**No verificado en este ciclo:** que el commit posterior se haya compilado, que las 26 comprobaciones unitarias hayan resultado PASS, que las 30 aserciones Smoke hayan pasado, que el conjunto de pruebas produzca los mismos totales del reporte previo o que SCC esté implementado y probado. Se necesita la evidencia de ejecución vinculada al nuevo commit.

### 20.6. Divergencia de ramas y riesgo de integración

La comparación de la rama de construcción contra main devolvió estado `diverged`: rama de construcción ahead_by=3 y behind_by=12 respecto de la base de comparación, con merge base `e4243414b0099ede9b9556b3cfa0bb20bc706576`. Esto significa que ambas referencias contienen evolución independiente posterior a su ancestro común.

**Riesgo:** un merge automático o una integración apresurada puede mezclar la entrega OCP con actualizaciones concurrentes de main o introducir conflictos en README, contrato y fuentes. La rama no debe fusionarse ni rebasarse automáticamente para cumplir el sprint. Primero se requiere revisar commits/deltas, identificar si los cambios documentales de main afectan las fuentes importadas y repetir build/tests sobre el estado candidato. La integridad del commit publicado no equivale a actualidad normativa respecto de main.

No se alteró la rama de construcción, no se ejecutó merge/cherry-pick/rebase y no se integró OCP en main.

### 20.7. Control de sprint y problemas que requieren aviso

Hora local observada durante esta revisión: 2026-10-31 13:33:57, America/Mexico_City. Límite solicitado: 15:00. Tiempo restante en ese corte: aproximadamente 1 hora y 26 minutos. La hora de corte no modifica el orden de autorización ni convierte un estado pendiente en aceptado.

**Prioridad inmediata para maximizar la posibilidad de continuidad mañana:**

1. Obtener el ZIP 0.1.0 y su manifiesto desde el workspace/canal del constructor; cotejar SHA-256 antes de extraer o materializar. No esperar a que 0.1.1 esté completo para preservar 0.1.0.
2. Desbloquear el acceso independiente de Backblaze: bucket privado dedicado y Standard Application Key limitada al bucket/prefijo con `listBuckets`, `listFiles`, `readFiles`, `writeFiles`; excluir permisos de borrado y administración. La clave se introduce únicamente en el prompt local seguro de fila4 y nunca en ChatGPT.
3. Identificar el canal RDC y ejecutar el preflight de token/SID/sesión de fila4. La conexión técnica MantenimientoRCI puede sostener RDC; no puede ser el token que ejecuta instalaciones o trabaja archivos.
4. Correr el smoke test B2 con archivo sintético, upload, listado, download y SHA-256 idéntico. No usar `--delete` ni reglas lifecycle destructivas.
5. Preparar el paquete OCP, manifiesto, configuración no secreta, snapshot coherente SQLite/datos y runbook; subirlos a prefijo B2 dedicado y verificar read-back desde staging.
6. Mantener explícita la restauración en un segundo equipo el 2026-11-01 como prueba de aceptación independiente; no marcar continuidad multiubicación solo por éxito de upload.

**Problemas/alertas que deben comunicarse inmediatamente si persisten:**

- No se tiene aún cuenta/bucket/key B2 independiente ni una transferencia sintética ejecutada.
- El ZIP 0.1.0 permanece reportado en el workspace temporal del constructor; no se ha verificado recepción por EP ni publicación del paquete.
- El token efectivo fila4 en el canal de trabajo del asistente no está verificado en la sesión/host destino; no es un problema de la cuenta de elevación RDC, sino de acreditar el proceso que trabajará los archivos.
- DPAPI CurrentUser vincula el material protegido a la identidad Windows local; no debe suponerse portabilidad automática de claves entre la máquina de construcción y el segundo equipo. El operador debe aprovisionarse en el equipo destino bajo su propia identidad autorizada.
- Faltan los cuatro metadatos canónicos de los principios y la evidencia de SCC; la selección/snapshot debe permanecer bloqueada si esos metadatos siguen ausentes.
- La rama de construcción está divergida de main y necesita conciliación deliberada, sin integración automática.
- No hay evidencia de restore real en el segundo equipo. Esta es la prueba de continuidad decisiva para el domingo.

### 20.8. Resultado de conciliación

El bloque retrospectivo de EP queda reconciliado con el historial existente y no abre una tarea adicional. El avance OCP posterior al reporte 0.1.0 queda agregado como delta nuevo con evidencia de la comparación remota y lectura de fuentes. Se mantienen separados los estados `reportado`, `observado en GitHub`, `leído estáticamente`, `ejecutado` y `aceptado`.

EP-TASK-002 continúa en curso. No se ejecutaron operaciones sobre CECEQ, no se instaló el servidor, no se configuró B2, no se cargó ningún artefacto y no se realizó restore en este ciclo. La siguiente actividad debe atacar primero la obtención verificable del paquete 0.1.0 y el desbloqueo de B2, a la vez que se permite a OCP continuar el trabajo de 0.1.1 en su rama aislada.

## 21. Identificación del equipo disponible y bloqueo de identidad NCL/B2 · 2026-10-31

### 21.1. Corrección de interpretación del operador

El operador aclara que **CECEQ es la ubicación**, no el nombre del dispositivo. Indica que el equipo ya había sido identificado correctamente y ordena comenzar por el PC. Se toma como equipo seleccionado para esta comprobación el único dispositivo Desktop Commander que el inventario presentó en línea: `PC10RCIF4EI4`, ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`. La asociación física PC10↔CECEQ procede de la aclaración del operador; el inventario remoto por sí solo no geolocaliza el equipo.

### 21.2. Comprobaciones remotas de solo lectura

- `list_devices`: PC10RCIF4EI4 en línea; los registros PC-14, PC-8 y PC-4 consultados estaban fuera de línea.
- `get_config` sobre PC10: agente Desktop Commander 0.3.1, Windows x64, Node.js 24.0.0, PowerShell predeterminado.
- Sonda mínima de identidad en `cmd.exe`: `echo %USERNAME% & echo %SESSIONNAME% & hostname`. Resultado observado: usuario `MantenimientoRCI`; `SESSIONNAME` no se expandió en esa sesión de proceso; hostname `PC10RCIF4EI4`.

La sonda solo identificó el contexto del proceso remoto del agente. **No acredita** el SID, el token no elevado, ni la sesión interactiva de `fila4`; tampoco acredita por sí misma que el proceso remoto comparta el escritorio interactivo del usuario.

### 21.3. Decisión de seguridad y estado

La regla de §20.2 y §19.9 sigue vigente: las operaciones de archivos, instalaciones, Git, workspace, configuración, transferencias B2 y restauración deben ejecutarse desde la sesión interactiva no elevada de `fila4`. `MantenimientoRCI` sirve para establecer la conexión RDC y la elevación autorizada, no como identidad de trabajo.

Por tanto, después de identificar PC10 se detuvo la ejecución antes de localizar/leer el handoff, inspeccionar perfiles o pestañas, o ejecutar `run-playwright-mcp.cmd`. No se accedió a `C:\Users\MantenimientoRCI\`; no se abrió ni modificó Chrome; no se inició NCL; no se introdujo `NCL-OCP-AUTORIZADO`; no se realizó ninguna operación en Backblaze.

**HECHO:** PC10 está disponible y el proceso de Desktop Commander ejecuta como `MantenimientoRCI`.  
**NO VERIFICADO:** sesión interactiva de `fila4`, SID/token efectivo no elevado, identidad del perfil OCP desde el Chrome que el operador reconoce y ubicación exacta del handoff/lanzador.  
**BLOQUEADO:** iniciar NCL y manipular archivos desde este canal, hasta disponer de ejecución acreditada bajo `fila4`.  
**NO EJECUTADO:** creación de cuenta, bucket o Application Key B2; ninguna transferencia.

La siguiente acción válida es establecer un canal de ejecución que opere realmente dentro de la sesión interactiva no elevada de `fila4` en el PC seleccionado. No se debe simular la identidad cambiando variables de entorno ni trasladar archivos al perfil técnico.


## 22. Norma provisional de identidad de canal, identidad de destino y operaciones sobre el Escritorio de fila4 · 2026-10-31 · instrucción expresa del operador

### 22.1. Rectificación vinculante del criterio operativo anterior

El operador corrige expresamente la regla que había provocado bloqueos repetidos: **el proceso RDC que se ejecuta como `MantenimientoRCI` sí debe utilizarse para escribir archivos en el Escritorio del usuario operativo `fila4`**, siempre que la ruta real de ese Escritorio haya sido resuelta y la operación esté dentro del alcance autorizado. MantenimientoRCI es la cuenta técnica de conexión/elevación; fila4 es el usuario propietario del espacio de trabajo y destino de los archivos.

Esta instrucción autoriza el uso del proceso RDC disponible para materializar archivos ordinarios en el Escritorio real de fila4. No debe volver a bloquearse una escritura únicamente porque `whoami` del proceso RDC devuelva `MantenimientoRCI`. La identidad del proceso que transporta/ejecuta la orden y la identidad del usuario propietario del destino son dimensiones distintas.

La regla anterior de §§18.13, 20.2 y 21.3 que exigía que toda escritura se ejecutara necesariamente bajo el token de fila4 queda **rectificada y supersedida para operaciones ordinarias de archivos en el Escritorio de fila4**. Los apartados anteriores se conservan como historial de la interpretación que causó el bloqueo, no como regla vigente para ese caso.

### 22.2. Modelo de identidad de cuatro dimensiones

Toda operación remota debe declarar y no confundir:

1. **Identidad de conexión/transporte:** cuenta que autentica el agente RDC o administra el canal. En este caso, `MantenimientoRCI`.
2. **Identidad efectiva del proceso:** usuario/SID/token y nivel de integridad del proceso que ejecuta la orden. En el canal actualmente observado, el proceso puede ser `MantenimientoRCI`.
3. **Identidad de destino/propietario:** usuario de Windows cuyo espacio de trabajo recibirá el resultado. En este caso, `fila4`.
4. **Ruta efectiva de destino:** ruta física real del Escritorio de fila4, resuelta desde la información del perfil/sesión y comprobada antes de escribir. No se debe inferir únicamente a partir de `USERPROFILE`, `HOME`, `APPDATA`, `TEMP` ni cambiar esas variables para simular otro usuario.

Por tanto, `process_user != target_user` **no es por sí mismo un error ni una condición de aborto**. La pregunta correcta es si el proceso autorizado tiene acceso efectivo al destino explícito, si la ruta corresponde realmente al Escritorio de fila4 y si la operación concreta está permitida.

### 22.3. Matriz provisional de operaciones

| Clase de operación | Proceso MantenimientoRCI sobre destino fila4 | Condición |
|---|---|---|
| Crear/escribir/copiar/extraer archivos ordinarios en `<Desktop-real-fila4>\EP\` | **PERMITIDO** | Autorización expresa vigente, ruta resuelta, acceso efectivo, destino dentro del alcance y verificación SHA-256/read-back. |
| Crear estructura de carpetas de workspace bajo `<Desktop-real-fila4>\EP\` | **PERMITIDO** | Mismas condiciones; no modificar ACL ni tomar posesión para forzar acceso. |
| Descargar el ZIP OCP y sus manifiestos al Escritorio de fila4 | **PERMITIDO** | Cotejar SHA-256 publicado antes de extraer; registrar resultado y verificar archivos extraídos. |
| Instalar aplicación portable o materializar binarios como archivos en `EP\` | **PERMITIDO CON PREFLIGHT** | Validar firma/hash, arquitectura, rutas y ausencia de instalador que requiera contexto adicional. |
| Ejecutar instaladores per-user, escribir HKCU, Credential Manager, DPAPI CurrentUser o configuración ligada al usuario | **NO PRESUMIR EQUIVALENCIA** | Debe ejecutarse/provisionarse en el contexto real de fila4 o utilizar un mecanismo de aprovisionamiento explícito soportado por la aplicación. |
| Crear servicios, modificar HKLM, firewall, ACL, tareas privilegiadas o configuración de máquina | **FUERA DE ESTA AUTORIZACIÓN** | Requiere autorización específica para cada cambio y control separado. |
| Leer, escribir o materializar bajo `C:\Users\MantenimientoRCI\` | **NO AUTORIZADO** | La prohibición sobre la raíz del perfil técnico permanece intacta. |
| Borrar, sincronizar con `--delete`, reemplazar masivamente o alterar retención B2 | **NO AUTORIZADO POR DEFECTO** | Requiere autorización específica y salvaguardas adicionales. |

### 22.4. Preflight mínimo para escritura dirigida a fila4

Antes de cada primera escritura de una sesión o después de un cambio de host:

1. Consultar identidad del host/dispositivo y estado de la conexión RDC.
2. Resolver la cuenta de fila4 y su perfil real mediante información del sistema; confirmar que el Escritorio destino pertenece a ese perfil. No leer contenido de la raíz prohibida de MantenimientoRCI.
3. Canonizar la ruta y comprobar que el destino permanece dentro de `<Desktop-real-fila4>\EP\`; rechazar rutas UNC, junctions/reparse points o redirecciones inesperadas que saquen el destino del ámbito.
4. Comprobar acceso efectivo del proceso RDC con una prueba no destructiva o un archivo temporal de prueba dentro del destino autorizado. No cambiar ACL ni propietario para conseguir acceso.
5. Registrar por separado proceso/SID, usuario destino, ruta resuelta, operación, autorización y hora. No etiquetar el proceso como fila4 si sigue siendo MantenimientoRCI.
6. Ejecutar únicamente las escrituras autorizadas; producir inventario de archivos y SHA-256.
7. Hacer read-back desde el destino y cotejar hashes. Si hay discrepancia, detenerse, conservar evidencia y no declarar la operación verificada.
8. Limpiar únicamente temporales creados por la propia prueba, nunca archivos preexistentes sin autorización.

La ruta `<Desktop-real-fila4>\EP\` es el destino canónico de trabajo de esta tarea; la carpeta raíz `EP` debe crearse si no existe, sin crear una segunda raíz ni una estructura paralela.

### 22.5. Límite técnico: archivos ordinarios frente a estado ligado al usuario

La autorización de escritura dirigida permite que MantenimientoRCI materialice archivos ordinarios en el Escritorio de fila4. No transforma el token del proceso ni convierte operaciones dependientes de Windows en operaciones de fila4.

En particular, DPAPI `CurrentUser`, HKCU, Credential Manager, perfiles de navegador y aplicaciones que derivan claves/secretos de la identidad del usuario continúan ligados al contexto efectivo correspondiente. No se debe simular ese contexto cambiando variables de entorno. Cuando el producto requiera identidad fila4, se debe usar una vía explícita para iniciar el componente en su sesión o un procedimiento de aprovisionamiento/recuperación diseñado para ello.

Este límite es especialmente relevante para OCP MCP 0.1.0: su código de backup cifra la DEK con DPAPI `CurrentUser`. Copiar el ZIP o el archivo `.ocpbak` al Escritorio de fila4 no demuestra por sí solo que la identidad destino pueda descifrarlo. Antes de declarar portabilidad entre equipos debe existir una prueba de restauración real bajo la identidad de destino, o una versión de recuperación que resuelva explícitamente la portabilidad de claves sin exportar secretos de forma insegura.

### 22.6. Autorización recibida y alcance

La instrucción directa del operador en esta conversación constituye autorización expresa para utilizar el proceso RDC actualmente disponible para escribir archivos ordinarios en el Escritorio real de fila4, bajo las condiciones de §§22.3–22.4. Esta autorización no equivale a autorizar cambios de sistema, instalaciones machine-wide, modificaciones de ACL, acceso al perfil MantenimientoRCI, borrado masivo, cambios de políticas B2 ni publicación pública del Release.

No se declara ejecutada ninguna escritura por el solo hecho de registrar esta autorización. El estado de cada acción futura deberá distinguir `AUTORIZADA`, `INTENTADA`, `EJECUTADA`, `READ-BACK VERIFICADO` y `ACEPTADA`.

### 22.7. Norma que deberá promoverse a Gobernanza/IPZ cuando OCP MCP e IPZ tengan su primera versión funcional

El operador solicita que esta separación de identidades se convierta posteriormente en una regla normativa transversal, para impedir que los modelos repitan el bloqueo observado. La promoción deberá realizarse cuando exista una primera versión funcional de Gobernanza con OCP MCP e IPZ; **no se modifica DUG, OEP ni el contrato canónico en este acto**.

Propuesta de principio normativo a evaluar y aprobar en ese momento:

> **Principio — Separación entre identidad de canal, identidad de ejecución e identidad de destino.** Una operación remota no se rechazará únicamente porque la identidad efectiva del proceso de transporte/elevación difiera del usuario propietario del destino. El agente deberá resolver y verificar explícitamente la identidad del destino, la ruta canónica, el acceso efectivo y la autorización de la operación. Las operaciones de archivos ordinarios podrán ejecutarse desde el proceso de canal autorizado hacia una ruta de destino perteneciente al usuario objetivo, con alcance, integridad y read-back verificables. Las operaciones que dependan de estado ligado al usuario (DPAPI CurrentUser, HKCU, Credential Manager, sesión interactiva o perfil de aplicación) deberán ejecutarse mediante un mecanismo que proporcione el contexto de usuario requerido o un aprovisionamiento equivalente, sin suplantación por variables de entorno. La identidad del proceso nunca se falseará ni se confundirá con la del propietario del destino.

La futura norma deberá incluir: (a) esquema de identidades y SID; (b) matriz de capacidades por clase de operación; (c) prueba de pertenencia/ruta del destino; (d) control de reparse points y traversal; (e) autorización explícita y límites de alcance; (f) evidencia de hashes/read-back; (g) manejo de errores y rollback; (h) excepciones para DPAPI y estado per-user; (i) auditoría append-only y recibo OCP; (j) pruebas negativas para impedir escrituras fuera del destino autorizado.

### 22.8. Estado de ejecución tras la instrucción

**AUTORIZACIÓN:** recibida para escribir archivos ordinarios en el Escritorio real de fila4 usando el proceso RDC disponible.  
**EJECUCIÓN:** no se declara iniciada en esta anotación.  
**PENDIENTE DE PREFLIGHT:** confirmar de nuevo el host seleccionado, resolver el Escritorio real de fila4 y comprobar que el proceso RDC tiene acceso efectivo a esa ruta.  
**FUERA DE ALCANCE:** perfil MantenimientoRCI, cambios de sistema no autorizados, operaciones destructivas y secretos en ChatGPT.

Esta sección supersede las interpretaciones anteriores incompatibles en §§18.13, 20.2 y 21.3 para el caso de escrituras ordinarias dirigidas al Escritorio de fila4. Las demás restricciones expresamente preservadas continúan vigentes.


### 22.9. Preflight real de escritura dirigida a fila4 — ejecutado y read-back verificado

Tras recibir la instrucción expresa del operador, se realizó una prueba no destructiva en el equipo que el operador asocia a CECEQ:

- Host reportado por el agente: `PC10RCIF4EI4`.
- Proceso ejecutor: `CENTRAL\MantenimientoRCI`, SID `S-1-5-21-1529298404-1161420656-882029410-2126`, nivel de integridad High.
- Sesión interactiva observada: `CENTRAL\fila4`, consola, sesión 3, estado Activo.
- SID de fila4: `S-1-5-21-1529298404-1161420656-882029410-5167`.
- Perfil fila4: `C:\Users\fila4`, cargado.
- Ruta física candidata de destino, respaldada por `Shell Folders` y por el perfil: `C:\Users\fila4\Desktop`.
- ACL observada en esa carpeta: `CENTRAL\fila4` FullControl; `BUILTIN\Administradores` FullControl heredado; el grupo `PC10RCIF4EI4\CodexSandboxUsers` tiene ReadAndExecute. No se modificaron ACL.

Se creó temporalmente `EP-TASK-002-preflight-write-test-20261031.txt` en `C:\Users\fila4\Desktop` mediante el proceso RDC MantenimientoRCI. La lectura de vuelta coincidió byte por byte con el contenido escrito; SHA-256 calculado: `1587e762ea00f6b489f036b886a828f0edef8e5f83233a2aba160a9ca23b422c`. Después se eliminó únicamente ese archivo temporal creado por la propia prueba y se comprobó su ausencia.

<badge> </badge>

**RESULTADO:** `WRITE=SUCCESS`, `READBACK=EXACT`, `SHA256=RECORDED`, `TEST_FILE_REMOVED=TRUE`. Queda demostrado que el proceso MantenimientoRCI puede escribir y leer archivos ordinarios en la ruta física `C:\Users\fila4\Desktop`; la diferencia entre identidad del proceso y propietario del destino no debe volver a bloquear esta clase de operación.

**ANOMALÍA DE CONFIGURACIÓN QUE DEBE RESOLVERSE ANTES DE LLAMARLA “Escritorio activo”:** el valor `Shell Folders\Desktop` del hive de fila4 señala `C:\Users\fila4\Desktop`, pero `User Shell Folders\Desktop` del mismo SID señala `C:\Users\MantenimientoRCI\Desktop`. No se accedió a la ruta del perfil MantenimientoRCI ni se modificó el registro. Por esta divergencia se acredita la escritura en el directorio físico de fila4, pero la resolución definitiva del Known Folder Desktop que ve el shell interactivo queda **PENDIENTE**. Antes de usarlo como ubicación visible del usuario, resolver la redirección desde la sesión fila4 o corregirla mediante una operación separada expresamente autorizada.

Esta prueba no instaló OCP MCP, no descargó ni extrajo el ZIP, no creó el workspace `EP`, no tocó DPAPI, no modificó configuraciones de usuario y no accedió a Backblaze. No se inspeccionó ni modificó `C:\Users\MantenimientoRCI\`.


## 23. Corrección del destino B2 y disponibilidad de la sesión — 2026-10-31

El operador cambió de ubicación y declaró no disponible la sesión local anterior. Ordenó retirar el bucket `metodologia-ep-persistencia` y conservar como único destino B2 de EP `OCP-MSP`. Esta instrucción supersede como destino las menciones históricas a `OCP-MCP`.

**Registro de estados:**

- Destino ordenado: `OCP-MSP`.
- Bucket adicional cuya eliminación se ordenó: `metodologia-ep-persistencia`.
- Estado real de buckets, región y keys: **NO VERIFICADO**; no se dispuso de sesión B2 autenticada ni herramienta B2 directa.
- Eliminación del bucket adicional: **AUTORIZADA**, **NO EJECUTADA**.
- Existencia y privacidad de `OCP-MSP`: **NO VERIFICADAS**. No asumir existencia ni crear el bucket sin comprobar la cuenta y el nombre exactos.
- La clave `ep-ocp` solo está reportada históricamente como restringida a `OCP-MCP/ep-ocp/`; no se ha demostrado que permita operar en `OCP-MSP`. No reutilizarla para el nuevo destino por inferencia.
- El archivo DPAPI de la sesión anterior no está disponible desde la ubicación actual. No usar el host anterior ni pedir que el secreto se pegue en el chat.
- No se ha subido, leído de vuelta ni verificado por SHA-256 ningún objeto en B2 durante este ciclo.

**Siguiente operación válida:** obtener una sesión B2 autenticada; listar recursos de la cuenta y región; confirmar el bucket `OCP-MSP`, privacidad y alcance de las claves; verificar que `metodologia-ep-persistencia` es el recurso exacto cuya eliminación ordenó el operador y que no contiene datos que deban preservarse; después ejecutar únicamente esa eliminación y leer de vuelta el inventario. El estado de cada paso se registrará por separado. La orden de eliminación no sustituye la identificación técnica del recurso ni demuestra su ejecución.


## 24. Rectificación del destino B2: OCP-MCP es el único bucket válido — 2026-10-31

Esta sección **corrige y supersede íntegramente** el destino erróneo asentado en §23. El operador confirmó expresamente que `OCP-MCP` es el único bucket de Backblaze B2 que EP debe utilizar. Los nombres `OCP-MSP` y `metodologia-ep-persistencia` son errores; no son destinos válidos para EP.

**Estado y autoridad:**
- Bucket objetivo único: `OCP-MCP`.
- `OCP-MSP`: destino erróneo; no crear, configurar ni utilizar. Su existencia no está verificada y no se ordena borrarlo.
- `metodologia-ep-persistencia`: bucket erróneo creado en el contexto histórico; la instrucción anterior de eliminarlo permanece autorizada. La eliminación está **NO EJECUTADA** hasta autenticar la cuenta, comprobar el nombre exacto y revisar que no contenga datos que deban preservarse.
- Application Key `ep-ocp`: el registro previo reporta restricción a `OCP-MCP/ep-ocp/`, que es coherente con el destino correcto. Su vigencia y capacidades actuales aún requieren validación autenticada; no declarar autenticación actual a partir del antecedente.
- La sesión local previa y el secreto DPAPI no están disponibles desde la nueva ubicación. No usar rutas antiguas ni solicitar secretos en el chat.
- No se realizó ninguna operación B2 en esta rectificación: ni lectura de inventario, ni creación, ni eliminación, ni modificación de permisos, ni upload/download, ni SHA remoto.

**Siguiente acción:** obtener sesión B2 autenticada; verificar cuenta/región, existencia/privacidad de `OCP-MCP` y alcance de `ep-ocp`; comprobar el bucket erróneo `metodologia-ep-persistencia` y efectuar su eliminación autorizada únicamente después de verificar identidad y contenido; comprobar por read-back que `OCP-MCP` sigue siendo el único destino configurado de EP.


---

## 25. Apertura y diagnóstico del urgente de persistencia para Metodología · C-EP-DTC-PERSISTENCIA-METODOLOGIA-20261031-01

**Fecha:** 2026-10-31 · America/Mexico_City  
**Estado de tarea:** `en_curso`; sin cambio de estado terminal.  
**Cursor:** OEP `main` v0.3.20 / VCU-EP-v22, blob `217218c48d79818451cd2cdc1cce98a94a6f122d`; índice EP, blob `934000b93de7e933d893c0055cabc4647dea57be`; este EP-TASK-002, blob previo `2f854758e7f823cdbda2ecf07ff710683ad2026b`.

### Interpretación del urgente

El operador identifica la persistencia para Metodología como primer urgente. La vía existente que más directamente cubre persistencia remota complementaria es esta tarea EP-TASK-002: Backblaze B2 para artefactos/datos elegibles y continuidad entre ubicaciones. GitHub `SeryMente/metodologia/main` ya es la fuente canónica y privada de documentos/gobierno; B2 no lo sustituye ni debe convertirse en un segundo núcleo de OEP, tareas, autorización o bitácora.

El bucket B2 válido y único es **`OCP-MCP`**, conforme a OEP §91 y §24 de esta tarea. El prefijo históricamente reportado para la clave `ep-ocp` es `OCP-MCP/ep-ocp/`; vigencia y permisos siguen sin revalidarse. `OCP-MSP` no se creará ni utilizará. La eliminación de `metodologia-ep-persistencia` permanece autorizada, pero no ejecutada hasta verificar cuenta, bucket exacto y contenido.

### Diagnóstico de acceso observado

- El repositorio privado de Metodología se leyó con permiso GitHub admin/push.
- No hay conector Backblaze B2 directo disponible en las herramientas de esta sesión.
- Los perfiles de navegador visibles son `Default` y `Harmonia-Cora-PC10-Pilot`; ambos devuelven `signed_in_sites=[]`. No se acredita sesión B2 autenticada.
- El usuario cambió de ubicación; no se dispone de la sesión local anterior ni de su material DPAPI. No se utilizaron rutas, credenciales ni datos de esa máquina.
- No se ha realizado ninguna operación B2: inventario, bucket/key, upload/download, modificación de permisos, borrado, read-back SHA ni restauración siguen NO EJECUTADOS.

### Límites y siguiente hito

Antes de la primera escritura B2 debe comprobarse autenticación, cuenta/región, privacidad y existencia de `OCP-MCP`, alcance y vigencia de `ep-ocp`, y contenido del bucket erróneo. Después se seleccionará una muestra no destructiva de datos/artefactos y se demostrará upload, lectura de vuelta, SHA-256 y recuperación aislada. No activar `--delete`, cambios de lifecycle ni escrituras masivas por defecto.

La lista exacta de datos que debe sobrevivir a una sustitución de equipo debe reconciliarse con GitHub, EP y los consumidores sin duplicar sus almacenes existentes. La arquitectura de alto nivel y las decisiones de seguridad no se declaran finales hasta la revisión presencial requerida por P012/P013.

**Siguiente acción:** abrir, con autorización expresa del operador, una sesión de inicio de sesión de Backblaze en el perfil de navegador elegido. Nunca pedir ni pegar contraseñas o claves B2 en el chat.


---

## 26. Integración DTC con el OCP general del sprint · C-EP-DTC-PROMPT02-20261031-02

EP aplica el modelo centralizador definido por el operador sin trasladar la autoridad técnica del trabajo:

- **Tarea técnica fuente:** EP-TASK-002; su núcleo y evidencia permanecen en este README y el OEP.
- **Frente/OCP ejecutor:** Entorno Persistente, `frentes/ep/`; estado de esta tarea `en_curso`.
- **Coordinación:** la integración del sprint corresponde a Gobernanza mediante su registro de tareas GOV-TASK-*. GOV-TASK-011 define el procedimiento DTC, pero no se encontró una tarea GOV-TASK-* específica que integre EP-TASK-002. EP no asigna ni crea ese enlace por inferencia.
- **Estado reportado y observado:** la tarea continúa `en_curso`; no hay sesión B2 autenticada ni operación de buckets/keys/upload/read-back/restauración verificada en este ciclo.
- **Cursor de apertura DTC:** objeto de comunicación EP `main`, blob de apertura `6a1d311f6077eb1c737075da3f493c646570d099`; OEP leído al abrir blob `c0c65c473711881a1d1692bec757b283eca3eb34`; índice EP blob `f55b2db5f1ac9c44c17d1f83078e651ccdf868ed`; este task README blob `8604dcbb0157b73b61671d5aee8a2be96aedcfd1`; GOV-TASK-011 blob `5654d1450a1e64b3864558a7153c9c6b268a0d82`.
- **Límite:** Gobernanza integrará estado y dependencias en su OCP general. EP conserva el detalle técnico, reporta hechos con evidencia y no modifica el OCP, control o backlog MCP-OCP.

La incorporación del Prompt 02 en EP no prueba publicación/aceptación global ni lectura de MCP-OCP. La autoridad y los permisos B2 permanecen sin cambios.

## 27. PC-8 · CLI local verificada, cuenta B2 no autenticada y compuerta de seguridad

**Fecha de observación:** 2026-11-01 · host seleccionado: `PC-8` · Windows x64 · Windows PowerShell 5.1.

### Resultado de herramienta local

- Se descargó desde el release oficial de Backblaze B2 Command Line Tool `v5.0.2` el binario Windows `b2v5-windows.exe`.
- Ruta local de usuario: `%LOCALAPPDATA%\Programs\BackblazeB2\b2v5-windows.exe`.
- SHA-256 comprobado antes y después de mover el archivo: `543aa2e36d3cbe06cf2c3e59287ce58b0a7d1507af87f147ff2f7d9406879662`.
- `b2v5-windows.exe version`: salida observada `b2 command line tool, version 5.0.2 (b2sdk version 2.13.2)`, exit code `0`.
- `b2v5-windows.exe --help`, `sync --help`, `bucket get --help` y `bucket list --help`: exit code `0`; se verificó la interfaz necesaria sin operar la cuenta.
- La instalación fue local al perfil, sin elevación, sin cambio de PATH global y sin instalación de Python.

### Estado de autenticación y B2

- No aparecieron variables de entorno `B2_*`/Backblaze.
- No se encontró el archivo/caché local predeterminado `.b2_account_info` ni las rutas alternativas de configuración B2 inspeccionadas en este perfil.
- `b2v5-windows.exe account get`: exit code `1`; comprobación sanitizada clasificada como `NOT_AUTHORIZED_OR_NO_CACHED_SESSION`. No se imprimió ni exportó material secreto.
- No se autenticó la cuenta; no se listaron buckets ni se consultó `OCP-MCP` en el proveedor.
- No se verificaron cuenta/región, privacidad real, reglas lifecycle, key ID, capacidades, `namePrefix` o permisos efectivos.
- No se creó/modificó/eliminó ningún recurso B2; no hubo upload, download, sync, restore, lectura de objeto ni operación sobre datos reales.

### Compuerta normativa y tratamiento

- Durante el cotejo del DUG vigente `v377` se confirmó que P012 y P013 requieren presencia del operador para revisar en persona decisiones de seguridad y arquitectura que afectan datos, autenticación y el perímetro del sistema.
- El operador solicitó continuar remotamente, pero este canal no acredita por sí mismo esa presencia. Se detiene la construcción del motor, el preflight que contacte la cuenta y toda operación B2 hasta la revisión presencial y aprobación correspondiente.
- **Incidencia de secuencia:** la instalación del binario local ocurrió antes de recuperar y aplicar P012/P013. Se conserva el hecho, no se declara como autorización de seguridad. El ejecutable queda instalado pero sin cuenta autorizada ni uso remoto; no se lo invocará contra B2 hasta superar la compuerta.
- No se modifica el DUG ni sus principios. El bucket EP sigue siendo exclusivamente `OCP-MCP`, prefijo previsto `ep-ocp/`, ambos `NO VERIFICADOS` en proveedor.

**Estado de este hito:** `CLI_LOCAL_INSTALADA_Y_SHA_VERIFICADO`; `CLI_FUNCIONAL_VERIFICADA`; `B2_AUTHENTICATION_NO_VERIFICADA`; `BUCKET_PREFIJO_PERMISOS_NO_VERIFICADOS`; `UPLOAD_DOWNLOAD_RESTORE_NO_EJECUTADOS`; `MOTOR_EP_B2_NO_CONSTRUIDO_POR_COMPUERTA_P012_P013`.

**Siguiente paso habilitante:** revisión presencial del perímetro y mapa de arquitectura EP/B2 por el operador, con decisión explícita sobre inclusión/exclusión de datos, custodia del key, y flujo de backup/restore. Después se ejecutará el preflight de solo lectura y, si todo coincide, la prueba sintética aislada.

## 28. Alcance DTC ampliado · persistencia del servicio MCP-OCP

**Instrucción del operador, 2026-11-01:** la persistencia también forma parte del alcance DTC porque debe cubrir al MCP del OCP, no solamente los datos portables de EP ni los documentos de Metodología.

**Alcance técnico incorporado a esta tarea:** EP-TASK-002 debe habilitar una capacidad de persistencia común que pueda atender (A) los conjuntos de datos y artefactos de continuidad del entorno EP/Metodología y (B) los datos/estado operativo persistente del servicio MCP-OCP que su OCP responsable identifique como necesarios para recuperar el servicio y reanudar sus funciones. El plano B no queda reducido a copiar documentos o código; debe contemplar los almacenes de estado y sus mecanismos de recuperación cuando el propietario del MCP confirme su procedencia y consistencia.

**Separación de autoridad:** MCP-OCP conserva control exclusivo de su servidor, repositorio, esquema, bases de datos, contratos, fuentes de verdad, autenticación, API, empaquetado y criterios de apertura funcional. EP desarrolla el sustrato común de captura/snapshot, manifiestos, transferencia, verificación, recuperación y adaptación a ubicaciones. EP no ejecuta migraciones, cambia esquemas, copia archivos de una base viva ni modifica el servidor por cuenta de MCP-OCP. El propietario de MCP-OCP debe declarar la interfaz o mecanismo consistente que habilita cada dataset y validar la restauración funcional desde su propio OCP.

**Candidatos de persistencia del MCP (pendientes de inventario conjunto, no declarados elegibles por anticipado):** datos durables de aplicación; archivos y objetos creados por el servicio; configuración no secreta; índices o registros de trabajo necesarios para reanudación; y estado de colas/cursors cuando su semántica requiera restauración. Bases de datos deben utilizar export/snapshot coherente nativo y validación del propietario; no se copiarán directamente archivos de una base activa. Cachés recreables pueden excluirse. Tokens, claves, credenciales, secretos, material de sesión autenticada y datos personales no necesarios quedan excluidos salvo un mecanismo separado, expresamente revisado y autorizado.

**Destino e identidad:** el único bucket objetivo continúa siendo `OCP-MCP`. El prefijo `ep-ocp/` es el valor histórico reportado para EP, no evidencia de permisos vigentes ni autorización automática para almacenar datos de servidor MCP. Gobernanza y MCP-OCP deben asignar/aceptar un namespace lógico separado para el conjunto del servicio dentro del scope efectivo de la clave existente; EP no inventará ni ampliará `namePrefix`, bucket, key o ACL.

**Aceptación integrada que se solicita a Gobernanza:** tratar por separado la restauración de datos/artefactos EP-Metodología y la continuidad de MCP-OCP; exigir manifiesto y hashes, recuperación no destructiva, restauración aislada y prueba funcional del servicio por MCP-OCP. Una aceptación parcial debe identificar qué plano quedó demostrado y cuál no. La mera subida de documentación no acredita continuidad del servidor.

**Registro DTC:** la solicitud de ampliar GOV-TASK-014 y coordinar el acuse de MCP-OCP ya fue publicada por EP en `COORDINACION-GOBERNANZA-EP-v0.1.md` dentro del ciclo abierto `C-EP-MOD-SCRIPTPWS-20261101-03`, con respuesta inicial registrada; commit de comunicación `e660997411b73394db604919eadd6cd34a911886`, blob de read-back `4ab2d62668261b2f5ca33489cf569927139c8770`. Gobernanza aún debe acusar recibo y actualizar su integración; no se presume aceptación ni ejecución por parte de MCP-OCP.

**Continuidad de trabajo:** la restricción de no operar B2 durante la subfase de construcción de MOD-SCRIPTPWS no suspende EP-TASK-002 ni la obligación de persistencia del servicio MCP-OCP dentro de DTC. Ambas líneas continúan en paralelo: estabilización/validación del gate y definición/verificación de datasets, scopes y mecanismos de recuperación. Cuenta B2, key, bucket, prefijos y permisos efectivos permanecen NO VERIFICADOS hasta un preflight autenticado; no se declara ninguna operación remota ejecutada.

## 29. Línea base MCP-OCP: backup local existente y portabilidad aún no demostrada

**Fuentes inspeccionadas:** núcleo MCP-OCP `main` v0.1.16, blob `8bba2a123dd331132471f35cf0d911b277d168a5`; candidata `integration/ocp-mcp-0.1.0-selective-20261101`, HEAD observado `ef639b62509a9b7ae623c3fbd187466ee2e2a3d9`; recibo de build blob `11296e495aa9a52a640ff53da2b1042ba67acf08`. La candidata declara build verificado, 31/31 unitarias, 29/29 integración y 200/200 componentes del ZIP con SHA/tamaños coincidentes. Estado: `MVP_TECNICO_VERIFICADO_NOT_INTEGRATED_NOT_INSTALLED_NOT_ACCEPTED`; ninguna de estas pruebas acredita instalación en EP o persistencia remota B2.

**Estado local descubierto en la candidata:**

- `SqliteStore` crea `data/ocp-mcp.sqlite` con SQLite WAL. Su esquema contiene, entre otras, tablas de instalación, key store, fuentes canónicas, ciclos, clasificaciones, selecciones, solicitudes, grants de autorización, snapshots, eventos, telemetría, recibos, metadatos de claves y puntos de backup.
- `BackupService` usa SQLite Online Backup API para capturar la base; verifica `PRAGMA quick_check`, genera SHA-256 y empaqueta una copia `.ocpbak` con AES-256-GCM.
- La clave de datos se envuelve mediante DPAPI `CurrentUser`; la cabecera del paquete marca `dpapi_scope=CurrentUser` y conserva `owner_sid`/`installation_id`.
- `Restore` descifra el paquete, verifica SHA-256 y `PRAGMA integrity_check`, mueve la base activa a una ruta rollback y coloca el archivo restaurado en la ruta local de la nueva base.
- El índice `backup_points` guarda `package_path` absoluto dentro de la propia base, por lo que un traslado fuera del host necesita un manifiesto externo y una resolución de rutas por ID lógico, no por ruta de origen.

**Brecha que condiciona la aceptación:** DPAPI `CurrentUser` no acredita portabilidad de la clave envuelta entre perfiles/equipos Windows diferentes. La prueba smoke `backup/restore and readiness after restore` del recibo corresponde a la candidata de build y no demuestra restauración cross-host. No subir el paquete y declarar persistencia multiubicación por el mero hecho de que esté cifrado o porque su hash coincida.

**Trabajo de integración requerido (en conjunto con el propietario MCP-OCP):** definir un sobre de recuperación o re-enveloping de la DEK mediante una clave de recuperación portable y autorizada, fuera de la base/paquete y custodiada de forma apropiada; identificar/manifiestar los paquetes sin depender de `package_path`; exportar una snapshot SQLite consistente; transferir el paquete cifrado al namespace B2 asignado; recuperar en otro host/perfil; y validar DPAPI/clave, AES-GCM, SHA-256, `integrity_check`, migraciones/schema, eventos/recibos, readiness y apertura funcional. La estrategia de clave y su rotación requieren revisión de MCP-OCP y aceptación del operador; EP no reimplementa ni modifica su `BackupService` por su cuenta.

**Clasificación de aceptación:** `BACKUP_LOCAL_MCP_CANDIDATA=REPORTADO_Y_COTEJADO_EN_CODIGO`; `B2_EXPORT_IMPORT=NO_IMPLEMENTADO/NO_VERIFICADO`; `RESTORE_CROSS_HOST=NO_VERIFICADO`; `MCP_OCP_INTEGRADO_EN_MAIN=NO`; `INSTALADO_EN_EP=NO`; `ACEPTADO_POR_OPERADOR=NO`. No confundir esos estados ni reciclar la prueba local como E2E multiubicación.

**DTC:** evidencia publicada para Gobernanza en `COORDINACION-GOBERNANZA-EP-v0.1.md`, mismo ciclo EP-03, addendum de persistencia MCP-OCP y portabilidad DPAPI; commit de comunicación `2a5cb60b82e845868be60a09fe253d5448c72d89`, blob/read-back `d069aab33ba2718a72a5b07dfc0486121b1058ea`. Espera respuesta de Gobernanza y acuse técnico MCP-OCP en su objeto propio; EP no escribe ni altera el núcleo/control MCP-OCP.


## 30. Matriz inicial de conjuntos y namespaces · propuesta para DTC

| Conjunto lógico | Fuente/captura | Clasificación inicial | Destino lógico propuesto | Condición para habilitar |
|---|---|---|---|---|
| `ep-host-user-data` | Datos elegibles de aplicaciones portables y workspace; inventario EP aún pendiente | Candidato principal EP | `ep-ocp/host/` | Selección por app/dataset, snapshot coherente y manifiesto SHA-256 |
| `metodologia-canonical-docs` | `SeryMente/metodologia/main` | GitHub es fuente canónica; copia B2 complementaria si Gobernanza la exige | `ep-ocp/metodologia/` | Snapshot identificado por commit/tree; no duplicar OEP/tareas/bitácoras como autoridad |
| `mcp-ocp-runtime-sqlite` | `data/ocp-mcp.sqlite` de la candidata MCP-OCP | Estado operativo potencialmente persistente; no hay evidencia de instalación/DB viva en EP | `ep-ocp/mcp-ocp/runtime/` | Captura nativa con SQLite Online Backup API/BackupService, integridad y validación del dueño MCP-OCP |
| `mcp-ocp-backup-packages` | `<dataRoot>/backups/<backup-id>.ocpbak` | Paquete local cifrado; portabilidad cross-host NO VERIFICADA por DPAPI `CurrentUser` | `ep-ocp/mcp-ocp/backups/` | Resolver envoltorio portable/recovery y sidecar manifest; restore en otro host/perfil |
| `mcp-ocp-build-evidence` | Recibo, source/build manifests y ZIP de la candidata | Artefactos versionados por rama/commit; no sustituyen runtime state | `ep-ocp/mcp-ocp/builds/` (opcional) | Gobernanza/MCP-OCP deciden retención; GitHub conserva procedencia |
| `secrets-and-live-auth` | Tokens, claves, credenciales, cookies, DPAPI blobs individuales y material de sesión autenticada | EXCLUIDO del backup ordinario | ninguno | Solo mecanismo de secretos separado y autorizado; nunca copia recursiva |

**Nota de namespace:** estos paths son propuestas lógicas, no carpetas B2 observadas. Dependen de verificar el único bucket `OCP-MCP` y que la key activa limite realmente a `ep-ocp/`. Los subdirectorios separan conjuntos por propietario; no crean bucket, key, ACL ni autoridad canónica adicional.

**Política inicial:** objetos remotos inmutables/versionados; no propagar borrados locales, no usar `--delete` ni lifecycle destructivo. La retención local de BackupService (daily/weekly/pre-update) no se copia automáticamente a B2: requiere política remota independiente y pruebas.

**Regla MCP-OCP:** no subir `ocp-mcp.sqlite`, sus archivos `-wal`/`-shm` ni un directorio activo por copia de archivos. Usar el snapshot SQLite nativo. El `.ocpbak` necesita manifiesto externo e identidad portable del mecanismo de descifrado antes de contar como copia multiubicación recuperable.

## 31. Contrato mínimo de manifiesto común EP/MCP-OCP

Cada snapshot transferible debe producir un manifiesto determinista independiente del host y de la ruta absoluta. El mismo contrato atiende archivos ordinarios EP, snapshots nativos de aplicaciones y paquetes `.ocpbak` MCP-OCP.

**Campos mínimos:** `schema`, `dataset_id`, `dataset_owner`, `snapshot_id`, `created_utc`, `source` (tipo, versión, commit/blob o identificador nativo), `consistency` (método y resultado), `encryption` (algoritmo, envoltorio de clave y portabilidad), `files[]` (ruta relativa lógica, tamaño y SHA-256), `destination` (bucket/prefijo y estado de verificación), `restore` (destino nuevo, pruebas requeridas y resultado). El manifiesto no incluye contraseñas, claves, tokens, cookies, SID completo, rutas absolutas privadas ni datos de autenticación.

**Ejemplo ilustrativo para el paquete MCP-OCP (no es recibo de una operación real):**

```json
{
  "schema": "ep-persistence-manifest/v1",
  "dataset_id": "mcp-ocp.runtime.sqlite",
  "dataset_owner": "MCP-OCP",
  "snapshot_id": "<content-addressed-id>",
  "created_utc": "<ISO-8601-UTC>",
  "source": {
    "kind": "sqlite-native-backup-package",
    "repository": "SeryMente/metodologia",
    "branch": "integration/ocp-mcp-0.1.0-selective-20261101",
    "source_commit": "5956595d5455d5b851c2ef1ff6808f0c2aeabff9",
    "package_format": "ocpbak"
  },
  "consistency": {
    "method": "sqlite-online-backup-api",
    "quick_check": "NOT_RUN_FOR_REMOTE_SNAPSHOT"
  },
  "encryption": {
    "algorithm": "AES-256-GCM",
    "key_envelope": "DPAPI-CurrentUser",
    "portable": false
  },
  "files": [],
  "destination": {
    "provider": "backblaze-b2",
    "bucket": "OCP-MCP",
    "bucket_status": "UNVERIFIED",
    "prefix": null,
    "upload_status": "NOT_EXECUTED"
  },
  "restore": {
    "target": "new-host-new-profile",
    "cross_host_key_recovery": "NOT_DESIGNED",
    "sha256": "NOT_RUN",
    "sqlite_integrity_check": "NOT_RUN",
    "application_readiness": "NOT_RUN"
  }
}
```

Los valores entre `<...>` son placeholders, no hashes ni IDs. `files[]` debe enumerar objetos reales con rutas relativas, tamaños y SHA-256 antes de transferir. El ejemplo deja visible la brecha DPAPI; no es una autorización para subir el paquete ni prueba de restauración.

**Invariante de aceptación:** un snapshot solo puede marcarse `RECOVERABLE` cuando el manifiesto, todos los objetos remotos, el mecanismo de recuperación de claves y una restauración funcional en destino nuevo hayan sido cotejados. `UPLOADED`, `HASH_MATCHED` o `LOCAL_RESTORE_PASSED` son estados parciales distintos.

## 32. Rectificación de compuerta presencial y continuidad del trabajo EP-TASK-002

**Rectificación cronológica del §27:** el estado que allí se registró —«el canal no acredita por sí mismo esa presencia»— corresponde al checkpoint anterior a la respuesta directa del operador. El 2026-11-01 el operador confirmó expresamente en esta conversación que estaba físicamente junto a PC-8 y ordenó continuar, sin preguntas de confirmación redundantes. Para P012/P013, la condición de presencia del operador se registra como `CONFIRMADA_POR_DECLARACIÓN_DIRECTA`; no es telemetría independiente. Esta rectificación no convierte en verificados cuenta B2, clave, bucket, ACL, `namePrefix`, ni pruebas de restauración.

**Alcance efectivo de DTC:** la persistencia del servicio MCP-OCP es trabajo activo de EP-TASK-002, no una línea fuera de alcance ni una tarea futura opcional. Los §§28–31 son la interpretación vigente: EP/Metodología y MCP-OCP son dos planos de datos con propietarios y validaciones separadas. El límite anterior «sin B2 durante la construcción MOD-SCRIPTPWS» restringe esa subfase del gate/host; no congela ni suspende EP-TASK-002 ni la preparación de datasets/manifiestos/recuperación para MCP-OCP.

**Estado de operación B2:** `b2v5` local funcional y SHA verificado; no hay sesión autenticada/caché B2 en PC-8. Cuenta/región, existencia/privacidad de `OCP-MCP`, key/scope `ep-ocp/` y capacidades siguen `NO_VERIFICADOS`; no hubo operaciones remotas. La siguiente etapa técnica permitida en EP-TASK-002 es preflight de proveedor en solo lectura una vez que el perfil de navegador autorizado disponga de una sesión Backblaze autenticada; nunca se solicitan secretos en chat. Después de ese preflight, la primera escritura será una prueba sintética aislada con manifiesto, SHA remoto, read-back y restore a una ruta nueva.

**Gobernanza:** la petición de alcance ampliado está publicada en el objeto DTC existente; `GOV-TASK-014` permanece `EN_CURSO` y el blob leído más recientemente aún no incorpora este addendum. No se atribuye respuesta ni aceptación de Gobernanza ni MCP-OCP. Se mantiene la comunicación en el mismo DTC, sin canal paralelo.

## 33. Ejecución B2 E2E de una sola pasada y fail-closed

**Mandato del operador (2026-11-01):** entregar el procedimiento a prueba de fallos y no repetir pruebas; el operador concede un ciclo de trabajo. Se mantiene el ciclo DTC existente `C-EP-MOD-SCRIPTPWS-20261101-03`; no abrir un ciclo paralelo.

### Estado previo observable

- PC-8 ONLINE en RDC, Windows x64, PowerShell por defecto.
- CLI `b2v5-windows.exe` v5.0.2 / SDK 2.13.2, SHA-256 `543aa2e36d3cbe06cf2c3e59287ce58b0a7d1507af87f147ff2f7d9406879662`.
- Caché anterior `%USERPROFILE%\.b2_account_info` preservada; la sesión nueva usa `%LOCALAPPDATA%\Khora\state\b2-ep-ocp.sqlite` vía `B2_ACCOUNT_INFO`.
- Proceso RDC `7232` está abierto en `b2 account authorize`, esperando `Backblaze application key ID`; no se recibió ni mostró ID/secret en ChatGPT.
- La bóveda KHORA no contiene nombres `B2_APPLICATION_KEY_ID`/`B2_APPLICATION_KEY`; no se abrió ni se pidió su llave maestra.
- `account get` sin autorización devuelve `Missing account data`; no se ha autenticado contra B2 ni consultado bucket/keys.

### Procedimiento único

**A. Autorización local:** continuar el proceso `7232` que ya está esperando el ID. La Application Key se crea en el panel Backblaze con bucket `OCP-MCP`, prefijo `ep-ocp/` y capacidades exactas `listBuckets`, `listFiles`, `readFiles`, `writeFiles`; sin capabilities adicionales. Los valores se introducen únicamente en la terminal local de PC-8. No iniciar otro `authorize` ni copiar secretos por chat.

**B. Preflight proveedor solo lectura, antes de cualquier objeto:** ejecutar en el mismo script de control, con `B2_ACCOUNT_INFO` apuntando al caché aislado. Capturar `account get` completamente en memoria, nunca imprimir/salvar su salida cruda porque contiene auth token y material de clave. Parsear `allowed`; exigir bucketId+bucketName exactos (`OCP-MCP`), `namePrefix` exacto (`ep-ocp/`) y conjunto exacto de cuatro capabilities permitidas. Contrastar bucket con `bucket list --json`, confirmar tipo `allPrivate`, y ejecutar `ls --json` de `b2://OCP-MCP/ep-ocp/`. No continuar si hay scope más amplio, key de cuenta, bucket/prefijo distinto, capability extra, parseo ambiguo, comando no-cero o respuesta inconsistente.

**C. Preparación local:** crear un GUID aleatorio y un fixture JSON autocontenido con payload aleatorio Base64 y SHA-256 interno. Escribir fuente y futura restauración en dos directorios recién creados bajo `%LOCALAPPDATA%\Khora\state\ep-b2-e2e\<GUID>\`. Comparar que ambos destinos estén vacíos/no existan; calcular tamaño, SHA-1 para la CLI y SHA-256 para aceptación.

**D. Lock de una sola pasada:** únicamente después de superar A–C, abrir `one-shot.lock` con `FileMode.CreateNew` y escribir un recibo local `RUNNING`. Si el lock ya existe, abortar sin subir ni reintentar. El lock contiene GUID y timestamp, no secretos.

**E. Única prueba E2E:** un solo objeto remoto `ep-ocp/_e2e/one-shot/<GUID>.json`; `b2 file upload --no-progress --sha1`; después `b2 file info` sobre la URI exacta y `b2 file download --no-progress` a la ruta de restauración nueva. Verificar igualdad de bytes/tamaño/SHA-256 fuente-descarga y SHA-256 del payload decodificado; guardar recibo sanitizado de ejecución con outputs sensibles omitidos, exit codes y huellas. Conservar el objeto remoto como evidencia; no borrar, ocultar, sobrescribir ni ejecutar lifecycle.

### Regla de fallo y no repetición

- Preflight fallido: cero escrituras remotas y E2E `NOT_STARTED`; documentar requisito ausente y no llamar al script de subida.
- Después del lock: no reintentar ni volver a subir el mismo objeto. Ante cualquier fallo, detener; conservar el lock, recibo parcial y todo objeto remoto que sí haya quedado; no usar delete/cleanup remoto. Registrar causa raíz, impacto y estado `PARTIAL/FAILED`, nunca PASS.
- No ejecutar una segunda prueba exploratoria para validar la corrección. Una eventual nueva prueba necesitará una decisión explícita del operador y un ciclo nuevo o reapertura formal conforme al DTC.

### Sintaxis local verificada (solo ayuda de CLI, sin operaciones proveedor)

En `b2v5` 5.0.2 están disponibles `bucket list --json`, `bucket get`, `ls --json`, `file upload`, `file info` y `file download`. `file download-by-name` no existe en esta versión; no usarlo. `account get` incluye credenciales de sesión en su salida; nunca imprimir salida cruda. La inspección de ayuda no ha ejecutado upload/download/restore.

**Estado de la instantánea histórica §33:** `SUPERSEDED_BY_§34`; el proceso `7232` pertenecía a PC-8 y ya no es una sesión operativa reutilizable. No inferir que la autorización llegó a completarse. El objeto DTC contiene el mismo compromiso y read-back en commit `631ffc6d2805d71f5a17dd812fa18eff35fe6ef9`, blob `da0c20ca4b85ccb3a42e8ea286425dc79bc21533`.


## 34. Reinstanciación tras pérdida declarada del entorno local · RDC 015RENTA01 · 2026-11-01

### Declaración y auditoría de entorno

El operador declara que la sesión local anterior se reinició y que no sobrevivió ningún dato del entorno; esta declaración gobierna la continuidad, sin presentarse como prueba forense de borrado de todos los medios. Se autenticó una conexión RDC nueva al dispositivo `015RENTA01` (`aacf2eb5-17f4-428e-9242-c24a1fe4a2ec`), Windows x64, PowerShell, Node 24.22.2. PC-8 está Offline; el PID histórico `7232` no se reutiliza.

En la auditoría local de solo lectura no se encontraron el ejecutable B2 ni las cachés `%LOCALAPPDATA%\Khora\state\b2-ep-ocp.sqlite` y `%USERPROFILE%\.b2_account_info`; tampoco existía `%LOCALAPPDATA%\Khora\state`. Git, GitHub CLI y VS Code CLI no estaban disponibles en PATH y no se encontraron clones conocidos bajo source/repos/Projects. La exportación Markdown presente en Downloads se conserva únicamente como antecedente documental.

### Restauración de herramienta verificada

Se instaló la CLI oficial B2 v5.0.2 en `%LOCALAPPDATA%\Programs\BackblazeB2\b2v5-windows.exe`, sin elevación. Lectura de vuelta: 18,639,088 bytes; SHA-256 `543aa2e36d3cbe06cf2c3e59287ce58b0a7d1507af87f147ff2f7d9406879662`, coincide con el pin conocido. La ejecución local devolvió `b2 command line tool, version 5.0.2 (b2sdk version 2.13.2)`, exit 0. Las ayudas locales de `account authorize`, `bucket list`, `ls`, `file upload`, `file info` y `file download` finalizaron con exit 0; `bucket list --json`, `ls --json` y `file upload --sha1` están disponibles. Esto no constituye operación contra Backblaze.

### Seguridad, autorización y continuidad

- No se ha leído ni introducido Application Key ID, Application Key, auth token ni salida cruda de `account get`.
- No se ha creado la caché aislada ni ejecutado `account authorize`; no se llamó al proveedor y no se ejecutó preflight, upload, file info, download o restore.
- La existencia y vigencia de una Application Key remota anterior son desconocidas. No crear una segunda clave por inferencia ni declarar revocada la anterior.
- La autorización deberá usar exclusivamente `B2_ACCOUNT_INFO=%LOCALAPPDATA%\Khora\state\b2-ep-ocp.sqlite`; el usuario ingresará ID y secreto localmente en la terminal, nunca en el chat.
- Se conserva el alcance exigido por §33: bucket `OCP-MCP`, prefijo `ep-ocp/`, capacidades exactamente `listBuckets`, `listFiles`, `readFiles`, `writeFiles`; sin delete. El preflight debe confirmar bucket privado, ID coincidente y prefijo permitido antes de cualquier escritura.
- P012/P013 del DUG v377 exigen revisión presencial para autenticación y seguridad. La declaración física anterior correspondía a PC-8 y no se hereda por cambio de dispositivo. La presencia del operador junto a `015RENTA01` sigue pendiente de declaración explícita.
- Después de superar el gate presencial y autorizar la cuenta, ejecutar exactamente el preflight y la prueba E2E one-shot de §33, sin exploración previa, sin retry y sin delete. Cualquier fallo tras crear el lock queda PARTIAL/FAILED y no autoriza repetición automática.

**Estado vigente §34:** `RDC_CONNECTED` · `ENV_RESET_DECLARED` · `B2_CLI_INSTALLED_HASH_VERIFIED` · `LOCAL_HELP_CONFORMANCE_PASS` · `PHYSICAL_PRESENCE_GATE_PENDING` · `AUTHORIZATION_NOT_STARTED` · `B2_PREFLIGHT_NOT_RUN` · `E2E_NOT_STARTED` · `UPLOAD_NOT_EXECUTED` · `RESTORE_NOT_EXECUTED`.

**Relación DTC:** mismo ciclo `C-EP-MOD-SCRIPTPWS-20261101-03`, sin abrir otro. La persistencia del evento se verificó en `frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md`, commit `8aedfa05a04f076f5167dd01c65f3dca1947f361`, blob `8ea765db88462b1d9a859128650397273deef943`.


## 35. Reanudación EP-03 · inventario RDC 015RENTA01 y compuerta B2 · 2026-11-01

### Fuentes y cursores adquiridos

- DUG `main`: Samantha v377 · NX-377m · Metacanon 1.28 · GOW 2.17, blob `54064c8fe00f872023a455f06596061ed69062ae`.
- OEP `main`, blob `75c10a9ae85c91857b5e1d5e95d60e58d96e7a2f`; cabecera todavía declara v0.3.27 / VCU-EP-v28.
- Índice EP `main`, blob `fb57e25f8fe03e81b03cbcaf64189de994509f12`; declara OEP v0.3.44 / VCU-EP-v46. La divergencia se conserva como pendiente de reconciliación; no se modifica versión por inferencia.
- Índice provisional de tareas `main`, blob `fcd76497dca45472153209a1158673386dfa7ba2`; EP-TASK-002 permanece `en_curso`.
- DTC EP `main`: cursor previo `e156ff79745b9835e7562d5050eafec378cf4e90`; esta entrada se procesa después de la respuesta de Gobernanza y el inventario RDC. Recibo DTC commit `c42ece813c60188d083e58d22559bb9560473bd4`, blob leído de vuelta `2779e2706f1bbf21d97cbd87f81c7912394326f1`.

### Inventario RDC local · observado, no inferido

- Dispositivo `015RENTA01`, Online; Windows PowerShell `5.1.26100.7920`, x64; perfil `C:\Users\PC`.
- B2 CLI `C:\Users\PC\AppData\Local\Programs\BackblazeB2\b2v5-windows.exe`; versión 5.0.2 / SDK 2.13.2; SHA-256 `543AA2E36D3CBE06CF2C3E59287CE58B0A7D1507AF87F147FF2F7D9406879662`.
- No se detectaron variables de entorno con nombres `B2*` o `AWS*`.
- El perfil aislado previsto `%LOCALAPPDATA%\Khora\state\b2-ep-ocp.sqlite` no existe.
- Existe `%USERPROFILE%\.b2_account_info`, 24.576 bytes; creación `2026-11-02T01:08:00.1738462Z`, modificación `2026-11-02T01:08:00.8922756Z`. La ACL observada limita acceso a SYSTEM, Administradores y la cuenta local del dispositivo. No se extrajo ni versionó su contenido. Un intento de interpretarlo como JSON falló con `ArgumentException`; el formato y la validez del perfil son `NO_VERIFICADOS`. El archivo se conserva intacto.
- Snapshot de procesos: sin nombres coincidentes `mcp`, `ocp`, `dotnet`, `khora`, `backblaze` o `b2`; sin directorios `OCP`, `MCP` o `Khora` directamente bajo `%LOCALAPPDATA%`. Esto no excluye instalaciones en otras rutas ni acredita ausencia global del servicio.
- Descargas contiene `ChatGPT-EP-20261101-1913.md`, `ChatGPT-Khora MCP-20261101-1912.md`, varias exportaciones OCP MCP y el ZIP ajeno `ebn-Uni-7.222.5412.313.zip`. La exportación OCP MCP 1917 tiene 54.916 bytes / 1.137 líneas; el escaneo acotado de patrones conocidos de secretos devolvió cero coincidencias. No se ha persistido esa exportación desde este ciclo ni se han leído secretos.

### Desviación procedimental registrada · `b2 account get`

Durante el inventario se ejecutó una sola vez `b2 account get` sobre el perfil local por defecto. El proceso terminó con exit 1; la respuesta parseable como JSON no contenía bloque `allowed`. La salida cruda no se mostró ni se guardó; no se introdujeron valores, no se ejecutó `account authorize`, no se usó Application Key y no se consultaron buckets/objetos. No hubo comandos `bucket list`, `ls`, `file upload`, `file info`, `file download` ni restore.

La respuesta de Gobernanza adquirida después en el mismo DTC prohíbe `account get` y limita este tramo a presencia/ausencia, metadatos y nombres no secretos. Como no se releyó el cursor DTC inmediatamente después de la respuesta inicial de EP, no puede acreditarse que el permiso operativo estuviera actualizado antes de esa invocación. Se registra como `DESVIACIÓN_PROCEDIMENTAL_LOCAL · IMPACTO_NO_DESTRUCTIVO_OBSERVADO`; no se oculta ni repite. Control preventivo: releer el mismo objeto DTC después de cada escritura de apertura y antes de toda operación local; aplicar el allowlist del cursor más reciente. Desde esta entrada, `account get` queda fuera de alcance hasta que Gobernanza/operador habiliten expresamente la siguiente fase.

### Reconciliación del plano MCP-OCP

- Control autoritativo actual `frentes/mcp-metodologia/CONTROL-RESPONSABILIDAD.json`, blob `ecb27b04aaba04025ef596b3f0ed6c049bc2420d`: `owned`, generación 4, alias operativo `chatgpt-mcp-ocp-01a199d8-9209-725c-b764-a0a66ac54882`. Su autorización B cubre código, pruebas, build y documentación dentro de `frentes/mcp-metodologia/`; excluye instalación/operación del host EP y configuración/credenciales B2.
- El núcleo `MCP-METODOLOGIA.md` blob `8bba2a123dd331132471f35cf0d911b277d168a5` continúa mostrando titular/generación 3. Se registra como espejo desactualizado respecto del control; EP no lo modifica.
- La rama candidata `integration/ocp-mcp-0.1.0-selective-20261101` existe. El recibo `BUILD-CANDIDATE-MCP-OCP-0.1.0-20261101.json`, blob `11296e495aa9a52a640ff53da2b1042ba67acf08`, declara build exit 0, 31/31 unitarias, 29/29 integración, 200 componentes verificados y ZIP SHA-256 `96a62fc1291f501b7fa9b0792af07021db4cb2222c8658910bdadb7732bc3b2d`. Su estado explícito es `MVP_TECNICO_VERIFICADO_NOT_INTEGRATED_NOT_INSTALLED_NOT_ACCEPTED`; no acredita servicio instalado ni dataset de runtime en EP.
- El objeto DTC de MCP-OCP contiene §30 con una solicitud pendiente a su titular sobre datasets, consistencia, backup/export nativo, envoltura de clave portable, manifiesto externo y restore cross-host. No se crea solicitud ni canal duplicado.

### Decisión, estado y siguiente acción

Se procesa la respuesta de Gobernanza: inventario de solo lectura y reconciliación completados; se conserva `PHYSICAL_PRESENCE_GATE_PENDING` para `015RENTA01`. `RDC_CONNECTED` no prueba presencia física. No hay autenticación B2, bucket/scope verificados, objeto remoto, upload, read-back remoto, descarga, restore ni E2E one-shot. No se creó el `one-shot.lock` ni se hizo una segunda prueba.

El siguiente hito depende de la revisión presencial explícita del operador junto a `015RENTA01` y de una autorización B2 válida con scope exacto `OCP-MCP/ep-ocp/`; después se ejecutará únicamente el preflight y la prueba E2E de una pasada ya documentados en §§33–34, sin reintentos ni borrados. La restauración de MCP-OCP requiere además la entrega y validación del paquete nativo portable por su titular actual.

**Estado de EP-TASK-002:** `en_curso`. **Ciclo EP-03:** abierto. No se declara persistencia operativa, restauración multiubicación ni aceptación.


## 36. Revisión presencial y seguridad de captura de credenciales B2 · 2026-11-01

**Presencia declarada:** el operador confirmó expresamente que está físicamente junto a `015RENTA01` en este ciclo. Esto satisface la señal factual de presencia para el host; no equivale por sí solo a aprobación de la arquitectura de credenciales ni a autorización de llamadas al proveedor.

**Bóveda local observada:** el clon `C:\Users\\PC\\Desktop\\Khora\\khora-jules-main` contiene `secrets/env-vault.enc.json` (3.656 bytes; SHA-256 `6D3648E0E434250794DABA89F0682451CBCB5EEAF1CF1A93A3324B6914CA683F`), con 9 entradas cifradas y ninguna variable `B2_*`/`AWS_*`. La ruta aparece en el índice Git local y existe en la rama remota `feat/khora-mcp-module-jules-20261101` (blob `9d30e8cdab83a1c54d8dc6cb7d46d1c80cab302f`). El `.gitignore` canónico de KHORA no excluye el archivo principal, solo ciertos respaldos. Por ello, esta copia queda preservada y no se le añaden credenciales. No se inspeccionaron valores descifrados.

**ACL:** SYSTEM, Administradores y usuario local tienen FullControl heredado sobre `secrets` y la bóveda. No se modificaron permisos ni archivos. La ACL es una observación local, no una prueba de protección frente a administradores o compromiso del perfil.

**Procedimiento propuesto:** crear una ruta de almacén fuera del árbol de cualquier repositorio, conservar el formato de la bóveda de KHORA y comprobar SHA-256/ACL/read-back; capturar valores mediante `Read-Host -AsSecureString` sin portapapeles ni argumentos; guardar en forma cifrada con escritura transaccional/atómica y validar por descifrado de prueba en memoria sin imprimir; importar solo al ámbito Process; limpiar variables y referencias al finalizar. El app key se introduciría una vez en el almacén; el desbloqueo de bóveda y la autorización/caché B2 son mecanismos distintos. No se promete desbloqueo perpetuo ni portabilidad DPAPI entre equipos.

**EP:** variables nativas de CLI `B2_APPLICATION_KEY_ID` y `B2_APPLICATION_KEY`; el proveedor documenta que la CLI las detecta automáticamente para `b2 account authorize` sin poner secretos en argumentos. La clave prevista para EP debe ser una application key restringida a bucket `OCP-MCP`, prefijo histórico `ep-ocp/` y capacidades mínimas sin borrado; el bucket/prefijo efectivo todavía no están verificados. Después de autorizar, una caché SQLite aislada configurable mediante `B2_ACCOUNT_INFO` puede evitar volver a introducir la clave en el mismo host/perfil, con ACL local y sin incluirla en respaldos ordinarios.

**Custodia:** la rama candidata consume `KHORA_B2_KEY_ID`, `KHORA_B2_APPLICATION_KEY`, `KHORA_B2_BUCKET_NAME` y `KHORA_B2_REGION`; `KHORA_OBJECT_STORAGE=b2` es el selector. El control autoritativo Custodia, generación 6, excluye el cambio de credenciales. No capturar, crear, rotar ni suministrar estas entradas hasta autorización adicional válida. No reutilizar la credencial de EP; emitir una clave independiente restringida a bucket/prefijo y capacidades apropiadas, una vez resuelto el alcance autorizado.

**Evidencia de fuentes:** DUG v377/NX-377m, blob `54064c8fe00f872023a455f06596061ed69062ae`; KHORA `env-vault.ps1` blob `46efce0ff43c400bccdee11f02de5bc2ddd21e4c`; KHORA `.gitignore` blob `5687794c45178d620de6f1d73dbe6312561af88a`; control Custodia generación 6 blob `fd2bdd9ec38655f6d7e00ab975488383e35099da`. La documentación oficial B2 confirma variables de entorno para evitar credenciales en argumentos, restricciones de app keys por bucket/prefijo/capacidades y requisito de app key estándar para S3-compatible.

**No ejecutado:** no se modificó ni copió la bóveda, no se escribieron secretos, no se cambió ACL/ignore, no se leyó la caché B2, no se ejecutó `account get` ni `account authorize`, no se llamó al proveedor y no se realizó operación de cuenta/bucket/objeto.

**Estado:** `PROCEDIMIENTO_PROPUESTO_NO_APROBADO`; revisión presencial específica y autorización del almacenamiento EP pendientes. Custodia mantiene su bloqueo de cambios de credenciales por control generation 6. EP-TASK-002 continúa `en_curso`.


### Addendum de integridad · bóveda local con modificación no confirmada · 2026-11-01

La lectura de solo metadatos del índice Git versión 2 confirmó que la ruta `secrets/env-vault.enc.json` está registrada. El object ID de Git en el índice es `9d30e8cdab83a1c54d8dc6cb7d46d1c80cab302f`, que coincide con el blob observado en la rama remota `feat/khora-mcp-module-jules-20261101`. El archivo actual del working tree produce Git blob `912bf1a0a5e84b0b5cb93268272bfb1ce27c3b43`; no coincide con el índice. Su tamaño actual es 3.656 bytes, frente a 3.607 bytes del archivo remoto.

**Interpretación limitada:** existe una modificación local no confirmada de la bóveda cifrada. No se inspeccionaron los campos/valores de las entradas, no se determinó qué cambió y no se asume que la versión del índice o la remota sea la versión más reciente válida. No restaurar, sobrescribir, limpiar, copiar ni mover ninguna de las versiones hasta aprobación presencial. La eventual materialización fuera de Git deberá preservar primero el archivo exacto del working tree mediante copia byte-exacta, SHA-256 y read-back, conservando el original sin alteración.

**Estado:** delta de integridad `DETECTADO`; procedencia semántica del cambio `NO_VERIFICADA`; sin mutación.


## 37. Autorización acotada B2 y compuerta presencial pendiente · 2026-11-06

### Entrada y autoridad

- **A literal:** «Si», en respuesta a la solicitud de autorizar autenticación de la aplicación EP y una prueba remota no destructiva acotada a `OCP-MCP`.
- **Fuente canónica:** DUG `main` v377 · NX-377m, blob `54064c8fe00f872023a455f06596061ed69062ae`; GOW §ARR (v2.17) consultado; principios P001, P004, P005, P012, P013, P016, P035, P038 y P043 aplicados.
- **Registro DTC actualizado:** commit `a153926b8a84c372cde2cac4873859656a8693bb`, blob `549b6cbb4933666876ad312dd781e0904482bfa6`, read-back exacto verificado.

### Permiso nuevo y límites

El operador autoriza, una vez superadas las compuertas: autenticar la aplicación EP existente; verificar en solo lectura cuenta, bucket privado `OCP-MCP`, prefijo y capacidades efectivas; crear un único artefacto sintético cifrado con nombre único dentro del alcance que el proveedor confirme; cargarlo; verificar su lectura/metadatos y SHA-256 remoto; descargarlo; cotejar bytes/hash; y restaurar exclusivamente ese artefacto sintético en un destino local aislado.

No autoriza crear/rotar claves, modificar bucket/privacidad/ACL/CORS/lifecycle/políticas/permisos, borrar o sobrescribir objetos preexistentes, hacer cutover/deploy/SQL de producción ni restaurar datos reales MCP-OCP. El prefijo histórico `ep-ocp/` no se presume autorizado. Si bucket/prefijo/capacidades no coinciden o una operación arroja resultado indeterminado, detenerse; no ampliar alcance, reintentar ni borrar el objeto de prueba.

### Estado de compuertas observado

- `B2_PROVIDER_AND_SCOPED_TEST=AUTHORIZED_BY_OPERATOR_PENDING_P012_P013`.
- `EP_LOCAL_VAULT_CREATE_AND_CAPTURE=AUTHORIZED_PREVIOUSLY_NOT_EXECUTED`.
- `015RENTA01=OFFLINE` en el inventario RDC de esta fecha; último visto reportado: 116 h antes.
- `PC10RCIF4EI4=ONLINE`, pero no se autoriza sustituir el host canónico con este equipo.
- DUG P012/P013 requiere revisión/presencia presencial del operador en el mismo ciclo para operaciones de autenticación, cifrado, shell/acceso y seguridad. No existe en este ciclo una declaración actual de presencia junto a `015RENTA01`; la presencia declarada el 2026-11-01 no se hereda.
- No se ha creado la bóveda EP, capturado secreto, hidratado variables, autorizado CLI/cuenta ni llamado al proveedor como consecuencia de esta nueva aprobación.

### Estado técnico

`B2_ACCOUNT_AUTH=NOT_EXECUTED` · `READ_ONLY_BUCKET_PREFLIGHT=NOT_EXECUTED` · `TEST_UPLOAD=NOT_EXECUTED` · `REMOTE_READBACK=NOT_EXECUTED` · `DOWNLOAD=NOT_EXECUTED` · `ISOLATED_SYNTHETIC_RESTORE=NOT_EXECUTED` · `MCP_OCP_NATIVE_RESTORE=NOT_ACCEPTED`. La aprobación de la prueba de artefacto sintético no demuestra persistencia operativa ni recuperación funcional de MCP-OCP.

### Siguiente acción

El operador debe revisar presencialmente el tramo junto a `015RENTA01` y poner ese host en línea. Tras verificar la presencia y la conexión correctas, completar la bóveda local EP previamente autorizada; después autenticar la clave existente y ejecutar el preflight read-only. Solo si los permisos efectivos coinciden, ejecutar una vez el flujo de artefacto sintético aprobado. Sin presencia/host o ante divergencia, no despachar operación B2.

**Estado de EP-TASK-002:** `en_curso`. **Ciclo EP:** conserva `C-EP-MOD-SCRIPTPWS-20261101-03`; sigue `OPEN`. **Cierre de ciclo:** pendiente de trabajo ejecutable y verificación de read-back final.

**Tiempo de registro:** 2026-11-06 · 16:14 America/Mexico_City. No se estima un plazo de cierre sin la disponibilidad del host y la compuerta presencial.


## 38. Cambio de host activo confirmado y captura local en curso · 2026-11-06 · sesión actual · America/Mexico_City

- **Corrección de host:** el operador confirmó `PC10RCIF4EI4` como su computadora actual y precisó que `015RENTA01` ya no es su equipo. `015RENTA01` permanece en el historial, pero no es el host objetivo de este ciclo. `PC10RCIF4EI4` está online en RDC y corresponde al equipo confirmado por el operador.
- **Preflight observado en el host actual:** Windows 11 Pro, PowerShell 5.1.26100.9711, x64; Git disponible; B2 CLI ausente; `%LOCALAPPDATA%\Khora`, carpeta `secrets`, bóveda EP y estado B2 aislado aún no existen.
- **Helper de cifrado cotejado:** `SeryMente/khora/scripts/khora/env-vault.ps1`, blob `46efce0ff43c400bccdee11f02de5bc2ddd21e4c`. La bóveda EP se mantiene separada y utiliza el formato criptográfico compatible; la bóveda compartida no se lee ni modifica.
- **Script temporal de captura:** escrito fuera del repositorio, Parser PS 5.1 PASS; se abrió ventana local visible (proceso `18512`). Solicita frase maestra dos veces y `B2_APPLICATION_KEY_ID`/`B2_APPLICATION_KEY` en campos ocultos. No usa clipboard, argumentos, transcripción ni variables persistentes User/Machine. La captura queda pendiente de entrada del operador.
- **Estado:** `CURRENT_EP_HOST=PC10RCIF4EI4`; `OPERATOR_PRESENCE_DECLARED_FOR_CURRENT_HOST=YES`; `VAULT_CAPTURE=AWAITING_OPERATOR_INPUT`; `VAULT_READBACK=NOT_EXECUTED`; `B2_CLI=NOT_INSTALLED`; `B2_ACCOUNT_AUTH=NOT_EXECUTED`; `B2_PREFLIGHT=NOT_EXECUTED`; `REMOTE_TEST=NOT_EXECUTED`. No se ha transmitido ni leído ningún secreto.
- **Siguiente:** terminar la captura desde la ventana local; verificar el archivo y ACL; instalar/verificar B2 CLI oficial; autorizar el perfil aislado y correr preflight de solo lectura antes de la prueba sintética one-shot autorizada.
- **Ciclo EP:** se conserva `C-EP-MOD-SCRIPTPWS-20261101-03`; no se abre un OCP ni folio nuevo.


### Precisión literal A · confirmación de host actual · 2026-11-06

La entrada literal del operador fue «Chi.». Se interpreta afirmativamente por ser la respuesta contextual a la pregunta de si `PC10RCIF4EI4` era la computadora actual. La crónica anterior normalizó la respuesta como «Sí»; esta nota conserva el literal de A y no altera la conclusión operativa.


## 39. Frontera Cora–OCP–EP y corrección de la política de frase maestra · 2026-11-06

- **A literal / decisión del operador:** «la bóveda de Cora es la bóveda de EP»; Cora es la prótesis/producto, OCP es el marco metodológico de desarrollo independiente y EP es un subámbito de esa metodología por objetos canónicos de persistencia. Esta separación debe gobernar toda operación y documentación.
- **Regla de separación:** Cora conserva su producto, datos, código y runtime; OCP conserva su metodología y materiales de desarrollo independiente; EP gestiona persistencia del entorno y namespaces metodológicos autorizados. La equivalencia operativa de bóveda Cora/EP no fusiona los productos, repositorios, secretos o datos de ambos ámbitos. No incorporar secretos Cora ajenos al alcance ni credenciales Custodia. La bóveda existente previamente señalada como compartida permanece sin mutación en este tramo.
- **Frase maestra:** el mínimo de 16 caracteres fue una validación local arbitraria, no una exigencia del KDF/cifrado. Por instrucción del operador se acepta cualquier frase no vacía, con confirmación duplicada. PBKDF2-HMAC-SHA256 a 200000 iteraciones y AES-256-CBC + HMAC-SHA256 permanecen; se advierte que una frase corta reduce resistencia a ataques de diccionario/fuerza bruta.
- **Intento 1:** falló únicamente por `MASTER_PASSPHRASE_TOO_SHORT`. No existe archivo destino ni temporal, y la captura anterior no creó la bóveda. El recibo de fallo original permanece conservado.
- **Reintento técnico corregido:** script fuera de Git actualizado; regla de longitud retirada, acepta toda frase no vacía; Parser PowerShell 5.1 PASS; se verificó que el archivo final, temporal y el recibo retry1 no existían antes de abrir la ventana. Ventana local abierta en `PC10RCIF4EI4` con PID `2440`; ruta de recibo retry1 independiente para conservar la evidencia del fallo anterior.
- **Estado:** `MASTER_LENGTH_POLICY=OPERATOR_SELECTED_NO_MINIMUM`; `VAULT_CAPTURE=AWAITING_LOCAL_INPUT`; `VAULT_READBACK=NOT_EXECUTED`; `B2_CLI=NOT_INSTALLED`; `B2_ACCOUNT_AUTH=NOT_EXECUTED`; `B2_REMOTE_TEST=NOT_EXECUTED`.
- **Siguiente:** completar captura y leer metadatos no secretos + SHA/ACL/read-back; después CLI, auth/preflight read-only y prueba sintética one-shot autorizada.


### Reintento de captura vacío y relanzamiento sin mínimo · 2026-11-06

**Estado observado:** el primer intento terminó por `MASTER_PASSPHRASE_TOO_SHORT`; el siguiente intento con política de longitud retirada terminó por `MASTER_PASSPHRASE_EMPTY`. Ambos recibos se conservaron. Tras ambos, el archivo final `%LOCALAPPDATA%\Khora\secrets\b2-ep-env-vault.enc.json` y su temporal no existían; no se capturó ni persistió credencial B2 y no se llamó al proveedor. El segundo fallo indica que el primer campo de frase maestra llegó vacío al proceso, no que el KDF o AES hayan rechazado una frase corta.

**Corrección visible y semántica:** el encabezado de la captura ahora dice literalmente que la bóveda de Cora es la bóveda operativa de EP, que Cora conserva su producto/datos/runtime y OCP conserva su metodología independiente. La captura almacena solo las dos variables B2 del namespace EP autorizado. Esto no altera archivos/repositorios de producto ni la bóveda compartida anterior.

**Reintento actual:** script temporal corregido; acepta cualquier frase maestra no vacía, confirma repetición y advierte la menor resistencia de frases cortas. Parser PowerShell 5.1 PASS. Preflight confirmó ausentes archivo final, temporal y recibo retry2. Ventana abierta en `PC10RCIF4EI4`, PID `18752`, recibo `EP-B2-Vault-Capture-20261106.retry2.status.json`. Estado: `AWAITING_OPERATOR_INPUT`; todavía sin bóveda verificada, sin autenticación y sin llamada B2.

**Instrucción a la entrada local:** primer prompt = frase maestra elegida por el operador; segundo prompt = repetir exactamente la misma frase; tercer prompt = `B2_APPLICATION_KEY_ID`; cuarto prompt = `B2_APPLICATION_KEY`. Los cuatro campos son de entrada oculta según el tipo de credencial; no introducir nada en el chat.


### CLI B2 oficial instalada y verificada en el host actual · 2026-11-06

**Origen:** release oficial Backblaze/B2_Command_Line_Tool v5.0.2, asset `b2-windows.exe`, publicado 2026-10-23. URL: `https://github.com/Backblaze/B2_Command_Line_Tool/releases/download/v5.0.2/b2-windows.exe`. SHA-256 publicado: `d6e5b1c0918c2755fc8c14eb5b5aa698c36b43d3fdc18fca13ea163d829bbbbb`.

**Instalación local:** `%LOCALAPPDATA%\Programs\BackblazeB2\b2.exe` en `PC10RCIF4EI4`, usuario `MantenimientoRCI`; no requiere instalación global ni elevación. SHA-256 calculado localmente coincide exactamente con el release. Authenticode: `Valid`; firmante `CN="BACKBLAZE, INC.", O="BACKBLAZE, INC."`. `b2 --help`: exit 0; `b2 version`: `b2 command line tool, version 5.0.2 (b2sdk version 2.13.2)`, exit 0.

**Límites:** se descargó y verificó el binario; no se llamó a `account authorize`, `account get`, `bucket list`, listados, upload, download, restore ni ninguna operación de cuenta/proveedor. No se creó caché `B2_ACCOUNT_INFO`. La CLI queda instalada y disponible para el siguiente gate, no autenticada.

**Captura local EP/Cora:** continúa en ventana local PID `18752`; la verificación más reciente no encuentra archivo final, temporal ni recibo retry2. Estado `AWAITING_OPERATOR_INPUT`.


## 40. Reanudación EP y fallo reportado de autenticación B2 · 2026-11-06

### Entrada, procedencia y captura del original

El operador indicó `ChatGPT-EP-20261106-1708.txt` y pidió incorporarlo a la persistencia documental EP y reanudar el trabajo. El archivo no apareció entre los adjuntos de la conversación ni en la búsqueda de título de la Biblioteca. La búsqueda recursiva amplia del perfil del host se detuvo sin resultado disponible; el sondeo acotado de Escritorio, Descargas, Documentos y Temp fue detenido después de no producir coincidencias visibles, sin completar una búsqueda exhaustiva. El original se conserva como `NO_LOCALIZADO_EN_LAS_SUPERFICIES_REVISADAS`: no se atribuye contenido, hash ni lectura; no se crea sustituto ni se declara incorporación verbatim. Esta crónica documenta solo evidencia accesible en este ciclo.

### A literal de estado B2 reportada por el operador

`EP_B2_ACCOUNT_AUTH=FAILED reason=UNEXPECTED_ERROR_RemoteException`.

La salida indica que el desbloqueo local llegó a la fase de autorización de cuenta; que no se imprimieron ni persistieron secretos en texto claro; y que no se ejecutaron operaciones de buckets ni archivos. No se dispone del traceback, código de salida de `b2`, recibo del proveedor o respuesta estructurada. La excepción remota del primer recibo es una causa técnica indeterminada. Además se localizó `EP-B2-Authorize-20261106.retry2.status.json`: `FAILED`, `PROVIDER_AUTH_REJECTED`, `authorize_exit_code=1`, `auth_started=True`, `account_get_exit_code` vacío, cero operaciones de bucket y archivo. La lectura estática del script confirma que esta clasificación se produce cuando stdout/stderr del proceso `b2 account authorize` coincide con patrones de `bad_auth_token`, `unauthorized` o `invalid application key`; el texto original no se conserva. Es evidencia de rechazo de autenticación reportado por la CLI, pero no permite conocer la causa concreta ni verificar la identidad de cuenta. Clasificación consolidada: `AUTH_ATTEMPT_1=FAILED_REMOTE_EXCEPTION`; `AUTH_ATTEMPT_2=FAILED_PROVIDER_AUTH_REJECTED_EXIT_1`; `RAW_PROVIDER_ERROR=NOT_RETAINED`; `ACCOUNT_IDENTITY=NOT_VERIFIED`.

### Metadatos locales observados sin revelar secretos

En `PC10RCIF4EI4` se verificó que la bóveda `C:\Users\MantenimientoRCI\AppData\Local\Khora\secrets\b2-ep-env-vault.enc.json` existe, mide 836 bytes y presenta SHA-256 `C4E6B0CC309A6702115790F46E05EF44C7FCF5C8B950112F4B18831BF1994F67`. No se encontraron temporales `*.tmp` en su directorio. La ACL no heredada concede `FullControl` a `NT AUTHORITY\SYSTEM`, `BUILTIN\Administradores` y `CENTRAL\MantenimientoRCI`. También existe `C:\Users\MantenimientoRCI\AppData\Local\Khora\state\b2-ep-ocp.sqlite` con 24,576 bytes; no se leyó su contenido. Estos metadatos no prueban autenticación ni scope B2. El descifrado/read-back comunicado anteriormente no se repitió en este ciclo.

### Estado y límites

- `EP_LOCAL_VAULT=EXISTS_HASH_ACL_OBSERVED`.
- `B2_CLI=5.0.2_INSTALLED_AND_VERIFIED` según la evidencia de instalación ya registrada en OEP.
- `B2_STATE_CACHE=EXISTS_CONTENT_NOT_INSPECTED`.
- `B2_ACCOUNT_AUTH=FAILED_REPORTED_REMOTEEXCEPTION`.
- `B2_PROVIDER_IDENTITY_AND_KEY_SCOPE=NOT_VERIFIED`.
- `BUCKET_PREFLIGHT=NOT_EXECUTED`; `SYNTHETIC_UPLOAD=NOT_EXECUTED`; `REMOTE_READBACK=NOT_EXECUTED`; `DOWNLOAD_AND_RESTORE=NOT_EXECUTED`.
- `MCP_OCP_NATIVE_RESTORE=NOT_ACCEPTED`; `EP-TASK-002=en_curso`.

No repetir `account authorize` ni operar buckets/archivos después del error. El permiso del operador para una prueba sintética se mantiene dentro de sus límites originales, pero el error exige detener el tramo y no reintentar sin autorización nueva. Próximo trabajo: localizar recibo/salida de error no secreta y determinar si la excepción procede de la capa RDC/ejecución, del proceso CLI o del proveedor, sin leer la caché SQLite ni volver a solicitar secretos. Si se requiere repetir autenticación, obtener nueva autorización expresa.

### Frontera Cora–OCP–EP

Se mantiene la instrucción del operador: la bóveda de Cora es la bóveda operativa de EP; Cora conserva su producto, datos, código y runtime; OCP permanece como marco metodológico independiente; EP conserva el ámbito de persistencia. La captura contiene exclusivamente las dos credenciales B2 del namespace EP autorizado. No se amplía a credenciales o datos adicionales de Cora ni a Custodia.

### Coordinación y evidencia documental

La respuesta inicial de reanudación ya fue registrada en el objeto DTC EP `frentes/ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md`, commit `950d62ba4db8770f7a5d87f00aee10d1ea348d49`, blob `62938936ff64aedac44c907d1d5d792aa5f8e01f`. La actualización del OEP se registra en §96, versión documental v0.3.28 / VCU-EP-v29. No se inicia ciclo nuevo: se conserva `C-EP-MOD-SCRIPTPWS-20261101-03` en `OPEN`; FOL1 no consta ACTIVO. El cierre DTC/read-back queda pendiente de completar la actualización y comparar los tres objetos.


### Addendum de recibos B2 · dos intentos fallidos confirmados · 2026-11-06

La inspección de metadatos/JSON de los recibos locales encontró `EP-B2-Authorize-20261106.status.json` (`UNEXPECTED_ERROR_RemoteException`; auth started; bóveda compartida intacta) y `EP-B2-Authorize-20261106.retry2.status.json` (`PROVIDER_AUTH_REJECTED`; `authorize_exit_code=1`; `account_get_exit_code` vacío; operaciones bucket=0, archivo=0; bóveda compartida intacta). La fuente del segundo estado fue inspeccionada estáticamente: el script clasifica el texto de stdout/stderr en memoria mediante patrones de rechazo de autenticación y solo escribe la clasificación y metadatos no secretos; stdout/stderr no se conservaron. El segundo recibo indica que la CLI recibió una salida compatible con rechazo de auth; no demuestra por sí solo cuál dato de la pareja de credenciales falló ni cuál fue la respuesta exacta. Esta evidencia rectifica el resumen previo: existieron dos intentos reportados antes de la revisión actual. En esta revisión no se ejecutó un tercer intento. No se repite `account authorize` ni se avanza a buckets/objetos sin nueva autorización expresa y diagnóstico. La bóveda cifrada y caché aislada mantienen su estado documentado; no se consultó el contenido de la caché.


## 41. Diagnóstico estático de rechazo B2 y revisión de clave existente · 2026-11-06

### Evidencia local nueva

En `PC10RCIF4EI4` se revalidó `b2.exe`: v5.0.2 (b2sdk 2.13.2), SHA-256 `D6E5B1C0918C2755FC8C14EB5B5AA698C36B43D3FDC18FCA13EA163D829BBBBB`, Authenticode `Valid` y firmante Backblaze Inc. `b2 account authorize --help` declara que la autenticación requiere capability `listBuckets` y admite `B2_APPLICATION_KEY_ID` / `B2_APPLICATION_KEY` en entorno. La llamada fue solo `--help`, no llamó a la cuenta.

El script retry2 pasó Parser PowerShell 5.1 con 0 errores. Revisión estática confirma descifrado en memoria, variables de proceso, caché B2 aislada, proceso hijo sin secretos en argumentos, stdout/stderr solo en memoria y limpieza al final. El recibo retry2 asignó `PROVIDER_AUTH_REJECTED` mediante coincidencia textual de errores de autenticación; la salida original no fue persistida. No había proceso `b2` activo al finalizar.

### Lectura técnica del rechazo

Backblaze documenta que HTTP 401 `unauthorized` durante `b2_authorize_account` significa que el `applicationKeyId` y/o `applicationKey` son incorrectos; distingue `unsupported` para ID válido pero no compatible con la versión de API. Como el recibo guardó solo la clasificación y no el mensaje/código crudo, no se puede asegurar cuál de estos motivos produjo el error ni identificar el campo discrepante.

Las claves estándar pueden estar restringidas por bucket, prefijo y expiración. La CLI requiere `listBuckets` para `account authorize`. Backblaze indica que el valor `applicationKey` solo se presenta al crear la clave y no puede recuperarse de la consola si se pierde. Fuentes: `https://www.backblaze.com/apidocs/b2-authorize-account`; `https://github.com/Backblaze/B2_Command_Line_Tool/blob/master/doc/source/quick_start.rst`; `https://help.backblaze.com/hc/en-us/articles/360052129034-Creating-and-Managing-Application-Keys`.

### Siguiente paso y bloqueo

El operador revisa visualmente la Application Key ya existente en Backblaze App Keys, sin crear/eliminar/rotar nada, y confirma únicamente los metadatos: presencia/estado, bucket `OCP-MCP`, prefijo `ep-ocp/` si corresponde, expiración, `listBuckets`, lectura/escritura mínima sin `deleteFiles`, y si conserva el valor original `applicationKey` de manera segura. No compartir valores secretos ni el contenido de la bóveda. Si el valor secreto se perdió, detenerse y solicitar autorización distinta antes de crear una clave de reemplazo.

No repetir `account authorize` hasta recibir nueva autorización expresa posterior al diagnóstico y cumplir la revisión/presencia P012/P013. No se inspeccionó la caché SQLite ni se ejecutaron operaciones de bucket/archivo. `EP-TASK-002` permanece `en_curso`; el siguiente hito es `APP_KEY_REVIEW`, no el upload.


## 42. Ingesta del original 2026-11-07 y reanudación de creación de Application Key · 2026-11-07

### Fuente y procedencia

Se adquirió por RDC el archivo `ChatGPT-EP (1)-20261107-1015.txt` desde `C:\Users\fila4\Downloads` en `PC10RCIF4EI4`: 974 líneas, 44,283 bytes. Copia exacta preservada en `frentes/ep/originales/ChatGPT-EP (1)-20261107-1015.txt`; SHA-256 `555A2BF9F6282DFD36A638FA4626A7511A0B4DEA869D3E737F1655921811F88E`, coincidente entre origen y destino. El repositorio privado se actualizó por fast-forward antes de la escritura documental; no había cambios locales previos.

### Estado consolidado

- Host vigente: `PC10RCIF4EI4`; archivo localizado bajo el perfil `fila4`.
- B2 CLI: v5.0.2, previamente verificada en hash/firma.
- Application Keys: el operador informa que no hay claves personalizadas visibles; solo aparece Master Application Key global. No se dispone del secreto de la clave personalizada anterior.
- Bucket objetivo: `OCP-MCP` (único bucket identificado por el operador). Prefijo, expiración y permisos de una clave personalizada: no disponibles porque no existe una fila visible que inspeccionar.
- No usar ni rotar Master Application Key.
- Dos intentos de autenticación anteriores permanecen fallidos; no se lanzó un tercero.

### Autorización y alcance de creación

El operador autorizó crear una sola clave `EP-OCP` con bucket `OCP-MCP`, prefijo `ep-ocp/`, capabilities `listBuckets,listFiles,readFiles,writeFiles`, sin `deleteFiles`, duración 365 días. Autorizó capturar el Key ID y el secreto directamente en memoria y guardarlos en la bóveda cifrada EP existente, verificando lectura de vuelta sin mostrar secretos. También autorizó el uso del navegador autenticado y ordenó preservar las pestañas de trabajo; preferencia operativa: CLI/headless o ventana/pestaña aislada por el único monitor disponible.

### Estado de ejecución y gates

`B2_APP_KEY_CREATE=AUTHORIZED_NOT_EXECUTED`; `B2_VAULT_WRITE_READBACK=NOT_EXECUTED`; `B2_ACCOUNT_AUTH=NOT_RETRIED`; `B2_BUCKET_PREFLIGHT=NOT_EXECUTED`; `SYNTHETIC_UPLOAD=NOT_EXECUTED`; `DOWNLOAD=NOT_EXECUTED`; `ISOLATED_RESTORE=NOT_EXECUTED`; `MCP_OCP_NATIVE_RESTORE=NOT_ACCEPTED`.

La CLI no crea una clave sin una credencial administrativa válida. La alternativa autorizada es la sesión del portal, pero la creación debe bloquearse antes del clic final si no está garantizada la captura segura inmediata del secreto hacia la bóveda. No extraer cookies, no utilizar la Master Key, no imprimir credenciales, no usar el portapapeles para secretos y no sustituir pestañas del operador. Después del read-back cifrado, cumplir P012/P013 antes de autenticar; ante cualquier error, detener sin reintento automático. La prueba sintética sigue siendo one-shot y condicionada a confirmar el scope efectivo.

**Estado de tarea:** `en_curso`. Se conserva el ciclo local `C-EP-MOD-SCRIPTPWS-20261101-03`; no crear OCP, control, sesión, responsabilidad o folios globales nuevos.


## 43. Preflight headless de Chrome y bloqueo de captura segura B2 · 2026-11-07

La inspección local de metadata confirmó que el Chrome autenticado del perfil `fila4` (PID raíz 12692) no tiene `--remote-debugging-port` ni endpoint CDP en los puertos 9222–9235. La segunda instancia de Chrome abierta por la asistencia usa el perfil `MantenimientoRCI` (PID raíz 12388), distinto del perfil autenticado; no se presume sesión compartida. No se leyó cookies ni storage, no se reinició Chrome y no se modificaron pestañas.

La CLI B2 5.0.2 no puede crear una Application Key sin credencial administrativa `writeKeys`, no disponible en la bóveda EP. No se usará la Master Key ni se extraerán cookies. La creación `EP-OCP` continúa autorizada, pero `AUTHORIZED_NOT_EXECUTED` hasta disponer de captura directa segura a la bóveda. Cualquier perfil de navegador alternativo o nuevo inicio de sesión requiere autorización específica antes de crearse.

Estados: `CHROME_FILA4_CDP=NOT_ENABLED`; `SECONDARY_PROFILE_AUTH=NOT_VERIFIED`; `B2_ADMIN_CREDENTIAL=NOT_AVAILABLE`; `B2_APP_KEY_CREATE=AUTHORIZED_NOT_EXECUTED`; `VAULT_CAPTURE=NOT_EXECUTED`; `B2_ACCOUNT_AUTH=NOT_RETRIED`; `EP-TASK-002=en_curso`.


## 44. Ingesta 1111 y estrategia B2 exclusiva con Master Application Key · 2026-11-07

### Fuente y continuidad

Se adquirió `ChatGPT-EP-20261107-1111.txt` desde `C:\Users\fila4\Downloads\` del perfil fila4 en `PC10RCIF4EI4`. Original: 1.046 líneas, 46.231 bytes, SHA-256 `4297642A8FC88628A38CE2F0057E72F849E708B4EFE4B19882C50DBB01CD51B7`. Copia exacta persistida en `frentes/ep/originales/ChatGPT-EP-20261107-1111.txt`; origen intacto. La transcripción no se incorpora como sustituto del estado vivo; este apartado registra su delta.

### Hallazgo de la credencial EP-OCP

La transcripción registra autenticación B2 exitosa con `EP-OCP` y un `account get` satisfactorio. El alcance devuelto contenía `deleteFiles` y facultades de administración/configuración de buckets además de los permisos de lectura/escritura; el vencimiento no quedó confirmado. El bucket `OCP-MCP` y prefijo `ep-ocp/` se reportaron restringidos. No hubo operaciones de archivos: upload=0, download=0, delete=0, restore=0. Estos hechos se conservan como resultado reportado del ciclo anterior, no como nueva prueba ejecutada en esta entrada.

### Decisión vigente del operador

El operador eligió utilizar **únicamente la Master Application Key** y prescindir de cualquier Application Key adicional. Quedó autorizado su uso para persistencia EP, sin crear otra clave y sin rotar ni revocar la propia Master Key. La clave `EP-OCP` no se usará en la nueva estrategia y queda sin modificación/revocación.

La Master Application Key tiene acceso completo a la cuenta B2, sin restricción de bucket/prefijo o vencimiento. Esta aceptación supone abandonar el mínimo privilegio por credencial. Límite operativo obligatorio: las órdenes de esta tarea apuntarán expresamente a bucket `OCP-MCP` y prefijo `ep-ocp/`; no borrar, cambiar lifecycle, modificar buckets, administrar claves ni operar otros destinos sin autorización específica independiente. Esta limitación se aplica en el flujo de comandos, no la impone el proveedor.

### Bóveda y compuerta

Metadatos observados de la bóveda EP: 876 bytes; SHA-256 `9688B3496FEA1670CEB2BD8C5CDA2D8461D71B18F9A821568423264F04E3BE7C`; ACL protegida; propietario `CENTRAL\MantenimientoRCI`. No se leyó ni modificó su contenido. En el estado previo las entradas vigentes eran las de `EP-OCP`; Master Key ID y Master Application Key todavía no están capturados ni persistidos. No se leyó el portapapeles en este ciclo.

La captura local exige presencia/revisión presencial del operador en el mismo ciclo por P012/P013. La presencia en un ciclo anterior no se hereda. No solicitar secretos por chat. Después de confirmación presencial, leer el bloque del portapapeles en memoria, cifrar ambas entradas en la bóveda existente, efectuar decrypt-readback y comprobar integridad/ACL; no iniciar autenticación antes de que todo el read-back sea PASS.

### Secuencia técnica pendiente

1. Captura local Master Key ID + Master Application Key desde el portapapeles, sin texto plano en archivos/logs/argumentos.
2. Verificación criptográfica de la bóveda y limpieza del portapapeles.
3. `b2 account authorize` con Master mediante CLI; variables de entorno solo para el proceso hijo y caché aislada.
4. `account get` y preflight no destructivo, restringiendo operativamente todos los comandos al destino OCP-MCP/ep-ocp/.
5. Una prueba sintética de upload/read-back/hash; posteriormente diseño y prueba de restore y segunda ubicación.

Preferencia ejecutiva: CLI/headless; no abrir ni reiniciar Chrome, no usar CDP ni ocupar el monitor si no es indispensable.

### Estado del hito

- `MASTER_KEY_CAPTURE` = `NOT_STARTED`
- `MASTER_KEY_VAULT_READBACK` = `NOT_STARTED`
- `MASTER_KEY_B2_AUTH` = `NOT_STARTED`
- `B2_BUCKET_PREFLIGHT` = `NOT_STARTED`
- `SYNTHETIC_UPLOAD_READBACK` = `NOT_STARTED`
- `RESTORE_CROSS_HOST` = `NOT_STARTED`
- `REMOTE_PERSISTENCE` = `NOT_PROVEN`

La tarea permanece `en_curso`. No se creó Application Key adicional, no se rotó/revocó la Master Key, no se modificó la bóveda y no se realizó ninguna operación B2 de bucket u objeto en este ciclo.

## 45. Reconciliación del estado operativo B2 y restauración entre ubicaciones · 2026-11-07

Este apartado actualiza y prevalece sobre los estados operativos anteriores de esta materialización. El estado vivo y la evidencia detallada permanecen en OEP §102–§103.

- La Master Application Key ya fue autenticada correctamente mediante caché aislada. La bóveda contiene las entradas Master y su coincidencia con los valores capturados fue verificada; no se reescribió.
- El bucket OCP-MCP fue consultado sin modificaciones. El objeto sintético de 126 bytes se subió bajo ep-ocp/_verification/, se descargó al mismo host, y el SHA-256 de origen y descarga coincidió. SSE-B2/AES256 y metadata read-back: PASS.
- El objeto sintético remoto permanece en B2. No se ha ejecutado borrado.
- La restauración física independiente no se ha ejecutado. El inventario RDC muestra PC10RCIF4EI4 Online como único equipo disponible; 015RENTA01, PC-8 y PC-14 aparecen Offline. No se considera una ruta local distinta del mismo equipo como segunda ubicación.
- Sincronización multiubicación, interrupción/reanudación, restauración funcional por consumidor y aceptación E2E permanecen pendientes.

**Estado:** en_curso. Próximo paso: habilitar un segundo equipo físico autorizado y confirmar su ruta destino. Después ejecutar descarga independiente, comparar SHA-256 contra el recibo EP-B2-SMOKE-20261107.json, probar apertura del artefacto por el consumidor y registrar evidencia saneada. No operar otros buckets/prefijos ni borrar el objeto de prueba.


## 46. Rectificación de arquitectura de datos y criterio de restauración · 2026-11-07

### Fuente y autoridad

Se incorpora la instrucción original INSTRUCCION-MATERIALIZACION-UBICACIONES-20261107.txt, preservada en originales. Esta entrada modifica la interpretación anterior de continuidad multiubicación y prevalece sobre la exigencia de un segundo equipo/unidad física que aparece en §45. No elimina la crónica histórica ni altera la evidencia de §45.

### Frontera de persistencia

- GitHub / organización SeryMente: repositorios de código, historial de cambios y objetos canónicos vigentes de Metodología/OCP. El repositorio SeryMente/metodologia conserva la especificación canónica y sus objetos OCP.
- Backblaze B2: destino de los datos de usuario generados por el uso de la metodología OCP y por las aplicaciones/proyectos bajo su sombrilla. No sustituye GitHub como remoto de código ni SeryMente/metodologia como autoridad canónica.
- Workspace local: materialización temporal bajo Escritorio/Ser y Mente/, con repositorios reconstruibles desde GitHub. No se usa GitHub para guardar los datos personales/runtime del usuario; tampoco se usa B2 como remoto de código ni como copia competidora del OCP.

La definición de qué datos de usuario se admiten, sus snapshots consistentes, cifrado, retención, conflictos, sincronización incremental e idempotencia permanece dentro de esta tarea y debe resolverse con inventario y pruebas. No se infiere permiso para capturar indiscriminadamente perfiles, cookies o datos de terceros.

### Master Application Key y destino B2

Se conserva la estrategia EP ya demostrada: uso de la Master Application Key existente, sin crear Application Keys individuales ni rotar/revocar la maestra. La autenticación y el smoke test de §102 siguen siendo la evidencia técnica disponible. El destino probado continúa siendo OCP-MCP/ep-ocp/; la Master Key tiene alcance global en su cuenta y el bucket/prefijo constituyen límites operativos, no restricciones técnicas impuestas a la clave. No ampliar operaciones fuera del destino autorizado.

### Rectificación del criterio de cierre

La restauración no requiere conectar un segundo equipo ni una unidad física independiente. Para cerrar esta tarea debe demostrarse que, desde una materialización limpia del workspace Ser y Mente en el Escritorio efectivo de la sesión Windows, EP puede recuperar los datos de usuario elegibles desde B2, verificar tamaño/hash y devolver el conjunto a un estado utilizable. Esta prueba puede realizarse en el mismo host, usando un destino local vacío y separado de la instancia fuente, sin presentarlo como prueba de independencia física.

La sincronización multiubicación lógica se demuestra mediante perfiles de ubicación y estado remoto común, no mediante la mera existencia de dos dispositivos. La prueba física entre equipos puede añadirse como robustez, pero no es compuerta obligatoria de cierre.

### Estado conservado

- Autenticación Master, GET de bucket, upload/download sintético, metadata, SSE-B2/AES256 y SHA-256: PASS según §102 y su recibo.
- Sincronización desatendida de datos reales de usuario: PENDIENTE.
- Inventario de datos elegibles y exclusiones: PENDIENTE.
- Snapshot coherente, manifiesto, conflicto, offline queue, idempotencia y recuperación desde B2: PENDIENTES.
- Prueba de reinstanciación/restauración por perfil en workspace limpio: PENDIENTE.
- Aceptación end-to-end del consumidor de usuario: PENDIENTE.

No se ejecutó ninguna transferencia de datos reales de usuario ni restauración durante esta actualización documental. El objeto sintético anterior permanece retenido y no se ha borrado.


## 47. BitLocker ubicuo y raíz maestra canónica · 2026-11-07

La instrucción del operador, preservada en INSTRUCCION-BITLOCKER-CECEQ-20261107.txt, establece que toda materialización local de EP debe residir en un workspace protegido con BitLocker, en cualquier perfil de ubicación, incluido CECEQ.

La única contraseña maestra que introduce el operador es la contraseña maestra de la bóveda canónica de variables de entorno. Esa misma contraseña es la raíz de desbloqueo del workspace BitLocker. Para respetar el mecanismo criptográfico ya existente, el protector BitLocker se deriva por sesión mediante PBKDF2-HMAC-SHA256, 200.000 iteraciones, sal ligada al identificador de sesión y resultado de 32 bytes. No se introduce una segunda contraseña maestra ni se persiste la contraseña maestra en claro. La bóveda y el volumen utilizan el mismo secreto de origen; las derivaciones mantienen separación criptográfica por sesión.

Esta regla se aplica en todas las ubicaciones. Si BitLocker, la elevación o la verificación XTS-AES-256/ProtectionStatus=On/100% no están disponibles, EP falla cerrado y no materializa repositorios ni datos en claro.

El cifrado local BitLocker es una condición del workspace. No significa que B2 reciba el volumen VHDX completo ni que los datos remotos tengan cifrado cliente adicional; la sincronización B2 conserva el alcance y los contratos propios de EP-TASK-002.

La excepción de CECEQ solo afecta a la eliminación automática: allí el cierre purga secretos de sesión, bloquea BitLocker y desmonta el volumen, pero conserva el contenedor/carpeta de trabajo cifrada. En otras ubicaciones, tras intentar la persistencia autorizada, purgar secretos, bloquear y desmontar, EP elimina automáticamente el contenedor y la carpeta de trabajo. La imposibilidad de persistir no permite conservar datos en claro fuera del perímetro protegido; se mantiene la precedencia de confidencialidad.

No se ejecutó en esta entrada ninguna operación de BitLocker, creación de volumen, sincronización de datos reales ni eliminación local.


## 48. Corrección canónica del perfil CECEQ · 2026-11-07

La denominación correcta y confirmada por el operador es CECEQ. Se adopta LOC-CECEQ; cualquier uso anterior de LOC-CSEC o LOC-CCEC en esta conversación o en notas provisionales queda supersedido para el perfil operativo actual. La grafía se considera cerrada y no se solicitará de nuevo.

En CECEQ el workspace sigue cifrado con BitLocker como en cualquier otra ubicación. Al terminar o activarse el Guardian se detienen procesos, se purgan secretos efímeros, se bloquea BitLocker y se desmonta el volumen, pero no se elimina automáticamente el contenedor ni la carpeta Ser y Mente. En cualquier ubicación distinta de CECEQ la volatilización automática del contenedor/carpeta EP continúa vigente. La ubicación desconocida se trata como distinta de CECEQ.

La contraseña que el operador introduce para desbloquear el workspace es la misma contraseña maestra utilizada para la bóveda canónica de variables de entorno; se conserva la derivación por sesión del diseño protegido existente y no se almacena la contraseña original en claro. No confundir esta contraseña maestra de bóveda con la Master Application Key de Backblaze.


## 49. Preflight local B2 y bloqueo de contexto de ejecución · 2026-11-08

### Adquisición y alcance

Se consultó el inventario RDC. El dispositivo `PC10RCIF4EI4` respondió Online (Device ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`). La configuración observada corresponde a Windows x64, PowerShell como shell predeterminado y cliente Desktop Commander 1.0.0. La sesión de terminal listada previamente incluye PID 5216, PowerShell, bloqueada y de larga duración; no se interactuó con ella. El listado de procesos no mostró ningún proceso `b2` activo.

### Preflight estrictamente local/read-only

El nuevo proceso de inspección terminó con exit code 0. Su identidad efectiva fue `CENTRAL\MantenimientoRCI`; PowerShell `5.1.26100.9711`.

- CLI: `C:\Users\MantenimientoRCI\AppData\Local\Programs\BackblazeB2\b2.exe`, 18.638.808 bytes.
- Versión: B2 CLI `5.0.2`, b2sdk `2.13.2`; `b2 version` exit 0.
- SHA-256: `D6E5B1C0918C2755FC8C14EB5B5AA698C36B43D3FDC18FCA13EA163D829BBBBB`, coincidente con el valor registrado previamente.
- Authenticode: `Valid`; firmante Backblaze Inc.
- Ruta esperada de bóveda en el `LOCALAPPDATA` de ese proceso: `C:\Users\MantenimientoRCI\AppData\Local\Khora\secrets\b2-ep-env-vault.enc.json` → `MISSING`.
- Ruta esperada de caché Master: `C:\Users\MantenimientoRCI\AppData\Local\Khora\state\b2-ep-master-20261107.sqlite` → `MISSING`.
- Procesos B2: ninguno al finalizar.

### Interpretación y bloqueo

El resultado `MISSING` se limita al contexto de perfil `CENTRAL\MantenimientoRCI` que ejecutó el preflight. No demuestra eliminación, corrupción ni inexistencia de los artefactos en el perfil `fila4` u otra ruta; no se realizó búsqueda de perfiles ni inspección recursiva. Tampoco se leyó contenido de bóveda/SQLite, portapapeles ni secretos.

La sesión RDC activa en este host está asociada al proceso `MantenimientoRCI`, mientras que la regla operativa de CECEQ reserva toda operación de archivos al usuario Windows `fila4`. Por esa razón se bloquea cualquier continuación local desde esta sesión. El resultado del preflight no se usa para autenticar ni para modificar el estado remoto.

### Estados y siguiente acción

- `B2_CLI=INSTALLED_VERSION_5.0.2_HASH_SIGNATURE_VERIFIED`.
- `VAULT_AT_MANTENIMIENTORCI_LOCALAPPDATA=NOT_FOUND_IN_THIS_CONTEXT`.
- `MASTER_CACHE_AT_MANTENIMIENTORCI_LOCALAPPDATA=NOT_FOUND_IN_THIS_CONTEXT`.
- `B2_PROCESS=NONE_AT_CHECK`.
- `B2_ACCOUNT_AUTH=NOT_RETRIED`; `BUCKET_OBJECT_OPERATIONS=NOT_EXECUTED`.
- `REAL_USER_DATA_SYNC=NOT_PROVEN`; `CLEAN_WORKSPACE_RESTORE=NOT_PROVEN`.
- `EP-TASK-002=en_curso`.

**Siguiente acción:** el operador debe iniciar RDC desde una terminal de Windows abierta como `fila4`, en el host CECEQ correspondiente, usando `npx @wonderwhy-er/desktop-commander@latest remote --no-persist-session`. Después se verificará la identidad efectiva del proceso RDC y se comprobarán únicamente los metadatos de las rutas conocidas de bóveda/caché. No se pedirá ni mostrará ningún secreto. No autenticar ni sincronizar hasta satisfacer las compuertas P012/P013 y confirmar el estado local de manera válida.

**No ejecutado en este ciclo:** no se interactuó con la sesión bloqueada PID 5216; no se leyó la bóveda ni SQLite; no se accedió al portapapeles; no se descifraron credenciales; no se ejecutó `account authorize`, `account get`, operación de bucket/objeto, upload, download, restore o delete; no se modificó ningún archivo local ni configuración B2.
