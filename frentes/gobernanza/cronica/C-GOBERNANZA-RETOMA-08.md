# C-GOBERNANZA-RETOMA-08 · Persistencia documental y transferencia de titularidad

**Fecha:** 2026-11-01  
**Frente/OCP:** `frentes/gobernanza/` · `SeryMente/metodologia` · `main`  
**Estado:** `PERSISTIDO_Y_VERIFICADO` · `TRANSFERENCIA_VERIFICADA`  
**Ciclo global:** PENDIENTE / NO ASIGNADO (FOL1 continúa inactivo).

## 1. Instrucción y alcance

Instrucción expresa del operador recibida en esta conversación:

> ADjunta en Persistenica Docuemtnald e Gobernanza, y toma responsabilidad de Gobernanza 1

Se ejecutan dos actos: conservar el archivo adjunto como original documental inmutable y transferir la titularidad operativa principal del frente Gobernanza a esta sesión. Se preservan los límites y autorizaciones previos: no se modifica el DUG, ART-025/ART-027 ni la IPZ nativa; no se alteran controles ni recursos de EP/MCP-OCP; no se activa FOL1 ni MCP-NORMATIVO.

## 2. Persistencia del original

**Archivo:** `ChatGPT-GOBERNANZA-20261101-1518.md`  
**Ruta canónica:** `frentes/gobernanza/documentos/originales/ChatGPT-GOBERNANZA-20261101-1518.md`  
**Tamaño:** 161.472 bytes  
**SHA-256 del adjunto:** `1ce5e272c9d4f80da83a5c5d4be4e36eecf8ebc29001132d5e998af8bacca0d6`  
**Git blob:** `a8bf0cb9f1bf3503827c6013e56abffa1f06e697`  
**Commit de creación:** `275854bb5d0a85cd9adb2f10ee65fcd41655e764`  
**Lectura de vuelta:** PASS; contenido UTF-8, tamaño y SHA-256 exactos frente al adjunto.  
**Manifiesto:** actualizado a seis originales; último evento C-GOBERNANZA-RETOMA-08.

El archivo se preserva como original; no se transforma en fuente normativa ni reemplaza el DUG.

## 3. Transferencia de responsabilidad

Control autoritativo: `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json`.

- Control anterior observado: generación 10, blob `403748d4a401c73abf322b2bc48bd517a9c56600`.
- Titular anterior: `chatgpt-C-GOBERNANZA-RETOMA-07-SES-20261031-GV8AA51721`, sesión `SES-20261031-GV8AA51721`.
- Nuevo titular: `chatgpt-C-GOBERNANZA-RETOMA-08-SES-20261101-GV8A19904`.
- Nueva sesión: `SES-20261101-GV8A19904`.
- Instancia: `chatgpt-gobernanza-retoma-2026-11-01-GV8A19904`.
- UUIDv7 local: `01a19904-cac5-7351-94eb-ce3ab3837be5` (no es ID nativo de ChatGPT).
- Generación resultante: 11.
- Evento: `C-GOBERNANZA-RETOMA-08`.

El titular previo queda supersedido. Se conserva intacta la corresponsabilidad previamente registrada, sesión `SES-20261101-ED4A2B32`. Resultado: dos responsables activos en el registro (titular + corresponsable), sin crear una tercera asignación. Búsqueda exacta del alias y UUID nuevo: cero coincidencias en el repositorio; esto no acredita unicidad organizacional ni fencing técnico universal.

**Commit del primer registro de transferencia:** `5c5d480a92adb57db959011619f2652940101031`; read-back de campos de asignación PASS.  
**Commit de cierre de verificación:** `34d77f2ec8906e620dbacf609129f1d5aca01d31`.  
**Blob final del control:** `beecec6d4a3ca166019f3271bf2715a2c64bb6f1`.  
**Estado:** `COMMITTED_AND_READBACK_VERIFIED`.

## 4. Reconciliación DTC de los frentes

Se inspeccionaron sus registros en `main`; los estados de ejecución se mantienen bajo autoridad de cada frente.

| Frente | Estado observado en este ciclo | Fuente/cursor | Límite |
|---|---|---|---|
| Gobernanza | Titularidad gen. 11 persistida y verificada; archivo y registros propios leídos de vuelta | Control final blob `beecec6d…`; original blob `a8bf0cb9…` | FOL1 inactivo; no hay folio global |
| EP | `CUMPLE_VERIFICADO` para el ciclo documental local `C-EP-DTC-PROMPT02-20261031-02` | Objeto DTC blob `24939fbe18b250256116f8556d96ae3c33bde238`; OEP v0.3.22 / VCU-EP-v24 blob `deaceadfc1de4636e0f9114a47a3d5255c04e897`; índice tareas blob `3c1d1bb91bc4152dd783f7f3b12ba1f986c40018` | EP-TASK-002 sigue `en_curso`; autenticación/B2, upload, read-back remoto y restauración no están ejecutados/verificados |
| MCP-OCP | `CUMPLE_PARCIAL`: ciclo local 05 abierto, con respuesta inicial/curso de trabajo registrado; no se observa cierre/read-back del ciclo 05 | Objeto de coordinación blob `4c6f9c12be9c227f66f71c149cef2d00db7dd17f`; núcleo blob `15d6fe1a65d52c52215378fd12a49c3a651d6d73`; control generación 3 blob `3e6f96e919c33c3015478b7fd0f262b1bee47b0c` | El núcleo §8.1 conserva una fotografía anterior (ciclo 03/04) frente a la coordinación §28 (ciclo 05); MCP-OCP debe reconciliarlo dentro de su propio OCP |

No se abre una solicitud nueva ni paralela a MCP-OCP mientras su ciclo 05 está abierto. Tampoco se altera el OEP, el control MCP-OCP, el host, el código o el backlog técnico de ningún frente. DTC global continúa `EN_CURSO_RECURRENT`.

## 5. Estado de continuidad y siguientes acciones

- Mantener GOV-TASK-011 como tarea recurrente; cada ciclo exige apertura, procesamiento, documentación de cierre y read-back.
- Integrar EP como verificado únicamente en su ciclo documental DTC; conservar EP-TASK-002 abierto por las pruebas materiales pendientes.
- Esperar el cierre/read-back de MCP-OCP ciclo local 05 y conciliar la diferencia entre su coordinación §28 y el snapshot de §8.1 desde el siguiente ciclo propio de MCP-OCP.
- Continuar el backlog integrado de Gobernanza sin duplicar tareas ejecutoras.
- No asignar CV/CY/A/B globales ni folios por OCP hasta activación verificada de FOL1.

## 6. Fuentes normativas y límites

DUG vigente de referencia en el frente: Samantha v373 · NX-373m. La edad de IPZ/DUG y la instalación nativa IPZ no se certifican en este evento. No se modificó DUG, GOW canónico, ART-025, ART-027, IPZ nativa, FOL1, MCP-NORMATIVO, EP ni MCP-OCP.
