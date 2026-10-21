# C-METODOLOGIA-MIGRACION-HILO-FRESCO-21 · Salida de ciclo

## 1. Identidad operativa y gobierno vigente

- Frente: Metodología / Metacanon.
- OCP: `frentes/metodologia/`.
- Folio de origen: `SES-20261021-C4D81A7F`; propietario actual generación 2.
- Metacanon: **1.19 · METACANON-OBJETOS-v1.19**.
- Sam: **v339 · NX-339m**.
- GOW: **v2.2**.
- MCP normativo: **DESACTIVADO**. La revisión de fuentes se hizo manualmente.

## 2. Dónde estamos

El OCP contiene ahora un paquete de handoff para el hilo fresco: prompt de migración, checkpoint y manifiesto. El control de responsabilidad contiene `handoff_preparation.status=prepared_waiting_for_target_claim`. **La transferencia no está completada:** la titularidad sigue en el propietario de origen hasta que el destino genere folio, ejecute CAS y confirme lectura de vuelta.

## 3. Actualización/delta

- [Prompt de migración para hilo fresco](https://github.com/SeryMente/metodologia/blob/main/frentes/metodologia/entregas/CHATGPT-v0.3/PROMPT-MIGRACION-HILO-FRESCO-21.txt).
- [Checkpoint de migración](https://github.com/SeryMente/metodologia/blob/main/frentes/metodologia/entregas/CHATGPT-v0.3/CHECKPOINT-MIGRACION-HILO-FRESCO-21.md).
- [Control de responsabilidad con handoff preparado](https://github.com/SeryMente/metodologia/blob/main/frentes/metodologia/CONTROL-RESPONSABILIDAD.json).
- [PENDIENTES.md](https://github.com/SeryMente/metodologia/blob/main/frentes/metodologia/PENDIENTES.md) registra evento y condiciones de transferencia.
- `PROMPT-ENTRADA.txt` y `LEEME.md` ahora apuntan al prompt fresco; el ARRANQUE-PORTABLE-v0.3 queda como transporte histórico.

## 4. Qué avanzó y evidencia

El control se leyó antes de escribir y su actualización fue condicionada por el SHA observado. La lectura de vuelta confirmó:

- `status: owned`, generación **2** y folio de origen sin cambios.
- Propietario/instancia de origen conservados.
- Evento `C-METODOLOGIA-MIGRACION-HILO-FRESCO-21` registrado con autorización explícita y estado `prepared_waiting_for_target_claim`.
- Destino declarado como no instanciado; se exige que genere folio/alias propio y ejecute CAS + read-back.

SHA del control después de preparar el relevo: `3125ea6a222d531f479292b69bd68c34b82f1ee7`.

## 5. Qué falta

- El hilo fresco debe usar el prompt, comprobar que evento/propietario/instancia/generación/folio siguen coincidiendo, generar un nuevo folio y efectuar la transferencia condicionada.
- Debe leer de vuelta el control y confirmar la generación nueva antes de cualquier mutación de proyecto.
- Debe recuperar y presentar literalmente la última salida persistida indicada en el prompt.
- IPZ nativo sigue sin poder leerse mediante estas herramientas; no se certifica igualdad con el artefacto actual.
- La prueba E2E de retoma en un hilo distinto aún no existe.

## 6. Viabilidad

La migración está preparada documentalmente. No puede declararse completada hasta que el hilo destino esté instanciado y cambie la titularidad de manera condicionada y verificada. El prompt está diseñado para detenerse si el control cambió, hay conflicto o falla la escritura/read-back.

## 7. Tiempo/ciclos

No se requiere una estimación de duración. El siguiente evento depende de abrir el hilo fresco y ejecutar la transferencia en una sola secuencia condicionada. No se ha programado ni se realizará trabajo en segundo plano.

## 8. Siguiente acción

Abre una conversación nueva y pega el contenido de [PROMPT-MIGRACION-HILO-FRESCO-21.txt](https://github.com/SeryMente/metodologia/blob/main/frentes/metodologia/entregas/CHATGPT-v0.3/PROMPT-MIGRACION-HILO-FRESCO-21.txt). El destino debe realizar el CAS y read-back, no limitarse a decir que recibió el contexto.

## 9. Continuación

En el primer ciclo, el hilo destino debe:
1. Adquirir INICIO, Sam, Metacanon, GOW y el control directamente desde `main`.
2. Reproducir literalmente `C-METODOLOGIA-AUDITORIA-REQUISITOS-20-salida-final.md` como «Última salida conservada del modelo anterior», o declarar `NO DISPONIBLE / NO VERIFICADA`.
3. Completar la transferencia con folio propio y read-back.
4. Citar el bloque vigente «🔄 Estado vivo» de Metacanon §9. Para «⚗️ En prueba / recién fallido», declarar que no está disponible en el OCP canónico vigente, salvo que encuentre una fuente actual.
5. Aplicar Metacanon §4 en los diez campos y revisar manualmente la cascada de Sam y el GOW. MCP normativo continúa desactivado.

## 10. Persistencia y checkpoint

- Control: `frentes/metodologia/CONTROL-RESPONSABILIDAD.json`.
- Prompt: `frentes/metodologia/entregas/CHATGPT-v0.3/PROMPT-MIGRACION-HILO-FRESCO-21.txt`.
- Checkpoint: `frentes/metodologia/entregas/CHATGPT-v0.3/CHECKPOINT-MIGRACION-HILO-FRESCO-21.md`.
- Crónica: `frentes/metodologia/cronica/C-METODOLOGIA-MIGRACION-HILO-FRESCO-21.md`.
- Diálogo visible: `frentes/metodologia/conversaciones/C-METODOLOGIA-MIGRACION-HILO-FRESCO-21-dialogo.jsonl`.
- Evidencia de lectura de vuelta: `frentes/metodologia/evidencias/C-METODOLOGIA-MIGRACION-HILO-FRESCO-21-readback.json`.

