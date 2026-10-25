# C-MCP-JULES-004 · endurecimiento de pruebas y estado de entrega

**Fecha real:** 2026-10-25.  
**Folio global del ciclo:** C-20261025-A6D39F20.  
**Sesión del frente:** SES-20261025-6F8A2C9D · generación 1.  
**Gobierno adquirido:** Samantha v340 · NX-340m; Metacanon 1.21; GOW 2.2.  
**OCP:** `frentes/mcp-jules/`.  
**PR de implementación:** [SeryMente/khora #336](https://github.com/SeryMente/khora/pull/336).  
**PR documental:** [SeryMente/metodologia #18](https://github.com/SeryMente/metodologia/pull/18).

## Objetivo

Resolver los bloqueos detectados durante la verificación, mantener las afirmaciones atadas al commit probado y registrar lo que queda para hacer utilizable el servidor desde ChatGPT.

## Correcciones y evidencia

- La primera ejecución global de CI de Khora observó 545 pruebas PASS y una prueba de sincronización interrepositorio fallida por ausencia de `GH_TOKEN`. La prueba ahora solicita un token de lectura explícito y, si no está disponible, registra un skip explícito; cuando se suministra el token, el fallo de lectura sigue siendo fallo. No afirma sincronización si no pudo verificarla.
- Se corrigieron dos bloques de imports que Ruff marcaba como I001 en los archivos `kernel/tests/test_graph_cycle_regressions.py` y `kernel/tests/test_runtime_leiden_contract.py`. El workflow G-4 del commit correspondiente informó PASS.
- La prueba de interfaz falló al arrancar el servidor Playwright porque el comando de build no heredaba `OIDC_ISSUER_URL` y `AUTH_SECRET`; se añadieron a las variables de entorno de prueba conforme al gate de compilación, sin cambiar credenciales productivas.
- En una ejecución posterior, `khora-ok` detectó errores TypeScript en el regex de `khora-web/tests/unit/helpers/mcp-route-fixture.ts` al validar nombres de fuente Jules. Se corrigió el regex para que los segmentos de ruta estén escapados correctamente. La nueva ejecución para el commit correctivo aún no estaba disponible al registrar esta crónica.
- Las pruebas nuevas observadas en una revisión anterior del PR pasaron: concordancia de esquemas/call de las 24 herramientas, validación de la ruta HTTP, separación de permisos y `requirePlanApproval=true`. No atribuir esos PASS al commit correctivo hasta que CI vuelva a ejecutarlos.

## Estado de credencial y despliegue

- La lista de variables del proyecto Vercel `khora-web` muestra una variable sensible `JULES_API_KEY` con destino `production`. Se consultó con descifrado desactivado; no se leyó ni registró su valor. Esto prueba existencia de una variable, no validez de la clave.
- Los checks de Vercel de commits de la rama han devuelto una página con `upgradeToPro=build-rate-limit`. Esto es un bloqueo de la plataforma para builds/preview, no evidencia de error del código. El preview Netlify de una revisión anterior sí se creó, pero no demuestra despliegue de producción ni sustituye a Vercel.
- La conexión MCP real desde ChatGPT, una llamada autenticada real a Jules y la ejecución de la secuencia de aprobación/feedback/respuesta permanecen NO VERIFICADAS.

## Validación documental

Los validadores del PR Metacanon se actualizaron para leer el único HTML canónico Samantha v340 y las secciones integradas de Metacanon/GOW, y los enlaces activos de bootstrap se apuntaron a ese archivo. Después del cambio, los workflows siguieron mostrando conclusión FAIL sin pasos ejecutados/runner asignado y sin logs recuperables, incluso tras reintentar. No atribuir un fallo a una aserción concreta ni afirmar PASS; la causa del bloqueo de workflow está NO VERIFICADA. No se crearon espejos Markdown ni se modificó la fuente canónica.

## Resultado y siguiente paso

El contrato, las siete herramientas, los scopes, la protección de aprobación y los criterios de adopción están materializados en ramas de trabajo. **El MVP remoto aún no es utilizable hasta que pase la CI de la punta actual, los PR queden integrados y el despliegue real permita probar la sesión Jules desde ChatGPT.**

Siguiente acción: esperar el resultado real de CI sobre el commit correctivo `9ff5dca4b99b99225dd256dd223f49aec0747b7d` o la punta posterior; corregir cualquier nuevo fallo con lectura de vuelta; no fusionar ni declarar producción mientras los gates materiales sigan sin verificación. La automatización persistente por sondeo es una extensión separada, documentada en la investigación y la guía de replicación.
