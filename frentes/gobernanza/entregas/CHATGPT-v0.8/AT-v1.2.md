# Articulación Trazable (AT) · definición operativa endurecida v1.2

**Estado:** definición operativa endurecida v1.2; propuesta operativa no canonizada como anexo independiente del DUG. Deriva de AT v1.1, que se conserva como antecedente íntegro.  
**Frente responsable:** Gobernanza · `frentes/gobernanza/`  
**Evento:** C-GOBERNANZA-DOBLE-CORRESPONSABILIDAD-01  
**Ciclo:** C-20261029-5510927B  
**Fuente normativa cotejada:** DUG v375 · NX-375m · `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html` · blob `c993a59163c2c163b17b599a003919b53c5cf6a8`  
**Metacanon:** 1.26 · **GOW:** 2.15 · **taxonomía:** 1.3 · **principios/anexos:** 43/21.

## 1. Propósito

Articulación Trazable (AT) es el mecanismo operativo responsable de analizar y realizar, dentro de las autorizaciones y restricciones aplicables, los cambios conceptuales de la metodología Ser y Mente que deban articularse entre sus niveles de OCP, su gobierno normativo y los documentos o materiales dependientes.

Su necesidad concreta es evitar que un cambio trabajado desde un ámbito, frente u OCP quede aislado, se materialice en un nivel incorrecto, contradiga la jerarquía del DUG o deje sin actualizar destinos que realmente dependan de él. AT identifica dónde debe producir efecto el cambio, dónde no debe producirlo y conduce su realización verificable.

## 2. Alcance delimitado de v1.1

AT v1.1 se limita a la articulación longitudinal de **cambios conceptuales y metodológicos** dentro de Ser y Mente: definiciones, taxonomía, ámbitos, contratos compartidos, reglas del método y sus materializaciones dependientes.

No es un sistema general para administrar cualquier cambio de software, producto, infraestructura, proyecto o proceso externo. Tampoco convierte toda modificación local en una enmienda del DUG. Un cambio que solo afecta un artefacto local permanece en su OCP cuando no exista una dependencia conceptual o normativa superior que requiera propagación.

AT no sustituye al DUG, a Metacanon, al GOW ni a los OCP de los niveles afectados. No crea autoridad, permisos, titularidad, capacidades ni sincronización. Cuando LISA sea aplicable, conserva su función de anclar intención y trazabilidad de requisitos; la cadena de LISA no se confunde con los niveles OCP ni los reemplaza.

## 3. Distinciones estructurales obligatorias

AT debe mantener separadas tres dimensiones que pueden relacionarse, pero no son equivalentes:

1. **Gobierno normativo del DUG.** Los principios son el único elemento de gobierno directo y conservan su orden y precedencia. Los anexos desarrollan o precisan principios bajo subordinación; ningún anexo tiene autoridad de gobierno independiente. El DUG HTML en `main` es la fuente normativa única. Su contenido humano precede a la representación estructurada, que es derivada.
2. **Taxonomía conceptual y OCP.** La Metodología, en sentido general y abstracto, es el OCP raíz. La organización, cada repositorio, cada frente, cada ámbito funcional y cada subámbito definido son OCP de su propio nivel. OCP no es un nivel taxonómico adicional. La categoría conceptual Ámbitos no se convierte por ello en un nivel de la cadena de infraestructura.
3. **Materialización física.** La ubicación documental, las carpetas y las rutas se resuelven para cada OCP según su autoridad, necesidad, control y recuperabilidad. No existe equivalencia obligatoria uno-a-uno entre concepto y directorio. Un ámbito no requiere una carpeta por definición.

La jerarquía documental de anexos (por ejemplo, ART-015, sus anexos hijos y los anexos de nivel documental 3) tampoco equivale a la jerarquía conceptual de OCP. Los números de nivel de anexos describen la subordinación documental de esos anexos, no la posición funcional de los conceptos que describen.

## 4. Flujo operativo único

AT v1.2 se materializa como **un mecanismo integrado con etapas internas**, no como una colección de submódulos. Las etapas comparten un mismo cambio de origen, un mapa de dependencias, compuertas de autorización y un registro de resultado; no se han demostrado estados, responsables o interfaces autónomos que justifiquen módulos separados.

### Etapa A · Adquirir origen y autoridad

- Conservar la instrucción o decisión de origen literalmente como vector semántico, con procedencia y folio de ciclo; separar el texto íntegro, los segmentos trazables y la interpretación derivada. Cada cambio propagado por AT debe poder justificarse mediante uno o más vectores semánticos de origen, o declararse explícitamente sin anclaje suficiente y quedar bloqueado/pendiente.
- Identificar el OCP donde nace el trabajo y el objeto conceptual que se pretende cambiar.
- Leer desde `SeryMente/metodologia/main` la versión vigente del DUG y las secciones de Metacanon/GOW pertinentes; leer los README, núcleo, control y fuentes del OCP afectado.
- Registrar versión, revisión o SHA observados. Si la fuente necesaria no puede verificarse, declarar `METODOLOGÍA NO VERIFICADA` y no ejecutar acciones que dependan de esa vigencia.

### Etapa B · Clasificar el cambio y su nivel correcto

Determinar si la propuesta afecta a uno o varios de estos destinos, sin presumir que todos deben cambiar:

