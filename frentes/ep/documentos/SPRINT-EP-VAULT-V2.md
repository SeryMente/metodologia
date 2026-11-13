# Sprint programado · EP Vault v2

**Frente:** Entorno Persistente (EP)  
**Tarea propietaria:** EP-TASK-004 — Reconstrucción integral de la bóveda EP  
**Diseño rector:** [Diseño integral EP Vault v2](DISENO-INTEGRAL-EP-VAULT-V2.md)  
**Estado del sprint:** PROGRAMADO · BUILD_NOT_DISPATCHED  
**Modo de ejecución:** secuencial por gates; sin fechas inventadas ni estimaciones no medidas.

Este plan no crea un OCP, EP-TASK ni folio nuevo. EV2-01…EV2-08 son identificadores internos de paquete dentro de EP-TASK-004. Cada paquete conserva debajo el criterio de origen literal del operador.

## 1. Orden del sprint

| Orden | Paquete | Resultado | Estado |
|---:|---|---|---|
| 0 | Cierre de diseño y revisión B/C | Diseño integral revisado por el operador; gate P012/P013 satisfecho | DISEÑO PREPARADO · REVISIÓN PENDIENTE |
| 1 | EV2-01 Baseline y custodia de datos | Una release base reproducible y una sola ruta activa identificada, sin pérdida | PREFLIGHT PARCIAL · RUTAS SIN RECONCILIAR |
| 2 | EV2-02 Formato criptográfico y migración | Sobre v2, compatibilidad v1, migración y rollback verificables | DISEÑO · NO IMPLEMENTADO |
| 3 | EV2-03 Host local e aislamiento de agente | Interfaz cerrable, custodia residente en memoria y frontera real de identidad | DISEÑO · BLOQUEADO POR AISLAMIENTO |
| 4 | EV2-04 CLI y uso delegado | Configuración CLI local y operaciones de uso sin revelar valores | DISEÑO · NO IMPLEMENTADO |
| 5 | EV2-05 Ubicaciones y sesiones | EFIMERA/NO_EFIMERA, expiración y registro mínimo | DISEÑO · PROPUESTA DUG PENDIENTE |
| 6 | EV2-06 Dead-man y Cryptomator | Pausa, 120 s, limpieza y desmontaje verificado | DISEÑO · NO IMPLEMENTADO |
| 7 | EV2-07 GUI mínima | Autenticación, duración/expiración y pausa; GUI no requerida en operación normal | DISEÑO · H10 PENDIENTE |
| 8 | EV2-08 Seguridad, regresión y aceptación | Pruebas negativas/positivas, migración y aceptación humana | PENDIENTE |

### Gate de despacho obligatorio

La revisión P012/P013 de seguridad y arquitectura se sitúa **antes de iniciar cualquier construcción**. La aprobación general de continuar no sustituye la revisión presencial B/C. El diseño y la programación documental pueden prepararse; no se despachan tareas de código, GUI, servicio local, política de acceso o migración hasta satisfacer ese gate.

Después del gate, EV2-01 sigue siendo el primer paquete técnico y debe cerrar antes de modificar el almacén. Cualquier fallo en ruta activa, hash de baseline, restauración o aislamiento bloquea solo el trabajo dependiente; no se resuelve mediante suposiciones ni inicialización destructiva.

## 2. Paquetes de trabajo

## EV2-01 · Baseline v1.0.0, procedencia y ruta efectiva

**Objetivo:** fijar un baseline reproducible y establecer qué almacén cifrado es el activo, sin abrir valores ni tocar datos reales.

