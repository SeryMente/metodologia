# C-MCP-JULES-011 · correcciones de auditoría estática y nuevo head sin ejecución de CI

**Fecha:** 2026-10-30. **OCP:** `frentes/mcp-jules/`. **Folio:** `SES-20261029-6C2F9A17`, generación 2. **Evento:** C-MCP-JULES-011. Esta crónica continúa C010; no modifica la titularidad ni crea una fase nueva.

## 1. Head vigente

- [KHORA PR #344](https://github.com/SeryMente/khora/pull/344), aún en borrador y sin merge.
- Rama `feat/mcp-jules-f2-20261029-6c2f9a17`.
- Head `3c7691bf4e69260b66d616f605e0ef32d5adc099`.
- Base `fix/custodia-recovery-verified-20261029`, head `e2ec67600885315fd4493911da89af1d4aafc297`; PR #340 de Custodia sigue abierto en borrador.

## 2. Correcciones derivadas de la revisión estática

1. El fixture MCP esperaba 25 llamadas de negocio. La nueva ruta añade dos preflights Jules: lectura de la sesión antes de listar actividades y consulta `sources.get` antes de crear. El total esperado se ajustó a 27 y se mantienen las comprobaciones de que ninguna herramienta recibe los tres controles normativos como argumentos de negocio.
2. El listado de ramas autorizadas ahora incluye `defaultBranch` como candidato aunque Jules no lo repita dentro de `githubRepo.branches`. Después deduplica por `displayName` y filtra con la ACL exacta; una rama default no autorizada no se publica. El fixture se modificó para que `main` exista solo como default y `restricted` aparezca en `branches`, de modo que el test cubra el caso.
3. La migración `033_jules_source_acl.sql` ahora exige `subject` y `granted_by` exactamente recortados, y obliga a registrar `revoked_by` junto con `revoked_at`. La migración continúa sin aplicar.

## 3. CI y servicios externos

Los nuevos eventos para el head `3c7691bf…` generaron CI y UI Quality. Los tres workflow runs relevantes fueron:

- UI Quality `41085296593`: UI E2E y UI Contract terminaron `failure`, ambos con `steps: null`.
- CI `41085296613`: `khora-web-gate`, `api-tests` y `calidad` terminaron `failure`, todos con `steps: null`.
- CI `41085286121`: repetición adicional del flujo, con los tres jobs terminando `failure` y `steps: null`.

Los checks Vercel del head permanecen en `failure` con destino a la configuración de plan/organización para repositorios privados. No se obtuvieron logs de ejecución de runner ni output de test. La conclusión sigue siendo CI pre-run no ejecutado; no se declara PASS ni FAIL de producto.

## 4. Estado de aceptación

- Código de siete herramientas, ACL y retry diferenciado: versionado en PR #344.
- Pruebas de catálogo, autorización, fuente/rama y retry: escritas y versionadas, sin ejecución válida.
- Migración ACL: versionada, no aplicada; rol read-only real sin verificar ni read-back.
- OAuth real, API Jules real, plugin público, ChatGPT Free, E2E, merge, despliegue y smoke/rollback: PENDIENTES.
- T01–T32: PENDIENTE; no se hereda evidencia histórica de otros heads.

## 5. Cierre

Se corrigieron dos defectos de preparación estática detectados durante revisión y se endureció la integridad de la ACL. El candidato sigue en Fase 2 EN CURSO y no se considera terminado ni utilizable. C010 conserva la historia del primer candidato; C011 fija el head actual y la última lectura de CI.

El control `CONTROL-RESPONSABILIDAD.json` permanece en SHA `6b5e9cb7a93af95e029100b48bcaa74d618354a2`, generación 2. No se modificó.