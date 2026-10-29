# Matriz de escenarios de arranque automático de FT/FDT

**Corte:** 2026-10-29 · **Versión:** 0.1 · **Propósito:** evitar que el operador tenga que recordar o volver a pegar el procedimiento al iniciar cada frente.

## Diseño de mecanismo

1. **IPZ global (disparador):** reconoce que la petición abre, retoma, cambia o asume un frente y arranca el bootstrap sin pedir permiso para activar el método.
2. **Prompt universal (procedimiento):** especifica las lecturas, el control del frente, la trazabilidad y las comprobaciones. El modelo lo adquiere desde `main`; el operador no lo pega en cada conversación.
3. **DUG integrado (autoridad):** fija las reglas y el glosario vigentes. El prompt, la IPZ, la memoria y los adjuntos no son autoridad paralela.
4. **OCP del frente (estado operativo):** determina titularidad, estado, pendientes, último resultado y siguiente acción autorizada.
5. **Salida visible mínima:** no reproducir la metodología ni enumerar una checklist a modo de preámbulo. Comunicar solo lo material: estado verificado, bloqueo real y la acción que se está ejecutando o sigue pendiente.

La IPZ propuesta contiene **1266 caracteres**. Se mantiene por debajo del límite de 1.500 caracteres que OpenAI documenta para Free/Go; la misma formulación también cabe en el límite mayor de los planes que lo admiten.

## Matriz de entrada

| # | Escenario de inicio | ¿Arranca automáticamente? | Regla de cobertura |
|---:|---|---|---|
| 1 | Chat normal nuevo, personalización activada | **Sí**, tras instalar la IPZ una sola vez | Activar el bootstrap antes de actuar sobre la primera petición del frente. |
| 2 | Conversación existente en la que se abre un frente distinto | **Sí**, tras instalar la IPZ | Detectar el cambio de alcance; no exigir frase clave ni reiniciar otros frentes sin necesidad. |
| 3 | Chat nuevo cuyo primer mensaje ya pide una tarea concreta de un frente, sin mencionar la metodología | **Sí**, si el contexto permite clasificarlo | Inferir el FT/FDT a partir de la tarea y las fuentes reales; no solicitar el prompt. |
| 4 | Retoma del mismo frente en hilo nuevo con checkpoint/adjuntos | **Sí** | Usar adjuntos para continuidad, pero volver a cotejar el canon y el estado vivo en `main`; no tratar el paquete como autoridad. |
| 5 | Chat temporal personalizado | **Sí**, si están activas las instrucciones personalizadas al iniciarlo | La documentación oficial indica que un chat temporal personalizado puede usar instrucciones personalizadas. |
| 6 | Chat temporal sin personalización | **No** | Las instrucciones personalizadas están desactivadas en ese chat. No usar este modo para una retoma sin introducir un mecanismo de arranque equivalente. |
| 7 | Chat dentro de un Proyecto con instrucciones que no mencionan el bootstrap | **No garantizado** | Las instrucciones del Proyecto tienen precedencia sobre las personalizadas globales. Añadir el mismo disparador a las instrucciones del Proyecto. |
| 8 | Chat dentro de un Proyecto con disparador equivalente en sus instrucciones | **Sí**, tras configurar ese Proyecto una sola vez | Mantener el disparador breve y los enlaces a la misma fuente canónica; no copiar el DUG completo como fuente paralela. |
| 9 | Conversación con un GPT personalizado | **No por la IPZ global** | Los GPT personalizados no usan instrucciones personalizadas globales. Su configuración propia debe incorporar el disparador si se siguen usando para frentes. |
| 10 | Voz/dictado o cambio entre web, escritorio y móvil en un chat normal | **Sí**, con la misma cuenta y personalización activa | Es la misma conversación/configuración; validar que la personalización no esté deshabilitada. |
| 11 | Inicio de trabajo en otro repositorio, pero bajo un FT/FDT gobernado por la metodología | **Sí** | Cargar el DUG global y luego descubrir el OCP real en el repositorio destino; no suponer que vive bajo una ruta única. |
| 12 | Petición cotidiana que no crea, retoma ni modifica un FT/FDT | **No se ejecuta el bootstrap** | Evitar contaminación de consultas ajenas al ámbito metodológico. |
| 13 | La fuente canónica o sus permisos no son accesibles | **Arranque intentado, no verificado** | Declarar `METODOLOGÍA NO VERIFICADA`; no presentar memoria/adjuntos como vigentes ni hacer cambios que dependan de una revisión no comprobada. |
| 14 | El control del frente revela otro titular activo o una generación divergente | **Sí para lectura; escritura bloqueada** | Preguntar una vez por la transferencia concreta; no apropiarse del frente ni escribir a ciegas. |
| 15 | API, otro modelo/proveedor, IDE/Codex u otra aplicación fuera de la conversación normal de ChatGPT | **No por la IPZ de ChatGPT** | Requiere configurar un disparador equivalente en el system prompt, instrucciones del proyecto o configuración de ese entorno. |
| 16 | IPZ deshabilitada, reemplazada o la cuenta cambia | **No garantizado** | La configuración es por cuenta; confirmar la personalización activada y volver a instalar la IPZ canónica si se perdió. |

## Cómputo de cobertura

Este es un **cómputo de escenarios operativos**, no una probabilidad estadística:

- **6 escenarios cubiertos por la IPZ global** en chats normales/personales: 1–5 y 10, con el ajuste de que el chat temporal solo cuenta si está personalizado. El cambio de frente dentro de un hilo también queda cubierto por el escenario 2.
- **2 escenarios cubiertos después de una configuración adicional por superficie:** Proyectos y GPTs (7–9; el disparador se instala una sola vez en cada configuración relevante).
- **2 escenarios de bloqueo seguro:** fuente inaccesible y titularidad incompatible (13–14). El bootstrap detecta el impedimento, pero no debe simular éxito ni eludir permisos.
- **2 escenarios fuera del alcance nativo de la IPZ:** API/otro entorno y despersonalización/cambio de cuenta (15–16).
- **1 escenario en el que el bootstrap se omite intencionalmente:** tarea ajena al sistema (12).

La cobertura no se considera aceptada hasta instalar la IPZ nativa y observar una primera conversación realmente nueva que arranque a partir de una petición de trabajo corriente, **sin pegar la IPZ ni mencionar DUG, Metacanon, GOW o el prompt**.

## Activación única pendiente

El repositorio no puede escribir el campo nativo de Instrucciones Personalizadas ni comprobarlo por una API. La acción final del operador es pegar el contenido de `IPZ-CAMPO-CHATGPT.txt` en **Configuración → Personalización → Instrucciones personalizadas**, con la personalización activada. No es una instrucción que deba repetirse en cada frente.

## Referencias oficiales comprobadas el 2026-10-29

- Instrucciones personalizadas, activación, aplicación general, límites de caracteres y ausencia de API: https://help.openai.com/es-es/articles/8096356-chatgpt-custom-instructions
- Instrucciones de Proyectos y precedencia frente a las globales: https://help.openai.com/es-es/articles/10169521-using-projects-in-chatgpt
- Chat temporal personalizado o sin personalización: https://help.openai.com/es-es/articles/8914046-chat-temporal-en-chatgpt
- GPTs personalizados: no usan memoria ni instrucciones personalizadas globales; cada conversación parte de cero: https://help.openai.com/en/articles/8554407-gpts-in-chatgpt
