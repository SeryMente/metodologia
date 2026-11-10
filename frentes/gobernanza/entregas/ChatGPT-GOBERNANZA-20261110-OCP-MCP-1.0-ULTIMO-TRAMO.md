# Gobernanza · OCP MCP 1.0 · último tramo conversacional

**Fecha:** 2026-11-10 · **Repositorio:** SeryMente/metodologia · **Rama:** main.
**Naturaleza:** persistencia de conversación y coordinación documental; no aprueba todavía parámetros criptográficos ni autoriza operaciones de host/B2.

## 1. Solicitud literal del operador

~~~text
Bueno, sigamos diseñando, Mira, yo le llamo gatillo de hombre muerto porque idealmente yo tengo que activar el borrado de mi espacio de trabajo en las ubicaciones efímeras donde me pongo a trabajar. O mejor dicho, en las ubicaciones donde utilizo sesiones de naturaleza efímera para trabajar. Sin embargo, a veces no puedo borrarlo, a veces salgo corriendo, a veces se me olvida, a veces se me acaba el crédito del cibercafé y ya no me da chanza de borrar. Yo no sé si realmente las sesiones en el cibercafé sean efímeras. Entonces yo necesito un mecanismo que para ese tipo de escenarios me garantice el borrado automatizado de todo el espacio de trabajo. Obviamente no les voy a borrar el disco duro a estas personas, pero como sugieres, pero debemos de tener un mecanismo automatizado que al inicio de la sesión recolecte datos de la máquina donde se está trabajando para saber si es un disco duro de estado sólido o si es un disco duro giratorio y en base a eso determinar la mejor estrategia para borrar el espacio de trabajo. Ahora, entiendo lo que dices. Si el espacio de trabajo está cifrado, entonces no es tan importante el borrado. y eso está bien. Entonces no hay que hacer tanto énfasis en un borrado súper mega nuclear, que tiene que sea un borrado, digamos, nuclear nomás, pero siempre y cuando el espacio de trabajo sí esté bien protegido mediante una estrategia de encriptación sólida, profesional y seria. Hay que organizar la secuencia de OCP MSP 1.0 de manera que las cuestiones de seguridad más urgentes y más asequibles estén primero que otras no tan urgentes y más difíciles en la secuencia. Es decir, cuáles beneficios de seguridad puedo tener rápido y fácil, de los más importantes. Tú me entiendes lo que quiero decir? Organiza la secuencia de manera inteligente y con hitos que podamos celebrar en el corto corto plazo. Así como tenemos el hito de zinc, planea otros hitos que podamos celebrar en el corto corto plazo. Este, por ejemplo, ya tengo encriptación para el espacio de trabajo, ya lo tengo persistente, etcétera. Además, bueno, hasta ahí. sigamos diseñando.
~~~

## 2. Última salida visible del modelo, reproducida literalmente

~~~text
Sí. Ahora sí tenemos un criterio de diseño bastante más claro: **OCP MCP 1.0 debe permitir trabajar en computadoras que no controlamos, sin dejar allí una copia recuperable de nuestro workspace cuando termina la sesión.**

Y hay algo importante: no necesitamos confiar en que el cibercafé borre los perfiles de Windows. Tenemos que tratar cada computadora externa como un equipo potencialmente persistente.

## 1. El concepto central: workspace de sesión con caducidad

Propongo que cada sesión de trabajo tenga una especie de contrato de uso temporal:

1. **Llegada a una computadora:** OCP examina el entorno: Windows, almacenamiento, permisos, cifrado y disponibilidad de herramientas.
2. **Apertura del workspace:** recupera los datos desde Backblaze, verifica su integridad y abre el espacio de trabajo cifrado.
3. **Trabajo:** los cambios se guardan localmente y se respaldan periódicamente de forma cifrada.
4. **Finalización o vencimiento:** se cierra el workspace, se elimina la capacidad local de descifrarlo y se ejecuta la limpieza de residuos propios de OCP.
5. **Siguiente computadora:** se recupera el último estado confirmado y se continúa trabajando.

La sesión debe tener una duración renovable. Por ejemplo, una autorización de 30 minutos que se renueve mientras estás trabajando. Ese plazo es ilustrativo, todavía no está aprobado.

Si te quedas sin tiempo en el cibercafé, el vencimiento de la sesión activa el cierre automático.

## 2. El examen de la computadora

Tu idea de identificar HDD o SSD es correcta. La incorporaría al inicio de cada sesión.

OCP recogería, sin modificar el equipo:

| Dato | Para qué sirve |
|---|---|
| Tipo de unidad: HDD, SSD o desconocido | Seleccionar limpieza complementaria. |
| Modelo y bus | Identificar limitaciones del almacenamiento. |
| Cifrado del volumen anfitrión | Evaluar exposición de archivos temporales. |
| Permisos disponibles | Saber qué operaciones puede realizar OCP. |
| Sistema de archivos | Seleccionar mecanismos compatibles. |
| Estado de suspensión e hibernación, cuando sea observable | Evaluar posibles residuos adicionales. |

Windows expone MediaType mediante su API de almacenamiento: HDD, SSD o sin especificar. No siempre podremos identificar correctamente el medio, por lo que un resultado desconocido debe considerarse una condición conservadora, no una autorización para experimentar.

**La estrategia importante:** no dependeremos del tipo de disco para garantizar la confidencialidad. El cifrado será la protección principal. La identificación del disco servirá para decidir si conviene una limpieza adicional.

## 3. Cómo funcionaría el borrado automático

Propongo tres operaciones complementarias:

