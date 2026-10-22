## 1. Identidad operativa y gobierno vigente

- **Proyecto/frente:** Ser y Mente · Metodología/Metacanon.
- **Evento:** `C-METODOLOGIA-AUDITORIA-REPOSITORIO-24`.
- **Folio global del ciclo:** `C-20261021-9C4F6A12`. La búsqueda exacta previa no devolvió coincidencias en los nueve repositorios accesibles; no demuestra unicidad fuera de ese alcance.
- **Sesión activa:** `SES-20261021-6B9E2F41`, generación 3, responsable ya registrado en `frentes/metodologia/CONTROL-RESPONSABILIDAD.json`.
- **Fuente normativa:** repositorio privado `SeryMente/metodologia`, rama `main`.
- **Gobierno:** Sam v339 · NX-339m; Metacanon v1.20; GOW v2.2. Sam no fue modificado.

## 2. Dónde estamos

Se obtuvo el árbol recursivo completo de `main` sin truncación: 346 entradas, incluidos 300 archivos y directorios. La raíz conserva seis directorios principales (`.github`, `CIBERCAFE`, `ENTREGABLES`, `frentes`, `gobernanza` y `scripts`) y pasó de 49 a 30 archivos sueltos.

La auditoría cubrió el árbol completo, rutas principales, puntos de entrada, README, gobierno, scripts y workflows, activos del frente Metodología, duplicados exactos y dependencias visibles. **No se afirma una revisión semántica línea por línea de los 300 archivos**; donde no se pudo demostrar que un artefacto era prescindible, se conservó.

## 3. Actualización/delta

1. Se simplificó el README raíz para convertirlo en un índice de navegación hacia los documentos vigentes. Sus 40 enlaces internos se cotejaron contra el árbol y no se encontraron destinos rotos.
2. Se movieron 15 recibos `REVISION-METACANON-*.json` a `frentes/metodologia/antecedentes/revisiones/`.
3. Se movieron cinco entregables de análisis de principios a `ENTREGABLES/principios-historicos/`.
4. La guía histórica de continuidad se archivó y conserva un puntero en su ruta original. El traslado del SI legado se revirtió tras identificar una dependencia activa: KHORA sigue leyendo `SI-METACOGNITIVO.md` como `CANONICAL_SI_PATH` y extrae de él la versión/nombre. El contenido original completo volvió a su ruta, con banner `GOBIERNO GENERAL SUPERSEDIDO`; la ruta `gobernanza/antecedentes/SI-METACOGNITIVO-v1.6.21-historico.md` queda como puntero. No retirarlo hasta migrar y probar ese consumidor.
5. Se retiraron los tres espejos de Sam que se habían generado antes de que el diseño se acordara: JSON para máquinas, espejo humano y esquema JSON. La fuente canónica Sam quedó intacta.
6. Se alineó el bloque vigente de `METODOLOGIA.md` con Sam, se corrigió una sección que contenía saltos de línea escapados como texto y se dejó constancia explícita de la compatibilidad pendiente del formato de salida heredado.
7. Los validadores y workflows se actualizaron para reconocer Sam como gobierno vigente y el SI anterior como archivo histórico. Se eliminó una invocación duplicada del validador de bootstrap en el workflow RDC.

## 4. Qué avanzó y evidencia

