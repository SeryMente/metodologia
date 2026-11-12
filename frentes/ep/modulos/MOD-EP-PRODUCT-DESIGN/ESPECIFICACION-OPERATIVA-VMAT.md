# Especificación operativa vMAT Product Design

**Módulo propietario:** `MOD-EP-PRODUCT-DESIGN` (módulo funcional interno de EP; invocación «Frente Product Design»).  
**Estado:** especificación funcional inicial, derivada de instrucción expresa del operador.  
**Alcance rector:** convertir dictados del operador en ChatGPT en tareas provisionales mínimas, exhaustivas, trazables y ejecutables en los frentes existentes; preparar su ejecución con BMAD y Superpowers a través de OpenCode.  
**No constituye:** un FT independiente, un gestor general de proyectos, una nueva metodología transversal ni una autorización para ejecutar trabajos no comprendidos en el dictado.

## 1. Resultado de uso esperado

El operador trabaja desde una conversación de ChatGPT y dicta la instrucción. ChatGPT conserva el texto fuente exactamente como fue recibido, determina qué frente y módulo existentes son responsables, extrae sus requisitos explícitos y crea las tareas provisionales correspondientes en el contenedor canónico del frente. Cada tarea debe cubrir todo lo que puede extraerse de la instrucción, sin añadir objetivos, funcionalidades, decisiones o trabajo que el operador no haya solicitado.

Las tareas quedan preparadas para ser ejecutadas por el agente local y las herramientas del frente. ChatGPT coordina la captura, la asignación, la trazabilidad, el control de alcance y la verificación; OpenCode ejecuta en el entorno local; BMAD aporta sus flujos de producto y desarrollo cuando sean pertinentes; Superpowers aporta el método de ingeniería y las habilidades de ejecución/revisión.

## 2. Arquitectura funcional y responsabilidad de cada componente

| Componente | Responsabilidad en vMAT | Lo que no debe atribuirse |
|---|---|---|
| ChatGPT | Entrada conversacional del dictado, preservación verbatim, extracción, asignación al frente, creación/actualización de tareas, coordinación y verificación mediante conectores autorizados | No tiene las skills nativas de Superpowers instaladas por el mero hecho de leer sus documentos |
| Repositorio canónico Metodología | Fuente persistente de las tareas provisionales de EP, del módulo vMAT y de la especificación; conserva enlaces y procedencia | No es una copia local ni prueba por sí solo que todos los artefactos locales estén sincronizados |
| RDC | Acceso del asistente al equipo, al workspace y a los procesos autorizados | No convierte skills locales en capacidades nativas de ChatGPT; tampoco equivale por sí mismo a aislamiento de permisos |
| MOD-EP-BMAD | Descubrimiento, brief, especificación, PRD, UX, arquitectura, historias, planificación y workflows BMAD ya instalados | No duplica el agente ni sustituye el registro provisional de tareas |
| MOD-EP-OPENCODE | Motor de agente local, sesiones, lanzadores, configuración y conexión Groq | No es el registro de tareas del frente |
| Superpowers | Skills de diseño de trabajo, planificación, aislamiento, ejecución, TDD, depuración, revisión y verificación para el agente compatible | No reemplaza el dictado verbatim, la asignación metodológica ni el control de alcance de vMAT |
| Groq | Proveedor de modelo utilizado por OpenCode, mediante la configuración nativa existente y la credencial EP Vault | No es el gestor de tareas ni el repositorio de instrucciones |

## 3. Contrato de preservación verbatim

1. Conservar el mensaje fuente exactamente, incluidos idioma, redacción, puntuación, mayúsculas, errores tipográficos, repeticiones, espacios y saltos de línea que formen parte del texto recibido.
2. No corregir, resumir ni normalizar el texto fuente. Las interpretaciones se guardan en una sección derivada separada.
3. Asignar una referencia local de procedencia al mensaje y relacionarla con cada tarea derivada. Esa referencia no es un folio global, UUID nativo ni autorización.
4. Mantener una matriz fuente → fragmento/requisito → tarea → entregable → criterio de aceptación. Ningún requisito explícito puede quedar sin cobertura y ningún alcance derivado puede carecer de soporte en la fuente.
5. Preservar instrucciones de seguridad, restricciones, límites, condiciones y exclusiones en su sentido y alcance originales. No convertir una posibilidad mencionada en un requisito.
6. Cuando una tarea agrupe varios requisitos dependientes, registrar todos los vínculos. Cuando haya resultados independientes que puedan ejecutarse por separado, separarlos solo si esa separación mejora la ejecución y no fragmenta artificialmente una solución coherente.
7. Si la instrucción no define una condición material necesaria, no inventarla. Crear la parte verificable y marcar el punto material como pendiente, o formular una sola pregunta concreta cuando no sea posible avanzar sin esa respuesta.

## 4. Regla de descomposición mínima y exhaustiva

La unidad de descomposición es el resultado ejecutable, no cada frase ni cada verbo. Aplicar este orden:

