# 📝 GOV-TASK-010 · Admisión obligatoria y titularidad exclusiva de conversaciones

**Naturaleza:** OCP provisional de tarea del frente Gobernanza; no constituye frente independiente ni canoniza el ámbito funcional Tareas.  
**Estado:** `pendiente`  
**Responsabilidad:** heredada del control `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`; sin control, sesión ni folio propios.  
**task_id:** `GOV-TASK-010`  
**scope_ref:** `frentes/gobernanza/`  
**Origen:** instrucción expresa del operador en esta conversación, 2026-10-31; captura estructurada pendiente de crónica/evidencia del evento.

## Enunciado

Diseñar, especificar e integrar una compuerta obligatoria de admisión para que ninguna conversación comience trabajo sustantivo bajo la Metodología sin que el operador haya asignado explícitamente un frente de trabajo existente y el modelo haya verificado, mediante el protocolo vigente de responsabilidad, que puede asumirlo sin colisión con otra conversación activa. La conversación debe rechazar consultas ajenas a un frente asignado y no iniciar operación sustantiva mientras falte asignación válida, titularidad verificable o exclusividad.

## Alcance

1. Solicitar al inicio de cada conversación la asignación explícita de un frente y su OCP/repositorio.
2. Consultar la fuente de responsabilidad correspondiente, validar titularidad, generación, autorización, estado y exclusividad según el protocolo existente.
3. No inferir un frente por el contenido de una pregunta ni aceptar consultas generales ajenas al marco de trabajo.
4. Si falta información o existe colisión, bloquear la operación sustantiva y explicar qué condición de admisión falta; no simular una asignación ni una transferencia.
5. Vincular la conversación admitida con su sesión/identidad operativa y con el control del frente. No crear una sesión o titularidad paralela.
6. Distinguir la apertura de una conversación en la interfaz de la admisión operativa del modelo: la plataforma puede permitir abrir el chat, pero el modelo no debe ejecutar trabajo sustantivo hasta superar la compuerta.
7. Integrar esta regla como refuerzo explícito del IPZ, después de sus dos referencias iniciales al GOW/§ARR y al DUG, dentro del límite de 1.500 caracteres.

## Dependencias

- IPZ configurado, instalado y leído de vuelta en el campo nativo de instrucciones personalizadas.
- Protocolo vigente de control de responsabilidad y exclusividad entre conversaciones.
- Acceso verificable a los controles de los OCP/frentes que pueden ser asignados.
- Identificación de conversación/sesión sin inventar IDs nativos; UUIDv7 local solo cuando el procedimiento autorizado lo requiera.
- Integración futura con el ciclo global FOL1; no activar ni asignar folios mientras FOL1 no esté activo.

## Límites

- No modificar controles de otros frentes ni transferir su titularidad desde Gobernanza.
- No afirmar que la plataforma impide técnicamente crear una conversación; el criterio verificable es que el modelo no inicia operación sustantiva sin admisión.
- No aceptar el folio de ciclo como sustituto de la validación de titularidad de la conversación.
- No activar MCP-NORMATIVO ni cambiar DUG/IPZ nativos sin las autorizaciones y compuertas correspondientes.

## Criterio de aceptación

Pruebas positivas y negativas demuestran que: (a) una conversación con frente asignado y titularidad exclusiva verificada puede iniciar; (b) una conversación sin frente, con control ausente, titularidad ajena, generación obsoleta o colisión no puede iniciar trabajo sustantivo; (c) una pregunta general ajena al frente no desvía la conversación; (d) el resultado es coherente con el protocolo de responsabilidad; y (e) el refuerzo IPZ cabe dentro de 1.500 caracteres y se ha instalado con lectura de vuelta verificable.

## Estado inicial

Pendiente. La instrucción queda delimitada en este objeto; no se afirma todavía una compuerta técnica implementada ni una IPZ nativa instalada.
