# Plantilla obligatoria · Informe individual de resolución y cierre de tarea

**Aplicación:** todas las tareas de todos los frentes de SeryMente/metodologia, actuales y futuras, técnicas, documentales, operativas, de investigación o aceptación.

## Regla de cierre

Cada tarea debe dejar su propio informe en su ficha/núcleo canónico: en el README individual cuando exista; si el frente concentra sus tareas en una lista única, bajo el bloque/ID de esa tarea. No se sustituye por un resumen global del frente ni por un comentario aislado en el chat.

El informe se agrega al historial de la tarea (sin borrar ni reescribir evidencia histórica), se enlaza desde el índice padre y se comunica al operador con su enlace. Primero se persiste; después se verifica mediante lectura de vuelta y cotejo del blob/SHA. La actualización del índice solo ocurre después de verificar el informe.

No se marca una tarea como completada hasta que: (a) todos sus criterios terminales aplicables estén PASS; (b) la evidencia de ejecución y verificación esté disponible y sea trazable; (c) el informe esté completo y leído de vuelta; y (d) se haya cumplido toda aceptación humana/local/externa expresamente requerida. Código escrito, documentación creada, pruebas definidas, pruebas sintéticas parciales o un PR abierto no bastan.

Si la tarea queda parcial o bloqueada, se registra igualmente un informe de estado con la misma estructura, pero el estado no se promueve a completada. Actualizarlo en cada relevo material y emitir el informe terminal cuando se resuelva. Un bloqueo externo no justifica ocultar preocupaciones ni detener subtareas independientes.

## Campos obligatorios del informe

Cada sección debe contener información concreta. Cuando no existan elementos, escribir explícitamente NINGUNO_VERIFICADO; cuando no se haya comprobado, escribir NO_VERIFICADO; cuando realmente no aplique, escribir NO_APLICA. No dejar campos vacíos ni convertir desconocimiento en ausencia de problemas.

1. **Identidad y corte:** ID/nombre exacto de la tarea; frente propietario; fecha/hora/zona; estado anterior y estado resultante; commit/base revisados.
2. **Objetivo y resultado:** qué se debía conseguir; qué quedó conseguido y qué no; diferencia residual respecto del objetivo.
3. **Cómo se solucionó:** secuencia ejecutada, decisiones técnicas/operativas y motivos verificables; alternativas descartadas relevantes. Describir el método y el resultado, no razonamiento privado.
4. **Cambios realizados:** archivos/rutas, componentes, configuraciones o sistemas tocados; commits, blobs y SHA aplicables. Distinguir claramente cambio propuesto, autorizado, intentado, ejecutado y verificado.
5. **Validación y evidencia:** criterio por criterio con PASS/FAIL/NOT_RUN/NOT_APPLICABLE; comando/procedimiento, entorno, resultado observado, identificador de prueba/workflow, logs/artefactos y hashes. Incluir read-back y recibos remotos cuando correspondan. Una prueba escrita o un workflow sin runner/steps/logs no es una prueba ejecutada.
6. **Bloqueantes y dependencias:** bloqueo exacto, evidencia, impacto, responsable/tercero que debe resolverlo, entrada o autorización requerida y condición objetiva para desbloquear. Si no hay, declarar NINGUNO_VERIFICADO.
7. **Preocupaciones y riesgos:** seguridad, privacidad, permisos, integridad, regresiones, compatibilidad, disponibilidad, coste, mantenibilidad y efectos colaterales; mitigación o decisión pendiente. Si no hay, declarar NINGUNO_VERIFICADO; lo no examinado queda NO_VERIFICADO.
8. **Pendientes y trabajo diferido:** qué queda fuera, por qué, quién lo retoma y qué dependencia lo habilita. No cerrar trabajo pendiente bajo una redacción ambigua.
9. **Rollback/recuperación:** mecanismo probado o plan de reversión, límites y condición para usarlo; declarar NO_VERIFICADO si no se probó.
10. **Aceptación y conclusión:** criterio final, quién/qué lo acepta, evidencia de aceptación y fecha; estado terminal explícito. Separar verificación técnica de aceptación humana/operativa.
11. **Siguiente acción:** solo si el estado no es terminal; acción concreta, propietario y gate de entrada.

## Formato para copiar en la ficha de la tarea

~~~markdown
### Informe de resolución/cierre · <ID de tarea> · <fecha y zona>

- **Frente / responsable:**
- **Estado anterior → resultante:**
- **Corte de fuente:** rama, commit y documentos revisados.
- **Objetivo y resultado:**
- **Cómo se solucionó:** pasos y decisiones verificables.
- **Cambios:** rutas, artefactos, commit/blob/SHA.
- **Validación:** criterio | PASS/FAIL/NOT_RUN | procedimiento/entorno | evidencia/log/artefacto/hash.
- **Read-back e integridad:** rutas, blob/SHA y resultado del cotejo.
- **Bloqueantes/dependencias:** o NINGUNO_VERIFICADO.
- **Preocupaciones/riesgos y mitigaciones:** o NINGUNO_VERIFICADO; no examinados NO_VERIFICADO.
- **Pendientes/diferidos:** o NINGUNO.
- **Rollback/recuperación:** evidencia o NO_VERIFICADO.
- **Aceptación:** criterio, aceptante, evidencia y fecha; o PENDIENTE.
- **Siguiente acción:** propietario y condición; NO_APLICA si terminal.
- **Conclusión:** COMPLETADA, PARCIAL, BLOQUEADA o CANCELADA, con justificación.
~~~

## Reglas de integridad del reporte

- Un informe por tarea; las tareas hermanas conservan sus propios estados e informes.
- No copiar secretos, credenciales, claves, datos personales innecesarios ni contenido privado a informes, índices, commits, logs o comentarios.
- Citar fuentes recuperables y evidencia original; no presentar inferencias como observaciones.
- No declarar PASS por ausencia de error, ni causa raíz sin evidencia.
- Registrar fallos y correcciones relevantes sin borrar el historial; un fallo conocido debe incluir impacto y prevención.
- El resumen enviado al operador debe enlazar el informe individual y mencionar solución, estado, bloqueantes y preocupaciones principales.
