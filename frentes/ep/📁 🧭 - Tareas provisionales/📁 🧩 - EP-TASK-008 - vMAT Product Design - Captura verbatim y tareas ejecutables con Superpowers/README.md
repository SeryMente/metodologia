# EP-TASK-008 — vMAT Product Design: captura verbatim y tareas ejecutables con Superpowers

**ID local:** EP-TASK-008.  
**Estado:** `en_curso` · diseño funcional y configuración inicial de Superpowers materializados; aceptación de runtime y flujo completo pendientes.  
**Frente propietario:** Entorno Persistente (EP).  
**Módulo funcional:** `MOD-EP-PRODUCT-DESIGN`, invocable como «Frente Product Design».  
**Contenedor provisional:** `frentes/ep/📁 🧭 - Tareas provisionales/`.  
**OCP padre:** `frentes/ep/OEP.md`.  
**Especificación de producto:** [ESPECIFICACION-OPERATIVA-VMAT.md](../../modulos/MOD-EP-PRODUCT-DESIGN/ESPECIFICACION-OPERATIVA-VMAT.md).

## Enunciado ejecutivo

Implementar vMAT Product Design para que el operador pueda dictar instrucciones directamente en ChatGPT y obtener, sin reescribirlas ni someterse a una plantilla, el número mínimo de tareas provisionales que agote íntegramente lo solicitado, sin añadir alcance. Cada tarea debe preservar el dictado verbatim, identificar el frente/módulo responsable, vincular cada requisito con entregables y criterios de aceptación y quedar preparada para ejecución. BMAD se reutiliza para los procesos de producto pertinentes y Superpowers para el flujo de ingeniería del agente OpenCode/Groq: planificación, aislamiento, ejecución, subagentes cuando sean útiles, TDD, depuración, revisión, verificación y cierre.

## 1. Fuente rectora — dictado verbatim

**Referencia local de fuente:** `SRC-VERBATIM-EP-2026-11-12-VMAT-01`.  
**Procedencia:** instrucción directa del operador en la conversación actual, 2026-11-12.  
**Integridad:** el siguiente bloque es la fuente literal; no corregir ni normalizar. Las decisiones derivadas se registran fuera de este bloque.

```text
Ok, la implementación debe de permitirme rápidamente usar la plataforma ChatGPT para poblar tareas  en los frentes de trabajo que puedan ser ejecutadas para resolver las soluciones basándose en las instrucciones verbatim que yo dicte en la plataforma. Ese va a ser el uso que se le tiene. Además, debe adecuarse a lo que ya ofrece el complemento Superpowers. Revisa Superpowers y las herramientas que ofrece. Esas son las cosas que yo quiero resolver con la implementación de mi vMAT de product design. Otras pueden ser dejadas de lado como posibilidades, pero por lo pronto esas las que ofrece Superpowers son las cosas que yo quiero desarrollar con mi implementación de vMAT de product design. Asegúrate que la implementación se ajuste a esto que te acabo de decir. Luego, a partir de ahora vas a crear tareas provisionales en el frente de trabajo que van a estar construidas de manera trazable a las instrucciones verbatim que yo dicto. Siempre las tareas provisionales deben de estar hechas para que agoten las instrucciones verbatim sin dar más, pero tampoco menos de lo que se puede extraer de las instrucciones. Entonces, haz esto que te acabo de decir y como ya es el último ciclo antes de irme, ya no te voy a poder dar instrucciones. Resuelve de extremo a extremo y no te detengas a menos que, no te detengas con bloqueos triviales. Tienes autorización previa para cualquier cosa que necesites. Usa ambas conexiones RDS que están disponibles y resuelve la implementación conforme lo dicho. Adiós.
```

## 2. Matriz de trazabilidad fuente → alcance ejecutable

| Requisito extraído de la fuente | Trabajo exigido | Resultado verificable |
|---|---|---|
| Usar ChatGPT rápidamente como entrada | Incorporar un flujo conversacional de captura directa, sin plantilla ni reescritura manual | Un dictado de ChatGPT produce una tarea persistida |
| Poblar tareas en frentes existentes | Descubrir el frente/módulo responsable y utilizar su contenedor provisional canónico | Índice del frente actualizado y tareas enlazadas |
| Basarse en instrucciones verbatim | Preservar literalmente el mensaje fuente y separarlo de toda interpretación | Bloque fuente íntegro en el núcleo de cada tarea o fuente vinculada inequívocamente |
| Adecuarse a Superpowers | Revisar e integrar sus skills aplicables en OpenCode | Plugin configurado en versión fijada, paquete descargado y prueba de skills |
| Resolver con vMAT Product Design | Definir el proceso de intake, asignación, descomposición, plan y aceptación | Especificación operativa dentro de MOD-EP-PRODUCT-DESIGN |
| Dejar otras posibilidades de lado | Excluir capacidades no solicitadas | Lista explícita de fuera de alcance |
| Crear tareas provisionales desde ahora | Establecer el procedimiento recurrente de creación | EP-TASK-008 creada; regla operativa recogida en la especificación |
| Agotar lo extraíble sin añadir ni omitir | Implementar control de cobertura y anti-expansión del alcance | Matriz requisito → tarea → entregable → aceptación y revisión de cobertura |
| Resolver el ciclo con las conexiones disponibles | Inspeccionar y usar ambas conexiones RDC según su identidad real | Evidencia de cada conexión y separación de tareas por identidad Windows |

