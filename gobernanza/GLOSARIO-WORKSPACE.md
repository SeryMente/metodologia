<callout icon="📜" color="gray_bg">
📍 Versión actual · v1.9 · evento C-GOW-METODOLOGIA-GLOSARIOS-02 · Canon Declarativo · Tier Bloqueante · Alcance: todo el WS · todos los proyectos y frentes de trabajo · Propietario: operador (Black Sheep), toda modificación requiere su autorización explícita
</callout>

## §F · Ficha

| Campo | Valor |
| --- | --- |
| Nombre | Glosario Operativo del Workspace |
| Acrónimo | GOW |
| Clase | Canon declarativo (Modo A) |
| Alcance | Todo el WS · todos los proyectos |
| Método rector | MDC v1.1 |
| Estado | En Revisión |
| Fecha de inicio | 2026-07-20 |
| Operador | Black Sheep |

---

## §SUM · Resumen Operativo

<callout icon="💊">
El GOW es el repositorio canónico y autoritativo de toda convención semántica y término operativo transversal del WS y de los frentes que adquieren este canon. <b>Aplica</b> cuando una denominación, abreviatura, equivalencia o posible error de transcripción afecta la interpretación, decisión o coordinación entre frentes; como regla de triage, prioriza términos usados en ≥2 documentos o frentes y cuya ambigüedad tenga costo real. <b>Revisión obligatoria</b>: consultar la fuente vigente al inicio y al cierre de cada ciclo, sin excepción; registrar en el mismo ciclo toda convención ratificada y toda corrección de transcripción que el operador solicite explícitamente. <b>No aplica</b> a léxicos estrictamente locales ni al vocabulario general del español o de ninguna disciplina. Los léxicos locales pueden existir, pero no contradicen silenciosamente el alcance transversal de este canon.
</callout>

## §IX · Índice

- §SUM · Resumen Operativo
- §IX · Índice
- §F · Ficha
- §EI · Párrafo Eidético
- §PRO · Procedencia
- §A · Glosario canónico (Grupos 1–10)
- §TAX · Dirección Taxonómica
- §AC · Acreditación
- §R · Qué NO es el GOW y riesgos
- §Q · Preguntas Abiertas
- §RAT · Registro de ratificaciones

---

## §EI · Párrafo Eidético

El Glosario Operativo del Workspace es el Canon que fija el significado único y autoritativo de cada término operativo usado en los documentos, Cánones, protocolos y conversaciones del espacio de trabajo. No es un diccionario general ni un léxico de proyecto: es la fuente de verdad transversal que garantiza que la misma palabra significa lo mismo en un handoff, en una tarjeta de roadmap, en una corrida RAP y en un dictado del operador. Su vigencia se acredita cuando un término definido aquí puede ser invocado por cualquier agente o documento del WS sin necesidad de re-definirlo localmente.

---

## §PRO · Procedencia

- 🎙️ Dictado del operador — términos canonizados verbalmente en sesión.
- 🟦 Corpus interno — términos que emergen de documentos ya canonizados del WS (Candado de Rapabilidad, MDC, MDP, Metaprompt).
- 🌐 Teoría externa — términos importados de marcos teóricos externos (TDP, Frankl, etc.) adaptados al WS.
- ✦ Propuesta de Samantha ratificada — términos propuestos por el agente y aprobados por el operador.

---

## §A · Glosario canónico

### Grupo 1 · Objetos del WS

<b>Canon</b> 🟦

Documento único y autoritativo que representa un objeto de interés fundamental del proyecto. Todo objeto fundamental tiene exactamente un Canon. No describe cómo se ejecuta algo — declara qué es, cuándo se considera logrado y bajo qué condiciones sus afirmaciones pueden gobernar la producción. Plural correcto en español: cánones.

<b>Canon declarativo (Modo A)</b> ✦

Canon cuyo objeto es declarativo — define qué es algo, cuáles son sus condiciones de vigencia y sus límites. No contiene secuencia ejecutable. Estructura: §F · §EI · §PRO · §A · §AC · §R · §Q · §RAT.

<b>Canon ejecutable (Modo B) = Protocolo</b> ✦

Canon cuyo objeto es también un procedimiento que se corre. Contiene todo lo de Modo A más §EXEC: disparador, insumos, secuencia atómica, compuerta falsable y rutas de escape. Sinónimo operativo: Protocolo. Ambos términos son intercambiables.

<b>Protocolo</b> ✦

Sinónimo de Canon ejecutable (Modo B). Un protocolo documentado bajo MDC es un Canon. Un procedimiento no fundamental que no pasa el triage de Canon no es un Protocolo — es una nota informal.

<b>Objeto fundamental</b> 🟦

Objeto del proyecto cuya ausencia o ambigüedad bloquea decisiones de diseño, producción o ratificación. Todo objeto fundamental tiene exactamente un Canon. Criterio de triage: ¿su ausencia crea ambigüedad que se paga en retrabajo o decisiones sin árbitro?

<b>Aserto</b> 🟦

Afirmación falsable con dueño y estado dentro de un Canon. Unidad mínima rapable. Todo aserto transita tres estados: Premisa → Blanco → Invariante.

<b>Premisa</b> 🟦

Estado inicial de un aserto: declarado en el Canon, con dueño, aún sin atacar por RAP.

<b>Blanco</b> 🟦

Estado intermedio de un aserto: apuntado por DIANA en una corrida RAP activa.

<b>Invariante</b> 🟦

Estado final de un aserto: sobrevivió el debate RAP y fue sellado por el Árbitro. Puede gobernar producción sin bypass.

<b>Era Post-Canon</b> ✦

Estado operativo de un protocolo una vez que su contenido normativo ha sido migrado íntegramente a Cánones Ejecutables hijos bajo el Método para Documentar Cánones (MDC). En la Era Post-Canon: (1) la especificación original pasa a ser fuente histórica de linaje — preservada verbatim, no editada; (2) la capa operativa son los Cánones hijos, que gobiernan ejecución, auditoría y evolución; (3) los cambios fluyen a través del sistema de Cánones (con sus Secciones DEP y pipelines de conflicto), no a través de la spec. Un protocolo en Era Post-Canon puede operar con autoridad transitoria por linaje verbatim antes de que cada Canon hijo haya completado su ratificación formal por RAP-on-RAP. Primer protocolo del WS en Era Post-Canon: RAP · Protocolo Adversarial de Razonamiento, 2026-07-20.

<b>Desfragmentación Post-Canon</b> ✦

Operación de migración que inaugura la Era Post-Canon de un protocolo: el contenido normativo de la especificación se distribuye verbatim en Cánones Ejecutables hijos (uno por subsistema o §EXEC distinguible), cada uno con anatomía MDC completa. La spec no se edita. Los hijos heredan autoridad transitoria hasta que cada uno pase su propia corrida RAP-on-RAP. Resultado del RAP Post-Canon: 11 Cánones (1 padre declarativo + 10 hijos ejecutables).

---

### Grupo 2 · Métodos y protocolos del WS

<b>MDC</b> ✦

