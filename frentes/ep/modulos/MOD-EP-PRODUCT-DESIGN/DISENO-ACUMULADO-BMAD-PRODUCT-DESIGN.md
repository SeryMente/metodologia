# Acumulado de diseño · Frente Product Design

**Corte:** 2026-11-13  
**Estado:** diseño acumulado; no desglosado en tareas provisionales.  
**Residencia:** EP → módulo MOD-EP-PRODUCT-DESIGN.  
**Nombre de trabajo:** Frente Product Design apoyado en BMAD y CIS.  
**Corrección terminológica:** las menciones históricas a «vMAT» proceden de un error de transcripción por dictado. No existe un producto ni una arquitectura aprobada con ese nombre. La referencia correcta de esta línea es BMAD.

---

## 1. Decisión de canal y topología

La experiencia se adapta a **ChatGPT + Remote Desktop Commander (RDC) + entorno local persistente**. No se instalará como complemento, plugin o GPT dentro de ChatGPT.

- ChatGPT identifica la intención de trabajo, selecciona el agente/fase adecuada y conduce el intercambio.
- RDC ejecuta en el entorno persistente las operaciones locales: abrir Chrome, consultar archivos, invocar scripts y persistir resultados.
- Google Chrome presenta las interfaces HTML locales.
- BMAD aporta los workflows y los recursos de brainstorming ya instalados.
- CIS aporta el catálogo de agentes, sus especialidades y los workflows que la suite publica.
- Los archivos de sesión, salidas y configuración viven en el entorno persistente de EP.

El host HTTP local escucha exclusivamente en 127.0.0.1. Por diseño no es accesible directamente desde la instancia cloud de ChatGPT. La unión entre ambos lados se hace mediante RDC: ChatGPT ordena abrir la interfaz en el equipo local; la selección se realiza en Chrome y el texto resultante se devuelve a la conversación.

No se presupone automatización de clics del navegador por RDC. La interacción con la interfaz es del operador. El portal ofrece copia al portapapeles mediante la API del navegador y un área de texto alternativa cuando el portapapeles no está disponible.

## 2. Interfaz local disponible

Se conservarán separados el portal general de Product Design y el selector oficial de BMAD:

| Superficie | Dirección local | Responsabilidad |
|---|---|---|
| Portal Product Design | http://127.0.0.1:8766/ | Catálogo de agentes CIS, áreas de trabajo y puntos de entrada |
| Brain Selector original | http://127.0.0.1:8765/brain-selector.html | Selección de modalidad y técnicas de brainstorming |

**Activos creados en el entorno persistente:**

- app/index.html: portal de Product Design con seis agentes, cinco áreas de trabajo y dos configuraciones colaborativas.
- launchers/Start-BMAD-BrainSelector-EP.ps1: comprueba el HTML de BMAD, inicia los dos servidores locales si hacen falta, valida HTTP 200 y abre el portal en el perfil persistente de Chrome EP.
- Registro de ejecución: logs/Fila4/brain-selector-launch.json.
- Brain Selector original, sin copia ni modificación: MOD-EP-BMAD/app/node_modules/bmad-method/src/core-skills/bmad-brainstorming/assets/brain-selector.html.
- Perfil de Chrome: MOD-EP-CHROME/data/Fila4/user-data.

**Ejecución observada el 2026-11-13:** identidad Windows CENTRAL\fila4; Chrome 157.0.8103.51; ambos endpoints HTTP respondieron 200; el Brain Selector original respondió text/html y 244,638 bytes; el portal local respondió 200 y 15,943 bytes en la verificación de contenido. Los servidores quedaron iniciados en los puertos 8765 y 8766, enlazados a loopback. El lanzador se ejecutó nuevamente después de añadir la nota sobre estado de integración CIS.

**Límite del portal actual:** el catálogo y la interfaz están operativos, pero el paquete CIS todavía no está instalado localmente en MOD-EP-BMAD. Los botones de los agentes que no son Carson copian invocaciones para ChatGPT; no prueban por sí mismos la ejecución de esas habilidades. La integración de fuentes oficiales y el runtime de cada skill quedan pendientes.

### Flujo conversacional esperado

