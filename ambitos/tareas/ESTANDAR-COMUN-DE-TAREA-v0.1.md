# Estándar común de tarea · v0.1 (candidato)

**Estado:** borrador reutilizable en incubación; no canonizado en el DUG ni en el GOW.  
**Origen:** ámbito Tareas v1.0.  
**Evento de diseño:** C-TAREAS-ESTANDAR-REUTILIZABLE-01 · 2026-10-28.

## 1. Decisión de diseño

**Sí conviene usar desde ahora un molde común**, siempre que sea un contrato mínimo y extensible, no un formulario rígido que fuerce a todos los ámbitos a tener las mismas necesidades. La distinción es:

- **Estándar común de tarea:** define qué significa una tarea y qué información básica conserva para que resulte entendible, trazable, ejecutable y verificable fuera del ámbito que la originó.
- **Perfil del ámbito:** añade campos o pruebas específicos cuando exista una necesidad real, sin redefinir silenciosamente el contrato común.
- **Subsistema Tareas:** será la capacidad transversal que gestione el ciclo de vida y la coordinación. No es lo mismo que el estándar que describe cada objeto tarea.

El estándar es independiente del proveedor de almacenamiento. No decide todavía si la fuente de estado será GitHub Issues, una base de datos, Notion u otra herramienta.

## 2. Contrato semántico común

Una **tarea** es una unidad de trabajo identificable, derivada de un origen trazable, que persigue un resultado esperado y tiene una condición de aceptación. Su registro permite determinar qué se pretende lograr, dentro de qué alcance, cuál es el estado observado, qué falta y qué evidencia justificaría el cierre.

El contrato debe conservar, como mínimo, estas invariantes:

1. **Identidad estable:** un ID no se reutiliza. Las referencias externas se registran sin confundirlas con el ID canónico.
2. **Procedencia:** toda tarea se vincula con la instrucción, decisión, compromiso o fuente de la que deriva. Un resumen posterior no reemplaza el original cuando este sigue siendo accesible y debe conservarse.
3. **Resultado esperado:** una tarea definida expresa un resultado verificable, no solo un tema o intención vaga.
4. **Ámbito/responsabilidad:** se identifica el FT o ámbito afectado cuando está confirmado; la falta de asignación se declara, no se inventa.
5. **Estado explícito:** el estado representa lo observado y obedece a transiciones documentadas.
6. **Aceptación verificable:** el cierre se contrasta con criterios definidos y evidencia recuperable. Una afirmación de “hecho” no sustituye la comprobación.
7. **Siguiente acción:** toda tarea activa conserva una acción siguiente concreta o declara que debe definirse.
8. **Relaciones tipadas:** dependencia, bloqueo, subtarea y relación contextual son vínculos distintos.
9. **Trazabilidad temporal:** fechas de creación, actualización, vencimiento y verificación se separan y solo se registran cuando son observadas o fijadas explícitamente.
10. **Extensibilidad:** los campos propios de un ámbito se guardan en un perfil o extensión con espacio de nombres, sin alterar el significado de los campos comunes.

## 3. Esquema de datos candidato

El archivo [ESQUEMA-TAREA-COMUN-v0.1.json](ESQUEMA-TAREA-COMUN-v0.1.json) plasma una primera interpretación técnica del contrato. Es candidato de diseño, no validación de producción.

| Campo | Función | Condición |
|---|---|---|
| schema_version | Versión del contrato | Obligatorio. |
| task_id | Identidad canónica estable | Obligatorio; política de generación/unicidad pendiente de ratificar. |
| title | Acción o resultado resumido | Obligatorio; concreto y legible. |
| status | Estado del ciclo de vida | Obligatorio; refleja evidencia. |
| origin | Tipo de origen y referencia trazable | Obligatorio; no inventar un ID nativo. |
| scope_ref | FT, ámbito, repositorio o contexto responsable | Obligatorio; si falta, declarar la asignación pendiente. |
| expected_outcome | Resultado esperado | Requerido antes de pasar a definida/lista/en curso/revisión/completada. |
| acceptance_criteria | Condiciones observables de cierre | Requeridas antes de ejecución; verificables al cerrar. |
| owner | Responsable | Opcional; desconocido y sin asignar son estados distintos. |
| priority | Prioridad y escala | Opcional; no inventar la escala. |
| due_date | Fecha límite | Opcional; solo si está fijada o confirmada. |
| next_action | Paso ejecutable siguiente | Necesario para estados activos que lo requieran. |
| relations / blockers | Dependencias, subtareas y bloqueos | Opcional; cada relación lleva tipo y destino. |
| evidence_refs | Evidencia de avance/aceptación | Referencias recuperables; necesarias para sostener el cierre. |
| created_at / updated_at / verified_at | Fechas de operación | Solo cuando sean observadas o expuestas por la fuente. |
| extensions | Campos específicos de dominio | Opcional; con espacio de nombres, sin redefinir el núcleo. |

