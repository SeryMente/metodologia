# Crónica · C-METODOLOGIA-PERSISTENCIA-DOCUMENTAL-20

**Fecha:** 2026-10-28 · `America/Mexico_City`  
**Frente:** Gobernanza · **OCP:** `frentes/gobernanza/`  
**Titular operativo:** `chatgpt-C-METODOLOGIA-PERSISTENCIA-DOCUMENTAL-20-SES-20261028-CPD20-1606` (alias, no ID nativo) · **Generación:** 2

## Adquisición de fuente y transferencia

Se leyó `main` del repositorio `SeryMente/metodologia`. La fuente vigente no era el recibo histórico v351: el DUG adquirido es v352 · NX-352m, blob `94473eccb6fa71303d5908ce678f7efeb191c215`. El metadato de `gobernanza/GLOSARIO-WORKSPACE.fuente.json` conserva la misma huella canónica; GOW v2.3 y Metacanon v1.21.

El control autoritativo se observó en blob `826574e7cf1d346960e0a48f33bb396588f307e2`, generación 1, titular `chatgpt-C-GOBERNANZA-INICIO-01-SES-20261028-3F2B7A91`, folio `SES-20261028-3F2B7A91`. Se releyó inmediatamente antes de escribir; revisión, generación y titular seguían coincidiendo. La mutación por el conector usó el SHA observado. Lectura de vuelta exacta: blob `7739102ac4623690a0aeeb470ff989bb27963cce`, generación 2, nuevo titular y folio registrados. Commit del traspaso: `0074427119b098b46bf5591243a78cf7e6f83644`.

## Correcciones persistidas

- `INICIO.md`: commit `93dc800fb20297df16f5296282eeedf62bb9705d`, blob de lectura de vuelta `5cbb0c93b3c982c2453b6ef9af2b971a2d7710c8`. Actualizados versión/contadores al DUG v352, 41 principios y 8 anexos.
- `frentes/metacanon/README.md`: commit `22521ad52304eb0a122de088d4a560c41ad4566f`, blob `78b93ad639e98cf400ff84523dfbd505171b8d10`. El arranque enlaza Gobierno general, Metacanon y GOW integrados en el DUG.
- `frentes/metacanon/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt`: commit `75527d6df9007a30af642112ff4f7ab0c0086f28`, blob `a220515e8373740084161c93c8ec7557b2d2ec5b`, 1479 caracteres. URLs corregidas a `#glosario`, `#meta-4` y `#P001`; el campo nativo de Instrucciones Personalizadas no fue instalado ni verificado.
- `frentes/gobernanza/GOBERNANZA.md`: commit `fd77b85efdffa8a125ab8dad5bc1ae8bb1f2c746`, blob `b9bf6687353697263c830f379bf54203207ed58f`. La apertura v345 queda marcada como histórica y se añade el corte vigente.
- `frentes/gobernanza/PENDIENTES.md`: commit `882b58c7ec03b0ab2eaaf1b75407dfee5254ea3b`, blob `4176c69734637d5516a8db733ed489dd99f123d6`. Se cerró el defecto histórico de JSON, se actualizaron los defectos obsoletos y se diferenciaron pendientes y bloqueos reales.

Cada archivo modificado se leyó de vuelta desde `main` y su contenido se cotejó con el escrito.

## Verificaciones técnicas del DUG v352

- `gov-data`: `JSON.parse` correcto; 41 principios, 8 anexos, 99 términos de GOW, Metacanon v1.21 y GOW v2.3.
- JavaScript integrado: compilación sintáctica aislada con `new Function` correcta. No se ejecutó el script en navegador.
- IDs estáticos duplicados: cero.
- P041: texto normativo de 282 caracteres; la primera prosa de `content_markdown` coincide con `normative_text`.
- ART-014 existe y refiere a P041; los registros de GOW definen los destinos `gow-spdf`, `gow-spd` y `gow-dug`.
- Las rutas relativas de Markdown verificadas en `INICIO.md` y el README de Metacanon existen en el árbol de `main`; no quedan referencias activas en los tres puntos de entrada inspeccionados a los archivos `.md` obsoletos de Samantha, Metacanon o GOW.
- La auditoría dinámica de anclas, enlaces inversos y renderizado no se ha ejecutado. No se declara una auditoría funcional integral.

## Prueba SPDF y límites

La prueba integral no pudo ejecutarse: esta conversación no contiene un archivo adjunto real que permita conservar/cotejar sus bytes o contenido original. El texto del mensaje no se convirtió en archivo ni se simuló captura; no se creó un manifiesto vacío. La recuperación desde otra instancia autorizada tampoco se probó. El ticket `GOV-SPDF-E2E-01` permanece bloqueado hasta que haya un original real y un segundo lector autorizado verificable.

No se consultaron ni ejecutaron GitHub Actions/workflows. El espejo de Notion no se actualizó ni se releyó; su sincronización actual sigue sin verificar.
## Articulación final · DUG v353 · NX-353m

Tras la reconciliación v352, se determinó que el alcance podía quedar articulado con el principio existente P041 y el anexo existente ART-014, sin agregar otro principio o anexo. P041 se fijó en 294 caracteres para incluir el disparador por adjunto en una conversación responsable de un FT/FDT, preservación en el OCP autorizado, procedencia, read-back/cotejo, bloqueos, no sustitución por derivados y ausencia de sincronización presumida.

ART-014 incorporó la sección 2 de activación por responsabilidad y tratamiento de adjuntos; define que todos los adjuntos de trabajo de esa conversación son insumo operativo por defecto, incluye revisión de adjuntos previos aún accesibles cuando se asume responsabilidad, exige resolver el OCP con el control vigente, guardar original antes de procesar, registrar el manifiesto, leer de vuelta y cotejar; explicita el contrato multiplataforma y que IPZ de ChatGPT es solo un punto de entrada subordinado, sin presumir instalación nativa. Los apartados anteriores se renumeraron hasta el §11.

La fuente DUG v353 fue escrita y releída exactamente: commit `868a8e9db9ede8611c1dc814d5b6a54060dd9269`, blob `16c93745311a5405166a31b583c2a648fda0d044`. El metadato GOW apunta a ese blob (commit `623645f5f814fbe3b1e7c7684479360fe39648dc`). IPZ quedó en 1492 caracteres (commit `6048162f086f890c0330b7e9d59175d79bf75831`), pero el campo nativo no fue instalado ni verificado.

Después se alinearon el punto de entrada, README de Metacanon y README de Gobernanza a v353. La prueba E2E con archivo real sigue bloqueada por falta de un adjunto original accesible; la auditoría dinámica de navegador, RDC literal, espejo de Notion y sincronización continua siguen abiertos.
