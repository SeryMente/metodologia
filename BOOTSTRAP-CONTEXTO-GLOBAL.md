# Bootstrap de Contexto Global

**Estado:** CANONICO
**Ambito:** Todas las conversaciones y proyectos sujetos a la metodologia comun.

## Proposito

Este archivo es el punto de entrada operativo para reconstruir contexto transversal cuando una conversacion nueva no conserva contexto de una conversacion anterior.

## Regla principal

### Frescura normativa obligatoria

El bootstrap debe usar el `SI-METACOGNITIVO.md` recuperado desde `main` como fuente activa. Si la copia recuperada identifica una versión anterior a la vigente publicada en `main`, esa copia se considera **HISTÓRICA/OBSOLETA** y no puede utilizarse para decidir bloqueos. Debe refrescarse la fuente antes de aplicar cualquier gate de Thinking o KHORA.

**PRECONDICION DE ARRANQUE:** una conversacion nueva debe consumir este bootstrap y `ESTADO-RDC-ACTIVO.md` antes de preguntar al usuario por la sesion RDC. Si existe una sesion persistente activa, se hereda; no se reidentifica.

La memoria de una conversacion no es la fuente global. El repositorio de la metodologia es la fuente persistente.

La verificación del SI es **por ciclo y atómica**. Cada ciclo debe leer `main` como `H1`, recuperar `SI-METACOGNITIVO.md` exactamente en `H1`, volver a leer `main` como `H2` y aceptar `F:✓` solo si `H1 = H2` y versión + nombre + blob SHA coinciden. El bootstrap nunca sustituye esta comprobación ni permite reutilizar caché o copias previas.

Para RDC, el estado mutable y unico se encuentra en:

`ESTADO-RDC-ACTIVO.md`

No se duplican aqui la cuenta, device_id, estado de sesion, timestamps ni consumo mensual, porque esos datos pueden cambiar.

## Precedencia del contexto RDC sobre KHORA

Antes de `HEALTH MCP` o de cualquier certificación de KHORA, cada ciclo debe leer `ESTADO-RDC-ACTIVO.md` y resolver el estado lógico de la sesión RDC y su conectividad observable. Ningún estado RDC de una conversación anterior sustituye esta lectura., Thinking es la ventana preferente para resolver la cascada normativa antes de la salida cuando está disponible. No constituye una prueba del razonamiento interno ni una condición que, por sí sola, bloquee la ejecución o la respuesta.

La disponibilidad de KHORA es independiente del modo de razonamiento. Si el MCP está disponible, se intenta `HEALTH → OPEN TURN → CASCADA NORMATIVA → VERIFY → RELEASE`. Si el MCP no está disponible, el ciclo continúa y la salida declara `K: OFF`, sin atribuir verificación externa.

Secuencia operativa:

`BOOTSTRAP → CONTEXTO → (THINKING si disponible) → HEALTH MCP → OPEN TURN → CASCADA NORMATIVA → VERIFY → RELEASE cuando disponible → RESPUESTA`

## Secuencia de arranque

1. Obtener `H1` de `main`; recuperar el SI exactamente en `H1`; obtener `H2` de `main`; usar la instantánea como fuente única y emitir `F:✓` solo si `H1 = H2` y versión + nombre + blob SHA son coherentes.
2. Leer `ESTADO-RDC-ACTIVO.md` para recuperar la identidad persistente de la sesion RDC.
3. Leer `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md` para aplicar el gate.
4. Heredar la sesion persistida si no existe marca de `FINALIZADA` o `SUSTITUIDA`.
5. Registrar el estado de `reasoning_mode` cuando la plataforma lo exponga; no bloquear solo por su ausencia. Si la fuente normativa recuperada contiene la semántica antigua de Thinking fail-closed, tratarla como copia obsoleta y refrescarla.
6. Una vez resuelto el contexto RDC, intentar `khora_mcp_health` sobre el MCP canónico; si no está disponible, declarar `K: OFF` en la salida. Si confirma acceso completo, conservar `K: ✓`. La falta de KHORA no bloquea por sí misma.
7. Ejecutar el gate de conectividad RDC correspondiente al ciclo; si el modelo comunica ausencia/pérdida de RDC, emitir `RDC-REINSTANTIAR` en el mismo ciclo.

## Distincion obligatoria

**Sesion** = identidad persistente del canal RDC reconocido globalmente.

**Conectividad** = capacidad observable de utilizar ese canal en vivo en el instante de la verificacion.

Una desconexion, dispositivo offline o herramienta indisponible no equivale a finalizacion de sesion y no autoriza a borrar ni reemplazar la identidad persistida.

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

## Cambio de sesion

Una nueva sesion verificada sustituye a la anterior y actualiza `ESTADO-RDC-ACTIVO.md`.

Un cierre explicito marca la sesion como finalizada.

Hasta entonces, las conversaciones nuevas deben reconocer la sesion persistente registrada.

## Regla para la plataforma

Cuando una conversacion nueva entre al ambito de esta metodologia, debe consultar este bootstrap y el estado RDC antes de preguntar al usuario por una sesion ya registrada.

La conversacion es un contenedor. La sesion RDC global es un estado compartido del repositorio.

## Prueba de propagacion

Una propagacion correcta queda demostrada cuando una conversacion nueva puede reconstruir, sin entrada del usuario, al menos `RDC-SESION`, `RDC-CUENTA`, `RDC-DISPOSITIVO`, `RDC-DEVICE-ID`, `UBICACION` y `WIN-OPERATIVO` desde `ESTADO-RDC-ACTIVO.md`. La conectividad se comprueba por separado cuando la tarea requiere uso RDC en vivo.

## Limite tecnico

Este contrato hace persistente y consultable el estado en el repositorio. La plataforma de ChatGPT no ofrece un mecanismo por el que un archivo de GitHub fuerce tecnicamente a toda conversacion futura a leerlo antes de responder; por ello, la metodologia define este archivo como bootstrap canonico que toda conversacion sujeta al sistema debe consumir al iniciar su ciclo.
