# Crónica · C-GOBERNANZA-REFERENCIAS-VERSION-01

**Fecha:** 2026-10-28 · America/Mexico_City  
**Frente:** Gobernanza · OCP: `frentes/gobernanza/`  
**Folio global de ciclo:** `C-20261028-FA636DB0`

## Cambio

La revisión posterior a DUG v357 detectó una referencia interna obsoleta en el resumen humano de Metacanon: «Gobierno general» aún citaba v356 · NX-356m. Se corrigió para apuntar a v358 · NX-358m y se versionó el DUG como v358 · NX-358m.

Es una corrección de referencia, no una nueva decisión semántica. Permanecen Metacanon 1.23, GOW 2.7 con 108 términos y taxonomía estructurada 1.2; el DUG conserva 41 principios y 16 anexos.

## Taxonomía vigente

OCP se aplica a cada unidad taxonómica de su propio nivel; la Metodología, en sentido general y abstracto, es el OCP raíz. Los dos ámbitos funcionales actuales son Persistencia documental y Gestión conversacional, al mismo nivel. Se permite definir subámbitos de nivel 2..N cuando una necesidad delimitada lo justifique, sin instanciarlos por defecto. Contexto sigue revertido como ámbito independiente y no es padre de Gestión conversacional.

## Fuente y comprobaciones

DUG: `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`  
Versión: v358 · NX-358m  
Commit: `1dd88b177d8782bae5e266310979f5307665d750`  
Blob: `89a28e4d05f5baab9c4b86abdb9fbfc532690c75`

La lectura de vuelta del DUG coincide exactamente. El JSON embebido pasa parseo; el JavaScript operativo extraído pasa compilación sintáctica aislada. No se detectaron IDs duplicados en el HTML estático ni anclas duplicadas en el contenido inspeccionado. Se alinearon metadatos y puntos de entrada; sus blobs/commits están registrados en el recibo de evidencia del evento.

## Límites

No se ejecutó renderizado de navegador ni auditoría dinámica de enlaces. Notion no se actualizó ni se releyó; IPZ nativo no se escribió ni verificó. La prueba E2E de persistencia documental con un adjunto real y recuperación por otra instancia autorizada permanece pendiente. GitHub Actions/workflows no se consultaron ni ejecutaron.

Este archivo es un registro operativo; la única fuente normativa permanece en el DUG HTML de `main`.
