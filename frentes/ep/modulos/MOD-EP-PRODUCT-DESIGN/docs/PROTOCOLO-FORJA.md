# Protocolo Forja
## Método rector de ideación y diseño de Product Design

**Versión documental:** 1.0
**Fecha:** 2026-11-15
**Estado:** propuesta integrada; pendiente de aceptación del operador
**Perfil ejecutor:** prompts/FORJA-CHAT.md
**Persistencia:** tools/Invoke-ProductDesignStore.ps1, sin modificaciones al motor aprobado

---

## 1. Propósito y autoridad metodológica

Protocolo Forja es el método rector para transformar una necesidad de producto en un contrato de diseño explícito, verificable y agnóstico a infraestructura. Sustituye a la lluvia de ideas genérica como procedimiento de ideación y diseño dentro de Product Design.

Forja no comienza proponiendo pantallas, código, arquitectura ni una solución tecnológica. Primero construye evidencia sobre el ramo, separa el común denominador de las decisiones diferenciadoras, obtiene las selecciones del operador y formaliza el resultado en dos zonas complementarias:

- **R# — Zona de Invariantes:** requisitos rígidos que el constructor debe cumplir íntegramente.
- **DL# — Zona de Espacio Delegado:** decisiones que el operador deja intencionalmente abiertas para que un modelo constructor explore variantes y optimice la solución sin infringir ningún R#.

La salida es un contrato de diseño, no una especificación de infraestructura. No prescribe lenguaje, framework, proveedor, nube, base de datos, hosting, topología ni patrón arquitectónico salvo que el operador convierta expresamente alguno en un R#.

### 1.1 Principios no negociables

1. **Secuencia estricta:** las fases se ejecutan en el orden definido. Una fase incompleta bloquea la siguiente.
2. **Autoridad del operador:** Forja investiga, clasifica, compara y recomienda; el operador selecciona, excluye y aprueba.
3. **Evidencia antes que afirmaciones:** las referencias se identifican y documentan. Lo desconocido se declara desconocido; no se inventan competidores, capacidades ni cuotas de mercado.
4. **Separación de naturaleza:** un esencial describe el mínimo funcional del ramo; un modificador altera la naturaleza, experiencia o posicionamiento del producto.
5. **Delegación explícita:** solo lo contenido en DL# queda abierto. El silencio no convierte una restricción en delegación.
6. **Hard-gate:** no se implementa código ni se inicializa o persiste un diseño antes de que el operador apruebe explícitamente el contrato final R# + DL#.
7. **No sustitución silenciosa:** Forja no modifica, simplifica ni omite un R# para acomodar una preferencia técnica del constructor.
8. **Trazabilidad:** cada R# y DL# identifica su origen, selección, evidencia o aprobación correspondiente.

## 2. Modelo de fases y transiciones

Las fases son secuenciales. No se ejecutan en paralelo ni se omiten para acelerar la sesión.

| Fase | Nombre | Resultado exigido | Gate de salida |
|---|---|---|---|
| F0 | Enmarque del reto | Problema, usuario, contexto, objetivo, límites conocidos y ramo | El reto tiene alcance suficiente para investigar |
| F1 | Mapeo de referentes | Mapa de referentes directos, competidores y análogos | Fuentes, fecha y alcance de la muestra visibles |
| F2 | Extracción y clasificación | Esenciales y modificadores separados y sustentados | Cada capacidad está clasificada y justificada |
| F3 | Selección del operador | Nivel de cada esencial y decisión individual sobre cada modificador | No quedan selecciones críticas inferidas |
| F4 | Síntesis R# + DL# | Contrato de diseño agnóstico a infraestructura | Todas las decisiones del operador están representadas |
| F5 | Revisión y aprobación | Versión completa presentada para aceptación | Aprobación explícita del operador |
| F6 | Persistencia autorizada | Registro del diseño aprobado y lectura de vuelta | Initialize, SaveCycle, ShowSession y Verify satisfactorios |

Un rechazo o una modificación solicitada devuelve el trabajo a la fase correspondiente. No se avanza dejando una discrepancia abierta. Una pausa conserva el estado en la conversación; no crea una persistencia implícita.

### F0 — Enmarque del reto

Forja identifica, sin repetir preguntas ya contestadas:

- Problema u oportunidad que se pretende resolver.
- Usuarios, actores y contexto de uso.
- Resultado que debe producir la solución.
- Industria, categoría o ramo al que pertenece.
- Alcance geográfico o regulatorio cuando sea material.
- Restricciones expresas, exclusiones y criterios de éxito conocidos.

Si falta un dato que cambia sustancialmente el ramo, el usuario objetivo o la investigación, Forja formula una pregunta concreta. No inicia una investigación sobre una categoría supuesta.

### F1 — Mapeo de referentes

Forja identifica los principales referentes y competidores relevantes para la categoría. Distingue al menos:

- **Directos:** ofrecen una solución comparable al mismo tipo de usuario o necesidad.
- **Adyacentes:** resuelven una parte relevante del problema o compiten por el mismo presupuesto o flujo de trabajo.
- **Análogos:** aportan un patrón funcional o de experiencia transferible, aunque pertenezcan a otro ramo.

Para cada referente presenta, cuando la evidencia esté disponible:

| Campo | Contenido |
|---|---|
| Referente | Nombre y enlace a fuente primaria o sitio oficial |
| Tipo | Directo, adyacente o análogo |
| Público y problema | A quién sirve y qué necesidad cubre |
| Propuesta funcional | Capacidades que ofrece, no solo su eslogan |
| Diferencia relevante | Qué lo distingue de los demás |
| Evidencia | URL, documento, fecha de publicación o consulta |
| Confianza | Alta, media o baja, con motivo |

La muestra debe ser suficiente para representar el ramo; Forja explica su criterio de selección y las limitaciones de cobertura. Usa investigación actual cuando el mercado pueda haber cambiado. Prioriza documentación oficial, fichas de producto y fuentes primarias; contrasta con fuentes independientes cuando sea útil. No transforma una muestra parcial en la afirmación universal de que todos los competidores hacen algo.

**Salida F1:** mapa comparativo y lista breve de patrones funcionales observados. Ninguna característica pasa automáticamente a ser requisito por aparecer en un referente.

### F2 — Extracción y clasificación

Toda capacidad candidata se clasifica en una de dos clases distinguibles.

#### 2.1 Esenciales — Común denominador

Son las capacidades de base que una solución del ramo debe ofrecer para cumplir su función y ser reconocible como solución de esa categoría. Forja distingue:

- **Universal o normativo:** exigido por una norma, regulación, estándar aplicable o condición funcional ineludible.
- **Común en la muestra:** presente en todos o casi todos los referentes examinados, pero sin evidencia suficiente para llamarlo universal.
- **Inferencia pendiente:** plausible, pero no demostrada. No se eleva a esencial hasta comprobarla o hasta que el operador la acepte explícitamente como requisito propio.

Cada esencial se presenta obligatoriamente en los tres niveles:

| Nivel | Alcance |
|---|---|
| **Austero** | Cumplimiento mínimo y suficiente de la capacidad. Delimita qué se incluye y qué queda fuera. |
| **Medio** | Cobertura funcional equilibrada, mayor profundidad, integración o comodidad respecto del nivel austero. |
| **De Lujo** | Cobertura amplia o premium, mayor sofisticación y calidad percibida; no significa añadir tecnología específica por defecto. |

Para cada esencial Forja presenta: identificador temporal E#, justificación, evidencia, clasificación de universalidad/confianza y descripción concreta de cómo se manifiesta en Austero, Medio y De Lujo. Los tres niveles describen alcance funcional observable, no una arquitectura.

El operador selecciona un nivel para cada esencial. Puede seleccionar el mismo nivel para todos o combinar niveles de manera explícita. Forja no elige por presupuesto supuesto, no interpreta silencio como Austero y no convierte una recomendación en selección.

#### 2.2 Modificadores cualitativos — Diferenciadores u originales

Son capacidades opcionales que modifican sustancialmente la naturaleza funcional, la experiencia, el posicionamiento o la propuesta de valor del producto. No se presentan como obligatorias ni se mezclan con los esenciales.

Cada modificador se presenta **individualmente**, con:

1. Identificador temporal M# y nombre.
2. Qué cambia en la naturaleza del producto y para qué usuario aporta valor.
3. Referente(s) que lo inspiran y evidencia disponible.
4. Beneficios, costes funcionales, riesgos y renuncias.
5. Decisión del operador: **Activar**, **Descartar** o **Pendiente**.
6. Efectos sobre otros modificadores y sobre los esenciales seleccionados.

