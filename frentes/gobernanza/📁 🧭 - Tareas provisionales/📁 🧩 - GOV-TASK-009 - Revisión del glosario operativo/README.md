# 📝 GOV-TASK-009 · Revisión del glosario operativo

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`
**Urgencia relativa:** baja; mejora no bloqueante. Se atiende después de los bloqueos operativos y sin desplazar controles esenciales.  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-009`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Revisar el Glosario Operativo del Workspace (GOW) para asegurar que su vocabulario esencial esté visible en primer plano y permita que un modelo nuevo comprenda el marco de trabajo en el primer paso indicado por las instrucciones personalizadas de ChatGPT. Mantener una entrada inicial breve y suficiente, sin cargarla con términos especializados que solo sean necesarios por contexto.

## Referencia de origen

DUG v373 · NX-373m · GOW declarado en los metadatos como v2.14; en particular, §ARR · Vocabulario de entrada para ChatGPT, §A · Glosario canónico y ART-027. Instrucciones personalizadas de ChatGPT: secuencia de lectura §ARR → DUG vigente → principios pertinentes en orden; anexos solo por remisión.

## Observación inicial verificada · 2026-10-30

- §ARR ya existe y se identifica expresamente como primera lectura lingüística de una conversación nueva. Verificación: 25 entradas numeradas, 26 conceptos y 26 IDs estructurados, todos con término y ancla resolubles.
- §ARR contiene 25 entradas numeradas que cubren 26 conceptos (el punto 17 agrupa Ciclo y Conversación), entre ellos Ser y Mente, GOW, DUG, principio de gobernanza, anexo, IPZ, repositorio/main, OCP, control de responsabilidad, continuidad conversacional, folios, UUIDv7 local, MCP normativo, CNP y PAI.
- Los 12 nombres que no aparecían literalmente en la sección canónica §A sí están incluidos en §ARR; por tanto, ya son visibles en el vocabulario inicial. La lista coincide con entry_vocabulary.term_ids (26 IDs; 26/26 resueltos).
- La entrada estructurada `MDP` conserva una definición histórica como “Método Estándar para Documentar Protocolos”, mientras que el DUG utiliza actualmente “microdescriptor de pertinencia”. Debe resolverse la colisión por alcance y procedencia, sin asumir equivalencia.
- La estructura humana y los metadatos muestran una divergencia de versión GOW (2.12 frente a 2.14) que requiere cotejo y reconciliación autorizada.

## Alcance de la revisión

1. Comprobar que §ARR refleja fielmente el recorrido de entrada exigido por la IPZ y que los conceptos indispensables aparecen antes de los vocabularios especializados.
2. Confirmar que las entradas humanas y estructuradas coinciden, incluidas definición, nombre canónico, aliases, grupo, ancla, alcance y excepciones.
3. Resolver la colisión de `MDP` distinguiendo el uso histórico del método documental del uso actual “microdescriptor de pertinencia”.
4. Evaluar si términos operativos como Sink y FOL1 deben incorporarse al vocabulario inicial o permanecer en las secciones contextuales; no añadirlos por mera exhaustividad.
5. Reconciliar la versión humana y estructurada del GOW, preservando la precedencia del contenido humano y el DUG como fuente normativa única.
6. Conservar términos históricos con procedencia y alcance explícitos; no eliminar ni renombrar por inferencia.

## Límites

Esta tarea no autoriza por sí misma una modificación normativa del DUG/GOW. Cualquier cambio sustantivo o reconciliación de versiones debe respetar el control de responsabilidad y las autorizaciones expresas aplicables. No crear un glosario paralelo ni convertir la representación estructurada en una autoridad independiente.

## Criterio de cierre

§ARR permite a un modelo nuevo identificar el sistema, el GOW, el DUG, la jerarquía de principios y anexos, el acceso a la fuente canónica y los mecanismos básicos de continuidad; el primer plano sigue siendo breve. La totalidad de las entradas humanas y estructuradas queda cotejada, las colisiones semánticas y divergencias de versión se resuelven con autorización, y el resultado se lee de vuelta desde `main`.


