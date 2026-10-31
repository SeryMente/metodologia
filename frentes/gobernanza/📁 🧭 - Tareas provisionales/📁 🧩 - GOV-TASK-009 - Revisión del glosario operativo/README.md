# 📝 GOV-TASK-009 · Revisión del glosario operativo

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `pendiente`  
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
