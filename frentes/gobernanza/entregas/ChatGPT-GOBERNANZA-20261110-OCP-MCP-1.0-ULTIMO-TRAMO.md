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