1. El operador invoca una necesidad de producto, diseño o ideación en ChatGPT.
2. ChatGPT identifica la fase y el agente adecuado; no fuerza brainstorming cuando la necesidad es analítica, estratégica o narrativa.
3. Cuando hace falta elegir agente o modalidad, ChatGPT utiliza RDC para abrir el portal local en Chrome.
4. El operador elige un agente. Carson abre el Brain Selector original de BMAD; los otros agentes presentan la invocación correspondiente en el portal.
5. Para Carson, el operador selecciona modalidad y técnicas en Brain Selector, pulsa Copy prompt y pega el resultado en ChatGPT.
6. ChatGPT ejecuta la técnica o workflow elegido. RDC proporciona acceso a métodos, documentación y persistencia local.
7. La sesión conserva ideas, preguntas, cambios de técnica, decisiones y procedencia.
8. Al cierre, se ofrece/genera el Brainstorm HTML Keepsake según las reglas de BMAD y la modalidad de sesión.

La interfaz queda abierta a añadir las fases y técnicas de otros agentes CIS, sin sustituir el catálogo original ni presentar como disponible un workflow que CIS no publique.

## 3. Brain Selector de BMAD

El activo local existente pertenece a bmad-method 6.12.4 y a la habilidad bmad-brainstorming. La inspección local de su catálogo y ejecución de brain.py categories confirmaron:

- 108 técnicas.
- 13 categorías.
- Tres modalidades: Facilitator, Creative Partner e Ideate for me.
- Selección de técnicas individuales, aleatorias, por recomendación del agente e invención de técnicas.
- Catálogo visual HTML, con filtros por categoría/objetivo y copia de un prompt de sesión.

El HTML oficial continúa siendo la fuente de verdad de la interfaz de brainstorming. El portal de Product Design lo enlaza; no replica su catálogo ni modifica el archivo instalado en node_modules.

### Modalidades

- **Facilitator:** el agente facilita, pregunta y provoca; las ideas son principalmente del operador.
- **Creative Partner:** el agente aporta ideas junto con el operador; debe atribuirse la autoría de cada aportación.
- **Ideate for me:** el agente realiza la exploración de forma autónoma y entrega la síntesis.

La modalidad elegida gobierna la sesión completa. La divergencia y la convergencia son fases distintas: no se prioriza ni descarta durante la generación de ideas.

### Persistencia de sesión

La habilidad usa un registro .memlog.md por sesión, con entradas cronológicas para ideas, preguntas, insights, decisiones, direcciones y técnicas utilizadas. El diseño exige append-only, autoría explícita cuando corresponde y reanudación leyendo el registro completo.

**Inconsistencia que debe resolverse antes de activar sesiones persistentes como flujo aceptado:** references/finalize.md ordena cambiar status a complete, mientras que la documentación del memlog.py instalado declara que el log no tiene estado de ciclo de vida modificable y prescribe registrar el cierre como un evento append-only. No se debe implementar ambas políticas sin conciliación.

## 4. Brainstorm HTML Keepsake

El Brainstorm HTML Keepsake sí está descrito en el workflow oficial de BMAD, pero no es una segunda aplicación preconstruida que deba abrirse al inicio.

Es un **entregable HTML autocontenido, generado al cierre de una sesión**, en el workspace de esa sesión. Debe reflejar el tema, las técnicas, las ideas y la síntesis; su tratamiento visual se adapta al contenido de la sesión y no depende de un template genérico.

Según references/finalize.md:

- En Ideate for me (y modo headless), la generación está prevista automáticamente.
- En Facilitator y Creative Partner, el Keepsake es opt-in; el agente lo recomienda y pregunta si se desea producir.
- El memlog es la fuente de la que derivan el Keepsake y otros artefactos.
- Puede producirse además un brainstorm-intent.md optativo para alimentar etapas posteriores como Product Brief o PRD.

Por tanto, el portal abre el Brain Selector; el Keepsake se produce por sesión, después de idear.

## 5. Catálogo CIS para Product Design V1.0

**Decisión del operador:** explorar uno por uno todos los agentes de CIS en V1.0, tal como los ofrece la suite. El catálogo no se reduce a Carson.

