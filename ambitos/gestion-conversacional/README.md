# Gestión conversacional · materialización operativa v1.1

**Estado:** contrato de foliación FOL1 preparado, todavía no activo; el contrato normativo reside en [ART-024 del DUG](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024) y [P042](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P042). El registro maestro comienza con contadores cero y sin asignaciones. La activación se reserva para después de preparar la nueva IPZ y abrir una conversación nueva bajo el formato. Esta carpeta es un OCP materializado, no una fuente normativa paralela.


> **Nota de alineación conceptual posterior · 2026-10-30:** el DUG v364 vigente todavía clasifica Trazabilidad semántica como módulo de Gestión conversacional en ART-020/024. La definición operativa revisada de [AT v1.0](../../frentes/gobernanza/entregas/CHATGPT-v0.8/AT-v1.0.md) la sitúa como capacidad fundamental de AT: los registros de esta carpeta siguen siendo el soporte físico provisional para conservar las trazas, pero la responsabilidad conceptual propuesta corresponde a AT. Esta reclasificación requiere enmienda explícita del DUG conforme a P005; hasta entonces prevalece ART-024 vigente. Registro conversacional permanece en Gestión conversacional. La instalación de IPZA no activa captura automática.


> **Extensión de trazabilidad AT v1.1:** los nuevos registros de vectores semánticos derivados por AT usan el [esquema AT v1.1](../../frentes/gobernanza/entregas/CHATGPT-v0.8/ESQUEMA-VECTORES-SEMANTICOS-AT-v1.1.json) y la definición de [AT v1.1](../../frentes/gobernanza/entregas/CHATGPT-v0.8/AT-v1.1.md). El registro JSONL de esta carpeta se conserva como materialización física histórica/compartida; la responsabilidad conceptual de la trazabilidad se define en AT, pendiente de alineación normativa de ART-020/024 conforme P005.

## Componentes

- **Registro conversacional:** [contrato](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024), [registro maestro de folios](REGISTRO-MAESTRO-FOLIACION.json), [esquema del maestro](ESQUEMA-FOLIACION-MAESTRA-v1.0.json), [índice de conversaciones](REGISTRO-CONVERSACIONES.csv), [esquema A/B v1.1](ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json), [guía FOL1 v1.1](REGISTRO-CONVERSACIONAL-v1.1.md). Los archivos de ciclo v1.0 E/S se conservan como legado.
- **Trazabilidad semántica:** [contrato](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024), [vínculos](REGISTRO-TRAZABILIDAD-SEMANTICA.jsonl), [esquema](ESQUEMA-TRAZABILIDAD-SEMANTICA-v1.0.json), [guía](TRAZABILIDAD-SEMANTICA-v1.0.md).
- [Fuentes verbatim históricos](FUENTES-VERBATIM-ORIGEN.jsonl): extractos de la transcripción aportada por el operador, con procedencia y clasificación.
- [Ciclo de referencia](../../frentes/gobernanza/conversaciones/C-GOBERNANZA-GESTION-CONVERSACIONAL-01-dialogo.jsonl): entrada/salida literal del ciclo de materialización.

- [Ciclo de reinstanciación universal v360](../../frentes/metacanon/conversaciones/C-METACANON-ARRANQUE-360-01-dialogo.jsonl): solicitud, autorización, resultado y procedencia de la intervención documental del 2026-10-29.

## Operación

1. Asignar una sola vez un UUIDv7 propio del registro; conservarlo durante las migraciones. No es ID nativo de plataforma.
2. Registrar repositorio, frente, último folio y referencia recuperable al ciclo; no inferir los datos que falten.
3. Tras la activación FOL1, preservar cada ciclo como A (entrada literal) y B (salida visible final), con número natural local, folios globales y folios por cada OCP aplicable. El esquema E/S y sus folios históricos no se renumeran.
4. Etiquetar únicamente segmentos literales que contengan instrucciones, decisiones o restricciones relacionadas con resultados.
5. Registrar contexto no esencial sin elevarlo a requisito ni norma.
6. Leer de vuelta y cotejar el contenido persistido; declarar cobertura incompleta cuando corresponda.

## Límites y corte FOL1 v1.1

El CSV/JSONL es una materialización de este OCP, no una convención de captura automática. FOL1 no está activo y no se emiten folios nuevos hasta el corte. El registro maestro ofrece contadores globales y por OCP para los contextos catalogados; su cobertura es la del inventario conocido, no una certificación exhaustiva de toda la organización. La idempotencia conserva un folio global por objeto y añade folios locales independientes por OCP; si se detecta un OCP adicional después, solo se extiende su mapa local. El SHA + read-back es serialización cooperativa, no bloqueo de servidor. No hay captura automática, sincronización omnicanal ni recuperación de conversaciones ausentes.

## Criterios verificables de cierre

- ID estable propio del registro y datos de localización disponibles.
- Pareja A/B recuperable por folios globales y OCP y texto cotejado, tras activación; los ciclos históricos E/S conservan su identidad.
- Etiquetas con fuente literal, resultado(s) y estado.
- Procedencia de extractos importados explícita; los no esenciales marcados como contexto no normativo.
- Esquemas y JSONL parseables; lectura de vuelta exacta.
- Sin afirmaciones de automatización o IPZ nativo que no estén verificadas.