**Trabajo:**
1. Fijar la release de referencia mediante MANIFEST y los Git blob SHA de Core, CLI, GUI, XAML, tests y recursos.
2. Preservar la carpeta local divergente como evidencia; comparar Core/GUI/XAML contra el baseline, sin sobrescribir ninguno.
3. Inventariar lanzadores, variables de proceso, redirecciones LOCALAPPDATA, configuración, ACL y rutas efectivas.
4. Reconciliar las dos raíces observadas: MOD-EPVAULT/v1.0.0/data/Fila4/Khora/secrets y EP/local-state/Khora/secrets. Documentar origen, timestamp, hashes, backups y vínculo con B2 sin mostrar valores.
5. Identificar cuál es la fuente activa mediante el flujo de autenticación/read-back permitido. Si no puede demostrarse, detenerse y preservar ambas.
6. Definir una sola ruta canónica por terminal y perfil de ubicación, dentro del workspace Cryptomator de acuerdo con OEP §137. No moverla aún.

**Criterios de aceptación:**
- Un manifiesto de baseline reproducible y cada archivo de producto coincide con el blob esperado.
- Las divergencias locales quedan explicadas y preservadas; ningún archivo se sobreescribe por coincidencia de nombre.
- La ruta activa queda demostrada con evidencia de lectura de vuelta; no basta con la última fecha de escritura.
- Todos los backups y archivos existentes quedan inventariados; ninguna copia se elimina.
- Se identifica con precisión cómo cada launcher resuelve el root de datos.
- No se ejecuta Initialize, no se escribe en la bóveda real y no se revelan valores.

**Dependencias:** revisión P012/P013; ninguna otra tarea técnica puede resolver la ruta en paralelo.

**Criterio fuente (verbatim):**

> Toma en cuenta todo el diseño, resuelve las tareas cuidadosamente. Siempre documenta el criteriov  verbatim detras de la tarea.
>
> Programa el sprint,no quiero nada mas de lo discutido y nada menos.

## EV2-02 · Sobre criptográfico v2 y migración no destructiva

**Objetivo:** definir e implementar una evolución segura del formato sin invalidar v1 ni arriesgar el almacén existente.

**Trabajo:**
1. Auditar con el baseline fijado la derivación de claves, separación de claves, IV/salt, MAC, autenticación previa al descifrado, atomicidad, DACL, backup y tratamiento de memoria.
2. Especificar el sobre v2 versionado, canonicalización de metadatos autenticados y metadatos mínimos por secreto.
3. Conservar lectura v1. El formato v2 mantiene PBKDF2-HMAC-SHA256 600.000 y AES-256-CBC + HMAC-SHA256 como perfil compatible mientras no exista benchmark/dependencia aprobada para cambiarlo.
4. No introducir Argon2id, AES-GCM ni nuevas dependencias criptográficas sin evaluación de runtime PowerShell 5.1/.NET, benchmark, pruebas de interoperabilidad y decisión de diseño.
5. Diseñar migración: backup verificado, escritura a nuevo archivo, reapertura, comparación interna sin mostrar valores, read-back y rollback.
6. Proteger el registro de eventos: integridad comprobable, ACL mínima, timestamps UTC y ninguna captura de valores. Fallo de auditoría impide usos delegados.

**Criterios de aceptación:**
- Vector de prueba v1 puede leerse en v2; versión incorrecta o tampering falla antes de exponer texto claro.
- Migración interrumpida preserva el archivo anterior y permite volver atrás.
- MAC, salt, IV y metadatos están cubiertos por las pruebas.
- Los valores nunca aparecen en stdout, stderr, logs, argumentos o archivos temporales.
- La suite negativa cubre contraseña incorrecta, manipulación, write interruption, backup y read-back.
- Ninguna migración de los dos almacenes reales se ejecuta dentro de este paquete; se autoriza como operación separada después de EV2-08.

**Dependencias:** EV2-01 cerrado.

**Criterio fuente (verbatim):**

> Novelocker vs Boveda, para esta actualizacion incluiremos una mejora de la boveda de variables que se adhiera a estandares de calidad como novelocker, hace lo que hace la boveda veradd?
>
> De lo anterior, necesitamos simplemente una solucion que no nos comprometa mas de lo necesari, y solo hasta ahi, accesible mediante CLI,  para  configurar secretos,  deuso temporal,&#x20;

## EV2-03 · EP Vault Host e aislamiento real del modelo

**Objetivo:** permitir que EP Vault opere sin ventana abierta, sin que el proceso del modelo obtenga la clave o el valor.

