# Bootstrap de Contexto Global

**Tipo:** ANEXO OPERATIVO

**Estado:** CANONICO
**Ambito:** Todas las conversaciones y proyectos sujetos a la metodologia comun.

## Proposito

Este archivo es el punto de entrada operativo para reconstruir contexto transversal cuando una conversacion nueva no conserva contexto de una conversacion anterior.

## Regla principal
## Activación inmediata de Vercel

Si el texto de la tarea, hilo o ciclo contiene una referencia operativa a Vercel —incluida publicación, preview, deployment, production, rollback, build o configuración— se activa inmediatamente el objeto `ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL.md`.

Antes de ejecutar cualquier acción dependiente de Vercel se debe resolver:

`LIMITATION-SCAN → DEPENDENCIA-VERCEL → SUFICIENCIA-LOCAL → VÍA DE EJECUCIÓN`

La limitación se busca primero; la necesidad real de Vercel se determina segundo; la suficiencia de una implementación local se comprueba tercero. Una cuota o límite de Vercel solo puede bloquear la parte que requiera materialmente el proveedor y no pueda ser cubierta localmente.


### Frescura normativa obligatoria

El bootstrap debe usar el `SI-METACOGNITIVO.md` recuperado desde `main` como fuente activa. La **cabecera `Versión` + `Nombre de versión` de ese snapshot exacto es la única identidad activa del SI**. El historial de versiones del archivo y cualquier declaración de versión procedente de Metodología, anexos, memoria conversacional o respuestas previas no puede sustituirla.

Si la copia recuperada identifica una versión anterior a la publicada en `main`, o si cualquier espejo documental declara como vigente una versión/nombre distintos de la cabecera activa, la copia se considera **HISTÓRICA/OBSOLETA o CONTRADICTORIA**. Debe refrescarse/reconciliarse antes de continuar. Ese estado no puede utilizarse para satisfacer `CI`, `RA`, `F` ni para ejecutar trabajo sustantivo.

**PRECONDICION DE ARRANQUE:** una conversacion nueva debe consumir este bootstrap y `ESTADO-RDC-ACTIVO.md` y, cuando RDC sea relevante, realizar descubrimiento vivo mediante el proveedor RDC antes de seleccionar una terminal. Un registro persistente no se hereda como selector actual de terminal.

La memoria de una conversacion no es la fuente global. El repositorio de la metodologia es la fuente persistente.

La verificación del SI es **por ciclo y atómica**. Cada ciclo debe leer `main` como `H1`, recuperar `SI-METACOGNITIVO.md` exactamente en `H1`, volver a leer `main` como `H2` y aceptar `F:✓` solo si `H1 = H2`, la versión + nombre proceden de la **cabecera activa** y el blob SHA coincide. El bootstrap nunca sustituye esta comprobación ni permite reutilizar caché o copias previas.

### Gate de arranque fail-closed

La conversación nueva no puede presentar el SI como `CARGADO`, activar el reanclaje inicial ni ejecutar trabajo sustantivo hasta cerrar esta secuencia:

`H1 → SI@H1 → H2 → CABECERA ACTIVA → CONSISTENCIA DE ESPEJOS → F:✓ → REANCLAJE INICIAL`

Reglas:
1. La cabecera activa del SI es la autoridad única sobre su versión/nombre del ciclo.
2. Una aparición de una versión dentro del historial no es evidencia de vigencia.
3. Un espejo contradictorio en Metodología, bootstrap o anexos no puede elevarse a autoridad; debe generar `F:!`.
4. `F:!` o `F:?` impide `CI:✓` y `RA:INICIAL|✓`; el ciclo queda BLOQUEADO/PENDIENTE de una adquisición válida.
5. La frase `SI CARGADO` queda reservada para un snapshot que haya superado H1/H2, identidad activa y blob SHA. No se permite mostrar una versión histórica como si fuera la vigente.
6. Si la ruta de recuperación disponible no demuestra el SHA exacto de `main`, debe tratarse como evidencia insuficiente, no como frescura válida.

Esta barrera existe precisamente para impedir que un estado histórico reaparezca como norma activa al abrir una conversación nueva.

Para RDC, `ESTADO-RDC-ACTIVO.md` es el registro persistente de identidades conocidas y ciclos de vida. No es la fuente de verdad de la presencia actual de dispositivos.

La presencia y conectividad actuales deben consultarse al proveedor RDC en vivo. Cuando existan varias cuentas vinculadas, el descubrimiento debe cubrir todas las cuentas accesibles al runtime antes de seleccionar una terminal.

## Precedencia del contexto RDC sobre KHORA

Antes de `HEALTH MCP` o de cualquier certificación de KHORA, cada ciclo debe leer `ESTADO-RDC-ACTIVO.md` y resolver el conjunto de dispositivos RDC observable en vivo. Ningún estado RDC de una conversación anterior puede seleccionar por sí mismo la terminal de este ciclo. Thinking es la ventana preferente para resolver la cascada normativa antes de la salida cuando está disponible. No constituye una prueba del razonamiento interno ni una condición que, por sí sola, bloquee la ejecución o la respuesta.

