## 1. Identidad operativa y gobierno vigente

- **Organización:** Ser y Mente (`SeryMente`).
- **Frente operativo:** Metacanon.
- **Repositorio propietario del método:** `SeryMente/metodologia`, rama `main`. El repositorio conserva su nombre; el OCP activo del frente es `frentes/metacanon/`.
- **Evento:** `C-METACANON-TAXONOMIA-REPOSITORIOS-25`; folio global declarado: `C-20261022-7B31A9D4`. No se certifica unicidad global fuera del alcance de herramientas.
- **Sesión activa:** `SES-20261021-6B9E2F41`, generación 3, según `frentes/metacanon/CONTROL-RESPONSABILIDAD.json`.
- **Gobierno adquirido:** Sam v339 · NX-339m; Metacanon v1.21 · `METACANON-OBJETOS-v1.21`; GOW v2.2. `MCP-NORMATIVO: DESACTIVADO`. Sam y GOW no fueron modificados.

## 2. Dónde estamos

La taxonomía multi-repositorio está incorporada en Metacanon §51. La jerarquía vigente distingue organización, repositorios, frentes/OCP y materiales de cada frente; además reconoce recursos auxiliares según su alcance. Un script no pertenece al frente central solo por estar físicamente en la raíz del repositorio.

Se leyeron los árboles `main` de nueve repositorios que las herramientas expusieron bajo `SeryMente`. Ese conjunto no demuestra que sean todos los repositorios de la organización.

## 3. Actualización/delta

