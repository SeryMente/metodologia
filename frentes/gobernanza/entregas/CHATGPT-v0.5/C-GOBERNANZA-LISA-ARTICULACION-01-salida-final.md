# Informe · Compatibilidad histórica LISA ↔ Articulación Trazable

**Frente:** Gobernanza · SeryMente/metodologia  
**Evento:** C-GOBERNANZA-LISA-ARTICULACION-01  
**Ciclo:** C-20261029-8B41F2D7  
**Estado:** revisión documental realizada; originales persistidos y cotejados.  
**Alcance negativo:** no se modificaron el DUG, Metacanon, GOW, Canon LISA, FIAT, Convención de Código Firmado, PCA ni el espacio de Notion.

## 1. Originales conservados

Se preservaron los dos archivos descargados en la sesión local, sin conversión, normalización de finales de línea ni sustitución por texto extraído:

| Original | Tamaño | SHA-256 calculado en origen | Lectura de vuelta |
|---|---:|---|---|
| AthanorJue20260319-normativo_v0943.html | 714.674 bytes | F16E3AEDAFE2B2D7919D700373343F4A5BEEE14BD23D940789980D5A977BDCB5 | Coincidencia Base64 exacta |
| LISA-Explicacion-Consolidada-v1.0 (1).pdf | 360.350 bytes | 78B3904FA7D585E6C407C30227A571F2229203DE651D08C3B2595899361C80CF | Coincidencia Base64 exacta |

Custodia: [original HTML](../../documentos/originales/AthanorJue20260319-normativo_v0943.html) · [original PDF](<../../documentos/originales/LISA-Explicacion-Consolidada-v1.0%20%281%29.pdf>) · [manifiesto](../../documentos/MANIFIESTO-DOCUMENTAL.json).

El SHA-256 se calculó sobre los bytes locales; la lectura de vuelta recuperada de GitHub coincide byte por byte con Base64 de origen. No se afirma sincronización con Notion ni se modificó su contenido.

## 2. Qué representa cada fuente histórica

- **Normativo Athanor / Lisa Hub v0.9.43 (HTML).** Fuente normativa histórica que da forma al marco pre-Cora: intención humana, Vector Semántico L0, requisitos trazables, arquitectura fractal, sistema de código y protocolo de ejecución. Incluye además material del primer diseño RAP.
- **LISA · Explicación Consolidada v1.0 (PDF, 2026-05-20).** Síntesis/índice de trabajo construida sobre el normativo v0.9.43 y RAP-SMU v1.3, con el Bloque 1 marcado como completado. Resume resultados que no estaban consolidados en el HTML base, entre ellos Principio Sagrado, LSV (LISA Semantic Validator) y MAT (Motor de Actualización Tecnológica). El PDF deja los bloques RAP 2–6 pendientes; no es la especificación completa vigente por sí solo.