**No exigir todos los campos desde el instante de captura.** Una tarea capturada puede estar incompleta y pasar a POR DEFINIR. Lo que sí debe quedar inequívoco es que el registro es provisional y qué dato material falta.

## 4. Ciclo de vida base candidato

Se propone compartir un conjunto pequeño de estados semánticos:

- **CAPTURADA:** existe solicitud o compromiso trazable, pero la formulación puede estar incompleta.
- **POR DEFINIR:** falta aclarar resultado, alcance, responsable u otro dato material.
- **DEFINIDA:** resultado y aceptación son comprobables; puede faltar preparación operativa.
- **LISTA:** reúne las condiciones acordadas para comenzar.
- **EN CURSO:** hay ejecución o avance observable.
- **BLOQUEADA:** un impedimento concreto impide continuar; conservar motivo, fuente y siguiente acción si se conoce.
- **EN REVISIÓN:** hay un resultado candidato que se coteja contra la aceptación.
- **COMPLETADA:** se cumplen los criterios de aceptación; conservar evidencia o referencia que sostenga el cierre.
- **APLAZADA:** decisión explícita de posponer; no equivale a completar.
- **CANCELADA:** decisión explícita de no continuar; conservar la procedencia.

Los códigos técnicos, transiciones, reapertura, concurrencia, recurrencia y prioridad requieren validación con casos reales. Un perfil puede añadir estados locales, pero debe mapearlos al conjunto base.

## 5. Extensiones por ámbito

El contrato se estructura en tres capas:

1. **Núcleo común:** identidad, título, procedencia, estado, alcance/contexto, resultado, aceptación, siguiente paso y trazabilidad.
2. **Relaciones de trabajo:** dependencias, subtareas, bloqueos, recursos, fuentes y evidencias.
3. **Perfil de dominio:** datos adicionales específicos del ámbito que crea o consume la tarea.

Ejemplos hipotéticos: un ámbito técnico podría añadir entorno, commit y prueba; uno comercial, cliente/operación y etapa; uno de investigación, hipótesis y fuente. Son ejemplos de extensibilidad; no canonizan campos ni crean ámbitos futuros.

Cada extensión debe tener espacio de nombres y versión; documentar propósito, campos, valores, validación y privacidad; no cambiar el sentido de los campos comunes; y declarar cómo se mapea al contrato común.

## 6. Persistencia e interoperabilidad

- El estándar describe el objeto; no impone un archivo por tarea, carpeta por ámbito ni una base de datos.
- Cada tarea tendrá una referencia canónica a su registro/estado cuando se elija la persistencia.
- Si una herramienta ya es la fuente autoritativa, Tareas puede indexar una referencia en vez de duplicar el registro.
- Si dos superficies contienen copias, se declara cuál es la fuente y cómo se reconcilian; no se presume sincronización automática.
- Los adaptadores traducen el esquema común a cada plataforma y documentan pérdidas, estados no representables y límites de permisos.
- El esquema no justifica recopilar credenciales o datos sensibles innecesarios.

## 7. Criterios de aceptación del estándar

Antes de canonizar la versión 1.0, comprobar que:

1. Un caso capturado incompleto se registra sin inventar resultado o aceptación.
2. Una tarea definida contiene resultado y criterios claros.
3. Una tarea bloqueada conserva motivo, procedencia y siguiente acción cuando se conoce.
4. Una tarea completada no carece de evidencia de aceptación cuando el caso la requiere.
5. Las referencias a FT, conversaciones, documentos y plataformas no se confunden.
6. Una extensión convive sin cambiar la semántica común.
7. No se duplican IDs dentro del universo accesible y la cobertura de la búsqueda queda declarada.
8. La recuperación/read-back funciona desde la fuente de estado elegida.
9. Los campos que no aporten valor se eliminan antes de ratificar.
10. El contrato se aplica a más de un ámbito sin obligar a usar el mismo almacén físico.

## 8. Estado y siguiente paso

**Estado: CANDIDATO v0.1; no canonizado.** Propuesta de trabajo del ámbito Tareas para evaluación transversal.

Siguiente paso recomendado: validar el contrato con dos o tres casos representativos de distinta naturaleza, sin crear tareas reales de forma automática. Después podrán diseñarse perfiles por ámbito. Solo cuando supere esas pruebas convendrá promoverlo al DUG/GOW y ubicar una referencia compartida estable en la infraestructura metodológica.