- **Cerrar:** terminar procesos, cerrar aplicaciones propias y desmontar el workspace.
- **Destruir la clave de sesión:** eliminar las claves temporales y sus copias locales. Esta es la protección principal.
- **Limpiar residuos:** borrar archivos temporales, cachés y artefactos que OCP haya creado fuera del contenedor protegido.

En HDD podría estudiarse una sobrescritura adicional sobre archivos propios y espacios controlados.

En SSD o almacenamiento desconocido no confiaría en la sobrescritura convencional. NIST SP 800-88 Rev. 2, publicada en septiembre de 2025, da un papel relevante al saneamiento criptográfico y exige considerar el dispositivo y la validación del método.

**Decisión de diseño recomendada:** la clave de sesión no debe quedar almacenada en claro en la computadora del cibercafé.

Si la computadora se apaga inesperadamente, los archivos cifrados pueden permanecer físicamente, pero no deben poder abrirse sin recuperar la clave autorizadamente.

Hay una limitación que debemos asumir: si el equipo anfitrión está comprometido mientras el workspace está abierto, puede copiar información en ese momento. Ningún mecanismo de borrado posterior puede deshacer esa copia.

## 4. Backblaze: la fuente de continuidad

Aquí aprovechamos lo que ya tienes implementado en EP.

Mi propuesta es separar las claves:

**Workspace y datos de usuario**  
Documentos · proyectos · DB · configuración

↓

**Cifrado antes de Backblaze**  
Clave de respaldo independiente

↓

**Backblaze B2**  
Snapshots · versiones · manifiestos · recuperación

La bóveda también se respalda, pero nunca como un archivo de secretos en claro. Necesitamos una estrategia separada de recuperación de claves.

Y no confundiremos borrar una versión visible de B2 con destruir todas sus versiones: Backblaze mantiene versiones anteriores y las reglas Lifecycle gobiernan su eliminación.

## 5. Orden inteligente: hitos cortos de OCP MCP 1.0

1. **Hito 1 · SINK:P004 — El modelo recupera contenido real.** Validar el recorrido IPZ → RDC → MCP STDIO y recibir el texto íntegro con trazabilidad.
2. **Hito 2 · Workspace protegido — Abrir y cerrar un espacio cifrado.** Aprovechar la encriptación de workspace que reportas como existente. Verificar apertura, bloqueo, desmontaje y ausencia de claves en claro.
3. **Hito 3 · Primer respaldo completo — Workspace y bóveda recuperables desde B2.** Snapshot cifrado, manifiesto, hashes y primera restauración comprobada.
4. **Hito 4 · Sesión con vencimiento — No depender de que recuerdes borrar.** Temporizador, renovación de autorización, bloqueo automático y destrucción de la clave local al vencer.
5. **Hito 5 · Limpieza automática adaptativa — Identificar HDD/SSD y limpiar los residuos propios.** Limpieza controlada, verificación y tratamiento conservador de equipos desconocidos.
6. **Hito 6 · Recuperación entre equipos — Cambiar de cibercafé sin perder continuidad.** Restaurar en otro equipo y validar que el resultado coincide con el último respaldo confirmado.
7. **Hito 7 · Panel WPF y dead-man completo — Ver qué ocurre y qué protección está activa.** Indicadores de sesión, proceso, MCP/STDIO, fuentes, readiness, cifrado local, respaldo remoto, última sincronización, restauración y saneamiento.
8. **Hito 8 · MCP-OCP 1.0.0.** Pruebas generales, recuperación, seguridad, paquete reproducible y aceptación integral.

## 6. Una decisión que no debemos pasar por alto

**Situación A — Se te acaba el tiempo en el cibercafé.** OCP debe cerrar la sesión y eliminar la copia local recuperable. Tu trabajo ya debe estar respaldado en B2.

**Situación B — Detectamos que el equipo puede estar comprometido.** OCP debe bloquear inmediatamente el acceso, destruir la clave local y no confiar en ese equipo para nuevas transferencias.

En ambos casos protegemos los datos, pero no necesariamente ejecutamos la misma secuencia.

## Mi propuesta para continuar

Antes de aprobar el diseño del dead-man, hay una cuestión técnica importante:

**¿Quieres que el workspace completo se descargue y se trabaje localmente en cada cibercafé, o prefieres que el contenido permanezca principalmente en tu entorno persistente y que el cibercafé utilice una copia local temporal solo de lo que necesites?**

Mi recomendación inicial es la segunda: reduce la cantidad de información expuesta en cada computadora y puede disminuir mucho el tiempo de limpieza.

Todavía no he actualizado tareas provisionales ni controles. Estamos cerrando el diseño; después traduciremos cada decisión aprobada a tareas concretas de EP, MCP-OCP y Gobernanza.
~~~

## Repetición de ciclo · adquisición, contraste y diseño

**Repositorio:** SeryMente/metodologia · main  
**HEAD adquirido:** 11a3317a10404ed3eaa853f3718ebeecbb161e56 (2026-11-10 20:21:17Z).  
**DUG:** Samantha v388 · NX-388m · ART-027; commit 3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c; blob 4db0ebadfd1e48b2bdec9236ba7f344921e4a865.  
**Control Gobernanza:** generación 17, blob 16a4265c8a5f1c3d5db7a96ca83100bcd973a42e; sin cambios.

### Backblaze: reporte del operador frente al último read-back

El operador reporta que EP terminó recientemente la persistencia por Backblaze. El último read-back de EP-TASK-002 disponible al adquirir este ciclo aún registra:
- Dos lecturas CLI con vaultSessionActive=false, variableCount=0 y las cinco variables B2 ausentes.
- Ciphertext local de 2.200 bytes.
- Workers/wrapper con análisis sintáctico PASS.
- Sin recibo ep-backblaze-persistence-result.json.
- Sin autenticación B2, upload, descarga, SHA-256 remoto ni restore acreditados en ese ciclo.

