# 📝 GOV-TASK-007 · Reconciliar IPZ y cerrar el corte FOL1

**Naturaleza:** OCP provisional de tarea; no es un frente independiente ni una unidad taxonómica canonizada.  
**Estado:** `en_curso`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control ni sesión propios.  
**task_id:** `GOV-TASK-007`  
**scope_ref:** `frentes/gobernanza/`

## Enunciado

Preparar una nueva IPZ que conserve las salvaguardas verificadas de v0.7 e integre el estado vigente, comprobar su límite y contenido, y después realizar la instalación observable y el corte FOL1 conforme a sus compuertas.

## Referencia de origen

frentes/gobernanza/PENDIENTES.md; INICIO.md; ART-025; registro maestro FOL1.

## Dependencias y límites

IPZ v0.8 no es sustitución íntegra: tiene 1.488 caracteres, pero omite la lista explícita de estados de autorización/ejecución y parte del contrato de eficiencia temporal presente en v0.7 (2.467 caracteres). FOL1 permanece PREPARADO_PENDIENTE_ACTIVACION_IPZ. No modificar campo nativo sin capacidad observable y read-back.

## Siguiente actuación

Cotejar v0.7 frente a v0.8 y ART-025/ART-027, preparar una versión completa dentro del límite de 1.500 caracteres y verificar su instalación antes de activar FOL1.

## Conciliación efectuada · 2026-10-30

- **v0.7:** 2.467 caracteres; conserva los estados propuesto/autorizado/intentado/ejecutado/verificado/aceptado, A/B literal y trazable, UUIDv7 local distinto del ID nativo, protección de rutas/control, GOW y MCP normativo desactivado, y el contrato temporal detallado.
- **v0.8:** 1.488 caracteres; añade CNP y PAI, pero no mantiene la distinción explícita de los seis estados ni buena parte del detalle de eficiencia de v0.7. No instalar como reemplazo íntegro.
- **v0.9:** borrador conversacional de 1.478 caracteres preparado para revisión. No se guardó como candidato en Git ni se escribió en instrucciones nativas.
- **FOL1:** registro maestro leído de vuelta desde `main`, blob `b93cbef77f2fa1a6e4290ae8177e957a1616e47b`; estado `PREPARADO_PENDIENTE_ACTIVACION_IPZ`, generación 3, 26 OCP conocidos, cero asignaciones, contadores globales en cero y cobertura `KNOWN_INVENTORY_ONLY`.

**Bloqueo de cierre:** la instalación de IPZ exige acceso a la configuración nativa, escritura autorizada y lectura de vuelta observable. FOL1 no se activa antes de comprobar esa instalación y efectuar el corte conforme a sus compuertas. En esta sesión no se ejecutó escritura nativa ni se asignaron folios.

## Criterio de cierre

Marcar como completada solo cuando el enunciado haya sido atendido, la evidencia correspondiente sea recuperable y el resultado haya sido leído de vuelta en la fuente canónica aplicable.


## Antecedente histórico supersedido · reorientación inicial · 2026-10-31

Este alcance precisa y amplía el enunciado anterior. El IPZ debe ser una instrucción de entrada compacta, no un resumen del DUG ni una fuente normativa paralela:

1. Máximo estricto de 1.500 caracteres en el campo nativo.
2. Primera referencia Sync acortada: GOW/§ARR, para que el modelo adquiera el vocabulario operativo.
3. Segunda referencia Sync acortada: DUG, documento único de gobernanza y sistema de instrucciones.
4. Después de ambas referencias, refuerzo de la compuerta obligatoria de admisión: no iniciar trabajo sustantivo sin frente asignado explícitamente y titularidad/exclusividad verificada mediante el protocolo vigente.
5. El modelo no acepta consultas ajenas al frente asignado ni infiere un frente a partir de una pregunta general.
6. El folio de ciclo no sustituye el control de titularidad de conversación. La integración de FOL1 ocurre después de instalar y verificar el IPZ, respetando sus compuertas.
7. IPZ debe preservar las salvaguardas vigentes de v0.7 y su formato de salida, sin perder los estados de autorización/ejecución ni el contrato de eficiencia temporal.

**Criterio ampliado de cierre:** contenido dentro de 1.500 caracteres; ambas referencias Sync resuelven a los destinos correctos; refuerzo de admisión probado con casos positivos y negativos; instalación en el campo nativo leída de vuelta; y solo entonces activar FOL1 conforme al protocolo. No se afirma instalación ni activación por la preparación del texto.


## Estado rector · C-GOBERNANZA-VECTOR-SEMANTICO-01 · 2026-10-31

La secuencia del campo queda fijada: (1) primer Sync acortado a GOW/§ARR; (2) segundo Sync acortado al DUG único; (3) refuerzo fail-closed de admisión, frente asignado y titularidad/exclusividad verificada; (4) reglas mínimas de sesión/ciclo y salida, dentro del máximo de 1.500 caracteres. Medir la longitud real en unidades exigidas por el campo. Mantener las seis distinciones de estado de v0.7 y el resto de salvaguardas verificadas: no sustituir con v0.8 incompleta.

La instalación y lectura de vuelta del campo nativo son requisito previo a activar FOL1. El ciclo global no se inventa ni se asigna mientras FOL1 siga `PREPARADO_PENDIENTE_ACTIVACION_IPZ`. Trazabilidad: [C-GOBERNANZA-VECTOR-SEMANTICO-01](../../cronica/C-GOBERNANZA-VECTOR-SEMANTICO-01.md).



## Rectificación de referencias IPZ aprobada · 2026-11-09 · C-GOBERNANZA-IPZ-RDC-SINK-01

Para el modo local aprobado, las dos referencias de entrada dejan de ser URLs cortas Sync. La secuencia ejecutable será:

