# C-METODOLOGIA-RDC-GUI-12 — incidente y prohibición de GUI compartida

- **Reporte/orden:** el operador observó que un modelo usaba la interfaz gráfica del monitor activo mediante RDC y ordenó identificarlo, detenerlo y evitar repetición.
- **Contención:** se envió orden urgente a los cinco hilos que figuraban en ejecución para detener GUI y limitarse a CLI/headless.
- **Identificación:** Signal Interpreter reconoció intentos sobre Chrome: abrir `chrome://extensions`, solicitar cierre normal de Chrome y acceder al botón Extensiones por automatización de accesibilidad. La última invocación falló; Chrome no se cerró.
- **Contraste:** el historial RDC recuperado de PC10RCIF4EI4 mostró, en los 200 eventos consultados, 100 `read_process_output`, 92 `start_process`, 3 `get_config`, 2 `list_sessions`, 1 `list_processes`, 1 `kill_process` y 1 `read_file`; no contenía la llamada gráfica reconocida. Por eso la atribución se apoya en el reconocimiento del hilo, no en ese historial limitado.
- **Decisión:** RDC no autoriza GUI compartida. Solo CLI/headless mientras el operador usa el monitor. GUI únicamente con autorización específica y segundo monitor verificado.
- **Cambio:** Metacanon 1.12, invariante §1.18, precisión en §24 y regla completa §40.
- **Límites:** no se revisaron los 1.000 eventos completos; no se afirma ausencia de otros intentos. Enraizamiento 3 y Dictado declararon solo uso CLI en su tramo.
- **Checkpoint:** persistir original, crónica, revisión y Metacanon; releer y comprobar versión/sello/regla.