- **Principios:** solo cuando el cambio introduce, altera o elimina una obligación de gobierno general. El principio se incorpora o modifica en la lista ordenada del DUG, respetando su precedencia.
- **Anexos:** cuando el cambio desarrolla una regla, taxonomía, estructura o procedimiento subordinado a uno o más principios existentes. Se conserva su padre, nivel documental, identificador, enlaces y retorno. No se utiliza un anexo para crear autoridad independiente.
- **Taxonomía y definiciones conceptuales:** cuando cambia la identidad, clase, alcance, relación o definición de una entidad o ámbito. Se actualizan los anexos taxonómicos que correspondan y las definiciones GOW necesarias.
- **OCP del ámbito, frente u otra unidad:** cuando el contrato conceptual aprobado debe reflejarse en el núcleo, README, instrucciones, controles o materiales del objeto correspondiente.
- **Materialización física o proyecciones:** solo cuando la forma de persistencia, ruta, índice o representación derivada tenga que cambiar para mantener consistencia y recuperabilidad.

El GOW fija vocabulario y equivalencias; no crea por sí mismo normas ni permisos. La representación estructurada del DUG refleja el contenido humano; no constituye una fuente normativa paralela.

### Etapa C · Trazar la propagación longitudinal

Construir una matriz breve de vector semántico de origen → regla aplicable → nivel/destino → efecto requerido. Cada vector debe enlazar a los resultados y cada resultado debe devolver el enlace a los vectores que lo justifican. La matriz debe distinguir:

- destinos que deben modificarse;
- destinos que solo requieren comprobar compatibilidad;
- destinos que permanecen sin cambio, con motivo;
- destinos cuyo efecto es posible pero todavía no está demostrado;
- destinos bloqueados por falta de autorización, permisos, titularidad, información o precondiciones.

El recorrido comienza en la autoridad superior y desciende por las dependencias reales: principios aplicables → anexos subordinados → taxonomía/definiciones y método → OCP de los ámbitos o frentes concernidos → materializaciones y artefactos dependientes. La secuencia se adapta a la clase del cambio: no se inserta una enmienda al principio si la necesidad se resuelve correctamente mediante un ajuste taxonómico o un anexo subordinado.

No propagar por simetría, por semejanza nominal ni a todos los repositorios. Identificar consumidores y dependencias demostrables. La inspección puede ser amplia; las modificaciones deben limitarse a los destinos necesarios.

### Etapa D · Aplicar autorización y restricciones por destino

Antes de realizar cada cambio, comprobar autoridad, titularidad, control, permisos, precondiciones y compuertas del destino:

- Toda modificación normativa al DUG requiere confirmación activa y explícita del operador **antes de escribir**, conforme a P005.
- Las modificaciones permanentes en otros objetos requieren la autorización expresa que corresponda, conforme a P024 y a las reglas particulares del OCP.
- Las colisiones de responsabilidad se resuelven mediante P037 y Metacanon §42, distinguiendo `TRANSFER_RESPONSIBILITY` (sustituye titular) de `ADD_CO_RESPONSIBLE` (añade una segunda sesión sin desplazarlo). La segunda operación exige autorización expresa, un único control autoritativo, exactamente un responsable activo antes de la operación y compare-and-swap/read-back; se bloquea una tercera sesión. Nunca se sobrescribe un control concurrente.
- Las modificaciones estructurales respetan la compuerta preescritura P022 y el criterio de no duplicación P025.
- Ninguna autorización para un destino se extiende por inferencia a otro.

AT es responsable de realizar los cambios que el análisis determine pertinentes **en la medida en que cada destino los permita**. Si un destino prohíbe o no autoriza el cambio, AT lo limita o bloquea, registra la razón y solicita la decisión que falte. No elude la compuerta ni presenta como ejecutado un cambio que solo propuso.

### Etapa E · Realizar en orden de dependencia

Cuando todas las compuertas necesarias estén satisfechas:

1. Aplicar primero los cambios autorizados en la fuente normativa o conceptual superior que corresponda.
2. Mantener el DUG en su único HTML canónico; actualizar su contenido humano, metadatos/versionado, enlaces y representación estructurada derivada de forma coherente.
3. Actualizar los anexos subordinados, conservando principio padre, niveles documentales, identificadores y navegación.
4. Ajustar las entradas GOW solo cuando cambien términos o definiciones.
5. Propagar a los OCP y materiales aguas abajo que dependan realmente del cambio, respetando su fuente de estado, control y ruta propios.
6. Para `ADD_CO_RESPONSIBLE`, conservar la sesión titular en el mismo control y añadir la segunda identidad como corresponsable; mantener compatibilidad de los campos heredados que identifican al titular primario.
7. Actualizar espejos externos únicamente cuando exista autorización, acceso y un procedimiento de verificación independiente. Nunca presumir sincronización.

Si una etapa queda bloqueada, AT no ejecuta el destino bloqueado. Puede continuar los cambios independientes que sí estén autorizados, dejando clara la propagación parcial y sus límites.

### Etapa F · Verificar y registrar

Por cada destino modificado, leer de vuelta la revisión escrita y cotejar el contenido pertinente. Verificar, según corresponda:

- principio afectado, posición y orden de la lista, precedencia y referencias;
- anexo, identificador, nivel documental, padre, principio(s) relacionado(s), enlaces y retornos;
- coherencia entre taxonomía conceptual, definiciones GOW y alcance de los OCP;
- separación entre identidad conceptual y materialización física;
- consistencia de la representación estructurada con el contenido humano;
- para corresponsabilidad, preservación del titular original, cardinalidad exacta de dos sesiones activas, folios y UUIDv7 locales distintos, generación común y ausencia de una tercera entrada;
- integridad de referencias, rutas, controles y materiales realmente dependientes;
- estado de cada destino sin convertir una inspección en prueba de modificación.

Registrar para cada destino uno de estos resultados: **SIN CAMBIO JUSTIFICADO**, **PENDIENTE**, **BLOQUEADO**, **INTENTO NO CONFIRMADO**, **EJECUTADO NO VERIFICADO** o **VERIFICADO**. Añadir autorización, fuente/revisión, evidencia, límite y siguiente paso. Solo la lectura de vuelta y el cotejo permiten declarar VERIFICADO.