Dos análisis son obligatorios para cada modificador:

**A. Exclusión mutua y dependencias.** Forja construye una matriz de compatibilidad entre modificadores y señala pares o grupos incompatibles, redundantes o condicionados. Para cada conflicto explica la causa y ofrece las alternativas. No activa dos opciones incompatibles ni resuelve el conflicto por su cuenta. Si hay dependencias, identifica qué opción requiere cuál.

**B. Competencia entre referentes.** Cuando dos referentes resuelven el mismo modificador mediante enfoques diferentes, Forja describe ambos enfoques, sus consecuencias y el contexto en que cada uno funciona mejor. No los promedia ni elige uno sin instrucción del operador.

**Salida F2:** inventario separado de esenciales y modificadores, con evidencia, alcance, compatibilidad y diferencias competitivas visibles.

### F3 — Selección del operador

Forja presenta una hoja de decisión compacta:

- Cada esencial E# con sus tres niveles y la selección del operador.
- Cada modificador M# con sus alternativas, exclusiones y elección individual.
- Conflictos sin resolver, dependencias y decisiones pendientes.
- Recomendaciones de Forja separadas visualmente de las elecciones del operador.

El operador puede adoptar una recomendación, cambiarla o descartarla. Forja registra la elección como decisión del operador solo después de recibirla de forma inequívoca. Un elemento **Pendiente** no puede convertirse en R# como si estuviera decidido; debe quedar fuera del contrato aprobado o aprobarse expresamente como cuestión diferida.

### F4 — Síntesis del contrato de diseño

Forja produce un único diseño compuesto por las dos zonas siguientes y no añade una tercera zona de requisitos.

#### Zona 1 — Invariantes R#

R# contiene exclusivamente obligaciones no negociables derivadas de:

- Niveles elegidos para esenciales.
- Modificadores activados por el operador.
- Restricciones y exclusiones expresas del operador.
- Condiciones normativas o funcionales aplicables, con su fuente identificada.

Cada requisito R# contiene:

| Campo | Regla |
|---|---|
| ID | R1, R2, R3… consecutivos y estables en la versión del diseño |
| Enunciado | Una obligación precisa; no una aspiración ambigua |
| Origen | E#, M#, restricción o decisión explícita del operador |
| Criterio de aceptación | Condición observable que permite verificar cumplimiento |
| Evidencia | Referencia o selección que lo sustenta |

R# es cerrado. El constructor no puede omitirlo, cambiar su significado, rebajar su alcance, sustituirlo por una preferencia técnica ni declararlo satisfecho sin evidencia. Si dos R# entran en contradicción, el constructor se detiene y devuelve el conflicto al operador; no resuelve por inferencia.

#### Zona 2 — Espacio Delegado DL#

DL# identifica decisiones que el operador no restringió y delega expresamente al modelo constructor. No es una lista de requisitos ocultos ni una especificación técnica prematura.

Cada DL# contiene:

| Campo | Regla |
|---|---|
| ID | DL1, DL2, DL3… consecutivos y estables |
| Dominio delegado | Decisión que se deja abierta |
| Objetivo de optimización | Qué debe maximizar o equilibrar el constructor |
| Límites | R# que no puede infringir y exclusiones aplicables |
| Libertad explícita | Qué alternativas puede explorar sin pedir otra selección |
| Criterio de calidad | Cómo comparar las variantes generadas |

El modelo constructor puede producir variantes diferentes y usar su capacidad probabilística para explorar soluciones originales. La delegación no prescribe una única arquitectura ni premia la repetición de una receta fija. Todas las variantes deben satisfacer íntegramente todos los R#. Si ninguna variante puede hacerlo, debe detenerse y solicitar resolución al operador.

**Regla de precedencia:** R# prevalece sobre cualquier decisión DL#. DL# solo opera dentro del espacio que dejan libre todos los R#. Nada que no esté escrito en DL# se considera delegado automáticamente.

### F5 — Revisión y aprobación hard-gate

Forja presenta el contrato completo, incluidos:

1. Mapa de referentes y fuentes.
2. Esenciales y los tres niveles ofrecidos para cada uno.
3. Selecciones exactas del operador.
4. Modificadores activados, descartados y pendientes.
5. Matriz de exclusión mutua/dependencias y comparación de enfoques competitivos.
6. Lista completa de R# con origen y aceptación.
7. Lista completa de DL# con sus fronteras de libertad.
8. Riesgos, supuestos y preguntas pendientes.

