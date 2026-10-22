# Kit portable de continuidad · 0.1.0

Herramientas auxiliares, no un nuevo estado canónico ni sustituto de Samantha. El estado sigue en §9 del metacanon. Uso de metodología general, incluyendo plataformas gratuitas. No instala servicios, extensión ni nuevas credenciales.

## Con y sin conectores

Con acceso al repositorio: iniciar por INICIO.md y el prompt universal, leyendo revisión y gobierno reales. Sin acceso: suministrar ARRANQUE.md del paquete y los archivos bajo demanda. Es una copia fechada: la plataforma debe declarar frescura desconocida hasta cotejar main. Conservar los originales en JSON/archivos, no confundir la lectura operativa con toda la historia.

El kit construye paquete JSON con inventario, SHA-256, revisión de origen y cobertura. La retoma produce un Markdown con gobierno obligatorio íntegro, proyección literal del método aplicable, §9 y pendientes. Se omiten del arranque §§10,11,18 de originales/antecedentes; se conservan íntegros en el paquete. El archivo raíz no se refactoriza ni se borra. Algunas secciones aplicables todavía contienen citas; no prometer un arranque mínimo ya perfeccionado.

## Interfaz ejecutable

`build`: recibe especificación, raíz, archivo de salida nuevo y revisión adquirida. `check` y `resume`: reciben paquete, opcionalmente revisión esperada y versión cargada nativamente. Ayuda exacta al invocar sin argumentos; no muta repositorio, no reejecuta efectos, no escribe sobre salidas existentes.

`laboratorio.cjs` recibe especificación, raíz, revisión y ruta nueva de resultado. Cada caso ejecuta un proceso Node fresco; conserva resultado, denominador, entorno, hashes y duración. Los temporales son únicos. No requiere paquetes de terceros ni descarga modelos. La regresión Python original se conserva sin modificar como ensayo-historico.py.

## Límites de confianza

Hashes detectan corrupción respecto al manifiesto; no son firma de autor ni certifican actualidad o comprensión. Un atacante que reescriba contenido y manifiesto queda fuera de esta prueba: comprobar procedencia/revisión en GitHub. Proporcionar revisión esperada desde evidencia independiente, no del mismo paquete si se busca detectar obsolescencia. Un proceso independiente NO es una conversación independiente con otro modelo.

La validación semántica sigue pendiente: próximo ensayo receptor ciego solo con paquete, respuestas sobre objetivo/estado/restricciones/próxima acción y cotejo humano con rúbrica. No se promete perfección universal. El equipo Windows ejecuta un laboratorio CLI aislado, no una máquina virtual ni vigilancia autónoma en segundo plano.
