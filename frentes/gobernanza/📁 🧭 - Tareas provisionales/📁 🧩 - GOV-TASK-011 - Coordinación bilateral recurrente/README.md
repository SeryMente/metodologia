# GOV-TASK-011 — DTC · Dinámica Trilateral por Ciclo

**Estado:** en_curso · **Tipo:** tarea provisional del OCP Gobernanza · **Responsabilidad:** heredada del control Gobernanza, generación 9. No crea control, sesión, titularidad ni folio independiente.

## Enunciado

En cada ciclo, Gobernanza es responsable de verificar que los tres frentes —Gobernanza, Entorno Persistente (EP) y OCP MCP— cumplen la DTC · Dinámica Trilateral por Ciclo. La comunicación es prioritaria: después del preflight obligatorio de admisión, titularidad, autorización y exclusividad, cada frente debe leer y responder la comunicación pendiente al inicio de su propio ciclo, antes de cualquier otro trabajo; al terminar de procesar la salida debe documentar las novedades y verificar la persistencia al cierre. Gobernanza comprueba el cumplimiento con evidencia, registra el resultado por frente y conserva la serialidad. Esta verificación no transfiere a Gobernanza la ejecución, titularidad ni autorización de EP u OCP MCP.

## DTC — obligación recurrente de Gobernanza

1. Revalidar la asignación y los controles del frente propio, la generación y el permiso de la operación.
2. Leer los registros provisionales de tareas de EP y OCP MCP desde sus fuentes operativas actuales. Registrar path, rama/ref, revisión/blob y resultado. Si el registro no está identificado o no existe en las rutas consultadas, no inferir su inexistencia: usar temporalmente el estado del OCP vigente, dejar la brecha en ambos objetos y exigir al frente el path canónico.
3. Leer ambos objetos persistentes de comunicación y procesar primero las respuestas recibidas. Distinguir mensaje publicado, leído, respuesta inicial, trabajo procesado, cierre documentado y read-back. La ausencia de respuesta se mantiene pendiente.
4. Dejar en cada objeto una entrada de Gobernanza para el ciclo actual, con una instrucción o, si no hay delta material, una constancia SIN_NOVEDAD que solicite acuse breve. No abrir una ronda técnica paralela si existe una respuesta previa pendiente en ese mismo frente.
5. Analizar cada respuesta antes de formular otra solicitud a ese frente. Comparar con el backlog rector, tareas, evidencia, controles y límites de EP/OCP. Resolver contradicciones o formular una única corrección material.
6. Al cierre del ciclo de Gobernanza, actualizar este objeto, GOBERNANZA.md/PENDIENTES.md e índice de tareas cuando haya cambios; verificar lectura de vuelta por SHA. No afirmar que EP/OCP leyeron o aplicaron un mensaje sin una respuesta registrada en su objeto.

## Compuertas que los tres frentes deben instalar y demostrar

- En la apertura de cada ciclo, después de sus preflight obligatorios, cada frente lee la comunicación nueva y deja su respuesta inicial en el mismo objeto antes de iniciar otra tarea técnica/documental.
- Tras esa respuesta inicial, continúa el trabajo autorizado e independiente.
- Después de procesar su salida y antes de cerrar, el frente documenta todas las novedades y cambios de tarea en su mismo objeto, y actualiza su OCP/núcleo y registro de tareas cuando corresponda.
- Ambos frentes deben crear el checklist/compuerta de entrada y salida dentro de sus propios objetos operativos y enlazarlo desde su registro de tareas. Gobernanza no modifica su código, host, control de responsabilidad ni autorizaciones.
- La tarea no se considera satisfecha hasta que cada frente haya instalado y leído de vuelta su compuerta, identificado su registro de tareas, y demostrado al menos una apertura con respuesta prioritaria y un cierre documentado.

## Objetos bilaterales persistentes

- EP: [COORDINACION-GOBERNANZA-EP-v0.1.md](../../../ep/entregas/COORDINACION-GOBERNANZA-EP-v0.1.md), en rama docs/metacanon-objetos-20261011. El estado técnico sigue en OEP.md.
- OCP MCP: [COORDINACION-SPRINT-OCP-MCP-v0.1.md](../../../mcp-metodologia/entregas/COORDINACION-SPRINT-OCP-MCP-v0.1.md), en main. El estado técnico sigue en MCP-METODOLOGIA.md y la evidencia de release.

## Hallazgos de la primera lectura

- EP: OEP v0.3.18 / VCU-EP-v20, blob e1e045cdc9b1a286047c6d47c47a5111a0b52bce en docs/metacanon-objetos-20261011. Se localizaron los hitos EP-H01–EP-H06 en §76. No se localizó un índice separado de tareas provisionales en las rutas convencionales consultadas; EP debe confirmar el registro canónico.
- OCP MCP: control owned, generación 2, blob 4a4742a51f0517a1b152a9c04ac6c185de024389. Build 0.1.0: 31 pruebas unitarias y 29 integración PASS; BUILT_AND_TESTED_NOT_INSTALLED; PENDING_EP; BLOCKED_OCPMSP por cuatro metadatos ausentes. El objeto de coordinación conserva en §15 un estado anterior generación 1/A-B pendientes que OCP debe reconciliar. No se localizó un índice separado de tareas provisionales OCP en las rutas convencionales consultadas.
- El mensaje común MSG-GOV-BILATERAL-20261031-01 fue publicado en ambos objetos. La lectura, respuesta inicial y aplicación por ambos frentes siguen PENDIENTES; Git read-back prueba persistencia, no recepción humana/modelo.

