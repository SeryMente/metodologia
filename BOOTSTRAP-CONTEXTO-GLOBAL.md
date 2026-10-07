# Bootstrap de Contexto Global

**Estado:** CANONICO
**Ambito:** Todas las conversaciones y proyectos sujetos a la metodologia comun.

## Proposito

Este archivo es el punto de entrada operativo para reconstruir contexto transversal cuando una conversacion nueva no conserva contexto de una conversacion anterior.

## Regla principal

**PRECONDICION DE ARRANQUE:** una conversacion nueva debe consumir este bootstrap y `ESTADO-RDC-ACTIVO.md` antes de preguntar al usuario por la sesion RDC. Si existe una sesion persistente activa, se hereda; no se reidentifica.

La memoria de una conversacion no es la fuente global. El repositorio de la metodologia es la fuente persistente.

Para RDC, el estado mutable y unico se encuentra en:

`ESTADO-RDC-ACTIVO.md`

No se duplican aqui la cuenta, device_id, estado de sesion, timestamps ni consumo mensual, porque esos datos pueden cambiar.

## Precondición normativa transversal

Una conversación nueva sujeta a la metodología no debe considerar resuelta una tarea sustantiva sin completar el circuito normativo de KHORA.

Secuencia obligatoria:

`BOOTSTRAP → HEALTH MCP → OPEN TURN → EJECUCIÓN → VERIFY → RELEASE → RESPUESTA`

Si el health-check MCP no está disponible o no confirma acceso completo, la conversación puede permanecer abierta para resolver el problema, pero el ciclo no puede declararse COMPLETADO.

La sesión RDC persistente se hereda desde `ESTADO-RDC-ACTIVO.md`; la conectividad se revalida únicamente cuando el ciclo requiere uso RDC en vivo.

## Secuencia de arranque

1. Leer `SI-METACOGNITIVO.md` y usar la version canonica vigente.
2. Leer `ESTADO-RDC-ACTIVO.md` para recuperar la identidad persistente de la sesion RDC.
3. Leer `ANEXO-GATE-CONTEXTO-OPERATIVO-FAIL-CLOSED.md` para aplicar el gate.
4. Heredar la sesion persistida si no existe marca de `FINALIZADA` o `SUSTITUIDA`.
5. Ejecutar `khora_mcp_health` sobre el MCP canónico y conservar su veredicto discreto `K: ✓` cuando confirme acceso completo.
6. Verificar conectividad RDC solamente cuando el ciclo necesite ejecutar una operacion RDC en vivo.

## Distincion obligatoria

**Sesion** = identidad persistente del canal RDC reconocido globalmente.

**Conectividad** = capacidad observable de utilizar ese canal en vivo en el instante de la verificacion.

Una desconexion, dispositivo offline o herramienta indisponible no equivale a finalizacion de sesion y no autoriza a borrar ni reemplazar la identidad persistida.

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
