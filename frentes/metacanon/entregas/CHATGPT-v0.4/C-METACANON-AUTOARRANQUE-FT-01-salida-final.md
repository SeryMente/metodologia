# Arranque automático de frentes: implementación y cobertura

El cambio clave es pasar de un prompt que se pega por conversación a un **disparador global que inicia la carga por sí mismo**. La cadena documental ya quedó ajustada y verificada mediante lectura de vuelta; la activación en los ajustes nativos de ChatGPT y la prueba semántica en un hilo nuevo siguen pendientes.

## IPZ candidata v0.4

[**Abrir la IPZ exacta para copiar (1.266 caracteres)**](https://github.com/SeryMente/metodologia/blob/main/frentes/metacanon/entregas/CHATGPT-v0.4/IPZ-CAMPO-CHATGPT.txt)

El texto guardado es:

```text
Al detectar una petición que abre, retoma, cambia o asume un frente FT/FDT gobernado por Ser y Mente/Metodología, ejecuta tú el arranque antes de trabajar: no esperes a que lo pida ni me solicites pegar un prompt. Consulta en main INICIO.md, el DUG integrado (incluye Metacanon y GOW), el prompt universal y después el OCP/control/estado del frente concreto. Canon: https://github.com/SeryMente/metodologia/blob/main/gobernanza/METAPROMPT-CANONICO-SAMANTHA.html
Entrada: https://github.com/SeryMente/metodologia/blob/main/INICIO.md
Procedimiento: https://github.com/SeryMente/metodologia/blob/main/PROMPT-UNIVERSAL-REINSTANTANCIACION.md
Haz la preparación sin ceremonia ni checklist visible; actúa sobre mi petición y comunica solo el estado comprobado, un bloqueo real o la siguiente acción necesaria. Verifica la fuente y la responsabilidad antes de escribir; si hay conflicto real de titularidad, pregunta una sola vez. Si main no puede verificarse, declara METODOLOGÍA NO VERIFICADA y limita cambios dependientes. No simules lectura, ejecución, persistencia ni sincronización. Si no es un frente de este sistema, no impongas el protocolo. En Proyectos/GPTs con instrucciones propias, replica allí el disparador; un chat temporal sin personalización no lo recibe.
```

## Cambios guardados en main

- [IPZ v0.4](https://github.com/SeryMente/metodologia/blob/main/frentes/metacanon/entregas/CHATGPT-v0.4/IPZ-CAMPO-CHATGPT.txt) · 1.266 caracteres · blob `1c664c4d406dba69fa70ed518bfc76f23fa25963`.
- [Prompt universal](https://github.com/SeryMente/metodologia/blob/main/PROMPT-UNIVERSAL-REINSTANTANCIACION.md) · ahora identifica el disparador como automático y evita exhibir todo el procedimiento como preámbulo · blob `23330e8a9802c2d984699c5c0d2603013335f310`.
- [BCR](https://github.com/SeryMente/metodologia/blob/main/BOOTSTRAP-CONTEXTO-GLOBAL.md) · convierte la instrucción literal, la interpretación y el checklist en material interno por defecto; solo los expone si se solicita o hace falta por una decisión material · blob `3fc9345a31e8c6ad2a44dc2c09e8b62b07e8668f`.
- [INICIO.md](https://github.com/SeryMente/metodologia/blob/main/INICIO.md), [continuidad](https://github.com/SeryMente/metodologia/blob/main/CONTINUIDAD-ENTRE-CONVERSACIONES.md), [README del frente](https://github.com/SeryMente/metodologia/blob/main/frentes/metacanon/README.md) y [pendientes](https://github.com/SeryMente/metodologia/blob/main/frentes/metacanon/PENDIENTES.md) enlazados a la nueva cadena y al estado real.

## Escenarios de entrada

La [matriz de escenarios v0.1](https://github.com/SeryMente/metodologia/blob/main/frentes/metacanon/entregas/CHATGPT-v0.4/MATRIZ-ESCENARIOS-INICIO-FT-v0.1.md) contiene **16 escenarios prácticos**. Los límites importantes son:

- Chat normal personalizado, inicio de frente dentro de una conversación existente, voz/dictado y chat temporal personalizado: cobertura prevista después de instalar la IPZ.
- Proyectos de ChatGPT con instrucciones propias: hay que incorporar allí el mismo disparador, porque las instrucciones del Proyecto tienen precedencia sobre las globales. Los GPT personalizados no consumen las instrucciones personalizadas globales; requieren configurar sus propias instrucciones. Un chat temporal sin personalización no recibe la IPZ. 
- API, Codex/IDE y otros proveedores: la IPZ de ChatGPT no se propaga; necesitan su configuración de instrucciones equivalente.
- Sin acceso comprobable a `main`: declarar `METODOLOGÍA NO VERIFICADA`. Si hay titular incompatible, bloquear escrituras y preguntar una vez. Si la tarea no abre ni retoma un frente de este sistema, no forzar el bootstrap.

## Única activación pendiente

No puedo escribir el campo nativo de Instrucciones Personalizadas a través de la integración de repositorio; OpenAI documenta que no ofrece una API para ese campo ([Centro de ayuda](https://help.openai.com/es-es/articles/8096356-chatgpt-custom-instructions)). 

Una única vez: abre **Configuración → Personalización → Instrucciones personalizadas**, verifica que la personalización esté activada, reemplaza el campo con la IPZ anterior y guarda. Después no tendrás que pegar ese prompt por frente; el mecanismo debe arrancar al detectar la tarea.

**Prueba de aceptación pendiente:** abre un chat normal nuevo y formula tu tarea real sin mencionar el DUG, Metacanon, GOW ni el prompt. Solo entonces podrá comprobarse si el disparador provoca la lectura actual de `INICIO.md`, el DUG y el OCP correcto sin que tú dictes el procedimiento. No marco esa prueba ni la instalación como realizadas.

