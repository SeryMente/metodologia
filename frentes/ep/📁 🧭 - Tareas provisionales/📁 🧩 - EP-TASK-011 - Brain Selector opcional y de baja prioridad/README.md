# EP-TASK-011 — Brain Selector oficial como comodidad opcional

**ID local:** EP-TASK-011  
**Estado:** `pendiente · LOW_PRIORITY · DEFERRED_AFTER_CORE`  
**Prioridad/secuencia:** Baja · posterior a EP-TASK-009; no bloquea el primer release  
**Frente propietario:** Entorno Persistente (EP)  
**Módulo:** MOD-EP-PRODUCT-DESIGN  
**OCP padre:** frentes/ep/OEP.md

## Enunciado ejecutivo

Conservar el resultado de la investigación sobre el Brain Selector oficial de BMAD y, solo en una etapa posterior, decidir si aporta una comodidad opcional al flujo conversacional ya funcional. No construir un selector general, dashboard ni interfaz propia por anticipación.

## 1. Fuentes verbatim y procedencia

- SRC-PD-20261113-ALCANCE-02, instrucción del operador, conservada literalmente en MOD-EP-PRODUCT-DESIGN/SPRINT-GENERAL-PRODUCT-DESIGN.md §18.
- SRC-PD-20261113-IDEACION-03, instrucción actual, conservada literalmente en el mismo sprint §18.

Pasajes pertinentes, no sustitutivos del original:

~~~text
Entonces nada más necesito tener una interfaz, bueno, no la necesito. Se puede utilizar la plataforma de chat. Si es mucho problema, mejor lo hacemos únicamente por el chat.
~~~

~~~text
prescindiendo de los elementos extras que son Brain Selector
~~~

## 2. Hallazgos de investigación acotados

1. Brain Selector es un recurso oficial de BMAD Brainstorming para componer el modo/stance y el lote de técnicas.
2. No selecciona agentes CIS ni es el motor de Carson.
3. El motor BMAD permite realizar la selección en la conversación; el selector HTML no es necesario para iniciar ni completar una sesión.
4. No se encontró una razón funcional que justifique anteponerlo al chat. Su valor potencial es comodidad de composición y copia del prompt.
5. La interfaz no debe convertirse en una segunda aplicación ni cargar la pantalla de elementos; el operador ya eligió el chat como ruta suficiente.

## 3. Alcance futuro, solo si se reactiva

- Reutilizar el Brain Selector original de BMAD antes que construir otro.
- Verificar versión y compatibilidad contra el BMAD local cuando llegue el turno de esta tarea.
- Mantenerlo estrictamente opcional: el mismo flujo debe funcionar sin abrirlo.
- Si la prueba muestra que no agrega valor al chat, cerrar la tarea sin construir UI.
- Cualquier apertura local futura debe usar la sesión principal de Chrome del operador, no un perfil aislado.

## 4. Fuera de alcance

No seleccionar agentes CIS; no mostrar catálogos completos; no crear un portal; no integrar Visual Companion de Superpowers; no instalar ni actualizar BMAD por anticipación; no usarlo como condición para Carson; no abordar esta tarea antes de que EP-TASK-009 esté aceptada y el operador decida retomarla.

## 5. Criterio de aceptación futuro

La tarea solo se reabre con una decisión material de que el selector mejora la experiencia. Se acepta si puede abrirse voluntariamente, configura modalidad/técnicas sin ruido visual, no reemplaza la interacción conversacional y su uso no introduce otra instalación o perfil de navegador innecesario. Puede cerrarse como NO NECESARIO si el chat sigue siendo suficiente.

## 6. Crónica acumulativa

### Investigación y diferimiento · 2026-11-13

- Se examinó el papel del Brain Selector en la habilidad oficial BMAD Brainstorming.
- Se verificó la distinción: configura stance/técnicas, no agentes CIS ni runtime de Carson.
- La instrucción más reciente del operador prescinde del elemento para la primera versión y exige únicamente registrar lo investigado en tarea provisional de baja prioridad.
- Estado: diferida; no hay prototipo, instalación ni cambio local.
