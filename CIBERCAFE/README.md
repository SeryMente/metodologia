# Registro Persistente de Desempeno - Cibercafe

**Estado:** CANONICO  
**Unidad de persistencia:** terminal individual `PC-N`

Este directorio conserva la memoria de desempeno de cada computadora del cibercafe.

## Regla

El cibercafe no se representa como una sola maquina.

Cada terminal tiene su propio registro:

`CIBERCAFE/PC-7/`
`CIBERCAFE/PC-8/`
`CIBERCAFE/PC-9/`

La memoria de una terminal no se transfiere automaticamente a otra.

## Estructura minima por PC

- `ESTADO.md`: estado consolidado y memoria reutilizable.
- `EVENTOS-YYYY-MM.md`: historial de eventos significativos.

## Continuidad ante DeepFreeze

Una sesion local puede desaparecer por reinicio o DeepFreeze sin perder la memoria del proyecto. La siguiente sesion recupera primero el registro de `PC-N` y despues revalida solamente lo dinamico o lo que haya cambiado.

## Sincronizacion

La telemetria continua permanece local.

El repositorio recibe eventos de alta relevancia inmediatamente, lotes de novedades periodicos y un `SYNC_FLUSH` obligatorio antes de reinicio/logoff/DeepFreeze cuando sea observable.

No se publica una fila por cada muestra de telemetria.

## Identidades

`PC-N` identifica la terminal del cibercafe.

`RDC-CUENTA + RDC-DEVICE-ID` identifica el canal RDC concreto de la sesion.

Ambas identidades se relacionan en los eventos, pero no son intercambiables.


## Perfil operativo del ámbito

Todas las terminales CIBERCAFE operan por defecto con **`PRESUPUESTO-REINICIO = 0`**.

Esto significa que el proceso de desempeño no reinicia, apaga, resetea ni programa reinicios; tampoco aplica BIOS/UEFI, firmware, reparación offline o cualquier cambio que requiera reboot. Esas oportunidades se conservan como `BLOQUEADA-REINICIO` y no impiden continuar con mejoras que puedan aplicarse en vivo.

Una ventana de mantenimiento CIBERCAFE es exclusivamente **live**. DeepFreeze o un reinicio externo pueden ocurrir fuera del proceso; la continuidad se protege mediante la memoria persistente y `SYNC_FLUSH` cuando exista señal observable suficiente.
