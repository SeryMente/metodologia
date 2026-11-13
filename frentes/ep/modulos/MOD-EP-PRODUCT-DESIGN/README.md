# MOD-EP-PRODUCT-DESIGN — Frente operativo Product Design

## Identidad y clasificación

- **Identificador:** `MOD-EP-PRODUCT-DESIGN`.
- **Frente padre:** Entorno Persistente (EP).
- **Clasificación metodológica:** módulo funcional interno de EP; subfrente funcional conforme a DUG ART-029.
- **Ruta canónica:** `SeryMente/metodologia/main/frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/`.
- **Entrada de invocación:** **Frente Product Design**.
- **Estado:** INICIALIZADO; definición y entregables del producto concreto pendientes de adquirir sus fuentes.

**Regla de acceso:** cuando el operador invoque «Frente Product Design», «Product Design» o «MOD-EP-PRODUCT-DESIGN», se entra en el contexto de trabajo de este módulo. La denominación «frente» funciona como interfaz operativa de invocación; no lo convierte en un FT/OCP independiente ni cambia su subordinación a EP.

## Gobierno y persistencia

Este módulo hereda del FT EP la autoridad, alcance autorizado, titularidad, sesiones, generación, OCP, núcleo operativo, control de responsabilidad, reglas de seguridad y aceptación. El estado integrado permanece en el único objeto padre:

- **OCP y estado rector:** [`frentes/ep/OEP.md`](../../OEP.md).
- **Control autoritativo:** [`frentes/ep/CONTROL-RESPONSABILIDAD.json`](../../CONTROL-RESPONSABILIDAD.json).
- **Inventario e instalación BMAD:** MOD-EP-BMAD, según OEP §141–§142.
- **Ejecución OpenCode/Groq:** MOD-EP-OPENCODE, según OEP §141–§142.

No se crea para este módulo un CONTROL-RESPONSABILIDAD.json, núcleo operativo, OCP, titularidad, sesión, generación ni folio global independientes. Este README es la puerta de entrada y la ficha funcional local; no compite con el OEP.

Los documentos, fuentes, decisiones, especificaciones, diseños, prototipos, pruebas y entregables propios de Product Design se conservarán dentro de esta carpeta. Se crearán subcarpetas solo cuando existan materiales reales que lo justifiquen. Los originales se distinguirán de sus derivados y conservarán su procedencia.

## Propósito funcional derivado

Desarrollar la capacidad de Product Design asistida por BMAD dentro de EP: transformar necesidades y fuentes del operador en definiciones de producto, requisitos, flujos de experiencia, especificaciones de interfaz y prototipos verificables, manteniendo trazabilidad entre fuentes, decisiones, diseño y validación.

Este propósito es una lectura funcional derivada del encargo de crear el frente/módulo para la implementación de Product Design con BMAD; no se presenta como un propósito literal de un FT independiente.

## Alcance funcional

1. **Descubrimiento:** problema, contexto, usuarios, necesidades, objetivos, restricciones y supuestos.
2. **Definición de producto:** product brief, propuesta de valor, alcance, requisitos funcionales/no funcionales, historias y criterios de aceptación.
3. **Experiencia de usuario:** arquitectura de información, escenarios, recorridos, flujos, estados, contenido y comportamiento.
4. **Diseño de interfaz:** jerarquía visual, componentes, patrones, sistema de diseño y especificaciones de interacción.
5. **Prototipado:** wireframes y prototipos conceptuales, visuales, navegables, funcionales o técnicos, siempre identificando su fidelidad y límites.
6. **Validación y transferencia:** evaluación frente a requisitos, pruebas aplicables, hallazgos, decisiones y handoff verificable a implementación.

## Límites e interfaces

- **MOD-EP-BMAD** conserva la instalación, configuración y recursos BMAD. Product Design consume esa capacidad; no reinstala ni duplica BMAD.
- **MOD-EP-OPENCODE** conserva los binarios, lanzadores, configuración y entorno de ejecución. Este módulo no duplica sus artefactos ni credenciales.
- **MOD-EP-CHROME** conserva su responsabilidad sobre el navegador y sus datos confinados cuando se utilice.
- La implementación de producción, despliegue y operación del producto no se presumen parte de Product Design. Se identificarán sus interfaces y el destino responsable cuando exista un producto concreto.
- La existencia de infraestructura BMAD/OpenCode/Groq probada no equivale a aceptación integral de EP ni a la aceptación de un proceso completo de Product Design.

## Criterios de calidad y aceptación

Cada entregable debe declarar su tipo, versión/estado, fuentes, supuestos y evidencia. En particular, no se confundirán:

