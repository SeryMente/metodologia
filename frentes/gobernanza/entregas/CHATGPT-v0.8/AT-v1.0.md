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

- Conservar la instrucción o decisión de origen literalmente cuando esté disponible, con su procedencia; separar el texto original de la interpretación.
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

Construir una matriz breve de origen → regla aplicable → nivel/destino → efecto requerido. La matriz debe distinguir:

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
| Origen e intención | Instrucción/decisión, procedencia y OCP de origen |
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

1. se identificó su origen, intención, OCP y autoridad vigente;
2. se clasificó correctamente el nivel al que pertenece, sin confundir principios, anexos, conceptos, OCP ni rutas físicas;
3. se determinó si el cambio requiere gobierno directo, desarrollo subordinado, ajuste taxonómico/GOW o solo actualización local;
4. se respetó el orden vigente de los principios y la subordinación documental de los anexos;
5. se identificaron los destinos que cambian, los que permanecen intactos y los que están bloqueados, con justificación;
6. cada escritura se hizo solo tras satisfacer la autorización y las compuertas particulares;
7. AT coordinó y realizó los cambios permitidos y verificó por lectura de vuelta sus resultados;
8. no se afirmó canonización, sincronización, propagación global ni verificación que no estuviera respaldada por evidencia.

## 7. Validación conceptual de los dos casos requeridos

### Caso positivo · cambio conceptual que debe articularse

**Antecedente real:** C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01. A partir de una instrucción autorizada, se distinguió la taxonomía conceptual de la infraestructura y se canonizó Propósito como elemento conceptual asociado al alcance de un FT. El cambio se reflejó en ART-015, ART-019, ART-020/021, Metacanon §§46/51, el GOW y la representación estructurada. No se añadió un principio ni un anexo, porque el cambio no introducía una nueva obligación de gobierno general. La lectura de vuelta del DUG fue exacta; el JSON incrustado parseó y el JavaScript pasó compilación sintáctica aislada. No se ejecutó renderizado de navegador ni auditoría dinámica completa de enlaces.

**Recorrido que AT debe reproducir:** clasificar la petición como cambio taxonómico/conceptual; conservar la autorización; modificar los anexos y definiciones que expresan esa taxonomía; mantener los principios existentes como gobierno superior; actualizar GOW/proyección derivada y verificar los destinos afectados. No imponer una carpeta por la existencia del concepto.

**Resultado de validación:** recorrido coherente con la estructura vigente y con el antecedente registrado. Es una comprobación retrospectiva de diseño, no una ejecución automatizada de AT v1.0.

### Caso negativo · propagación que debe limitarse

**Estado vigente observado:** Tareas tiene un diseño y materiales locales en incubación, incluido un estándar mínimo candidato v0.2, pero el DUG v362 mantiene como ámbitos funcionales canónicos Persistencia documental y Gestión conversacional. ART-015/020 no incorporan Tareas a la lista canónica.

**Decisión de AT:** el hecho de que exista `ambitos/tareas/`, un diseño o un estándar local no autoriza a promover Tareas al DUG/GOW ni a modificar la lista de principios. La propagación hacia el canon queda **BLOQUEADA** hasta que exista una propuesta clasificada, una autorización explícita para el cambio normativo y la aprobación correspondiente. El trabajo local que no dependa de esa promoción puede continuar dentro de las compuertas de su propio OCP.

**Resultado de validación:** el límite está determinado por la fuente vigente y por P005/P024. Es una comprobación de escritorio sobre el estado actual, no una prueba de ejecución automática.

## 8. Decisión de arquitectura y límites de evolución

La v1.0 utiliza un solo mecanismo coordinador con etapas A–F y un único registro de articulación. La diversidad de funciones no demuestra por sí misma la necesidad de submódulos: análisis, clasificación, impacto, autorización, realización y verificación operan sobre el mismo cambio y la misma cadena de dependencias.

La posible descomposición se difiere. Solo se reabrirá si el uso real demuestra responsabilidades con ciclo de vida, estado, titularidad o contrato de interfaz independientes. No se crea un submódulo por verbo, por simetría o por anticipación.

## 9. Estado

**AT v1.0: DEFINICIÓN OPERATIVA CERRADA PARA EL ALCANCE SOLICITADO.**  
**Canonización en el DUG: NO REALIZADA.**  
**Implementación automatizada independiente: NO REALIZADA NI REQUERIDA PARA ESTE CIERRE.**  
**DUG, Metacanon, GOW y Canon LISA: SIN MODIFICACIONES EN ESTE CICLO.**

El siguiente trabajo vuelve al ámbito Tareas. AT v1.0 queda como mecanismo de articulación que se aplicará al desarrollar ese ámbito; no se presume que Tareas ya esté canonizado ni que sus artefactos locales tengan autoridad normativa superior.
