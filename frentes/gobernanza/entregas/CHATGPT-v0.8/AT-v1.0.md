# Articulación Trazable (AT) · definición operativa v1.0

**Estado:** propuesta operativa cerrada para el alcance v1.0; no canonizada en el DUG.  
**Frente responsable:** Gobernanza · `frentes/gobernanza/`  
**Evento:** C-GOBERNANZA-AT-V1-01  
**Ciclo:** C-20261029-34641998  
**Fuente normativa cotejada:** DUG v362 · NX-362m · `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html` · blob `b7593409c428e209d35f53a5f13501652208d949`  
**Metacanon:** 1.24 · **GOW:** 2.11 · **taxonomía:** 1.3 · **principios/anexos:** 41/18.

## 1. Propósito

Articulación Trazable (AT) es el mecanismo operativo responsable de analizar y realizar, dentro de las autorizaciones y restricciones aplicables, los cambios conceptuales de la metodología Ser y Mente que deban articularse entre sus niveles de OCP, su gobierno normativo y los documentos o materiales dependientes.

Su necesidad concreta es evitar que un cambio trabajado desde un ámbito, frente u OCP quede aislado, se materialice en un nivel incorrecto, contradiga la jerarquía del DUG o deje sin actualizar destinos que realmente dependan de él. AT identifica dónde debe producir efecto el cambio, dónde no debe producirlo y conduce su realización verificable.

## 2. Alcance delimitado de v1.0

AT v1.0 se limita a la articulación longitudinal de **cambios conceptuales y metodológicos** dentro de Ser y Mente: definiciones, taxonomía, ámbitos, contratos compartidos, reglas del método y sus materializaciones dependientes.

No es un sistema general para administrar cualquier cambio de software, producto, infraestructura, proyecto o proceso externo. Tampoco convierte toda modificación local en una enmienda del DUG. Un cambio que solo afecta un artefacto local permanece en su OCP cuando no exista una dependencia conceptual o normativa superior que requiera propagación.

AT no sustituye al DUG, a Metacanon, al GOW ni a los OCP de los niveles afectados. No crea autoridad, permisos, titularidad, capacidades ni sincronización. Cuando LISA sea aplicable, conserva su función de anclar intención y trazabilidad de requisitos; la cadena de LISA no se confunde con los niveles OCP ni los reemplaza.

## 3. Distinciones estructurales obligatorias

AT debe mantener separadas tres dimensiones que pueden relacionarse, pero no son equivalentes:

1. **Gobierno normativo del DUG.** Los principios son el único elemento de gobierno directo y conservan su orden y precedencia. Los anexos desarrollan o precisan principios bajo subordinación; ningún anexo tiene autoridad de gobierno independiente. El DUG HTML en `main` es la fuente normativa única. Su contenido humano precede a la representación estructurada, que es derivada.
2. **Taxonomía conceptual y OCP.** La Metodología, en sentido general y abstracto, es el OCP raíz. La organización, cada repositorio, cada frente, cada ámbito funcional y cada subámbito definido son OCP de su propio nivel. OCP no es un nivel taxonómico adicional. La categoría conceptual Ámbitos no se convierte por ello en un nivel de la cadena de infraestructura.
3. **Materialización física.** La ubicación documental, las carpetas y las rutas se resuelven para cada OCP según su autoridad, necesidad, control y recuperabilidad. No existe equivalencia obligatoria uno-a-uno entre concepto y directorio. Un ámbito no requiere una carpeta por definición.

La jerarquía documental de anexos (por ejemplo, ART-015, sus anexos hijos y los anexos de nivel documental 3) tampoco equivale a la jerarquía conceptual de OCP. Los números de nivel de anexos describen la subordinación documental de esos anexos, no la posición funcional de los conceptos que describen.

## 4. Flujo operativo único

AT v1.0 se materializa como **un mecanismo integrado con etapas internas**, no como una colección de submódulos. Las etapas comparten un mismo cambio de origen, un mapa de dependencias, compuertas de autorización y un registro de resultado; no se han demostrado estados, responsables o interfaces autónomos que justifiquen módulos separados.

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
- Las colisiones de responsabilidad se resuelven mediante P037 y Metacanon §42; no se sobrescribe un control concurrente.
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
6. Actualizar espejos externos únicamente cuando exista autorización, acceso y un procedimiento de verificación independiente. Nunca presumir sincronización.

Si una etapa queda bloqueada, AT no ejecuta el destino bloqueado. Puede continuar los cambios independientes que sí estén autorizados, dejando clara la propagación parcial y sus límites.

### Etapa F · Verificar y registrar

Por cada destino modificado, leer de vuelta la revisión escrita y cotejar el contenido pertinente. Verificar, según corresponda:

- principio afectado, posición y orden de la lista, precedencia y referencias;
- anexo, identificador, nivel documental, padre, principio(s) relacionado(s), enlaces y retornos;
- coherencia entre taxonomía conceptual, definiciones GOW y alcance de los OCP;
- separación entre identidad conceptual y materialización física;
- consistencia de la representación estructurada con el contenido humano;
- integridad de referencias, rutas, controles y materiales realmente dependientes;
- estado de cada destino sin convertir una inspección en prueba de modificación.