La disponibilidad de KHORA es independiente del modo de razonamiento. Si el MCP está disponible, se intenta `HEALTH → OPEN TURN → CASCADA NORMATIVA → VERIFY → RELEASE`. Si el MCP no está disponible, el ciclo continúa y la salida declara `K: OFF`, sin atribuir verificación externa.

Secuencia operativa:

`BOOTSTRAP → CONTEXTO → (THINKING si disponible) → HEALTH MCP → OPEN TURN → CASCADA NORMATIVA → VERIFY → RELEASE cuando disponible → RESPUESTA`

## Secuencia de arranque

El primer ciclo de una conversación nueva parte del régimen de Instrucciones personalizadas de ChatGPT **solo después de cerrar el gate de frescura/identidad normativa**. Ese ciclo debe aplicar el régimen y ejecutar un **reanclaje inicial obligatorio** que establezca su continuidad para los ciclos posteriores. Una adquisición histórica, incompleta o contradictoria no satisface el punto de activación.

Desde el segundo ciclo, **cada ciclo debe ejecutar un reanclaje de continuidad antes del trabajo sustantivo**. El reanclaje no se hereda por memoria, no se considera consumido por una aplicación anterior y no depende de que el ciclo anterior haya producido `CI: ✓`.

`CI` se calcula de forma independiente en cada ciclo. `CI: ✓` solo expresa que las condiciones observables del régimen se manifiestan en el ciclo; `CI: ?` activa un reanclaje correctivo antes de declarar continuidad satisfecha; `CI: !` exige corregir la contradicción observable antes de continuar con trabajo sustantivo sujeto al régimen.

El reanclaje debe referirse al régimen canónico vigente y no crear un resumen o una copia normativa paralela. Su función es reforzar la continuidad del mismo régimen en cada ciclo.

1. Obtener `H1` de `main`; recuperar el SI exactamente en `H1`; obtener `H2` de `main`; leer primero la cabecera activa `Versión` + `Nombre de versión`; comparar después los espejos documentales; usar la instantánea como fuente única y emitir `F:✓` solo si `H1 = H2`, la identidad de la cabecera es estable y versión + nombre + blob SHA son coherentes con esa instantánea.
2. Leer `ESTADO-RDC-ACTIVO.md` como registro persistente de identidades conocidas; no tratarlo como selector de terminal actual.
3. Leer `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md` para aplicar el gate.
4. Cuando RDC sea relevante, descubrir en vivo los dispositivos ONLINE en todas las cuentas RDC accesibles y reconciliarlos con el registro persistente.
5. Resolver la terminal concreta del ciclo por `RDC-CUENTA + RDC-DEVICE-ID`; no seleccionar por nombre genérico ni por memoria de otra conversación.
6. Registrar el estado de `reasoning_mode` cuando la plataforma lo exponga; no bloquear solo por su ausencia.
7. Si la tarea utiliza Vercel, cargar `ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL.md` y clasificar si requiere un deployment nuevo antes de ejecutar.
8. Una vez resuelto el contexto RDC, intentar `khora_mcp_health` sobre el MCP canónico; si no está disponible, declarar `K: OFF` en la salida.
9. Si no existe ningún dispositivo ONLINE y RDC es requerido, bloquear y ofrecer `RDC-REINSTANTIAR`.


## Procedimiento condicional de CLI Windows y repositorios

Cuando el ciclo incluya operaciones en Windows PowerShell, arranque de aplicaciones, instalación de dependencias o descarga/actualización de repositorios, consumir ANEXO-PROCEDIMIENTO-ARRANQUE-CLI-WINDOWS-Y-CLONADO-REPOSITORIOS.md antes de ejecutar. El script reutilizable de clonación es scripts/clone-public-repo-to-desktop.ps1.

Si el usuario exige CLI, toda inspección y operación de la terminal debe realizarse por línea de comandos; no usar automatización de ventanas, clics ni controles gráficos. La creación o actualización de archivos persistentes sigue el contrato de publicación condicionada y read-back.

El anexo no reemplaza el snapshot SI, el registro de terminales, el descubrimiento vivo RDC ni la verificación por ping. Es un procedimiento condicional de implementación, no un selector de terminal.

## Distincion obligatoria

**Identidad RDC** = par `RDC-CUENTA + RDC-DEVICE-ID` que identifica una terminal/dispositivo en el proveedor.

**Registro persistente** = memoria transversal de identidades conocidas y sus ciclos de vida.

**Conectividad** = capacidad observable de utilizar un dispositivo en vivo en el instante de la verificacion.

**Selección de terminal** = decisión del ciclo/conversación sobre qué identidad RDC concreta se utilizará; no es un estado global.

