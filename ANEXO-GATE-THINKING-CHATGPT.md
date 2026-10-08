# Anexo — Gate de Thinking en ChatGPT

**Estado:** CANÓNICO
**Versión:** v1.1.5
**Fecha:** 2026-10-08
**Ámbito:** Todos los ciclos sujetos a la metodología cuando la plataforma de ejecución sea ChatGPT.

## 1. Regla de frescura y precedencia

Este anexo está subordinado a `SI-METACOGNITIVO.md`. Cualquier copia que describa Thinking como precondición bloqueante es histórica y no puede usarse para bloquear un turno. La versión activa del SI debe ser la recuperada desde `main`.

## 2. Ventana de ejecución

Thinking es la ventana operativa preferente para resolver la cascada normativa antes de emitir la respuesta. No se considera una prueba del contenido del razonamiento interno y no constituye una condición que por sí sola bloquee la salida.

La resolución del contexto RDC es anterior a este anexo: antes de `HEALTH MCP`, el ciclo debe leer y resolver `ESTADO-RDC-ACTIVO.md`. Este anexo no puede iniciar la certificación KHORA antes de que ese gate haya terminado.

Secuencia preferente:

`SNAPSHOT SI → ESTADO RDC → THINKING → HEALTH MCP → OPEN TURN → CASCADA DE PRINCIPIOS → VERIFY → RELEASE → SALIDA`

## 3. Gate adaptativo

- `THINKING` puede utilizarse cuando la plataforma lo exponga.
- `INSTANT`, estado desconocido o ausencia de señal no bloquean por sí mismos la producción de la salida.
- Durante el razonamiento se intenta acceder a KHORA antes de abrir un turno normativo.
- Cuando KHORA no está disponible, el turno continúa y el HUD declara `K: OFF`.
- Cuando KHORA está disponible, la cascada normativa intenta alcanzar `VERIFIED_RELEASE` antes de declarar verificación positiva.

## 4. Contrato protocolario

KHORA conserva el runtime del turno como metadato:

`platform=ChatGPT`
`reasoning_mode=THINKING|INSTANT|UNKNOWN|UNAVAILABLE`
`output_format_version=v1.7.7`

La ausencia de un modo de razonamiento no invalida el receipt. El verificador distingue entre integridad normativa y disponibilidad del runtime.

## 5. Límite de evidencia

La metodología no afirma ni almacena una prueba del razonamiento interno del modelo. `reasoning_mode` es una observación/atestado operativo cuando la integración la proporciona; no equivale a evidencia del contenido mental del modelo.

La evidencia fuerte sigue siendo el receipt, sus hashes, la cobertura de principios y el veredicto de KHORA cuando el MCP está disponible. Cuando KHORA no está disponible, no existe veredicto externo para ese turno y el estado debe reflejarlo como `K: OFF`.

## 6. Formato visible y reanclaje

El formato de salida por ciclo es obligatorio y versionado como `v1.7.7`.

`PROYECTO / CONV-XX / CXXX`

`SI CARGADO · vX.Y.Z — NOMBRE DE VERSIÓN · COMPLETO · ACTIVO`

`ChatGPT · CI: ✓|?|! · RA: INICIAL|✓|CORRECTIVO|! · UBIC: ... · RDC: ... · C: ... · S: ... · K: ✓|?|! · T: ✓|?|! · fila4`

`RESULTADO: ...`
`ESTADO: COMPLETADO | BLOQUEADO | PENDIENTE`

`T: ✓` no se emite salvo que el runtime lo observe/ateste; `T: ?` no bloquea. `K: ✓` requiere además el health-check autenticado del MCP canónico; `K: OFF`, `K: ?` y `K: !` no bloquean por sí mismos.

## 7. Cierre

La salida puede emitirse en cualquier escenario. `K: ✓` solo se declara después de `VERIFIED → RELEASE`. Cuando el MCP está fuera de servicio o inaccesible, se declara `K: OFF` y no se atribuye verificación externa al turno. El contrato visible `v1.7.7` sigue siendo obligatorio. Los indicadores `CI` y `RA` pertenecen a ese contrato. `CI` registra la aplicación verificable del régimen y `RA` registra su reanclaje obligatorio por ciclo; ninguno afirma una lectura introspectiva del campo de la plataforma.
