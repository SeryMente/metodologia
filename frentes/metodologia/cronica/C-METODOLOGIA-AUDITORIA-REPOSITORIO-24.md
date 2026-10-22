# Crónica · C-METODOLOGIA-AUDITORIA-REPOSITORIO-24

**Fecha local:** 2026-10-21 (America/Mexico_City).  
**Evento:** inventario completo y limpieza conservadora del repositorio.  
**Folio global de ciclo:** `C-20261021-9C4F6A12`. Búsqueda exacta previa: nueve repositorios accesibles, cero coincidencias; la unicidad global no se afirma.  
**Sesión/FT:** Metodología/Metacanon · `SES-20261021-6B9E2F41`, generación 3.  
**Fuente:** `SeryMente/metodologia/main`.  
**Base inspeccionada antes de persistir M24:** `2fd5ca10b58b5a60ecb26cc86a400073151e5c31`.

## Instrucciones literales

Las tres entradas del operador se guardan sin normalización en [el diálogo M24](../conversaciones/C-METODOLOGIA-AUDITORIA-REPOSITORIO-24-dialogo.jsonl). El mismo archivo contiene la salida final visible, idéntica a la salida persistida. El último pedido que gobierna el ciclo solicita auditar el repositorio y retirar solo aquello que no sea necesario/esencial, resolver dudas triviales con criterio autónomo y conservar el juicio humano para decisiones materiales.

## Inventario estructural

- Árbol recursivo de `main`: 346 entradas, sin truncación, en 300 blobs y directorios.
- Seis directorios de primer nivel: `.github`, `CIBERCAFE`, `ENTREGABLES`, `frentes`, `gobernanza`, `scripts`.
- La raíz pasó de 49 a 30 archivos. El README raíz tiene 40 enlaces internos y todos resuelven tras sumar la explicación de compatibilidad del SI.
- La revisión fue estructural y orientada por dependencias: árbol completo, gobierno, README, archivos rectores, scripts, workflows y artefactos de los frentes relevantes. No se declara un análisis semántico línea por línea de todos los 300 archivos.

## Mutaciones registradas

1. Commit `b98cfad3b5579fc37f899d36bff850b33252ad33`: retirada de los tres espejos Sam generados prematuramente antes de que el operador autorizara el diseño.
2. Commit `13fd53e992b41709059886697e10113225c0f5c0`: reordenamiento de raíz; 15 recibos `REVISION-METACANON-*.json` en `frentes/metodologia/antecedentes/revisiones/`; cinco análisis de principios en `ENTREGABLES/principios-historicos/`; traslado inicial del SI legado y de la continuidad histórica; README raíz simplificado. Después se verificó que KHORA consume la ruta raíz del SI, por lo que ese traslado se revirtió; la ruta de antecedentes es ahora un puntero.
3. Commit `43ab7ed7e0f59387fcbe12e89ea99e9605d2a5ce`, seguido de `a56245e4d0cf3eba36be2cabf8c70b6be7ec20e7` y `503f0044c6f4dc34fa0168a854862b15093b98b1`: actualización iterativa del validador Python para Sam vigente, puntero de SI histórico y contrato de salida.
4. Commits `bdf4bdfbe5749bab632d79b8ab1905dcf8ccdf82`, `e2d0713d86a866a1e42d8cda2c3138e2ba0761ca`, `d189a60903ae338d63b6c3ecf2168ed32559b17a`, `62ce8245a50716316a47a88e5d8a401e5986a6d4` y `40536af20d8b0bcfe995a4ef17f1255c8c1d4cea`: actualización de workflow para referenciar el archivo SI archivado, retirar aserciones obsoletas, corregir comprobaciones repetidas/ámbito y eliminar la invocación duplicada del validador bootstrap.
5. Commit `3714c055631e99d940993bd16d07f4d1376c9fca` y `5599e962b088e5c6aa6a75d850ac5889d5b35736`: corrección de la sección §5 de `METODOLOGIA.md`, reparación de la línea con saltos escapados y nota explícita sobre la incompatibilidad pendiente del esquema heredado.
6. Commit `ff1138ce70d2f63ddc5f00d9f09bed6d30c93062`: reparación de los tres enlaces relativos del SI histórico archivado; el blob anterior, `1c1e8746d70807ad3274bf98f723f08915585efe`, queda como procedencia de la copia previa al rebaseo de rutas.
7. Commit `b704314c0231004aa95ce852a7c6d841e783b1b4`: actualización de §9 del Metacanon con el estado M24.
8. Commit `2fd5ca10b58b5a60ecb26cc86a400073151e5c31`: registro de los pendientes REPO-01, SCHEMA-01, CI-01, EP-SCRIPTS-01, DUPLICADOS-01 y SAM-ATOM-01.
9. Salida, diálogo, crónica, evidencia, README del OCP y manifiesto se actualizan en esta secuencia. Sus contenidos se leen de vuelta desde `main`; sus SHA finales se incorporan al recibo de evidencia y al manifiesto donde corresponde.