Se conserva el reporte del operador, pero el estado integrado es B2_REMOTE=NOT_VERIFIED_PENDING_EP_RECONCILIATION. EP debe aportar el recibo más reciente y su read-back. No se afirma que la persistencia esté fallida en absoluto ni que esté terminada: existe una discrepancia temporal/de evidencia abierta.

### Nombre y objetivo

- Programa/sprint completo: OCP MCP 1.0.
- Producto software final: MCP-OCP 1.0.0.
- Primer hito operativo: SINK:P004; ya no es el nombre del sprint.
- H1 exige que el modelo reciba el texto íntegro desde IPZ real por RDC → MCP STDIO, con ID/título, pin DUG, commit/blob y SHA-256.

### Diseño de seguridad

1. Tratar cibercafés como equipos persistentes/no confiables; no asumir que sus perfiles Windows son realmente efímeros.
2. Cifrado local de la copia efímera como protección primaria. La inspección inicial HDD/SSD/UNKNOWN será no destructiva y solo decidirá limpieza complementaria.
3. Separar la clave efímera de sesión de la clave persistente/de recuperación del backup. Al expirar, destruir solo la capacidad local de descifrar la copia efímera, nunca la única clave que permite recuperar B2.
4. Cifrar del lado del cliente antes de transferir a B2. No subir secretos en claro ni claves maestras junto al ciphertext.
5. Clasificar y respaldar workspace, ciphertext/metadatos autorizados de la bóveda de variables de entorno, datos de usuario/OCP y snapshots consistentes. GitHub continúa siendo la fuente canónica de código/documentos versionados.
6. Al vencer una sesión: detener procesos OCP, bloquear, cerrar/desmontar el contenedor cifrado, destruir clave efímera local y limpiar residuos creados por OCP. Nunca borrar el disco anfitrión, perfiles ajenos ni backups remotos.
7. En SSD o medio desconocido, no confiar en sobrescritura convencional. Saneamiento específico del medio será complementario y condicionado a capacidades verificadas.
8. Separar el dead-man para sesiones efímeras del gate físico EP-TASK-003 de Fila 4.
9. Límite: un host comprometido durante una sesión abierta puede copiar información; ningún borrado posterior revierte esa copia.

### Hitos cortos y camino de dependencias

| Orden | Hito | Evidencia | Dependencia/propietario |
|---|---|---|---|
| H1 | SINK:P004 desde IPZ | Respuesta visible al modelo con pin/hash | MCP-OCP + Gobernanza; EP para gates/instalación |
| H2 | Workspace cifrado verificado | Abrir, bloquear, cerrar/desmontar; no queda clave local persistente | EP; verificar primero el cifrado que el operador reporta |
| H3 | Restore B2 verificado | Upload, descarga, SHA y restore aislado de workspace/bóveda/datos elegibles | EP-TASK-002 + GOV-TASK-014; MCP-OCP define sus datasets |
| H4 | Sesión efímera con lease | Vencimiento, cierre automático y destrucción de clave local sin afectar recuperación | EP + integración MCP-OCP |
| H5 | Limpieza adaptativa | Detección HDD/SSD/UNKNOWN y limpieza de residuos OCP | EP |
| H6 | Observabilidad | Panel WPF con sesión, proceso, STDIO, fuentes, readiness, cifrado, B2, restore y limpieza | MCP-OCP + EP |
| H7 | Release MCP-OCP 1.0.0 | P001–P043, 43 positivos + 8 negativos/frontera, panel, paquete reproducible, instalación y aceptación | Tres frentes |

MCP-OCP-02 → MCP-OCP-05; MCP-OCP-03 (fixtures) y MCP-OCP-04 (harness) avanzan en paralelo. GOV-TASK-007 prepara el candidato IPZ después de congelar el contrato P004. EP reconcilia B2 y EP-TASK-003 en paralelo con desarrollo remoto no sensible. B2 no bloquea fixtures/harness/P004; instalación y datos privados sí esperan sus gates EP. Panel y matriz 43+8 no bloquean H1.

### Decisiones todavía no aprobadas

Nivel definitivo de seguridad; duración/renovación del lease; condiciones y acciones del dead-man; workspace completo local frente a copia selectiva/remote-first; clasificación de rutas; retención/versionado y eliminación remota B2. Los 30 minutos mencionados son un ejemplo, no un parámetro aprobado.

No se autoriza borrar objetos/versiones B2, cambiar ACL/lifecycle/bucket, destruir claves persistentes, alterar controles, escribir IPZ nativa ni operar sobre discos o perfiles de terceros.

**Estado documental propuesto:** OCP_MCP_1_0=DOCUMENTALMENTE_REBASELINED; SINK_P004=NOT_IMPLEMENTED_NOT_ACCEPTED; MCP_OCP_02=OPEN; EP_TASK_002=B2_REMOTE_NOT_VERIFIED_PENDING_RECONCILIATION; EP_TASK_003=PARTIAL_FAIL; EP_TASK_005=PENDING; GOV_E2E=PENDING; IPZ_NATIVE=NOT_VERIFIED; FOL1=PREPARED_NOT_ACTIVE; MCP_NORMATIVO=DESACTIVADO.


---

## 3. Continuación de instrucciones del operador · 2026-11-10

### 3.1 Instrucciones literales recibidas

**Mensaje literal 1:**

~~~text
Si esta bien, duracion renovable.&#x20;