## 5. Registro mínimo de articulación

Cada cambio sustantivo atendido por AT deja una matriz recuperable con estos campos:

| Campo | Contenido |
|---|---|
| Vector semántico | ID de fuente, folio conversacional/ciclo, segmento literal y procedencia |
| Origen e intención | Instrucción/decisión, interpretación separada y OCP de origen |
| Base normativa | DUG, Metacanon, GOW y revisiones consultadas |
| Clasificación | Principio, anexo, taxonomía, definición, OCP o materialización |
| Regla aplicable | Principios y disposiciones subordinadas pertinentes |
| Destino y nivel | OCP/artefacto concreto y su posición estructural |
| Impacto | Cambia, comprobar, sin cambio, incierto o bloqueado; con motivo |
| Autorización | Referencia y alcance exacto, o compuerta pendiente |
| Realización | Acción efectuada y revisión de destino |
| Verificación | Read-back, cotejo y evidencia disponible |
| Estado | Uno de los estados definidos en la etapa F |

Este registro es una herramienta de trazabilidad operativa; no crea otro canon, otra lista de normas ni una fuente paralela de estado.

## 6. Criterios de aceptación de AT v1.0

AT v1.2 satisface su propósito cuando, ante un cambio conceptual concreto, permite demostrar que:

1. se identificó su origen, vector semántico literal, interpretación separada, OCP y autoridad vigente;
2. cada cambio y resultado puede rastrearse bidireccionalmente hasta los vectores que lo justifican;
3. se clasificó correctamente el nivel al que pertenece, sin confundir principios, anexos, conceptos, OCP ni rutas físicas;
4. se determinó si el cambio requiere gobierno directo, desarrollo subordinado, ajuste taxonómico/GOW o solo actualización local;
5. se respetó el orden vigente de los principios y la subordinación documental de los anexos;
6. se identificaron los destinos que cambian, los que permanecen intactos y los que están bloqueados, con justificación;
7. cada escritura se hizo solo tras satisfacer la autorización y las compuertas particulares;
8. AT coordinó y realizó los cambios permitidos y verificó por lectura de vuelta sus resultados;
9. no se afirmó canonización, sincronización, propagación global ni verificación que no estuviera respaldada por evidencia.

## 7. Validación conceptual de los dos casos requeridos

### Caso positivo · cambio conceptual que debe articularse

**Antecedente real:** C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01. A partir de una instrucción autorizada, se distinguió la taxonomía conceptual de la infraestructura y se canonizó Propósito como elemento conceptual asociado al alcance de un FT. El cambio se reflejó en ART-015, ART-019, ART-020/021, Metacanon §§46/51, el GOW y la representación estructurada. No se añadió un principio ni un anexo, porque el cambio no introducía una nueva obligación de gobierno general. La lectura de vuelta del DUG fue exacta; el JSON incrustado parseó y el JavaScript pasó compilación sintáctica aislada. No se ejecutó renderizado de navegador ni auditoría dinámica completa de enlaces.

**Recorrido que AT debe reproducir:** clasificar la petición como cambio taxonómico/conceptual; conservar la autorización; modificar los anexos y definiciones que expresan esa taxonomía; mantener los principios existentes como gobierno superior; actualizar GOW/proyección derivada y verificar los destinos afectados. No imponer una carpeta por la existencia del concepto.

**Resultado de validación:** recorrido coherente con la estructura vigente y con el antecedente registrado. Es una comprobación retrospectiva de diseño, no una ejecución automatizada de AT v1.0.

### Caso negativo · propagación que debe limitarse

**Estado vigente observado:** Tareas tiene un diseño y materiales locales en incubación, incluido un estándar mínimo candidato v0.2, pero el DUG v362 mantiene como ámbitos funcionales canónicos Persistencia documental y Gestión conversacional. ART-015/020 no incorporan Tareas a la lista canónica.

**Decisión de AT:** el hecho de que exista `ambitos/tareas/`, un diseño o un estándar local no autoriza a promover Tareas al DUG/GOW ni a modificar la lista de principios. La propagación hacia el canon queda **BLOQUEADA** hasta que exista una propuesta clasificada, una autorización explícita para el cambio normativo y la aprobación correspondiente. El trabajo local que no dependa de esa promoción puede continuar dentro de las compuertas de su propio OCP.

**Resultado de validación:** el límite está determinado por la fuente vigente y por P005/P024. Es una comprobación de escritorio sobre el estado actual, no una prueba de ejecución automática.

## 9. Decisión de arquitectura y límites de evolución

La v1.0 utiliza un solo mecanismo coordinador con etapas A–F y un único registro de articulación. La diversidad de funciones no demuestra por sí misma la necesidad de submódulos: análisis, clasificación, impacto, autorización, realización y verificación operan sobre el mismo cambio y la misma cadena de dependencias.

La posible descomposición se difiere. Solo se reabrirá si el uso real demuestra responsabilidades con ciclo de vida, estado, titularidad o contrato de interfaz independientes. No se crea un submódulo por verbo, por simetría o por anticipación.

## 10. Trazabilidad semántica como fundamento de AT

La trazabilidad semántica es una **capacidad interna y fundamental de AT**, no un ámbito funcional transversal independiente ni, en el diseño objetivo de AT, un módulo subordinado a Gestión conversacional. Su objeto específico es conservar el anclaje causal y justificativo de los cambios que AT analiza, decide propagar y realiza: cada cambio debe remontarse a uno o varios vectores semánticos originados en instrucciones, decisiones o restricciones verbatim del operador. **Para los efectos que el sistema realiza por instrucciones del operador, esos vectores son la fuente de verdad de la intención y del requisito de origen.** No sustituyen, sin embargo, la jerarquía normativa del DUG ni las compuertas de autorización: un vector no concede por sí solo permiso para modificar un principio, anexo u OCP.

