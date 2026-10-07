# ANEXO — Procedimiento canónico de sincronización audio–transcripción en vivo

**Incorporación:** v0.10.0 · **Estado:** CANÓNICO
**Caso prioritario:** Otro Gran Programa (OGP)

## 1. Propósito

Conseguir una correspondencia temporal precisa entre la palabra pronunciada y la palabra resaltada en una transcripción viva.

El procedimiento es reutilizable, pero su prioridad operativa inmediata es OGP.

## 2. Regla maestra

CAMBIO → BENCHMARK → NÚMEROS → DELTA → DECISIÓN → EVIDENCIA → PUBLICACIÓN

El objetivo no es producir el benchmark ni el dashboard. El objetivo es mejorar la sincronización de OGP lo antes posible con evidencia objetiva.

## 3. Línea de base congelada

Antes de perfeccionar se congela una baseline identificada y versionada. Debe conservar versión, commit, workflow, fecha, configuración, muestra y valores completos. No se redefine para favorecer una iteración.

En OGP, la referencia actualmente establecida es B1.

## 4. Benchmark independiente del contenido

El motor recibe externamente segmentos, palabras, audio, tiempos, adaptador de runtime, muestra y umbrales. No puede depender de nombre de proyecto, audio, idioma, número de segmentos o número de palabras.

La eliminación, adición o sustitución de segmentos debe recalcular automáticamente la medición.

La independencia del contenido debe servir para OGP primero y, después, para reutilización futura.

## 5. Métricas

| Métrica | Explicación de una frase | Ideal |
|---|---|---:|
| M1 · Cobertura | Cuántas palabras tienen timing certificado. | 100 % |
| M2 · Integridad textual | Confirma que el timing usa exactamente el texto canónico. | 100 % |
| M3 · Monotonía | Comprueba que los tiempos avanzan en orden. | 100 % |
| M4 · Intervalos válidos | Verifica que cada palabra tenga inicio y fin válidos. | 100 % |
| M9 · Latencia visual P95 | Mide cuánto tarda el resaltado en seguir al audio. | 0 ms; gate ≤ 50 ms |
| M10 · Palabra incorrecta | Mide cuántas veces se resalta una palabra equivocada. | 0 % |
| M11 · Palabra omitida | Mide cuántas veces falta el resaltado correcto. | 0 % |
| M12 · Monotonía de transición | Comprueba que el resaltado no retroceda. | 100 % |
| M13 · Estabilidad de seek | Confirma que el audio llegue estable al tiempo solicitado. | 100 % |

M5–M8 son diagnósticos hasta disponer de un ideal comparable suficientemente definido.

## 6. Índice General de Perfección (IGP)

IGP = 100 × Π(qᵢ ^ wᵢ), con Σwᵢ = 1.

Pesos por defecto: M1 8 %, M2 8 %, M3 8 %, M4 8 %, M9 18 %, M10 15 %, M11 15 %, M12 10 %, M13 10 %.

El IGP mide distancia al ideal, no distancia a B1.

Estados: PERFECTO = todos los gates pasan e IGP 100.000; CERTIFICADO = todos los gates pasan e IGP < 100.000; NO CERTIFICADO = algún gate falla.

Un gate crítico fallido nunca puede ser compensado por otras métricas.

## 7. Dashboard obligatorio

En cada iteración debe mostrar IGP, déficit hasta 100, gates, delta frente a baseline, cada métrica con valor/objetivo/calidad/peso/gate/delta y una sola frase explicativa, diagnósticos separados y evidencia.

Un error de medición debe mostrarse como ERROR DE MEDICIÓN y nunca convertirse en cero artificial.

## 8. Regla de iteración

Cada cambio debe mantener el mismo instrumento de medición. Una iteración es mejor solo si la evidencia demuestra mejora frente a la referencia elegida.

Si una iteración mantiene M10/M11 en 0 % pero empeora el IGP o la métrica que pretendía mejorar, se registra como NO MEJORA.

El dashboard no puede alterar baseline, benchmark, pesos ni umbrales.

## 9. Prioridad OGP

1. Aislar el defecto real.
2. Corregirlo.
3. Medirlo.
4. Compararlo.
5. Publicar la mejora.
6. Repetir.

No debe abrirse una línea de abstracción, visualización o generalización que retrase materialmente este ciclo.

## 10. Implementación de referencia

Repositorio: https://github.com/SeryMente/otrobuenprograma
Dashboard: sync-dashboard.html
Motor IGP: assets/js/igp.js
Benchmark: scripts/lib/sync-benchmark.js y scripts/benchmark_sync_timing.py
Configuración IGP: assets/data/sync-igp-config.json
Definiciones: assets/data/sync-metric-definitions.json
