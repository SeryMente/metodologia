# Anexo — Gate de Thinking en ChatGPT

**Estado:** CANÓNICO
**Versión:** v1.1.2
**Fecha:** 2026-10-07
**Ámbito:** Todos los ciclos sujetos a la metodología cuando la plataforma de ejecución sea ChatGPT.

## 1. Ventana de ejecución

Thinking es la ventana operativa preferente para resolver la cascada normativa antes de emitir la respuesta. No se considera una prueba del contenido del razonamiento interno y no constituye una condición que por sí sola bloquee la salida.

Secuencia preferente:

`THINKING → HEALTH MCP → OPEN TURN → CASCADA DE PRINCIPIOS → VERIFY → RELEASE → SALIDA`

## 2. Gate adaptativo

- `THINKING` puede utilizarse cuando la plataforma lo exponga.
- `INSTANT`, estado desconocido o ausencia de señal no bloquean por sí mismos la producción de la salida.
- Durante el razonamiento se intenta acceder a KHORA antes de abrir un turno normativo.
- Cuando KHORA no está disponible, el turno continúa y el HUD declara `K: OFF`.
- Cuando KHORA está disponible, la cascada normativa intenta alcanzar `VERIFIED_RELEASE` antes de declarar verificación positiva.

## 3. Contrato protocolario

KHORA conserva el runtime del turno como metadato:

`platform=ChatGPT`
`reasoning_mode=THINKING|INSTANT|UNKNOWN|UNAVAILABLE`
`output_format_version=v1.7.2`

La ausencia de un modo de razonamiento no invalida el receipt. El verificador distingue entre integridad normativa y disponibilidad del runtime.

## 4. Límite de evidencia

La metodología no afirma ni almacena una prueba del razonamiento interno del modelo. `reasoning_mode` es una observación/atestado operativo cuando la integración la proporciona; no equivale a evidencia del contenido mental del modelo.

La evidencia fuerte sigue siendo el receipt, sus hashes, la cobertura de principios y el veredicto de KHORA cuando el MCP está disponible. Cuando KHORA no está disponible, no existe veredicto externo para ese turno y el estado debe reflejarlo como `K: OFF`.

## 5. Formato visible

El formato de salida por ciclo es obligatorio y versionado como `v1.7.1`.

`PROYECTO / CONV-XX / CXXX`

`SI CARGADO · vX.Y.Z — NOMBRE DE VERSIÓN · COMPLETO · ACTIVO`

`ChatGPT · UBIC: ... · RDC: ... · C: ... · S: ... · K: ✓|?|! · T: ✓|?|! · fila4`

`RESULTADO: ...`
`ESTADO: COMPLETADO | BLOQUEADO | PENDIENTE`

`T: ✓` no puede aparecer mientras el gate esté en estado desconocido. `K: ✓` requiere además el health-check autenticado del MCP canónico.

## 6. Cierre

La salida puede emitirse en cualquier escenario. `K: ✓` solo se declara después de `VERIFIED → RELEASE`. Cuando el MCP está fuera de servicio o inaccesible, se declara `K: OFF` y no se atribuye verificación externa al turno. El contrato visible `v1.7.2` sigue siendo obligatorio.