Me interesan los metadatos de la sesion, en general,  esto puede usarse con telemetria para distintos fines. Manteniendolo sencillo, pero puesto que la sesion recolecta las converasciones, y ya estoy desarrollando medicionde tiempo de resolucion de ciclos,  etc, quiero tener identificadores para la sesion, ubicacion, y asociado a la ubicacion dispositivo,  ip, etc, toda la huella digital,  fecha, hora de inicio y finalizacion de la sesion. Eso ya hay que incluirlo en el sprint OCP MCP 1.0. Diseñalo bienpara que nbo sea tan dificil de tener esos metadatos, que sean secuenciales, profesionales, bien diseñados las nomenclauturas. Y utiles. Que no se conviertan en un problema.&#x20;



## 2. El examen de la computadora

Okay.

Amplia la recoleccion de datos de la computadora de la sesion o dispositivo,  al maximo de lo legalmente posible. &#x20;



3. El borrado de la sesion que sea implacable y robusto. Profundo. Tan profundo como sea posible,  sin meternos ne muchos problemas ok? Un desencadenante autoamtico,  mediante GUI de Entrono Persistente,  automaticamente iniciado al instanciar sesion.  Auto desencadenamiento automatico tras cierto tiem'po, busca una forma de desencadenar el borrado autoamtico, que sea util, profesional, serio, y bien pensado.&#x20;
4. Necesito que la persistencia se active, si o si,  aunque sea de manera cruda, como prioridad a partir de ya, y conforme el sprint se va desarrollando, se vaya remplazand por formas mas elaboradas. AL final  se trata de ahorrar tiempo, busca l amanera deque el diseño final de la persistencia, sea tal, que permita una instanciacion y resolucion  de sesiones y necesidades intrasesioneficiente y rapido. LA eficiencia es ultra prioridad al final de los finales.
5. La boveda de variables, anota una tarea para el hitoo,  debe de contener la totalidad, de las variables usadas en khora, y en ocp,  osea toda la organizacion ser y mente. Pregunta puede ser usada para darle contraseñas a RDC para uso seguro sin exponerlas demasiado? La boveda debe de persistirse como prioridad en las primeras etapas de la secuencia del sprint.&#x20;
6. Los hitos estoy de acuerdo.&#x20;



Se descarga el  workspace completo, en cada isntancia.&#x20;
~~~

**Mensaje literal 2:**

~~~text
Toma en cuenta lo anterior, y documenta siempre las instrucciones verbatim. Identifica cosas que yo tenga que responder para que tengas la instruccioncompleta, y 'preguntame, para que puedas pasar a la fase de condfiguracion de tareas en los frentes que esten  implicados, para que esos frentes ya se pongan a trabajar.
~~~

### 3.2 Decisiones expresas incorporadas al diseño

- La duración de la sesión será **renovable**. La duración concreta, la regla de renovación y los límites máximos siguen pendientes.
- Cada instancia descargará el **workspace completo** y lo trabajará localmente.
- OCP MCP 1.0 incluirá metadatos y telemetría de sesión, con identificadores correlacionables para sesión, ubicación, dispositivo, red/IP, conversación y ciclo; marcas de inicio y finalización; duración y eventos de persistencia/seguridad.
- La inspección inicial del equipo será amplia y de solo lectura. Debe identificar, como mínimo, Windows/SO y versión, arquitectura, permisos, recursos, almacenamiento y tipo HDD/SSD/UNKNOWN, sistema de archivos, cifrado observable, conectividad, capacidad disponible y compatibilidad con el mecanismo de workspace.
- El cierre será robusto y profundo, pero acotado a workspace, procesos y artefactos propios de OCP. No se borrarán discos, perfiles, datos o artefactos de terceros.
- La GUI del Entorno Persistente iniciará automáticamente el guardián de sesión al instanciar una sesión. El guardián activará el cierre por vencimiento/condiciones configuradas, sin depender de que el operador recuerde hacerlo manualmente.
- La persistencia debe existir desde las primeras etapas, aunque su primera versión sea mínima. Se sustituirá incrementalmente por una implementación más elaborada sin interrumpir continuidad ni perder datos. La eficiencia de instanciación, recuperación, guardado y resolución intrasesión es prioridad máxima.
- La bóveda cubrirá todas las variables utilizadas por KHORA y OCP en el ámbito organizacional Ser y Mente. La persistencia de la bóveda se prioriza en las primeras etapas.
- Se investigará la integración de la bóveda con RDC para suministrar credenciales en tiempo de ejecución sin exponerlas en argumentos, scripts, registros, portapapeles ni almacenamiento en claro. La capacidad real de RDC y su interfaz segura de entrada deben verificarse antes de seleccionar el mecanismo.
- Se mantienen aceptados los hitos y se modifica su secuencia para adelantar la persistencia y la bóveda.
- Se documenta la intención de aprovechar la recolección de conversaciones y la medición de tiempos de resolución de ciclos; queda pendiente precisar si la telemetría enlazará solo metadatos/IDs o también contenido de conversación.

### 3.3 Diseño propuesto de identidad y nomenclatura

**Principio:** separar identidad técnica estable de etiqueta humana. Ningún identificador debe codificar nombre, IP, dirección física, hostname, serial de hardware o información personal.

