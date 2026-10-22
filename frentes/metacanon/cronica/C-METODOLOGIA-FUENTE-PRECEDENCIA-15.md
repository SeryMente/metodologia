# Crónica del ciclo · C-METODOLOGIA-FUENTE-PRECEDENCIA-15

**Fecha:** 2026-10-21  
**Frente:** Metacanon · Repositorio Metodología  
**Estado:** cambios documentales persistidos y leídos de vuelta; sincronización perpetua y pruebas semánticas externas no realizadas.

## Instrucciones del operador

- Recuperar y ampliar el Glosario Operativo existente en Khora Hub, corregir `SAM` por `Sam`, revisar la normativa heredada de Sam, incorporar términos previos y adaptar el Bootstrap Conversacional Recursivo a Metacanon vigente.
- Mandato explícito de jerarquía: «Repositorio Metodología manda todo. Es preponderante frente a notion, y lo que sea».

## Decisiones incorporadas

1. El repositorio `SeryMente/metodologia`, rama `main`, es la fuente documental/metodológica preponderante. Notion, instrucciones personalizadas, memorias y copias son espejos subordinados; si divergen, prevalece el contenido verificado del repositorio.
2. En Sam v336 · NX-336m se añadió P038 inmediatamente después de P001 para hacer visible la preponderancia de la fuente. P008 fue refinado para dirigir toda convención al GOW canónico y exigir su registro en el mismo ciclo.
3. Metacanon pasó a v1.16 · `METACANON-OBJETOS-v1.16`, con §§43–45 e invariante 21: §43 preponderancia de `main`; §44 revisión obligatoria del GOW al inicio y cierre de cada ciclo; §45 unicidad de fuente y migración del corpus anterior.
4. El GOW canónico es únicamente `gobernanza/GLOSARIO-WORKSPACE.md`, v1.9. Se preservó el cuerpo completo de Notion GOW v1.7 y se integró el vocabulario de `GLOSARIO-OPERATIVO.md` v1.3.1. Se importaron 49 bloques de término, se consolidaron duplicados y se preservaron los alcances locales.
5. El original de `GLOSARIO-OPERATIVO.md` v1.3.1 se archivó verbatim en `frentes/metodologia/antecedentes/GLOSARIO-OPERATIVO-v1.3.1.md`. La ruta raíz ahora es un puntero de compatibilidad. El anexo de normalización pasa a ser procedimiento subordinado, no otro glosario.
6. `BOOTSTRAP-CONTEXTO-GLOBAL.md` se reescribió como BCR compatible con los cánones actuales: adquisición completa en el primer turno, revisión de GOW cada ciclo, normalización contextual, control de responsabilidad con compare-and-swap y lectura de vuelta, sin simular acceso ni sincronización.
7. Las páginas Notion GOW y Sam se actualizaron desde `main` y fueron releídas. GOW quedó v1.9 con Grupo 10 y Sam v336 · NX-336m con P037/P038, firma de carga correcta y P008 apuntando al GOW canónico.

## Normativa heredada relevante de Sam

La versión previa de P008 establecía que el GOW es el «HUB CENTRAL» de las convenciones operativas y que todo término/acuerdo ratificado debía registrarse ahí en el mismo turno: **«Normar sin registrar en el GOW = norma incompleta»**. Se preservó ese principio y se actualizó para el GOW único dentro de `SeryMente/metodologia/main`.

P001 mantiene la jerarquía por cascada: la regla superior prevalece; una regla específica refina, pero no anula una superior. P037 mantiene el procedimiento de resolución explícita de colisiones de responsabilidad mediante una sola pregunta al operador y traspaso condicionado con lectura de vuelta. P038 es el nuevo principio de preponderancia de fuente colocado inmediatamente después de P001.

## Evidencia del repositorio

- Sam v336, blob `711c613519d3c33ed6bb479ce3a8c9b65dd6269f`.
- Metacanon v1.16, blob `50fd180af34cbfc939bfd7655b1ae5c75725c4dc`.
- GOW v1.9, blob `17bf150cf20532793b8d1b3e175e0330013df4d8`.
- BCR actualizado, blob `767db8cdf00d3106399023c1baceeb5a91a6b4e6`.
- INICIO, blob `871253399531683be912ee58dc504f0b3713feef`.
- Gobernanza README, blob `fd5651b0adb7686633a21756eab7939e2a25fb7c`.
- Puntero raíz, blob `367898529eca9cef425f3a3d2471c85b31c8127b`.
- Anexo de normalización, blob `510143b33c762840bf7a31bbd9ad726ffddce033`.
- Revisión estructurada, `REVISION-METACANON-1.16.json`, blob `6c23c90dfc7609565b00d2496961bb1683b58e05`.
- Pendientes del frente, blob `4f5ece5fe12617f9ff1ee88467f6a7c3c2aeada4`.

## Verificación de espejos de Notion

- GOW: [página Notion](https://app.notion.com/p/247a418782418399a86001aae61ae938), título Canon v1.9; read-back comprobó Grupo 10, términos CECEQ/RDC, Sam, normalización contextual a KHORA, revisión por ciclo, preponderancia del repositorio y regla de no activación implícita.
- Sam: [página Notion](https://app.notion.com/p/c85a41878241830588e181f4c02fbab4), título v336 · NX-336m; read-back comprobó la firma NX-336m, P037/P038, P008 y pie de 38 principios.

## Límites y pendientes

- No hay sincronización perpetua GitHub↔Notion instalada; las actualizaciones verificadas son puntuales.
- Los ajustes nativos de instrucciones personalizadas de ChatGPT no se modificaron desde esta conexión. El texto BCR adaptado debe presentarse al operador listo para copiar.
- La aceptación semántica por un modelo independiente sigue pendiente; no se afirma que otros modelos necesariamente obedecerán el BCR.
- Los recibos dejan SHA-256 sin recalcular; se registra el blob SHA de GitHub, sin declarar un digest SHA-256 verificado.
- Sesión PRIUS y seguridad/cifrado siguen diferidos.