Solicita una decisión explícita: **Aprobar diseño**, **Solicitar cambios** o **Rechazar**. Para aprobación puede utilizarse la expresión inequívoca «APROBAR DISEÑO FORJA vX.Y». Un elogio, silencio, cambio de tema o petición de continuar no constituye aprobación.

Si el operador solicita cambios, se modifica la fase pertinente y se presenta una nueva versión. Si aprueba, Forja fija la versión y congela el significado de todos los R#; los cambios posteriores requieren una revisión y nueva aprobación.

**Prohibición hard-gate:** antes de la aprobación explícita está prohibido escribir código, invocar herramientas de construcción, inicializar una sesión persistente, ejecutar Initialize o SaveCycle, o declarar que el diseño quedó guardado. La preparación del texto en la conversación no es persistencia.

La aprobación de diseño permite registrar el diseño aprobado mediante el almacén autorizado. No autoriza por sí sola la ejecución de código, despliegues, cambios de infraestructura, acceso a datos reales ni la apertura de compuertas EP. Para implementación se requiere la autorización operativa correspondiente.

### F6 — Persistencia del diseño aprobado

Una vez recibido el visto bueno explícito del diseño, Forja prepara un ciclo de síntesis y lo envía mediante el wrapper existente. El motor Python y el wrapper PowerShell no se modifican en este alcance.

#### 6.1 Adaptador de identidad sin modificar el motor

El registro vigente de persistencia valida el par agente/motor contra una lista cerrada: Carson corresponde a bmad-brainstorming. El almacén no tiene todavía una identidad Forja de primera clase.

Para mantener intacto el motor aprobado y poder validar compatibilidad ahora, el perfil utiliza este **adaptador de metadatos**:

- agent = Carson
- engine = bmad-brainstorming
- tags incluyen protocolo-forja y perfil:forja
- goal y project_title identifican explícitamente Protocolo Forja
- los items R# y DL# conservan autor?a y procedencia Forja/operador; la autor?a t?cnica del registro se adapta a los valores cerrados del motor.

Esta correspondencia es exclusivamente una clave de compatibilidad con el esquema de persistencia. No autoriza ni ejecuta el método BMAD Brainstorming, no exige consultar brain.py y no convierte a Carson en autoridad metodológica. La autoridad metodológica sigue siendo este protocolo y el perfil prompts/FORJA-CHAT.md.

No se debe enviar agent = Forja ni engine = protocolo-forja al wrapper hasta que una extensión de esquema, con sus pruebas propias, sea autorizada y aprobada. Esta especificación no modifica AGENTS, el motor Python, el wrapper ni sus pruebas.

#### 6.2 Contrato Initialize

Campos obligatorios exactos: topic, agent, engine, mode. Campos opcionales: goal, project_title, maturity, tags.

Para Forja, el adaptador utiliza:

- topic: ramo y problema de diseño.
- agent: Carson, por compatibilidad de esquema.
- engine: bmad-brainstorming, por compatibilidad de esquema.
- mode: creative_partner, como valor neutro aceptado por el esquema; no sustituye las fases Forja.
- goal: objetivo del diseño y mención expresa de Protocolo Forja.
- project_title: título del producto o solución.
- maturity: mature para un diseño aprobado.
- tags: protocolo-forja, perfil:forja y etiquetas de dominio pertinentes.

#### 6.3 Contrato SaveCycle

El payload debe usar exclusivamente las claves admitidas por el motor:

- project_id, session_id, cycle_number, stage, mode
- techniques, items, open_questions, decisions
- links_to_previous, tags, maturity, session_status

Los identificadores de proyecto/sesión provienen de la respuesta real de Initialize; nunca se inventan. Para el ciclo final aprobado:

- stage: synthesis
- mode: creative_partner
- session_status: completed si el operador cerró el diseño; paused si dejó una revisión abierta.
- techniques: fases efectivamente aplicadas del Protocolo Forja.
- items: cada R# se representa como item type decision; cada DL# como item type direction.
- open_questions: solo asuntos que el operador haya aceptado dejar abiertos.
- decisions: selección de niveles, elecciones de modificadores, exclusiones y aprobación explícita.
- links_to_previous: lista vacía para un primer ciclo; versiones relacionadas solo cuando se conozca su ID real.
- tags: incluye protocolo-forja y perfil:forja.
- maturity: mature únicamente tras aprobación del contrato.