| Entidad | Identificador técnico | Etiqueta legible propuesta | Regla |
|---|---|---|---|
| Organización | UUIDv7 | ORG-000001 | Un único espacio de nombres de Ser y Mente. |
| Workspace persistente | UUIDv7 | WSP-000001 | Estable entre instancias autorizadas. |
| Sesión | UUIDv7 | SES-YYYYMMDD-000001 | Consecutivo por workspace y día local; conservar UTC como referencia temporal. |
| Ubicación | UUIDv7 | LOC-000001 | Alias del lugar; no incluir dirección/IP en el ID. |
| Dispositivo observado | UUIDv7 | DEV-000001 | Pseudónimo interno; no derivar del serial ni MAC en claro. |
| Instantánea de red | UUIDv7 | NET-000001 | Una por observación/cambio de red relevante, no una identidad permanente de la persona. |
| Conversación | UUIDv7 | CONV-000001 | Referencia local; no copiar identificadores nativos de plataforma sin necesidad. |
| Ciclo | UUIDv7 | CYC-000001 | Vinculado a conversación y sesión. |
| Evento | UUIDv7 | EVT-000001 | Idempotencia y orden temporal; emitir fuera de la ruta crítica. |

El consecutivo legible se asignará en el ámbito indicado con operación atómica en el almacén persistente. UUIDv7 será la clave técnica para evitar colisiones y permitir generación local. Si una sesión comienza sin conexión, se genera el UUIDv7 local y se asigna/reconcilia el consecutivo cuando se confirme persistencia; no se bloqueará el arranque por un número central. No se usarán folios FOL1 ni IDs nativos como sustituto de estos identificadores OCP.

**Sobre temporalidad:** guardar started_at_utc y ended_at_utc en ISO 8601 UTC, además de zona IANA y offset local observados. duration_ms se calcula con reloj monotónico de la misma instancia; no restar relojes de pared. Registrar end_reason y termination_status para distinguir cierre normal, vencimiento, inactividad, pérdida de autorización, error y cierre forzado.

**Sobre telemetría:** todos los eventos llevan event_id, schema_version, event_type, occurred_at_utc, session_id, workspace_id y los IDs relacionados que apliquen (location_id, device_id, network_snapshot_id, conversation_id, cycle_id). Tipos iniciales: session.started, session.heartbeat, session.lease.renewed, session.idle.warning, session.locked, session.ended, session.deadman.triggered, session.persistence.checkpoint, session.workspace.restored, session.cleanup.completed, session.device.inventory.completed, session.network.observed, conversation.linked, cycle.started, cycle.completed y cycle.not_measured. No duplicar los metadatos completos en cada evento: guardar referencias y un snapshot versionado al inicio/cambios.

### 3.4 Inventario del dispositivo y contexto de ubicación/red

El perfil inicial será **amplio, read-only y basado en allowlist**. “Máximo legalmente posible” no significa capturar indiscriminadamente datos de otros usuarios del equipo. El inventario se divide en niveles para no bloquear inicio ni convertir la huella digital en una carga:

- **Nivel A · Base automática:** fabricante/modelo de equipo cuando esté disponible; familia/modelo de CPU y arquitectura; RAM total; GPU/familia si resulta útil; SO, edición, versión/build y arquitectura; idioma y zona horaria; estado de elevación/permisos; número, modelo/familia, capacidad, bus e interfaz de unidades; HDD/SSD/UNKNOWN; volúmenes, sistema de archivos, espacio libre y estado de cifrado observable; capacidades de suspensión/hibernación cuando sean accesibles; tipo/estado de interfaces de red y conectividad; capacidades de energía; versión de OCP, GUI, RDC y componentes relevantes. Todo sin modificar el equipo.
- **Nivel B · Contexto de red acotado:** IP pública observada; direcciones locales necesarias para diagnóstico; IPv4/IPv6; tipo de interfaz; ASN/operador y geolocalización aproximada derivada de IP si existe fuente fiable. Guardar fuente, hora, precisión estimada y estado de verificación. La IP no se utilizará como identidad estable.
- **Nivel C · Huella seudonimizada opcional:** identificadores de interfaz, hostname o atributos de hardware transformados con HMAC bajo clave organizacional y rotación definida. No conservar su valor original. Solo habilitar tras confirmar propósito, consentimiento/autorización aplicable y retención.
- **Excluido por defecto:** números de serie en claro, SID/usuario/contraseña de Windows, tokens/cookies, perfiles ajenos, historial de navegación, contenido de otras aplicaciones, archivos fuera del workspace OCP, inventario indiscriminado de procesos/programas, SSID/BSSID y escaneo de redes cercanas, certificados privados, teclado/pantalla/captura de contenido y GPS preciso en segundo plano. Cualquier excepción requiere finalidad específica, autorización del titular/administrador del equipo y revisión legal.
- **Ubicación:** location_id representa un alias creado/seleccionado por el operador. La ubicación derivada por IP será país/región/ciudad aproximados y se marcará con su fuente/precisión; GPS o coordenadas exactas estarán desactivados por defecto y requerirán opt-in explícito. No inferir que una dirección física es precisa a partir de IP.

Los campos con posibilidad de identificar al propietario/usuario del cibercafé se tratarán como datos personales o potencialmente personales. Antes de activar recolección extendida se definirá aviso/consentimiento, finalidad concreta, retención, derechos aplicables y autorización del titular/administrador del dispositivo. La ley aplicable depende de los países de operación y de quién determina el tratamiento. No existe una autorización general para capturar “todo” por el mero hecho de que el dato sea técnicamente accesible.

### 3.5 Persistencia mínima inmediata y evolución eficiente

Se propone una escalera que entrega continuidad desde el principio y reemplaza componentes sin cambiar el contrato de datos:

