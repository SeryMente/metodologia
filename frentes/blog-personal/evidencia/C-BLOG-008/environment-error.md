# Error real de ensayo local C-BLOG-008
Operación: bundle del consumidor desde entry.tsx temporal.
Síntoma verbatim: Could not resolve "react-dom/client"; Could not resolve "react/jsx-runtime"; Cannot import "app/components/ingreso/ingreso-studio.module.css" into a JavaScript file without an output path configured.
Causa: entry en /tmp fuera del árbol de resolución y esbuild trata CSS module separado. No fallo de producto. Estado: no archivos remotos modificados, no publicación.
Corrección: nodePaths desde require.resolve de React; plugin exporta objeto CSS vacío porque este ensayo no audita diseño ni estilos.
Verificación: repetir ensayo causal; resultado en browser-evidence/browser-report.json si pasa.
Prevención: resolución de dependencias instalada explícita y alcance de CSS declarado en el test.

Ensayo2: AssertionError [ERR_ASSERTION]: No independent of positive normative service. Aserción de fixture usaba la última petición global; lectura/efectos asíncronos pueden intercalarse. Se verifica existencia de decline_archived y consentimiento final en escenario aislado; no cambia producto. Si persiste falta de petición, ensayo debe bloquear, no atribuirse éxito.

Ensayo3/4: traza real mostró estado awaiting_editorial_receipt al evaluar aserción prematura; no rechazo de servidor. Se exige waitForResponse(decline_archived) + polling local leído, no una espera ambigua. Además, caso sin recibo no muestra botón de preparar (bloqueo correcto); el test intentaba pulsar control inexistente y agotaba timeout. Corrección de fixture: verificar ausencia de control y cero peticiones. Ningún defecto de producto inferido de estos fallos de harness.
