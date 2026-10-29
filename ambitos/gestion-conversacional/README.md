# Gestión conversacional · materialización operativa v1.0

**Estado:** implementación inicial; el contrato normativo reside en [ART-024 del DUG](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024). Esta carpeta es un OCP materializado para los artefactos que necesita este ciclo; no es una fuente normativa paralela.

## Componentes

- **Registro conversacional:** [contrato](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024), [registro maestro](REGISTRO-CONVERSACIONES.csv), [esquema E/S](ESQUEMA-CICLO-CONVERSACIONAL-v1.0.json), [guía](REGISTRO-CONVERSACIONAL-v1.0.md).
- **Trazabilidad semántica:** [contrato](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024), [vínculos](REGISTRO-TRAZABILIDAD-SEMANTICA.jsonl), [esquema](ESQUEMA-TRAZABILIDAD-SEMANTICA-v1.0.json), [guía](TRAZABILIDAD-SEMANTICA-v1.0.md).
- [Fuentes verbatim históricos](FUENTES-VERBATIM-ORIGEN.jsonl): extractos de la transcripción aportada por el operador, con procedencia y clasificación.
- [Ciclo de referencia](../../frentes/gobernanza/conversaciones/C-GOBERNANZA-GESTION-CONVERSACIONAL-01-dialogo.jsonl): entrada/salida literal del ciclo de materialización.

## Operación

1. Asignar una sola vez un UUIDv7 propio del registro; conservarlo durante las migraciones. No es ID nativo de plataforma.
2. Registrar repositorio, frente, último folio y referencia recuperable al ciclo; no inferir los datos que falten.
3. Preservar cada ciclo como entrada y salida separadas, con folio común y sufijos `-E` / `-S`. Mensajes auxiliares visibles se almacenan separados de la salida final.
4. Etiquetar únicamente segmentos literales que contengan instrucciones, decisiones o restricciones relacionadas con resultados.
5. Registrar contexto no esencial sin elevarlo a requisito ni norma.
6. Leer de vuelta y cotejar el contenido persistido; declarar cobertura incompleta cuando corresponda.

## Límites v1.0

El CSV/JSONL es una elección física provisional para este OCP, no una convención universal. Esta implementación no ofrece captura automática, sincronización omnicanal ni recuperación de conversaciones ausentes. Un registro local no demuestra cobertura global.

## Criterios verificables de cierre

- ID estable propio del registro y datos de localización disponibles.
- Pareja E/S recuperable por folio y texto cotejado.
- Etiquetas con fuente literal, resultado(s) y estado.
- Procedencia de extractos importados explícita; los no esenciales marcados como contexto no normativo.
- Esquemas y JSONL parseables; lectura de vuelta exacta.
- Sin afirmaciones de automatización o IPZ nativo que no estén verificadas.
