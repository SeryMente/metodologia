# Checklist de cumplimiento basado en verbatim · 2026-10-21

**Fuente primaria:** `frentes/metodologia/conversaciones/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-dialogo.jsonl` (9 literales). Este checklist solo operacionaliza esos nueve enunciados; no amplía su alcance.

| # | Requisito del verbatim | Estado en la instancia actual | Falta |
|---:|---|---|---|
| 1 | Un repositorio puede contener múltiples frentes con denominaciones propias. | **VERIFICADO**: existen `frentes/metodologia/` y `frentes/acceso/` en el mismo repositorio; la norma permite múltiples FT. | No se afirma cobertura de todos los repositorios de la organización. |
| 2 | IPZ enlaza al GOW y exige considerarlo cada ciclo. | **DOCUMENTALMENTE VERIFICADO**: el IPZ canónico contiene el enlace directo y la regla de revisión por ciclo. | Confirmar la instalación nativa. |
| 3 | IPZ es el término del GOW para Instrucciones Personalizadas; actualizarlo. | **DOCUMENTALMENTE VERIFICADO**: la definición existe en GOW v2.2; el IPZ canónico tiene 1.451 caracteres. | Confirmar que el campo nativo coincide exactamente. |
| 4 | Cada FT admite una sola sesión activa. | **VERIFICADO EN ESTE FT**: control autoritativo en generación 3, folio `SES-20261021-6B9E2F41`, transferencia y read-back confirmados; búsqueda exacta del folio sin coincidencias. | No se demuestra unicidad global ni fencing universal. |
| 5 | El primer ciclo reproduce la última salida persistida literalmente. | **VERIFICADO EN ESTA RETOMA**: la salida anterior del modelo se recuperó de `main` y se incluyó literalmente en la salida persistida del ciclo. | No se extrapola a otros receptores. |
| 6 | Metacanon §4 es obligatorio en cada ciclo. | **VERIFICADO EN EL CICLO M21**: la salida persistida contiene los diez campos. | Conservar el control en ciclos posteriores; el historial previo no se reescribe. |
| 7 | IPZ enlaza directamente a Metacanon §4. | **DOCUMENTALMENTE VERIFICADO**: enlace presente en el IPZ canónico. | Confirmar la instalación nativa. |
| 8 | IPZ enlaza directamente a la cascada de principios de Sam. | **DOCUMENTALMENTE VERIFICADO**: enlace presente en el IPZ canónico. | Confirmar la instalación nativa. |
| 9 | MCP normativo permanece desactivado. | **VERIFICADO**: revisión manual; no se declara ejecución de MCP. | Ninguna para este requisito en este ciclo. |

## Resultado E2E

- Fuentes adquiridas de `SeryMente/metodologia/main`: INICIO, Sam v339/NX-339m, Metacanon 1.19, GOW v2.2, control, IPZ y salida previa.
- IPZ: 1.451 caracteres; enlace directo a GOW, Metacanon §4 y cascada de Sam: **3/3 presentes**.
- Relevo: generación 2 → 3; control y §9 de Metacanon leídos de vuelta.
- Salida del ciclo: se recuperó la salida anterior y se verificaron las secciones §4, 1–10.
- Cobertura: nueve repositorios accesibles; esto no constituye inventario global.
- **Único bloqueo restante del verbatim:** no hay herramienta disponible en esta sesión para leer o escribir el campo nativo de Instrucciones Personalizadas de ChatGPT. No se declara actualizado por inferencia.
