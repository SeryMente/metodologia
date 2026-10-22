# Entregable de extracción de principios metodológicos

## A. PRINCIPIOS IDENTIFICADOS

| Estado | Jerarquía | Folio | Denominación | Justificación |
|---|---:|---|---|---|
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Versionado Común | Se canonizó el uso común de MAJOR.MINOR.PATCH para estados reconocibles del sistema. |
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Estado Versionado | La versión identifica un estado reconocible del sistema y no necesariamente un ciclo o sesión individual. |
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Narrativa Evolutiva | Cada versión debe conservar una narrativa que permita reconstruir la evolución del sistema. |
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Trazabilidad Narrativa | La narrativa de versión debe expresar Antes → Cambio → Motivo → Resultado. |
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Identidad de Versión | Cada versión está compuesta conceptualmente por valor numérico, nombre y narrativa. |
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Foliación Global de Ciclos | Cada ciclo debe poseer una foliación global independiente de la conversación que lo contiene. |
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Precedencia del Ciclo | El ciclo constituye la unidad de secuencia global y la conversación constituye su contexto o contenedor. |
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Operación mediante Entorno Autorizado | Las operaciones sobre el entorno local deben ejecutarse mediante el mecanismo operativo autorizado para ese entorno. |
| CONFIRMADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Separación Administrativo-Operativa | La autorización administrativa debe mantenerse separada de la ejecución operativa ordinaria. |
| DERIVADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Consolidación Metodológica Externa | Las reglas metodológicas transversales deben conservarse en un repositorio metodológico común, separado de las implementaciones particulares. |
| DERIVADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de No Canonización por Persistencia | Persistir una propuesta metodológica no modifica por sí mismo su estado normativo. |
| DERIVADO | PENDIENTE | PXXX · PENDIENTE DE FOLIACIÓN | Principio de Suficiencia Progresiva | La metodología debe evolucionar hacia el mínimo conjunto suficiente de reglas, evitando crecimiento normativo o documental innecesario. |

## B. ENTREGABLE NORMALIZADO

> **PENDIENTE · PXXX · Principio de Versionado Común ·** Todos los repositorios sujetos a la metodología general utilizan una nomenclatura común de versión MAJOR.MINOR.PATCH. La versión representa un estado reconocible del sistema.

> **PENDIENTE · PXXX · Principio de Estado Versionado ·** Una versión puede abarcar múltiples ciclos operativos cuando estos contribuyen al mismo estado reconocible. El ciclo operativo y la versión no constituyen necesariamente la misma unidad temporal.

> **PENDIENTE · PXXX · Principio de Narrativa Evolutiva ·** Cada versión debe disponer de una narrativa que permita reconstruir su evolución. La narrativa debe conservar la relación entre estado anterior, cambio, motivo y resultado.

> **PENDIENTE · PXXX · Principio de Trazabilidad Narrativa ·** La narrativa de una versión debe estructurarse conceptualmente como Antes → Cambio → Motivo → Resultado. La secuencia debe permitir comprender cómo y por qué evolucionó el sistema.

> **PENDIENTE · PXXX · Principio de Identidad de Versión ·** Cada versión debe disponer de un valor numérico, un nombre y una narrativa. El nombre proporciona identidad verbal sin sustituir al número ni a la narrativa.

> **PENDIENTE · PXXX · Principio de Foliación Global de Ciclos ·** Cada ciclo metodológico debe disponer de un folio global único e independiente de la conversación en la que ocurra. La foliación debe permitir secuencias intercaladas entre conversaciones sin pérdida de trazabilidad.

> **PENDIENTE · PXXX · Principio de Precedencia del Ciclo ·** El ciclo constituye la unidad de secuencia global y la conversación constituye su contexto contenedor. La identificación de proyecto, conversación y ciclo debe poder coexistir sin sustituir la identidad global del ciclo.

> **PENDIENTE · PXXX · Principio de Operación mediante Entorno Autorizado ·** Las operaciones sobre el entorno local deben ejecutarse mediante el mecanismo operativo autorizado para dicho entorno. Los mecanismos no autorizados no deben utilizarse como sustitutos para modificar el entorno.

> **PENDIENTE · PXXX · Principio de Separación Administrativo-Operativa ·** La elevación o autorización administrativa debe mantenerse separada de la ejecución operativa. Una identidad destinada exclusivamente a autorización no debe utilizarse para realizar trabajo operativo.

> **PENDIENTE · PXXX · Principio de Consolidación Metodológica Externa ·** Las reglas metodológicas transversales deben mantenerse en un repositorio común separado de las implementaciones particulares. Los proyectos concretos deben aplicar la metodología sin convertirse en su fuente única de definición.

> **PENDIENTE · PXXX · Principio de No Canonización por Persistencia ·** La incorporación de un análisis o propuesta a un repositorio no convierte automáticamente su contenido en norma canónica. El estado normativo de cada elemento debe conservarse explícitamente.

> **PENDIENTE · PXXX · Principio de Suficiencia Progresiva ·** El desarrollo metodológico debe buscar el conjunto mínimo suficiente de reglas necesario para gobernar correctamente el sistema. La incorporación de nuevas reglas debe justificarse por una necesidad normativa real y no por acumulación documental.

## C. RELACIÓN CON LA METODOLOGÍA

