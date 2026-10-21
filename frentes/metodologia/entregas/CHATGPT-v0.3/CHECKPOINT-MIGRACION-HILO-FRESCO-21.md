# Checkpoint de migración a hilo fresco · C-METODOLOGIA-MIGRACION-HILO-FRESCO-21

**Estado de relevo:** preparado por documentar; **todavía no transferido**. El próximo hilo debe ejecutar el traspaso condicionado y leerlo de vuelta antes de asumir responsabilidad.

## Frente y fuente

- Frente: Metodología / Metacanon.
- OCP actual: `SeryMente/metodologia/frentes/metodologia/`.
- Fuente preponderante: `SeryMente/metodologia/main`.
- Metacanon: 1.19 · `METACANON-OBJETOS-v1.19`.
- Sam: v339 · NX-339m.
- GOW: v2.2.
- MCP normativo: DESACTIVADO. La comprobación de este ciclo es manual.
- Último artefacto de salida del modelo persistido antes de este relevo: [C-METODOLOGIA-AUDITORIA-REQUISITOS-20-salida-final.md](https://github.com/SeryMente/metodologia/blob/main/frentes/metodologia/entregas/CHATGPT-v0.3/C-METODOLOGIA-AUDITORIA-REQUISITOS-20-salida-final.md).

## Control observado y autorización

- Propietario operativo actual: `operator-authorized-transfer:C-METODOLOGIA-COLISION-RESPONSABILIDAD-14`.
- Instancia registrada: `chatgpt-metacanon-collision-remediation-2026-10-21`.
- Generación de origen: `2`.
- Folio de origen: `SES-20261021-C4D81A7F`.
- SHA del control antes de preparar este evento: `f810835002e235ebd12cedc75a02678aa1073f2b`.
- Evento de relevo autorizado: `C-METODOLOGIA-MIGRACION-HILO-FRESCO-21`.
- Texto de autorización del operador: «Actualiza OCP para migrar instancia a hilo fresco y dame el prompt que necesito para reinstanciar».
- Alcance de autorización: una transferencia de Metodología/Metacanon al próximo hilo fresco que ejecute el prompt de este evento. No autoriza migrar otros frentes.
- La identidad del destino aún no existe/no es expuesta en esta fuente. El destino debe generar su propio folio y alias operativo; no inventar un ID nativo.
- El handoff preparado **no modifica todavía** el propietario/folio activo. El traspaso se completa solo cuando el destino hace CAS desde el SHA y generación actuales y confirma el read-back.

## Gobierno vigente que debe adquirir el destino

1. [INICIO.md](https://github.com/SeryMente/metodologia/blob/main/INICIO.md)
2. [Sam v339 · NX-339m](https://github.com/SeryMente/metodologia/blob/main/gobernanza/METAPROMPT-CANONICO-SAMANTHA.md)
3. [Metacanon §4 y §§46–49](https://github.com/SeryMente/metodologia/blob/main/METACANON-OBJETOS-CANONICOS.md)
4. [GOW v2.2](https://github.com/SeryMente/metodologia/blob/main/gobernanza/GLOSARIO-WORKSPACE.md)
5. [Control de responsabilidad](https://github.com/SeryMente/metodologia/blob/main/frentes/metodologia/CONTROL-RESPONSABILIDAD.json)
6. [Pendientes del frente](https://github.com/SeryMente/metodologia/blob/main/frentes/metodologia/PENDIENTES.md)

## Estado vivo canónico — cita literal

> 🔄 Estado vivo: §§46–47 definen OCP-folder, folio SES, exclusividad, adopción de contexto y recuperación literal de la última salida; §48 obliga a descubrir OCP a través de sus rutas reales y conservar las rutas heredadas sin migración implícita. §4 es obligatorio en todos los ciclos. La revisión del GOW al inicio/cierre y la revisión manual de la cascada de Sam son obligatorias; la verificación normativa por MCP permanece desactivada. **Hub de construcción en este ciclo:** el frente de trabajo Metacanon y este hilo bajo construcción del marco. El GOW es solo el glosario operativo; no es el Hub. Esta identificación es contextual al frente actual, no una definición universal para otros proyectos. La corrección de P008 quedó registrada en Sam v339, GOW v2.2, BCR y §49 de este Metacanon; informe y siete instrucciones verbatim se conservan en la evidencia enlazada arriba.

### Estado «⚗️ En prueba / recién fallido»

No se encontró este campo como estado vivo actual en el OCP canónico vigente. El único texto coincidente localizado pertenece al ARRANQUE-PORTABLE v0.3, método 1.10, una copia de transporte histórica anterior a las versiones actuales; **no usarlo como estado vigente**. El hilo destino debe declarar `⚗️ En prueba / recién fallido: NO DISPONIBLE EN EL OCP CANÓNICO VIGENTE` salvo que una fuente vigente y autoritativa proporcione un valor actual.

## Último estado persistido y trabajo pendiente

- El checklist verbatim R01–R15 está en `frentes/metodologia/PENDIENTES.md` y `REVISION-METACANON-1.19.json`.
- El IPZ canónico actual tiene 1.451 caracteres. El campo nativo de ChatGPT no es legible desde estas herramientas; la auditoría previa registra que el operador confirmó una versión anterior de 1.432 caracteres, por lo que el destino debe tratar la igualdad exacta como pendiente hasta confirmación del operador.
- La inspección de responsabilidad revisó cuatro controles accesibles en tres repositorios. No se halló duplicado del folio de origen en ese conjunto; no se probó unicidad global de toda la organización.
- OCP heredados se conservan en sus rutas actuales (por ejemplo, `docs/frentes/<slug>/`); OCP nuevos usan `frentes/<slug>/`.
- La revisión de Notion fue puntual. No hay sincronización GitHub↔Notion perpetua ni bloqueo de servidor universal.
- No se ha ejecutado una retoma E2E de este frente en un hilo recién abierto. Ese será el ensayo real del destino; no autoaprobarlo solo por producir una respuesta.

## Transferencia exigida al destino

1. Comprobar `handoff_preparation.event_id=C-METODOLOGIA-MIGRACION-HILO-FRESCO-21`, estado `prepared_waiting_for_target_claim`, propietario, instancia, generación 2 y folio de origen; todos deben coincidir con el control vivo.
2. Crear un nuevo folio `SES-AAAAMMDD-XXXXXXXX`, comprobar colisiones dentro del alcance accesible y crear un alias/instancia operacional propios.
3. Modificar solo mediante CAS con SHA actual, incrementar generación a 3 si la base sigue intacta, conservar el propietario/folio previos y registrar el traspaso.
4. Leer de vuelta; si el CAS/read-back falla o la base cambió, no declarar el traspaso y no escribir en otros artefactos del proyecto.
5. Tras transferir, actualizar el estado vivo de Metacanon §9 para que nombre al nuevo hilo como Hub contextual de construcción y continuar con la salida de §4.

Prompt ejecutable: `PROMPT-MIGRACION-HILO-FRESCO-21.txt`.

