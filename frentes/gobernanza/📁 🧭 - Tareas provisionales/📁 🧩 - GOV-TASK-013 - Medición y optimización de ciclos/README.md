# GOV-TASK-013 — Medición objetiva y optimización del tiempo de procesamiento de ciclos

**Estado:** en_curso · **Tipo:** tarea propia de Gobernanza · **Responsabilidad:** heredada del OCP Gobernanza, generación 11. No crea un FT, OCP, control, sesión ni folio independiente.

## Objetivo

Establecer una línea base reproducible del tiempo de procesamiento de ciclos sustantivos y permitir comparar mejoras, con atención especial a GitHub y RDC. Medir desde el primer ciclo completo cuyo registro temporal pueda comenzar al inicio; no reconstruir marcas históricas.

## Instrumentación por ciclo

Incorporar un único bloque `performance` al recibo/evidencia del ciclo ya existente. No crear una bitácora paralela ni una entrada por cada llamada.

Campos mínimos:

- `request_received_at`: instante de recepción, solo si la plataforma lo expone.
- `processing_started_at`: primera acción efectiva de procesamiento posterior a la instrucción.
- `processing_finished_at`: última verificación/read-back antes de la salida final.
- `response_emitted_at`: emisión final, solo si la plataforma expone una marca verificable.
- `observed_processing_ms`: diferencia inicio-fin observada; no equivale a tiempo activo puro.
- `end_to_end_ms`: solo cuando recepción y emisión sean ambas observables.
- `clock_source`, `clock_precision`, `timezone`: fuente y precisión del reloj; marcas en ISO 8601 UTC y zona local de referencia America/Mexico_City.
- `operations[]`: operaciones externas materialmente relevantes, agrupadas por proveedor/tipo (GitHub, RDC, otros), con hora de inicio/fin y duración de ida y vuelta observada, resultado y reintentos/fallos. Esa duración incluye procesamiento del conector/proveedor; no se presenta como latencia de red pura.
- `wait_intervals[]`: esperas explícitas por operador, otro frente o dependencia externa, con inicio/fin y motivo cuando ambos sean observables.
- `operation_counts`: lecturas, escrituras, llamadas, reintentos y fallos, sin conservar payloads o secretos innecesarios.
- `workload`: clase de trabajo, complejidad observable, OCP y resultado del ciclo.
- `coverage`: marcas disponibles/no disponibles y campos `NOT_MEASURED`.

Si no existe una marca verificable, usar `NOT_MEASURED`; nunca estimar, asignar cero ni completar retrospectivamente. No capturar razonamiento interno. El intervalo de procesamiento incluye análisis y operaciones ejecutadas dentro de él y no debe rotularse «tiempo de pensamiento» o «tiempo activo puro».

## Línea base y comparación

- El ciclo que instala esta regla y los ciclos que empezaron antes de activar la medición quedan excluidos de la línea base si no tienen marcas completas desde el inicio.
- El primer ciclo sustantivo de Gobernanza que arranque después de esta activación y registre cobertura completa será el primer candidato de línea base.
- Reunir al menos 10 ciclos completos de carga comparable antes de fijar una referencia inicial estable. Si no se alcanza esa muestra, informar el resultado como preliminar.
- Reportar tamaño de muestra, mediana, percentil 90 (P90) y rango. Separar duración de procesamiento, operaciones externas y esperas observadas.
- Comparar clases de trabajo semejantes; registrar diferencias de alcance/herramientas. No atribuir causalidad a un cambio solo por una reducción aislada.
- Una mejora se acredita cuando se repite en ciclos comparables y no degrada exactitud, seguridad, autorización, trazabilidad, read-back ni aceptación. No fijar metas numéricas antes de observar la línea base.

## Criterio de aceptación

1. El bloque temporal se incorpora a la evidencia del ciclo existente sin duplicar OCP ni bitácora.
2. Las marcas tienen fuente, precisión, zona y cobertura declaradas.
3. Las operaciones GitHub/RDC quedan separadas del intervalo completo de procesamiento.
4. Las esperas conocidas no se imputan a procesamiento; las desconocidas permanecen desconocidas.
5. La línea base se calcula solo sobre ciclos elegibles y compara muestras de carga semejante.
6. Se puede identificar con evidencia qué fase/proveedor concentra tiempo y si una optimización produjo mejora repetida.

## Fuentes y relación

- Norma: [DUG v377 · NX-377m](../../../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), [Metacanon §52](../../../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-52), [§4](../../../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-4), [§28](../../../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-28), [P020](../../../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P020) y [P043](../../../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P043).
- Análisis y experimentos: [GOV-TASK-012](../📁%20🧩%20-%20GOV-TASK-012%20-%20Fluidez%20y%20desempeño%20del%20marco/README.md).
- Incorporación al ciclo recurrente: [GOV-TASK-011](../📁%20🧩%20-%20GOV-TASK-011%20-%20Coordinación%20bilateral%20recurrente/README.md).

**Siguiente acción:** capturar las marcas completas del próximo ciclo sustantivo de Gobernanza desde su primera acción efectiva.