Una desconexión, dispositivo offline o herramienta indisponible no equivale por sí sola a finalización de una identidad persistida. Tampoco impide descubrir otra identidad RDC ONLINE que corresponda a una terminal distinta.

## Contrato de publicación transaccional RDC

Antes de `HEALTH MCP` de KHORA, cada ciclo debe consumir `ESTADO-RDC-ACTIVO.md`. Después de una recuperación o refresco, la continuidad depende de una publicación transaccional y un read-back satisfactorio.

Secuencia:

`LEER ESTADO → VALIDAR → PUBLICAR CON SHA/CONDICIÓN → READ-BACK → KHORA`

Si la escritura o lectura de vuelta falla, no se considera resuelta la recuperación y no se reanuda trabajo dependiente de RDC.

## Recuperación por divergencia de observabilidad RDC

Si el estado global registra `RDC-SESION = ACTIVA`, pero la verificación del canal reporta offline/no verificable y el usuario informa actividad local de una terminal RDC, la conversación no debe volver a preguntar qué sesión existe ni declarar que la sesión terminó.

Debe:

1. registrar la divergencia;
2. mantener la identidad persistente;
3. cuando el ciclo requiera RDC, bloquear solo la ejecución sustantiva;
4. emitir `RDC-REINSTANTIAR`;
5. instruir al usuario a cerrar la terminal observada y abrir una nueva sesión RDC;
6. recibir el `RDC-HANDSHAKE`;
7. actualizar `ESTADO-RDC-ACTIVO.md` con la nueva sesión verificada antes de reanudar.

La nueva conversación consumirá automáticamente ese registro actualizado. No existe propagación por memoria conversacional; la propagación se produce por el estado compartido del repositorio.

## Cambio de terminal y ciclo de vida

Una nueva identidad RDC verificada se añade al registro; no sustituye automáticamente a otra identidad de dispositivo.

El cierre explícito, desconexión verificable o sustitución afecta a la identidad concreta que corresponda al mismo `RDC-DEVICE-ID`.

Una conversación nueva debe descubrir en vivo qué identidades están ONLINE y puede seleccionar una distinta de la utilizada por otra conversación.

## Regla de plataforma de publicación

Cuando el ciclo dependa de Vercel, la cuota y el modo de ejecución deben resolverse desde `ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL.md`. Una limitación para crear deployments no implica indisponibilidad global de Cora; debe preferirse el deployment existente o la ejecución local cuando sean suficientes.

## Regla para la plataforma

Cuando una conversacion nueva entre al ambito de esta metodologia, debe consultar este bootstrap y el estado RDC antes de preguntar al usuario por una sesion ya registrada.

La conversacion es un contenedor. La sesion RDC global es un estado compartido del repositorio.

## Prueba de propagacion

Una propagación correcta queda demostrada cuando una conversación nueva puede recuperar el registro persistente de identidades RDC y, sin depender de él como verdad actual, consultar el proveedor para obtener el conjunto ONLINE del ciclo. La conversación puede entonces resolver `RDC-CUENTA`, `RDC-DISPOSITIVO` y `RDC-DEVICE-ID` de la terminal seleccionada. La ubicación y el `WIN-OPERATIVO` se resuelven por separado.

## Limite tecnico

Este anexo no crea una capa normativa adicional: solo encadena la recuperación de fuentes y el contexto persistente definido por el SI y la Metodología.

Este contrato hace persistente y consultable el estado en el repositorio. La plataforma de ChatGPT no ofrece un mecanismo por el que un archivo de GitHub fuerce tecnicamente a toda conversacion futura a leerlo antes de responder; por ello, la metodologia define este archivo como bootstrap canonico que toda conversacion sujeta al sistema debe consumir al iniciar su ciclo.


## Continuidad persistente de desempeno en CIBERCAFE

Para el perfil CIBERCAFE se aplica desde bootstrap `PRESUPUESTO-REINICIO = 0`. Recuperar la memoria de `PC-N` antes de repetir diagnósticos; no planificar ni ejecutar reboot, BIOS/UEFI, firmware, reparación offline ni cambios que requieran reinicio. Las oportunidades `BLOQUEADA-REINICIO` deben conservarse en la memoria para una eventual migración a un ámbito con régimen distinto.

Cuando la ubicacion sea CIBERCAFE, la continuidad del proceso de desempeno se resuelve por terminal individual, no por el cibercafe como conjunto.

Antes de repetir un diagnostico profundo, el ciclo debe consultar el registro de la terminal correspondiente en `CIBERCAFE/PC-N/ESTADO.md` y sus eventos recientes. El conocimiento vigente se reutiliza y solo se revalida lo dinamico o lo que muestre evidencia de cambio.

La telemetria continua pertenece a la sesion local y no obliga a una llamada RDC por muestra. La persistencia se realiza mediante eventos significativos y lotes segun `ANEXO-PROCESO-LIBERACION-DESEMPENO-CIBERCAFE.md`, incluyendo `SYNC_FLUSH` antes de reinicio/DeepFreeze cuando sea observable.
