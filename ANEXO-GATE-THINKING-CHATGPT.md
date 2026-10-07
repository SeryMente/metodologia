# Anexo — Gate de Thinking en ChatGPT

**Estado:** CANÓNICO
**Versión:** v1.1.1
**Fecha:** 2026-10-07
**Ámbito:** Todos los ciclos sujetos a la metodología cuando la plataforma de ejecución sea ChatGPT.

## 1. Precondición

Todo ciclo sujeto a la metodología debe ejecutarse en modo Thinking de ChatGPT. La secuencia normativa se resuelve durante el razonamiento del turno antes de emitir la respuesta.

Secuencia obligatoria:

`THINKING → HEALTH MCP → OPEN TURN → CASCADA DE PRINCIPIOS → VERIFY → RELEASE → SALIDA`

## 2. Gate fail-closed

- `THINKING` es obligatorio.
- La señal válida debe pertenecer al runtime o integración que ejecuta el turno; la capacidad general del modelo para razonar no sustituye el estado de plataforma.
- `INSTANT` no es un estado permitido para ejecutar trabajo sujeto a la metodología.
- Ausencia de señal o imposibilidad de determinar el modo requerido = BLOQUEADO.
- El bloqueo impide ejecución sustantiva y cierre, pero mantiene abierta la conversación para resolver la condición.

## 3. Contrato protocolario

KHORA exige en el turno:

`platform=ChatGPT`
`reasoning_mode=THINKING`
`output_format_version=v1.7.1`

Los tres valores forman parte de la evidencia del turno. Cualquier ausencia o valor distinto impide `VERIFIED`.

## 4. Límite de evidencia

La metodología no considera verificable un estado de razonamiento que solo sea supuesto, inferido por el nombre del modelo o reconstruido a posteriori. Si la integración no entrega una señal operativa aceptable, el estado es `T: ?` y el ciclo queda bloqueado.

OpenAI documenta que ChatGPT dispone de un modo Thinking y que las Apps/MCP reciben metadata de cliente, pero la metadata MCP documentada no incluye el selector de modelo o modo de razonamiento. Por tanto, el servidor KHORA no puede afirmar que lea directamente el selector visual.

El protocolo utiliza `reasoning_mode=THINKING` como atestado obligatorio del runtime/modelo. El atestado no debe describirse como una prueba independiente de la interfaz. El gate sigue siendo fail-closed: sin el atestado correcto no hay ejecución normativa.

## 5. Formato visible

El formato de salida por ciclo es obligatorio y versionado como `v1.7.1`.

`PROYECTO / CONV-XX / CXXX`

`SI CARGADO · vX.Y.Z — NOMBRE DE VERSIÓN · COMPLETO · ACTIVO`

`ChatGPT · UBIC: ... · RDC: ... · C: ... · S: ... · K: ✓|?|! · T: ✓|?|! · fila4`

`RESULTADO: ...`
`ESTADO: COMPLETADO | BLOQUEADO | PENDIENTE`

`T: ✓` no puede aparecer mientras el gate esté en estado desconocido. `K: ✓` requiere además el health-check autenticado del MCP canónico.

## 6. Cierre

`E: COMPLETADO` solo puede emitirse después de `VERIFIED → RELEASE`, con `T: ✓`, `K: ✓` y con el contrato visible `v1.7.1` cumplido. Si Thinking no está activado o no puede verificarse, no existe ejecución metodológicamente completada.