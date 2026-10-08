# Historial RDC

**Estado:** CANÓNICO
**Naturaleza:** registro histórico operativo; no sustituye a ESTADO-RDC-ACTIVO.md.
**Función:** conservar el ciclo de vida de las sesiones RDC y permitir reconstruir sustituciones, finalizaciones y conflictos entre conversaciones.

## Regla

Una entrada representa una sesión lógica, no cada ping ni cada ciclo de conversación.

Los registros históricos no se eliminan para crear una apariencia de continuidad. Una sesión cambia de estado mediante un cierre, sustitución, revocación o expiración verificable.

## Sesiones

| RDC-REGISTRO-ID | INICIO VERIFICADO | FIN VERIFICADO | CUENTA | DISPOSITIVO | DEVICE-ID | UBICACION | ESTADO | SUSTITUIDA-POR | CAUSA |
|---|---|---|---|---|---|---|---|---|---|
| RDC-20261007-0001 | 2026-10-07T20:31:30.2613435Z | 2026-10-08T16:22:08.620Z* | blacksheepsup@gmail.com | PC10RCIF4EI4 | 7fabbc1d-7c0d-4400-bd31-88b3b4229286 | CECEQ | SUSTITUIDA | RDC-20261008-0001 | Nueva sesión verificada en PC-7; dispositivo anterior apagado y posteriormente observado OFFLINE |
| RDC-20261008-0001 | 2026-10-08T16:20:35.092Z | 2026-10-08T17:41:23.258Z | blacksheepsup@gmail.com | PC-7 | 5165397f-3ccf-4c7d-939f-821526119101 | CECEQ | SUSTITUIDA | RDC-20261008-0002 | Sustituida por nueva sesión verificada en el mismo equipo; nuevo device_id y ping verificado |
| RDC-20261008-0002 | 2026-10-08T17:41:23.258Z | — | blacksheepsup@gmail.com | PC-7 | 418659b7-64bc-4cb2-a2cb-ed8fd83c5005 | CECEQ | ACTIVA | — | Nueva sesión verificada; device online y ping verificado |

* Hora de inicio del shutdown del dispositivo anterior; la consulta posterior confirmó OFFLINE.

## Regla de unicidad

El estado operativo normal es una sola sesión ACTIVA.

Si aparecen varias sesiones ACTIVA simultáneamente:
- se considera conflicto salvo que exista una excepción explícita y vigente;
- no se elige una sesión por inferencia;
- la resolución debe quedar registrada mediante sustitución, finalización o excepción verificable.

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

La sesión global vigente se determina exclusivamente desde:

ESTADO-RDC-ACTIVO.md

Este archivo conserva el pasado; no autoriza por sí mismo una sesión actual.
