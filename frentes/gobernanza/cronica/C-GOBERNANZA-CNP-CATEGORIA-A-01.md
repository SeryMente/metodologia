# C-GOBERNANZA-CNP-CATEGORIA-A-01 · Categoría A como identificador único del CNP

**Fecha observada:** 2026-10-30. **Estado:** modificación canónica ejecutada y leída de vuelta.

## Autorización

El operador autorizó expresamente eliminar la variable ordinal/posición CNP-01 a CNP-05. La categoría de preponderancia A identifica por sí sola la pertenencia al Conjunto Nuclear de Principios (CNP); el decimal se conserva exclusivamente para ordenar la preponderancia relativa dentro de la categoría. La autorización quedó incorporada al control de responsabilidad y leída de vuelta con titular activo y generación 6.

## Modificación

En DUG v367 · NX-367m se eliminaron los campos ordinales `id: CNP-01…CNP-05` de la lista de miembros y los campos `cnp_id` de los cinco principios. La tabla humana dejó de mostrar la columna de posición. Se conservaron los identificadores reales de principios P001, P004, P005, P038 y P043 y sus decimales A · 0.9, A · 0.8, A · 0.7, A · 0.6 y A · 0.5.

El DUG declara ahora que A es la categoría de máxima preponderancia y que identifica la pertenencia al CNP. No se asigna ordinal adicional. Las categorías B–Z permanecen como categorías inferiores. El GOW actualizó la definición de CNP para reflejar la misma regla.

## Verificación

- DUG v367 · NX-367m, evento `C-GOBERNANZA-CNP-CATEGORIA-A-01`.
- Commit: `8268055b23493dc55a1b6afc62ef0c32c276f0f3`.
- Blob de lectura de vuelta: `abb4d397bf78aa60d1fd340ac54535f1e3b1d55a`, idéntico al SHA del contenido actualizado.
- JSON embebido parseado; 43 principios y 19 anexos.
- La lista CNP conserva cinco miembros Pxxx. No queda `CNP-01…CNP-05`, ningún campo de miembro `id`, ni campos `cnp_id` en los principios. Los valores decimales se mantienen.

## Observación sobre IPZ v0.8

La comparación directa encontró que v0.8 tiene 1.488 caracteres frente a 2.467 de v0.7, pero no conserva íntegramente todo su contenido. Entre las omisiones verificadas están los seis estados (propuesto, autorizado, intentado, ejecutado, verificado y aceptado), la aclaración de que la edad IPZ no demuestra instalación nativa, la instrucción «Muestra solo» y el desarrollo operativo detallado de eficiencia (selección de vía suficiente, anti-redundancia, agrupación de lecturas, ciclos breves y entrega inmediata del resultado útil). Por tanto, v0.8 no debe instalarse como sustitución íntegra de v0.7 hasta preparar una candidata que reconcilie ambos contenidos dentro del límite.

## Límites

No se ejecutó renderizado de navegador ni auditoría dinámica de anclas/retornos. No se modificó la IPZ candidata ni el campo nativo. FOL1 continúa `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; no se asignó folio a este evento.
