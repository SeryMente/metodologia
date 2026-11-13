# EP-TASK-012 — Generación automática de Brainstorm HTML Keepsake

**ID local:** EP-TASK-012  
**Estado:** `pendiente · LOW_PRIORITY · DEFERRED_AFTER_CORE`  
**Prioridad/secuencia:** Baja · posterior a EP-TASK-009 y EP-TASK-010; no bloquea el primer release  
**Frente propietario:** Entorno Persistente (EP)  
**Módulo:** MOD-EP-PRODUCT-DESIGN  
**OCP padre:** frentes/ep/OEP.md

## Enunciado ejecutivo

Conservar la investigación de BMAD sobre Brainstorm HTML Keepsake y dejar preparada una tarea posterior para integrarlo como artefacto visual generado por el agente a partir de una sesión persistida. El operador no debe diseñar, maquetar ni completar el HTML. Esta tarea no se ejecuta en la primera versión.

## 1. Fuentes verbatim y procedencia

- SRC-PD-20261113-ALCANCE-02, instrucción del operador, conservada literalmente en MOD-EP-PRODUCT-DESIGN/SPRINT-GENERAL-PRODUCT-DESIGN.md §18.
- SRC-PD-20261113-IDEACION-03, instrucción actual, conservada literalmente en el mismo sprint §18.

Pasajes pertinentes, no sustitutivos del original:

~~~text
Y luego el otro elemento HTML, keep safe, pensé que era como una forma de obtener un resultado gráfico después de la lluvia de ideas, pero que no me tenga que poner a mí a diseñar ese elemento porque si lo tengo que diseñar, pues entonces no lo quiero tener.
~~~

~~~text
prescindiendo de los elementos extras que son Brain Selector, Rush HTML Keep Safe.
~~~

## 2. Hallazgos de investigación acotados

1. En BMAD V6.12 el artefacto se llama brainstorm.html y se define como HTML autocontenido, creativo y específico de la sesión.
2. El archivo incorpora CSS y JavaScript; no depende de recursos externos.
3. Se genera desde el registro completo de la sesión. Debe conservar ideas, técnicas, agrupaciones y síntesis, sin inventar material que no conste en la fuente.
4. En Ideate for me la referencia indica generación automática. En Facilitator y Creative Partner los artefactos son optativos y el agente ofrece el Keepsake al cierre.
5. La habilidad upstream sugiere delegar la generación a un subagente, pero este entorno ChatGPT + RDC no tiene todavía una prueba de runtime que acredite esa ruta.
6. No se ha demostrado el proceso completo desde una sesión real de Carson hasta un HTML producido, validado, abierto en el host y guardado en el proyecto.

## 3. Alcance futuro, solo después del núcleo

- Leer como fuente canónica los ciclos persistidos por EP-TASK-010.
- Generar el HTML directamente desde el registro, sin trabajo de diseño del operador.
- Preservar procedencia y separar ideas del operador, aportaciones de Carson, técnicas, hallazgos y decisiones.
- Validar HTML, ausencia de recursos externos, fidelidad al registro y recuperación.
- Mantener el archivo dentro del proyecto y la bóveda EP protegida.
- Respetar la diferencia de comportamiento por modo BMAD; no generar de manera automática en todos los modos salvo decisión explícita posterior.

## 4. Fuera de alcance

No construir plantilla visual genérica, portal, editor, selector, nueva UI ni flujo de diseño para el operador. No usar el Keepsake como almacenamiento canónico: el registro de ciclos es la fuente. No abordar esta tarea antes de EP-TASK-009 y EP-TASK-010.

## 5. Criterio de aceptación futuro

Desde una sesión de Carson ya guardada, producir un brainstorm.html autocontenido, validarlo, cotejar su contenido con ciclos fuente, guardarlo como artefacto versionado y abrirlo solo cuando el operador lo solicite o el flujo vigente del modo lo requiera. Una prueba fallida no afecta ni pierde la sesión original.

## 6. Crónica acumulativa

### Investigación y diferimiento · 2026-11-13

- Se leyó la referencia upstream BMAD V6.12 references/finalize.md.
- Se confirmó que Keepsake es un artefacto visual generado por el agente, no una tarea de diseño que corresponda al operador.
- Se documentó su diferencia de generación según el modo y la ausencia de una prueba end-to-end local.
- La instrucción más reciente lo deja fuera de la primera versión y solicita conservar el hallazgo en una tarea de baja prioridad.
- Estado: diferida; no se generó ni abrió un Keepsake local.