El contrato distingue tres artefactos que convergen, pero no se fusionan:

1. **Persistencia documental:** conserva los originales y derivados documentales que el frente recibe o produce —incluidos adjuntos, fuentes, manifiestos, evidencias y documentos de trabajo— conforme a ART-022/014. Es la capacidad de custodia y recuperación documental.
2. **Registro conversacional:** conserva el texto literal visible de cada ciclo registrado como pareja entrada del operador (`-E`) y salida visible del modelo (`-S`), con identidad local estable de conversación, folio de ciclo, secuencia, repositorio, frente y referencia recuperable al diálogo. Es la fuente documental de la conversación y su índice de localización.
3. **Trazabilidad semántica de AT:** selecciona dentro de las entradas los segmentos verbatim pertinentes, los clasifica como vectores semánticos y enlaza cada vector con las decisiones, impactos, cambios, destinos, pruebas y resultados que justifica. No sustituye al registro íntegro ni a la custodia documental.

La convergencia consiste en que los registros conversacionales y los documentos adjuntos son objetos que deben persistirse y recuperarse; AT consume esas fuentes y enlaza semánticamente los cambios. No implica que Persistencia documental, Registro conversacional y AT sean un único ámbito, ni que la ruta física de un registro determine su titularidad conceptual. Los registros de conversación pueden permanecer físicamente en el OCP de Gestión conversacional mientras se resuelve la alineación normativa de la clasificación de Trazabilidad semántica.

### 9.1 Vector semántico y relación bidireccional

- El texto íntegro de cada entrada se conserva sin corrección, normalización ni resumen en el registro conversacional.
- De esa entrada se extraen uno o varios segmentos literales pertinentes. Cada segmento recibe un identificador estable y una clasificación; el extracto no reemplaza el original.
- El vector apunta a los cambios, anexos, principios, OCP, archivos y evidencias que derivan de él.
- Cada cambio o resultado incorpora referencias inversas a los vectores que lo justifican. Si una pieza no puede llevar metadatos propios, su registro de cambio o índice canónico debe contener el enlace inverso.
- Una instrucción puede originar varios cambios y un cambio puede responder a varios vectores. Los vínculos parciales, inferidos, pendientes o no demostrables se marcan como tales; no se inventa causalidad.
- La relación debe recorrer los niveles aplicables: vector → regla/principio → anexo subordinado → definición/taxonomía → OCP afectado → materialización/resultado; y desde cada resultado debe poder recorrerse el camino inverso hasta el vector original.
- Los cambios que no puedan justificarse suficientemente en los vectores quedan sin propagación automatizada/ejecutiva hasta aclaración o ratificación. El modelo puede proponer una interpretación, pero no reescribe el vector ni eleva una inferencia a instrucción literal.

### 9.2 Contrato mínimo de registro

Cada vector semántico enlazado a un cambio registra, como mínimo: `trace_id`; `source_ref` al registro de entrada; `conversation_id` local; `cycle_folio`; `literal_excerpt`; clasificación; interpretación derivada separada; referencias a principios/anexos y versiones consultadas; OCP y destinos; resultado(s); autorización aplicable; estado de vínculo y verificación. El registro conversacional conserva, por separado, el texto íntegro y la pareja E/S.

La trazabilidad se declara **VERIFICADA** solo cuando la fuente literal, el enlace de ida, el enlace de retorno y los resultados referenciados fueron leídos de vuelta y cotejados. Si solo se guardó la fuente, el vínculo está **PENDIENTE**; si no existe anclaje suficiente, queda **NO VERIFICADO/BLOQUEADO**.

### 9.3 Compatibilidad con la integración futura de LISA

AT v1.1 debe ser compatible con el Canon LISA y con la futura integración de LISA en la metodología, sin anticipar ni simular esa integración:

- El vector semántico conserva la instrucción de primera mano y su procedencia; no se confunde automáticamente con un L0 ratificado.
- Cuando LISA aplique, AT referencia el L0 correspondiente y, si procede, la cadena L0 → REQ → ACR → resultado/código. Los elementos derivados se identifican como derivados.
- El modelo no inventa, firma ni ratifica un L0 en nombre del operador. Se respetan las compuertas de ratificación definidas por el Canon LISA/FIAT cuando se integren.
- Un Documento Fuente Aprobado, si existe, complementa el vector/L0 con contenido mecánico verificable; no sustituye la intención del operador ni se presume aprobado por estar archivado.
- La matriz de impacto de AT complementa la cadena de especificación LISA; no crea una cadena de autoridad paralela. Los cambios upstream activan revisión de compatibilidad de dependencias downstream.
- La integración completa de LISA, FIAT, LSV, MAT u otros instrumentos sigue siendo trabajo futuro sujeto a sus propias autorizaciones y validaciones. AT v1.1 solo define los puntos de enlace y preserva la compatibilidad.

### 9.4 Relación con el DUG y estado de alineación

El DUG v362 actualmente ubica Trazabilidad semántica como módulo interno de Gestión conversacional en ART-020/024. La clasificación conceptual precisada por el operador para AT v1.0 requiere revisar esa ubicación: Registro conversacional permanece en Gestión conversacional; Trazabilidad semántica pasa a ser capacidad fundamental de AT. Persistencia documental sigue siendo un ámbito funcional transversal paralelo, con el que los registros conversacionales convergen en su custodia.