Método para Documentar Cánones <b>= Método de Canonización = Metacanon</b>. En el contexto histórico/local del WS Khora, los tres nombres se usaron como equivalentes — «Metacanon» expresaba que el MDC es el Canon cuyo objeto es el Canon como tipo de documento. Esta equivalencia no se exporta automáticamente a la Metodología de Ser y Mente, donde «Metacanon de objetos canónicos» designa el marco v1.14 para mantener frentes persistentes. En referencias entre espacios se usan calificadores completos. El método que rige cómo se construye todo Canon del WS. Dos modos: declarativo (Modo A) y ejecutable (Modo B). Reemplaza al MDP como método rector único. Documento: [MDC · Método para Documentar Cánones v1.1](https://app.notion.com/p/f55a418782418304a3d581adad1a71f6).

<b>MDP</b> 🟦

Método Estándar para Documentar Protocolos. Documento predecesor del MDC, ahora en proceso de absorción. Sus reglas de linting (verbos imperativos, compuerta binaria, arranque en frío) viven como §EXEC dentro del MDC.

<b>RAP</b> 🟦

Refinamiento Adversarial Productivo. Protocolo de debate estructurado que convierte Premisas en Invariantes mediante ataque y defensa controlados. Versión vigente: v1.4.3.

<b>VRC</b> ✦

Verificador de Rapabilidad de Cánones. Protocolo (Canon ejecutable) que corre 7 controles sobre un Canon y emite veredicto binario APTO / NO APTO antes de someterlo a RAP.

<b>GOW</b> ✦

Glosario Operativo del Workspace. Este documento.

<b>SSC · Sustrato de Sesión Canónica</b> ✦

Capa abstracta e irreducible heredada por todo tipo de sesión formal del WS. Define los 8 componentes obligatorios que convierten una conversación en sesión canónica: SSC-01 Banner de Estado · SSC-02 IE con Adjudicación · SSC-03 Compuertas de Apertura · SSC-04 Compuerta de Cierre · SSC-05 Anclaje de Versión · SSC-06 DG (Directiva General) · SSC-07 NI (Norte Inmediato) · SSC-08 Folio de Sesión. No se instancia directamente — lo especializan los tipos de sesión concretos (FIAT, PRIUS, RAP y futuros). Propuesta de Samantha ratificada por el operador (2026-07-24, PRIUS-003). Documento: [SSC · Sustrato de Sesión Canónica · Canon v0.1](/p/5b4a418782418277a061014cc180acc1?pvs=25).

<b>FN · Forja Normativa</b> 🎙️

Mecanismo de enmienda intencional y deliberado dentro de una sesión canónica: el operador convoca explícitamente una corrida de diseño para construir, refinar o especificar un componente canónico (Canon, Artefacto, norma de redacción, etc.). Contraparte intencional del IE (Insight Empírico) — donde el IE es emergente y reactivo, la FN es dirigida y proactiva. Ambos son fuente de verdad para el L0 del Canon o Artefacto afectado y producen enmiendas igualmente legítimas. Ratificado por dictado del operador (2026-07-24, PRIUS-003); nombre aprobado tras descarte de DNS (conflicto infraestructura de redes). Define los 8 componentes obligatorios que convierten una conversación en sesión canónica: SSC-01 Banner de Estado · SSC-02 IE con Adjudicación · SSC-03 Compuertas de Apertura · SSC-04 Compuerta de Cierre · SSC-05 Anclaje de Versión · SSC-06 DG (Directiva General) · SSC-07 NI (Norte Inmediato) · SSC-08 Folio de Sesión. No se instancia directamente — lo especializan los tipos de sesión concretos (FIAT, PRIUS, RAP y futuros). Propuesta de Samantha ratificada por el operador (2026-07-24, PRIUS-003). Documento: [SSC · Sustrato de Sesión Canónica · Canon v0.1](/p/5b4a418782418277a061014cc180acc1?pvs=25).

---

### Grupo 3 · Estructura de los Cánones

<b>Párrafo Eidético (§EI)</b> 🎙️

Bloque obligatorio en todo Canon. Párrafo único de 3–5 oraciones que responde qué es el objeto en su totalidad — no cómo funciona ni cuáles son sus partes. Debe pasar el Test de Identidad: si el nombre del objeto se elimina y el párrafo sigue aplicando a otro objeto del WS, es inválido.

<b>Test de Identidad</b> ✦

Prueba de validez del Párrafo Eidético: reemplazar el nombre del objeto por \[OBJETO\] y verificar que el párrafo no describe ningún otro objeto del WS. Si lo describe → reescribir.

<b>Test de Genericidad</b> 🟦

Prueba equivalente del MDP para el Bloque de Apertura de un protocolo: eliminar el nombre del protocolo del párrafo de apertura; si sigue siendo verdadero para cualquier otro protocolo, es prosa, no diferencial.

<b>Procedencia</b> ✦

Capa de origen de cada afirmación o término: permite identificar fuente, fecha/evento, ámbito y linaje. En el corpus de Cánones, marcas de procedencia: 🎙️ dictado del operador · 🟦 corpus interno · 🌐 teoría externa · ✦ propuesta de Samantha ratificada. Las entradas heredadas conservan su fuente y alcance; las citas originales no se reescriben como si hubieran nacido normalizadas.

<b>Acreditación (§AC)</b> ✦

Conjunto de condiciones observables y conjuntas que determinan cuándo un Canon está «poseído». Equivale a la Compuerta Falsable del MDP aplicada a un objeto declarativo.

<b>Poseído</b> ✦

Estado de una capacidad o Canon cuando cumple simultáneamente sus condiciones de acreditación (§AC): definida ✓ + ratificada por el operador ✓ + usada en decisiones reales ✓. Sin la condición de uso, el Canon describe una casa deshabitada.

<b>Arranque en Frío</b> 🟦

Prueba de validez de un Canon o protocolo: un agente fresco, sin historial de conversación, debe poder responder las preguntas clave del documento a 0 preguntas de aclaración. Si no puede → el documento falla.

<b>Compuerta Falsable</b> 🟦

Condición de salida binaria y observable de un protocolo o Canon. No admite inspección subjetiva. En Cánones: se expresa como §AC.

---

### Grupo 4 · Demográficos y capacidades (Khora)

<b>FCP · Facultad Cognitiva de la Prótesis</b> 🎙️

Nombre canónico para los tres objetivos de capacidad de Khora (SEA, IAR, RES). Definición teleológica: nombre de la capacidad que Khora hace posible + el poder que confiere al usuario + el sustrato en que opera + la condición de acreditación que la valida.

<b>Contrato cognitivo del grafo</b> ✦

Compromiso de diseño y aceptación que traduce las capacidades de la prótesis Khora en obligaciones verificables del grafo, sin deformar las fuentes ni sustituir la autoría y las decisiones del usuario. Pregunta rectora ratificada: «¿Este grafo permite ejercer las capacidades que justifican construirlo sin deformar las fuentes?». Nombre y pregunta canonizados por orden expresa del operador en el evento C-CONTRATO-COGNITIVO-01. Referencia semántica de proyecto registrada aquí por la instrucción de hub central; no se generaliza como obligación de otros proyectos. Definición rectora única y alcance: [objeto canónico del frente grafo, Contrato cognitivo del grafo](https://github.com/SeryMente/khora/blob/fix/graph-occurrence-history-20261018/docs/frentes/grafo/OBJETO.md#contrato-cognitivo-del-grafo--can%C3%B3nico). No es otro algoritmo, diagnóstico, promesa de perfección ni certificación de producto.

<b>FDP · Facultad Determinista de la Prótesis</b> ✦

Contraparte estructural de la FCP: nombre canónico para las capacidades de Khora cuya condición de acreditación no es un veredicto de síntesis o interpretación sobre el grafo, sino correspondencia directa y auditable con la fuente (cadena de custodia, timestamp de captura vs. del hecho, hash del payload). Falsable por auditoría de trazabilidad, no por coherencia de juicio. Propuesta de Samantha, ratificada por el operador (2026-07-21).

<b>SEA · Síntesis Existencial Accionable</b> 🎙️

FCP-1. La capacidad de identificar y proponer, desde el grafo de relación personal, la jerarquía de valores e ideal de personalidad que se manifiestan en las elecciones registradas del operador.

<b>IAR · Ideación Asíncrona Recuperable</b> 🟦

FCP-2. La capacidad de conservar y recuperar ideas dispersas con su evolución temporal para el trabajo creativo.

<b>RES · Redacción Enraizada en Sentido</b> 🎙️

FCP-3. Denominación canónica ratificada por dictado expreso del operador (2026-07-21 20:12, registrado como «✅ Resuelto» en la fila L0-002 del Génesis); supersede la forma previa «Resonancia de Evidencia Selectiva» 🟦 (procedencia de corpus, v1.0 del GOW — drift corregido 2026-07-23 con autorización expresa del operador). Definición teleológica completa pendiente de re-ratificación bajo la nueva denominación; definición previa del corpus (a cotejar): la capacidad de identificar patrones de coherencia entre el idion del operador y su desempeño documentado.

<b>TL · Línea de Tiempo biográfica forense</b> ✦

FDP-1. La capacidad de generar la cronología del operador desde el PKG con rigor pericial forense: cada evento con fuente original, timestamp de captura vs. timestamp del hecho, dispositivo/app de origen, hash del payload crudo y cadena de custodia de cada transformación hasta el grafo. Sustrato estructural declarado de FCP-2 (IAR) y, por extensión inferida, de FCP-1 (SEA) y FCP-3 (RES).

<b>GRP · Grafo de Relación Personal</b> 🎙️

Sigla canónica del grafo de relación personal: el sustrato de datos personales bien construido sobre el que operan las Facultades Cognitivas de la Prótesis (FCP: SEA · IAR · RES) y del que se esperan capacidades emergentes. Normado como término operativo por dictado del operador (2026-07-23), en el marco del insight empírico que declara la Narrativa Emergente del Génesis (Protocolo FIAT, E-24) como propiedad funcional de carácter temporal del workspace (WS): habrá de ser sustituida eventualmente cuando todo se apoye en las capacidades emergentes de un GRP bien construido; se desconoce aún el punto en que la aplicabilidad del GRP alcanzará el dinamismo del flujo de trabajo principal del WS.

<b>Operaciones visoespaciales de la cognición</b> ✦

Inventario finito de esquemas espaciales (esquemas de imagen) con los que la cognición estructura el pensamiento abstracto, y que constituye la gramática visual candidata de la prótesis: contenencia (Euler), orden/gradación, proximidad/semejanza, jerarquía/composición, flujo/causalidad, tensión/trade-off, centro/periferia, magnitud/peso, evolución temporal, correspondencia/analogía y hueco/ausencia (el espacio negativo como motor de ideación). La transición animada entre arreglos cuenta como operación propia: porta información estructural que ningún par de estados estáticos contiene (rastreo de identidad de los elementos a través del cambio). Base conceptual de una capacidad candidata de proyección visual en tiempo real del GRP (Grafo de Relación Personal) bajo arreglos predeterminados — brainstorm en incubación, sin estatus de FCP (Facultad Cognitiva de la Prótesis). Registrado por instrucción expresa del operador (2026-07-24, sesión de ideación).

<b>Afirmación Competitiva</b> ✦

Aserto falsable, fechado y acotado sobre la posición de Khora frente al mercado — novedad, defensibilidad o ventana — que se pronuncia en pitch, diseño o priorización. Toda Afirmación Competitiva vive <b>enumerada</b> en un registro canónico único (numeración correlativa AC-01, AC-02…; residencia inaugural: los asertos A1–A8 de la TCV · Tesis Competitiva de la Tríada de Proyección Visual), con dueño, fecha, fuente y <b>sensor de vigencia</b> asignado al frente Vigía de la Ventana — una afirmación competitiva sin número de registro o sin sensor no es citable en pitch ni en diseño. El registro porta <b>vigilancia de ampliación</b>: el Parte del Vigía puede proponer altas cuando la evidencia habilite reclamar más territorio; el portafolio crece solo si cada alta es independientemente falsable, acotada y defendible (más afirmaciones = mejor, solo mientras ninguna diluya o solape a las demás y cada una pague su peaje de vigilancia). Nota anti-sigla: no se asigna sigla «AC» por colisión con §AC (Acreditación) y ACR (Criterio de Aceptación) — el término se escribe siempre en forma no abreviada. Registrado por instrucción expresa del operador (2026-07-24, sesión de diseño del Vigía).

<b>PED · Persona en Desintegración</b> 🎙️

Demográfico primario de SEA. Estado (no esencia ni rango) de una persona en proceso de desintegración positiva dabrowskiana: conflicto activo entre conformidad grupal y elección autónoma, con elección sistemática de lo segundo.

<b>PEI · Persona en Integración</b> 🎙️

Demográfico secundario de SEA. Estado de una persona en proceso de integración. Puede beneficiarse de SEA desde la verificación de coherencia entre valores declarados y elecciones registradas.

---

### Grupo 5 · Convenciones semánticas operativas

<b>Frente de trabajo</b> — Denominación corta de «objeto canónico de persistencia de frente de trabajo»: directorio persistente con un núcleo operativo único, contexto externo recuperable, documentos, antecedentes, conversaciones originales y crónica. No equivale a un solo archivo .md. «Ventana de contexto», «historial conversacional» y «crónica del frente» son objetos distintos; no crean fuentes paralelas de estado. En uso ordinario puede aludir también al esfuerzo de trabajo; explicitar la distinción cuando afecte custodia o arquitectura. «Fuentes de trabajo» se normaliza a «frentes de trabajo» si el contexto lo identifica inequívocamente, conservando el dictado original.

<b>Persistencia seamless entre conversaciones</b> — Continuidad desde el último punto efectivamente guardado y verificado, sin exigir repetir lo conservado. No significa memoria ilimitada, captura automática ni conservación de mensajes no escritos; las lagunas se declaran.

<b>Prompt universal de reinstanciación</b> — Disparador portable para adquirir gobierno, identificar el frente, leer su estado vigente y retomar con evidencia. En Notion verifica el metaprompt recibido por configuración; fuera de Notion exige carga explícita. Carga y sincronización no son equivalentes. Modelo y persona no se infieren uno del otro.

<b>Premisa de anclaje ético en lo posible</b> 🎙️

Término de Ética con referencia transversal para el frente grafo. Su definición única y límites residen en <mention url="https://app.notion.com/p/65ca41878241826a9628017bdd8ce1a1" />, §4, ETICA-v1.2, eventos E10 y C-POSIBILIDAD-SITUADA-01. Se conserva el nombre ya registrado en E10; la denominación provisional concurrente queda como historia, no segundo término rector. Relaciona orientación ética y comprensión revisable de posibilidades y restricciones; no convierte viabilidad en justificación moral ni propone definición clínica. Se registra la referencia, no una ética universal ni un canon paralelo.

<b>Otro Gran Programa (OGP)</b> 🎙️

Nombre actual del proyecto antes denominado <b>Otro Buen Programa (OBP)</b>, confirmado por el operador el 2026-10-17 y coincidente con el sitio y repositorio públicos. OBP se conserva como alias histórico para recuperar antecedentes; no se reescriben citas ni documentos históricos como si hubieran nacido con el nombre nuevo. Raíz: <mention url="https://app.notion.com/p/f19a41878241838384ec81137b757005" />.

<b>Paquete de Tercer ámbito</b> ✦

Paquete documental de la iniciativa en curso, identificado mediante el <mention url="https://app.notion.com/p/55da418782418391921c81acdc227a16" />; no equivale a la totalidad de la sombrilla Tercer ámbito. Regla de identificación aprobada por el operador e incorporada al <mention url="https://app.notion.com/p/c85a41878241830588e181f4c02fbab4" /> como Principio de Identificación del Paquete de Tercer ámbito \[P034\], v332 · NX-332m · 2026-10-16.

<b>Remote Desktop Commander (RDC)</b> 🎙️

Denominación del operador para Desktop Commander Remote MCP, del paquete <code>@wonderwhy-er/desktop-commander</code>, identificado en las conversaciones aportadas y la documentación del publicante. No es «Conexión a Escritorio remoto de Windows». Arranque oficial: <code>npx @wonderwhy-er/desktop-commander@latest remote</code>; requiere Node.js 18 o superior. La sesión normalmente se conserva; el proceso debe permanecer abierto y Ctrl+C lo desconecta sin revocar la autorización. Conectarlo no acredita Node estable, entrega Profuturo ni autorización para acceder o modificar equipos. [Fuente oficial](https://github.com/wonderwhy-er/DesktopCommanderMCP/blob/main/src/remote-device/README.md). Nombre ratificado por el operador; identificación y arranque contrastados (2026-10-11).

<b>WS</b> ✦

Abreviatura operativa de «workspace» (espacio de trabajo). Cuando se usa sin calificador, refiere al workspace Black Sheep en Notion.

<b>Normalización contextual: CORA / C-O-R-A → KHORA</b> 🎙️

Convención de normalización de transcripción ratificada por el operador. Cuando el contexto confirma que la mención alude a la prótesis cognitiva digital o al sistema asociado, las formas «Cora», «CORA», «C-O-R-A» y variantes fonéticas cercanas se normalizan a la forma canónica KHORA. En redacción de marca se conserva «Khora» o «Khora OS» cuando corresponde al nombre comercial; KHORA es el identificador canónico de normalización. Si el contexto evidencia otra entidad llamada Cora/CORA, se conserva esa entidad. Si persiste una ambigüedad real, se explicita y se pregunta una sola vez. La asociación no autoriza a cambiar citas u originales históricos.

<b>MP · PRIUS-MP · Metaprompt Canónico de Capa 1</b> 🎙️

Nombre canónico del estrato de instrucciones de sistema que rige al agente núcleo del WS. Desde la era PRIUS (2026-07-23), el MP reside íntegramente en §EI.1 del Canon Sesión PRIUS — es el conjunto de principios \[P-n\], artefactos \[ART-n\] y recuerdos vigentes de Capa 1 que carga en cada sesión. Abreviatura canónica: <b>MP</b>. Nombre alternativo operativo: <b>PRIUS-MP</b> (enfatiza la residencia en el Canon PRIUS). La equivalencia pre-PRIUS «Workspace (documento) = Metaprompt = System Prompt · Abreviaturas: MP · SY» queda obsoleta y reemplazada por esta entrada. 🎙️ Dictado del operador (2026-07-24, sesión PRIUS-003).

<b>Sam</b> 🎙️

Abreviatura canónica autorizada para «Metaprompt Canónico de Samantha», la fuente de gobierno general de Samantha, cuyo archivo canónico es gobernanza/METAPROMPT-CANONICO-SAMANTHA.md en SeryMente/metodologia/main. En este sentido, normaliza la forma transcrita «SAM» a «Sam» y, solo cuando el contexto confirme que se refiere al metaprompt, reconoce las variantes históricas de dictado «Samanta», «Metapron» y «Metapromp». No designa por sí sola al agente/persona Samantha ni a otro sistema llamado Sam; si el contexto apunta a otra entidad, conserva su nombre.

<b>Metacanon de objetos canónicos (Metacanon v1.16)</b> 🟦

Marco del repositorio SeryMente/metodologia que configura y mantiene frentes de trabajo como directorios con un núcleo operativo único y materiales enlazados. No confundir con la equivalencia histórica/local de «Metacanon» y «Método para Documentar Cánones (MDC)» usada en el WS Khora. En comunicaciones entre espacios, usar el nombre completo o el calificador de contexto; no propagar equivalencia indistinta.

<b>Normalización de transcripción</b> 🎙️

Asociación explícita entre una forma errónea detectada en dictado/transcripción y el término correcto. Registrar correcciones nuevas solo cuando el operador lo indique expresamente; aplicar automáticamente asociaciones canónicas ya autorizadas cuando el contexto las confirme. No reescribir citas ni originales históricos; conservar la forma observada, la forma correcta, las condiciones de aplicación y la procedencia. Si el contexto real sigue ambiguo, preguntar una sola vez.

<b>Equivalencia operativa</b> ✦

Relación entre formas de denominación que pueden interpretarse igual bajo un alcance definido. No inferir equivalencia por similitud textual, fonética o semántica; registrar alcance, forma canónica, alias/errores admitidos, excepciones y procedencia. Una equivalencia propia de un proyecto no se generaliza a todo el WS.

<b>Revisión del GOW por ciclo</b> ✦

Comprobación obligatoria al inicio y al cierre de cada ciclo de trabajo: consultar esta fuente vigente, identificar términos, abreviaturas, alias y correcciones relevantes para la tarea, resolver discrepancias conforme a la jerarquía y la autorización aplicables, y registrar en este mismo ciclo toda convención ratificada o corrección explícitamente solicitada. Si la fuente no está accesible, declarar «GOW NO VERIFICADO» y no suponer que está vigente. La revisión no obliga a añadir términos sin necesidad real ni a versionar ante todo acceso; la versión cambia cuando cambia el contenido normativo o terminológico.

<b>Glosario operativo compartido</b> ✦

Denominación funcional del GOW para todos los frentes de trabajo: vocabulario transversal que permite abreviar términos, convenir significados y corregir errores recurrentes de transcripción mediante asociaciones explícitas entre expresiones incorrectas y términos correctos, conforme el operador las identifique y solicite. La fuente canónica preponderante es SeryMente/metodologia/main, archivo gobernanza/GLOSARIO-WORKSPACE.md; esta página de Notion y las demás copias son espejos subordinados. Si existe divergencia, prevalece la revisión verificada de main; si main no puede consultarse, declarar «GOW NO VERIFICADO». El GOW puede conservar entradas con ámbito local explícito para evitar pérdida contextual, pero su presencia no universaliza su aplicación.

<b>Julia = Jules</b> 🎙️

Convención de equivalencia terminológica normada por dictado extraoficial del operador (2026-07-23 · nota extraoficial de la sesión de Lilo): «Julia» y «Jules» son nombres intercambiables para el agente asíncrono de codificación de Google (Jules) en todo uso operativo del WS. Antecedente: los handoffs del circuito registraban «Julia/Joules» como typo sistémico de transcripción de voz equivalente a «Jules»; esta convención eleva «Julia» de typo tolerado a término convenido de uso intercambiable. Propagación pendiente por canales legales: repositorio (Exclusividad de entrada — nada llega al repo sin instancia FIAT cerrada o derivación declarada de un L0 firmado), fuentes de verdad del esquema del núcleo de Khora y tabla Génesis · Registro L0 (esclusa: los vectores semánticos L0 solo se modifican en sesión FIAT formal).

<b>Proyecto Oficial · Abreviatura: PO</b> 🎙️

El único proyecto reconocido como oficial en el WS — operativo tanto desde la capa 1 (infraestructura nativa de Notion) como desde la capa 2 (sistema de cánones). Existe un solo Proyecto Oficial en cualquier momento dado. Todo asunto concerniente al Proyecto Oficial que pretenda afectar elementos canónicos de la capa 2 debe ser tratado obligatoria y no negociablemente dentro de una sesión formal de la capa 2; fuera de esa sesión, los asuntos del Proyecto Oficial pueden discutirse en capa 1 sin que ello afecte ningún elemento canónico. Abreviatura canónica: <b>PO</b>. 🎙️ Dictado del operador (2026-07-23, sesión FIAT L0-001).

<b>Canon del Canon</b> ✦

Locución coloquial para referirse al MDC — el Canon cuyo objeto es el Canon como tipo de documento. No es un término técnico formal; el término formal es MDC. Sinónimo operativo: Metacanon (también intercambiable con MDC por dictado del operador 2026-07-23).

<b>Objeto de la Crónica</b> 🟦

Fila en la base de datos Crónica Global de Operación que registra un ciclo de trabajo del agente. Contiene: resumen, herramienta de cómputo, fricción, narrativa, enlace al hilo.

<b>Verbos vetados (en §A de un Canon)</b> ✦

Verbos proscritos en el cuerpo declarativo de un Canon cuando se aplican a la persona o al objeto que el Canon representa: <i>definir, determinar, contener</i>. Verbos del canon: <i>documentar, hacer visible, proponer, identificar</i>.

<b>Bypass del candado</b> 🟦

Autorización explícita del operador para que un aserto en estado Premisa gobierne producción sin haber sido rapado. Debe registrarse en la tarjeta correspondiente con fecha y alcance.

<b>Doble Candado</b> 🎙️

Régimen de aprobación por candados ortogonales e independientes: Candado A (despacho/ejecución) más un candado de presencia del operador por categoría — B (UX/UI, \[P353\]), C (seguridad de la información y copy público, \[P354\]), D (arquitectura de sistema, \[P356\]). Cumplir un candado nunca satisface otro. Categorías cubiertas: UI · UX · seguridad de la información · copy de marketing/comunicación · arquitectura de sistema. El bloqueo aplica únicamente al alto nivel de cada categoría.

<b>Alto nivel (Doble Candado)</b> 🎙️

Estrato de decisión que SÍ es objeto del Doble Candado en sus cinco categorías. En arquitectura: toda decisión que cambia el mapa del sistema — qué piezas existen, cómo se relacionan y comunican, sobre qué sustrato descansan, qué es real vs. simulado. Lo de nivel suficientemente concreto NO es objeto del candado y se resuelve bajo la Regla del Experto (\[P334\]). Motivación: involucramiento real del operador en el diseño sin descender a concreción excesiva.

<b>Prueba del mapa</b> ✦

Válvula de escalamiento del Doble Candado: una decisión de nivel concreto escala al candado si (a) cambia el mapa del sistema, o (b) moldea algo que el operador va a tocar, sentir o necesitar confiar (sus datos personales, la Caja Negra, la veracidad real-vs-mock declarada al usuario). Propuesta de Samantha ratificada por el operador (2026-07-20).

<b>PDCP · Principio de Delegación Creativa Probabilística</b> 🟦

Principio que gobierna toda delegación creativa a un ejecutor probabilístico: la instrucción declara el QUÉ y el POR QUÉ con límites duros (objetivo, presupuesto/alcance, normas de «Hecho cuando») y deja el CÓMO deliberadamente abierto; cada ciclo que redacte, revise, apruebe o dispare una delegación de este régimen confirma su apego en una línea explícita. Formalizado en la Fuente como \[P347\]; heredado por los regímenes Dirigido y Mixto del Canon LISA. Acrónimo canónico fijado por orden expresa del operador (2026-07-20) 🎙️; la grafía «PDPC» de documentos previos es drift. Documento: <mention url="https://app.notion.com/p/1f54801ce39f4cff8a207bf812c6a6a5" />.

<b>Modelo Operativo</b> 🎙️

Nombre canónico del modelo de no frontera del WS (ratificado por el operador 2026-07-21): el modelo que opera el ciclo cotidiano sin portar firma de frontera (\[P286\]). Reemplaza «modelo débil» en todo uso del WS. Contraste: el modelo frontera (Fable 5, Opus 4.8) es el único habilitado para firmar material Jules y tomar decisiones materiales irreversibles.

<b>Formas No Abreviadas (Anti-Sigla Opaca)</b> 🎙️

Convención de redacción obligatoria para Samantha: toda abreviatura, sigla o código interno del WS — en especial los de diseño reciente — se escribe en su forma no abreviada indicando entre paréntesis la forma abreviada (p. ej. «Registro de ratificaciones (§RAT)»), en cada mención, mientras el operador no declare familiaridad explícita con el término. Canonizada en el Metaprompt como \[P358\] (v320 · 2026-07-21). Endurecida con compuerta falsable (v321–v322 · 2026-07-22): señal de violación verificable (sigla sin familiaridad declarada y sin forma no abreviada en la misma mención = turno defectuoso, se declara y corrige ese ciclo) y cotejo anti-sigla previo al envío. La Lista de Familiaridad Declarada fue instanciada y revertida el mismo día por rectificación del operador (anti-crecimiento del WS).

<b>Dimensión del núcleo (firmada / candidata)</b> 🎙️

Convención de denominación ratificada por el operador (2026-07-22): nombre canónico para cada uno de los esquemas de recuperación aumentada por grafos de conocimiento (GraphRAG / KG-RAG) replicables al interior del núcleo multidimensional de Khora — la equivalencia es por convención: «dimensión del núcleo» = «esquema de recuperación aumentada por grafos de conocimiento». En la literatura externa se denominan también variantes GraphRAG o esquemas de recuperación estructurada. Dimensiones firmadas (vector L0-002): EpisTwin y RAKG. Dimensiones candidatas: HippoRAG 2, PathRAG, OG-RAG, MegaRAG, LightRAG, RAPTOR, KET-RAG, RAGU. Toda dimensión porta un switch independiente y debe poder apagarse sin colapso del núcleo (coexistencia heterogénea).

<b>Un solo servidor de desarrollo por directorio (Next 16)</b> 🟦

Convención de entorno verificada en sesión (2026-08-05, ticket FIX-DICTADO): Next.js 16.2.11 con Turbopack <b>rechaza un segundo servidor de desarrollo (</b><b><code>next dev</code></b><b>) para el mismo directorio de proyecto</b>, incluso si se le asigna otro puerto. Aviso literal: <code>⨯ Another next dev server is already running.</code>. Cambiar de puerto no es remedio: hay que cerrar el proceso que escucha el puerto y borrar <code>khora-web\.next\dev</code> antes de relanzar. Consecuencia operativa: todo diagnóstico local de Khora empieza por comprobar si el puerto 3000 ya está escuchando, no por lanzar otro servidor.

<b>Coordinación directa entre hilos</b> 🎙️<br />Intercambio mediante herramientas entre sesiones existentes y autorizadas, sin usar al operador como mensajero por defecto. Cada hilo consulta deltas pertinentes del otro y acuerda tareas/roles funcionales con un escritor declarado por recurso; estados y resultados requieren evidencia. No equivale a vigilancia permanente, creación de agentes ni autorización nueva de seguridad o publicación. Mensajes de mero acuse, reenvíos equivalentes y bucles de autoencargos quedan excluidos. Ratificado y endurecido por el operador el 2026-10-11; aplicación inaugural en Entorno Persistente, con fuente operativa única en [Objeto Canónico de Persistencia de Entorno, §80](https://github.com/SeryMente/metodologia/blob/docs/metacanon-objetos-20261011/frentes/ep/OEP.md). El prompt portable para otros pares no transfiere datos ni permisos del proyecto inaugural.

### Grupo 6 · Canon LISA · especificación de intención

<b>Canon LISA</b> ✦

Canon ejecutable que norma la conversión de la intención dictada del operador en especificación firmada (L0 → REQ → ACR) para las categorías candadas, y punto único de invocación de todo lo rescatable del trabajo LISA pre-Khora (lo diferido vive en su §IDEAS). Documento: <mention url="https://app.notion.com/p/968a41878241825a960b01d1d241cb08" />.

<b>Vector Semántico L0</b> 🟦

Unidad mínima de intención formalizada. Se extrae por diálogo socrático (nunca se propone) y solo existe con la firma del operador. Todo REQ deriva exclusivamente de él. Su firma satisface el candado B/C/D de la tarjeta correspondiente.

<b>RE · Requerimiento Expandido</b> 🟦

Reformulación de un REQ desde otro ángulo (máx. 4 por REQ) que amplía las superficies de entrada del modelo sin restringir ni prescribir: el espacio de soluciones tras leerlo debe ser idéntico al previo.

<b>ACR · Criterio de Aceptación</b> 🟦

Condición observable en verbos de estado (nunca de proceso) que determina cuándo un REQ está satisfecho. Instrumento de inspección del operador bajo el Doble Candado: ratifica ACRs, no diffs.

<b>Compuertas del L0 (ABS · SFN · VER)</b> 🟦

Filtros falsables del Vector L0: abstracción (sin implementación no dictada por el operador), necesidad y suficiencia (el L0 se valida por su descendencia; REQ sin traza → gap o REQ ajeno, sin tercera opción) y verificación de coherencia interna.

<b>LSV manual · Cotejo ciego</b> ✦

Procedimiento vigente de validación del L0 en ausencia del LSV algorítmico (diferido en §IDEAS del Canon LISA): secuencia socrática + compuertas + cotejo del L0 contra los dichos originales del operador sin ver la derivación.

<b>Régimen de especificación (Cero Variación · Mixto · Dirigido)</b> 🟦

Dial de delegación declarado por tarjeta candada antes del despacho: dosifica cuánta variación tolera el operador y cuánta ceremonia porta la cadena L0→REQ→ACR. Hereda el PDCP \[P347\].

<b>Guardas de frontera (Dos Familias · Espacio Abierto)</b> 🟦

Prueba de Dos Familias: si los criterios solo admiten una familia de implementación, prescriben disfrazado → reescribir (salvo Cero Variación declarado). Auditoría de Espacio Abierto: RE y L2 no estrechan el espacio de soluciones. Protegen \[P356\] y el PDCP.

<b>Compuerta de merge (Conformación Negativa · Z-CIA)</b> 🟦

Precondición de aceptación de PRs de tarjetas candadas: búsqueda activa del incumplimiento de cada ACR (atacar, no confirmar) + declaración de integridad (nada simulado, mockeado o parcial etiquetado como real).

<b>Fuente de Verdad Documental (Documento Fuente Aprobado)</b> 🎙️

Figura del Canon LISA (§EI.11 · enmienda v1.2 · 2026-07-22): en casos especiales, un documento aprobado explícita y expresamente por el operador funge como fuente de verdad complementaria del dictado — sus unidades citables (p. ej. unidades de auditoría (UA)) anclan REQs y ACRs sin sustituir jamás al L0 (doble ancla obligatoria, compuerta SFN). El documento se congela como insumo versionado con huella verificable; toda mutación exige re-aprobación expresa. Casos inaugurales: los documentos de unidades de auditoría de EpisTwin y RAKG.

### Grupo 7 · Convención de Código Firmado

<b>Convención de Código Firmado</b> ✦

Canon ejecutable que norma la cabecera de trazabilidad @l0/@req/@acr de todo código producido bajo tarjeta candada, prohíbe el código huérfano dentro de ese alcance y extiende esa trazabilidad al código pre-LISA que una tarjeta candada toque. Documento: <mention url="https://app.notion.com/p/bf6a4187824183ebb9e6012950ec0a50" />.

<b>Cabecera de trazabilidad (@l0/@req/@acr)</b> 🟦

Primer comentario de un archivo dentro del alcance de una tarjeta candada, que declara el L0, el/los REQ y el/los ACR de los que el archivo es inspeccionable. Mínima y legible; no exige manifiesto separado. Desde la v1.1 (2026-07-22) admite la cuarta etiqueta <code>@ua</code> — obligatoria cuando la tarjeta declara un Documento Fuente Aprobado (Canon LISA §EI.11): ancla el archivo a las unidades de auditoría del documento fuente.

<b>Código huérfano</b> 🟦

Archivo nuevo o modificado dentro del alcance de una tarjeta candada que carece de cabecera de trazabilidad. Falla la Conformación Negativa sin necesidad de inspeccionar su contenido.

<b>Regla de contacto (retrofit)</b> ✦

Precepto de la Convención de Código Firmado: el código pre-LISA no requiere retrofit masivo ni preventivo; solo recibe cabecera de trazabilidad cuando una tarjeta candada lo modifica, como parte del alcance de esa tarjeta, antes del merge.

<b>AP-ING v2.0</b> 🟦

Procedimiento de ingeniería inversa de especificación (4 fases) que reconstruye L0/REQ/ACR mínimos para código pre-LISA sin spec previa documentada, previo a anotar su cabecera de trazabilidad.

---

### Grupo 8 · Protocolo FIAT · ingesta de L0

<b>Protocolo FIAT</b> 🎙️

Canon ejecutable (en incubación v0.x) que norma la sesión de chat como máquina de estados dura (S0–S7) para la toma, firma y materialización de Vectores Semánticos L0, con banner de ejecución por turno. Entrada única del sistema. Nombre ratificado por el operador (2026-07-21): «fiat» — la palabra creadora («fiat lux»), registro de creación divina, no ocultista. Documento: <mention url="https://app.notion.com/p/99ba4187824182e7aedf011a6d452bce" />.

<b>Génesis · Registro L0</b> 🎙️

Base de datos que contiene la totalidad de los L0 del sistema (WS y Khora), residencia única del texto de cada vector (D6 · Opción A): el repo solo porta referencias <code>@l0</code>. Una fila = un L0 = una instancia FIAT.

<b>Instancia FIAT</b> ✦

Ejecución formal del protocolo: 1 sesión = 1 L0. Nace en S0 INICIADA y solo termina en S7 CERRADA (L0 firmado ∧ fila del Génesis ∧ tablero ∧ Crónica) o ✕ ABORTADA con causa registrada.

<b>IE · Insight Empírico</b> 🎙️

Dato de experiencia recolectado durante la ejecución de una instancia de un canon en incubación — señaladamente el Protocolo FIAT: conducta observada, hueco normativo, validación o contraejemplo que emerge del uso real del protocolo. Se registra con fecha y procedencia (🎙️ operador · 🤖 modelo) en el expediente de incubación del canon (§RIESGOS), sin mutar la instancia en curso (anclaje de versión, E-06). Al cierre o suspensión de la sesión, cada Insight Empírico (IE) se adjudica obligatoriamente, uno por uno: implementar como enmienda a la versión canónica vigente · dejar documentado, con razón registrada, para integración posterior. Término registrado por dictado del operador (2026-07-23).

<b>L0 de primera mano / L0 derivado</b> ✦

Clases de vector bajo la trazabilidad universal (Canon LISA v1.1): primera mano = pasa la prueba del mapa → toma socrática + firma del operador; derivado = bajo el límite → el sistema lo deriva del L0 padre, marcado «Derivado», ratificación exprés individual o por lote.

<b>Banner de ejecución (◈ FIAT)</b> ✦

Bloque obligatorio en cada turno con instancia activa: estado actual, progreso S0–S7, compuertas y salidas legales, con léxico cerrado (✓ · ▶S◀ · ◻ · ✕). Turno sin banner durante instancia activa = turno inválido.

<b>Exclusividad de entrada</b> 🎙️

Regla dura del Protocolo FIAT: nada llega al tablero, a un canon, a la Fuente ni al repo sin instancia FIAT cerrada o derivación declarada de un L0 firmado. Sin válvula de hotfix (D5 · 2026-07-21, a prueba — vigilada por el ledger de riesgos del canon).

<b>Extracción Protegida</b> 🎙️

Régimen 1 de trabajo sobre la palabra del operador (Protocolo FIAT §EI.3, E-02): el objeto es la intención aún no dictada; el modelo solo pregunta y espeja — proponer está prohibido. Régimen único legal en S1 EXTRACCIÓN.

<b>CCA · Cobertura y Compleción Asistida</b> 🎙️

Régimen 2 de trabajo sobre la palabra del operador (Protocolo FIAT §EI.3, E-02): existiendo una intención madre ya dictada que define el espacio, el modelo enumera candidatos de cobertura marcados 🤖 con ancla citable a dichos del operador; cada candidato recibe veredicto individual A/R/M del operador y procedencia registrada («asistido · veredicto + fecha»). Frontera binaria con la Extracción Protegida: sin intención madre dictada, no hay CCA. Nombre híbrido canónico dictado por el operador (2026-07-21).

<b>Gramática de dependencias obligatorias</b> 🎙️

Órgano determinista del Protocolo FIAT (§EI.7, E-03): tabla fija «tipo de pieza → huecos obligatorios» que la máquina abre mecánicamente al nacer cada pieza (imposible → órgano + señal de violación · criterio → lector, momento, evidencia · órgano → evento del flujo + carga · plazo → efecto del vencimiento). S2 no ofrece firma con huecos abiertos, salvo hueco firmado como abierto por el operador. Crece por jurisprudencia con autorización del operador; enmendarla al momento del cobro es ilegal.

<b>Candado de No-Divergencia (E-04)</b> 🎙️

Regla del Protocolo FIAT (E-04 · autorizado 2026-07-21): con instancia activa, todo dictado ajeno al carril de la instancia NO se atiende — se espeja en una línea y se ofrecen únicamente tres salidas: continuar · suspender · abortar con causa. Prohibido al modelo fabricar artefactos de rescate fuera del Génesis para preservar estado. Señal de violación: turno que atiende materia ajena o crea un artefacto fuera del carril.

<b>Estado ⏸ SUSPENDIDA</b> 🎙️

Estado terminal provisional de una instancia FIAT (E-04 · autorizado 2026-07-21): alcanzable desde S1–S5 por dictado «Suspende» del operador, o forzoso al cerrar sesión con instancia abierta. Snapshot íntegro = fila del Génesis con Estado=Candidato (vector verbatim, compuertas, Instancia de Origen). Restauración: re-correr TODAS las compuertas del estado suspendido — íntegra o no es. Toda suspendida entra al censo V-2 y porta gatillo V-3.

### Grupo 9 · Protocolo de Construcción Auditada (PCA)

<b>PCA · Protocolo de Construcción Auditada</b> 🎙️

Canon ejecutable (en incubación v0.x, Ruta B) que rige el circuito por el cual una unidad de trabajo derivada de un Documento Fuente Aprobado (Canon LISA §EI.11) se despacha al ejecutor probabilístico externo (Jules) y se audita mecánicamente antes de integrarse al repositorio. Bautizado por el operador (2026-07-22, "PCA confirmado"). Documento: <mention url="https://app.notion.com/p/5ada418782418220811d01451dec1c40" />.

<b>Sobre de Despacho</b> 🎙️

Bloque único y autocontenido que cruza la frontera manual operador→Jules: cita el Vector Semántico L0, los Requerimientos (REQ) y Criterios de Aceptación (ACR) verbatim, exige la cabecera de código firmado y la cláusula de No-Simulación, y declara qué evidencia debe devolverse. El operador solo copia y pega.

<b>Sobre de Retorno</b> 🎙️

Único contenido válido que regresa de Jules al espacio de trabajo: la referencia del Pull Request. Nada de lo que el ejecutor declare cuenta como evidencia — solo lo que el repositorio contenga.

<b>khora-audit</b> 🎙️

Instrumento determinista, versionado en el repositorio, que audita mecánicamente cada Pull Request tras el merge: cabecera de trazabilidad presente, traza a un Criterio de Aceptación (ACR) ratificado, pruebas con salida real, y prueba de heterogeneidad (apagar una dimensión sin colapso del núcleo). Declarado tarjeta fundacional #0 del Protocolo de Construcción Auditada (PCA), pendiente de construcción.

---


### Grupo 10 · Metodología compartida y entradas heredadas del glosario de Metodología

**Procedencia:** migración íntegra de las entradas terminológicas del archivo GLOSARIO-OPERATIVO.md, versión v1.3.1, blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85. Su original completo se conserva en frentes/metodologia/antecedentes/GLOSARIO-OPERATIVO-v1.3.1.md. Se unifica aquí el vocabulario común sin extender los términos locales más allá de su ámbito original. Los conceptos que ya existían en los grupos anteriores se consolidan en su entrada canónica correspondiente, no se duplican.

#### Entradas de términos canónicos heredados

<b>CECEQ</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** ubicacion.  
**Definicion:** nombre canonico de la ubicacion de trabajo correspondiente al Centro Cultural Gomez Morin en Queretaro.  
**Forma canonica:** CECEQ.  
**Variantes de transcripcion conocidas:** CSEC, CSEQ.  
**Regla:** las variantes se normalizan a CECEQ.

<b>RDC</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** mecanismo de acceso.  
**Definicion:** Remote Desktop Commander, canal utilizado para operar el entorno remoto autorizado.  
**Forma canonica:** RDC.  
**Regla:** no se confunde con la identidad de una terminal ni con la ubicacion fisica.

<b>Identidad RDC</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** identidad operativa de dispositivo.  
**Definicion:** combinacion de `RDC-CUENTA + RDC-DEVICE-ID` que identifica una terminal concreta ante el proveedor RDC.  
**Regla:** el nombre visible del dispositivo no basta para identificar una terminal.

<b>Sesion RDC</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** estado operativo por terminal.  
**Definicion:** conexion remota autenticada asociada a una identidad RDC concreta.  
**Distincion:** pueden coexistir varias sesiones RDC en dispositivos diferentes; no existe una unica sesion RDC global para todas las conversaciones.

<b>Divergencia de observabilidad RDC</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** estado operativo de recuperación.  
**Definicion:** condicion en la que una terminal RDC requerida no puede verificarse en vivo mientras el usuario aporta evidencia local positiva de actividad de esa terminal.  
**Regla:** no permite inferir finalizacion ni sustituir la terminal por otra identidad ONLINE. Cuando el ciclo requiere esa terminal en vivo, activa el protocolo `RDC-REINSTANTIAR`.

<b>RDC-REINSTANTIAR</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** comando conversacional de recuperación.  
**Definicion:** instrucción canónica que solicita cerrar la terminal/sesión RDC observada, iniciar una nueva sesión y devolver el `RDC-HANDSHAKE` necesario para sustituir de forma verificable el estado global.  
**Regla:** no se interpreta como comando de shell ni como evidencia de finalizacion de otra identidad.

<b>Ubicacion actual</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** estado transversal.  
**Definicion:** lugar fisico de trabajo vigente para los ciclos actuales.  
**Regla:** permanece vigente entre conversaciones hasta declaracion explicita de cambio.

<b>Usuario Windows operativo</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** identidad operativa.  
**Definicion:** cuenta bajo la que deben ejecutarse las operaciones ordinarias del entorno.  
**Regla:** identifica la identidad operativa de referencia del perfil; no obliga por sí misma a cambiar la identidad efectiva de ejecución.

<b>Usuario Windows administrativo</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** identidad administrativa.  
**Definicion:** identidad administrativa o elevada disponible en el entorno. Puede coincidir con la identidad efectiva de la sesión RDC.  
**Regla:** su uso para trabajo ordinario está permitido cuando la operación sea técnicamente válida. La única restricción específica de materialización de repositorios se define en los anexos operativos.

<b>Bloqueo de ejecucion</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** estado de ejecución.
**Definicion:** condición en la que el ciclo no puede realizar trabajo sustantivo ni declararse cerrado por faltar una precondición verificable.
**Regla:** el bloqueo es operativo, no conversacional. El modelo permanece disponible para resolver la causa, recibir información y volver a verificar el contexto.

<b>Notificacion de bloqueo</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** formato operativo.
**Definicion:** salida visual estandarizada que identifica inmediatamente un ciclo bloqueado.
**Regla:** debe aparecer al inicio de una notificación de bloqueo y utilizar el formato canónico del registro por ciclo.

<b>Ciclo</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** unidad metodologica.  
**Definicion:** unidad de secuencia y trazabilidad global establecida por la metodologia.

<b>Conversacion</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** contenedor.  
**Definicion:** contexto conversacional que contiene uno o mas ciclos; no sustituye la identidad global del ciclo.

<b>Variante de transcripcion</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** alias de normalizacion.  
**Definicion:** forma producida por dictado, reconocimiento de voz o legado que corresponde razonablemente a un termino canonico.  
**Regla:** la variante no adquiere autoridad por aparecer en la entrada original del usuario.

<b>Termino canonico</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** unidad terminologica.  
**Definicion:** forma ortografica y semantica que debe utilizarse una vez incorporada al glosario.

<b>RDC-REQUERIDA</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** estado de requisito del ciclo.
**Definicion:** indica si la conversacion o ciclo requiere una sesion RDC activa para ejecutar la tarea.
**Valores:** SI, NO o PENDIENTE DE RESOLUCION.
**Regla:** una deteccion indeterminada no puede convertirse en SI o NO por inferencia; debe resolverse explicitamente.

<b>CONTEXTO-VERIFICACION</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** estado de gate.
**Definicion:** resultado de la comprobacion del contexto operativo antes de ejecutar.
**Valores canonicos:** VERIFICADO-ACTIVO, VERIFICADO-INACTIVO, NO-REQUERIDO, BLOQUEADO.
**Regla:** estados de deteccion como NO-VERIFICADO, INDETERMINADO o FUENTE-NO-DISPONIBLE no son estados de paso.

<b>Registro RDC activo</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Sección de términos metodológicos comunes.

**Tipo:** registro operativo global.
**Definicion:** registro compartido que conserva identidades RDC conocidas, ciclos de vida y metadatos de continuidad entre conversaciones.
**Fuente:** ESTADO-RDC-ACTIVO.md.
**Regla:** no selecciona una terminal global ni sustituye el descubrimiento vivo del proveedor. La terminal actual se resuelve por ciclo.

<b>Terminal RDC seleccionada</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

**Tipo:** estado operativo de ciclo.  
**Definicion:** identidad RDC concreta elegida para el ciclo actual despues del descubrimiento vivo.  
**Regla:** la seleccion es local a la conversacion/ciclo y se identifica por cuenta + device_id. No se hereda como seleccion global desde otra conversacion.

<b>Descubrimiento RDC vivo</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

**Tipo:** mecanismo de verificacion.  
**Definicion:** consulta al proveedor RDC que determina que identidades de dispositivo estan actualmente observables/ONLINE.  
**Regla:** tiene precedencia sobre el registro persistente para determinar presencia y conectividad actuales.

<b>PC-N</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

**Tipo:** identidad persistente de terminal de CIBERCAFE.  
**Definicion:** identificador de una computadora individual del cibercafe, por ejemplo `PC-7`, `PC-8` o `PC-9`.  
**Regla:** el registro y la memoria de desempeno pertenecen a cada `PC-N`; CIBERCAFE no se trata como una sola maquina.

<b>Evento de desempeno</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Entrada heredada con alcance expresado en su definición.

**Tipo:** registro operativo.  
**Definicion:** hecho semantico relevante del proceso de observacion, optimizacion, cambio, regresion, error o sincronizacion de una terminal.

<b>Memoria persistente de desempeno</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Entrada heredada con alcance expresado en su definición.

**Tipo:** estado transversal por terminal.  
**Definicion:** estado consolidado de desempeno que sobrevive a sesiones locales efimeras y mecanismos de restauracion como DeepFreeze mediante el repositorio.

<b>Sincronizacion hibrida de desempeno</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Entrada heredada con alcance expresado en su definición.

**Tipo:** mecanismo operativo.  
**Definicion:** estrategia que mantiene telemetria de alta frecuencia local y publica al repositorio eventos materiales inmediatamente, observaciones ordinarias en lotes y un `SYNC_FLUSH` antes de reinicio/DeepFreeze cuando sea observable.

<b>Economia de llamadas RDC</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

**Tipo:** criterio de eficiencia operativa.  
**Definicion:** capacidad de obtener evidencia, acciones o decisiones utiles minimizando llamadas RDC que no agreguen valor.  
**Regla:** una llamada remota debe justificarse por descubrimiento, accion, verificacion de transicion, resolucion de ambigüedad material o sincronizacion; las mediciones repetibles y la telemetria frecuente deben resolverse localmente o mediante reutilizacion y batching.

<b>RDC-REUTILIZACION</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

**Tipo:** indicador de eficiencia.  
**Definicion:** cantidad o proporcion de verificaciones servidas mediante memoria persistente u observaciones ya vigentes, evitando una nueva llamada RDC.

<b>RDC-EVITADAS</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

**Tipo:** indicador de eficiencia.  
**Definicion:** llamadas remotas que no fueron necesarias gracias a reutilizacion, agregacion o batching de informacion.

<b>PERFIL-CIBERCAFE-NO-REINICIO</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

Perfil operativo permanente del ámbito CIBERCAFE en el que la continuidad de la sesión tiene prioridad: `PRESUPUESTO-REINICIO = 0` y ninguna intervención puede requerir reboot de la terminal.

<b>BLOQUEADA-REINICIO</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

Estado de una intervención que requiere reinicio, apagado, reset, entrada a UEFI/BIOS o reparación offline. Se registra como oportunidad, no se ejecuta y no bloquea por sí mismo el resto del ciclo.

<b>VENTANA-DE-MANTENIMIENTO-LIVE</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance operativo RDC/CIBERCAFE, no universal.

Periodo de mantenimiento en CIBERCAFE en el que la terminal permanece encendida, conectada y utilizable por el usuario. No autoriza reinicio.

<b>Cuota de deployment Vercel</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance técnico de publicación/desarrollo, cuando el proyecto lo utilice.

**Tipo:** restricción de plataforma.
**Definición:** límite vigente que Vercel aplica a la creación de nuevos deployments, dependiente del plan y de las ventanas temporales del proveedor.
**Regla:** se verifica contra la documentación y el estado vigente de Vercel; no se trata como una constante permanente ni como indicio de indisponibilidad total de KHORA.

<b>Deployment</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance técnico de publicación/desarrollo, cuando el proyecto lo utilice.

**Tipo:** objeto de publicación.
**Definición:** versión del proyecto creada y servida por Vercel o preparada para servirla.
**Regla:** la existencia de un deployment no significa que represente el `main` actual; debe verificarse su commit/SHA y estado.

<b>Ejecución local</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance técnico de publicación/desarrollo, cuando el proyecto lo utilice.

**Tipo:** modo de ejecución.
**Definición:** instancia de Cora ejecutada fuera del servicio remoto de Vercel, normalmente desde el repositorio canónico en el equipo local.
**Regla:** puede usarse para desarrollo, depuración y validación cuando el URL canónico no sea materialmente necesario. No adquiere autoridad de producción.

<b>URL canónico de publicación</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance técnico de publicación/desarrollo, cuando el proyecto lo utilice.

**Tipo:** referencia de despliegue.
**Definición:** URL que la metodología reconoce como superficie canónica de producción de un proyecto.
**Regla:** una instancia local o un deployment histórico no se presenta como equivalente al URL canónico sin una decisión explícita y verificable.

<b>Verificación local de build Vercel</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance técnico de publicación/desarrollo, cuando el proyecto lo utilice.

**Tipo:** mecanismo de validación.
**Definición:** ejecución local de `vercel build` para obtener y revisar el artefacto `.vercel/output` sin crear por sí misma un deployment remoto.
**Regla:** `vercel deploy` y `vercel deploy --prebuilt` sí crean deployments y quedan sujetos a los límites del proveedor.

<b>Estado de cuota Vercel</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance técnico de publicación/desarrollo, cuando el proyecto lo utilice.

**Tipo:** estado operativo de ciclo.
**Definición:** clasificación de la capacidad de crear el deployment requerido en el momento de la operación.
**Valores:** `NO-REQUERIDA`, `DISPONIBLE`, `LIMITADA`, `NO-VERIFICADA`.
**Regla:** `LIMITADA` bloquea la publicación que necesita un deployment nuevo, pero no bloquea por sí misma las operaciones sobre deployments existentes ni la ejecución local.


## 7. Formalización de frentes — C-METODOLOGIA-GOBIERNO-01

<b>Núcleo operativo</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance metodológico transversal.

Archivo de entrada y estado vigente de un frente. Orienta y enruta, conserva gobierno obligatorio y continuidad suficiente; no duplica toda la historia ni es un índice vacío.

<b>Contexto persistido</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance metodológico transversal.

Representación externa verificable necesaria para reconstruir una ventana de trabajo útil en otra instancia. No es la ventana interna ni la memoria del modelo.

<b>Historial conversacional</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance metodológico transversal.

Originales secuenciados de entradas del usuario y salidas visibles del modelo, con cambios de plataforma, conversación y modelo, y rol/persona cuando existan. No equivale al contexto operativo ni a una síntesis.

<b>Crónica del frente</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance metodológico transversal.

Registro explicativo de acontecimientos, decisiones, acciones, evidencias, límites y continuidad enlazado con originales; no los sustituye.

<b>Espacio de trabajo Ser y Mente</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance metodológico transversal.

Organización `SeryMente` y sus repositorios como espacio persistente común. Las aplicaciones comerciales, como Notion, son superficies vinculadas, no la única persistencia.

<b>Sincronización perpetua</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance metodológico transversal.

Requisito ratificado: cada cambio documental en la aplicación de origen desencadena actualización automática de su espejo en el repositorio del frente. Alcance confirmado aplicación → repositorio; no presume dirección inversa. Mecanismo aún pendiente; una copia puntual no acredita continuidad automática.

<b>Sesión PRIUS</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance metodológico transversal.

Segunda capa de gobernanza histórica del espacio Notion. Uso futuro previsto; revisión/adaptación diferidas explícitamente hasta que no haya urgencias. Copiar o mencionar su canon no abre una sesión.

<b>Metacanon de frentes</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance metodológico transversal.

Método de configuración y mantenimiento de los frentes, subordinado al gobierno general. No se confunde con el metaprompt ni sustituye las reglas superiores de cada plataforma.

## 8. Precisión de revisión integral1.10

<b>Categorías de revisión</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance de revisión y cierre metodológico.

Dieciséis ejes de auditoría de cobertura e integración del método. No reemplazan los trece bloques del molde del núcleo ni obligan a dieciséis secciones nuevas por frente.

<b>Contrato de cierre</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance de revisión y cierre metodológico.

Concreción del encargo, criterio observable, fuente de intención, permiso, dependencias, evidencia y checkpoint dentro del núcleo existente. No es un segundo estado ni autorización automática.

<b>Aceptación funcional</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance de revisión y cierre metodológico.

Contraste del funcionamiento previsto con evidencia del receptor real y su entorno. Se distingue de revisión documental completada y de controles mecánicos aprobados; no se deduce de ellos.

<b>Recibo de refresco</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance de revisión y cierre metodológico.

Evidencia derivada de lectura de la fuente central: revisión, versión/huella, modificación, comprobación y adopción. No constituye otro núcleo ni actualiza por sí solo un frente.

<b>Antigüedad del método</b> 🟦

**Procedencia y alcance:** importado de GLOSARIO-OPERATIVO.md v1.3.1 (blob 6b8d3a50f2ac235b5597989981a0eabee9e90d85); conservar el alcance específico de esta definición y no generalizarla a otros proyectos por mera inclusión en el GOW. Alcance de revisión y cierre metodológico.

Tiempo desde la última modificación comprobada del archivo metodológico, distinto del tiempo desde su comprobación o empaquetado. Si faltan reloj/fuente/fecha coherentes, edad no verificada.

- **Responsable exclusivo del frente:** único hilo/instancia vigente en el control, no todo lector o colaborador.
- **Generación de responsabilidad:** contador que invalida permisos operativos anteriores al transferir/liberar; no autentica identidad por sí mismo.
- **Comparación y sustitución atómicas:** reemplazo condicionado a la huella exacta observada, sin que un segundo competidor sobrescriba silenciosamente.
- **Preflight cooperativo:** comprobación previa; no equivale a imposición transaccional de todas las escrituras.


## §TAX · Dirección Taxonómica

| Campo | Valor |
| --- | --- |
| <b>Tipo</b> | Declarativo |
| <b>Tier</b> | Bloqueante |
| <b>Emoji canónico</b> | 📜 |
| <b>Dominio</b> | Gobernanza · Método |
| <b>Ubicación en árbol</b> | ⚙️ Sistema › 📜 Glosario Operativo del Workspace · Canon v1.2 |
| <b>CatFlow</b> | — |

---

## §AC · Acreditación

El GOW se considera poseído cuando:

- <b>(a) Trazabilidad:</b> todo término del §A tiene su marca de procedencia (🎙️/🟦/🌐/✦) y su grupo asignado.
- <b>(b) Reconocimiento:</b> el operador ha ratificado el §RAT con al menos una sesión de revisión.
- <b>(c) Uso:</b> al menos un documento del WS cita el GOW explícitamente como fuente de definición de un término, en lugar de definirlo localmente.

---

## §R · Qué NO es el GOW y riesgos

<b>Qué NO es:</b>

- No es un léxico de proyecto específico (esos pueden existir con términos propios del proyecto).
- No es un diccionario general del español ni de ninguna disciplina.
- No es una lista exhaustiva de todo el vocabulario del WS — solo los términos operativos cuya ambigüedad tiene costo real.
- No reemplaza la definición en contexto cuando un documento necesita precisar un uso local de un término general.

<b>Riesgos:</b>

- <b>Inflación de glosario:</b> añadir términos que no tienen uso cruzado real → mitigación: triage antes de añadir (¿este término se usa en ≥2 documentos de proyectos distintos?).
- <b>Drift semántico:</b> un documento usa un término con significado diferente al del GOW sin declararlo → mitigación: VRC Control 2 detecta ausencia de marca de procedencia; revisión periódica del GOW.
- <b>Glosario desactualizado:</b> el WS evoluciona más rápido que el GOW → mitigación: revisión obligatoria al inicio y cierre de cada ciclo; resolver el delta de inmediato y versionar solo cuando cambie el contenido normativo o terminológico.

---

## §Q · Preguntas abiertas — NO canónicas

1. ¿Qué términos técnicos de EpisTwin/GraphRAG cumplen el criterio de uso transversal y costo de ambigüedad para incorporarse al GOW?
2. ¿Cuál es el mecanismo de propuesta de nuevos términos? ¿Solo el operador los propone, o el agente puede proponer con ratificación posterior?
3. ¿Los términos del Léxico RAP[\[1\]](/p/aa7a418782418265b86b81c496de67f5?pvs=25) deben migrarse al GOW o coexistir?
4. ¿El GOW se versiona con cada término nuevo, o solo con cambios semánticos sustantivos?

---

## §RAT · Registro de ratificaciones

<b>C-GOW-SAM-01 · v1.7 · 2026-10-21.</b> Por instrucción expresa del operador se preserva el GOW preexistente como fuente única, se amplía su uso transversal a los frentes que adquieren este canon, se incorpora «Sam» como abreviatura contextual de «Metaprompt Canónico de Samantha», se añade el contrato de normalización de transcripción y revisión obligatoria en cada ciclo, y se limita explícitamente la equivalencia histórica MDC/Metacanon al contexto local para evitar colisiones con Metacanon de objetos canónicos v1.14. Las entradas previas se conservan; la actualización no equivale a revalidación de todas ellas.

<b>C-GOW-METODOLOGIA-GLOSARIOS-02 · v1.9 · 2026-10-21.</b> Por instrucción expresa se integra el corpus de términos del Glosario Operativo de la Metodología v1.3.1 a este único GOW; las entradas duplicadas se consolidan y los términos de ámbito específico conservan su alcance. El archivo raíz anterior se preserva verbatim como antecedente y pasa a ser un puntero de compatibilidad. Se eleva Metacanon a v1.16 para normar la unicidad de fuente. La página Notion v1.9 fue actualizada desde esta revisión de main y leída de vuelta en el mismo ciclo; se verificaron título, versión y contenido incorporado. Esta escritura es puntual y no instala sincronización perpetua. Por instrucción expresa del operador, `SeryMente/metodologia/main` pasa a ser la fuente canónica preponderante del GOW y de la documentación metodológica compartida. Se conserva el contenido heredado y se modifica la declaración de fuente para que Notion sea un espejo subordinado. La entrada «Metacanon de objetos canónicos» se actualiza a v1.15. La página Notion se actualizó desde la revisión canónica de main y se leyó de vuelta en este ciclo para comprobar título, v1.8, precedencia del repositorio y entradas operativas. Esta comprobación puntual no instala sincronización automática futura.

<b>C-METODOLOGIA-CONTINUIDAD-02 · v1.6.</b> Se registran las denominaciones y la continuidad por frentes ratificadas por el operador, con arranque diferenciado por plataforma. Las entradas previas, incluida la definición única de Ética, permanecen íntegras.

<b>C-POSIBILIDAD-SITUADA-01 · v1.5.</b> Por instrucción expresa del operador se denomina y canoniza una premisa depurada en el objeto existente de Ética. Este glosario registra únicamente su nombre y remisión transversal; no duplica la definición, no universaliza la premisa y no revalida entradas históricas. El dictado original permanece íntegro en Ética; no se incorpora «locura» como definición clínica. Ancla: sesión 3fd5d4a3-b250-807a-8bd7-00a9fde7ee9d.

<b>C-CONTRATO-COGNITIVO-01 · v1.4.</b> Por orden expresa del operador se registra «Contrato cognitivo del grafo» y su pregunta rectora; definición de proyecto reside en el objeto canónico del frente grafo de Khora. No se canoniza como ciencia la reflexión autobiográfica, clínica o espiritual que acompaña el dictado; no se amplían permisos ni se revalidan entradas históricas. Ancla de evento de la sesión 3fd5d4a3-b250-807a-8bd7-00a9fde7ee9d, mensaje 1189; no se inventa fecha de calendario.

<b>2026-10-17 · v1.3.</b> Incorporado el nombre actual Otro Gran Programa y la equivalencia recuperable con Otro Buen Programa por instrucción explícita del operador. No modifica los demás acuerdos ni revalida el contenido histórico.

Consolidación documental v1.2 · 2026-10-16, autorizada mediante la solicitud de unificar las cuatro versiones en Workspace Actual. Recupera de Workspace Numb v1.1 la convención ya ratificada «Coordinación directa entre hilos» y conserva las incorporaciones de Workspace Actual sobre Remote Desktop Commander y el Paquete de Tercer ámbito; no amplía permisos ni ratifica términos nuevos.

<b>Aprobación:</b> canonizado por orden expresa del operador (Black Sheep) · 2026-07-20 — construcción progresiva en sesiones de diseño de Canon. <b>Proceso:</b> Ruta A · v1.0 · 2026-07-20.

<b>Evidencia de Verificación de Identidad:</b> Test de Identidad <code>APROBADO</code> — con <code>[OBJETO]</code>, el párrafo describe únicamente el repositorio canónico de términos operativos del WS con condición de uso cruzado; ningún otro Canon del WS cumple esa función (el MDC norma cómo construir un Canon; los demás Cánones usan sus términos) · Test de Genericidad <code>APROBADO</code> — no aplica a cualquier Canon: nombra específicamente un glosario operativo transversal con condición de uso cruzado y fuentes con marcas de procedencia · Veredicto ✅ <code>IDENTIDAD VERIFICADA</code> · 2026-07-21.

<b>VRC aplicado:</b> <code>VRC v1.1 · 2026-07-21 · NO APTO</code> — Controles 🔒 fallidos: C1 (Callout no agente-legible · §SUM ausente · §IX ausente) · C3 (§TAX ausente) · C5 (§RAT sin evidencia de Identidad ni Ruta de proceso). Control 🟡 fallido: C4 (§PRO autónoma podada · §AC no contemplada en Declarativo). Acciones correctivas: reemplazar callout por formato 📍 · añadir §SUM callout 💊 · añadir §IX · añadir §TAX · absorber §PRO en callout · añadir Tests de Identidad y Ruta A en §RAT. Re-arropado pendiente antes de primera corrida RAP.

| Elemento | Estado | Fecha | Operador |
| --- | --- | --- | --- |
| §EI · Párrafo Eidético | Premisa | 2026-07-20 | Black Sheep |
| Grupo 1 · Objetos del WS (Canon, Aserto, estados) | Premisa | 2026-07-20 | Black Sheep |
| Grupo 2 · Métodos (MDC, MDP, RAP, VRC, GOW) | Premisa | 2026-07-20 | Black Sheep |
| Grupo 3 · Estructura de Cánones (§EI, §AC, Poseído, etc.) | Premisa | 2026-07-20 | Black Sheep |
| Grupo 4 · Demográficos y FCPs (SEA, IAR, RES, PED, PEI) | Premisa | 2026-07-20 | Black Sheep |
| Grupo 5 · Convenciones operativas (WS, verbos vetados, bypass) | Premisa | 2026-07-20 | Black Sheep |
| §AC · Acreditación | Premisa | 2026-07-20 | Black Sheep |
| Grupo 5 · Doble Candado / Alto nivel / Prueba del mapa | Premisa | 2026-07-20 | Black Sheep |
| Grupo 6 · Canon LISA (L0, RE, ACR, compuertas, regímenes, guardas) | Premisa | 2026-07-20 | Black Sheep |
| Grupo 5 · PDCP (término nuevo) + corrección de drift PDPC→PDCP (Grupo 6) | Premisa | 2026-07-20 | Black Sheep |
| Grupo 7 · Convención de Código Firmado (Cabecera, Código huérfano, Regla de contacto, AP-ING v2.0) | Premisa | 2026-07-20 | Black Sheep |
| Grupo 8 · Protocolo FIAT (FIAT, Génesis, Instancia, clases de L0, Banner de ejecución, Exclusividad de entrada) | Premisa | 2026-07-21 | Black Sheep |
| Grupo 8 · E-02 (Extracción Protegida · CCA · Cobertura y Compleción Asistida) | Premisa | 2026-07-21 | Black Sheep |
| Grupo 8 · E-03 (Gramática de dependencias obligatorias) | Premisa | 2026-07-21 | Black Sheep |
| Grupo 8 · E-04 (Candado de No-Divergencia · Estado ⏸ SUSPENDIDA) + L0-001 Firmado (Régimen Mixto) | Premisa | 2026-07-21 | Black Sheep |
| Grupo 5 · Modelo Operativo (nombre canónico del modelo de no frontera) | Premisa | 2026-07-21 | Black Sheep |
| Grupo 4 · FDP + TL-01 (Facultad Determinista de la Prótesis, contraparte estructural de FCP) | Premisa | 2026-07-21 | Black Sheep |
| Grupo 5 · Cora = Khora (equivalencia terminológica del nombre de producto) | Premisa | 2026-07-21 | Black Sheep |
| Grupo 5 · Formas No Abreviadas (Anti-Sigla Opaca) · \[P358\] del Metaprompt v320 | Premisa | 2026-07-21 | Black Sheep |
| Grupo 5 · Dimensión del núcleo (firmada / candidata) — equivalencia con esquemas de recuperación aumentada por grafos de conocimiento | Premisa | 2026-07-22 | Black Sheep |
| Grupo 5 · Formas No Abreviadas — compuerta falsable (\[P358\] v322; Lista de Familiaridad Declarada revertida por rectificación) | Premisa | 2026-07-22 | Black Sheep |
| Grupo 6 · Fuente de Verdad Documental (Canon LISA v1.2 §EI.11) · Grupo 7 · etiqueta @ua (Convención de Código Firmado v1.1) | Premisa | 2026-07-22 | Black Sheep |
| Grupo 9 · Protocolo de Construcción Auditada (PCA) — bautizo confirmado, canon creado en incubación v0.1 (Ruta B), términos Sobre de Despacho / Sobre de Retorno / khora-audit | Premisa | 2026-07-22 | Black Sheep |
| Grupo 4 · RES — corrección de discrepancia: «Resonancia de Evidencia Selectiva» (corpus 2026-07-20) → «Redacción Enraizada en Sentido» (dictado del operador 2026-07-21 20:12, fila L0-002 del Génesis). Autorización expresa del operador 2026-07-23 («Grupo A. Autorizado»). Definición teleológica pendiente de re-ratificación. | Premisa | 2026-07-23 | Black Sheep |
| Grupo 8 · IE (Insight Empírico) — término canonizado por dictado del operador; unidad de recolección del expediente de incubación (§RIESGOS del Protocolo FIAT), con adjudicación obligatoria al cierre de sesión (E-06) | Premisa | 2026-07-23 | Black Sheep |
| Grupo 4 · GRP (Grafo de Relación Personal) — término normado por dictado del operador, junto con el insight empírico que declara la Narrativa Emergente del Génesis como propiedad funcional temporal del WS | Premisa | 2026-07-23 | Black Sheep |
| Grupo 5 · Julia = Jules (equivalencia terminológica del agente asíncrono de codificación) — normado por dictado extraoficial del operador (nota extraoficial · sesión de Lilo); propagación a repositorio, fuentes de verdad del núcleo y tabla Génesis diferida a canales legales (Exclusividad de entrada · esclusa FIAT) | Premisa | 2026-07-23 | Black Sheep |
| Grupo 5 · Proyecto Oficial (PO) — único proyecto oficial del WS, reconocido por capa 1 y capa 2; dictado del operador (2026-07-23, sesión FIAT L0-001) | Premisa | 2026-07-23 | Black Sheep |
| Grupo 4 · Operaciones visoespaciales de la cognición — inventario de esquemas de imagen como gramática visual candidata para la proyección visual del GRP; brainstorm en incubación, sin estatus de FCP (sesión de ideación 2026-07-24) | Premisa | 2026-07-24 | Black Sheep |
| Grupo 4 · Afirmación Competitiva — aserto falsable, fechado y acotado sobre la posición de Khora, enumerado en registro único con sensor de vigencia (Vigía de la Ventana) y vigilancia de ampliación; sin sigla por colisión con §AC/ACR — instrucción expresa del operador (2026-07-24, sesión de diseño del Vigía) | Premisa | 2026-07-24 | Black Sheep |
| Grupo 5 · MP / PRIUS-MP — redefinición del Metaprompt Canónico de Capa 1: residencia migrada a §EI.1 del Canon Sesión PRIUS (era PRIUS, 2026-07-23); convención pre-PRIUS «Workspace (documento) = Metaprompt = System Prompt · Abreviaturas: MP · SY» eliminada y reemplazada por esta entrada. Dictado del operador (2026-07-24, sesión PRIUS-003). | Premisa | 2026-07-24 | Black Sheep |
| Grupo 2 · SSC (Sustrato de Sesión Canónica) — capa abstracta base de toda sesión formal del WS; 8 componentes canónicos SSC-01 a SSC-08; nombre propuesto por Samantha y ratificado por el operador (2026-07-24, PRIUS-003). Canon creado en incubación v0.1. | Premisa | 2026-07-24 | Black Sheep |
| Grupo 2 · FN (Forja Normativa) — mecanismo de enmienda deliberado e intencional dentro de sesión canónica; contraparte dirigida del IE (Insight Empírico); ambos fuente de verdad para el L0 del Canon/Artefacto. Dictado del operador (2026-07-24, PRIUS-003); nombre aprobado tras descarte de DNS por conflicto con infraestructura de redes. | Premisa | 2026-07-24 | Black Sheep |
| Grupo 5 · Un solo servidor de desarrollo por directorio (Next 16) — convención de entorno verificada en el ticket FIX-DICTADO (colisión de puerto 3000 y rechazo de segundo <code>next dev</code> por Turbopack); autorización expresa del operador | Premisa | 2026-08-05 | Black Sheep |
| Grupo 5 · Remote Desktop Commander (RDC) — nombre ratificado; referente Desktop Commander Remote MCP y arranque contrastados con conversaciones y documentación oficial; no autoriza acceso remoto | Nombre ratificado; referente contrastado | 2026-10-11 | Black Sheep |