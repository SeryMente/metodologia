# Pendientes · Frente Gobernanza

## Prioridad inmediata

1. **GOV-JSON-01 · Reparar integridad del JSON incrustado.** La extracción del bloque `gov-data` de la gobernanza v345 no supera `JSON.parse` (error inicialmente observado en la posición 97306). El texto recuperado junto a `ART-013` contiene una secuencia `<script>` y código del renderizador dentro del dato; comparar la versión v344, conservar el contenido humano original y reparar sin reinterpretación ni truncamiento.
2. **GOV-ART-01 · Resolver identificador del handoff RDC.** `ART-012` ya designa la matriz normativa de persistencia y `ART-013` el comando de inicio RDC Cyber. No duplicar IDs ni renumerar en silencio. El uso de `ART-014` quedó propuesto, pero no consta autorización explícita de esa numeración.
3. **GOV-NAV-01 · Corregir navegación obsoleta.** `INICIO.md` todavía referencia v340 mientras el HTML indica v345; el README de Metacanon conserva enlaces a Markdown históricos no disponibles. Reorientar los enlaces al documento único y sus anclas integradas después de comprobar las rutas.
4. **GOV-RDC-01 · Validar el literal de PowerShell.** Conservar el comando recibido exactamente como original y validar sintaxis/función antes de declararlo listo. No ejecutarlo por el mero hecho de documentarlo; cualquier corrección candidata debe quedar separada del literal.
5. **GOV-IPZ-01 · Preparar IPZ.** Enlazar al anexo definitivo desde las Instrucciones Personalizadas, sin copiar el comando completo. Las herramientas disponibles no muestran acceso nativo de escritura al campo; si el límite persiste, entregar texto listo para pegar y declarar instalación pendiente.
6. **GOV-LINK-01 · Auditoría de navegación.** Tras la reparación, comprobar JSON, sintaxis JavaScript, IDs únicos, destinos y retornos internos en la versión actual; no trasladar cifras de auditorías históricas.

## Restricciones heredadas

- El único documento normativo es `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`; este OCP no es una fuente normativa paralela.
- No alterar contenido normativo sustantivo de Samantha ni el GOW sin autorización expresa.
- No crear anexos ni cambiar IDs en presencia de colisiones sin resolverlas.
- No ejecutar ni consultar GitHub Actions/workflows.
- No afirmar renderizado de navegador si no se prueba.
- No afirmar que el campo nativo de IPZ está actualizado sin escritura y verificación reales.
- El OCP de Metacanon permanece en `frentes/metacanon/`.
