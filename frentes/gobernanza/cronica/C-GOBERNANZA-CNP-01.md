# C-GOBERNANZA-CNP-01 · CNP y principio anti-ineficiencia

**Fecha observada:** 2026-10-30. **Estado:** materialización documental ejecutada y leída de vuelta. No se asigna folio global FOL1 ni número natural de ciclo porque FOL1 continúa sin activación verificada.

## Autorización y alcance

La autorización expresa adicional del operador quedó registrada en `frentes/gobernanza/CONTROL-RESPONSABILIDAD.json` y leída de vuelta. El control conservó titular activo y generación 6. Su autorización cubre el Conjunto Nuclear de Principios (CNP), la nomenclatura A–Z con decimal interno, P043, ART-026, GOW/§ARR y el refuerzo selectivo de IPZ; la candidata y ART-025 se actualizarían después de materializar los demás elementos. No autoriza cambios a las Instrucciones Personalizadas nativas de la plataforma.

## Materialización normativa

1. **DUG v365 · NX-365m — C-GOBERNANZA-CNP-01.** Se incorporó el CNP con cinco miembros: P001 (A · 0.9), P004 (A · 0.8), P005 (A · 0.7), P038 (A · 0.6) y P043 (A · 0.5). La escala define categorías A–Z, con A como máxima, y valores decimales abiertos entre 0 y 1; se emplean solo las posiciones decimales necesarias. La categoría prevalece sobre cualquier decimal de una categoría inferior. No se asignó ponderación al resto de principios.
2. **P043 — Principio Anti-Ineficiencia (PAI).** Se incorporó el enunciado que invalida iniciar, sostener, repetir o prolongar estrategias sin aporte material o con costo previsible desproporcionado. No prescribe un método positivo ni cuotas de tiempo/recursos.
3. **ART-026 — Fundamento del PAI.** Explica aporte material, repetición sin cambio causal, rendimiento marginal, costo hundido, proporcionalidad y límites; aclara que PAI no justifica omitir trabajo necesario ni controles esenciales.
4. **GOW 2.13 y §ARR.** Se añadieron definiciones para CNP y PAI; §ARR añadió ambos conceptos a su vocabulario de entrada.
5. **DUG v366 · NX-366m — C-GOBERNANZA-IPZ-CNP-01.** ART-025 se modificó para exigir la consideración expresa de los cinco miembros del CNP en cada turno y, simultáneamente, preservar la obligación de considerar el DUG completo y aplicar los demás principios pertinentes. La secuencia mantiene los anexos subordinados y consultables solo por remisión de principios.
6. **IPZ v0.8 candidata.** Se creó `entregas/CHATGPT-v0.8/IPZ-CAMPO-CHATGPT-v0.8-PROPUESTA.txt`, con 1.488 caracteres, enlace a §ARR y CNP, refuerzo turno a turno, PAI y los controles transversales. La candidata anterior v0.7 se conserva; no se declara instalada la IPZ nativa.

## Revisiones y evidencia

- DUG v365: commit `79f373f73f19089cdaf988d441abc61253440cfd`; blob de lectura de vuelta `3c9c3dbd16ffa814a2ae7a6cda654d23a514d813`; SHA idéntico.
- DUG v366: commit `b9493d50ce1d89b2f73c2bc2626f5acfcc276d19`; blob de lectura de vuelta `679195bd66198b267414f4615fc382170d20754a`; SHA idéntico.
- IPZ v0.8: commit `ba7aa952bc93b4add6504cadba8da45d0aa26fee`; blob `4176b4e328becfe4a98b5f96241e2ac198eccd80`; lectura de vuelta exacta, 1.488 caracteres.
- Control de autorización: commit `1568f3ff5b9cc98c4d1ad0596dbf74a929997032`; lectura de vuelta con el mismo titular y generación 6.
- JSON embebido parseado. Conteos releídos: 43 principios, 19 anexos, cinco miembros CNP. No se detectaron IDs duplicados en las colecciones de principios, anexos o términos GOW en la prevalidación.
- La lógica de la auditoría HTML se parametrizó respecto del total declarado de principios, en lugar del literal anterior 42.

## Límites pendientes

No se ejecutó renderizado de navegador ni auditoría dinámica de anclas/retornos. No se modificó ni verificó el campo nativo de Instrucciones Personalizadas. FOL1 permanece `PREPARADO_PENDIENTE_ACTIVACION_IPZ`, sin asignaciones; no se asignan folios a este evento. La calibración decimal del CNP y la aplicación del PAI quedan abiertas a revisión empírica posterior.
