# Historial RDC

**Estado:** CANÓNICO
**Naturaleza:** registro histórico operativo; no determina por sí mismo la conectividad actual.
**Función:** conservar el ciclo de vida de las identidades RDC, incluidas múltiples terminales concurrentes, y permitir reconstruir sustituciones, finalizaciones y conflictos entre conversaciones.

**Identidad primaria:** `RDC-CUENTA + RDC-DEVICE-ID`.

## Regla

Una entrada representa una identidad lógica de dispositivo, no cada ping ni cada ciclo de conversación.

Los registros históricos no se eliminan para crear una apariencia de continuidad. Una identidad cambia de estado mediante un cierre, sustitución, revocación o expiración verificable.

Múltiples identidades pueden estar ACTIVAS simultáneamente cuando corresponden a distintos `RDC-DEVICE-ID`; esto no constituye conflicto. El nombre visible del dispositivo no es un identificador único.

## Sesiones

| RDC-REGISTRO-ID | INICIO VERIFICADO | FIN VERIFICADO | CUENTA | DISPOSITIVO | DEVICE-ID | UBICACION | ESTADO | SUSTITUIDA-POR | CAUSA |
|---|---|---|---|---|---|---|---|---|---|
| RDC-20261007-0001 | 2026-10-07T20:31:30.2613435Z | 2026-10-08T16:22:08.620Z* | blacksheepsup@gmail.com | PC10RCIF4EI4 | 7fabbc1d-7c0d-4400-bd31-88b3b4229286 | CECEQ | SUSTITUIDA | RDC-20261008-0001 | Nueva sesión verificada en PC-7; dispositivo anterior apagado y posteriormente observado OFFLINE |
| RDC-20261008-0001 | 2026-10-08T16:20:35.092Z | 2026-10-08T17:41:23.258Z | blacksheepsup@gmail.com | PC-7 | 5165397f-3ccf-4c7d-939f-821526119101 | CECEQ | SUSTITUIDA | RDC-20261008-0002 | Sustituida por nueva sesión verificada en el mismo equipo; nuevo device_id y ping verificado |
| RDC-20261008-0002 | 2026-10-08T17:41:23.258Z | — | blacksheepsup@gmail.com | PC-7 | 418659b7-64bc-4cb2-a2cb-ed8fd83c5005 | CECEQ | ACTIVA | — | Nueva sesión verificada; device online y ping verificado |

* Hora de inicio del shutdown del dispositivo anterior; la consulta posterior confirmó OFFLINE.

## Regla de unicidad

La unicidad se evalúa por `RDC-CUENTA + RDC-DEVICE-ID`.

Múltiples sesiones/identidades ACTIVAS son normales cuando corresponden a dispositivos distintos. No existe una única sesión RDC global.

Un conflicto existe cuando la misma identidad presenta estados incompatibles o cuando se pretende representar una misma identidad de device_id como dos terminales distintas sin evidencia. La conexión de una terminal nueva no finaliza ni sustituye otra terminal.

## Uso

Este historial se consulta cuando exista:
- nueva identidad RDC;
- sustitución o recuperación;
- múltiples sesiones;
- conflicto de identidad;
- excepción;
- necesidad de reconstruir el ciclo de vida de una sesión.

No se consulta para cada ping cuando la identidad global y la conexión observada coinciden.

## Fuente actual

La presencia y conectividad actuales se determinan exclusivamente mediante descubrimiento vivo del proveedor RDC.

`ESTADO-RDC-ACTIVO.md` y este historial conservan continuidad, identidades conocidas y ciclos de vida; no autorizan por sí mismos una terminal actual.

La selección de terminal pertenece al ciclo/conversación y debe utilizar `RDC-CUENTA + RDC-DEVICE-ID`.
