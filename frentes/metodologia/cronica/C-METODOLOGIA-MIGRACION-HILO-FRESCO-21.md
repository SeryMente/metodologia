# Crónica · C-METODOLOGIA-MIGRACION-HILO-FRESCO-21

**Fecha:** 2026-10-21  
**OCP:** `frentes/metodologia/`  
**Estado:** relevo preparado; la transferencia al hilo destino sigue pendiente de CAS y read-back.

## Mandato del operador
«Actualiza OCP para migrar instancia a hilo fresco y dame el prompt que necesito para reinstanciar».

## Fuente y versiones adquiridas
- Fuente preponderante: `SeryMente/metodologia/main`.
- Metacanon 1.19 · `METACANON-OBJETOS-v1.19`.
- Sam v339 · NX-339m.
- GOW v2.2.
- MCP normativo desactivado por instrucción del operador; revisión manual.

## Paquete creado
- Prompt: `frentes/metodologia/entregas/CHATGPT-v0.3/PROMPT-MIGRACION-HILO-FRESCO-21.txt`.
- Checkpoint: `frentes/metodologia/entregas/CHATGPT-v0.3/CHECKPOINT-MIGRACION-HILO-FRESCO-21.md`.
- Manifiesto del relevo: `frentes/metodologia/entregas/CHATGPT-v0.3/MANIFIESTO-C-METODOLOGIA-MIGRACION-HILO-FRESCO-21.json`.
- Entrada breve y LEEME de v0.3 redirigen al prompt específico; ARRANQUE-PORTABLE-v0.3 permanece histórico y no se trata como gobierno vigente.

## Control de responsabilidad
El control ahora registra `handoff_preparation.status=prepared_waiting_for_target_claim` para este evento. Tras la escritura y lectura de vuelta, continúa en `status=owned`, generación 2, con propietario `operator-authorized-transfer:C-METODOLOGIA-COLISION-RESPONSABILIDAD-14` e instancia `chatgpt-metacanon-collision-remediation-2026-10-21`. El folio de origen permanece `SES-20261021-C4D81A7F`. No se atribuye la titularidad al hilo destino porque todavía no existe en el control.

## Próximo paso
El hilo fresco debe adquirir la fuente vigente, comprobar que evento/propietario/instancia/generación/folio coinciden con el relevo preparado, generar un nuevo folio y un alias operativo, ejecutar CAS condicionado por SHA e incrementar la generación, preservar el propietario y folio anteriores y leer de vuelta el control. Solo entonces puede declarar el traspaso completado. Si la base cambia o no hay acceso de escritura, detenerse y permanecer en lectura.

La última salida persistida antes de este evento que el destino debe reproducir literalmente está en `frentes/metodologia/entregas/CHATGPT-v0.3/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-salida-final.md`. El objetivo no se aprueba por la mera emisión de un prompt.

