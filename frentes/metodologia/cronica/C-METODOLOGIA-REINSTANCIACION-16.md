# Crónica del ciclo · C-METODOLOGIA-REINSTANCIACION-16

**Fecha:** 2026-10-21  
**Frente:** Metodología / Metacanon  
**OCP:** `frentes/metodologia/`  
**Folio activo verificado:** `SES-20261021-C4D81A7F`  
**Estado:** cambios canónicos persistidos y releídos; ajuste nativo IPZ pendiente de pegado explícito del operador.

## 1. Mandato y alcance

El operador pidió que una instrucción como «retoma el frente de trabajo Harmonia» active un flujo portable de reinstanciación: localizar, entre los repositorios de SeryMente accesibles para la sesión, el repositorio correcto; localizar el FT por su denominación propia; foliar la sesión; adjudicarla de forma exclusiva al FT; adoptar su contexto; recuperar la última salida visible del modelo que esté realmente conservada y aplicarla como salida del primer ciclo; adoptar el marco de trabajo del Metacanon y emitir su formato obligatorio en todos los ciclos. También exigió enlaces directos desde IPZ al GOW vigente, a Metacanon §4 y a la lista de principios en cascada de Sam. La verificación normativa por MCP queda desactivada; se requiere revisión manual ciclo a ciclo.

El texto de la instrucción del operador, la continuidad por expiración de tiempo y los mensajes de progreso visibles se conservaron en `frentes/metodologia/conversaciones/C-METODOLOGIA-REINSTANCIACION-16-dialogo.jsonl` como texto legible. Ese JSONL no es una exportación binaria de la plataforma ni acredita metadatos nativos no expuestos.

## 2. Normativa previa encontrada y conectada

- **Metacanon §4:** los diez campos de salida obligatorios por ciclo.
- **Metacanon §28:** registro incremental verificable, persistencia, lectura de vuelta y checkpoint.
- **Metacanon §29:** el frente se materializa como directorio organizado, no archivo monolítico.
- **Metacanon §42 y Sam P037:** ante otra titularidad activa, pregunta única al operador y traspaso condicionado por revisión/generación, con lectura de vuelta.
- **Metacanon §§43–45:** preponderancia de `SeryMente/metodologia/main` y GOW como único glosario operativo canónico.
- **Sam P001/P038/P008/P039:** cascada de autoridad, fuente preponderante, revisión obligatoria del GOW al inicio y cierre de cada ciclo y reinstanciación FT/OCP con folio exclusivo.
- **SI-METACOGNITIVO.md:** queda como antecedente histórico; no vuelve a ser una autoridad paralela.

## 3. Cambios persistidos en `main`

| Artefacto | Revisión vigente | Función añadida o verificada |
|---|---|---|
| `METACANON-OBJETOS-CANONICOS.md` | v1.17 · `METACANON-OBJETOS-v1.17` | §4 actualiza formato obligatorio; §46 define OCP-folder; §47 norma retoma, folio SES, exclusividad y salida inicial. |
| `gobernanza/METAPROMPT-CANONICO-SAMANTHA.md` | v337 · NX-337m | P039 gobierna retoma de FT y folio exclusivo; P008 exige revisión del GOW al inicio/cierre de cada ciclo; P038 conserva preponderancia del repositorio. |
| `gobernanza/GLOSARIO-WORKSPACE.md` | v2.0 | Define FT/FDT, OCP, SES e IPZ; enlaza directamente GOW, Metacanon §4 y la cascada de Sam. |
| `BOOTSTRAP-CONTEXTO-GLOBAL.md` | blob `26c69035250e857641aea341fb4468a8617c6a07` | BCR alineado a main, búsqueda de FT por nombre, OCP, folio, salida literal anterior y MCP normativo desactivado. |
| `INICIO.md` / `gobernanza/README.md` | blobs registrados en evidencia | Rutas de adquisición y referencias actualizadas a Sam v337/Metacanon v1.17/GOW v2.0. |
| `frentes/metodologia/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt` | 1.287 caracteres | Campo IPZ corto listo para pegar; enlaces directos al GOW, Metacanon §4 y la lista de principios de Sam. |
| `REVISION-METACANON-1.17.json` | blob registrado en evidencia | Recibo estructurado del cambio y sus límites. |

Los espejos de Notion de Sam y GOW se actualizaron desde `main` y se releyeron. Sam quedó como v337/NX-337m; el GOW como v2.0 con las entradas FT/FDT, OCP, SES e IPZ y los enlaces exigidos.

## 4. Folio, titularidad y búsqueda

El control `frentes/metodologia/CONTROL-RESPONSABILIDAD.json` registra `generation: 2`, `status: owned` y `session_folio: SES-20261021-C4D81A7F`. El folio es identificador operativo, no un ID nativo de ChatGPT. El responsable de sesión usa un alias operativo previamente autorizado porque el runtime no expuso el ID nativo.

La búsqueda de código accesible no devolvió coincidencias del folio, pero el índice no demuestra ausencia global. La evidencia solo permite afirmar el control de Metodología y el alcance de los repositorios accesibles; no se declara una exclusión server-side ni unicidad probada en toda la organización. El flujo obliga a revisar el control específico del OCP en cada nueva retoma.

## 5. Verificación y límites

- Lectura de vuelta de Metacanon v1.17, Sam v337/NX-337m, GOW v2.0, BCR, INICIO, guía de gobernanza, control de folio y recibos.
- Lectura de vuelta de Notion: Sam v337/NX-337m con P037/P038/P008/P039; GOW v2.0 con FT/FDT/OCP/SES/IPZ, revisión obligatoria y enlaces directos.
- El IPZ tiene 1.287 caracteres; la documentación vigente de OpenAI fija 1.500 caracteres para Free/Go. El texto está guardado en main, pero no se ha pegado en el ajuste nativo.
- La verificación normativa por MCP permanece desactivada; se requiere revisión manual de la cascada de Sam y del GOW en cada ciclo.
- No se implementó sincronización perpetua GitHub↔Notion; las propagaciones verificadas son puntuales.
- No se probó aceptación semántica por un modelo externo distinto; no se promete obediencia universal.

## 6. Próxima acción pendiente

Pegar `frentes/metodologia/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt` en **Configuración → Personalización → Instrucciones personalizadas** de ChatGPT, guardar y volver a leer el campo para comprobarlo. Hasta entonces, el ajuste nativo debe considerarse **PENDIENTE**, aunque la norma y el artefacto estén publicados y verificados.
