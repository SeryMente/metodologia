# Crónica · C-GOBERNANZA-TAXONOMIA-CONCEPTUAL-INFRAESTRUCTURA-01

**Fecha:** 2026-10-28  
**Ciclo:** C-20261028-5E83B1D7  
**Sesión activa:** SES-20261028-GV3K8P6Q · generación 3  
**Fuente normativa anterior:** DUG v358 · NX-358m · blob 89a28e4d05f5baab9c4b86abdb9fbfc532690c75  
**Fuente normativa resultante:** DUG v359 · NX-359m · blob b2ff2845a5a99dc4ce3cafafc4f8e43607d48145 · commit 1377e697cfe7d18b7558ab1eab46e0154e16426d  
**Estado:** PERSISTIDO Y RELEÍDO; auditoría de navegador pendiente.

## Encargo y autorización

El operador pidió distinguir la taxonomía conceptual de la infraestructura GitHub, mantener la categoría taxonómica Ámbitos, canonizar Propósito como enunciado compacto que define el alcance de un frente y documentar que puede materializarse como archivo o sección raíz sin directorio propio. También indicó continuar la definición de Tareas y pidió evaluar un estándar común de tareas reutilizable en ámbitos futuros. La petición original se conserva literalmente en el diálogo JSONL del ciclo.

La autorización se aplicó al cambio concreto en DUG/Metacanon/GOW descrito aquí. No se interpretó como autorización para canonizar Tareas; Tareas sigue en incubación.

## Cambio normativo efectuado

Se versionó la fuente única a **DUG v359 · NX-359m**, **Metacanon 1.24**, **GOW 2.8** y **taxonomía estructural 1.3**. No se añadieron principios ni anexos: siguen siendo 41 y 16, respectivamente. El GOW pasa a 109 términos.

- **ART-015** separa identidad/taxonomía conceptual, categoría Ámbitos, cadena de infraestructura y reglas de materialización.
- **ART-019 y ART-021** explicitan el Propósito del FT y permiten conservarlo como enunciado compacto en un archivo raíz o una sección de documento raíz.
- **ART-020** distingue los dos ámbitos funcionales transversales canónicos (Persistencia documental y Gestión conversacional) del elemento conceptual canónico Propósito.
- **Metacanon §46** explicita que la identidad taxonómica y la materialización física son dimensiones distintas; un OCP de repositorio no está obligado a incluir un directorio `ambitos/`.
- **Metacanon §51** separa el mapa conceptual de la cadena de infraestructura GitHub.
- **GOW** añade el término “Propósito de frente” con alias “Propósito” y aclara el término general Ámbito.
- La proyección estructurada identifica tres elementos canónicos de la categoría Ámbitos: dos ámbitos funcionales y Propósito como elemento conceptual declarativo. La lista estricta de ámbitos funcionales sigue teniendo dos miembros.

La existencia de `ambitos/tareas/` continúa siendo una decisión provisional para alojar los materiales del diseño en incubación porque existen varios artefactos operativos; no es una regla que se imponga a todos los OCP.

## Recomendación sobre Tareas

Se creó en el OCP de Tareas un **Estándar común de tarea v0.1**, acompañado por un esquema JSON candidato. La decisión recomendada es conservar un contrato mínimo compartido —identidad, título, procedencia, alcance, estado, resultado esperado, aceptación, siguiente acción, relaciones y evidencia— con extensiones versionadas por dominio. Esto separa el objeto tarea del subsistema transversal Tareas y evita forzar a todos los ámbitos a la misma base de datos o directorio.

Los artefactos siguen marcados como candidatos. No se creó un registro vacío, no se eligió aún una plataforma como fuente de estado y no se probó una tarea real de extremo a extremo. La definición de estados/transiciones, prioridad, fuente de estado e integraciones sigue pendiente de validación con casos reales.

## Validación

La lectura de vuelta del DUG coincide con la escritura. El JSON incrustado parsea. El JavaScript operativo se compiló sintácticamente en aislamiento, sin ejecutarlo. La capa HTML estática contiene 27 IDs sin duplicados. No se ejecutó renderizado de navegador ni auditoría dinámica completa de enlaces. El campo nativo de Instrucciones Personalizadas de ChatGPT no se modificó ni verificó.

## Continuidad

Desde Tareas, continuar con TAR-01/TAR-02 y probar el contrato común con dos o tres casos representativos antes de decidir si se eleva a estándar canónico. Para cualquier ampliación taxonómica de Tareas, preparar propuesta explícita y obtener la autorización correspondiente.