10. **Corrección de compatibilidad tras auditoría de consumidores:** se confirmó en `SeryMente/khora/main`, `khora-web/lib/server/norm-check.ts` (blob `8d8293b0d140ab3b7b6f7e18c4db7e54d3daf4c4`), que KHORA parsea versión/nombre de la ruta raíz `SI-METACOGNITIVO.md`. La prueba `khora-web/tests/unit/methodology_contract_sync.test.ts` (blob `599746d007580840909e5a1a561a9d62ce27de0b`) exige igualdad exacta con el esquema v1.7.7. Por eso se restituyó el blob original del SI (`1c1e8746d70807ad3274bf98f723f08915585efe`) en la raíz sin editar, preservando su banner `GOBIERNO GENERAL SUPERSEDIDO`; `gobernanza/antecedentes/SI-METACOGNITIVO-v1.6.21-historico.md` quedó como puntero, no como segunda copia completa. Sam sigue inalterado y KHORA no se modificó en este ciclo.

## Criterio de conservación

No se borraron originales de conversaciones, crónicas, resultados de pruebas, recibos de revisión, manifiestos de entrega ni historial de frentes. Los 15 recibos de revisión y cinco análisis fueron archivados para reducir ruido en la raíz, no destruidos. Se mantuvieron dos pares de blobs duplicados por sus usos distintos: un prompt autocontenido en dos paquetes versionados y el resultado de regresión Python que comparte bytes con la ruta de salida `pruebas/continuidad/resultado.json`.

Se retuvieron los dos scripts de bootstrap EP porque son distintos y su uso externo no está demostrado ni descartado. No se modificó Sam, no se asignaron pesos y no se marcó como completada la auditoría semántica de los 40 principios.

## Verificación y límite de CI

Las validaciones estáticas se alinearon a la dependencia real: el SI raíz es la fuente de compatibilidad legado marcada como supersedida; la ruta de archivo es un puntero; Sam permanece como gobierno general vigente de Metodología. El README raíz resolvió 40/40 destinos internos.

En GitHub Actions, los workflows `validate-canonical-bootstrap` y `Validate RDC Governance` reportaban `failure` en el corte del commit `40536af20d8b0bcfe995a4ef17f1255c8c1d4cea`. La herramienta de lectura de jobs devolvió cero pasos y la descarga de logs devolvió `BlobNotFound`. No es posible determinar la causa exacta a partir de esta conexión ni afirmar un PASS de CI. Las ejecuciones permanecen como fallo observado/no diagnosticado hasta tener logs legibles.

## Siguiente estado

La dependencia aguas abajo ya está identificada: `SeryMente/khora/main` usa `SI-METACOGNITIVO.md` como `CANONICAL_SI_PATH` y mantiene una prueba de sincronización exacta del esquema v1.7.7. Su migración a Sam requiere cambios coordinados y pruebas de contrato/runtime en KHORA; no se efectuó en este ciclo. La auditoría semántica de los 300 archivos y la revisión de atomicidad/redundancia de los 40 principios de Sam permanecen abiertas.