En Notion, ambos originales están embebidos como fuentes verbatim en el [Anclaje LISA ↔ Cora OS v1.0](https://app.notion.com/p/386a4187824182a1ae9201e95cc592ce), y el [Canon LISA v1.2](https://app.notion.com/p/968a41878241825a960b01d1d241cb08) los identifica como fuentes verbatim del trabajo LISA pre-Khora. La copia ahora custodiada por Gobernanza es una **copia de preservación y consulta cruzada**, no una segunda autoridad normativa para LISA.

## 3. Estado de LISA encontrado en Notion

La revisión encontró el **Canon LISA · Especificación de Intención v1.2**, con fecha de versión 2026-07-22 (la consulta disponible devuelve un corte fechado 2026-10-20). Sus decisiones relevantes son:

1. **Trazabilidad universal (§EI.10):** todo cambio que modifique el sistema en el Workspace —metacanon, cánones y reglas— o en Khora —repositorio y producto— debe trazar a un Vector Semántico L0. Se puede dosificar la ceremonia, pero no suprimir la trazabilidad: L0 de primera mano cuando la prueba del mapa lo exige; L0 derivado, marcado y ratificado, cuando se permite.
2. **Cadena de especificación:** L0 → REQ L1 → L2 → RE (0–4) → ACR → COD. El L0 representa intención; REQ/ACR descienden de él; el código es el resultado comprobable.
3. **Documento Fuente Aprobado (§EI.11):** en casos especiales puede complementar la intención con contenido mecánico verificable, pero nunca sustituye al L0. Requiere designación expresa, congelación/versionado y huella verificable; mutaciones posteriores exigen nueva aprobación. Un archivo histórico conservado no se convierte automáticamente en Documento Fuente Aprobado para una construcción futura.
4. **Convención de Código Firmado v1.1:** en el alcance de tarjetas candadas, el código lleva @l0, @req, @acr y @ua cuando proceda. Esta convención no debe copiarse mecánicamente a la metodología OCP como si fuera una regla ya canonizada allí; es una dependencia operativa del canon LISA y de su entorno.
5. **FIAT v0.40:** instrumenta la extracción, firma y materialización de L0 por una secuencia formal. El modelo no fabrica ni ratifica por cuenta propia la intención original.
6. **MDC v1.1:** trata explícitamente las dependencias de cánones: un cambio upstream activa revisión de compatibilidad de downstream; se resuelve de forma binaria antes de ratificar un cambio que pudiera romperlos.
7. **PDCP y PCA:** preservan el límite de la delegación probabilística y la auditoría basada en evidencia. La especificación determina el qué y sus criterios; la implementación ocupa solo el margen autorizado y se acepta con pruebas, no por afirmación.

Fuentes consultadas: [Canon LISA v1.2](https://app.notion.com/p/968a41878241825a960b01d1d241cb08), [Anclaje LISA ↔ Cora OS](https://app.notion.com/p/386a4187824182a1ae9201e95cc592ce), [Handoff de 2026-07-20](https://app.notion.com/p/faba418782418215991a013a5989041e), [Convención de Código Firmado v1.1](https://app.notion.com/p/bf6a4187824183ebb9e6012950ec0a50), [Protocolo FIAT v0.40](https://app.notion.com/p/99ba4187824182e7aedf011a6d452bce), [MDC v1.1](https://app.notion.com/p/f55a418782418304a3d581adad1a71f6), [PDCP v1.0](https://app.notion.com/p/594a41878241827b9b8b01316843616b), [PCA v0.2](https://app.notion.com/p/5ada418782418220811d01451dec1c40), [Chasis Cora OS v1.0](https://app.notion.com/p/64ba41878241835186df81ba74ac686d) y [Guía de despacho](https://app.notion.com/p/605a41878241825c94cc01a6d9d59272).

## 4. Decisión histórica de integración: una distinción necesaria

El [Anclaje LISA ↔ Cora OS v1.0](https://app.notion.com/p/386a4187824182a1ae9201e95cc592ce), sellado el 2026-07-18, deja establecidas dos cosas distintas:

- El **canon de especificación LISA** se adoptó y evolucionó posteriormente hasta v1.2 en Notion.
- La **integración de LISA/LSV/MAT en Cora OS v1.0** no quedaba autorizada por el anclaje: los bloques RAP 2–6 debían sellarse y el operador debía ordenar expresamente crear las tarjetas correspondientes. El chasis crece por tarjetas; describir una arquitectura futura no autoriza construirla.

Por tanto, no es correcto inferir ni que LISA sigue sin canon ni que su integración de producto ya quedó ejecutada. El canon de especificación existe en Notion; la incorporación futura al chasis/producto se mantiene como ámbito separado y sujeto a sus compuertas. No se modificó ninguna de esas páginas.

## 5. Relación con la Articulación Trazable (AT)

El concepto explorado en la conversación —todavía **no ratificado como nombre ni canon**— cubre un problema más amplio que la mera trazabilidad de requisitos:

- **LISA** fija la raíz de intención y cómo comprobar su descendencia semántica hasta los criterios y la implementación.
- **AT**, según el diseño conversado, debería gobernar el ciclo transversal del cambio: conservar la instrucción verbatim; identificar consecuencias necesarias; inspeccionar niveles, dominios, repositorios y componentes potencialmente afectados; declarar también qué no cambia; aplicar únicamente acciones autorizadas; y verificar resultados con evidencia y lectura de vuelta.

La compatibilidad no consiste en duplicar LISA ni en reemplazar el L0 por una tabla de impacto. Consiste en usar LISA como **anclaje de intención y trazabilidad** cuando aplique, y a AT como **proceso de análisis de impacto, delimitación y propagación controlada**. La matriz de impacto complementaría la cadena L0/REQ/ACR; no sería otra cadena de autoridad en paralelo.

### Composición compatible sugerida (no implementada)

Instrucción original verbatim → L0 autorizado/ratificado cuando aplique → REQ y ACR trazables → matriz de impacto (afectados / no afectados) → regla y permiso aplicables → cambio mínimo autorizado → pruebas y lectura de vuelta → evidencia y estado.

En esta futura composición:

- El L0 no se inventa ni se firma por inferencia del modelo. Se extrae y ratifica según la regla LISA/FIAT correspondiente.
- La matriz de impacto distingue explícitamente **afectación necesaria**, **afectación posible pendiente de prueba** y **sin cambio justificado**. La inspección puede ser amplia; la modificación debe ser mínima.
- La autorización es una compuerta independiente de la trazabilidad. Una traza completa no concede permiso para modificar un canon ni sustituye las reglas de titularidad.
- El resultado incluye evidencia, incertidumbre y estado de cada efecto; un componente revisado que no cambia se conserva como tal, sin crear trabajo para justificar actividad.
- Los cambios upstream en cánones ejecutables revisan sus dependencias declaradas; los cambios puramente archivísticos no se deben convertir artificialmente en un cambio de arquitectura o producto.

## 6. Compatibilidad con la metodología OCP vigente

La fuente normativa preponderante del repositorio sigue siendo el [DUG v359 · NX-359m](https://github.com/SeryMente/metodologia/blob/main/gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), con Metacanon 1.24, GOW 2.8, 41 principios y 16 anexos. Los mecanismos existentes que mejor sirven de base para AT son:

- **P005 y P024:** autorización expresa antes de mutar normas u objetos permanentes.
- **P022:** compuerta previa a escritura y verificación estructural pertinente.
- **P025:** anti-bloat; no crear artefactos o trabajo adicional por mera simetría.
- **P035 y Metacanon §28:** continuidad y registro verificable del ciclo, incluidos resultado, límites y siguiente paso.
- **P037 y Metacanon §42:** resolver titularidad con transferencia explícita y cotejo, sin sobrescribir concurrencia.
- **P038:** preponderancia de SeryMente/metodologia/main sobre espejos para la metodología.
- **P041, ART-014 y ART-022:** originales intactos, procedencia, manifiesto, lectura de vuelta y cotejo.
- **Metacanon §26:** adquirir gobierno y permiso antes de actuar, relacionar requisitos con evidencia y no declarar conformidad por afirmación.
- **Metacanon §§28, 43 y 46:** ciclo recuperable, frescura/versionado y OCP/ruta autorizados.

Estos mecanismos cubren de antemano buena parte de la gobernanza de cambio, la persistencia y la prohibición de ampliación no justificada. AT debería **orquestarlos y hacerlos trazables en un solo flujo**, no copiarlos en un nuevo canon. Solo una brecha demostrada y una autorización posterior justificarían una adición normativa.

La página antigua [Metodología de uso general · marco replicable](https://app.notion.com/p/0e8a418782418248a42e8171ca6ae282) aporta antecedente sobre planificación por etapas y autoauditoría antes de entregar. Aquí se trata como material de contexto histórico/operativo, no como sustituto del DUG vigente.

## 7. Alcance y salvaguardas para la siguiente etapa

1. **La AT permanece propuesta.** Ni su nombre expandido ni su definición se incorporaron al DUG/GOW o al Canon LISA; el paquete/propuesta conversado no se declara canon.
2. **No hay enmienda normativa en este ciclo.** Esta operación custodia originales y registra análisis; no modifica reglas, requisitos ni arquitectura de LISA, Cora OS o el DUG.
3. **No hay aprobación automática de fuente LISA.** La conservación de los dos originales en Gobernanza mejora su recuperación y cotejo, pero no los designa como nuevos Documentos Fuente Aprobados para construir software.
4. **No se adelantó la integración LISA a Cora OS.** Se mantienen las compuertas explícitas del anclaje y las autorizaciones de su entorno.
5. **No se canoniza Tareas.** Tareas sigue siendo un ámbito funcional transversal en incubación, no un frente adicional ni un tercer ámbito funcional ya incluido en la taxonomía DUG. Su carpeta física actual no se generaliza como regla para otros OCP.
6. **Cobertura temporal:** el acceso disponible a las páginas consultadas de Notion devuelve cortes fechados el 2026-10-20; no puedo certificar con esas lecturas que no haya actualización posterior. La búsqueda fue dirigida por LISA/Athanor/LSV y trazabilidad, y la lectura priorizó el canon y sus dependencias relevantes; no fue una auditoría línea por línea de cada resultado incidental.

## Dictamen

**Compatible por composición, con una frontera clara.** LISA aporta la raíz de intención y la cadena de especificación verificable; AT puede aportar el procedimiento universal de cambio, impacto, alcance negativo y propagación. Su futura definición debe heredar los permisos, la persistencia y las compuertas vigentes, además de mantener el L0 como origen cuando proceda. No hace falta ampliar hoy el canon de metodología ni editar LISA. La decisión segura en este ciclo es preservar las dos fuentes históricas, dejar esta relación documentada y retomar el diseño de AT sin convertirlo todavía en norma.


## Adenda · Precisión posterior del alcance funcional de AT · 2026-10-29 12:46 (America/Mexico_City)

El operador precisó que la **Articulación Trazable (AT)** no solo analiza el cambio y sus efectos, sino que también debe servir como **medio para realizar los cambios que analiza**. Esta precisión amplía explícitamente su alcance funcional desde el análisis y la delimitación hasta la ejecución coordinada de los cambios resultantes.

La distinción operativa queda así:

1. **Analizar:** preservar y rastrear la instrucción de origen; derivar sus consecuencias necesarias; examinar dependencias, impactos y componentes afectados o no afectados.
2. **Autorizar y delimitar:** comprobar titularidad, permisos y compuertas; decidir qué cambios están autorizados y cuáles deben excluirse o quedar bloqueados.
3. **Realizar:** servir como mecanismo operativo para aplicar los cambios autorizados en sus componentes y destinos correspondientes, mediante herramientas o ejecutores competentes, conservando el límite de alcance.
4. **Verificar y registrar:** releer los resultados, cotejarlos con lo solicitado, evidenciar el estado y dejar recuperable la relación entre instrucción, análisis, autorización, ejecución y resultado.

La facultad de realizar cambios **no equivale a autorización autónoma** para modificar todo sistema que la AT pueda analizar. Análisis, permiso y ejecución son funciones distinguibles; las escrituras quedan sujetas al gobierno, la titularidad y las autorizaciones de cada destino. La AT debe ejecutar lo necesario y autorizado, no implementar automáticamente toda consecuencia posible.

Por tanto, la composición compatible se entiende como **flujo integral de cambio** —origen e intención → análisis de impacto → autorización y alcance → realización coordinada → verificación y evidencia—, con LISA como anclaje de intención y especificación cuando corresponda. Esta adenda documenta la aclaración del operador; no canoniza la AT ni modifica el DUG, Metacanon, GOW o el Canon LISA.


## Aclaración posterior · Responsabilidad realizadora de AT · 2026-10-29

El operador precisó el sentido de la función realizadora de la Articulación Trazable (AT): no se trata solo de que AT esté disponible como canal o medio para aplicar cambios. **AT es el mecanismo responsable de realizarlos**, dentro de la medida y los límites que permitan las reglas, la titularidad, los permisos, las precondiciones y las compuertas del destino correspondiente.

Esta responsabilidad cubre llevar el cambio analizado y delimitado a su realización efectiva, coordinando las herramientas o ejecutores autorizados y verificando el resultado. No convierte a AT en autoridad autónoma ni le permite eludir restricciones. Cuando un destino prohíba, limite o no autorice una modificación, AT debe respetar el límite: excluir o ajustar la acción, dejar constancia del bloqueo y solicitar la decisión o autorización que falte, en vez de ejecutar por fuera de la compuerta.

Por tanto, AT no solo diagnostica ni se limita a recomendar cambios: responde operativamente por la aplicación de los cambios que corresponden, en la medida autorizada, y por la verificación y el registro de su resultado. Esta precisión aclara el concepto de trabajo; **no lo canoniza** ni modifica el DUG, Metacanon, GOW, Canon LISA o Notion.


## Adenda · Cierre acotado de AT v1.0 y evaluación de subcomponentes · 2026-10-29

El objetivo inmediato queda acotado a **llevar la definición operativa de la Articulación Trazable (AT) a v1.0**, sin abrir un rediseño más amplio ni prolongar esta línea de trabajo más de lo necesario. Esto no autoriza por sí mismo implementar software ni canonizar la definición.

Queda como tarea pendiente verificar, con fundamento en la naturaleza multifacética de la necesidad que AT debe aliviar, si conviene descomponer el componente en subcomponentes o submódulos. AT debe observar/analizar el cambio, controlar y limitar su impacto, mitigarlo, acotar dónde corresponde que impacte, dirigir y facilitar la propagación pertinente y servir como mecanismo responsable de realizar los cambios dentro de los permisos y límites de cada destino. Esta diversidad funcional justifica **evaluar** la modularización, no darla por necesaria de antemano ni asumir una correspondencia automática de un submódulo por cada verbo.

La evaluación deberá identificar responsabilidades realmente separables, dependencias e interfaces, y aportar evidencia suficiente para justificar una descomposición. Se resolverá en esta etapa solo en la medida en que resulte necesario o urgente para conseguir una AT v1.0 coherente, delimitada y verificable. Si no bloquea ese cierre, se documentará como evolución posterior, sin convertirla en motivo de demora ni ampliar el alcance actual.

**Criterio de trabajo:** cerrar AT v1.0 con la estructura mínima que cubra la necesidad demostrada; no añadir módulos por simetría, anticipación o elegancia arquitectónica. La validación debe contemplar tanto un cambio que se propaga correctamente a los destinos necesarios como una acción limitada o bloqueada por un destino. La AT permanece como propuesta en diseño, no canonizada.