## 3. Alcance incluido

1. Captura directa de dictados de ChatGPT y preservación verbatim.
2. Extracción separada de objetivos, requisitos, entregables, restricciones, dependencias, autorización y criterios de aceptación.
3. Asignación a frentes/módulos existentes, sin crear frentes ni OCP por defecto.
4. Descomposición mínima y exhaustiva en tareas provisionales ejecutables.
5. Registro de la fuente verbatim, matriz de trazabilidad, plan, pruebas y crónica en el README de cada tarea.
6. Actualización del índice del frente y lectura de vuelta de los archivos.
7. Integración funcional del método Superpowers con OpenCode y el proveedor Groq existente.
8. Reutilización de BMAD cuando se necesite descubrimiento, definición de producto, PRD, UX, arquitectura o planificación.
9. Ejecución con aislamiento, TDD, depuración sistemática, revisión y verificación antes de declarar terminado.
10. Informe verificable del trabajo y del estado de aceptación.

## 4. Exclusiones de este encargo

No incluir gestor general de proyectos, tablero paralelo, automatización en segundo plano, supervisión permanente, sincronización universal de cuentas/equipos, scraping, despliegues, analítica ni módulos adicionales que no se desprendan directamente de la instrucción. No cambiar la taxonomía de EP ni crear un FT independiente para Product Design.

## 5. Modelo operativo exigido

**ChatGPT (entrada y coordinación) → tarea provisional en el frente → BMAD cuando corresponda → OpenCode + Superpowers + Groq para ejecución → pruebas/revisión/verificación → evidencia y actualización del núcleo de tarea.**

- ChatGPT conserva y traza el dictado, crea la tarea y controla que no haya deriva.
- BMAD aporta el proceso de producto y los workflows ya instalados.
- Superpowers aporta skills de ingeniería y ejecución del agente.
- OpenCode ejecuta las skills y comandos locales.
- Groq es el proveedor de modelo de OpenCode.
- RDC permite que ChatGPT alcance el host y recupere resultados; no convierte las skills locales en herramientas nativas de ChatGPT.
- El repositorio canónico conserva las tareas y la documentación del módulo.

## 6. Superpowers revisado

**Fuente oficial:** `obra/superpowers`; release actual consultada `v7.0.2`, publicada como release no prerelease.  
**Compatibilidad objetivo:** OpenCode V1; configuración oficial mediante la propiedad `plugin`. OpenCode local `1.19.5` se conserva.

Skills observadas en el paquete `v7.0.2` (15):

- `using-superpowers`: bootstrap y selección de skills.
- `brainstorming`: aclaración de intención/decisiones materiales.
- `writing-plans`: planes de implementación por tareas pequeñas.
- `using-git-worktrees`: aislamiento de trabajo.
- `subagent-driven-development`: ejecución por subagentes con revisión.
- `executing-plans`: ejecución de planes en línea.
- `dispatching-parallel-agents`: paralelismo de tareas independientes.
- `test-driven-development`: RED–GREEN–REFACTOR.
- `systematic-debugging`: análisis de causa raíz.
- `requesting-code-review`: revisión de cambios.
- `receiving-code-review`: procesamiento de feedback.
- `verification-before-completion`: prueba fresca antes de afirmar éxito.
- `finishing-a-development-branch`: cierre de rama y alternativas de entrega.
- `diagnosing-superpowers`: diagnóstico del propio complemento.
- `writing-skills`: creación/prueba de skills nuevas cuando sea explícitamente requerido.

La implementación usará la skill pertinente, no todas mecánicamente. La ideación y las preguntas de aclaración se omiten cuando el dictado ya resuelve la decisión; solo se pregunta cuando la respuesta cambiaría materialmente el resultado y no existe evidencia suficiente.

## 7. Evidencia y cambios ejecutados en este ciclo

### 7.1 Conexiones RDC

Se detectaron dos conexiones Online con el mismo rótulo de equipo `PC10RCIF4EI4`, pero identidades Windows diferentes:

| Conexión | Identidad efectiva | Uso válido |
|---|---|---|
| RDC A · `952ad493-0a54-48a8-b0a2-de7aba24b0e4` | `CENTRAL\MantenimientoRCI` | Inspección administrativa y acceso al host |
| RDC B · `5182a6bc-db2c-452e-a52a-95d63f6c74d6` | `CENTRAL\fila4` | Operaciones que requieren DPAPI CurrentUser y EP Vault |

Ambas conexiones alcanzan el mismo host físico observado. No acreditan dos equipos físicos.

### 7.2 Configuración Superpowers

