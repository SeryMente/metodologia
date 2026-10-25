# C-MCP-JULES-003 · verificación inicial por GitHub Actions

**Fecha real:** 2026-10-25.  
**Folio global del ciclo:** C-20261025-9D2B6A17.  
**Folio de sesión / control:** SES-20261025-6F8A2C9D · generación 1.  
**Gobierno:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2.  
**OCP:** `frentes/mcp-jules/`.  
**PR de implementación:** [SeryMente/khora #336](https://github.com/SeryMente/khora/pull/336).  
**PR documental:** [SeryMente/metodologia #18](https://github.com/SeryMente/metodologia/pull/18).

## Objetivo

Leer resultados reales de las acciones de integración continua que dispararon las dos solicitudes de integración; distinguir evidencia a favor de las nuevas herramientas de bloqueos de la suite global; no declarar merge ni MVP remoto utilizable sin pruebas y conexión reales.

## Evidencia de Khora

Para el SHA `d695f3e25ec0fe6edbdd80e03d7dd1a7d20ff58d`:

- `npm run typecheck`: **PASS**.
- `npm run ui-review:check`: **PASS**.
- `npm run ui:contract`: **PASS**.
- API tests: **PASS**.
- Pruebas nuevas de contrato MCP: **PASS**. La salida de CI marca exitosamente:
  - `all 24 real registration shapes generate valid schemas and accept advertised examples`;
  - `real route: HTTP discovery and all 24 calls agree; malformed input cannot reach service`;
  - `Jules scopes are least-privilege and session creation always requires explicit plan approval`.
- Suite de unidades completa: **545 PASS / 1 FAIL**. El único fallo observado es `KHORA local contract matches the canonical Metodología contract`, en `tests/unit/methodology_contract_sync.test.ts`, porque el proceso `gh api` exige `GH_TOKEN` y la acción no lo proporciona. La prueba intenta leer el esquema de un repositorio privado diferente; no es fallo de una prueba nueva de Jules.
- La etapa de calidad Python falla en `ruff check .` por dos errores I001 de orden de imports en `kernel/tests/test_graph_cycle_regressions.py` y `kernel/tests/test_runtime_leiden_contract.py`, archivos que no se modificaron en esta tarea.
- `khora-ok`/build y UI Contract fallan al ejecutar la misma suite de unidades que incluye la dependencia sin `GH_TOKEN`. Por tanto el build del flujo no terminó y no queda certificado como PASS.
- No se verificó conexión autenticada a la API Jules, porque no se usó ni se leyó `JULES_API_KEY`.

## Evidencia de Metacanon

Para la revisión del PR #18, las acciones `validate-canonical-bootstrap` y `Validate RDC Governance` terminaron en **FAIL**. El contenido visible de esos validadores sigue exigiendo rutas Markdown heredadas como `gobernanza/METAPROMPT-CANONICO-SAMANTHA.md`, `METACANON-OBJETOS-CANONICOS.md` y la identidad anterior v339 / NX-339m. La fuente canónica `main` que se adquirió para este ciclo es el documento integrado `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`, v340 / NX-340m. La lectura de los logs de esos jobs no devolvió el detalle de pasos; la discrepancia de rutas/versiones en los propios validadores sí quedó comprobada. No se cambió la fuente de gobernanza ni se añadieron archivos espejo para satisfacer checks desactualizados.

## Resultado y límites

El test de contrato específico de Jules y los chequeos TypeScript, UI y API observados pasan; las puertas globales permanecen rojas por fallos de suite existentes o validadores no alineados con el canon actual. No se declaró ningún resultado global de CI como verde. No hubo merge, despliegue, key configurada ni uso real desde ChatGPT. Ambos PR permanecen abiertos.

## Próxima acción

Aislar el bloqueo de CI sin desactivar comprobaciones ni crear documentación normativa espejo; corregir solo lo que quede dentro del alcance autorizado. Después, volver a ejecutar los workflows y actualizar la aceptación con evidencia. El frente no es todavía **MVP REMOTO UTILIZABLE**: la secuencia real con una sesión de Jules y la conexión del cliente siguen pendientes.
