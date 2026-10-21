# C-METODOLOGIA-AUDITORIA-REQUISITOS-20 · Salida de ciclo

## 1. Identidad operativa y gobierno vigente

- Frente: Metodología / Metacanon.
- OCP: `frentes/metodologia/`.
- Folio SES: `SES-20261021-C4D81A7F`; generation 2, status `owned`.
- Metacanon: **1.19 · METACANON-OBJETOS-v1.19**.
- Sam: **v339 · NX-339m**.
- GOW: **v2.2**.
- MCP normativo: **DESACTIVADO**. La auditoría se realizó por lecturas manuales de los archivos de `main` y read-back de Notion.

## 2. Dónde estamos

La mayoría de las exigencias ya están expresadas en la normatividad y los artefactos vigentes. La distinción crítica es: cumplimiento documental no equivale a una prueba real de retoma en otra conversación, y no equivale a un bloqueo técnico universal de titularidad.

## 3. Actualización/delta

La versión vigente de main evolucionó después de la revisión anterior: Metacanon 1.19 §49 aclara que el GOW es exclusivamente un glosario y que el Hub contextual de esta construcción es el frente Metacanon y su hilo. Sam está en v339/NX-339m y el GOW en v2.2. Se actualizó el recibo fuente GOW que estaba en v2.1 y se corrigió §9 de Metacanon sobre la vigencia del artefacto IPZ.

### Instrucción original — extractos literales

- “los frentes de trabajo si se nombran por su denominacion especifica, no hay limite a los frentes de trabajo que pueden haber en un repositorio.”
- “Las instrucciones personalizadas tambien contienen un enlace directo al glosario operativo mas actualizado, para que lo tome encuenta siempre, y a cada ciclo.”
- “IPZ es el termino del GOW para Instruccines Personalizaddas. ACtualzialo tambien.”
- “Los FT solo pueden ser adjudicados a una sesion, nunca a mas deuna simultaneamente”
- “Se identifica desde el OCP (...) la ultima salida del modelo. para presentarla como salida en el primer ciclo de la conversacion”
- “el formato de salida, es obligatorio en cada ciclo de la converascion.”
- “las IPZ deben de contener un enlace directo a la parte del metacanon que contiene el formato de salida obligatorio en cada ciclo.”
- “las IPZ deben de contener unenlace directo a Sam, especificamente, la lista deprincipios en cascada ordenados jerarquicamente por grado de preponderancia.”
- “por lo pronto esta desactivada la verificacion por MCP.”

### Versión pulida

Al retomar un FT/FDT en una conversación nueva o refrescada, adquirir primero INICIO, Sam, Metacanon y GOW desde SeryMente/metodologia/main, que prevalece sobre Notion y cualquier copia. Buscar el FT por su nombre canónico entre los repositorios realmente accesibles, sin asumir que cada repositorio contiene un solo FT. Descubrir el OCP por el núcleo, README y control del propio frente; usar frentes/<slug>/ en OCP nuevos y conservar rutas canónicas existentes como docs/frentes/<slug>/.

Generar un folio operativo SES-AAAAMMDD-XXXXXXXX por sesión; registrar el folio en el único control autoritativo del OCP mediante comparación SHA/generación y lectura de vuelta. Cada FT solo puede tener una sesión activa. Si hay un titular incompatible, preguntar una vez por autorización expresa y transferir únicamente tras CAS y read-back verificados. No inventar ID nativo ni declarar unicidad global fuera de los controles accesibles.

Adoptar el contexto persistido del OCP. En el primer ciclo reproducir literalmente la última salida visible del modelo que esté realmente guardada, con ruta/procedencia; si no existe o no es accesible, declarar NO DISPONIBLE sin reconstruirla. Emitir la salida de Metacanon §4 en cada ciclo. Revisar GOW al inicio y al cierre y la cascada de principios de Sam manualmente en cada ciclo. IPZ debe enlazar directamente al GOW, a Metacanon §4 y a la lista de principios de Sam. MCP normativo permanece desactivado. El formato IPZ vigente está en el artefacto canónico de main; su instalación nativa solo se declara verificada tras confirmar el contenido guardado.

## 4. Qué avanzó y evidencia

Se verificaron en main Metacanon §4 y §§46–49, Sam v339/NX-339m/P008, GOW v2.2, BCR, INICIO, control de folio e IPZ. Notion devolvió los títulos/vigencias v339/NX-339m y v2.2. El archivo IPZ canónico tiene 1.451 caracteres y su copia local comparte el mismo Git blob SHA `ff456fbc02f60c93d0dc35a70ee602ceb47626c8`.

## 5. Qué falta

La lista verificable de quince criterios está en `frentes/metodologia/PENDIENTES.md` y en `REVISION-METACANON-1.19.json`. Los bloqueos principales son la lectura del IPZ nativo y una prueba operativa de retoma en un FT diferente.

## 6. Viabilidad

La normatividad necesaria está presente. Puede comprobarse la infraestructura documental, pero el cumplimiento absoluto universal no puede afirmarse sin acceso a todos los repositorios y sin prueba E2E en otro hilo/modelo. Las instrucciones no otorgan permisos técnicos por sí mismas.

## 7. Tiempo/ciclos

No aplica una estimación temporal fiable a un campo nativo que no se puede leer desde estas herramientas. El cierre operativo requiere que el operador sustituya el texto IPZ previo por el artefacto actual y confirme el guardado.

## 8. Siguiente acción

Sustituir el IPZ nativo por `frentes/metodologia/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt` (1.451 caracteres) y confirmar que quedó guardado. Luego ejecutar una prueba de retoma controlada de un FT con salida previa persistida y permiso de prueba claro.

## 9. Continuación

En toda retoma futura, realizar adquisición de canon, descubrimiento de OCP por nombre, comprobación de titularidad/folio, adopción del contexto y recuperación literal de salida anterior cuando exista. La salida §4 es obligatoria cada ciclo; GOW al inicio/cierre y cascada de Sam manualmente.

## 10. Persistencia

- Checklist completo: `frentes/metodologia/PENDIENTES.md`.
- Revisión: `REVISION-METACANON-1.19.json`.
- Evidencia de lectura: `frentes/metodologia/evidencias/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-readback.json`.
- Crónica: `frentes/metodologia/cronica/C-METODOLOGIA-AUDITORIA-REQUISITOS-20.md`.
- Diálogo visible: `frentes/metodologia/conversaciones/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-dialogo.jsonl`.