Cada item usa exactamente los campos type, full_text, author, maturity, reusable y provenance. provenance contiene exactamente source, technique y notes. El texto completo del R# o DL# se conserva dentro de full_text; no se reduce a un resumen. El motor solo acepta author=operator o author igual al agent de la sesi?n. Por ello, R# usa author=operator y DL# usa author=Carson como alias de sesi?n Forja; provenance.source y provenance.notes identifican que el contenido DL# fue generado/delegado por Forja. No uses author=Forja ni variantes adornadas, porque el motor las rechaza.

#### 6.4 Secuencia de ejecución y comprobación

La secuencia permitida después de aprobación es:

1. Initialize — crear el proyecto y la sesión.
2. SaveCycle — almacenar el contrato aprobado R# + DL#.
3. ShowSession — recuperar la sesión y comprobar que aparece el ciclo esperado.
4. Verify — exigir ok = true, issues vacío y consistencia del índice.

No se declara «guardado» si una operación falla, falta index_updated, el Verify informa incidencias o el contenido leído de vuelta no coincide con el aprobado. Se conservan el SHA-256, la revisión y el resultado que devuelve el motor.

El wrapper se invoca mediante tools/Invoke-ProductDesignStore.ps1 con los parámetros reales -Operation, -WorkspaceRoot, -TerminalId y -PayloadJson; -TimeoutSeconds puede fijarse dentro de su rango admitido. -TestMode solo se utiliza con el workspace sintético permitido. La escritura productiva sigue bloqueada hasta la integración y verificación de EP-C0/TP-02B. No se suplanta esa verificación con un booleano ni con una ruta elegida por el perfil.

## 3. Invariantes de gobernanza del método

- No saltar F1 o F2 porque el operador sugiera una solución inicial; la propuesta puede registrarse como hipótesis y contrastarse.
- No pasar de F2 a F4 sin selecciones de F3.
- No convertir recomendación de Forja en selección del operador.
- No ocultar exclusiones, incompatibilidades, dependencias ni enfoques competitivos distintos.
- No generar R# a partir de opciones pendientes.
- No escribir una arquitectura, stack o infraestructura dentro de R# o DL# por conveniencia del modelo si el operador no lo decidió.
- No debilitar R# para hacer viable una opción técnica.
- No persistir borradores o checkpoints antes de aprobación.
- No ejecutar código, despliegues ni operaciones del host a partir de una aprobación de diseño.
- No alterar el motor de persistencia para acomodar el perfil sin una autorización y una revisión separadas.

## 4. Criterios de validación del perfil

La validación sintética de Forja debe comprobar como mínimo:

1. Fases F0–F6 presentes y secuenciales.
2. F1 produce referentes directos/adyacentes/análogo con evidencia.
3. Cada esencial incluye Austero, Medio y De Lujo.
4. Cada modificador se presenta individualmente con exclusión mutua y competencia.
5. No existen R# antes de selecciones explícitas del operador.
6. DL# contiene decisiones realmente delegadas y límites explícitos respecto de R#.
7. La aprobación explícita bloquea/desbloquea la persistencia según lo definido.
8. Los payloads Initialize y SaveCycle cumplen el esquema exacto del motor sin añadir campos.
9. El wrapper ejecuta Initialize, SaveCycle, ShowSession y Verify únicamente en TestMode sintético.
10. La lectura de vuelta conserva R# y DL# y Verify devuelve integridad sin incidencias.

Una prueba sintética valida contrato y flujo técnico. No equivale a aceptación interactiva del operador, autorización productiva, integración EP-C0 ni prueba de implementación del producto.

## 5. Estado de la integración

Esta versión incorpora el método y el perfil conversacional como propuesta para evaluación. La validación sintética, si pasa, demuestra compatibilidad con el wrapper y el esquema actuales usando el adaptador descrito. No convierte Forja en un agente de primera clase en AGENTS; esa ampliación queda fuera del alcance para preservar intacto el motor aprobado.

La aprobación del operador sobre estos documentos y la autorización posterior de implementación son decisiones separadas.
