# Inventario inicial de necesidades y vías de acceso a inteligencia artificial · v0.1

Estado: **derivado de fuentes internas; no equivale a acceso actual verificado**. Corte: C-ACCESO-001. Método: recuperar necesidades, evidencia histórica, vías ya consideradas y huecos; no elegir proveedor ni gastar.

## 1. Necesidades funcionales recuperadas

| ID | Necesidad | Umbral preliminar | Evidencia interna | Estado |
|---|---|---|---|---|
| N01 | Comprender dictado divergente, largo y matizado sin perder el hilo | Mantener contexto, negaciones, términos propios, intención y continuidad entre ciclos | [Custodia de volcados 2026-08-07](https://app.notion.com/p/163a4187824183da889b0162aa0f242e) | Necesidad explícita; prueba comparativa pendiente |
| N02 | Sostener persistencia cognitiva y convertir material amorfo en acción recuperable | Recuperar antecedentes, preservar originales y producir síntesis/acciones trazables | [Custodia de volcados 2026-08-07](https://app.notion.com/p/163a4187824183da889b0162aa0f242e) y propósito SEA/IAR/RES del workspace | Necesidad explícita; criterios cuantitativos pendientes |
| N03 | Construcción de software asistida por agente | Edición real de archivos, uso fiable de herramientas, pruebas y continuidad en editor/repositorio | [SET.2 · IA en el editor](https://app.notion.com/p/fc9a418782418237b07381d23d959b9f) | Diseño histórico; propiedad “Prueba real” está desmarcada |
| N04 | Investigación, contraste y razonamiento adversarial con varios modelos | Capacidad de confrontar ideas, revisar fuentes y evitar dependencia de una sola perspectiva | [Espejo vital](https://app.notion.com/p/487a41878241821da12981a533f97342) menciona Refinamiento Adversarial Productivo | Necesidad recuperada; carga/modelos concretos pendientes |
| N05 | Voz: transcripción en tiempo real y conservación del audio original | Español personal, baja distorsión, corrección, reconexión, archivo de audio y trazabilidad | [Custodia de volcados](https://app.notion.com/p/163a4187824183da889b0162aa0f242e) y [Radar](https://app.notion.com/p/a7da4187824182bc827f81a465c79e71) | Fallo real documentado; proveedores no comparados |
| N06 | Procesamiento privado/local para el grafo personal sensible | Ejecución local suficiente, sin exponer material sensible a servicios no aprobados | [Oficio CECEQ](https://app.notion.com/p/802a418782418345b78501f9e2fb95bd) | Necesidad de seguridad explícita; hardware/modelos pendientes |
| N07 | Acceso sostenible a modelos de frontera | Calidad suficiente, continuidad, cuotas y costo previsibles; no depender de pruebas efímeras | [Custodia de volcados](https://app.notion.com/p/163a4187824183da889b0162aa0f242e), [Espejo vital](https://app.notion.com/p/487a41878241821da12981a533f97342) | Cuello de botella explícito; acceso actual sin inventariar |

## 2. Accesos y vías ya documentados

| Vía | Evidencia histórica | Qué podría cubrir | Límite actual |
|---|---|---|---|
| Cuentas de prueba/créditos de Notion | El operador reportó acceso a modelos de frontera y reinicios de uso limitado en el volcado de 2026-08-07 | N01, N02, N04 y asistencia general | Temporal, dependiente de créditos/cuentas; vigencia, términos y modelos disponibles NO VERIFICADOS en este ciclo |
| Interfaz de programación de aplicaciones de Anthropic dentro de Continue | Tarjeta SET.2 propone Claude Haiku 4.5 por rapidez, costo y uso de herramientas; tope histórico aproximado de 50 USD/mes | N03 y parte de N01/N02 | Configuración histórica; “Prueba real” desmarcada; modelo, precio, cuenta y llave actuales NO VERIFICADOS |
| Groq como respaldo | SET.2 lo conserva como respaldo y reporta fallo histórico de modelos GPT-OSS en modo Agent | N03 parcial y tareas económicas | El fallo es histórico y de una combinación concreta; catálogo/cuota actuales NO VERIFICADOS |
| Deepgram / ElevenLabs para voz | Radar identifica transcripción en tiempo real; Narrative histórica considera voz avanzada una dependencia del producto | N05 | No ensayados con voz/español del operador; costo, crédito y disponibilidad actuales NO VERIFICADOS |
| Terminal institucional con cómputo local | Oficio CECEQ solicita canalización a instituciones para evaluar capacidad local segura | N06 y eventualmente N03/N07 | Solicitud histórica; respuesta, hardware, permisos y continuidad NO VERIFICADOS |
| Estímulo público para licencias/créditos | Oficio CECEQ propone respaldo para PECDA/CONCYTEQ; identifica licencias y créditos como cuello de botella | N07 y proveedores especializados | No es recurso concedido; elegibilidad, calendario y monto pendientes |
| Programas, créditos y apoyos del Radar | Radar conserva oportunidades de infraestructura, modelos, voz, financiación y difusión sin presupuesto inicial | N03, N05, N07 | Beneficios publicados ≠ acceso concedido; cada vía requiere revalidación actual y compuerta |

## 3. Restricciones recuperadas

1. **Económica:** modelos de frontera y créditos de cómputo son un cuello de botella; existen referencias históricas a un tope aproximado de 50 USD/mes y a periodos de recursos muy limitados, pero el presupuesto actual debe confirmarse.
2. **Continuidad:** las cuentas de prueba y reinicios de cuota permiten trabajar, pero son una base estructuralmente frágil.
3. **Privacidad y seguridad:** el grafo personal puede contener material sensible; parte del procesamiento requiere evaluar ejecución local o servicios expresamente aprobados.
4. **Calidad:** el valor buscado no es “cualquier modelo”, sino comprensión robusta de matices, persistencia y uso confiable de herramientas.
5. **Portabilidad:** conviene separar necesidades de proveedor para poder cambiar de canal sin reconstruir el sistema.
6. **Operación:** ninguna llave se guarda en Git; una configuración histórica no acredita disponibilidad actual.
7. **Interfaz remota:** Remote Desktop Commander queda limitado a terminal o interfaz de línea de comandos no gráfica; interfaz gráfica solo con autorización específica y segundo monitor verificado.

## 4. Hipótesis de cartera, todavía no decisión

La necesidad probablemente no se resuelve con un solo modelo ni un solo canal. La cartera mínima a contrastar es:

- **Frontera interactiva:** comprensión, síntesis, diseño y continuidad de alto nivel.
- **Agente de código:** edición y pruebas con herramientas confiables.
- **Modelo económico/rápido:** tareas repetibles y alto volumen.
- **Voz:** transcripción en tiempo real y, si se justifica, síntesis/conversación.
- **Local/privado:** material sensible y operación resiliente sin exposición no aprobada.
- **Multimodelo:** contraste adversarial cuando la decisión lo merezca.

Esta segmentación es una hipótesis de trabajo; no autoriza proveedor, arquitectura, gasto ni tratamiento de datos.

## 5. Huecos que bloquean la comparación real

- Casos de uso priorizados y frecuencia/volumen por necesidad.
- Calidad mínima observable y pruebas comunes para N01–N07.
- Inventario actual de cuentas, planes, créditos, cuotas y vencimientos, sin revelar secretos.
- Presupuesto mensual sostenible y tolerancia a gasto variable.
- Clasificación de datos: qué puede salir a nube y qué exige procesamiento local.
- Equipo local/institucional realmente disponible y sus especificaciones.
- Disponibilidad regional y contractual actual desde México.
- Necesidad de contexto largo, navegación, conectores, herramientas y memoria por flujo.

## 6. Siguiente prueba autorizada

Construir una matriz de casos de uso con cinco campos: **resultado necesario · frecuencia/volumen · sensibilidad · calidad mínima · costo máximo**. Primero derivar borrador de las fuentes del workspace; preguntar al operador únicamente por los huecos materiales que no estén ya conservados. Después inventariar acceso actual y revalidar proveedores/precios con fuentes vigentes antes de recomendar.
