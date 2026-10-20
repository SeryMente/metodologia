# Ideas pendientes · frente de metodología

Registro de trabajo, no sustituto del estado canónico ni de las conversaciones originales. Las decisiones aquí recogidas no se presentan como implementaciones. La prioridad sigue urgencia e impacto; no se altera una prioridad acordada sin indicación del operador.

## Mandato vigente

Primero lo urgente y después la mejora continua. Conservar las notas de lo que dice el operador y poder mostrar las ideas pendientes cuando lo solicite. No declarar conservación íntegra si falta verificar la cobertura de los originales.

## Urgente

- **CONT-01 · En curso, no verificado:** ensayar en un entorno virtual la continuidad de contexto entre conversaciones; iterar sobre los fallos observados. Distinguir pruebas de archivos y recuperación de estado de pruebas semánticas con modelos independientes. No prometer perfección universal.
- **CONT-02 · Pendiente:** consolidar un prompt universal de reinstanciación que recupere el frente desde la revisión persistida, sin depender de la memoria del chat anterior. Debe cubrir cortes imprevistos y conversaciones limitadas, no solo traspasos planificados.
- **GOB-01 · Autorizado, no aplicado:** añadir al metaprompt de Samantha únicamente lo necesario para dar cabida a los frentes y su continuidad, preservando identidad, dinámica y normas existentes. No equivale a autorización para rehacerlo.
- **PORT-01 · Parcial:** terminar la portabilidad del metacanon. Ya existe el primer bloque documental 1.7 en GitHub; todavía no acredita arranque ligero ni funcionamiento sin acceso a Notion. La dependencia de conectores y el modo de transporte sin conector requieren resolución explícita.
- **CUST-01 · En curso:** mantener entradas del operador y salidas visibles del asistente en la carpeta del frente, con secuencia y límites de conversación, plataforma y modelo. Archivar metadatos solo cuando sean conocidos; no inferir modelo, rol o persona.
- **CUST-02 · Pendiente:** reconciliar la cobertura del historial anterior a este registro. El bloque C-METODOLOGIA-GOBIERNO-01 declara cobertura parcial. Estas notas son una síntesis de acuerdos recuperados, NO una transcripción íntegra ni prueba de que no se perdió nada.

## Importantes, sin implementación acreditada

- **SYNC-01 · Requisito ratificado, pendiente:** cada cambio a un documento en una aplicación de espacio de trabajo, como Notion, debe desencadenar la actualización automática de su espejo en el repositorio. Dirección ratificada: aplicación → repositorio. Una copia puntual no acredita sincronización perpetua. Detectar y visibilizar fallos; no prometer infalibilidad.
- **ARQ-01 · Arquitectura ratificada, materialización parcial:** objeto = directorio completo. Un archivo de entrada enruta hacia un núcleo operativo único y otros materiales según necesidad. Evitar cargar un archivo monolítico de aproximadamente 70 000 caracteres. Ventana de contexto y copia de conversaciones son relacionadas, pero distintas.
- **HIST-01 · Requisito ratificado:** historial secuenciado de la conversación general, incluidos cambios de plataforma, conversación y modelo; identidad/rol solo cuando estén asignados. Conservar originales además de la crónica y distinguir resúmenes de originales.
- **DOC-01 · Requisito ratificado:** el frente contiene copias de los documentos producidos en aplicaciones especializadas. GitHub sostiene la persistencia transversal de la organización SeryMente; las aplicaciones son superficies de trabajo, no una dependencia exclusiva.
- **GLOS-01 · Requisito ratificado:** «frente de trabajo» es la denominación corta de «objeto canónico de persistencia de frente de trabajo». Enumerar formalmente sus características generales a partir de la práctica de estas semanas, no inventar complejidad por anticipación.
- **GOB-02 · Parcial:** el metaprompt de Samantha es el gobierno general del repositorio y la organización, como el mismo documento sincronizado, no un gobierno paralelo. El espejo v332 existe; cualquier nueva edición debe cotejarse con la fuente.

## Diferidos explícitamente

- **SEG-01 · Alta importancia, diferido por urgencia:** seguridad de la información, cifrado de documentos y contenido de los frentes. El diferimiento NO autoriza publicar secretos, abrir repositorios ni eliminar controles existentes.
- **PRIUS-01 · Diferido hasta que no haya urgencias:** revisar la capa 2, Canon Sesión PRIUS, y decidir cómo utilizarla. El usuario prevé utilizarla, pero no la ha reactivado. La capa 1 sigue siendo el metaprompt de Samantha.

## Criterio de cierre de una idea

Conservar el identificador y registrar evidencia de implementación, cancelación explícita o sustitución acordada. No retirar pendientes por silencio ni por aparecer mencionados en una norma. Mostrar este registro cuando el operador pida las ideas pendientes.

## Cobertura

Este archivo recoge acuerdos disponibles en el contexto activo y la recapitulación de trabajo. Para las dos instrucciones nuevas conservadas literalmente, véase `conversaciones/C-METODOLOGIA-CONTINUIDAD-02-entradas.json`. No contiene pensamientos privados del modelo. No afirma custodia automática de mensajes futuros ni recuperación completa de conversaciones anteriores.