| Principio | Relación |
|---|---|
| Versionado Común | YA CUBIERTO — sección de versionado existente |
| Estado Versionado | YA CUBIERTO |
| Narrativa Evolutiva | YA CUBIERTO |
| Trazabilidad Narrativa | YA CUBIERTO |
| Identidad de Versión | YA CUBIERTO |
| Foliación Global de Ciclos | YA CUBIERTO |
| Precedencia del Ciclo | YA CUBIERTO |
| Operación mediante Entorno Autorizado | YA CUBIERTO como gobernanza del entorno |
| Separación Administrativo-Operativa | DESARROLLO / ABSTRACCIÓN DE REGLA EXISTENTE |
| Consolidación Metodológica Externa | YA CUBIERTO conceptualmente |
| No Canonización por Persistencia | DESARROLLO DE PRINCIPIO EXISTENTE |
| Suficiencia Progresiva | YA CUBIERTO |

## H. Regla operativa incorporada sin elevar a principio

La cuota de Vercel, los estados de deployment y la continuidad mediante ejecución local se clasifican como **gobernanza operativa de plataforma**. No constituyen principios nuevos del sistema porque dependen de un proveedor y de un entorno concreto. Su fuente canónica es `ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL.md`.

La decisión metodológica es que el modelo debe considerar estas restricciones cuando la tarea utilice Vercel, pero resolverlas mediante reglas operativas sustituibles y no mediante una alteración del núcleo de principios.

## D. CONTENIDOS NO CONVERTIDOS EN PRINCIPIOS

| Contenido | Clasificación | Motivo |
|---|---|---|
| P001, P002, etc. | REGLA OPERATIVA | Es nomenclatura de registro, no principio autónomo. |
| Valores concretos de jerarquía 0–1 | CRITERIO / CONVENCIÓN | Define representación de precedencia. |
| Reglas concretas para determinar MAJOR/MINOR/PATCH | PENDIENTE | Se indicó explícitamente que deben formalizarse posteriormente. |
| Nombre de una versión en 1–2 palabras | CRITERIO | Es una convención de denominación. |
| Uso de GitHub | HERRAMIENTA / IMPLEMENTACIÓN | No constituye por sí mismo una norma metodológica. |
| Uso de RDC | REGLA OPERATIVA / IMPLEMENTACIÓN | La abstracción normativa es la operación mediante entorno autorizado. |
| Identidades administrativas u operativas concretas | DECISIÓN CONTEXTUAL | Pertenecen a un entorno determinado. |
| PowerShell / comandos específicos | PROCEDIMIENTO | Son mecanismos de implementación. |
| Reglas técnicas específicas de otros proyectos | PROCEDIMIENTO / REGLA OPERATIVA | Pertenecen al ámbito técnico específico. |
| Ejemplos de nombres de versiones | EJEMPLO | No constituyen vocabulario canónico. |
| Convenciones de salida de una conversación concreta | REGLA OPERATIVA / PROCEDIMIENTO | No deben confundirse con el principio metodológico subyacente. |

## E. ANEXOS RELACIONADOS

| Anexo | Relación |
|---|---|
| Anexo de versionado | CANDIDATO / parcialmente existente |
| Anexo de foliación global | CANDIDATO |
| Anexo de gobernanza del entorno | EXISTENTE CONCEPTUALMENTE |
| Anexo de consolidación de principios | CANDIDATO |
| Anexo de criterios MAJOR/MINOR/PATCH | CANDIDATO — requiere definición posterior |
| Anexo de nomenclatura de versiones | CANDIDATO |
| Anexo de reglas operativas por proyecto | CANDIDATO |
| Anexo de trazabilidad | CANDIDATO |
| Procedimientos técnicos concretos | SIN ANEXO NECESARIO |

## F. CONFLICTOS, SOLAPAMIENTOS Y PENDIENTES

### Conflictos

**NINGUNO DETECTADO.**

### Solapamientos

Existe solapamiento conceptual entre narrativa evolutiva, trazabilidad narrativa e identidad de versión. Son candidatos a consolidación posterior si el canon demuestra que pueden expresarse como una unidad normativa sin pérdida semántica.

### Foliación

**PENDIENTE DE FOLIACIÓN CANÓNICA.** No se dispone en esta conversación del registro completo de folios ya asignados; por seguridad normativa no se inventaron números.

### Jerarquías

**PENDIENTES.** La conversación establece el significado de la jerarquía, pero no proporciona fundamento suficiente para asignar valores numéricos a cada principio nuevo.

### MAJOR/MINOR/PATCH

**PENDIENTE DE FORMALIZACIÓN.** La convención MAJOR.MINOR.PATCH está confirmada, pero los criterios exactos para incrementar cada componente permanecen abiertos.

### Consolidación

**PENDIENTE.** Los principios derivados deben evaluarse frente al canon completo antes de incorporarse como normas definitivas.

## G. CONTROL FINAL DE CALIDAD

| Control | Resultado |
|---|---|
| Cobertura del contenido | OK |
| Atomicidad | OK |
| Generalidad | OK |
| Estabilidad | OK |
| No duplicación | OK — con solapamientos señalados para consolidación |
| Jerarquía | PENDIENTE — no se inventaron valores |
| Nomenclatura | OK |
| Trazabilidad | OK |
| Compatibilidad | OK |
| Completitud | OK — dentro del contexto disponible |

## Estado del entregable

**Análisis:** COMPLETADO  
**Control de calidad:** COMPLETADO  
**Canonización:** NO REALIZADA  
**Foliación definitiva:** PENDIENTE  
**Jerarquías definitivas:** PENDIENTES

Este archivo representa el resultado del análisis de la conversación y constituye un insumo de consolidación. Su persistencia no convierte automáticamente los elementos DERIVADOS o PROPUESTOS en principios canónicos.
