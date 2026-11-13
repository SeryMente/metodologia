# EP-TASK-009 — Carson conversacional en ChatGPT con motor BMAD Brainstorming

**ID local:** EP-TASK-009  
**Estado:** `en_curso · CARSON_CHAT_PROFILE_CREATED_READBACK_VERIFIED · LIVE_SESSION_ACCEPTANCE_PENDING`  
**Prioridad/secuencia:** Alta · primer hito funcional  
**Frente propietario:** Entorno Persistente (EP)  
**Módulo:** MOD-EP-PRODUCT-DESIGN  
**OCP padre:** frentes/ep/OEP.md  
**Núcleo:** este README es la especificación y crónica acumulativa única de la tarea. No crea otro FT, OCP ni control.

## Enunciado ejecutivo

Entregar una herramienta de lluvia de ideas madura que el operador pueda iniciar y utilizar directamente desde la conversación ordinaria de ChatGPT. La primera versión usa la identidad de Carson de CIS como coach conversacional y el motor BMAD Core bmad-brainstorming como método de ideación. No requiere Brain Selector, Keepsake, portal, dashboard ni OpenCode.

## 1. Fuente rectora — instrucción literal

**Fuente:** SRC-PD-20261113-IDEACION-03 · instrucción directa del operador · 2026-11-13.  
**Ubicación canónica:** MOD-EP-PRODUCT-DESIGN/SPRINT-GENERAL-PRODUCT-DESIGN.md §18.  
**Regla:** conservar grafía, puntuación, errores de transcripción y saltos de línea; la lectura normalizada se mantiene fuera del bloque.

~~~text
Bueno, vamos a empezar con una implementación que me permita acceder a una herramienta para lluvia de ideas madura, apoyada en las habilidades, el motor de Carson para la primera versión vía chat prescindiendo de los elementos extras que son Brain Selector, Rush HTML Keep Safe. Nada más acota los resultados de tu investigación en cuanto a estos dos elementos en las tareas provisionales de baja prioridad, las que van a estar más adelante en la secuencia en el frente

El autoguardado tipo Office y la biblioteca indexada no tiene que ser al carácter, sino por ciclo. Hacer un guardado básico del proyecto en curso autonombrándolo si el usuario no aporta alguna denominación y etiquetándolo de manera esencial. Es decir como es un módulo de lluvia de ideas, lo que yo estoy tratando de hacer es disponer de una persistencia de los borradores de las ideas que trabaje a veces de manera incompleta o poco finalizada, así como de las más maduras que también podré trabajar de manera profunda con la ayuda de la herramienta. Y disponer de estos diseños hasta el fin de los tiempos sin tener miedo a que se pierdan esas ideaciones. Por cierto, qué bueno que me acuerdo. Este módulo tiene que conectarse con la prótesis cognitiva. Pero bueno, de eso me encargo después porque sería demasiado para mantener el hilo con tanta divergencia. Ahora, ¿por qué le pones continuidad AB? ¿Eso qué tiene que ver? Resuelve el autoguardado, por así decirlo, y la biblioteca de manera que tengamos un marco esencial apegado única y estrictamente a lo necesario. Creo que con estas instrucciones tienes lo necesario para completar el diseño y verificar y garantizar la integridad del mismo antes de la ejecución
~~~

## 2. Matriz de trazabilidad

| Requisito derivado | Entrega específica | Criterio de aceptación |
|---|---|---|
| Acceso por chat | Perfil conversacional Carson en prompts/CARSON-CHAT.md | El operador invoca Carson o inicia una lluvia de ideas sin portal ni selector. |
| Motor de brainstorming | Adaptación del flujo BMAD bmad-brainstorming | El agente usa técnicas BMAD pertinentes, no una lista inventada ni un flujo de preguntas genérico. |
| Tres modos | Facilitator, Creative Partner e Ideate for me | Cada modo distribuye correctamente la generación de ideas y conserva autoría. |
| Técnicas adecuadas | Consulta selectiva del catálogo local | Se proponen normalmente 3–4 técnicas por tanda; no se expone el catálogo completo ni se exige explorarlo. |
| Divergencia y convergencia | Fases diferenciadas | No se evalúa ni descarta prematuramente durante la divergencia; la convergencia se activa por petición o señal suficiente. |
| Ideas verdes y maduras | Registro completo del contenido significativo | Las formulaciones incompletas no se reemplazan por resúmenes ni se descartan; una síntesis se conserva aparte. |
| Operación sobria | Comunicación adaptada al operador | Una pregunta por turno cuando sea necesaria; no formularios, menús largos ni celebración artificial. |
| Exclusiones iniciales | Sin Brain Selector, Keepsake, portal ni OpenCode | El primer flujo se puede ejecutar en chat sin esos elementos. |