1. Identificar el objetivo y los resultados expresamente pedidos.
2. Extraer entregables, capacidades, restricciones, dependencias, autorizaciones y condiciones de aceptación explícitas.
3. Identificar el frente/módulo existente que tiene responsabilidad funcional sobre cada resultado.
4. Agrupar requisitos que formen una única solución coherente; separar resultados que tengan distinta responsabilidad o puedan aceptarse independientemente.
5. Crear el menor número de tareas que permita ejecutar y verificar todos los resultados solicitados.
6. Verificar cobertura completa de la instrucción y ausencia de alcance no solicitado.
7. Registrar expresamente cualquier elemento que se haya dejado fuera porque la instrucción lo presentó como opcional, posibilidad o fuera de alcance.

No crear un frente u OCP nuevo para resolver un vacío de asignación. Buscar primero el frente existente; si la asignación no es inequívoca, conservar el requisito sin atribuirlo falsamente y resolver solo la parte no ambigua.

## 5. Estructura mínima de cada tarea provisional

Cada tarea debe mantener, dentro del README individual del contenedor provisional del frente:

- Identificador local estable y estado provisional.
- Frente y módulo responsable, con vínculo al OCP padre.
- Enunciado ejecutivo del resultado que se debe lograr.
- Fuente verbatim íntegra o vínculo inequívoco al archivo que la conserva.
- Matriz de trazabilidad de requisitos/fragmentos a tareas, entregables y aceptación.
- Objetivo y alcance incluido.
- Exclusiones justificadas por la instrucción fuente.
- Dependencias reales y condiciones de inicio.
- Plan ejecutable con pasos pequeños, rutas y herramientas pertinentes.
- Pruebas y criterios verificables de aceptación.
- Evidencias, resultados, hashes/read-back cuando aplique.
- Crónica acumulativa del avance y siguiente acción.

El índice del frente resume ID, estado, enunciado y enlace. No se crea una bitácora, tablero u objeto de estado paralelo. Cada tarea hereda el control, la autoridad y el OCP de su frente padre.

## 6. Flujo de operación desde ChatGPT

### A. Captura

Recibir el dictado del operador como texto fuente. No pedir que lo vuelva a escribir en otra plantilla. Cuando el usuario dicte por voz, trabajar con la transcripción disponible y declarar cualquier incertidumbre real de reconocimiento; no inventar palabras que no estén presentes.

### B. Interpretación y asignación

Extraer objetivos, resultados, límites, restricciones y autorización. Consultar el índice canónico de frentes y módulos para asignar cada resultado al destino existente. Distinguir una orden de ejecución, una solicitud de diseño, una opción mencionada y una posibilidad futura.

### C. Trazabilidad y creación

Crear el número mínimo de tareas que cubra la instrucción, usando el contenedor provisional del frente correspondiente. Preservar el dictado verbatim en el núcleo de la tarea o en un original vinculado. Actualizar el índice y leer de vuelta cada archivo creado o modificado.

### D. Plan y ejecución

Preparar un plan ejecutable en pasos pequeños y verificables. Usar la skill de Superpowers pertinente al tipo de trabajo. Delegar en subagentes solo cuando las partes sean independientes y no compartan estado mutable. Ejecutar únicamente dentro de la autorización y de los gates del frente. La existencia de una tarea no autoriza por sí sola una operación que la instrucción no haya autorizado.

### E. Revisión y cierre

Revisar cada resultado contra el dictado fuente y los criterios de aceptación. Ejecutar pruebas y lectura de vuelta; no confiar únicamente en el reporte del agente. Registrar evidencia. No marcar una tarea como completada si no satisface todos sus criterios o si no existe evidencia de ejecución.

## 7. Capacidades de Superpowers adoptadas

**Versión de referencia:** Superpowers `v7.0.2`, release oficial no prerelease, configurada para OpenCode V1 mediante la clave `plugin`. La instalación local de OpenCode es `1.19.5`; no se actualiza de versión como parte de esta especificación.

| Skill | Uso dentro de vMAT |
|---|---|
| `using-superpowers` | Bootstrap que instruye al agente para detectar y cargar skills relevantes antes de actuar |
| `brainstorming` | Aclarar propósito o decisiones de producto solo cuando la respuesta cambie el resultado y no esté resuelta por el dictado |
| `writing-plans` | Convertir el alcance aprobado en pasos pequeños, rutas, cambios y verificaciones concretas |
| `using-git-worktrees` | Aislar trabajo de código cuando exista un repositorio Git y la configuración del frente lo permita |
| `subagent-driven-development` | Ejecutar tareas independientes con subagente por tarea y revisión en cada etapa |
| `executing-plans` | Alternativa de ejecución en línea cuando subagentes no aporten valor o no estén disponibles |
| `dispatching-parallel-agents` | Paralelizar únicamente dominios realmente independientes y sin estado compartido |
| `test-driven-development` | Aplicar RED–GREEN–REFACTOR y probar primero el comportamiento esperado |
| `systematic-debugging` | Investigar causas raíz mediante proceso sistemático, no correcciones por tanteo |
| `requesting-code-review` | Solicitar revisión del trabajo frente a plan/requisitos y corregir hallazgos importantes |
| `receiving-code-review` | Evaluar y responder técnicamente a las observaciones recibidas |
| `verification-before-completion` | Exigir evidencia nueva antes de afirmar que algo funciona o está terminado |
| `finishing-a-development-branch` | Verificar el resultado y presentar el estado final de la rama; merge/PR solo conforme a autorización |
| `diagnosing-superpowers` | Diagnosticar fallos de activación o comportamiento de las propias skills usando evidencia de sesión |
| `writing-skills` | Crear o modificar skills solo cuando el resultado requerido sea explícitamente extender el catálogo de habilidades |