1. **Renombre operativo y ruta canónica:** el commit [`4ce94de`](https://github.com/SeryMente/metodologia/commit/4ce94de73f2d9dbfc1a5a033bc4cff49443c8dc2) implementó el nombre **Metacanon** y movió el OCP activo a `frentes/metacanon/`. La antigua `frentes/metodologia/` conserva solo punteros de compatibilidad, sin control de responsabilidad duplicado.
2. **Regla común:** Metacanon §51 define la clasificación entre recursos de frente, infraestructura del repositorio, recursos compartidos dentro de un repositorio y recursos compartidos entre repositorios. No se crean carpetas vacías de recursos compartidos.
3. **Inventario central:** `INVENTARIO-REPOSITORIOS-Y-FRENTES.md` registra las nueve estructuras observadas y sus límites de cobertura. Su fila de GDP fue corregida en [`2650bf8`](https://github.com/SeryMente/metodologia/commit/2650bf8c551c85fb1e4526fec5a8a53e625dfcb5): su README nombra `docs/SPRINT-CONSAR-AFORE-NSS.md` como objeto de estado de archivo único, no como carpeta OCP.
4. **Puntos de entrada locales:** se verificó una sección de organización de frentes/recursos o índice equivalente en los README/puntos de entrada de los nueve repositorios accesibles.
5. **Coherencia del índice central:** se corrigió el README raíz para apuntar a Metacanon v1.21 en [`a9d104e`](https://github.com/SeryMente/metodologia/commit/a9d104e320b56b44f36c45cea7f80be4c54dce86). El estado vivo de Metacanon y el registro de esta ejecución quedaron leídos de vuelta en [`1ff295f`](https://github.com/SeryMente/metodologia/commit/1ff295f7b5d88ffc8007e06c68a7a9a19622b157).

## 4. Qué avanzó y evidencia

| Repositorio | Estructura local verificada |
|---|---|
| [`SeryMente/metodologia`](https://github.com/SeryMente/metodologia) | OCP `frentes/metacanon/`, `frentes/ep/`, `frentes/acceso/` y `frentes/blog-personal/`; `frentes/metodologia/` es puntero. |
| [`SeryMente/khora`](https://github.com/SeryMente/khora) | Tres OCP heredados: `docs/frentes/dictado-voz/`, `docs/frentes/harmonia/` y `docs/frentes/tareas-automaticas/`. Se conservan esas rutas. |
| [`SeryMente/serymente`](https://github.com/SeryMente/serymente) | No se encontró carpeta OCP `frentes/` o `docs/frentes/`; se conserva la estructura del sitio y sus activos. |
| [`SeryMente/otrogranprograma`](https://github.com/SeryMente/otrogranprograma) | No se encontró carpeta OCP en esas rutas; `docs/`, `blog/`, código y activos siguen en su lugar. |
| [`SeryMente/GDP`](https://github.com/SeryMente/GDP) | Se detectó un objeto de estado de archivo único en `docs/SPRINT-CONSAR-AFORE-NSS.md`; su clasificación/migración a OCP de carpeta está pendiente. |
| [`SeryMente/khora-effectif`](https://github.com/SeryMente/khora-effectif) | No se encontró carpeta OCP en `frentes/` o `docs/frentes/`; se conserva la estructura de extensión/worker. |
| [`SeryMente/signal-interpreter`](https://github.com/SeryMente/signal-interpreter) | OCP en `docs/frentes/signal-interpreter/`; ruta heredada preservada. |
| [`SeryMente/tercer-ambito`](https://github.com/SeryMente/tercer-ambito) | `etica/` conserva núcleo/documentos, fuentes y evidencia; la designación formal de OCP y su control requieren una revisión específica. |
| [`SeryMente/personal`](https://github.com/SeryMente/personal) | OCP en `frentes/repertorio-canto-personal/`; scripts y evidencias exclusivos continúan allí. |

Los README locales describen estas estructuras y no crean nuevos frentes por simetría. Las lecturas de vuelta de los archivos centrales confirman el nombre operativo, la ubicación activa y el índice actualizado.

## 5. Qué falta

- **Scripts del repositorio Metacanon:** los dos scripts de Entorno Persistente y el asociado a CIBERCAFE siguen en `scripts/`. No se movieron aún: la búsqueda de referencias no devolvió resultados fiables y no demuestra ausencia de consumidores. Antes de mover, hay que comprobar invocadores, rutas relativas y pruebas; no consolidar las dos variantes de EP sin conocer sus dependencias.
- **GDP:** clasificar y, si procede, planificar la migración del sprint de archivo único a un OCP de carpeta. No se movió ni reescribió el núcleo actual.
- **Tercer ámbito / Ética:** verificar núcleo y control autoritativo para decidir si `etica/` ya funciona como OCP heredado. No renombrarlo sin esa comprobación.
- **Cobertura de la organización:** nueve repositorios fueron accesibles; la cobertura de repositorios no expuestos sigue NO VERIFICADA.
- **CI:** en el corte observado, `validate-canonical-bootstrap` y `Validate RDC Governance` fallaron en el commit `2650bf8c551c85fb1e4526fec5a8a53e625dfcb5`. La consulta de jobs no entregó pasos ni logs, así que la causa exacta está NO VERIFICADA. KHORA y GDP también mostraron fallos en sus workflows, y en OGP falló el paso «Contrato público v1.7.0» mientras el despliegue de GitHub Pages resultó exitoso. No se declara PASS global de CI.

## 6. Viabilidad

La taxonomía está definida y el nombre operativo **Metacanon** está implementado en la ubicación canónica. Las estructuras existentes se registraron por evidencia, manteniendo rutas heredadas y sin crear OCP o carpetas compartidas vacíos. La limpieza/migración de scripts se mantiene separada hasta demostrar sus dependencias. No se cambió código de producto, no se modificó Sam ni GOW y no se alteró la identidad del repositorio `SeryMente/metodologia`.

## 7. Tiempo/ciclos

Este registro corresponde al ciclo global declarado `C-20261022-7B31A9D4`. No estimo una duración para la segunda fase hasta identificar los consumidores reales de los scripts y el alcance del OCP de GDP.

## 8. Siguiente acción

Auditar las referencias y dependencias de los tres scripts clasificados por alcance (EP/CIBERCAFE), empezando por sus rutas relativas y los invocadores conocidos; después preparar una migración con adaptadores compatibles si es necesaria. En paralelo, resolver la clasificación de GDP y Ética sin mover rutas por estética.

## 9. Continuación

La entrada de continuidad es [`frentes/metacanon/README.md`](../README.md). El inventario entre repositorios es [`INVENTARIO-REPOSITORIOS-Y-FRENTES.md`](../../../../INVENTARIO-REPOSITORIOS-Y-FRENTES.md); las reglas normativas están en [Metacanon §51](../../../../METACANON-OBJETOS-CANONICOS.md#51-taxonomia-de-organizacion-repositorios-frentes-y-recursos). Para la conversación fresca, utilizar [`PROMPT-REINSTANTIACION-METACANON-M25.txt`](PROMPT-REINSTANTIACION-METACANON-M25.txt). El registro es un corte puntual, no sincronización automática entre repositorios.

## 10. Persistencia

Este evento se registra bajo `frentes/metacanon/` con las instrucciones posteriores, diálogo JSONL, salida, crónica, evidencia y prompt de reinstanciación. El control sigue registrado en `SES-20261021-6B9E2F41`, generación 3; la nueva conversación debe comprobar el control y no asumir ni transferir titularidad sin la autorización requerida. No se ejecutaron ni consultaron workflows en este cierre; los fallos históricos no se presentan como aprobados.