- concepto o brief con requisitos aprobados;
- wireframe o mockup con prototipo funcional;
- prototipo con MVP;
- MVP con producto productivo;
- prueba sintética con validación de usuarios;
- implementación ejecutada con aceptación.

El módulo se considerará funcionalmente completo cuando el proceso de diseño acordado tenga entradas trazables, requisitos y criterios verificables, entregables de diseño consistentes, resultados de validación y transferencia documentada. La aceptación de un artefacto no implica la aceptación global del módulo ni de EP.

## Estado inicial y siguiente trabajo

- **Creación documental:** este módulo queda materializado en la ruta canónica indicada.
- **BMAD:** se reutiliza la instalación del módulo padre EP; no se reclama una implementación productiva nueva.
- **Producto concreto:** pendiente de identificar a partir del documento general de implementación y demás fuentes que el operador incorpore.
- **Documento fuente:** no está adjunto ni identificado inequívocamente en esta conversación; no se presume su contenido.
- **Siguiente acción:** adquirir el documento fuente, preservar el original y clasificar su contenido (prototipo conceptual/visual/navegable/funcional, PoC, MVP o implementación productiva) antes de derivar requisitos y plan de diseño.

## Base metodológica

- DUG canónico de Metodología: v393 · NX-393m; ART-015, ART-019, ART-021 y ART-029.
- Metacanon §46.5: módulo funcional hereda autoridad, OCP, núcleo y control del FT padre.
- OEP EP: único objeto rector, con registro integrado de módulos.


## Reorientación rectora: Frente Product Design con BMAD · 2026-11-12

**Propósito operativo actualizado:** permitir que el operador use directamente ChatGPT para dictar instrucciones y que esas instrucciones se conviertan en el mínimo conjunto de tareas provisionales ejecutables de los frentes existentes. Cada tarea debe conservar la fuente verbatim, asignación de responsabilidad, requisitos derivados, entregables y criterios de aceptación. La descomposición debe cubrir todo lo extraíble de la fuente y no incorporar alcance que no esté solicitado.

**Especificación funcional de origen:** [ESPECIFICACION-OPERATIVA-VMAT.md](./ESPECIFICACION-OPERATIVA-VMAT.md). El nombre del archivo conserva el rótulo histórico derivado del dictado; «vMAT» no es una denominación aprobada y la referencia correcta del diseño es BMAD.  
**Tarea provisional en curso (rótulo histórico):** [EP-TASK-008 — registro de captura verbatim y tareas ejecutables con Superpowers](../../📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-008%20-%20vMAT%20Product%20Design%20-%20Captura%20verbatim%20y%20tareas%20ejecutables%20con%20Superpowers/README.md). La carpeta conserva su nombre histórico; no se crea ni se configura una tarea nueva en esta actualización.

### Encaje de herramientas

- **BMAD 6.12.4:** se reutiliza para descubrimiento, definición de producto, requisitos, UX, arquitectura, historias y planificación cuando el dictado lo requiera.
- **Superpowers v7.0.2:** se integra como catálogo de skills de ingeniería para OpenCode V1; planificación, worktrees, subagentes, ejecución de planes, TDD, debugging, revisión, verificación y cierre.
- **OpenCode 1.19.5 + Groq:** conserva el agente local y proveedor/modelo ya configurados; la clave permanece administrada por EP Vault y solo se expone al proceso autorizado.
- **ChatGPT + RDC:** constituye el canal de captura, coordinación, creación documental y consulta de resultados. La disponibilidad de skills locales no significa que se conviertan en herramientas nativas de ChatGPT.

La configuración local de OpenCode incorpora el plugin V1 fijado a `v7.0.2`. La configuración y el paquete descargado fueron observados; el descubrimiento efectivo de skills por el agente todavía requiere un resultado de runtime verificable. La existencia del plugin no se toma como aceptación completa.

### Regla de trabajo derivada

Para cada nuevo dictado, conservar literalmente el mensaje fuente y crear el menor número de tareas provisionales que cubra todos los resultados, restricciones y condiciones expresas. Cada requisito debe quedar trazado a una tarea, entregable y criterio de aceptación. No crear tareas para posibilidades mencionadas como opcionales ni añadir funcionalidades por iniciativa propia. Las tareas se alojan en el contenedor provisional del frente responsable; la gobernanza y el OCP padre no se duplican.

Esta reorientación supersede como siguiente acción del módulo la espera de un documento general de implementación que no fue adjuntado en este ciclo. No altera el gobierno de EP ni promueve Product Design a FT independiente.


## Continuidad conversacional · 2026-11-13