## 3. Base técnica observada

- Fuente CIS oficial de Carson: bmad-code-org/bmad-module-creative-intelligence-suite, commit 658e71030be808181c1031f5461ee3613e7ff530.
- SKILL Carson leído: blob ec4d56fe1c0a13b52c481bdc6b27ff1c7c1fd2b4.
- customize.toml de Carson leído: blob f5d5f24a42e15dcf605c293312f64c3c47eaf16f. Carson aparece como Elite Brainstorming Specialist, con entrada BS que delega a bmad-brainstorming.
- BMAD Core local 6.12.4: existe el archivo src/core-skills/bmad-brainstorming/SKILL.md y los recursos asociados bajo MOD-EP-BMAD.
- brain.py categories ejecutado en CENTRAL\fila4 devolvió 13 categorías y 108 técnicas (suma de los conteos mostrados).
- La identidad de Carson es una capa de coach; el motor que ejecuta la metodología es BMAD Brainstorming. No se afirma que CIS esté instalado como runtime nativo en ChatGPT.
- Perfil conversacional materializado en [CARSON-CHAT.md](../../modulos/MOD-EP-PRODUCT-DESIGN/prompts/CARSON-CHAT.md), Git blob ef334c36d002e11c22b2de156fbff4775a3b56f3, lectura de vuelta exacta.

## 4. Alcance y exclusiones

Incluye activación por chat, enmarcado del reto, selección de modo, técnicas, divergencia, convergencia, síntesis y conservación de autoría.

No incluye todavía autoguardado durable ni biblioteca activa; pertenecen a EP-TASK-010 y son necesarios para declarar integrado el módulo completo. En esta tarea no se declara persistencia después de cerrar o perder esta conversación.

No incluye Brain Selector (EP-TASK-011), Keepsake HTML (EP-TASK-012), los otros cinco agentes CIS, la Prótesis Cognitiva, ni cualquier portal. Superpowers queda exclusivamente como referencia conceptual, no como herramienta operativa.

## 5. Secuencia de aceptación

1. Invocar Carson por nombre desde un chat normal.
2. Ejecutar un caso breve en cada modo y comprobar comportamiento/autoría.
3. Ejecutar al menos una tanda de técnicas de BMAD desde el catálogo local.
4. Interrumpir una sesión y comprobar que el contexto de la conversación mantiene el punto de trabajo; la reanudación durable se acepta en EP-TASK-010.
5. Verificar que ninguna fase abre Brain Selector, portal o Keepsake.
6. Registrar hallazgos, limitaciones, evidencia y decisión de aceptación.

## 6. Límites y seguridad

- No tocar Chrome ni cambiar de perfil para iniciar el chat.
- No modificar ni desinstalar configuraciones históricas de OpenCode/Superpowers.
- No afirmar que un perfil conversacional equivale a un modelo nuevo o a un runtime CIS instalado.
- No presentar un borrador como guardado duradero hasta que EP-TASK-010 lo confirme.
- Las habilidades Superpowers solo se consultan como referencia para desarrollos propios y no se importan como runtime.

## 7. Crónica acumulativa

### Ciclo de diseño e inicialización · 2026-11-13

- Fuente literal: SRC-PD-20261113-IDEACION-03, reproducida en §1 y en el sprint §18.
- Se revisó el OCP Harmonia v0.46 y su README. La trazabilidad se expresa con fuente literal, matriz, estado, aceptación, evidencias y crónica; no se encontró un índice independiente de tareas dentro de la raíz Harmonia. La materialización de tareas se mantiene por el índice EP y un README por tarea.
- Se leyó la fuente oficial CIS Carson y su configuración; se verificó que la opción BS delega a BMAD Brainstorming.
- Se comprobó en el host CENTRAL\fila4 la presencia de BMAD Core 6.12.4 y se ejecutó brain.py categories: 108 técnicas/13 categorías.
- Se creó CARSON-CHAT.md y se hizo lectura de vuelta exacta. No se modificó el paquete BMAD instalado ni se ejecutó una instalación CIS.
- Estado: perfil conversacional preparado; prueba funcional con una sesión real aún pendiente.
- Siguiente acción: probar Carson en conversación con un tema del operador; registrar evidencia sin afirmar todavía aceptación.
