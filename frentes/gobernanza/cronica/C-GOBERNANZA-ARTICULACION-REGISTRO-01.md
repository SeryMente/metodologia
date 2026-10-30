# Crónica · C-GOBERNANZA-ARTICULACION-REGISTRO-01

**Fecha:** 2026-10-30 · **Ciclo:** C-20261030-9D7E31A2 · **Conversación local:** 01a18a1b-3000-7b4c-892a-8d31e5f6a7b8  
**Frente:** Gobernanza · **OCP:** `frentes/gobernanza/`  
**Fuente normativa cotejada:** DUG v362 · NX-362m · blob `b7593409c428e209d35f53a5f13501652208d949`.

## Instrucción y corrección de estructura

El operador aclaró que Gobernanza es el frente responsable y Tareas es trabajo/ámbito en desarrollo dentro de ese frente, no un frente independiente. Se descarta la transferencia de titularidad de Tareas.

El operador precisó que Persistencia documental y Registro conversacional convergen en la custodia y recuperación de documentos y ciclos E/S, mientras Trazabilidad semántica debe ser una capacidad fundamental de AT: conserva vectores verbatim y los enlaza bidireccionalmente con cambios, principios, anexos, OCP y resultados. AT debe ser compatible con futura integración LISA.

## Revisión de fuentes

Se cotejaron DUG v362 (ART-015, ART-020, ART-022, ART-024), Metacanon §28, los artefactos v1.0 de Gestión conversacional y la revisión histórica de compatibilidad LISA. Se confirmó:
- ART-020/024 todavía ubican Trazabilidad semántica como módulo de Gestión conversacional.
- ART-022/014 definen Persistencia documental como custodia de originales/derivados con manifiesto y verificación.
- Registro conversacional tiene esquema para UUIDv7 local, folio de ciclo, E/S, procedencia, repositorio y frente.
- La implementación v1.0 no ofrece captura automática ni sincronización omnicanal.
- La revisión de LISA v1.2 describe trazabilidad universal a Vector Semántico L0, cadena L0→REQ→ACR, no invención/ratificación de L0 por el modelo y compatibilidad mediante composición con AT.

## Acciones ejecutadas

1. Se revisó AT v1.0 y se añadió la trazabilidad semántica como capacidad fundamental, con flujo de vectores, enlaces bidireccionales, campos mínimos y compatibilidad LISA.
2. Se actualizó el README y la guía de Trazabilidad semántica para explicar que la materialización actual es histórica/provisional y que el DUG vigente prevalece hasta su enmienda.
3. Se asignó UUIDv7 local `01a18a1b-3000-7b4c-892a-8d31e5f6a7b8` y folio `C-20261030-9D7E31A2`.
4. Se persistió el mensaje íntegro del operador en `FUENTES-VERBATIM-ORIGEN.jsonl`, fuente `SRC-C-20261030-9D7E31A2-USER`.
5. Se añadió la fila de conversación en `REGISTRO-CONVERSACIONES.csv` y cuatro vínculos semánticos.
6. Se completó el diálogo E/S literal; la salida S incorpora los límites de autorización y automatización.
7. Se creó esta crónica, salida y evidencia.

## Límites y compuertas

No se modificó el DUG ni el GOW. P005 exige autorización explícita previa para enmiendas normativas; el control de Gobernanza excluye cambios sustantivos amplios sin esa autorización. Se propone una enmienda acotada a ART-020/024 y las entradas GOW afectadas, sin principio ni ámbito funcional nuevo.

IPZA no instala captura automática. El ciclo actual se persistió mediante escritura manual y lectura de vuelta; esto no demuestra captura automática futura. La integración LISA completa tampoco se ejecutó; solo se fijaron puntos de compatibilidad.

## Estado

- Entrada literal: persistida y cotejada.
- Salida visible: persistida y cotejada.
- Registro maestro: actualizado con UUIDv7 local y folio.
- Trazas: registradas; la reclasificación DUG permanece parcial hasta autorización y enmienda.
- AT v1.0: definición operativa revisada.
- DUG/GOW: sin cambios.
- Tareas: permanece como trabajo dentro del frente Gobernanza.

