# Salida final · Reducción del diseño común de tareas

Apliqué la instrucción de reducir el diseño a su mínima expresión y de mantener el apego a las instrucciones verbatim. La intervención se limitó a los candidatos de Tareas; el DUG/GOW no se modificó y Tareas no se canonizó.

## Estándar común mínimo vigente como propuesta: v0.2

- [Estándar común de tarea v0.2](../../ESTANDAR-COMUN-DE-TAREA-v0.2.md)
- [Esquema JSON mínimo v0.2](../../ESQUEMA-TAREA-COMUN-v0.2.json)
- [Diseño de Tareas v1.0 actualizado](../../DISEÑO-TAREAS-v1.0.md)
- [Instrucciones operativas reducidas](../../INSTRUCCIONES-TAREAS-v1.0.md)
- [Texto candidato IPZ reducido](../../IPZ-TAREAS-CANDIDATO.txt)
- [Pendientes actualizados](../../PENDIENTES.md)

El núcleo queda en cuatro campos: **identidad, enunciado, referencia al origen y estado**. La referencia de ámbito es condicional: solo se añade si el contexto no permite identificarlo claramente. Los estados propuestos son pendiente, en curso, completada y cancelada.

## Elementos retirados del núcleo

La v0.2 no exige campos separados para resultado esperado, criterio de aceptación, siguiente acción, responsable, prioridad, fecha límite, relaciones, bloqueos, evidencia por tarea ni marcas temporales. La v0.1 queda preservada como antecedente histórico, pero ya no es la propuesta vigente. Las necesidades futuras podrán reabrirse solo con una instrucción expresa o un caso real que lo justifique.

## Qué no se ha hecho

No se creó un registro de tareas, no se decidió una plataforma canónica, no se probó una tarea real end-to-end y no se ejecutó un validador completo de JSON Schema. El JSON v0.2 solo se comprobó sintácticamente con JSON.parse. El archivo de IPZ del repositorio se actualizó y releyó, pero el campo nativo de ChatGPT no se modificó ni verificó.

**Tareas sigue en incubación.** Antes de ampliar el diseño, falta determinar si el ámbito añade una capacidad necesaria a la metodología existente. No se deben agregar campos, estados ni infraestructura por simetría o anticipación.

Registro del ciclo: [crónica](../../cronica/C-TAREAS-ESTANDAR-MINIMO-02.md) · [evidencia](../../evidencias/C-TAREAS-ESTANDAR-MINIMO-02.json) · [diálogo con la instrucción literal](../../conversaciones/C-TAREAS-ESTANDAR-MINIMO-02-dialogo.jsonl).
