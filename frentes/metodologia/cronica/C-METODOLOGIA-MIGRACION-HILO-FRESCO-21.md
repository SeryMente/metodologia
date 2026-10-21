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



## Resultado de la reinstanciación del destino · 2026-10-21

**Estado final:** transferencia completada; no es ya un relevo pendiente. Esta sección supersede el estado prospectivo descrito en la preparación histórica anterior, sin borrar su cronología.

- **Autorización:** «Actualiza OCP para migrar instancia a hilo fresco y dame el prompt que necesito para reinstanciar»; alcance limitado a Metodología/Metacanon y a este evento.
- **Control antes del CAS:** blob SHA 3125ea6a222d531f479292b69bd68c34b82f1ee7, propietario operator-authorized-transfer:C-METODOLOGIA-COLISION-RESPONSABILIDAD-14, generación 2, folio SES-20261021-C4D81A7F, estado de relevo prepared_waiting_for_target_claim.
- **Control después del CAS/read-back:** blob SHA 08f0ac0e9e3797d44f6f0827fabf90eb1cd139e0, commit d2b070183fe0b0fcc21279dcdd862234fcdd9374; propietario/alias chatgpt-C-METODOLOGIA-MIGRACION-HILO-FRESCO-21-SES-20261021-6B9E2F41, instancia chatgpt-metodologia-metacanon-migracion21-6B9E2F41, generación 3, folio SES-20261021-6B9E2F41, estado transferred/destino claimed. Se conservan el titular anterior, el folio anterior y los historiales de transferencia/asignación.
- **Metacanon §9:** blob SHA anterior 4ff1090d1174575133f9355d0bb98dc55041e2d7; blob SHA leído de vuelta 76fddd36a79e02340b7f4620cca8851cf8e305ac, commit 168fc562eff7a5b5b2a42d8acd74739b52f11310. Se identifica contextualmente este frente/hilo operativo como Hub; Metacanon permanece en v1.19.
- **Salida exacta de este ciclo:** frentes/metodologia/entregas/CHATGPT-v0.3/C-METODOLOGIA-MIGRACION-HILO-FRESCO-21-salida-final-SES-20261021-6B9E2F41.md, blob SHA 854b38c857a4e527f19ab2cdbbf0fcca0d0aba4f, commit 2a9a72032d659062ac52bc9f358032c4765cccff; lectura de vuelta comparada carácter por carácter con el texto preparado.
- **Colisión/alcance:** cuatro controles legibles inspeccionados; búsqueda exacta del folio en los nueve repositorios accesibles bajo SeryMente devolvió cero coincidencias. La ruta de control para SeryMente/personal/frentes/repertorio-canto-personal/ devolvió 404 y no se contabiliza como leída. Un error de preparación local (ReferenceError: structuredClone is not defined) ocurrió antes de invocar la escritura; no causó mutación. Se releyeron los controles y el SHA vigente antes de ejecutar el único CAS que sí escribió.
- **Límites:** no se afirma ID nativo, unicidad global ni fencing de servidor; no se tocó ningún otro FT, Notion, el campo nativo IPZ o código de producto. La prueba semántica E2E sigue pendiente.
- **Gobierno:** fuente SeryMente/metodologia/main; Sam v339 · NX-339m; GOW v2.2; MCP normativo desactivado y revisión manual.