1. **P0 · Journal de sesión:** antes de abrir el workspace, registrar ID de sesión, ubicación/dispositivo observados, lease, estado y último checkpoint conocido en almacenamiento local cifrado y persistente.
2. **P1 · Bóveda temprana:** inventariar nombres, referencias, ámbito, uso, propietario, entorno y estado de cada variable; cifrar valores en cliente y persistir snapshot/manifiesto. Separar secretos de configuración no sensible. Probar restauración de la bóveda antes de depender de ella para RDC.
3. **P2 · Workspace completo:** descargar en cada instancia el snapshot completo confirmado; validar manifiesto, integridad y SHA antes de abrir. Mantener caché local cifrada y deduplicación/chunks para acelerar futuras instancias, sin sustituir el requisito de disponer del workspace completo local.
4. **P3 · Persistencia intrasesión:** journal/WAL de cambios y snapshots incrementales cifrados, con agrupación/compresión/deduplicación y subida fuera de la ruta crítica. Guardar metadatos de checkpoints y acuses; no bloquear conversación/resolución por transferencias secundarias.
5. **P4 · Commit y recuperación:** distinguir LOCAL_DURABLE, REMOTE_UPLOADED, REMOTE_VERIFIED y RESTORE_VERIFIED. La subida no es aceptación. Un checkpoint remoto solo se considera confirmado tras leerlo, cotejar hash y probar la recuperación definida.
6. **Migración sin interrupción:** versión de esquema y formato de snapshot; lectura compatible de la versión anterior; migración transaccional; copia de seguridad anterior; validación/read-back antes de retirar el mecanismo antiguo.

**Regla crítica de cierre:** no destruir la única clave que protege cambios todavía no respaldados. Debe definirse qué prevalece ante expiración mientras hay cambios no sincronizados: (a) cierre y destrucción inmediata, aceptando pérdida de esos cambios; (b) preservar un paquete local de recuperación cifrado y separado del workspace montado; o (c) requerir checkpoint remoto verificado antes de completar cierre criptográfico, con excepción de emergencia. Esta política requiere decisión expresa.

### 3.6 Bóveda organizacional y credenciales RDC

Alcance propuesto: catálogo organizacional de variables para Ser y Mente, con namespaces por producto/sistema y ambiente, por ejemplo SERMENTE/KHORA/DEV, SERMENTE/KHORA/PROD, SERMENTE/OCP/DEV, SERMENTE/OCP/PROD y SERMENTE/INFRA/<SERVICIO>/<ENTORNO>. Cada entrada tendrá nombre canónico, clasificación (secret/config), servicio, entorno, propietario, consumidor, origen, última verificación/rotación, versión y referencia; el valor secreto solo existe cifrado. No duplicar un mismo secreto sin necesidad: permitir referencias controladas.

**RDC:** la bóveda puede actuar como proveedor de credenciales just-in-time. Preferencia: interfaz de secreto soportada por RDC (si existe), Credential Manager del SO o canal IPC/STDIN protegido con control de acceso y vida breve. Evitar parámetros de línea de comandos, archivos temporales en claro, scripts, variables de entorno heredadas, portapapeles, logs y telemetría. El valor se entrega solo al proceso autorizado y se elimina de memoria cuando sea viable. No afirmar compatibilidad de RDC hasta auditar su versión y mecanismo de autenticación.

### 3.7 Secuencia revisada de hitos propuesta

- **H1 · SINK:P004:** primer resultado funcional desde IPZ → RDC → MCP STDIO con texto íntegro y pin/hash.
- **H2 · Persistencia mínima + bóveda:** journal de sesión, inventario organizacional de variables y primera persistencia cifrada de bóveda. Hito corto y prioridad inmediata; la bóveda se restaura en prueba antes de utilizarla como fuente de credenciales.
- **H3 · Workspace completo recuperable:** descarga íntegra por instancia, cifrado verificado, snapshot/manifest, integridad y restore B2.
- **H4 · Identidad y telemetría de sesión:** nomenclatura, ubicación/dispositivo/red, marcas temporales, correlación con conversación/ciclo y registro versionado con privacidad.
- **H5 · Lease renovable y dead-man:** GUI inicia guardián automáticamente; renovación, inactividad/vencimiento, aviso y cierre automatizado.
- **H6 · Limpieza adaptativa robusta:** desmontaje, destrucción de claves efímeras, limpieza de artefactos OCP y verificación por HDD/SSD/UNKNOWN.
- **H7 · Continuidad y observabilidad:** restauración rápida en equipos distintos y panel WPF con estado de sesión, checkpoint, B2, lease y limpieza.
- **H8 · MCP-OCP 1.0.0:** pruebas integrales, generalización P001–P043, 43 casos positivos + 8 negativos/frontera, paquete reproducible, instalación y aceptación.

H1 mantiene independencia de panel y generalización completa. H2 debe correr en paralelo con desarrollo P004 cuando sus gates lo permitan; la persistencia de B2 y la verificación de restore no se darán por concluidas sin read-back.

### 3.8 Base legal y privacidad por verificar

Como referencia inicial para tratamiento privado en México, la LFPDPPP vigente consultada en Cámara de Diputados indica principios de licitud, finalidad, lealtad, consentimiento, calidad, proporcionalidad, información y responsabilidad (art. 5); define dato personal en términos de persona identificada o identificable (art. 2); exige informar mediante aviso de privacidad y describir datos/finalidades/medios (arts. 14–16); y exige medidas de seguridad y confidencialidad (arts. 18–20). La aplicación concreta depende de la finalidad, los titulares, el país y si existe tratamiento por cuenta de terceros. Fuente: https://www.diputados.gob.mx/LeyesBiblio/pdf/LFPDPPP.pdf (texto vigente consultado; última reforma publicada 2025-11-14). No equivale a dictamen jurídico ni cubre otros países.

### 3.9 Preguntas bloqueantes antes de configurar tareas de los frentes

