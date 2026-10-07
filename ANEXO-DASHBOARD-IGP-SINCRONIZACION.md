# ANEXO — Especificación canónica del Dashboard IGP para sincronización

**Estado:** CANÓNICO
**Caso prioritario:** Otro Gran Programa (OGP)

## 1. Función

El dashboard es el instrumento de control de cada iteración. No es el objetivo del sprint.

Debe permitir comprender rápidamente el estado de OGP y decidir qué defecto debe atacarse a continuación.

## 2. Vista mínima

Primero: IGP actual, Déficit hasta 100, Gates críticos y Δ IGP vs baseline.

Después, las métricas núcleo y, por separado, los diagnósticos.

## 3. Tarjeta de métrica

VALOR → OBJETIVO → CALIDAD → PESO → GATE → DELTA → EXPLICACIÓN

La explicación debe ocupar una sola oración o frase corta comprensible.

## 4. Estados

PERFECTO · CERTIFICADO · NO CERTIFICADO · ERROR DE MEDICIÓN

Un error de medición nunca debe representarse como una puntuación cero.

## 5. Comparación

La referencia primaria es la baseline congelada. Debe verse el delta absoluto y el estado del gate.

Las tendencias históricas son complementarias y nunca sustituyen los números comparables.

## 6. Integridad

El dashboard no puede modificar benchmark, baseline, pesos, umbrales ni resultados; tampoco ocultar fallos.

## 7. Procedencia

Deben aparecer versión, commit, workflow, muestra, segmentos, palabras y snapshot de datos.

## 8. Prioridad OGP

El dashboard debe ser suficientemente simple para no distraer del objetivo operativo: hacer que la palabra resaltada corresponda a la palabra hablada.

Toda extensión del dashboard debe justificar que ayuda a encontrar o comprobar mejoras de OGP.

## 9. Referencia

https://github.com/SeryMente/otrobuenprograma/blob/main/sync-dashboard.html