Esta corrección se documenta aquí como definición operativa propuesta. **No se modifica el DUG ni el GOW sin autorización normativa expresa previa conforme a P005.** Hasta que esa enmienda se autorice y se materialice, el DUG vigente conserva precedencia y la reclasificación se considera propuesta pendiente de alineación normativa.


### 10.5 Vector semántico: fuente de verdad de intención y requisito

Para los efectos que el sistema realiza por instrucciones del operador, **el dictado verbatim es la fuente de verdad de la intención y del requisito de origen**. Esta regla se aplica con las siguientes distinciones:

1. **Fuente original:** mensaje íntegro del operador, conservado como entrada E en el registro conversacional. Es inmutable como evidencia; no se corrige, normaliza, resume ni sustituye.
2. **Vector semántico:** segmento literal, continuo y exacto de la fuente que contiene una instrucción, decisión, restricción, condición o criterio relacionado con el trabajo. Debe poder localizarse dentro de la fuente por su referencia; el extracto no puede contener palabras corregidas o añadidas.
3. **Interpretación derivada:** significado operativo que AT atribuye al vector. Se registra aparte, nunca dentro del campo verbatim, con su tipo: DIRECTA, IMPLICACIÓN CLARA, INFERENCIA CONSERVADORA o AMBIGUA.
4. **Requisito operativo:** formulación estructurada de lo que se debe conseguir, derivada del vector y enlazada a él. No sustituye al vector ni adquiere autoridad independiente.
5. **Contexto:** segmento útil que no contiene requisito, decisión o restricción. Se conserva como contexto no normativo y no se convierte por sí mismo en trabajo.

Una entrada puede contener varios vectores y varios segmentos contextuales. Cada vector recibe identidad estable separada. No se fuerza un único resumen para una entrada con instrucciones distintas.

**Umbral de actuación:** una instrucción directa o una implicación clara permite definir el efecto dentro del alcance autorizado. Una inferencia conservadora solo puede orientar propuestas o acciones reversibles y de bajo impacto que ya estén autorizadas. Una ambigüedad que cambie el objetivo, el destino, la autoridad, el alcance o el criterio de aceptación bloquea la modificación dependiente; se formula una única pregunta concreta cuando no exista una interpretación conservadora segura. La urgencia no permite convertir una inferencia en dictado.

Si un cambio no tiene un vector semántico suficiente, AT no lo presenta como derivado del operador. Debe identificar una fuente alternativa legítima —principio, anexo, decisión autorizada o requisito técnico— y registrarla expresamente; si no existe, el cambio queda PENDIENTE/BLOQUEADO.

### 10.6 Convergencia funcional y separación de custodia

Los tres componentes convergen en un mismo circuito de persistencia y recuperación, pero conservan contratos distintos:

| Componente | Qué conserva o hace | Fuente/índice | Límite |
|---|---|---|---|
| Persistencia documental | Custodia originales, adjuntos, documentos derivados, manifiestos y evidencias. | OCP autorizado, estructura y manifiesto conforme a ART-022/014. | No reemplaza el registro de conversación ni extrae por sí sola intención. |
| Registro conversacional | Conserva la pareja literal entrada del operador E / salida visible del modelo S por ciclo, identidad local, folios y referencias al frente/repositorio. | Registro maestro de conversaciones y diálogo JSONL. | No implica captura automática, sincronización omnicanal ni recuperación de mensajes no disponibles. |
| Trazabilidad semántica de AT | Extrae vectores exactos de entradas, los clasifica y relaciona con reglas, destinos, cambios, resultados y evidencia. | Registro de trazas consumido por AT; cada traza apunta a su fuente y resultados. | No sustituye la fuente íntegra ni concede autoridad o permisos. |

La custodia documental de un adjunto sigue ART-022/014; la custodia de un ciclo conversacional sigue su esquema E/S. Ambos son registros persistentes recuperables, pero no se mezclan ni se fuerza a una conversación a usar el manifiesto de adjuntos como sustituto de su esquema. Los registros pueden residir físicamente en el OCP que hoy los materializa; la ruta física no cambia su clasificación conceptual.

AT debe consumir ambos tipos de fuente cuando sean pertinentes: el dictado conversacional para intención y requisitos; los documentos originales aprobados para contenido mecánico y verificable cuando corresponda. Un documento adjunto no se convierte automáticamente en Documento Fuente Aprobado LISA.

### 10.7 Política de conservación y recuperación de instrucciones

- Antes de pedir al operador que repita una instrucción, la instancia debe buscarla en main, en el registro conversacional, en las fuentes verbatim y en el índice de trazabilidad aplicable.
- Una instrucción que ya exista literal y recuperable no se vuelve a solicitar ni se reconstruye desde memoria o resúmenes.
- Si se encuentra el texto, se usa la referencia estable y se conserva el origen; si solo existe un extracto histórico, se informa que la cobertura es parcial y no se finge que se recuperó la entrada completa.
- Las fuentes y trazas se conservan de forma acumulativa. Una corrección posterior se incorpora como nueva entrada que referencia y supersede la anterior; no se sobrescribe ni elimina silenciosamente el original.
- Si una fuente deja de estar disponible, AT registra la laguna, el último punto recuperable y los efectos que quedan bloqueados. No pide un nuevo dictado hasta haber agotado la búsqueda razonable en las fuentes canónicas accesibles.
- Se conserva el texto visible del usuario y la salida visible final del modelo. No se archiva razonamiento interno oculto ni se declara haber capturado mensajes, adjuntos o resultados de herramientas que no estuvieron disponibles.

### 10.8 Trazabilidad de ida y retorno

La relación bidireccional no se cumple con una referencia unidireccional aislada. Para cada vector:

