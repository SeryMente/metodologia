# Crónica · C-METACANON-TAXONOMIA-REPOSITORIOS-25

**Fecha local:** 2026-10-22 (America/Mexico_City).  
**Folio de ciclo declarado:** `C-20261022-7B31A9D4`; unicidad global NO VERIFICADA.  
**Frente:** Metacanon · **sesión activa:** `SES-20261021-6B9E2F41`, generación 3.  
**Fuente normativa:** `SeryMente/metodologia/main`, Metacanon v1.21; Sam v339 · NX-339m; GOW v2.2.

## Instrucciones conservadas

Los dos dictados que definen el alcance se preservan sin normalización en [diálogo JSONL](../conversaciones/C-METACANON-TAXONOMIA-REPOSITORIOS-25-dialogo.jsonl). El pedido ratifica Metacanon como nombre operativo del frente y solicita implementar la taxonomía en todos los repositorios de Ser y Mente.

## Estado encontrado

El repositorio ya mostraba el OCP activo `frentes/metacanon/`, un puntero en `frentes/metodologia/`, Metacanon §51 y el inventario de nueve repositorios accesibles. Los README locales ya incorporaban una clasificación de frentes y recursos. Se verificó la cadena de commits que registra ese estado; no se duplicó ni volvió a mover el OCP.

## Cambios aplicados en este ciclo

1. README raíz: versión del enlace a Metacanon corregida de v1.20 a v1.21. Commit `a9d104e320b56b44f36c45cea7f80be4c54dce86`; read-back blob SHA `5412bbc2b9a0b25fb97e17881b90900245b1547b`.
2. Inventario: GDP fue precisado porque su README identifica `docs/SPRINT-CONSAR-AFORE-NSS.md` como objeto canónico de sprint de archivo único. Se marca su clasificación/migración como pendiente y no se crea ni mueve carpeta. Commit `2650bf8c551c85fb1e4526fec5a8a53e625dfcb5`; read-back blob SHA `558580fcb9ecd6345ffd83d8d0036a0c6ba57206`.
3. Metacanon §9: agregado el checkpoint de implementación multi-repositorio, límites y estado de CI. Commit `1ff295f7b5d88ffc8007e06c68a7a9a19622b157`; read-back blob SHA `db10db366fd770ce7cb7a9e8fc392b83824c8821`.

## Cobertura por repositorio

Árboles `main` leídos: `SeryMente/metodologia`, `khora`, `serymente`, `otrogranprograma`, `GDP`, `khora-effectif`, `signal-interpreter`, `tercer-ambito` y `personal`. En sus entradas principales se verifica la clasificación local de OCP o la declaración explícita de que no se crea un OCP vacío. El conjunto accesible no prueba cobertura total de la organización.

## Límites y aceptación

- No se movieron los scripts de EP/CIBERCAFE: falta descubrir los invocadores, las rutas relativas y las dependencias de todos los consumidores.
- GDP conserva el núcleo de sprint como archivo único; no se convierte a OCP de carpeta sin una migración definida.
- `etica/` en `SeryMente/tercer-ambito` permanece en su ruta actual; su control formal no se declaró verificado.
- Los workflows centrales de Metodología fallaron en el corte consultado y los jobs no expusieron pasos/logs. Se registran también los fallos observados de KHORA/GDP y el fallo del contrato público v1.7.0 en OGP. Ninguno se presenta como PASS.

La [salida final §4](../entregas/CHATGPT-v0.3/C-METACANON-TAXONOMIA-REPOSITORIOS-25-salida-final.md) contiene el resumen operacional completo. La [evidencia JSON](../evidencias/C-METACANON-TAXONOMIA-REPOSITORIOS-25.json) aporta SHA de blobs y estado de las lecturas de vuelta.