# Fuentes recuperadas · Cognición visoespacial y proyección visual

**Corte de revisión:** 2026-11-13  
**Estado:** categoría de diseño futuro, pendiente de priorización secuencial.  
**Ámbito:** conservar ideas, definiciones y referencias de Khora encontradas en Notion para integrarlas después en el Frente Product Design. No implementar aún el lienzo, el renderizador ni la IAR.

## 1. Categoría paraguas propuesta

**Cognición visoespacial y proyección visual**

Esta categoría reúne las ideas que tratan la externalización espacial del pensamiento abstracto, las operaciones visoespaciales que la cognición emplea para organizarlo, la proyección visual del Grafo de Relación Personal (GRP) y la gramática/renderizador capaz de conservar identidad al cambiar de representación.

La etiqueta es una sombrilla de trabajo para el acumulado, no una facultad nueva canonizada ni un nombre de producto ratificado.

## 2. Inventario canónico de once operaciones

El GOW v2.2 contiene una entrada denominada **Operaciones visoespaciales de la cognición**, registrada el 2026-07-24 como premisa/incubación, sin estatus de FCP.

Los once esquemas espaciales recogidos son:

1. **Contenencia** — diagramas de Euler.
2. **Orden / gradación.**
3. **Proximidad / semejanza.**
4. **Jerarquía / composición.**
5. **Flujo / causalidad.**
6. **Tensión / trade-off.**
7. **Centro / periferia.**
8. **Magnitud / peso.**
9. **Evolución temporal.**
10. **Correspondencia / analogía.**
11. **Hueco / ausencia** — el espacio negativo como posible motor de ideación.

La entrada agrega una operación sobre el cambio entre representaciones: **transición animada entre arreglos**, rastreando la identidad de los elementos a través del movimiento. La propuesta sostiene que el cambio porta información estructural que no está presente en un único estado estático. Esa operación debe conservarse como extensión explícita del inventario, sin sumarla silenciosamente como un duodécimo esquema espacial.

**Estatuto:** base conceptual de una capacidad candidata de proyección visual en tiempo real del GRP, bajo arreglos predeterminados; brainstorm en incubación, no FCP implementada.