1. **Ida:** el registro de vector debe enumerar los principios/reglas, anexos, definiciones, OCP, destinos y resultados que derivan de él.
2. **Retorno:** cada destino modificado debe incorporar el trace_id de origen en sus metadatos, crónica, evidencia o registro local. Cuando el destino no admita metadatos, el registro de impacto de AT debe contener el par destino ↔ trace_id y actuar como índice de retorno recuperable.
3. **Consulta inversa:** dado un result_ref, la instancia debe poder localizar todos los trace_id que lo justifican; dado un trace_id, debe poder localizar todos sus resultados. Ambas consultas se prueban y registran.
4. **Cardinalidad:** un vector puede sustentar varios resultados; un resultado puede depender de varios vectores. Se conservan todos los enlaces, sin forzar relación uno-a-uno.
5. **Disposición de cada destino:** todo destino inspeccionado se registra como CAMBIO_REQUERIDO, COMPROBAR_COMPATIBILIDAD, SIN_CAMBIO_JUSTIFICADO, INCIERTO o BLOQUEADO, con motivo. No se omiten destinos para aparentar cierre.
6. **No huérfanos:** ningún cambio ejecutado por AT queda sin vector o fuente alternativa de autoridad; ningún vector activo queda sin resultado o disposición declarada.

La traza no demuestra por sí sola que el contenido derivado sea correcto. La corrección exige revisar la interpretación, la regla aplicable, el permiso, el destino y la evidencia del resultado.

### 10.9 Compatibilidad LISA: contrato de enlace, no simulación

La definición de Vector Semántico L0 en el GOW v2.11 lo identifica como una unidad mínima de intención formalizada mediante diálogo y reconocida con firma del operador. Por tanto, el segmento verbatim que AT conserva **no es automáticamente un L0**.

AT v1.1 adopta los siguientes límites de compatibilidad:

- El vector conversacional conserva la fuente de primera mano y su texto exacto; el L0 es la formalización LISA que corresponda, con su diálogo, compuertas y ratificación. AT referencia ambos cuando existan, sin confundir sus identidades.
- Cuando LISA aplique, el registro de AT reservará y enlazará los identificadores de los niveles que realmente existan en el Canon LISA vigente: L0 → REQ L1 → L2 → RE (0–4) → ACR → COD. No se omiten niveles por conveniencia ni se simula su materialización.
- Un L0 derivado debe identificarse como derivado y seguir la ratificación exigida por LISA. El modelo no inventa, firma ni ratifica un L0 en nombre del operador.
- Un Documento Fuente Aprobado solo complementa al L0: requiere aprobación expresa, versión congelada y huella verificable; la mera presencia de un archivo en documentos/originales/ no satisface esa condición.
- La matriz de impacto AT complementa la cadena LISA; no reemplaza la raíz de intención, no reduce la cadena de requisitos y no genera autoridad paralela.
- Hasta que la integración completa de LISA/FIAT/LSV/MAT en la metodología sea construida y verificada, el registro debe declarar LISA_NO_INTEGRADA o INTEGRACIÓN_PENDIENTE cuando corresponda. Una referencia a LISA no equivale a cumplimiento integral de LISA.
- Cuando cambie el Canon LISA o su versión, AT debe revisar el contrato de enlace y documentar compatibilidad; no queda congelada a la especificación histórica revisada en octubre de 2026.

### 10.10 Estado normativo y transición

El DUG v362 continúa clasificando Registro conversacional y Trazabilidad semántica como módulos internos de Gestión conversacional en ART-020/024. AT v1.1 establece la arquitectura operativa objetivo solicitada por el operador, pero no modifica esa clasificación canónica.

Hasta que el operador autorice expresamente la enmienda P005 y esta sea escrita y leída de vuelta en el DUG:

- ART-020/024 conservan precedencia normativa.
- Registro conversacional sigue siendo componente de Gestión conversacional.
- La función de trazabilidad semántica se aplica operativamente al trabajo de AT, pero su reclasificación conceptual en el DUG permanece PENDIENTE_DE_ALINEACIÓN.
- El registro físico actualmente ubicado en ambitos/gestion-conversacional/ se conserva; no se mueve ni duplica por anticipación.
- No se añaden principios, anexos, ámbitos funcionales ni directorios por simetría.

## 11. Protocolo obligatorio de AT por ciclo sustantivo

AT v1.2 se aplica en cada ciclo que pueda producir cambios conceptuales/metodológicos o una decisión sobre su propagación. No se crea un registro por cada llamada auxiliar o acuse trivial; se sigue Metacanon §28 para identificar el ciclo sustantivo.