**Trabajo:**
1. Implementar el Host local sin ventana, subordinado a MOD-EPVAULT, iniciado después de autenticación local y mantenido durante la concesión.
2. Mantener clave de sesión, credencial de apertura Cryptomator y concesiones solo en memoria durante la concesión activa. No crear un archivo DPAPI CurrentUser que permita a procesos de la misma identidad recuperar la clave compartida; al sellar, retirar la credencial y concesión de memoria.
3. Exponer canal local (Named Pipe con ACL) únicamente para la identidad agente autorizada y la UI/operador. El canal admite `RequestWorkspaceOpen` y `RequestLock` solo con concesión activa.
4. Crear/usar identidad Windows agente separada, estándar, no administradora y sin ACL de lectura sobre la bóveda, notas, backups, memoria del Host o volumen montado.
5. Restringir RDC para que el agente no tenga shell ni filesystem directo que permita eludir el Host. La opción actual allowedDirectories=[] no satisface esto.
6. Verificar la identidad real del cliente y cada operación; no emitir bearer token al contexto del modelo.
7. Al terminar/reiniciar Host, invalidar concesiones y exigir autenticación local nueva.

**Criterios de aceptación:**
- Cerrar la GUI no termina la sesión autorizada mientras Host esté activo y dentro de TTL.
- Con concesión activa, el modelo puede solicitar montar y bloquear Cryptomator; Host entrega la contraseña por stdin y nunca la devuelve al modelo.
- `RequestWorkspaceOpen` no crea ni prolonga concesiones y falla tras pausa, bloqueo o expiración hasta nueva autenticación local.
- Host bloqueado/reiniciado no restaura claves/credenciales desde disco.
- La identidad agente no puede leer el archivo cifrado, descifrar DPAPI CurrentUser, inspeccionar memoria del Host, leer el volumen ni lanzar PowerShell arbitrario con identidad propietaria.
- Una solicitud directa a archivos/rutas/secretos fuera del pipe se deniega.
- Si RDC conserva shell/filesystem irrestricto bajo la identidad del operador, el uso delegado de secretos permanece deshabilitado; no se marca como excepción aceptable.

**Dependencias:** EV2-01; decisión presencial P012/P013.

**Criterio fuente (verbatim):**

> Se tendria que abrir  y cerrar la boveda mediane el uso del token? Es decir, unmodelo con  el tokenpodria abrir la boveda y cerrarla al terminar?
>
> Como puedo tener unsecreto disponible enEP vault sintener la boveda abierta, para que los modelos lo tomen. Pero demanera segura?

## EV2-04 · CLI de configuración y operación de secretos

**Objetivo:** mantener CLI como superficie normal de administración local y permitir uso delegado sin mostrar el valor.

**Trabajo:**
1. Reconciliar el contrato CLI con el código exacto de v1.0.0; corregir los casos CaptureNote/Load/TTL que no coincidan.
2. Conservar Status, Unlock local, List, Set/SetFromClipboard, Remove, notas y Lock con salida no sensible.
3. Capturar valores desde prompt local seguro o clipboard del operador; nunca desde argumentos, línea de comandos, variables persistentes, logs o transcripción.
4. Mantener Reveal solo como acción local explícita del operador; el agente no puede invocarlo ni recibir su stdout.
5. Retirar Run genérico del contrato del modelo. Sustituirlo por Use sobre operationId y adaptadores nominados con host HTTPS, método, rutas y parámetros permitidos.
6. No implementar adaptadores de proveedores no especificados. Definir el contrato y probarlo con un adaptador sintético.
7. Registrar quién/qué pidió, secreto referenciado, operación, destino, hora, expiración y resultado; nunca valor/headers/argumentos sensibles.

