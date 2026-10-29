# Crónica · C-GOBERNANZA-GESTION-CONVERSACIONAL-01

**Fecha:** 2026-10-29 · America/Mexico_City  
**Folio:** C-20261029-E3DA7D1D  
**Sesión/control observado:** SES-20261029-GV4M8Q2R · generación 4 (alias operativo, no ID nativo)  
**Fuente canónica final:** DUG v360 · NX-360m · blob `3cda9d38db1bee76ff0ca752f3ecde8719c70d41`; GOW 2.9; Metacanon 1.24; taxonomía 1.3.  
**Estado:** contrato normativo y materialización provisional v1.0 persistidos; lectura de vuelta y parseo comprobados.

## Encargo

Normar y articular los módulos Registro conversacional y Trazabilidad semántica como parte de Gestión conversacional, inspeccionando los efectos necesarios en la jerarquía de OCP, el DUG, el GOW, los puntos de entrada y los artefactos operativos. Preservar extractos verbatim relevantes de la transcripción aportada, con clasificación explícita de lo esencial y lo no esencial. Cerrar solo este alcance para volver a Tareas.

## Resultado canónico

- Se añadió **ART-024**, anexo de nivel documental 3, hijo de ART-020.
- ART-020 ahora señala los dos componentes como módulos internos, sin crear ámbitos ni subámbitos nuevos.
- El GOW pasó de v2.8/109 términos a v2.9/111 términos con `gow-registro-conversacional` y `gow-trazabilidad-semantica`.
- DUG pasó de v359 · NX-359m a v360 · NX-360m. Se conservan 41 principios; los anexos pasan de 16 a 17; Metacanon sigue en 1.24 y la taxonomía en 1.3.
- No se creó un principio nuevo. Metacanon §28 ya cubre conservación literal de entradas/salidas visibles, procedencia, estado y evidencia; no se duplicó el procedimiento general.
- LISA y sus páginas de Notion no se modificaron. ART-024 remite a LISA cuando aplique, sin sustituir L0/REQ/ACR ni crear otra cadena de autoridad.

## Materialización

La carpeta `ambitos/gestion-conversacional/` contiene:
- README operativo v1.0.
- Guías operativas de ambos módulos.
- CSV con un registro de conversación y un UUIDv7 local estable, separado de cualquier ID nativo de plataforma.
- Dos esquemas JSON.
- Registro JSONL de trazabilidad con 11 relaciones.
- Archivo JSONL con cinco extractos verbatim históricos.

En el OCP de Gobernanza queda la pareja E/S de este ciclo y su salida final. El folio es `C-20261029-E3DA7D1D`; los lados se identifican por `-E` y `-S`. El registro S conserva por separado cinco mensajes auxiliares de progreso visibles; no se concatenan a la salida final.

## Verbatim y no esencial

Los extractos históricos proceden del texto de la transcripción pegada por el operador en esta conversación. Se conserva exactamente el fraseo recibido en esos extractos, incluidos errores de escritura; se declara que no se cotejaron con IDs nativos. La decisión terminológica y los requisitos funcionales se trazan a sus resultados. La pregunta sobre nombres queda como contexto no esencial, y el fragmento sobre la articulación general de cambios se marca fuera de alcance de estos módulos. Ninguno de esos fragmentos se eleva automáticamente a norma.

## Controles y límites

- DUG embebido: JSON parseable, v360, 41 principios, 17 anexos, ART-024 hijo de ART-020, GOW 2.9 con 111 términos.
- GOW machine: dos términos nuevos, visibles en la sección humana y en la representación estructurada.
- CSV: una fila de datos con UUIDv7 local; el identificador nativo de plataforma permanece vacío/no expuesto.
- Fuentes verbatim JSONL: cinco líneas parseables; trazabilidad semántica JSONL: once líneas parseables.
- Diálogo del ciclo: dos líneas JSONL, lados E/S; la entrada E coincide exactamente con el mensaje de usuario y la salida S coincide exactamente con el archivo de salida final. Cinco mensajes auxiliares visibles quedan en S por separado.
- Lectura de vuelta de los artefactos relevantes realizada desde `main`. No se afirma validación mediante un motor JSON Schema completo, renderizado navegador, prueba independiente cross-platform, captura automática, sincronización continua ni escritura del IPZ nativo.
- Una escritura intermedia del DUG produjo temporalmente un bloque JSON embebido truncado. La comprobación de lectura de vuelta detectó el defecto; la siguiente revisión recompuso el DUG desde v359, codificó los caracteres HTML sensibles al embeber el JSON y se releó correctamente la versión canónica actual v360. La versión defectuosa quedó supersedida por el commit correctivo; el blob vigente es el indicado arriba.
- El archivo candidato IPZ del OCP Metacanon no se modificó, ya que ese frente tiene otro responsable activo. El punto de entrada general `INICIO.md` sí se actualizó.

## Cierre de alcance

Registro conversacional y Trazabilidad semántica quedan cerrados para la especificación y materialización inicial v1.0. Los criterios comprobables son identidad estable, pareja E/S recuperable, folio/modificadores, datos de repositorio/frente, etiquetas y resultados con estado, procedencia de extractos importados, clasificación de contexto no esencial y lectura de vuelta.

El cierre no implica perfección futura ni captura automática. La evolución queda supeditada a necesidades observadas en uso. GOV-AT-01 permanece abierto e independiente; los artefactos de Tareas no se reescriben en este ciclo. El próximo objetivo vuelve a Tareas, donde deberá resolverse la discrepancia preexistente entre las referencias a v0.2 y la existencia del candidato v1.0.

## Artefactos relacionados

- [Salida final](../entregas/CHATGPT-v0.6/C-GOBERNANZA-GESTION-CONVERSACIONAL-01-salida-final.md)
- [Evidencia](../evidencias/C-GOBERNANZA-GESTION-CONVERSACIONAL-01.json)
- [Diálogo literal E/S](../conversaciones/C-GOBERNANZA-GESTION-CONVERSACIONAL-01-dialogo.jsonl)
- [Materialización de Gestión conversacional](../../ambitos/gestion-conversacional/README.md)
