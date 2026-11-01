# GOV-TASK-012 — Revisión integral de fluidez y desempeño del marco de Gobernanza

**Estado:** en_curso · **Tipo:** tarea propia de Gobernanza · **Responsabilidad:** heredada del OCP Gobernanza, generación 11. No crea un FT, OCP, control, sesión ni folio independiente.

## Objetivo

Identificar y reducir la fricción estructural que prolonga los ciclos de Gobernanza, especialmente la causada por operaciones GitHub, RDC, lecturas repetidas, secuencias de escritura y verificaciones redundantes, sin debilitar autorización, exactitud normativa, seguridad, trazabilidad ni lectura de vuelta.

## Alcance de la revisión

1. Recorrer el flujo completo: recepción y delimitación del objetivo → preflight y responsabilidad → adquisición del DUG/GOW → recuperación de cursores → diagnóstico → decisión → operaciones externas → read-back → cierre y persistencia.
2. Localizar latencias y esperas por fase y herramienta. Separar duración observada de operaciones, procesamiento dentro del ciclo y esperas externas; no atribuir a GitHub/RDC demoras que no hayan sido medidas.
3. Detectar lecturas duplicadas, llamadas secuenciales que puedan agruparse sin perder CAS, dependencias seriales evitables, referencias obsoletas, mutaciones repetidas y validaciones que se repiten sin cambiar sus supuestos.
4. Clasificar cada compuerta como esencial, condicionada por riesgo o redundante. Ninguna salvaguarda preponderante se elimina por conveniencia o por una medición aislada.
5. Diseñar experimentos pequeños, reversibles y comparables; contrastar sus efectos con ciclos de carga semejante y con GOV-TASK-013.

## Criterio de aceptación

- Mapa de flujo y dependencias del ciclo con sus fases y puntos de espera.
- Matriz de cuellos de botella respaldada por mediciones observadas, no por impresiones.
- Priorización por duración/costo medido, frecuencia, impacto y riesgo; distinguir hechos, hipótesis y zonas no medidas.
- Propuestas concretas con cambio esperado, riesgo, compuertas preservadas, prueba antes/después y condición de reversión.
- Al menos una mejora comprobada en ciclos comparables antes de declarar que el rendimiento mejoró. Si no existe muestra suficiente, mantener el dictamen como provisional.

## Límites

No modificar el DUG, la IPZ, controles ni OCP ajenos por iniciativa de esta tarea. Toda enmienda normativa queda sujeta a P005 y autorización expresa. No optimizar eliminando preflight, permisos, verificación de fuentes, CAS, read-back ni evidencia. No llamar «tiempo activo» a intervalos que incluyen esperas o latencia de herramientas.

## Fuentes y relación

- Marco vigente: [DUG v377 · NX-377m](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), en particular [Metacanon §4](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-4) y [§52](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-52), [P020](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P020) y [P043](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P043).
- Medición: [GOV-TASK-013](../📁%20🧩%20-%20GOV-TASK-013%20-%20Medición%20y%20optimización%20de%20ciclos/README.md).
- Coordinación y evidencia de ciclo: [GOV-TASK-011](../📁%20🧩%20-%20GOV-TASK-011%20-%20Coordinación%20bilateral%20recurrente/README.md).

**Siguiente acción:** obtener una primera muestra de ciclos completos medidos y construir el mapa de flujo sobre evidencia real.


## Trazabilidad MCP-OCP y enlace de retorno

El DUG enlaza al núcleo operativo y al README del OCP MCP desde el término canónico GOW. Esta tarea comprobará en su siguiente revisión si el núcleo MCP-OCP contiene un vínculo Markdown de retorno al DUG v377, y si sus referencias siguen resolviendo. No modificar el OCP/control MCP-OCP desde Gobernanza: cualquier backlink faltante se solicitará a su titular en el mismo objeto de coordinación; hasta entonces la bidireccionalidad entre DUG y OCP externo se clasificará como pendiente de verificación, no como completa. Los enlaces y retornos internos del propio DUG se auditan por separado.