**Criterios de aceptación:**
- CLI local puede agregar, actualizar, listar por nombre y eliminar por acción explícita sin mostrar valor.
- Ninguna herramienta del agente devuelve el valor secreto.
- El agente no puede seleccionar ejecutable, argumento, URL, header o destino arbitrario.
- Las redirecciones, respuestas de error y respuestas del servicio no devuelven credenciales ni headers sensibles.
- La autorización expirada o revocada falla cerrada y queda auditada.
- Si el log crítico no puede escribirse, Use/Authorize falla cerrado.

**Dependencias:** EV2-02 y EV2-03.

**Criterio fuente (verbatim):**

> De lo anterior, necesitamos simplemente una solucion que no nos comprometa mas de lo necesari, y solo hasta ahi, accesible mediante CLI,  para  configurar secretos,  deuso temporal,&#x20;
>
> Como puedo tener unsecreto disponible enEP vault sintener la boveda abierta, para que los modelos lo tomen. Pero demanera segura?

## EV2-05 · Tipos de ubicación y modelo de sesión

**Objetivo:** incorporar los dos tipos mínimos al perfil de ubicación y definir qué se conserva/elimina.

**Trabajo:**
1. Proponer en ART-013 del DUG un atributo obligatorio persistence_type: EFIMERA | NO_EFIMERA.
2. Mantener terminal_id separado de location_id; el tipo pertenece a la ubicación y no constituye nivel de confianza.
3. La sesión hereda tipo de ubicación. Registro mínimo: session_id técnico, location_id, terminal_id, persistence_type, opened_at_utc, expires_at_utc, state y scope.
4. Para EFIMERA, dropdown con 15s, 30s, 1m, 2m, 3m, 5m, 10m y 15m; entrada manual en segundos dentro del intervalo 1–900s; default 5m. Se elimina la opción 1h no soportada consistentemente por el CLI.
5. Para NO_EFIMERA, seleccionar fecha/hora de expiración. Mostrar hora local y guardar UTC.
6. Las ubicaciones EFIMERA tienen un subárbol EP temporal por terminal/sesión; NO_EFIMERA conserva ciphertext local.
7. Preparar el texto exacto de ART-013 como patch propuesto, sin escribir DUG antes de aprobación P005/P012/P013.

**Criterios de aceptación:**
- El perfil tiene uno y solo uno de los tipos; un perfil sin tipo no puede abrir sesión.
- El tipo se hereda, no lo decide implícitamente el modelo ni el hostname.
- EFIMERA y NO_EFIMERA producen comportamientos diferentes verificables.
- Terminal y ubicación se almacenan como dimensiones separadas.
- DUG solo se actualiza después de revisión presencial y autorización activa; hasta entonces la propuesta permanece no normativa.

**Dependencias:** EV2-01 y revisión P012/P013.

**Criterio fuente (verbatim):**

> Las sesiones se configuran por ubicacion, se debe de normar enel dug, los tipos de ubicacion,  por lo menos dos: Efimera y No-Efimera, asi que queden.&#x20;
>
> La sesion efimera es volatil, se borra todo con hombre muerto. Y de de duracion variable, en la interfaz vamos a poner undropdown, y tambien a permitir ingreso abierto.&#x20;
>
> La sesion no-efimera, se trata como semi-permanente, confecha de expiracion. No se borran los datos encriptados del entorno local.  &#x20;

## EV2-06 · Dead-man, pausa y ciclo Cryptomator

**Objetivo:** sellar la sesión cuando el operador se ausenta y verificar que la bóveda deja de estar montada.

**Trabajo:**
1. Host mantiene el monitor de inactividad, independiente de la GUI.
2. Detectar input de teclado/ratón en la sesión Windows del operador. Integrar un evento explícito de voz activa emitido por el cliente; no grabar ni transcribir audio. Micrófono abierto por sí solo no reinicia temporizador.
3. Actividad del modelo/agente no reinicia el temporizador.
4. Switch manual inicia sellado inmediatamente; inactividad de 120s activa dead-man.
5. Revocar concesiones y bloquear nuevas operaciones; drenar solicitudes, escritores y handles; cerrar procesos autorizados.
6. Solicitar desmontaje graceful de Cryptomator CLI; comprobar que no queda volumen/montaje. Un handle abierto o GRACEFUL UNMOUNT FAILED produce LOCK_FAILED y bloquea backup/sync.
7. Retirar claves/buffers mutables y limpiar subárbol temporal EP según el tipo de ubicación.
8. Reanudar únicamente tras introducir localmente la contraseña maestra; un token de modelo no puede reabrir.

