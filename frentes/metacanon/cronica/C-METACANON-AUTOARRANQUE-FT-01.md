# Crónica · C-METACANON-AUTOARRANQUE-FT-01

**Fecha:** 2026-10-29 · **Ciclo:** C-20261029-6A84D3F1 · **Frente:** Metacanon · **DUG rector:** Samantha v360 · NX-360m.
**Titular observado:** generación 6, folio SES-20261029-7F4A9C21. Control de responsabilidad leído antes de mutar; el titular de esta sesión y la generación coincidieron.

## Necesidad operativa

El operador rechazó que la prueba dependiera de dar al modelo el procedimiento completo. El requisito es que, al iniciar un frente, el modelo active el arranque por iniciativa propia y actúe como si el operador hubiese recordado el método, sin pedirle pegarlo cada vez. También solicitó enumerar los escenarios posibles de inicio.

## Decisión

Se adopta una cadena de tres capas:

1. **IPZ global** como disparador breve.
2. **Prompt universal y BCR** como procedimiento de adquisición y ejecución, sin ceremonia visible por defecto.
3. **DUG y OCP vivo** como autoridad normativa y estado del frente; el contexto transportado es solo auxiliar.

No se modificó el DUG ni el estado normativo de AT. El ciclo se limita al mecanismo de arranque y su cobertura operativa.

## Cambios guardados y releídos

| Artefacto | Blob SHA | Commit |
|---|---|---|
| `frentes/metacanon/entregas/CHATGPT-v0.4/IPZ-CAMPO-CHATGPT.txt` (1.266 caracteres) | `1c664c4d406dba69fa70ed518bfc76f23fa25963` | `82afc1efcf062d6c4638dc38fe6bd2ef9ae078a3` |
| `frentes/metacanon/entregas/CHATGPT-v0.4/MATRIZ-ESCENARIOS-INICIO-FT-v0.1.md` (16 escenarios) | `b7c4e792adeaf20ee3eb92707479ed5002f35b2d` | `89cf7a88fd0adc3c4f75f475780b88b40b4f0111` |
| `PROMPT-UNIVERSAL-REINSTANTANCIACION.md` | `23330e8a9802c2d984699c5c0d2603013335f310` | `c7d35b28f885d09207c0a12136cf8a572a6b8e90` |
| `BOOTSTRAP-CONTEXTO-GLOBAL.md` | `3fc9345a31e8c6ad2a44dc2c09e8b62b07e8668f` | `f9cd68080ebccac7b619d3ea3809727be324e8a1` |
| `INICIO.md` | `ab16d7e6aa986a9d086e034831ea1466df71ba83` | `fb753db8ff508318c6306e3e7850adea74d06052` |
| `CONTINUIDAD-ENTRE-CONVERSACIONES.md` | `0f2b7862d78716f15024bd929d5d3f3dc90626c0` | `e0441d294471e526703d417baa4b1fe60a3d60c9` |
| `frentes/metacanon/README.md` | `a51e07f93f65f598d67b7dbd6933a37487d337d9` | `71469151530caac9f5610be2d81bf64a6d52979b` |
| `frentes/metacanon/PENDIENTES.md` | `5cc0047cce669e85a6901cd2e8af9fb0e4e72d48` | `d165ba91fb7d2ab095d0343ba7b3e0e70e291d75` |
| `frentes/metacanon/entregas/CHATGPT-v0.4/C-METACANON-AUTOARRANQUE-FT-01-salida-final.md` (enlaces fuente portables) | `b1d35b28a64dd26e8cf83ecda8f8ecb4e5a776a3` | `a0fdb13b6f4abcb151e44f5395162f37ace28d4c` |
| `frentes/metacanon/conversaciones/C-METACANON-AUTOARRANQUE-FT-01-dialogo.jsonl` | `a733ddd4b7e2aa4e969386bfbaf0449d6378131c` | `e2c7212f0030250c7460b73e8b8bcce8cd394b5a` |

Cada uno de esos artefactos fue leído de vuelta y comparado con el contenido enviado a guardar. El folio de ciclo candidato `C-20261029-6A84D3F1` no apareció en el control vivo, el registro conversacional, el diálogo anterior ni el registro de fuentes consultados. Esto es un chequeo de colisión de alcance acotado, no certificación global.

## Matriz de cobertura

Se registraron 16 escenarios: chats normales nuevos y existentes; inicio de frente sin nombrar la metodología; retoma con adjuntos; chat temporal personalizado y no personalizado; Proyectos con o sin disparador local; GPT personalizado; voz/dictado y cambio de dispositivo; otro repositorio gobernado por el DUG; consulta ajena al método; pérdida de acceso a main; colisión de titularidad; API/IDE/otro proveedor; personalización desactivada/cambio de cuenta. Las excepciones que no pueden cubrirse solo desde IPZ quedan separadas de los fallos seguros.

## Estado real al cierre

- **Implementación documental:** completada y releída de vuelta.
- **IPZ nativa de ChatGPT:** no instalada ni verificada desde estas herramientas.
- **Prueba semántica en un chat realmente nuevo:** pendiente.
- **AT:** sin cambio normativo.
- **No se declara:** sincronización automática, universalidad de obediencia, instalación de ajustes nativos ni validación semántica por haber pasado comprobaciones mecánicas.

Referencias oficiales consultadas el 2026-10-29:
- Instrucciones personalizadas y ausencia de API para su campo: https://help.openai.com/es-es/articles/8096356-chatgpt-custom-instructions
- Precedencia de las instrucciones de Proyecto: https://help.openai.com/es-es/articles/10169521-using-projects-in-chatgpt
- Chat temporal personalizado: https://help.openai.com/es-es/articles/8914046-chat-temporal-en-chatgpt
- GPTs personalizados y sus instrucciones propias: https://help.openai.com/en/articles/8554407-gpts-in-chatgpt