Estas preguntas deben resolverse antes de convertir la propuesta en instrucciones de implementación para EP, MCP-OCP y Gobernanza. Lo no contestado permanecerá explícitamente pendiente; no se inferirá autorización.

1. **Jurisdicción y titularidad:** ¿OCP operará solo en México o también en otros países? ¿La telemetría será únicamente sobre tus sesiones/dispositivos autorizados, o también sobre equipos de terceros con autorización expresa del dueño/administrador?
2. **Ubicación/IP:** ¿Apruebas como predeterminado registrar IP pública y geolocalización aproximada por IP, con coordenadas GPS exactas desactivadas? ¿Quieres habilitar GPS exacto solo mediante consentimiento explícito?
3. **Nivel de huella:** ¿Apruebas el Nivel A automático y el Nivel B de red; dejando el Nivel C seudonimizado como opt-in, y excluyendo por defecto seriales, cuentas, perfiles, procesos completos, SSID/BSSID e historial?
4. **Retención/propósitos:** ¿Qué finalidades habilitas desde el inicio (seguridad/borrado, diagnóstico/soporte, rendimiento/tiempos de ciclo, auditoría/continuidad)? ¿Qué retención deseas para IP exacta y huella seudonimizada, frente a métricas agregadas sin identificadores?
5. **Lease:** ¿Qué vencimiento por inactividad prefieres y cómo se renueva: automático por actividad observada, confirmación periódica en GUI, o ambos? Propuesta inicial a aprobar: lease móvil de 30 minutos, heartbeat de 60 segundos, aviso final y límite absoluto de sesión con reautorización.
6. **Cambios no sincronizados al vencer:** ¿Debe prevalecer borrado inmediato aunque se pierdan cambios no subidos, conservar un paquete local cifrado de recuperación, o bloquear el cierre normal hasta un checkpoint remoto verificado, con cierre de emergencia separado?
7. **Conversaciones:** ¿La telemetría enlazará únicamente IDs y metadatos de conversación/ciclo, mientras el contenido completo permanece dentro del workspace cifrado, o se pretende replicar también el contenido en los registros de telemetría?
8. **Consecutivos:** ¿Te sirve la secuencia por workspace y día (SES-YYYYMMDD-000001) con UUIDv7 como clave técnica, o necesitas un consecutivo global de toda la organización?
9. **Bóveda:** ¿El alcance incluye valores de variables/secretos de todos los sistemas y ambientes de Ser y Mente (producción, desarrollo y pruebas), además de sus nombres y referencias? ¿Autorizas que RDC consuma secretos just-in-time solo después de verificar un canal de entrada seguro soportado?
10. **Arranque y persistencia:** si B2 no está disponible al instanciar, ¿se permite abrir desde el último snapshot local verificado y dejar la subida en cola cifrada, o la sesión debe esperar a confirmar B2 remoto? La rapidez favorece el primer enfoque, pero debe definirse la tolerancia a pérdida.

**Estado:** instrucciones y decisiones anteriores registradas; workspace completo local confirmado; duración renovable confirmada sin parámetros; alcance de bóveda organizacional confirmado como objetivo. La propuesta de esquema, niveles de inventario, persistencia y secuencia es diseño preliminar. No se han configurado ni despachado tareas nuevas a EP/MCP-OCP; no se han modificado sus controles, ni se ha activado telemetría, inspección, lease, borrado, B2 o integración de credenciales.


---

## 4. Respuestas y órdenes finales del operador · 2026-11-10 · criterio de verdad

### 4.1 Respuesta literal sobre parámetros, jurisdicción, telemetría, borrado y persistencia

~~~text
1\. Jurisdicción y equipos: ¿OCP operará solamente en México o también en otros países? ¿La recolección se limitará a equipos que tienes autorización para inspeccionar, incluidos los equipos de cibercafés?

Operaa solamente en mexico, y asume que tengo autorizacion para inspeccionar cualquier mauqina donde opere. &#x20;



2. No,  GPS y todo, siempre y cuando no me haga muy lento, o me cause problemas.&#x20;



3.Nivel robusto por default.



4. &#x20;Las que sean armonicas con  las necesidades de mi proyecto.  Sin quedarme corto. Conservare los datos pro tiempo indenfinido .&#x20;



5. Aprobado.&#x20;





6. Se trata de intentar mantener la recuerabilidad del trabajo o progreso.  Pero borrar todo nuclearmente alcanzado cierto evento. Tratand antes de respaldar, pero dandole prioridad al borrado. &#x20;
7. Todo se cifra,  incluidas las converasciones. &#x20;
8. No lo se,  ya te di las especificaciones, westas preguntas no me interesan.&#x20;
9. Si, pero ponlo en la secuencia,  no lo hagas ahora. Ya te habia dicho, par aque quiers que confirme.  RDC se autentica al inicio de sesion, y se maneja una sola sesion activa, posiblemente dos. Por razones especiales, pero no se si esto esimportante  ahra? O tu dime.&#x20;
10. Pendietnbe en la secuencia medio de persistencia alternativo como respaldo. Por ahora solo backblaze asumiendo que no fallara.&#x20;
~~~

### 4.2 Órdenes literales de configuración y organización

~~~text
Si ya tienes l oque necesitas configura las tareas rapidamente para empezar a trabajar
~~~

~~~text
Siu, recuerda organizar por hitos, documenta toda mi insutrccionverbatim, par que sirvand ecriteriod e verdad para las a tareas
~~~

~~~text
Sí, recuerda organizar por hitos, documenta toda mi insutrccionverbatim, par que sirvand ecriteriod e verdad para las a tareas
~~~

### 4.3 Decisiones vinculantes para las tareas del sprint