**Criterios de aceptación:**
- El timer cumple 120s en la sesión propietaria, con pruebas de input y sin reset por actividad del modelo.
- El evento de voz reinicia solo cuando el cliente confirma captura/entrada de voz del operador; si no existe esa señal, la aceptación de audio queda pendiente.
- EFIMERA: dead-man/expiración sella y elimina solo el subárbol temporal propio; no afecta almacenes de otras ubicaciones/terminales.
- NO_EFIMERA: dead-man/expiración sella y conserva ciphertext.
- Manual pause sella y exige reauth; no reactiva sesión por reabrir la ventana.
- Cryptomator queda desmontado y ausente antes de declarar LOCKED. En fallo, estado explícito LOCK_FAILED.

**Dependencias:** EV2-03 y EV2-05.

**Criterio fuente (verbatim):**

> Las sesiones se pausan. Por inactividad, o switch en la interfaz. Al páusarse se cierra el acceso al secreto que contiene la llave de la boveda, para  que no sea posible  obtenerlo, si no se ingresa la contraseña maestra en laintrfaz. De esa manera seria mi responsabilidad cerrar  mi sesion,   si me llevanto, pero si lo olvido, se garantiza el sellado  tras unos pocos minutos de inactividad. Dos minutos. es todo lo que toma borrar la boveda, si no se registrada entrada de audio, raton, o teclado, o uso del  equipo por el usuario.&#x20;

## EV2-07 · GUI mínima, configuración y notas efímeras

**Objetivo:** mantener GUI solo para las acciones humanas justificadas y no convertirla en dependencia de operación normal.

**Trabajo:**
1. Conservar la GUI física clean-room vigente únicamente después de revisar sus hashes y aceptación H10; no reusar la GUI legacy.
2. Mostrar perfil/ubicación y tipo heredado, dropdown/entrada manual EFIMERA, fecha/hora NO_EFIMERA, pausa, estado y tiempo restante.
3. Usar GUI para ingreso local de contraseña maestra, notas efímeras y acciones de autorización/rotación que requieran al operador.
4. Permitir cerrar GUI sin cerrar Host; la operación normal de modelo sigue por CLI/canal local.
5. No añadir dashboard, panel de administración separado ni monitor visual permanente.

**Criterios de aceptación:**
- Ninguna acción de uso normal del modelo requiere GUI.
- GUI pide la contraseña local para abrir/reanudar; contraseña nunca aparece en argumento o log.
- La GUI cerrada no oculta un estado bloqueado ni prolonga TTL.
- Notas efímeras conservan TTL, lista de metadatos y revelación exclusivamente local explícita; una nota enviada al modelo pasa a estar disponible para el modelo y no se trata como secreto oculto.
- B/C y H10 se registran como revisados por el operador; test de XAML/nombres no sustituye revisión visual.

**Dependencias:** EV2-05 y EV2-06.

**Criterio fuente (verbatim):**

> Creo que no es la solución que necesitamos porque necesito una solución headless CLI para trabajarla con el modelo vía RDC sin que yo tenga que tener una interfaz gráfica abierta. A no ser que tenga que ingresar una contraseña, por ejemplo. Y nada más, como es el caso de la bóveda de entorno persistente. ¿Puedo tener una interfaz gráfica? Por ejemplo, la bóveda canónica de, perdón, la, corrijo, la bóveda de variables de entorno. La tengo en interfaz gráfica porque necesito ingresar una contraseña y a veces utilizo, por ejemplo, notas efímeras. De hecho, esos dos usos son los únicos que justifican el uso de una interfaz gráfica. Si no fuera así, no lo tendría que ver jamás el componente en el monitor.

## EV2-08 · Seguridad, regresión, migración y aceptación