- **Árbol/root:** inventario recursivo completo, sin truncación; 30 archivos en la raíz y seis directorios principales.
- **Enlaces:** 40 de 40 destinos internos del README raíz existen en el árbol.
- **Conservación:** se preservaron los originales históricos, recibos de revisión, bitácoras, evidencias y entregables de frentes. Los archivos movidos se archivaron en lugar de destruirse.
- **Duplicados exactos mantenidos:** el prompt de kit v0.1.1 y el de entrega CHATGPT-v0.2 son contenido idéntico en paquetes separados; el JSON de regresión Python y `pruebas/continuidad/resultado.json` son idénticos, pero `resultado.json` es una ruta de salida utilizada por el ensayo. Se conservaron ambos pares.
- **Validación estática:** se cotejaron los predicados de contenido de Sam v339/NX-339m, el archivo SI legado marcado como supersedido, el puntero de archivo, el bootstrap, el esquema v1.7.7 y las invariantes RDC. La restauración de la ruta raíz mantiene la compatibilidad de KHORA; no convierte al SI legado en autoridad general vigente.
- **GitHub Actions:** en el último corte leído, los workflows `validate-canonical-bootstrap` y `Validate RDC Governance` figuraban `failure`. El conector no entregó pasos ni logs utilizables (la descarga de logs devolvió `BlobNotFound`); por ello el motivo exacto no está verificado y no se declara PASS de CI.
- **Trazabilidad:** el historial de Git conserva las versiones previas a los movimientos y la crónica/evidencia de M24 registra los hashes de origen y destino.

## 5. Qué falta

- **Contrato v1.7.7 / KHORA:** `FORMATO-REGISTRO-VERIFICACION-CICLO.md` y su esquema siguen usando `SI CARGADO` y `H1 → SI@H1`. El consumidor quedó verificado en `SeryMente/khora/main`: `khora-web/lib/server/norm-check.ts` define `CANONICAL_SI_PATH = "SI-METACOGNITIVO.md"`; `khora-web/tests/unit/methodology_contract_sync.test.ts` exige igualdad exacta con `khora-web/contracts/FORMATO-REGISTRO-VERIFICACION-CICLO.schema.json` v1.7.7, idéntico al esquema canónico de Metodología. La migración a identidad Sam debe coordinar ambos repositorios y pasar las pruebas; no cambiar el contrato en forma aislada.
- **CI-01:** diagnosticar los fallos de GitHub Actions con logs/annotations accesibles. No hay evidencia suficiente para atribuir la causa a un test particular.
- **Scripts EP:** `bootstrap-entorno-persistente.ps1` y `bootstrap-entorno-persistente-ep.ps1` son distintos. El canon referencia el primero; no se borró el segundo sin identificar su consumidor real.
- **Auditoría semántica:** la atomicidad y redundancia de los 40 principios de Sam siguen pendientes de su tarea anterior; este ciclo no modifica Sam.
- **Segunda pasada por carpetas:** la revisión estructural está hecha, pero todavía no existe una lectura semántica individual de cada uno de los 300 archivos.

## 6. Viabilidad

La limpieza estructural y de navegación quedó aplicada y leída de vuelta. No se ejecutaron borrados masivos de registros únicos: en este repositorio, el archivo histórico, las instrucciones originales, los resultados de prueba y los recibos son parte de la trazabilidad. Solo se retiraron tres artefactos generados prematuramente que no debían persistir. El archivo SI raíz se mantuvo completo por dependencia externa confirmada; la compatibilidad definitiva queda abierta.

## 7. Tiempo/ciclos

Un ciclo global: `C-20261021-9C4F6A12`. No se estima duración para la migración del contrato v1.7.7 porque antes debe identificarse y validar a sus consumidores.

## 8. Siguiente acción

El siguiente paso material es diseñar la migración coordinada de `CANONICAL_SI_PATH` y del contrato v1.7.7 en KHORA para que lea Sam sin romper sus recibos ni la prueba de sincronización del esquema. KHORA no se modificó en esta limpieza.

## 9. Continuación

Retomar desde `INICIO.md`, leer Metacanon §9/§50, Sam, GOW, `frentes/metodologia/README.md`, `PENDIENTES.md` y el control de responsabilidad. El siguiente hilo debe usar el output M24 persistido; no reconstruirlo de memoria ni repetir el prompt M21 ya consumido.

## 10. Persistencia

La salida, diálogo literal, crónica y recibo de evidencia M24 se guardaron bajo `frentes/metodologia/` y se leyeron de vuelta desde `main`. El README del OCP apunta a esta salida y el manifiesto activo refleja el nuevo blob del README. Metacanon permanece en v1.20; Sam permanece en v339 · NX-339m. La evidencia distingue el éxito de las modificaciones/read-back de la falta de PASS verificable de GitHub Actions.