La conversación completa que origina esta retoma quedó preservada en [fuentes/ChatGPT-PRODUCT-20261113-0951.md](./fuentes/ChatGPT-PRODUCT-20261113-0951.md). La última salida del modelo se reproduce literalmente en [EP-TASK-008 — retoma de contexto](../../📁%20🧭%20-%20Tareas%20provisionales/📁%20🧩%20-%20EP-TASK-008%20-%20vMAT%20Product%20Design%20-%20Captura%20verbatim%20y%20tareas%20ejecutables%20con%20Superpowers/README.md).

**Continuidad corregida:** el nombre de invocación es «Frente Product Design» y el método de producto es BMAD. «vMAT» fue un error de transcripción por dictado y no debe utilizarse como denominación activa. `EP-TASK-008` sigue `en_curso`; su carpeta y el nombre del archivo de especificación conservan rótulos históricos hasta una migración documental separada.

## Acumulado de diseño · BMAD, CIS y capacidades visoespaciales

El diseño acumulado, el flujo local ChatGPT + RDC, el portal CIS/Brain Selector y los límites de integración están registrados en [DISENO-ACUMULADO-BMAD-PRODUCT-DESIGN.md](./DISENO-ACUMULADO-BMAD-PRODUCT-DESIGN.md).

Las ideas recuperadas de Notion sobre cognición visoespacial, los once esquemas, la TCV, D-PROY y la taxonomía emergente se conservan en [FUENTES-CAPACIDADES-VISOESPACIALES.md](./FUENTES-CAPACIDADES-VISOESPACIALES.md). Esa categoría queda diferida a una etapa posterior, sin tareas provisionales creadas.

**Corrección de nomenclatura:** «vMAT» fue un error de transcripción por dictado; la referencia pretendida es BMAD. No es una denominación de producto aprobada.


## Diseño vigente del sprint · 2026-11-13

**Documento general actual:** [SPRINT-GENERAL-PRODUCT-DESIGN.md](./SPRINT-GENERAL-PRODUCT-DESIGN.md). Estado: borrador integral para revisión de diseño extremo a extremo; aún no autoriza implementación ni crea tareas provisionales.

Esta reorientación, dictada por el operador el 2026-11-13, fija como arquitectura objetivo:

- ChatGPT en conversación ordinaria como interfaz principal. No se requiere el portal auxiliar ni una nueva interfaz de selección.
- BMAD como método de Product Design y CIS como catálogo de seis agentes; la selección se resuelve en el chat, sin desplegar el catálogo completo por defecto.
- Superpowers exclusivamente como referencia para habilidades que se desarrollarán por cuenta propia. No forma parte del runtime ni del proceso operativo de Product Design.
- Brain Selector oficial como recurso opcional no requerido; selecciona modalidad y técnicas de brainstorming, no agentes CIS.
- Brainstorm HTML Keepsake como resultado HTML autocontenido generado por el agente a partir de la sesión. El operador no diseña ni maqueta este resultado.
- Diseño pendiente de autoguardado y versiones recuperables tipo Office, más biblioteca básica indexada y reutilizable.
- Cognición visoespacial y proyección visual diferida; solo se conservan sus documentos y categoría.
- Desglose de tareas posterior al vaciado y revisión integral del diseño, replicando el arreglo verbatim del frente Harmonia.

**Precedencia documental:** si los apartados históricos anteriores de este README, DISENO-ACUMULADO-BMAD-PRODUCT-DESIGN.md, ESPECIFICACION-OPERATIVA-VMAT.md, EP-TASK-008 u OEP §§142.19–142.20 contradicen el diseño vigente aquí enlazado, deben leerse como antecedentes de la línea anterior, no como decisiones objetivo vigentes. Se preservan sin borrado ni cambio de estado hasta una reconciliación documental explícita.

**Límite:** el documento general es un borrador de diseño. No se ha instalado CIS, construido autoguardado, creado la biblioteca, generado un Keepsake local ni ejecutado una prueba integral.

- CIS se adaptará como perfiles y procedimientos conversacionales propios a partir de sus fuentes oficiales; su repositorio es un módulo demostrativo en evolución y no se presume que todos sus workflows estén listos o instalados.
- OpenCode no es requisito de la arquitectura objetivo ChatGPT + RDC; el estado de las configuraciones existentes se conserva como antecedente independiente.
- Superpowers queda limitado a la consulta de sus habilidades como referencia para desarrollar capacidades propias. Su Visual Companion no forma parte del alcance actual.
- El flujo de dictados debe mantener la relación fuente verbatim → requisito → tarea → entregable → criterio de aceptación → evidencia, con asignación al OCP responsable.

**Última salida visible del ciclo:** [ULTIMA-SALIDA-PRODUCT-DESIGN-20261113-1350.md](./fuentes/ULTIMA-SALIDA-PRODUCT-DESIGN-20261113-1350.md). Conserva el checkpoint B y los anclajes A correspondientes.