**Objetivo:** verificar la implementación como producto y solo entonces autorizar cualquier migración real.

**Trabajo:**
1. Ejecutar suite en baseline fijado y suite v2 aislada con fuentes/hash/manifiesto.
2. Pruebas negativas de shell/RDC, acceso a paths, pipe ACL, DPAPI same-user, reveal, Run, egress, audit tampering y reuso de concesión revocada.
3. Pruebas de cifrado, migración, recuperación, atomicidad, backups, TTL, dead-man, voz, pause, unmount y tipos de ubicación.
4. Pruebas en dos identidades Windows; después en dos terminales físicas, preservando separación terminal/ubicación.
5. Solo tras aceptación, preparar un plan separado para reconciliar/migrar el almacén real. Read-back de cada candidato, respaldo preservado y autorización explícita antes del primer cambio real.
6. Publicar código/documentación/testes en main con manifiesto y read-back. Aceptación humana final separada del resultado técnico.

**Criterios de aceptación:**
- Todos los tests positivos y negativos pasan sobre el commit/hash exacto que se pretende liberar.
- Se demuestra recuperación del almacén v1 y restauración del backup.
- Ningún secreto aparece en output, logs, argumentos, entorno de agente ni expediente de prueba.
- Dead-man y desmontaje son verificables, sin declarar success si existe LOCK_FAILED.
- La ruta activa se conoce y se restaura antes de mover o transformar datos.
- H10, P012/P013 y aceptación humana están documentados; mientras falten, RELEASE/ACCEPTANCE no se marcan PASS.

**Dependencias:** EV2-01 a EV2-07.

**Criterio fuente (verbatim):**

> No quiero elementos que no sean absotulamente esenciales en el marco administrativo. Solo lo necesario objetivvamente.
>
> Programa el sprint,no quiero nada mas de lo discutido y nada menos.
>
> Pero primero finaliza todo el disñeo tomate los ciclos que necesites. Pero trabaja con la integridad y soldiez que te digo

## 3. Gates de entrada, salida y bloqueo

### Entrada a construcción

Todos deben ser verdaderos:

- Diseño revisado presencialmente por el operador bajo P012/P013.
- EV2-01 identifica baseline y ruta activa; ambas copias previas preservadas.
- Se aprueba la frontera de identidad del agente y se elimina shell/filesystem de bypass.
- La propuesta ART-013 se revisa y recibe autorización normativa explícita antes de tocar DUG.

### Salida técnica de cada paquete

El paquete se cierra con:
- fuente literal del criterio de operador (ya incluida aquí);
- cambios identificados por archivos y hashes;
- pruebas ejecutadas y resultado real;
- read-back de los artefactos;
- límites y fallos que sigan abiertos.

### Bloqueos duros

- Sin aislamiento real del agente: no hay uso delegado de secretos.
- Sin ruta activa demostrada: no hay migración.
- Sin graceful unmount verificado: no hay LOCKED ni backup.
- Sin señal de voz del cliente: audio no se declara cubierto por el dead-man.
- Sin P012/P013: no inicia construcción.
- Sin P005 y autorización activa: no se modifica DUG.

## 4. Límites del sprint

No se añaden paquetes de UI/portal, cloud, Rclone, Backblaze, MCP normativo, OAuth, segundo almacén, segundo gestor de secretos, backup del workspace ni migración integral de SeryMente. No se crean nuevos EP-TASK, OCP, folios ni IDs administrativos. EP-TASK-004 mantiene la titularidad.

## 5. Estado al programar

- DISEÑO: INTEGRADO PARA REVISIÓN; no aprobado por B/C.
- EV2-01: PREFLIGHT PARCIAL; baseline sintético probado; divergencia local y dos almacenes sin reconciliar.
- EV2-02…EV2-08: PROGRAMADOS; no despachados a construcción.
- DUG ART-013: patch propuesto; no escrito.
- Datos reales, secretos y Cryptomator: sin cambios en este ciclo.
- BUILD: BLOQUEADO HASTA REVISIÓN P012/P013.