Registrar para cada destino uno de estos resultados: **SIN CAMBIO JUSTIFICADO**, **PENDIENTE**, **BLOQUEADO**, **INTENTO NO CONFIRMADO**, **EJECUTADO NO VERIFICADO** o **VERIFICADO**. Añadir autorización, fuente/revisión, evidencia, límite y siguiente paso. Solo la lectura de vuelta y el cotejo permiten declarar VERIFICADO.

## 5. Registro mínimo de articulación

Cada cambio sustantivo atendido por AT deja una matriz recuperable con estos campos:

| Campo | Contenido |
|---|---|
| Vector semántico | ID de fuente, folio conversacional/ciclo, segmento literal y procedencia |\n| Origen e intención | Instrucción/decisión, interpretación separada y OCP de origen |
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

AT v1.0 satisface su propósito cuando, ante un cambio conceptual concreto, permite demostrar que:

1. se identificó su origen, vector semántico literal, interpretación separada, OCP y autoridad vigente;\n2. cada cambio y resultado puede rastrearse bidireccionalmente hasta los vectores que lo justifican;
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

## 10. Decisión de arquitectura y límites de evolución

La v1.0 utiliza un solo mecanismo coordinador con etapas A–F y un único registro de articulación. La diversidad de funciones no demuestra por sí misma la necesidad de submódulos: análisis, clasificación, impacto, autorización, realización y verificación operan sobre el mismo cambio y la misma cadena de dependencias.

La posible descomposición se difiere. Solo se reabrirá si el uso real demuestra responsabilidades con ciclo de vida, estado, titularidad o contrato de interfaz independientes. No se crea un submódulo por verbo, por simetría o por anticipación.

## 9. Trazabilidad semántica como fundamento de AT

La trazabilidad semántica es una **capacidad interna y fundamental de AT**, no un ámbito funcional transversal independiente ni, en el diseño objetivo de AT, un módulo subordinado a Gestión conversacional. Su objeto específico es conservar el anclaje causal y justificativo de los cambios que AT analiza, decide propagar y realiza: cada cambio debe remontarse a uno o varios vectores semánticos originados en instrucciones, decisiones o restricciones verbatim del operador.

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

AT v1.0 debe ser compatible con el Canon LISA y con la futura integración de LISA en la metodología, sin anticipar ni simular esa integración:

- El vector semántico conserva la instrucción de primera mano y su procedencia; no se confunde automáticamente con un L0 ratificado.
- Cuando LISA aplique, AT referencia el L0 correspondiente y, si procede, la cadena L0 → REQ → ACR → resultado/código. Los elementos derivados se identifican como derivados.
- El modelo no inventa, firma ni ratifica un L0 en nombre del operador. Se respetan las compuertas de ratificación definidas por el Canon LISA/FIAT cuando se integren.
- Un Documento Fuente Aprobado, si existe, complementa el vector/L0 con contenido mecánico verificable; no sustituye la intención del operador ni se presume aprobado por estar archivado.
- La matriz de impacto de AT complementa la cadena de especificación LISA; no crea una cadena de autoridad paralela. Los cambios upstream activan revisión de compatibilidad de dependencias downstream.
- La integración completa de LISA, FIAT, LSV, MAT u otros instrumentos sigue siendo trabajo futuro sujeto a sus propias autorizaciones y validaciones. AT v1.0 solo define los puntos de enlace y preserva la compatibilidad.

### 9.4 Relación con el DUG y estado de alineación

El DUG v362 actualmente ubica Trazabilidad semántica como módulo interno de Gestión conversacional en ART-020/024. La clasificación conceptual precisada por el operador para AT v1.0 requiere revisar esa ubicación: Registro conversacional permanece en Gestión conversacional; Trazabilidad semántica pasa a ser capacidad fundamental de AT. Persistencia documental sigue siendo un ámbito funcional transversal paralelo, con el que los registros conversacionales convergen en su custodia.

Esta corrección se documenta aquí como definición operativa propuesta. **No se modifica el DUG ni el GOW sin autorización normativa expresa previa conforme a P005.** Hasta que esa enmienda se autorice y se materialice, el DUG vigente conserva precedencia y la reclasificación se considera propuesta pendiente de alineación normativa.

## 11. Estado

**AT v1.0: DEFINICIÓN OPERATIVA REVISADA; TRAZABILIDAD SEMÁNTICA INCORPORADA COMO CAPACIDAD FUNDAMENTAL.**  
**Canonización en el DUG: NO REALIZADA.**  
**Implementación automatizada independiente: NO REALIZADA NI REQUERIDA PARA ESTE CIERRE.**  
**DUG v362 / ART-020 / ART-024 y GOW: SIN MODIFICACIONES; alineación normativa pendiente de autorización expresa. Canon LISA: sin modificaciones.**

El siguiente trabajo dentro del frente Gobernanza puede volver a la tarea de desarrollar Tareas cuando se resuelva la alineación normativa necesaria. Tareas no es un frente independiente. AT v1.0 queda como mecanismo de articulación que se aplicará al desarrollar ese ámbito; no se presume que Tareas ya esté canonizado ni que sus artefactos locales tengan autoridad normativa superior.
