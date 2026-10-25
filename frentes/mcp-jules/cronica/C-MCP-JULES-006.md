# C-MCP-JULES-006 · corrección del secreto sintético de Playwright

**Fecha real:** 2026-10-25.  
**Folio global del ciclo:** C-20261025-9B3A7D20.  
**Sesión del frente:** SES-20261025-6F8A2C9D · generación 1.  
**Gobierno:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2.  
**OCP:** 'frentes/mcp-jules/'.  
**PR de implementación:** [SeryMente/khora #336](https://github.com/SeryMente/khora/pull/336).

## Síntoma comprobado

En el workflow 'UI Quality' para 'feat/mcp-jules-tools-20261025', la prueba de Playwright no llegaba a iniciar el servidor web porque el comando 'webServer' invoca 'npm run build'; ese script ejecuta 'prebuild', que ejecuta las pruebas de unidad. Seis casos de 'mcp_normative_gate.test.ts' fallaron con 'TURN_TOKEN_INVALID_SIGNATURE'.

La lectura de vuelta de la prueba encontró que 'makeToken()' firma los tokens de prueba con 'test-jwt-secret-min-32-chars-long', pero 'playwright.config.ts' inyectaba 'mock-jwt-secret-at-least-32-chars-long'. No era un fallo del API Jules ni de la clave de producción.

## Corrección

- 'khora-web/playwright.config.ts': se alinearon las dos apariciones de la clave sintética (comando Windows y entorno POSIX) con el valor empleado en 'mcp_normative_gate.test.ts'.
- No se cambió 'MCP_JWT_SECRET' productivo, ni la validación JWT, ni los tokens emitidos por el servidor.
- Se mantienen 'stdout: "pipe"' y 'stderr: "pipe"' para que futuras fallas del proceso de arranque no queden ocultas en los logs de UI.

Commit correctivo: '8a8d8404aaaee39898665530f711d3ca927e6ea8'.

## Estado de verificación al registrar este ciclo

- CI del commit anterior 'e57118003921a5dfca76ee8fe4e39ea13daec73b': **PASS** (incluida la suite de unidad; 548 PASS y 1 SKIP reportados en ese corte).
- UI Quality del commit anterior: **FAIL**, con seis fallas de token sintético diagnosticadas; es evidencia de causa anterior, no de la corrección.
- CI, UI Quality, G-4 y 'khora-ok' se dispararon para el commit correctivo '8a8d8404aaaee39898665530f711d3ca927e6ea8'; esos nuevos resultados seguían en ejecución/pendientes en el momento de guardar esta crónica. No trasladar automáticamente los PASS del commit previo.
- Checks de Vercel del commit anterior siguen fallando con 'build-rate-limit'; el preview Netlify anterior pasa, pero no es despliegue de producción.
- Los validadores del PR Metacanon siguen en FAIL sin pasos, runner ni logs recuperables; causa NO VERIFICADA.

## Próximo paso

Leer los resultados de la punta '8a8d8404aaaee39898665530f711d3ca927e6ea8'. Si el prebuild y Playwright pasan, continuar con los gates globales restantes. Los PR se mantienen abiertos y la utilidad remota sigue NO VERIFICADA mientras no se pruebe una llamada autenticada desde ChatGPT al servidor desplegado.
