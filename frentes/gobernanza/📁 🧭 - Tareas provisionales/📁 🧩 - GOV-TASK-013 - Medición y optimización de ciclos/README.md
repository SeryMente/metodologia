# GOV-TASK-013 — Medición objetiva y optimización del tiempo de procesamiento de ciclos

**Estado:** en_curso · **Tipo:** tarea propia de Gobernanza · **Responsabilidad:** Gobernanza 2 (asiento corresponsable activo `SES-20261101-GV8E89D1FF`, generación 12), por delimitación operativa expresa del operador. Esta atribución no transfiere la titularidad primaria del frente ni modifica su control.

## Delimitación de responsabilidades

- **Gobernanza 2:** responsable de GOV-TASK-013 y de su diseño de medición, instrumentación, captura, análisis, línea base, KPI y experimentos de optimización. También conserva GOV-TASK-012 dentro de su ámbito propio.
- **Gobernanza 1:** titular primario y responsable exclusivo de la DTC (Dinámica Trilateral por Ciclo), incluida GOV-TASK-011, el sprint DTC, la coordinación interfrente, sus ciclos, cursores, solicitudes, integración, dependencias y aceptación.
- **Límite de esta tarea:** GOV-TASK-013 no abre, procesa ni cierra ciclos DTC; no opera cursores o mensajes EP/MCP-OCP; no emite solicitudes interfrente ni modifica GOV-TASK-011, tableros o artefactos de coordinación pertenecientes a Gobernanza 1.
- Si una medición revela una dependencia interfrente, Gobernanza 2 documenta el hallazgo y lo canaliza a Gobernanza 1. No ejecuta por sustitución el trabajo del titular DTC.
- Esta separación es una asignación funcional de tareas; no altera el roster, la titularidad ni el control común del frente.

## Objetivo

Establecer una línea base reproducible del tiempo de procesamiento de ciclos sustantivos y permitir comparar mejoras, con atención especial a GitHub y RDC. Medir desde el primer ciclo completo cuyo registro temporal pueda comenzar al inicio; no reconstruir marcas históricas.

## Restricciones de diseño vigentes · instrucción del operador 2026-11-02

1. **Una sola magnitud primaria por ahora:** duración observable del ciclo sustantivo completo. No diseñar ni desplegar KPIs derivados, tokenización/costo, primera respuesta, latencia por herramienta, tasas de error, reintentos ni instrumentación adicional sin nueva decisión. La clasificación de ciclo se conserva únicamente para poder contar la frecuencia por categoría; el catálogo de categorías queda pendiente de diseño.
2. **Checkpoint inicial común:** capturar el evento canónico `cycle.accepted` en el límite de entrada del orquestador/adaptador, después de que el entorno recibe y admite la entrada y antes de cualquier procesamiento específico de proveedor/modelo. No usar la primera acción interna observable del modelo.
3. **Checkpoint final común:** capturar `cycle.completed` cuando termina el turno/ciclo completo y la salida final visible queda disponible para el consumidor, una vez concluidas las iteraciones de herramientas y orquestación que pertenezcan al mismo ciclo. El evento terminal de una sola respuesta de modelo no equivale automáticamente al cierre del ciclo externo.
4. **Portabilidad:** los nombres anteriores son eventos semánticos del contrato común, no nombres de API impuestos a proveedores. Cada adaptador mapea señales nativas verificables al contrato. Cuando no exista señal fiable, registrar `NOT_MEASURED` y el motivo; no sustituirla por una acción detectiva distinta ni completar por inferencia.
5. **Reloj:** conservar fecha UTC y procedencia/precisión del reloj; calcular duración con reloj monotónico cuando el adaptador controle ambos extremos. No depender de restar relojes de pared susceptibles de ajuste.
6. **Integración conversacional/AT:** vincular la medición al UUIDv7 local de conversación y al ciclo real; relacionar el registro A/B y, cuando aplique, los vectores AT mediante referencias recuperables. La telemetría no duplica el texto conversacional ni crea un registro por herramienta.
7. **Ámbito físico:** reutilizar el OCP transversal existente `ambitos/gestion-conversacional/` para el contrato común y sus referencias; no crear una copia de telemetría por frente. Cada frente conserva en su propia evidencia únicamente las referencias que le correspondan.
8. **Captura de contenido:** conservar A/B literal según ART-024, sin razonamiento interno oculto ni secretos. Captura automática y sincronización entre plataformas no se presumen: requieren un adaptador real, permisos y prueba de lectura de vuelta.
9. **FOL1:** continúa PREPARADO_PENDIENTE_ACTIVACION_IPZ. No asignar folios nuevos ni declarar activación desde esta conversación; el contrato vigente exige preparar la IPZ y comenzar una conversación nueva para el corte.
10. **Base de datos:** motor/proveedor y política de retención/acceso permanecen pendientes de decisión. Cualquier proyecto existente ajeno a Metodología queda fuera de alcance; no provisionar ni reutilizar infraestructura antes de aprobar el destino.

### Verificación documental inicial de OpenAI

- Responses API streaming documenta eventos de ciclo de vida `response.created`, `response.completed` y `error`; son señales del ciclo de una respuesta API y solo pueden mapearse al ciclo externo cuando la arquitectura de orquestación confirme esa equivalencia: https://developers.openai.com/api/docs/guides/streaming-responses
- La exportación ordinaria de ChatGPT entrega una copia descargable del historial; no es un hook de captura en vivo por turno: https://help.openai.com/en/articles/7260999-exporting-your-chatgpt-history-and-data
- La Compliance Platform expone registros/metadatos de conversaciones en espacios Enterprise/Edu elegibles, con permisos administrativos y retención documentada de 30 días en el servicio de logs; no se presume disponible en una cuenta ni sustituye un hook universal: https://help.openai.com/en/articles/9261474-openai-compliance-platform-for-enterprise-and-edu-customers

**Estado de diseño:** checkpoints semánticos propuestos; adaptador nativo de ChatGPT UI no identificado en documentación pública consultada; catálogo de categorías pendiente; base de datos pendiente; activación FOL1 pendiente de su compuerta. No se declara una implementación activa.

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

- Norma: [DUG v377 · NX-377m](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html), [Metacanon §52](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-52), [§4](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-4), [§28](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#meta-28), [P020](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P020) y [P043](../../../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P043).
- Análisis y experimentos: [GOV-TASK-012](../📁%20🧩%20-%20GOV-TASK-012%20-%20Fluidez%20y%20desempeño%20del%20marco/README.md).
- Incorporación al ciclo recurrente: [GOV-TASK-011](../📁%20🧩%20-%20GOV-TASK-011%20-%20Coordinación%20bilateral%20recurrente/README.md), bajo responsabilidad exclusiva de Gobernanza 1 para el DTC.
 
**Siguiente acción:** diseñar el esquema de medición y KPI respetando la delimitación anterior; iniciar la captura en el primer ciclo sustantivo elegible y completo desde su primera acción efectiva.