## Prioridad para IPZ · instrucción del operador · 2026-10-31

§ARR es la primera referencia del recorrido IPZ y debe familiarizar al modelo con el vocabulario mínimo necesario para entender la Metodología, la asignación de frentes, los ciclos, los folios, el DUG, los principios y OCP MCP. El DUG es la segunda referencia y conserva la autoridad normativa única. Revisar que los enlaces y términos de §ARR sean resolubles, suficientes y no creen una segunda fuente normativa. La prioridad de esta revisión aumenta porque §ARR es el primer destino de navegación del IPZ.


## Antecedente histórico supersedido · prioridad rectora IPZ · C-GOBERNANZA-VECTOR-SEMANTICO-01 · 2026-10-31

GOW/§ARR es el primer destino del IPZ y debe ofrecer el vocabulario necesario para comprender Metodología, admisión, repositorios/frentes, ciclo/folios y DUG. Debe ir antes del segundo enlace al DUG; este último conserva la autoridad normativa única. Verificar el destino Sync abreviado, resolución, anclas y compatibilidad del glosario humano/estructurado. La divergencia de banner/versiones y el inventario de satélites se resuelven con GOV-TASK-006; esta tarea valida la funcionalidad de la primera referencia, no modifica el canon. Trazabilidad: [C-GOBERNANZA-VECTOR-SEMANTICO-01](../../cronica/C-GOBERNANZA-VECTOR-SEMANTICO-01.md).


## Alineación de referencia IPZ · 2026-11-09 · C-GOBERNANZA-IPZ-RDC-SINK-01

La primera referencia operativa del IPZ se denomina `GOW:ARR` y la segunda `DUG`. Se resuelven por RDC/MCP-OCP local; no son URLs Sync ni requieren acortador HTTP. Esta tarea conserva su alcance: verificar que §ARR ofrece el vocabulario de entrada suficiente, breve y coherente con el DUG único, y que la respuesta de `GOW:ARR` corresponde a la revisión canónica importada.

La prueba de resolución depende de MCP-OCP y se ejecutará después de que exista la herramienta local; la validación semántica del vocabulario sigue siendo responsabilidad de Gobernanza. No añadir Sink al vocabulario inicial por mera exhaustividad ni modificar el GOW por inferencia. Estado de esta tarea: `en_curso`, no aceptada.


## Cierre de alcance GOW:ARR · sprint Sink local · reconciliado con DUG v388 · 2026-11-10

`GOW:ARR` queda definido como operación de lectura de §ARR desde la fuente DUG importada y verificada localmente por MCP-OCP. Gobernanza valida contenido, suficiencia lingüística, anclas y correspondencia humano/estructurada; MCP-OCP implementa la recuperación y entrega los pins. La prueba se ejecuta sobre la instancia local instalada en `frentes/mcp-metodologia/instalacion-local/`, no sobre lectura manual de HTML ni URL HTTP. Baseline: Samantha v388/NX-388m, commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`, blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`. No modificar el GOW por inferencia ni añadir Sink al vocabulario inicial por exhaustividad. La tarea sigue en curso hasta ejecutar validación y leer la evidencia de vuelta.


## Reporte individual obligatorio de resolución/cierre
Al resolver, completar, bloquear o cancelar esta tarea, registrar su propio informe en este README usando [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md). Explicar objetivo y resultado, cómo se solucionó, decisiones verificables, cambios/rutas/commits/blobs/SHA, criterios y pruebas ejecutadas con logs/artefactos, read-back, bloqueantes/dependencias, preocupaciones/riesgos, pendientes, rollback y aceptación. Declarar NINGUNO_VERIFICADO o NO_VERIFICADO donde corresponda; nunca ocultar campos. No marcar completada sin criterios PASS, evidencia y read-back. Actualizar el índice padre después de verificar este informe y entregar al operador el enlace individual y síntesis de solución, evidencia, bloqueantes y preocupaciones. No incluir secretos ni datos sensibles.