1. **Adquirir y refrescar autoridad.** Leer main, verificar DUG/Metacanon/GOW vigentes, registrar versión y SHA, leer el núcleo y el control de responsabilidad de Gobernanza y los OCP afectados. Si no se puede leer una fuente necesaria, declarar METODOLOGÍA NO VERIFICADA y limitar el trabajo.
2. **Recuperar antes de preguntar.** Buscar las instrucciones previas y vectores relacionados en los registros persistidos. No solicitar que se repita material disponible.
3. **Abrir el ciclo conversacional.** Asignar/reutilizar el UUIDv7 local de la conversación y asignar el folio del ciclo. Conservar entrada E literal; al cierre, guardar salida visible S literal. Mensajes auxiliares visibles pertinentes se separan de S. No inventar IDs nativos.
4. **Extraer y clasificar vectores.** Identificar segmentos literales exactos, uno por unidad de intención diferenciable. Clasificar instrucción, requisito, decisión, restricción, criterio de aceptación o contexto no esencial. El original íntegro permanece intacto.
5. **Separar interpretación y requisito.** Escribir la lectura operativa fuera del verbatim, clasificar su nivel de certeza y no aumentar ni reducir el significado original. Cuando sea necesario, declarar la ambigüedad.
6. **Construir el mapa de impacto.** Por cada vector, revisar los niveles/destinos potencialmente dependientes: principios → anexos subordinados → taxonomía/GOW/método → OCP/ámbitos/frentes → documentos, índices y materializaciones → espejos externos autorizados. La matriz marca también destinos no afectados y por qué.
7. **Aplicar compuertas por destino.** Verificar autoridad, titularidad, permisos y autorización expresa. P005 para el DUG; P024 y controles del OCP para cambios permanentes; ninguna instrucción se extiende a destinos no incluidos en su alcance.
8. **Realizar el cambio mínimo.** Ejecutar solo los destinos autorizados y realmente dependientes. No propagar por simetría, nombre parecido o automatismo supuesto. Registrar intento, bloqueo o no-acción motivada.
9. **Cerrar los enlaces de ida y retorno.** Añadir los trace_id a cada destino/evidencia o al índice de retorno. Comprobar tanto vector → resultados como resultado → vectores.
10. **Verificar la persistencia.** Leer de vuelta entrada, salida, registros, archivos modificados, enlaces, estados y huellas. Una llamada de escritura sin read-back no es persistencia verificada.
11. **Emitir el resultado y los huecos.** Declarar qué cambió, qué no, qué está bloqueado, la fuente/versión consultada, las pruebas realizadas y las lagunas. No anunciar automatización, sincronización, captura integral o aceptación que no se haya probado.

El ciclo no se considera documentalmente completo si falta uno de los lados E/S disponibles, la referencia al vector de origen, la disposición de los destinos afectados o la lectura de vuelta. Si la plataforma no expone el texto de un mensaje o no permite escribirlo, declarar la limitación; no reconstruirlo desde memoria.

## 12. Modelo mínimo de registro y estados

El registro semántico de AT debe poder expresar, como mínimo, estos campos:

| Campo | Regla |
|---|---|
| trace_id | Identificador estable del vector; no se reutiliza ni se recicla. |
| source_ref | Referencia al mensaje E íntegro o a una fuente importada con procedencia explícita. |
| conversation_id | UUIDv7 local estable; separado del ID nativo si la plataforma lo expone. |
| source_cycle_folio | Folio del ciclo de la fuente E íntegra a la que apunta source_ref. |
| record_cycle_folio | Folio del ciclo en que se creó/actualizó esta traza. |
| literal_excerpt | Extracto exacto que puede cotejarse dentro de la entrada original. |
| classification | Clase de vector o contexto; no se infiere requisito por mera presencia. |
| interpretation | Lectura derivada, separada del literal y con nivel de certeza. |
| rule_refs | Principios, anexos, Metacanon y términos GOW realmente aplicables. |
| destination_refs | OCP, documentos o componentes inspeccionados/afectados. |
| impact_disposition | Cambio, comprobación, sin cambio, incertidumbre o bloqueo, siempre con razón. |
| result_refs | Referencias recuperables a cambios, entregables, pruebas y evidencias. |
| reverse_link_refs | Ubicación desde la que un resultado puede regresar a los vectores que lo justifican. |
| authorization_ref | Autorización exacta, alcance, estado y destino al que aplica. |
| lisa_refs | Canon/versión y L0/REQ/L2/RE/ACR/COD existentes, o estado de integración pendiente. |
| verification | Read-back, cotejo literal, comprobación de ambos sentidos y evidencia. |
| status | Estado actual del vínculo; el historial se conserva por adición/supersesión. |

Estados del vínculo: CAPTURADO, CLASIFICADO, INTERPRETACIÓN PENDIENTE, ENLACE PARCIAL, BLOQUEADO, VERIFICADO y SUPERSEDIDO. Los estados de cada destino son independientes: CAMBIO_REQUERIDO, COMPROBAR_COMPATIBILIDAD, SIN_CAMBIO_JUSTIFICADO, INCIERTO, BLOQUEADO, INTENTO_NO_CONFIRMADO, ESCRITO_NO_VERIFICADO o VERIFICADO.

No declarar un vector VERIFICADO por el solo hecho de que su texto esté guardado. Para ese estado deben existir fuente recuperable, extracto exacto, interpretación diferenciada, regla/fuente de autoridad, destino y resultado, vínculo inverso y lectura de vuelta. La aceptación del operador, cuando sea necesaria, se registra por separado del estado técnico VERIFICADO.

## 13. Pruebas falsables y criterio de cierre endurecido

La definición AT v1.2 se considera aplicada correctamente a un cambio concreto solo si supera las comprobaciones pertinentes:

1. **Fidelidad del vector:** cada extracto coincide literalmente con un segmento de la entrada E; la entrada completa se recupera sin normalización.
2. **Separación semántica:** original, vector, interpretación y requisito operativo aparecen separados. Ninguna palabra añadida por el modelo se presenta como dictado del operador.
3. **Cobertura de origen:** todo cambio ejecutado por AT tiene al menos un vector o una fuente alternativa de autoridad identificada. Todo vector activo tiene una disposición explícita.
4. **Cobertura de impacto:** se identifican destinos que cambian, se comprueban, permanecen sin cambio o quedan bloqueados, con una razón falsable.
5. **Bidireccionalidad:** una consulta por trace_id devuelve destinos/resultados; una consulta por result_ref devuelve los trace_id de origen. Ambos caminos se verifican.
6. **Jerarquía normativa:** no se confunden principios con anexos, jerarquía documental con niveles OCP, ámbitos con directorios, ni GOW con autoridad.
7. **Autorización:** ninguna escritura normativa o permanente ocurre por inferencia, por cobertura de trazabilidad o por urgencia.
8. **Persistencia:** entrada E, salida S, registro semántico y artefactos se leen de vuelta; se cotejan los contenidos y se conservan referencias de revisión.
9. **Compatibilidad LISA:** los vectores no se etiquetan automáticamente como L0; se referencia la cadena LISA que exista, y se declara lo que todavía no está integrado.
10. **Límites reales:** no se afirma captura automática, sincronización multiplataforma, ID nativo ni acceso futuro si la herramienta no lo expone y verifica.