1. **Jurisdicción y operación:** México. Para la planificación se toma como declaración del operador que cuenta con autorización para inspeccionar cualquier máquina donde opere. Las implementaciones deben respetar permisos del sistema operativo, avisos/consentimientos legalmente exigibles y límites técnicos; la autorización declarada no implica eludir controles del host.
2. **Inventario:** perfil robusto por defecto. Intentar recoger información de ubicación GPS, IP y contexto de red, además de inventario técnico completo, siempre que el dato sea accesible por interfaces soportadas, su captura no perjudique la velocidad/estabilidad y el tratamiento sea lícito. Guardar origen, timestamp, precisión y estado AVAILABLE/UNAVAILABLE/DENIED/ERROR; no fingir datos ausentes. No elevar privilegios ni evadir permisos de ubicación.
3. **Retención:** conservar indefinidamente los datos cifrados que resulten armónicos con las finalidades operativas del proyecto, salvo obligación legal aplicable, revocación válida o decisión posterior del operador. Mantener inventario de categorías, finalidad, fuente y fecha de captura.
4. **Lease aprobado:** renovación de 60 s mientras la sesión esté activa; ventana de lease de 30 min; aviso previo; cierre por 10 min de inactividad; duración absoluta máxima de 8 h. Cada sesión tendrá lease/estado independiente. Una segunda sesión requiere modo excepcional explícito, máximo dos activas y separación de IDs, claves, eventos y workspace montado.
5. **Cierre prioritario:** ante el trigger terminal, intentar un checkpoint/respaldo primero, pero con presupuesto de tiempo acotado y sin permitir que la persistencia posponga el borrado local. Al agotarse el presupuesto, bloquear/desmontar y destruir criptográficamente la clave efímera local; limpiar residuos OCP. El trigger de emergencia o sospecha de compromiso prioriza cierre/crypto-erasure inmediato y no espera a B2. Jamás destruir la clave de recuperación persistente ni borrar discos/perfiles/datos ajenos.
6. **Cifrado integral:** cifrar todo el workspace, incluyendo contenido de conversaciones, adjuntos y datos persistidos; cifrar también snapshots B2, bóveda y telemetría identificable. La telemetría no replicará contenido en claro. El cifrado no elimina las obligaciones de tratamiento de datos.
7. **Workspace:** descargar el workspace completo en cada instancia y trabajar localmente sobre su copia cifrada. Backblaze es el único destino remoto inicial, bajo EP-TASK-002. El medio alternativo de persistencia queda anotado para una etapa posterior; no provisionarlo ahora.
8. **RDC:** autenticación al inicio de sesión. Una sesión RDC activa por defecto; permitir una segunda solo por excepción explícita. La bóveda deberá entregar credenciales de forma just-in-time a un mecanismo seguro verificado, nunca por command-line, logs, portapapeles o archivos en claro. La integración se planifica y verifica en su hito; no se implementa en esta fase documental.
9. **Nomenclatura:** no bloquear el trabajo por preferencia de consecutivo. Adoptar UUIDv7 como identidad técnica y etiquetas secuenciales legibles por entidad, asignadas de modo atómico; si se inicia sin conexión, el UUIDv7 permite registrar eventos localmente y el consecutivo se reconcilia al persistir. No reutilizar folios FOL1 ni identificadores nativos.
10. **Hitos:** conservar SINK:P004 y ordenar persistencia mínima/bóveda tempranas, workspace completo recuperable, telemetría, lease/dead-man, limpieza y release. La configuración y las asignaciones se estructuran por hitos; cada frente conserva propiedad y evidencia propias.

### 4.4 Especificación de trigger y límite de borrado

- La GUI del Entorno Persistente inicia automáticamente un guardián independiente al crear la instancia; la terminación de GUI/proceso principal, pérdida de heartbeat, lease vencido, inactividad configurada o acción explícita del operador activan el cierre según su clase.
- La política de cierre ordinario intenta una única persistencia/checkpoint bajo un presupuesto inicial configurable de 30 s; si falla, vence el presupuesto o no se confirma el checkpoint, se ejecuta el cierre criptográfico local y se deja el estado de recuperación como no confirmado. El presupuesto se medirá y ajustará en pruebas; no es permiso para extender la exposición.
- El trigger de emergencia/sospecha de compromiso omite la espera de respaldo, bloquea y destruye la capacidad local de descifrado cuanto antes.
- El guardián debe poder completar el cierre si la GUI principal falla. La caída del equipo/corte eléctrico no puede ejecutar limpieza en ese instante: las claves de sesión no deben quedar persistidas en claro, de modo que la pérdida de memoria volátil deje la copia local cifrada e inaccesible.
- La limpieza cubre el contenedor/workspace OCP, procesos/artefactos creados por OCP y residuos temporales identificados. No recorre ni borra indiscriminadamente el perfil ni el disco anfitrión. En SSD/UNKNOWN se prioriza saneamiento criptográfico; no confiar en sobrescritura tradicional.
- El cierre debe emitir recibo local saneado: trigger, tiempos, checkpoint intentado/confirmado, cierre/desmontaje, clave de sesión invalidada, limpieza ejecutada, residuos no eliminables y estado final. No incluir secretos.

### 4.5 Estado de configuración

Decisiones suficientes para configurar las tareas provisionales de Gobernanza, MCP-OCP y EP. La implementación real sigue sometida a los controles y responsables propietarios de cada frente. Esta instrucción autoriza configuración documental de tareas y handoff; no autoriza eludir compuertas host, modificar controles, revelar credenciales, ejecutar operaciones B2, ni borrar o alterar almacenamiento.