Fuente primaria: [GOW · Glosario Operativo del Workspace v2.2](https://app.notion.com/p/247a418782418399a86001aae61ae938).

## 3. TCV · Tesis Competitiva de la Tríada de Proyección Visual

La TCV v1.4 describe una composición de tres elementos:

1. **GRP persistente y de construcción automática:** el sustrato de información y relaciones personales.
2. **Selector de proyección semántico:** el modelo de lenguaje decide qué representación conviene; no recibe el papel de dibujante de la interfaz.
3. **Renderizador reactivo:** presenta el grafo usando una gramática visoespacial predeterminada y conserva la identidad persistente de los nodos.

El documento distingue tres bucles:

- **Render y transición:** sin invocar al modelo.
- **Selección semántica de proyección:** llamada discreta al modelo.
- **Extracción:** proceso asíncrono, desacoplado de la actualización visual.

La tesis declara sus componentes como premisas de diseño; no acredita una tríada funcional en producción ni su eficacia cognitiva. También advierte que identificadores estables no prueban por sí solos orientación espacial, comprensión o menor fricción. Sus afirmaciones de novedad/ventaja competitiva no se tienen por demostradas.

Fuente primaria: [TCV · Canon v1.4](https://app.notion.com/p/2aba418782418269beaa01732c93b649).

## 4. D-PROY / VIS-COG-01

DOC-09 registra **VIS-COG-01 (D-PROY, gramática visoespacial completa)** como capacidad fuera de Khora 0.9 y 0.9.1, prevista para 0.9.1+ y condicionada a su propio L0. No debe confundirse con el grafo visual existente de Khora ni con el portal de Product Design.

Fuente: [DOC-09 · Cierre 0.9 DevBeta](https://app.notion.com/p/f4ca4187824183cf89be019edcaabe52).

## 5. Taxonomía espacial emergente

El Ideario de diseño conserva dos chispas directamente relacionadas:

### 5.1 Idion / koinón como señal abductiva

Aplicar el PVE al mismo objeto semántico en personas distintas, separar lo compartido (koinón) de lo propio (idion) y estudiar el residuo de diferencia entre los idion como indicio del telos particular de cada usuario. La idea propone triangular varios objetos para inferir patrones propios sin postularlos de antemano. Está marcada «Aún no aplicar».

### 5.2 Taxonomía del espacio como invariante emergente

Cuando exista un método replicable para modelar objetos percibibles, la taxonomía del espacio de trabajo podría emerger como un invariante del método aplicado a la propia prótesis, en vez de imponer al operador la carga de diseñar su organización manualmente.

La idea condiciona ese salto a resolver tres frentes mencionados en el PVE: **error de representación, defecto de cobertura y marco teleológico**. Advierte además que el horizonte es asintótico, que la taxonomía resultante sería facetada y que toda taxonomía manual intermedia sería andamiaje provisional/desechable. Está marcada «Aún no aplicar».

Fuente: [Ideario de diseño · chispas para etapas posteriores](https://app.notion.com/p/7cca4187824183b0971881480c8178f9).

### 5.3 No confundir PVE

En el marco de Teleología Eidética, **PVE significa Protocolo de Variación Eidética**. Es un método de análisis/descripción que tiene seis fases y apartados sobre cobertura y teleología. No es la abreviatura de proyección visual, ni el nombre de la tríada, ni una de las once operaciones visoespaciales.

Fuentes: [Teleología Eidética · marco de modelado](https://app.notion.com/p/af0a4187824182979bb90121822ff4e0) · [Análisis General · el método](https://app.notion.com/p/4d2a4187824183d2bd8e018d46f85454).

## 6. Documentos fuente y su función

| Documento | Función dentro del acumulado | Estatuto / frontera |
|---|---|---|
| [GOW v2.2](https://app.notion.com/p/247a418782418399a86001aae61ae938) | Fuente de los once esquemas y la transición animada | Registro explícito como premisa/incubación, no FCP. |
| [TCV v1.4](https://app.notion.com/p/2aba418782418269beaa01732c93b649) | Fuente de la tríada y los tres bucles | Canon declarativo; diseño propuesto, no implementación ni ventaja demostrada. |
| [Ideario de diseño](https://app.notion.com/p/7cca4187824183b0971881480c8178f9) | Fuente de PVE comparado por idion/koinón y taxonomía espacial emergente | Chispas futuras; «Aún no aplicar». |
| [DOC-09](https://app.notion.com/p/f4ca4187824183cf89be019edcaabe52) | Sitúa VIS-COG-01 / D-PROY fuera de 0.9 y 0.9.1 | Dependencia de planeación histórica; requiere L0 propio. |
| [Teleología Eidética](https://app.notion.com/p/af0a4187824182979bb90121822ff4e0) | Desambigua el acrónimo PVE y conecta con la taxonomía | Marco de modelado independiente de la proyección. |
| [Análisis General · el método](https://app.notion.com/p/4d2a4187824183d2bd8e018d46f85454) | Profundiza variación eidética y evaluación teleológica | Referencia metodológica; no spec del renderizador. |
| [Radar Comercial · IA Personal / GraphRAG](https://app.notion.com/p/748a418782418271ab4201db6f8107bd) | Compara el espacio de mercado y opciones técnicas | Evidencia externa fechada; no valida diseño ni exclusividad. |
| [Radar de convergencia funcional](https://app.notion.com/p/a7da4187824182bc827f81a465c79e71) | Formula F12: proyecciones visuales estables y conmutables | Hipótesis funcional; pide prueba de identidad/orientación y esfuerzo. |
| [Otro Gran Programa · Estado actual](https://app.notion.com/p/94aa418782418368a46d014279f2baae) | Resume la tesis de la tríada y advierte competidores | Documento secundario; no demuestra implementación. |
| [Khora · IAR · Planeación](https://app.notion.com/p/023a4187824182538fff01d56e97692d) | Contexto de unidades ideacionales, evolución temporal y grafo | Línea IAR distinta; no incorporarla a esta categoría funcional. |
| [SEA · IAR · RES](https://app.notion.com/p/e82a418782418218a828012f162740a1) | Define IAR como O2 | Capacidad cognitiva canónica separada de la proyección visoespacial. |
| [Khora OS · Arquitectura UI 0.9–0.9.1](https://app.notion.com/p/a92a418782418397adf7812851808d72) | Describe la UI/grafo existente y sus límites | No equivale al futuro lienzo visoespacial. |
| [Diseño Inicial · Khora Núcleo](https://app.notion.com/p/8cfa41878241835584fc818ba5f32320) | Antecedente de capas y progresión de capacidades | Contexto histórico de la interfaz. |
| [Diseño UX · Khora](https://app.notion.com/p/d22a4187824182909edf01c969d5399c) | Principios de experiencia de Khora | Referencia UX general, no especificación visoespacial. |
| [Visión de Khora](https://app.notion.com/p/321a4187824183b8b95501a38f613779) | Contexto del propósito de la prótesis | Borrador de visión; no prueba capacidades construidas. |
| [Prótesis Cognitiva Digital · idion](https://app.notion.com/p/c28a41878241821f939a81f52b9feb98) | Expone el sentido personal del concepto de prótesis | Fuente conceptual, no contrato del lienzo. |
| [Brain Dump · Khora & Desintegración Positiva](https://app.notion.com/p/6c6a4187824182d8a352819f607b6e2b) | Antecedente del concepto de prótesis | Material de ideación histórico. |
| [Diseño & UI · Khora](https://app.notion.com/p/c57a41878241826bb93181595babea5a) | Contenedor de diseño y UI; enlaza Ideario y specs | Índice de área, no definición adicional. |
| [Capa de Integración · Khora](https://app.notion.com/p/107a4187824183f19f0401f20ad66030) | Contexto arquitectónico de integración | No añade una nueva operación visoespacial. |
| [Dossier de Insumos · Réplica EpisTwin](https://app.notion.com/p/b31a4187824183ccb575016b7ce9c90c) y [Anexo Técnico EpisTwin](https://app.notion.com/p/847a4187824182c1ab24017ef51f8e51) | Antecedentes del sustrato GRP/EpisTwin | Soporte técnico de contexto; no describen la tríada visual. |
| [Recuperación extremo a extremo](https://app.notion.com/p/ec9a41878241838796c68100b2f4bc82) | Estado de recuperación e integración real de grafo | Evidencia de construcción del sustrato; no prueba proyección semántica. |
| [Resumen técnico EpisTwin](https://app.notion.com/p/182a41878241821f8c210143610ece36) y [Genealogía EpisTwin](https://app.notion.com/p/719a418782418269b9f681e580086830) | Contexto de arquitectura de investigación | No aportan nuevas operaciones visoespaciales. |

## 7. Falsos positivos excluidos para no mezclar proyectos

- **Documento Canónico · Fuente de verdad** (RAP-MMD): incluye un lienzo detallado para una arena adversarial de RAP; no es el lienzo cognitivo de Khora.
- **Imagen del sistema · Estado construido** (RAP-MMD): describe una UI arcade adversarial; no es la tríada de proyección visual.
- **Registro Canónico de Errores de Terminal**, **Esoterismo y Ocultismo**, **Notas de trabajo CENSUS** y otros resultados de búsqueda semántica: las páginas examinadas no contienen una especificación pertinente de las operaciones visoespaciales.
- La UI actual de grafo con @xyflow/react + dagre es un antecedente técnico reutilizable, no una implementación de D-PROY.

## 8. Criterios de conservación y futura evaluación

Cuando esta categoría se active en una etapa posterior:

- Preservar los once esquemas como inventario histórico de origen y revisar si la taxonomía final añade, fusiona o separa operaciones; no renumerar ni alterar el registro original.
- Mantener identidad persistente de nodos a través de cambios de proyección; la animación solo aporta información si rastrea los mismos elementos y relaciones.
- Separar el selector semántico del renderizador: el LLM decide la proyección; no genera el dibujo completo en cada turno.
- Separar el bucle de render/transición del bucle de selección LLM y de la extracción asíncrona.
- Conservar fuente, versión y estado epistémico de cada nodo/relación representado.
- Comparar lista/chat/grafo/proyecciones, recarga, cambio de filtro y corrección; medir orientación y esfuerzo del usuario, no solo atractivo visual.
- Considerar accesibilidad, alternativa textual, teclado, foco, reversibilidad y exportación.
- Revalidar el panorama competitivo antes de afirmaciones de novedad: el Radar registra Nowledge Mem y otras opciones con memoria, grafo o lienzo. No se afirma exclusividad.

## 9. Prioridad y secuencia

**Prioridad relativa: posterior a los esenciales del Frente Product Design.** La categoría se conserva por urgencia estratégica moderada, pero no desplaza la integración operativa de BMAD/CIS, la selección de agentes ni el flujo ChatGPT + RDC.

No se asigna número de fase ni tareas provisionales todavía. Al vaciar el acumulado, esta categoría se colocará en una parte ulterior de la secuencia, después de los componentes esenciales que el operador determine.

## 10. Alcance y límite de la revisión

La revisión usó búsquedas semánticas de Notion con expresiones exactas y variantes: operaciones visoespaciales, esquemas espaciales, proyección visual, TCV, GRP, D-PROY, VIS-COG-01, transición animada, espacio negativo, lienzo, taxonomía espacial, PVE e IAR, entre otras. Se consultaron fuentes canónicas y páginas de apoyo de las ramas Proyectos y Sistema, y se abrieron documentos relevantes para distinguir menciones pertinentes de falsos positivos.

**Límite explícito:** el conector de Notion no ofreció en este ciclo una exportación integral del contenido de todas las páginas ni un inventario completo y legible de cada bloque del workspace. Por ello, este registro es un barrido amplio de documentos localizados y revisados, no una afirmación de que se haya leído literalmente cada página existente en Khora Hub. No se marca cobertura 100% hasta ejecutar una enumeración exhaustiva de páginas y revisión de contenido completo. Las páginas fuente consultadas muestran estado unverified; se utilizan como evidencia de ideas registradas, no como prueba de implementación o ratificación.