**Prueba negativa obligatoria:** una propuesta que no pueda vincularse a un vector o fuente normativa, cuyo sentido dependa de una inferencia ambigua, o que carezca de autorización para su destino, no puede propagarse como cambio ejecutado. Debe quedar PENDIENTE o BLOQUEADA.

**Prueba de no-duplicación:** una instrucción ya persistida y recuperable se reutiliza por su referencia; no se exige nuevo dictado, no se crea una copia paralela del original y no se abre otro registro maestro.

## 14. Estado

**AT v1.2: DEFINICIÓN OPERATIVA PARA TRAZABILIDAD, PROPAGACIÓN, COMPATIBILIDAD LISA Y DOBLE CORRESPONSABILIDAD LIMITADA.**  
**Canonización en el DUG: NO REALIZADA.**  
**Motor autónomo de ejecución/captura: NO IMPLEMENTADO NI DEMOSTRADO; AT v1.2 define un procedimiento operativo verificable que debe ejecutar la instancia responsable mientras la automatización no exista.**  
**DUG v375 / GOW 2.15: alineación normativa materializada y leída de vuelta para P037, P039, Metacanon §§38/42/47 y control de responsabilidad. Metacanon 1.26 y LISA: sin cambios estructurales adicionales en esta derivación. AT v1.2 sigue siendo propuesta operativa, no anexo independiente canonizado.**

El siguiente trabajo dentro del frente Gobernanza puede volver a la tarea de desarrollar Tareas cuando se resuelva la alineación normativa necesaria. Tareas no es un frente independiente. AT v1.0 queda como mecanismo de articulación que se aplicará al desarrollar ese ámbito; no se presume que Tareas ya esté canonizado ni que sus artefactos locales tengan autoridad normativa superior.



## 15. Incorporación excepcional de una segunda conversación responsable

La cardinalidad ordinaria por frente es una sesión activa. El operador puede autorizar expresamente una excepción `ADD_CO_RESPONSIBLE` para incorporar una segunda conversación en el mismo frente, sin transferir, liberar ni sustituir al titular vigente. El máximo absoluto es dos sesiones activas: titular y corresponsable. Una tercera conversación queda bloqueada.

### 15.1 Precondiciones y autorización

1. Recuperar el único `CONTROL-RESPONSABILIDAD.json` vigente; registrar blob SHA, generación, titular, folio y sesiones activas.
2. Comprobar que existe exactamente una sesión activa. Si ya existen dos, detener la incorporación; no desplazar ni retirar a ninguna.
3. Obtener autorización expresa del operador para `ADD_CO_RESPONSIBLE`; una autorización de transferencia no se interpreta como permiso para co-responsabilidad, ni a la inversa.
4. Crear para la segunda conversación un alias operativo, una etiqueta de instancia, un UUIDv7 local y un folio `SES-AAAAMMDD-XXXXXXXX` propios. Registrar el ID nativo solo si la plataforma lo expone realmente.

### 15.2 Mutación única y preservación

Actualizar mediante compare-and-swap condicionado al blob SHA/revisión y generación recién leídos. Conservar literalmente los campos heredados que identifican al titular principal; incrementar la generación una sola vez; registrar en `active_responsibles[]` tanto al titular como al corresponsable, cada uno con rol, alias, instancia, UUIDv7 local, folio y estado activo. Ambas sesiones quedan asociadas a la nueva generación del mismo control. No crear un segundo control, un OCP duplicado ni una transferencia encubierta.

Si SHA o generación no coinciden, no sobrescribir ni reintentar a ciegas: releer, reconciliar y volver a determinar la operación autorizada. El resultado de escritura no se considera verificado hasta completar lectura de vuelta y cotejar titular conservado, segunda sesión, folios, UUIDv7, generación y cardinalidad.

### 15.3 Coordinación y límites reales

Antes de cada escritura canónica, cualquiera de las dos sesiones debe volver a leer el mismo control, observar la generación actual y usar SHA/CAS. Una colisión obliga a releer y reconciliar; ninguna sesión puede presumir que conserva una revisión anterior. El máximo de dos se valida en el control y en cada preflight. La tercera sesión no se agrega ni toma el lugar de otra sin una autorización distinta de transferencia/liberación.

La garantía es cooperativa y documental: el registro compartido y CAS reducen sobrescrituras concurrentes entre escritores que usan el mismo control, pero no autentican por sí solos la identidad de una conversación ni crean fencing universal frente a herramientas o escritores que eludan el protocolo. No afirmar sincronización automática ni exclusión técnica universal.

### 15.4 Criterio de aceptación

`ADD_CO_RESPONSIBLE` queda verificado solo cuando: (a) el titular original permanece activo y sin cambio de alias/folio/UUIDv7; (b) la segunda sesión tiene identidad operativa y folio propios; (c) ambas aparecen en el único control con una misma generación; (d) el conteo activo es exactamente dos y el límite máximo es dos; y (e) una lectura de vuelta coteja literalmente los campos y su SHA. El folio global del ciclo y los folios A/B no se generan por esta asignación de sesión; permanecen sujetos al estado efectivo de FOL1.