1. `GOW:ARR` — recuperar §ARR y su vocabulario inicial por RDC/MCP-OCP.
2. `DUG` — comprobar la fuente canónica completa y su procedencia.
3. Después, aplicar el refuerzo fail-closed de admisión y las demás salvaguardas de v0.7.
4. Cuando un MDP indique pertinencia, consultar `SINK:Pxxx` antes de aplicar el principio.

Los identificadores son referencias operativas locales, no enlaces HTTP ni credenciales. No implementar MOD-SYNC, Cloudflare, túneles o resolvedores públicos para satisfacer este requisito. La versión IPZ final sigue sujeta a menos de 1.500 caracteres en el texto exacto (UTF-16 y puntos de código), con todas las salvaguardas de v0.7 y sin copiar la norma desarrollada.

La instalación de las Instrucciones Personalizadas nativas y su read-back son una fase aparte. FOL1 solo podrá activarse después de esa verificación; mientras tanto sigue `PREPARADO_PENDIENTE_ACTIVACION_IPZ` y no se asignan folios globales.

**Estado:** contrato de referencias armonizado; texto IPZ final, conteo, instalación nativa, read-back y FOL1 permanecen pendientes.


## Separación de la aceptación del servidor MCP-OCP · 2026-11-09

La instalación local del servidor MCP-OCP es entregable de EP-TASK-005 y se ubica en `frentes/mcp-metodologia/instalacion-local/` dentro del checkout local de Metodología. **No depende de instalar o actualizar la IPZ nativa ni de activar FOL1.** GOV-TASK-007 conserva su propio orden: reconciliar v0.7 y salvaguardas, medir menos de 1.500 caracteres, instalar el campo nativo cuando proceda y verificar read-back; solo después se evalúa el gate FOL1. La ausencia de FOL1 no bloquea implementación, build, paquete ni instalación local del servidor. No asignar folios globales antes del corte autorizado.

---

## Fast path IPZ para piloto SINK:P004 · 2026-11-10

Para habilitar el uso práctico de Sink cuanto antes, esta tarea prepara el candidato IPZ compacto **después de congelar el contrato de respuesta SINK:P004** y coordina su prueba con MCP-OCP-04/GOV-TASK-003.

**Contrato fuente vigente:** DUG Samantha v388/NX-388m, ART-027, define `SINK:Pxxx` como recuperación local por MCP-OCP STDIO/RDC. No es un alias HTTP ni debe confundirse con `MOD-SYNC`, que pertenece a EP.

Secuencia de contenido:
1. `GOW:ARR` — adquirir §ARR y vocabulario operativo.
2. `DUG` — verificar Samantha v388/NX-388m y procedencia de la fuente canónica.
3. Inventario de 43 IDs/MDP; determinar pertinencia sin tratar MDP como texto normativo.
4. Cuando sea pertinente, consulta obligatoria `SINK:Pxxx`; el primer piloto usa P004.
5. Preservar admisión fail-closed, asignación de frente, titularidad/exclusividad, distinciones de estado y las demás salvaguardas de v0.7.

El candidato debe quedar por debajo de 1.500 caracteres medidos en las unidades nativas requeridas (UTF-16 y puntos de código), cotejado literalmente, sin copiar los textos desarrollados ni convertirse en fuente normativa paralela. El piloto E2E exige demostrar IPZ → RDC autorizado → MCP-OCP STDIO → respuesta visible al modelo con pin/hash. Un JSON-RPC desde consola solo demuestra transporte y no valida el uso desde IPZ.

La escritura en Instrucciones Personalizadas nativas, lectura de vuelta y conteo sobre el campo realmente instalado son acciones separadas. **No se declara IPZ nativo modificado/instalado en esta actualización.** FOL1 sigue `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; no bloquea SINK:P004 y no se activa hasta superar su propio gate. No inventar folios.

**Estado:** secuencia y criterio del piloto documentados; candidato exacto, conteo, escritura nativa, read-back y E2E siguen pendientes.



---

## Estado vigente de Fast Path IPZ para SINK:P004 · 2026-11-10

El orden continúa siendo: (1) congelar el contrato de respuesta de MCP-OCP para `SINK:P004`; (2) preparar el candidato IPZ compacto con `GOW:ARR → DUG → MDP → SINK:P004`; (3) cotejar el límite de 1.500 caracteres y las salvaguardas de v0.7; (4) instalar/read-back el campo nativo como operación separada; (5) activar FOL1 solo después de que su propio gate quede satisfecho. No invertir el orden ni utilizar un candidato incompleto como reemplazo de v0.7.

**Estado de dependencias:** la implementación P004 y la rama MCP-OCP-02 válida siguen pendientes; la rama candidata observada es antigua respecto de main y no cumple el rebaseline. EP-TASK-003 continúa `PARTIAL_FAIL`, por lo que la instalación/consulta con fuente privada en Fila 4 no puede comenzar. La preparación textual del candidato IPZ y sus pruebas de longitud/estructura pueden avanzar fuera del host; no modificar aún las Instrucciones Personalizadas nativas.

**Aceptación:** GOV-TASK-003 solo cierra cuando la llamada real se origina en el contexto IPZ y la respuesta P004 aparece visible al modelo por RDC/STDIO con texto íntegro, pin y SHA-256. Una prueba manual de consola no es sustituto. FOL1 es independiente y no bloquea el piloto.

`GOV-TASK-007=IPZ_CANDIDATE_PREP_PENDING_P004_CONTRACT` · `IPZ_NATIVE=NOT_VERIFIED` · `FOL1=PREPARADO_PENDIENTE_ACTIVACION_IPZ` · `MCP-NORMATIVO=DESACTIVADO`.
