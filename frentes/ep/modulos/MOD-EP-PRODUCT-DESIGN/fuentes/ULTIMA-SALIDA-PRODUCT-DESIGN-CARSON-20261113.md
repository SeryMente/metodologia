# Salida visible · Product Design / Carson · 2026-11-13

## A · instrucción rectora

La instrucción literal del operador está conservada como SRC-PD-20261113-IDEACION-03 en SPRINT-GENERAL-PRODUCT-DESIGN.md §18. Este checkpoint no reconstruye ni sustituye ese original.

## B · resultado visible del ciclo

### Diseño adoptado

La primera versión de la herramienta de lluvia de ideas funciona desde el chat ordinario de ChatGPT. Carson actúa como coach conversacional y BMAD Core bmad-brainstorming como motor. Se soportan los modos Facilitator, Creative Partner e Ideate for me. No se requiere un portal, selector, dashboard, Keepsake ni OpenCode.

Carson es una capa de identidad/facilitación, no un modelo independiente. La fuente CIS indica que BS — Guided Brainstorming Session delega al motor bmad-brainstorming. La instalación local BMAD Core 6.12.4 y el perfil upstream de Carson fueron inspeccionados. El catálogo brain.py categories mostró 108 técnicas en 13 categorías.

### Persistencia y biblioteca

El guardado ocurre por ciclo de ideación: al terminar tandas, transiciones entre divergencia/convergencia, pausas e interrupciones, o cierre. No se escribe carácter por carácter ni por cada turno trivial. Cada registro conserva las formulaciones íntegras de ideas verdes y maduras, autoría, técnicas, preguntas, hallazgos y decisiones. La síntesis se añade aparte y no reemplaza el contenido original.

Si el operador no nombra proyecto, se genera nombre descriptivo a partir de tema/fecha y etiquetas esenciales. El índice SQLite FTS5 es derivado y reconstruible desde proyectos, sesiones y ciclos; los resultados reutilizables se enlazan a otros proyectos sin duplicar ni perder la procedencia.

La conservación a largo plazo es el objetivo, pero no se promete permanencia literal sin redundancia, cifrado, custodia de claves y pruebas periódicas de restauración. Los datos del módulo deben permanecer dentro del workspace protegido EP; los respaldos remotos deben ser ciphertext cifrado del lado cliente.

### Implementación documental y tareas

- Perfil conversacional creado: prompts/CARSON-CHAT.md, blob ef334c36d002e11c22b2de156fbff4775a3b56f3, read-back exacto.
- Documento general: SPRINT-GENERAL-PRODUCT-DESIGN.md, blob 4e376047ee315a2fc4c97858743a96f69436a26f, read-back exacto.
- EP-TASK-009 Carson: blob bc58ea3353f65875ab2acfadd744a6d855ddbfe3, read-back exacto.
- EP-TASK-010 Persistencia: blob de núcleo de tarea decc94e9624323988985abb808929957ce72c08, read-back exacto.
- EP-TASK-011 Brain Selector diferido, baja prioridad: blob 37ae38e09c3ee981518046d68f18071eaf1d6215, read-back exacto.
- EP-TASK-012 Keepsake diferido, baja prioridad: blob 386fbb4b9e0b04d99e88a4309f43512887fe56fd, read-back exacto.
- Índice de tareas EP: blob 192894d04c978cdef9dade851d9b84e965363145, read-back exacto.
- EP-TASK-008 quedó pendiente de reconciliación; la configuración previa de Superpowers se conserva como antecedente y no se utiliza como runtime del Product Design vigente.

### Verificaciones de entorno y límites

- BMAD Brainstorming local fue leído; brain.py categories se ejecutó.
- SQLite 3.45.1 en Python 3.11.9 bajo CENTRAL\fila4 pasó una prueba FTS5 en memoria. No se creó una base de datos persistente.
- RDC mostró dos conexiones al mismo host visible PC10RCIF4EI4, con identidades Windows diferentes: CENTRAL\fila4 y CENTRAL\MantenimientoRCI. No se confundieron como dos equipos físicos.
- El volumen W: no contenía el workspace EP montado; solo se observó System Volume Information. La bóveda Cryptomator seguía bloqueada. No se escribieron ideaciones fuera del workspace cifrado.
- EP-TASK-002 y la aceptación del respaldo/restauración no están resueltos para Product Design.
- No se ejecutó Chrome, no se modificó la sesión principal, no se instaló CIS, no se creó Keepsake y no se activó la biblioteca.

### Secuencia vigente

1. Probar Carson en el chat con un tema real.
2. Desbloquear EP Vault localmente en la identidad autorizada y completar EP-TASK-010 dentro del workspace protegido, con verificación de escritura/read-back.
3. Validar backup cifrado cliente-lado y restauración.
4. Mantener Brain Selector y Keepsake como tareas de baja prioridad posteriores, sin bloquear el primer release.
5. Mantener la integración con Prótesis Cognitiva expresamente diferida.

A/B es control documental externo y no una función del producto de lluvia de ideas.
