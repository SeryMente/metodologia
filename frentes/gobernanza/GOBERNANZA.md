# Núcleo operativo · Gobernanza

**Frente:** Gobernanza.  
**Repositorio:** `SeryMente/metodologia`.  
**OCP:** `frentes/gobernanza/`.  
**Evento de apertura:** `C-GOBERNANZA-INICIO-01`.  
**Ciclo:** `C-20261028-4B81D65C`.  
**Sesión inicial:** `SES-20261028-3F2B7A91`, generación 1.

## Propósito y límite

Este frente separado se ocupa inicialmente del mantenimiento operativo, integridad, navegación y verificación del documento único de gobernanza:

[`gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html)

El OCP previo `frentes/metacanon/` mantiene su nombre y su control. **Metacanon** sigue nombrando el método (v1.21, `METACANON-OBJETOS-v1.21`); **Gobernanza** es el nuevo nombre de este frente separado. Este núcleo registra estado de trabajo y no duplica las normas del HTML ni constituye una fuente normativa paralela.

## Fuente canónica observada al abrir el frente · registro histórico

- Documento: **Gobernanza única Samantha v345**.
- Blob SHA observado en `main`: `4d4d4f7077d58ed48d12bc856bc81ec414fe8733`.
- Rama: `main`.
- Integridad del JSON incrustado: **FAIL** en la comprobación directa de `JSON.parse`; error inicial comunicado en la posición 97306.
- Integridad del JavaScript: las cuatro extracciones de bloques de script comprobadas pasaron `new Function` en una prueba local de sintaxis; esto no constituye validación de ejecución o renderizado en navegador.
- La causa material no debe reducirse a escapar un carácter aislado: el contenido recuperado del JSON contiene una etiqueta `<script>` y código del renderizador dentro del bloque de texto asociado a `ART-013`, compatible con una rotura del límite del bloque de datos y con saltos de línea sin escapar.
- No se ha escrito ni reparado aún el HTML de gobernanza en este ciclo.

## Alcance de trabajo recibido

1. Reparar mínimamente el JSON/JavaScript de la gobernanza única sin perder ni reinterpretar el contenido humano.
2. Verificar directamente las secciones, anexos, IDs, enlaces de navegación y retornos después de la reparación.
3. Incorporar el handoff de RDC únicamente después de resolver la colisión de identificadores existentes; no duplicar ni renumerar IDs silenciosamente.
4. Corregir referencias de navegación obsoletas desde los puntos de entrada que correspondan.
5. Preparar el texto de IPZ con enlace directo al anexo vigente y declarar explícitamente que la instalación nativa queda pendiente si las herramientas no la permiten.

## Límites

- No modificar contenido normativo sustantivo de Samantha ni el GOW por iniciativa propia.
- No crear documentos normativos paralelos; la fuente normativa única sigue siendo el HTML canónico.
- No ejecutar workflows de GitHub Actions ni consultar sus resultados.
- No ejecutar el comando RDC por el mero hecho de documentarlo.
- No afirmar que IPZ nativo está actualizado sin una operación real y lectura de vuelta.

## Estado inicial · registro histórico de apertura

**ABIERTO · En preflight.** La creación de este frente y su control de responsabilidad sí se leyeron de vuelta. La corrección del HTML, el anexo RDC y la instalación de IPZ siguen pendientes. Consulte [Pendientes](PENDIENTES.md) y el [control de responsabilidad](CONTROL-RESPONSABILIDAD.json).

## Estado actual · C-METODOLOGIA-PERSISTENCIA-DOCUMENTAL-20 · 2026-10-28

Responsabilidad transferida y verificada: control de `main` actualizado de generación 1 a 2. El titular receptor es `chatgpt-C-METODOLOGIA-PERSISTENCIA-DOCUMENTAL-20-SES-20261028-CPD20-1606` (alias operativo no nativo). Blob de control anterior `826574e7cf1d346960e0a48f33bb396588f307e2`, blob de lectura de vuelta `7739102ac4623690a0aeeb470ff989bb27963cce`, commit `0074427119b098b46bf5591243a78cf7e6f83644`.

El DUG vigente leído desde `main` es v352 · NX-352m, blob `94473eccb6fa71303d5908ce678f7efeb191c215`. `gov-data` parsea como JSON; la compilación sintáctica aislada del JavaScript pasa, sin prueba de ejecución en navegador. Estado declarado: 41 principios, 8 anexos, Metacanon v1.21, GOW v2.3 y 99 términos. P041 mide 282 caracteres y ART-014 define el SPDF. Las anclas P041/ART-014 y los destinos de GOW `gow-spdf`, `gow-spd`, `gow-dug` se encuentran definidos en los datos/código integrado; la auditoría dinámica de retornos aún no se ha ejecutado.

Puntos de entrada actualizados y leídos de vuelta: `INICIO.md` blob `5cbb0c93b3c982c2453b6ef9af2b971a2d7710c8`, `frentes/metacanon/README.md` blob `78b93ad639e98cf400ff84523dfbd505171b8d10`, IPZ blob `a220515e8373740084161c93c8ec7557b2d2ec5b` (1479 caracteres). No se verificó instalación del campo nativo de Instrucciones Personalizadas.

La prueba E2E del SPDF no se ejecutó: no hay un archivo adjunto real que preservar en esta conversación; el mensaje no se sustituyó por un archivo fabricado y no se creó un manifiesto vacío. Tampoco está verificada una recuperación por una segunda instancia autorizada.
