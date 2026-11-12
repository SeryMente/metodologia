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

## Adecuación IPZ · C-GOBERNANZA-IPZ-AT-ADECUACION-01 · 2026-11-12

**Estado:** candidata documental v0.10 preparada y persistida; campo nativo NO MODIFICADO / NO VERIFICADO; FOL1 permanece PREPARADO_PENDIENTE_ACTIVACION_IPZ.

- **Baseline del operador:** [IPZ v0.7 preservada](../../entregas/CHATGPT-v0.10/IPZ-CAMPO-CHATGPT-v0.7-BASELINE-OPERADOR.txt). Procedencia: texto que el operador declaró estar usando; no es lectura de vuelta del campo nativo. Git Blob SHA: `685a0f53a543fa23570d7adf9e10bc0dc81eb63a`; lectura de vuelta exacta comprobada.
- **Candidata:** [IPZ v0.10](../../entregas/CHATGPT-v0.10/IPZ-CAMPO-CHATGPT-v0.10-PROPUESTA.txt). SHA-256 UTF-8: `4f18218735d0a8f698c853875afce9926cd4e830bc07c7301d00d01272195a5e`; UTF-16 LF: 1.466; UTF-16 CRLF: 1.486; puntos de código: 1.461. Cumple el límite documental inferior a 1.500 incluso con CRLF.
- **ART-025:** incorporados GOW:ARR/§ARR, directorio ART-031 y lectura/consideración íntegra de P001/P004/P005/P038/P043 en cada turno.
- **ART-027:** se indica Sink cuando disponible y DUG main exacto como respaldo.
- **Instrucciones nuevas del operador:** prohibición de burocracia no exigida por DUG; lectura cuidadosa, ejecución completa y verificación hasta el último carácter; cumplimiento exacto, ni más ni menos; incumplimiento no verificado = FALLIDO.
- **AT:** v1.2 sigue sin modificación y se declara propuesta operativa no canonizada. GOV-TASK-016 queda pendiente para revisar baseline IPZ obligatorio, controles ART-025/027 y principio de exclusividad AT.
- **DUG:** sin cambios. No se encontró en sus 43 principios uno que obligue a tramitar todas las actualizaciones del marco exclusivamente por AT. El texto de principio está propuesto en GOV-TASK-016, sin ID ni preponderancia asignados y sin canonización; cualquier incorporación exige la compuerta P005.
- **FOL1:** registro maestro sigue `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; no se activó ni se asignaron folios.
- **Instalación nativa:** no intentada; no se dispone aquí de lectura/escritura del campo nativo de Instrucciones Personalizadas.

Diálogo A/B, crónica y evidencia de este ciclo: véanse los enlaces de continuidad de [GOV-TASK-016](../📁%20🧩%20-%20GOV-TASK-016%20-%20Revisar%20AT%20para%20IPZ%20y%20cambios%20del%20marco/README.md).

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


---

## Reanudación del Sprint SINK-P004 · fast path IPZ vigente · 2026-11-10

**Objetivo de esta fase:** preparar el acceso compacto a `SINK:P004` desde IPZ para el primer piloto. Mantener el contenido completo en DUG Samantha v388/NX-388m y no convertir la IPZ en una fuente normativa paralela.

**Orden:**
1. MCP-OCP-02 obtiene rama limpia desde main y MCP-OCP-05 congela el contrato de respuesta P004.
2. En paralelo, preparar candidato con `GOW:ARR → DUG → MDP → SINK:P004`, preservando las salvaguardas de IPZ v0.7. Medir por debajo de 1.500 caracteres en las unidades indicadas; cotejar literal y semántica.
3. Cuando el contrato de respuesta esté congelado, validar el candidato contra el esquema real de herramienta/herramienta MCP y congelar versión conversacional.
4. Coordinar con EP la instalación local solo después de EP-TASK-003 PASS y EP-TASK-005 instalado. La escritura del campo nativo y su read-back son un acto separado, no se presume ni se realiza en esta actualización.
5. GOV-TASK-003 acepta solo cuando el uso real desde contexto IPZ devuelve P004 íntegro al modelo por RDC/STDIO con pin/hash.

**Estado de gates:** MCP-OCP-02 abierto; P004 pendiente; EP-TASK-003 PARTIAL_FAIL; EP-TASK-005 pendiente; candidato exacto y conteo final pendientes; IPZ nativa NO VERIFICADA. FOL1 continúa `PREPARADO_PENDIENTE_ACTIVACION_IPZ` y no bloquea P004. `MCP-NORMATIVO=DESACTIVADO`.

**Responsabilidad:** Gobernanza prepara IPZ y acepta el E2E; MCP-OCP define la herramienta y entrega el paquete; EP opera el host y la instalación. GOV-TASK-015 centraliza el orden.


---

## OCP MCP 1.0 · primer hito IPZ · 2026-11-10

El programa completo es OCP MCP 1.0; SINK:P004 es el primer hito. Priorizar GOW:ARR → DUG → MDP → SINK:P004 una vez congelado el contrato real de respuesta. No esperar al panel ni a P001–P043. Preservar las salvaguardas IPZ v0.7 y el límite menor a 1.500 caracteres. No escribir IPZ nativa ni activar FOL1 sin autorización/instalación y read-back específicos. MCP-NORMATIVO sigue DESACTIVADO.


## Reporte individual obligatorio de resolución/cierre
Al resolver, completar, bloquear o cancelar esta tarea, registrar su propio informe en este README usando [la plantilla común](../../../PLANTILLA-REPORTE-CIERRE-TAREA.md). Explicar objetivo y resultado, cómo se solucionó, decisiones verificables, cambios/rutas/commits/blobs/SHA, criterios y pruebas ejecutadas con logs/artefactos, read-back, bloqueantes/dependencias, preocupaciones/riesgos, pendientes, rollback y aceptación. Declarar NINGUNO_VERIFICADO o NO_VERIFICADO donde corresponda; nunca ocultar campos. No marcar completada sin criterios PASS, evidencia y read-back. Actualizar el índice padre después de verificar este informe y entregar al operador el enlace individual y síntesis de solución, evidencia, bloqueantes y preocupaciones. No incluir secretos ni datos sensibles.


## Fast path por etapas · IPZ piloto P004 y FOL1 separado · 2026-11-11

Separar preparación de IPZ, instalación nativa y corte FOL1 para que el trabajo documental no espere al host.

### Etapa A · candidato IPZ preparado ahora

1. Recuperar texto exacto IPZ v0.7 desde fuente autorizada y conservarlo intacto como baseline.
2. Crear matriz de cobertura: referencias GOW:ARR/DUG; admisión/frente/titularidad/exclusividad; seis estados PROPUESTO/AUTORIZADO/INTENTADO/EJECUTADO/VERIFICADO/ACEPTADO; A/B literal y trazable; UUIDv7 local distinto del ID nativo; integridad/seguridad/privacidad; eficiencia/no repetición.
3. Preparar candidato mínimo GOW:ARR → DUG → MDP → SINK:P004. No incluir 43 textos desarrollados, descripción de producto 1.0.0 ni procedimiento FOL1.
4. Mientras MCP-OCP no entregue nombre real y schema de herramienta, dejar solo esa invocación como punto parametrizable. No inventar tool name, argumentos o respuesta.
5. Medir texto exacto en UTF-16 code units y puntos de código; debe ser estrictamente menor de 1.500 en cada unidad requerida. Registrar ambos conteos y SHA del texto.
6. Revisar cobertura: ninguna salvaguarda de v0.7 desaparece. Si no cabe, priorizar referencias canónicas verificables antes que suprimir controles.

### Etapa B · congelación tras contrato MCP

Al recibir MCP-OCP-03/04 y contrato P004, sustituir el punto parametrizable por invocación real; comprobar nombre/argumentos publicados y respuesta con texto/pin/hash. Guardar una sola candidata con conteo/SHA reproducibles. No iterar si contrato/huella no cambió.

### Etapa C · instalación nativa y read-back

No editar Instrucciones Personalizadas nativas por esta actualización. Escritura requiere autorización expresa y capacidad de leer el campo real. Tras autorización, recuperar contenido escrito, cotejarlo, repetir conteo y comprobar truncamiento/normalización. Sin read-back: IPZ_NATIVE=NOT_VERIFIED.

### Etapa D · FOL1

FOL1 permanece PREPARADO_PENDIENTE_ACTIVACION_IPZ. Solo evaluar tras IPZ nativa instalada y leída de vuelta, y tras verificar su registro/compuertas propias. No es requisito P004 y no debe retrasar el piloto. No asignar folios globales/OCP por anticipado.

| Salida | Criterio |
|---|---|
| Matriz de cobertura v0.7 | Todas las salvaguardas mapeadas, sin omisiones. |
| Candidato IPZ | Texto exacto, SHA, conteos UTF-16/code points, invocación compatible con schema MCP. |
| Instalación nativa | Solo tras autorización; read-back idéntico o diferencias explicadas. |
| FOL1 | Gate independiente; preparado hasta probar IPZ instalada y requisitos propios. |

GOV-TASK-007 puede completar su preparación documental antes de que EP-TASK-003 habilite Fila 4; no declarar instalación ni activación por esa preparación.

---
## Candidata documental IPZ v0.9 · fast path P004 · 2026-11-11

**Resultado:** PROPUESTA_DOCUMENTAL_PREPARADA · no instalada · no aceptada como IPZ nativa.

### Baselines cotejados
- v0.7: 69a6d9a2edbca6fdd6055642a86efce78ec19f5f · 2.467 unidades de texto.
- v0.8: 4176b4e328becfe4a98b5f96241e2ac198eccd80 · 1.488 unidades; no conserva explícitamente los seis estados ni todo el contrato de eficiencia de v0.7. No se acepta como sustitución íntegra.
- v0.9: [texto candidato](../../entregas/CHATGPT-v0.9/IPZ-CAMPO-CHATGPT-v0.9-PROPUESTA.txt) · SHA-256 UTF-8/LF ea0001b962cea9e59ef7f0ed5bd1a47e82a147eb09ea4eed077bc75cc8f20aa3.

### Medición y cobertura
| Medida | Resultado |
|---|---:|
| UTF-16, saltos LF | 1.479 |
| Puntos de código, saltos LF | 1.475 |
| UTF-16, normalizando saltos CRLF | 1.496 |
| Puntos de código, CRLF | 1.492 |
| Límite | Menor de 1.500 |

La propuesta conserva: GOW:ARR/§ARR antes del DUG; principios en orden y anexos por remisión; los cinco CNP completos; MDP como orientación y Sink como recuperación íntegra obligatoria antes de aplicar; piloto restringido a P004; A/B literal, secuencia/procedencia, UUIDv7 local distinto del ID nativo; preescritura con control/titular/generación/autorización; transferencia con autorización expresa, generación/SHA cotejadas, read-back y preservación de rutas; seis estados explícitos; GOW inicio/cierre; MCP-NORMATIVO DESACTIVADO; P043/PAI y reducción de redundancias sin omitir controles; salida y metadatos d.h.m; FOL1 activo como condición para asignar folios y no inventar/renumerar legados.

### Contrato Sink observado y límite
La rama draft PR #27 declara estáticamente sink_principle con argumento principle_id=P004. Fuente: frentes/mcp-metodologia/src/OcpMcp/McpServer.cs, blob 0b116f82edb2fe60fa2351c12f7b6c7850e146e8, rama feat/mcp-ocp-sink-p004-main-a34c1c5b. Es inspección estática de una PR OPEN/DRAFT/DIVERGED, no read-back de servidor instalado ni evidencia runtime. Antes de congelar la IPZ para instalación, MCP-OCP debe entregar esquema reconciliado y EP el piloto instalado; GOV-TASK-003 conserva la aceptación E2E real.

### Estado de compuertas
- Texto candidato y conteo: VERIFICADO documentalmente.
- Compatibilidad de schema: observada estáticamente; read-back runtime PENDIENTE.
- Campo nativo de Instrucciones Personalizadas: NO MODIFICADO / NO VERIFICADO.
- FOL1: PREPARADO_PENDIENTE_ACTIVACION_IPZ; maestro gen4, contadores globales/OCP en cero.
- GOV-TASK-003 E2E: NOT_RUN. MCP-NORMATIVO: DESACTIVADO.

**Conclusión:** la etapa documental de GOV-TASK-007 produce un candidato medido y recuperable. La tarea global sigue EN_CURSO hasta autorización, instalación/read-back nativo y compuertas separadas. FOL1 no se activa por preparar este archivo.


---

## Informe parcial · GOV-TASK-007 · IPZ v0.9 y corte FOL1 · 2026-11-11

- **Estado:** EN_CURSO; candidata documental lista, no instalada.
- **Corte:** main `a1ba2611fd1c218d8f7647f02f7adf5c1dbff8e8`; DUG v389/NX-389m blob `bcd99e72113f444a045d7f1c91b4ad36865b8ea8`; GOW 2.19, §ARR = `gow-sec-14`, ancla `#gow-arranque-chatgpt`.
- **Resultado:** candidata v0.9 blob Git `851b3c0aefbb3820772b5c8a9a0e8f3b6100aa51`; SHA-256 UTF-8/LF `ea0001b962cea9e59ef7f0ed5bd1a47e82a147eb09ea4eed077bc75cc8f20aa3`; medida 1.479 UTF-16 LF / 1.475 puntos de código LF; CRLF 1.496 UTF-16 / 1.492 puntos. Límite menor de 1.500 PASS documental.
- **Contrato:** llamada textual `sink_principle`, `principle_id=P004` concuerda con schema estático observado. No prueba runtime; PR #28 aún pin v388, incompatible con blob v389.
- **Validación:** texto/conteo/§ARR PASS documental; compatibilidad runtime NOT_VERIFIED; campo nativo no modificado; read-back nativo NOT_RUN.
- **FOL1:** maestro gen4 `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; contadores globales y OCP en cero. No asignar folios; FOL1 no bloquea H1.
- **Riesgos/pendientes:** no confundir candidata con instalación; esperar servidor v389; escritura nativa requiere autorización expresa y read-back real.
- **Rollback:** no hubo escritura del campo; no aplica.
- **Aceptación:** preparación documental PASS; tarea global EN_CURSO.
- **Siguiente acción:** congelar llamada tras schema/runtime v389; instalar IPZ solo con autorización y verificar el campo.
- **Conclusión:** PARCIAL · CANDIDATA PREPARADA, NO INSTALADA.