## Criterio de cierre

EP y OCP tienen un registro de tareas localizable y leído cada ciclo; ambos tienen una compuerta propia en su OCP/objeto operativo que exige lectura y respuesta al inicio y documentación al cierre; ambos responden al mensaje de Gobernanza en los objetos bilaterales; las novedades se cotejan con el backlog rector; las entradas se leen de vuelta; no hay afirmaciones de recepción/ejecución sin evidencia. FOL1 permanece inactivo hasta instalación/verificación IPZ; no inventar folios globales.

## Procedencia

Creada por instrucción directa del operador del 2026-10-31: «Vas a leer las tareas provisionales de los frentes ... EP y OCP MCP ... en cada uno ... un objeto provisional de persistencia para comunicarte con ellos» y posterior aclaración de prioridad de lectura/respuesta al inicio del ciclo y documentación al terminar de procesar la salida.

**Crónica:** [C-GOBERNANZA-COMUNICACION-BILATERAL-01](../../cronica/C-GOBERNANZA-COMUNICACION-BILATERAL-01.md) · **Evidencia:** [JSON](../../evidencias/C-GOBERNANZA-COMUNICACION-BILATERAL-01.json).
## Matriz de cumplimiento DTC por los tres frentes

### Gobernanza

- **Apertura:** cumplir admisión fail-closed; leer las tareas provisionales, los objetos de comunicación y las últimas respuestas de EP y OCP MCP; verificar novedades/cursor; escribir o actualizar la comunicación a ambos antes de otra actividad sustantiva.
- **Procesamiento:** analizar las respuestas primero; cotejarlas con el vector semántico y los controles de los tres frentes; después continuar el backlog propio y trabajo independiente autorizado.
- **Cierre:** registrar el resultado DTC de los tres frentes, novedades, tareas/estados, bloqueos, siguiente acción y pronóstico en GOBERNANZA/PENDIENTES/esta tarea y evidencia; read-back por SHA.

### Entorno Persistente (EP)

- **Apertura de cada ciclo EP:** realizar preflight propio; leer el objeto de comunicación Gobernanza y el cursor nuevo; registrar respuesta inicial antes de otra tarea.
- **Procesamiento:** continuar tareas/hitos de EP dentro de su autorización.
- **Cierre:** documentar novedades al terminar de procesar la salida en el objeto bilateral, OEP y registro de tareas; conservar evidencia y read-back.

### OCP MCP

- **Apertura de cada ciclo OCP:** realizar preflight propio; leer el objeto de coordinación del sprint y el cursor nuevo; registrar respuesta inicial antes de otra tarea.
- **Procesamiento:** continuar construcción, pruebas y tareas OCP dentro del control vigente.
- **Cierre:** documentar novedades al terminar de procesar la salida en el objeto del sprint, MCP-METODOLOGIA y registro de tareas; conservar evidencia y read-back.

### Criterios de verificación de Gobernanza

Para cada uno de los tres frentes, verificar separadamente: (1) ciclo/identidad y fuente vigentes; (2) lectura de las comunicaciones nuevas; (3) respuesta inicial registrada antes del trabajo sustantivo; (4) continuidad de trabajo dentro del alcance autorizado; (5) novedades documentadas después del procesamiento y antes del cierre; (6) actualización de OCP/núcleo y registro de tareas cuando proceda; (7) lectura de vuelta de los artefactos/commits declarados. Un mensaje guardado no demuestra lectura; un informe de éxito no sustituye evidencia; una prueba de build no demuestra instalación o aceptación.

Estados de verificación: `CUMPLE_VERIFICADO`, `CUMPLE_PARCIAL`, `NO_CUMPLE`, `NO_VERIFICABLE`, `SIN_CICLO_OBSERVADO`. Este último se usa cuando no hay ciclo observable del frente desde la revisión anterior; no se presume cumplimiento ni incumplimiento. Toda brecha debe conservar criterio, evidencia ausente, propietario del frente y acción correctiva. La verificación es ciclo a ciclo, no un control continuo entre turnos; no prometer vigilancia ni ejecución en segundo plano.

**Responsable de verificación transversal:** Gobernanza, por medio de GOV-TASK-011. **Responsables de ejecución y evidencia propia:** cada frente, dentro de su control. **Criterio rector:** backlog semántico de Gobernanza.

## Denominación

**DTC = Dinámica Trilateral por Ciclo.** Esta es la denominación compacta de la secuencia recurrente entre Gobernanza, EP y OCP MCP. Se emplea desde esta revisión en lugar de referirse al mecanismo únicamente como coordinación bilateral.