**Regla:** no ejecutar todas las skills mecánicamente en cada tarea. Seleccionar el flujo que corresponda al tipo de trabajo, conservar sus gates y documentar cuándo una skill no aplica. La lluvia de ideas no debe retrasar dictados completos; las preguntas se reservan para decisiones materiales no resueltas por la fuente.

## 8. Encaje de BMAD y Superpowers

BMAD y Superpowers cumplen funciones complementarias:

- BMAD se emplea cuando el resultado requiere descubrimiento, definición de producto, PRD, UX, arquitectura, épicas/historias o workflows de desarrollo del método.
- Superpowers gobierna el método de trabajo del agente al diseñar un plan, aislar código, ejecutar, probar, depurar, revisar y verificar.
- vMAT es la capa de entrada y trazabilidad que conserva el dictado y lo transforma en tareas de los frentes. No duplica los workflows ni las skills de BMAD o Superpowers.

## 9. Fuera de alcance inicial

No incorporar por anticipación funciones que el operador dejó como posibilidades: gestor general de proyectos, tableros paralelos, automatización programada o en segundo plano, supervisión permanente, analítica, sincronización universal de cuentas, scraping, despliegues o administración autónoma de todos los repositorios. Solo se incorporarán si un dictado futuro lo solicita.

## 10. Evidencia inicial y estado de integración

- Superpowers upstream: `obra/superpowers`, release `v7.0.2`, etiqueta oficial publicada como release no prerelease el 2026-11-03.
- Configuración de OpenCode V1: `MOD-EP-OPENCODE/config/Fila4/xdg-config/opencode/opencode.json`; proveedor/modelo existente preservado y añadido `superpowers@git+https://github.com/obra/superpowers.git#v7.0.2`.
- SHA-256 del `opencode.json` tras añadir el plugin: `14A8F3D0A91B53AEDB47CF359025771D72CBAFAE142094099668569A1AB04096`.
- Respaldo previo: `opencode.json.pre-superpowers-v7.0.2-20261112.bak`; SHA-256 `5F24F3F43822C65113D9EEEC71AAFD67EC96287C7068679E52E4BE89DF777CC6`.
- El paquete `superpowers` quedó descargado en el caché aislado de OpenCode, tag `v7.0.2`; se observaron los 15 directorios de skill.
- La autenticación Groq se obtuvo a través de EP Vault en el contexto `CENTRAL\fila4`; el launcher mantuvo la credencial en memoria de proceso.
- La carga runtime y el descubrimiento efectivo de skills deben considerarse aceptados solo después de una respuesta del agente que enumere skills realmente descubiertas. La mera presencia del paquete o de la configuración no basta.

## 11. Criterios de aceptación de vMAT

1. Un dictado realizado en ChatGPT llega al flujo sin exigir que el operador lo vuelva a escribir en una plantilla.
2. El texto fuente se conserva verbatim y separado de la interpretación.
3. Cada requisito explícito tiene vínculo a una tarea, entregable y criterio de aceptación.
4. La descomposición es mínima y exhaustiva: no omite alcance extraíble ni agrega trabajo no solicitado.
5. Las tareas se crean en el registro provisional del frente responsable y se enlazan en su índice.
6. Cada tarea puede retomarse desde su README sin depender de la memoria conversacional.
7. La ejecución utiliza BMAD cuando aporta procesos de producto y Superpowers para las skills de ingeniería aplicables.
8. OpenCode descubre y carga realmente Superpowers v7.0.2 con su integración oficial V1 y el proveedor Groq existente.
9. Cada tarea implementada pasa revisión, prueba y verificación con evidencia antes de cerrarse.
10. No se crean frentes, OCP, controles de responsabilidad ni almacenes de estado paralelos.



## Estado real del runtime al cierre de este ciclo · 2026-11-12

La configuración del plugin V1 y el paquete Superpowers v7.0.2 quedaron verificados localmente, incluidos 15 directorios de skills en el caché. El primer lanzamiento OpenCode se inició con sesión EP Vault activa, pero no devolvió una enumeración de skills y acabó con código 1 después de no mostrar progreso observable. Un segundo lanzamiento fue bloqueado antes de iniciar OpenCode porque la sesión EP Vault había expirado (`VAULT_SESSION_NOT_OPEN`). No se obtuvo ni se usó una contraseña maestra y no se expuso la API key. Por ello, la integración runtime permanece pendiente de desbloquear EP Vault localmente bajo `CENTRAL\fila4` y repetir la comprobación con evidencia de skills descubiertas. La configuración del plugin no equivale a aceptación runtime.