| Agente | Skill de agente | Workflow/capacidad principal | Estado documental |
|---|---|---|---|
| Carson | bmad-cis-agent-brainstorming-coach | Brainstorming (bmad-brainstorming) | Habilidad de agente; delega en BMAD Core. |
| Maya | bmad-cis-agent-design-thinking-coach | Design Thinking (bmad-cis-design-thinking) | Agente y workflow documentados. |
| Dr. Quinn | bmad-cis-agent-creative-problem-solver | Problem Solving (bmad-cis-problem-solving) | Agente y workflow documentados. |
| Victor | bmad-cis-agent-innovation-strategist | Innovation Strategy (bmad-cis-innovation-strategy) | Agente y workflow documentados. |
| Sophia | bmad-cis-agent-storyteller | Storytelling (bmad-cis-storytelling) | Agente y workflow documentados. |
| Caravaggio | bmad-cis-agent-presentation-master | PL, CR, EX, VM mediante prompts de agente | Agente y menú directo documentados; workflows empaquetados de presentación aparecen en desarrollo. |

Caravaggio ofrece cuatro acciones de menú:

- **PL:** planear una presentación, pitch o charla.
- **CR:** criticar un deck, slide o visual.
- **EX:** crear el guion de un video explicativo.
- **VM:** escoger el recurso visual apropiado (visualización de datos, diagrama, metáfora visual o imagen).

La suite también documenta configuraciones colaborativas como **Creative Squad** y **Design Pair**. La composición y el comportamiento exactos deben leerse desde los archivos oficiales de CIS; no se inventará su roster a partir del nombre.

### Fases que el portal debe poder seleccionar

1. Brainstorming / ideación divergente — Carson.
2. Design Thinking — Maya.
3. Diagnóstico y resolución de problemas — Dr. Quinn.
4. Innovación y estrategia — Victor.
5. Storytelling — Sophia.
6. Comunicación visual y presentaciones — Caravaggio.

La lista es un catálogo de capacidades publicadas por CIS, no una secuencia rígida ni una afirmación de que todos los workflows estén instalados o probados localmente.

### Versiones y compatibilidad

- BMAD Core local: **6.12.4**, verificado en package.json.
- El manifiesto bmod.toml de Carson en CIS recomienda bmad-brainstorming versión **6.13.0**.
- Se debe resolver la compatibilidad/alineación de versiones antes de integrar y aceptar el conjunto CIS completo. No se actualiza BMAD automáticamente como parte de este diseño.

Repositorio oficial consultado: bmad-code-org/bmad-module-creative-intelligence-suite, commit 658e71030be808181c1031f5461ee3613e7ff530.

## 6. Capacidades que quedan separadas

La IAR (Ideación Asíncrona Recuperable) es una facultad distinta: conservar y recuperar ideas dispersas, agrupadas y con su evolución temporal. No forma parte del selector HTML ni se incorpora aquí como implementación del lienzo visoespacial.

La proyección cognitiva visoespacial también se mantiene fuera del alcance funcional inicial del portal. Su material se conserva y organiza en FUENTES-CAPACIDADES-VISOESPACIALES.md.

La categoría futura agrupa las operaciones visoespaciales, la tríada de proyección visual, la gramática D-PROY y las ideas de taxonomía espacial emergente. Se programa en una etapa ulterior, después de resolver los componentes esenciales del flujo Product Design. No se crea ahora tarea, número de secuencia ni prioridad cuantificada.

## 7. Límites y pendientes de integración

1. Instalar/sincronizar localmente los seis skills de agente y los workflows CIS que estén disponibles.
2. Alinear BMAD Core 6.12.4 con la versión de brainstorming recomendada por CIS (6.13.0) y ejecutar pruebas de compatibilidad.
3. Implementar la detección de intención en ChatGPT y el despacho RDC al lanzador sin depender de comandos manuales del operador.
4. Hacer que la invocación de cada agente cargue las instrucciones y fuentes oficiales correspondientes desde el entorno persistente.
5. Validar selección/copia de prompts en Chrome y el fallback de área de texto; esa interacción de portapapeles no se ha probado todavía.
6. Conciliar la política de cierre memlog descrita arriba.
7. Probar el circuito completo ChatGPT → RDC → portal → agente/workflow → persistencia → reanudación → Keepsake.
8. No presentar como implementado el lienzo visoespacial ni la IAR.

## 8. Estado de planeación

Este archivo acumula decisiones, evidencia y límites para el posterior desglose del Frente Product Design. **No constituye una tarea provisional** ni las crea. Las tareas se configurarán cuando el operador indique vaciar el acumulado, ordenando primero lo esencial y dejando la categoría visoespacial para una etapa ulterior.