- Respaldo previo creado: `MOD-EP-OPENCODE/config/Fila4/xdg-config/opencode/opencode.json.pre-superpowers-v7.0.2-20261112.bak`.
- Configuración activa: `MOD-EP-OPENCODE/config/Fila4/xdg-config/opencode/opencode.json`.
- Modelo preservado: `groq/openai/gpt-oss-120b`.
- Plugin añadido: `superpowers@git+https://github.com/obra/superpowers.git#v7.0.2`.
- SHA-256 de configuración activa: `14A8F3D0A91B53AEDB47CF359025771D72CBAFAE142094099668569A1AB04096`.
- SHA-256 del respaldo previo: `5F24F3F43822C65113D9EEEC71AAFD67EC96287C7068679E52E4BE89DF777CC6`.
- El paquete `superpowers` se descargó al caché de OpenCode fijado a `v7.0.2`; se comprobaron físicamente los 15 directorios de skills.
- El launcher Groq/EP Vault se ejecutó bajo `CENTRAL\fila4`; informó `EP_VAULT_SESSION=ACTIVE`, `SECRET_HANDLING=PROCESS_MEMORY_ONLY` y modelo Groq `groq/openai/gpt-oss-120b`. No se mostró el secreto.
- **No declarar todavía prueba de skills Runtime PASS:** el proceso de consulta a OpenCode seguía activo y no había devuelto su respuesta observable al cerrar el asiento. La configuración y descarga sí quedaron verificadas.

### 7.3 Persistencia canónica

El diseño y las tareas se conservan en `SeryMente/metodologia/main`. El directorio local `Metodologia` no es un checkout Git verificado (`.git` ausente) y no se utilizó como fuente de escritura canónica. La instalación local de OpenCode sigue siendo configuración por terminal; la especificación documenta cómo debe reproducirse en otra terminal, sin fingir continuidad multi-equipo ya probada.

## 8. Criterios de aceptación y pruebas pendientes

- [ ] Un dictado de ChatGPT se convierte en tareas provisionales de los frentes correctos sin recaptura manual.
- [ ] La fuente se preserva verbatim y la matriz demuestra cobertura completa sin alcance añadido.
- [ ] El número de tareas es mínimo y corresponde a resultados ejecutables independientes.
- [ ] Los archivos se conservan en el contenedor provisional correcto y el índice se lee de vuelta.
- [ ] OpenCode V1 carga realmente Superpowers y el agente enumera las skills descubiertas.
- [ ] Superpowers y BMAD se invocan en sus responsabilidades complementarias.
- [ ] Una tarea sintética atraviesa captura → plan → ejecución aislada → revisión → verificación y devuelve evidencia.
- [ ] El procedimiento se recupera desde una sesión nueva usando la configuración persistente y sin exponer credenciales.

## 9. Siguiente acción

Completar la prueba de carga/discovery de Superpowers desde OpenCode `1.19.5` y la prueba sintética del flujo vMAT de creación de tarea a partir de un dictado de ejemplo, en un proyecto aislado. Después actualizar esta misma crónica y la especificación con los resultados reales. La tarea permanece `en_curso` hasta superar todos los criterios.

## 10. Crónica acumulativa

### Ciclo de inicialización · 2026-11-12

- **Fuente:** dictado verbatim incluido en §1.
- **Objetivo:** orientar Product Design a la entrada de ChatGPT, la creación de tareas provisionales trazables y su ejecución con capacidades Superpowers.
- **Estado previo:** MOD-EP-PRODUCT-DESIGN inicializado, pero su propósito funcional previo priorizaba un documento fuente de implementación no adjunto; no existía definición operativa vMAT en la carpeta.
- **Hallazgos:** BMAD 6.12.4 ya está instalado; OpenCode 1.19.5 y Groq nativo ya estaban integrados. Superpowers no estaba configurado en OpenCode ni aparecía en la búsqueda local de archivos del árbol SeryMente.
- **Decisiones derivadas de la fuente:** centrar el producto en captura verbatim, selección de frente, descomposición mínima/exhaustiva, tarea provisional y ejecución/verificación con Superpowers; dejar fuera capacidades ajenas a la biblioteca Superpowers que el operador no pidió.
- **Cambios ejecutados:** configuración OpenCode V1 extendida con Superpowers v7.0.2, respaldo previo conservado, especificación operativa creada y enlazada desde MOD-EP-PRODUCT-DESIGN, esta tarea provisional materializada.
- **Pruebas:** read-back de configuración, SHA-256 de configuración/respaldo, paquete Superpowers v7.0.2 en caché y conteo físico de 15 directorios de skills. La prueba del agente continuaba sin salida final visible al registrar esta crónica.
- **Limitaciones:** las dos conexiones RDC corresponden al mismo host físico y a dos identidades Windows; la carga efectiva de skills y el flujo completo de captura/creación/ejecución siguen pendientes de prueba. No se modificó la versión de OpenCode ni se alteró el proveedor Groq.
- **Siguiente acción:** completar descubrimiento de Superpowers desde una nueva sesión OpenCode, ejecutar una prueba sintética de vMAT sin tocar proyectos productivos y actualizar estado/evidencia.
