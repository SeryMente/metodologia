# 📝 GOV-TASK-006 · Reconciliar divergencias documentales de Gobernanza

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-006`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Auditar y reconciliar las divergencias entre el estado vigente del DUG, índices, núcleo operativo, pendientes, crónicas y evidencias, conservando los antecedentes históricos sin presentarlos como estado actual.

## Referencia de origen

frentes/gobernanza/README.md; GOBERNANZA.md; PENDIENTES.md; crónicas y evidencias históricas; INICIO.md.

## Dependencias y límites

Control de Gobernanza generación 7 (C-GOBERNANZA-RETOMA-06); cualquier diferencia normativa se resuelve en el DUG y no mediante fusión silenciosa de copias.

## Hallazgos de reconciliación actual

- DUG vigente: v373 · NX-373m, blob `cac4525de77d4f47a8a59c25201968ecf2056b90`.
- Control de Gobernanza: generación 7, blob leído de vuelta `c41c3cddc866de999827fc6ae36c23dde400344f`.
- Punto de entrada, núcleo, pendientes y registro de tareas conservaban referencias activas a v371/generación 6; se corrigen en este corte documental, sin reescribir los registros históricos.
- **GOW canónico:** el banner humano conserva v2.12; la proyección `gov-data.document.gow_version` y `gov-data.glossary.version` declara 2.14 y contiene 127 términos. De esos 127 nombres estructurados, 115 aparecen literalmente en la sección humana y 12 no se encuentran allí: Principio de gobernanza; Anexo del DUG; IPZ · Instrucciones Personalizadas de ChatGPT; Rama principal main; Control de responsabilidad; UUIDv7 local; MCP normativo; Folio de conversación; Binomio A/B; Foliación jerárquica; CNP · Conjunto Nuclear de Principios; PAI · Principio Anti-Ineficiencia. La comparación v367→v368 confirma que la revisión estructurada pasó de 2.13 a 2.14 sin cambio en el texto humano. El JSON auxiliar GLOSARIO-WORKSPACE.fuente.json sigue describiendo v2.11/blob histórico y se declara derivado, no normativo.
- **INICIO.md:** conserva frases antiguas de ART-027 sobre telemetría de consideración/selección/consulta/aplicación y cuenta FOL1 de 25 contextos/22 elegibles/3 bloqueados; el registro maestro actual indica 26 OCP/23 elegibles/3 bloqueados. El control del frente Metacanon está `owned`, generación 6, por `chatgpt-C-METACANON-ARRANQUE-360-SES-20261029-7F4A9C21`; INICIO.md no fue modificado desde Gobernanza. Es una dependencia interfrente que debe reconciliar su titular.
- **Límite de esta reconciliación:** 115/127 es un cotejo literal de nombres, no prueba automática de ausencia conceptual bajo sinónimos. La discrepancia de versión y las 12 entradas ausentes exigen decidir qué representa el GOW humano vigente. No se cambia DUG/GOW ni se altera la proyección estructurada por iniciativa de esta sesión.

## Siguiente actuación

Obtener decisión del operador sobre la autoridad objetivo del GOW: (A) completar el texto humano para reflejar v2.14/127 términos y corregir el banner, incorporando las 12 entradas faltantes con alcance/definiciones cotejados; o (B) tratar v2.12/texto humano como vigente y autorizar revertir la proyección estructurada a su representación concordante. Después de esa decisión y autorización P005, alinear el archivo auxiliar derivado. En paralelo, solicitar al titular Metacanon gen6 la corrección de INICIO.md; Gobernanza no escribe ese OCP.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.


## Ampliación de objetivo · Gobernanza 1.0 · 2026-10-31

Además de las divergencias ya identificadas, esta tarea debe inventariar y resolver los elementos satélite que crecieron alrededor del DUG (por ejemplo, documentos de identidad o auxiliares que contienen reglas, definiciones o estado que debió residir en el documento único). El objetivo de 1.0 es recuperar una única fuente normativa, conservar procedencia e historia y dejar cada artefacto satélite clasificado como: índice/navegación, proyección derivada, evidencia histórica, control operativo o candidato a integración/eliminación.

No borrar, fusionar ni trasladar elementos por inferencia. La decisión de cada satélite debe señalar autoridad, función, dependencia, contenido duplicado y destino. El resultado debe evitar que un elemento auxiliar se convierta inadvertidamente en una segunda fuente normativa.


## Vector vigente y alcance satélite · C-GOBERNANZA-VECTOR-SEMANTICO-01 · 2026-10-31

El cierre 1.0 requiere inventario explícito de todo elemento situado alrededor del DUG, con clase, autoridad, función, procedencia, dependencia, duplicación y destino: índice/navegación, proyección derivada, control operativo, evidencia histórica o candidato a integración/eliminación. El nombre `identidad.md` fue señalado expresamente por el operador, pero la búsqueda de nombre en el árbol y las referencias Git disponibles para esta revisión no devolvió coincidencia. Estado correcto: **no localizado en las fuentes consultadas; ubicación y procedencia pendientes**, no «inexistente». No borrar, mover, fusionar ni elevar a fuente normativa por inferencia.

El GOW también presenta divergencia humana/estructurada (banner humano 2.12 frente a estructura declarada 2.14/127 términos, con 12 nombres sin coincidencia literal en el texto humano). Resolver precedencia y destino dentro de esta tarea sin cambiar el DUG/GOW canónico sin la autorización normativa requerida. El auxiliar `GLOSARIO-WORKSPACE.fuente.json` es derivado, no una segunda autoridad.

La salida de esta tarea será una matriz de inventario y decisión por satélite, más evidencia de lectura de vuelta. Trazabilidad: [C-GOBERNANZA-VECTOR-SEMANTICO-01](../../cronica/C-GOBERNANZA-VECTOR-SEMANTICO-01.md).


## Reporte individual obligatorio de resolución/cierre
Al resolver, completar, bloquear o cancelar esta tarea, registrar su propio informe en este README usando [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md). Explicar objetivo y resultado, cómo se solucionó, decisiones verificables, cambios/rutas/commits/blobs/SHA, criterios y pruebas ejecutadas con logs/artefactos, read-back, bloqueantes/dependencias, preocupaciones/riesgos, pendientes, rollback y aceptación. Declarar NINGUNO_VERIFICADO o NO_VERIFICADO donde corresponda; nunca ocultar campos. No marcar completada sin criterios PASS, evidencia y read-back. Actualizar el índice padre después de verificar este informe y entregar al operador el enlace individual y síntesis de solución, evidencia, bloqueantes y preocupaciones. No incluir secretos ni datos sensibles.
