# Registro de Terminales de Cibercafe

**Estado:** CANONICO
**Fecha:** 2026-10-09

Este archivo es el indice de las computadoras individuales administradas por el proceso persistente de liberacion de desempeno.

| Terminal | Estado | Registro de estado | Eventos | Ultima observacion persistente |
|---|---|---|---|---|
| PC-4 | ACTIVA EN REGISTRO | `CIBERCAFE/PC-4/ESTADO.md` | `CIBERCAFE/PC-4/EVENTOS-2026-10.md` | 2026-10-09 |
| PC-7 | ACTIVA EN REGISTRO | `CIBERCAFE/PC-7/ESTADO.md` | `CIBERCAFE/PC-7/EVENTOS-2026-10.md` | 2026-10-08 |

## Regla de alta

Para incorporar una nueva computadora se crea una carpeta individual `CIBERCAFE/PC-N/` con `ESTADO.md` y el archivo mensual de eventos correspondiente.

No se clona el estado de otra PC. El hardware, drivers, rendimiento, oportunidades e intervenciones se descubren y validan para la terminal concreta.

## Regla de continuidad

El indice identifica la unidad de memoria, no el estado vivo de RDC. La terminal viva del ciclo se resuelve mediante el descubrimiento RDC canonico; una vez resuelta, su memoria de desempeno se recupera por `PC-N`.


## Perfil común de operación

Todas las terminales `PC-N` registradas bajo CIBERCAFE heredan `PRESUPUESTO-REINICIO = 0`. El registro de una oportunidad que requiera reboot no constituye autorización para ejecutarla en esa terminal; debe quedar marcada `BLOQUEADA-REINICIO` en su estado individual.
