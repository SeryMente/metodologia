# Continuidad entre conversaciones · mejora continua

Prioridad rectora: el operador dice las cosas en el chat una vez; el sistema conserva y recupera lo ya expresado, sin devolverle el trabajo de reconstrucción. El objeto es el directorio del frente; el núcleo concentra el estado vigente y la ventana de contexto externa, no la memoria privada del modelo. Conversaciones, crónica y pendientes son registros diferenciados.

## Arranque según plataforma

- **Notion:** puede recibir el metaprompt por configuración. Verificar página, firma y revisión del contenido realmente cargado. Si la configuración apunta a una versión antigua, cargar expresamente la fuente vigente y declarar la diferencia; una edición de página no demuestra que se haya corregido el ajuste de personalización.
- **Otras plataformas:** no presumir instrucciones instaladas. Adquirir expresamente el mismo gobierno desde el repositorio o una copia íntegra de procedencia identificada. Sin conector al repositorio privado, la copia suministrada permite lectura limitada, no escritura ni frescura verificadas.
- En esta sesión se observó carga automática de la página v330, marcada eliminada, frente a fuente viva y espejo v332 antes de la edición v333. Se documenta el caso; no se afirma reparado el ajuste de personalización.

## Checkpoint coherente

Antes de arriesgar el corte, conservar en una revisión conjunta: gobierno adquirido; identidad y ruta del núcleo; evento hasta el cual hay originales; estado, decisiones y pendientes; operaciones con resultado confirmado o incierto; evidencia y siguiente acción. Para transporte, un manifiesto derivado identifica revisión de origen y huellas de los archivos necesarios. No es otro estado vigente: su validez está limitada a esa revisión.

La huella detecta alteraciones respecto de una referencia conocida; no prueba autoría o vigencia por sí sola. Si no se conoce la revisión actual, declarar frescura desconocida. Si falta gobierno, cobertura indispensable, identidad del frente o conciliación de cambios, detener la acción afectada, no rellenar por inferencia. Una operación «hecha» sin evidencia exige revisión; una operación incierta nunca se repite a ciegas. No existe manera de recuperar un mensaje jamás guardado solo escribiendo una norma.

## Custodia de la conversación y de ideas

Guardar originales literales con identificador de conversación y secuencia de origen; preservar correcciones y duplicados. Consignar plataforma/modelo/rol/persona cuando se conozcan, no inventarlos. Una crónica explica y enlaza; no sustituye originales. Las propuestas no pasan a decisiones por aparecer en el chat. Mantener una lista consultable de pendientes con identificadores y evidencia de resolución, sin segunda fuente de estado operativo. «Fuentes de trabajo» se interpreta como «frentes de trabajo» en este contexto, pero no se modifica el original.

En metodología, el núcleo sigue siendo `METACANON-OBJETOS-CANONICOS.md`, §9. `frentes/metodologia/PENDIENTES.md` es el registro de ideas enlazado, no otro núcleo. La custodia recuperada de esta sesión tiene su índice en `frentes/metodologia/evidencias/SESION-3ff5-cobertura.json`.

## Pruebas y aceptación

Banco reproducible en `frentes/metodologia/pruebas/continuidad/ensayo.py`, sin dependencias externas, credenciales, red ni modelos. Fabrica escenarios sintéticos y arranca un proceso nuevo por retoma; comprueba recuperación desde archivos, integridad, cobertura, frescura, operaciones, ambos modos de plataforma y no mutación del paquete. Tres variantes deliberadamente escalonadas permiten ver fallos y correcciones. No son mediciones de versiones históricas del metacanon ni ensayos de comprensión de modelos.

Resultado mecánico: 33/33 escenarios pasan en la variante final; repetibilidad comprobada. Esto no acredita continuidad semántica en otra conversación de inteligencia artificial, no prueba rendimiento en ChatGPT gratuito, no instala middleware que fuerce a un modelo a obedecer y no demuestra una garantía universal.

**Siguiente prueba pendiente:** una conversación independiente, sin este historial, recibe solo el prompt y las fuentes del frente; debe contestar las cinco preguntas de retoma sin recapitulación del operador, distinguir los límites y realizar un siguiente paso autorizado sin duplicar operaciones. Registrar modelo y plataforma solo si son verificables. Repetir ante fallos reales, incorporando primero los de mayor urgencia.

## Diferidos y límites

La sincronización automática aplicación → repositorio continúa sin implementación acreditada; los espejos de este ciclo son copias puntuales. Seguridad/cifrado y revisión de Sesión PRIUS permanecen diferidos explícitos. Esta mejora no activa PRIUS ni modifica los permisos de seguridad. El aligeramiento físico del metacanon y la adquisición de todas las dependencias Notion siguen pendientes; no se declara portabilidad total.

## Endurecimiento1.9

Aplicar §35: demostrar retoma desde fuentes, verificar bloques completos y acción contra autorización; detener solo la dependencia no adquirida. Distinguir copia offline, original, estado confirmado y efecto incierto. El verificador0.1.1 toma la versión real del método y comprueba el gobierno completo contra la huella de origen suministrada. Huellas y procesos aislados no acreditan semántica ni autoría de una referencia no confiable. No activar cifrado, PRIUS, observador o sincronización por esta mejora.

## Aceptación integral1.10

Aplicar§36: contrato del ciclo y propósito global separados, dependencias por operación, estado único y versiones textuales. Las cinco puertas requieren evidencia propia; preparar un paquete no aprueba la retoma real. Conservar en REAL-CHATGPT-01 entrada, respuesta y acción literales, sin atribuir modelo desconocido ni autocalificación.

## Refresco de la fuente · ciclo10

Aplicar§37 en cada ciclo activo: comprobar versión/huella y commit de la ruta central por un medio real; recuperar/adoptar solo delta compatible ya autorizado. Mostrar versión adquirida, antigüedad de modificación y estado de comprobación. Sin acceso/reloj/origen: vigencia o edad NO VERIFICADA. No fingir refresco entre turnos o de instrucciones nativas.

## Responsabilidad exclusiva · método1.10§38

La migración no transfiere el frente por sí sola. Verificar CONTROL-RESPONSABILIDAD.json autoritativo: segundo hilo, copia offline o propiedad incierta ⇒ solo lectura/análisis y propuestas NO APLICADAS, sin asumir responsabilidad ni escribir el canon. No vence por interrupción. Transferir explícitamente a hilo/instancia identificados mediante comparación y sustitución atómicas; nunca sobrescribir el control con push genérico. La biblioteca ensaya el control, no impone un cerrojo a herramientas que lo eludan; esa limitación debe declararse. Refresco y propiedad son compuertas independientes.
