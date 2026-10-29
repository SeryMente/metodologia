# Salida final · C-METACANON-ARRANQUE-360-01

**Fecha local:** 2026-10-29 (America/Mexico_City).  
**Frente:** Metacanon.  
**Ciclo:** `C-20261029-7F4A9C21`.  
**Fuente normativa:** `SeryMente/metodologia/main`; DUG Samantha v360 · NX-360m, Metacanon 1.24, GOW v2.9 (111 términos), taxonomía 1.3.  
**Estado:** arranque documental común implementado y relevo de titularidad verificado; IPZ nativa y prueba semántica en conversación nueva pendientes.

## 1. Decisión y alcance

El objetivo es pasar del diseño de Gestión conversacional y del asunto AT a una aplicación que haga que la siguiente conversación de cualquier frente arranque consultando la metodología vigente antes de resolver tareas. Para reducir la dependencia de la memoria conversacional, se reparó la cadena documental de arranque, se restauró el prompt universal que estaba enlazado pero no existía en `main`, se reconciliaron las referencias del bootstrap con el DUG integrado y se actualizó la IPZ candidata.

**Esto no equivale aún a garantizar comportamiento universal.** El archivo IPZ no puede instalarse ni leerse de vuelta mediante los conectores de esta ejecución, y todavía no se ha hecho una prueba semántica en una conversación realmente nueva. La cadena de documentos pasa la revisión mecánica descrita más abajo; su aceptación operativa final depende de esos dos pasos.

AT no se ratifica ni modifica en este ciclo.

## 2. Titularidad transferida

- **Autorización literal recibida:** `Si`, en respuesta a la pregunta directa sobre asumir el frente Metacanon y sustituir la titularidad registrada.
- **Titular anterior:** `chatgpt-C-METACANON-REINSTANTANCIACION-M27-SES-20261028-8D7A31C2`, generación 5, folio `SES-20261028-8D7A31C2`.
- **Titular nuevo (alias operativo):** `chatgpt-C-METACANON-ARRANQUE-360-SES-20261029-7F4A9C21`, generación 6, folio `SES-20261029-7F4A9C21`.
- **Control anterior observado:** `0eaf612b01de0ae630b7a4775849be455ebda6c8`.
- **Control posterior leído de vuelta:** `86f0e4fa59e37976704231290b460cf6dc9252b0`.
- **Commit de transferencia:** [`4cb58ba1927d858d2c3cffd5f8376c15fee402c4`](https://github.com/SeryMente/metodologia/commit/4cb58ba1927d858d2c3cffd5f8376c15fee402c4).

La comparación contra el SHA observado, el incremento de generación, la conservación del titular anterior y la lectura de vuelta quedaron verificados. El alias no es un ID nativo de ChatGPT. El control es una salvaguarda cooperativa, no una exclusión server-side de escritores que lo eludan. La búsqueda de colisiones cubrió el control de Metacanon y cuatro controles hermanos accesibles; no certifica unicidad global.

## 3. Artefactos actualizados o creados

| Artefacto | Resultado leído de vuelta |
|---|---|
| `PROMPT-UNIVERSAL-REINSTANTANCIACION.md` | Creado en la raíz; blob `7ef052146416add46260cf9d51eaa34c2fa83caa`; commit `723c048cf14a957a91e78d5a7d76112a53f5559f`. |
| `BOOTSTRAP-CONTEXTO-GLOBAL.md` | Reconciliado con el DUG integrado y con la puerta común de ART-024; blob `d5e7bca9225fb040d73ebbeca52e36c8637d3afd`. |
| `frentes/metacanon/entregas/CHATGPT-v0.3/IPZ-CAMPO-CHATGPT.txt` | Candidato actualizado, 1.365 caracteres; blob `7400b5109987bcf81301861b666715bf53636468`. |
| `INICIO.md` | Apunta explícitamente al prompt universal y al BCR y declara los límites de instalación/prueba; blob `345d2b383f07c762afbdcc2dc567ce27451aa6e5`. |
| `README.md` | Índice raíz reconciliado con el DUG v360 integrado; blob `181862468cf99bca8609b6cd38b5758ec2dcb566`. |
| `CONTINUIDAD-ENTRE-CONVERSACIONES.md` | Delegación de arranque actualizada; blob `b3d9c1494b631e83cacecc2b6f60f085a4ba657a`. |
| `frentes/metacanon/README.md` | Índice del frente actualizado a DUG v360/GOW 2.9 y enlazado al ciclo; blob `31d683aaf3df9e25af47d9ff0921950711d4a85c`. |
| `frentes/metacanon/PENDIENTES.md` | CONT-02 actualizado a implementación documental con prueba semántica e IPZ nativa pendientes; blob `761d6c79b2d577728cf962e4a58ee091abb30eac`. |
| Registro conversacional | Se conservó el UUIDv7 local existente y se actualizó el último folio; blob `62bf29733441928392348aa3f26138cf94c2985e`. |
| Fuentes verbatim de origen | Solicitud actual y autorización registradas con procedencia y sin inventar IDs nativos; blob `ed1c597a84e6f575d7c61caee5ee9aca234c46e1`. |
| Trazabilidad semántica | Vinculados requisito y autorización con sus resultados, estados y referencias; blob `e225feedb255695f81ed95fc89a64c5b92b15235`. |

La fuente normativa se mantiene en el DUG HTML único; no se crean fuentes normativas paralelas ni se presume una sincronización automática.

## 4. Verificación mecánica

**Resultado: 9/9 controles documentales PASS.**

1. DUG adquirido: Samantha v360 · NX-360m, blob `3cda9d38db1bee76ff0ca752f3ecde8719c70d41`.
2. Prompt universal presente y leído de vuelta.
3. BCR enlaza al DUG integrado y ya no contiene los antiguos enlaces canónicos Markdown de Sam, Metacanon y GOW.
4. IPZ candidata con ART-024 y referencia al prompt universal; longitud 1.365 caracteres.
5. INICIO enlaza prompt y BCR y expone la limitación de IPZ/prueba semántica.
6. README raíz refleja DUG v360 y GOW v2.9.
7. Puntero de continuidad remite al prompt y al BCR.
8. Control de titularidad leído de vuelta: generación 6, folio correcto y autorización literal `Si`.
9. Estado de AT conservado sin ratificación implícita.

La prueba valida archivos y enlaces, no interpretación por un modelo independiente.

## 5. Paso operativo que falta

### A. Instalar la IPZ candidata

En ChatGPT de escritorio/web, abre **Configuración → Personalización → Instrucciones personalizadas**, activa la personalización y reemplaza el texto por el contenido exacto que sigue. Guarda los cambios.

La IPZ tiene 1.365 caracteres. El Centro de ayuda de OpenAI indica que se encuentra en Configuración → Personalización en web/escritorio, y que los cambios se aplican a todos los chats; el límite documentado es de 1.500 caracteres para Free/Go y de 5.000 para Plus, Pro, Enterprise, Business y Education: https://help.openai.com/es-es/articles/8096356-chatgpt-custom-instructions. Estas instrucciones no son una garantía de cumplimiento perfecto; deben probarse en operación.

### B. Probar en una conversación realmente nueva

Después de guardar la IPZ, abre un hilo nuevo y solicita:

> Inicia el frente que voy a trabajar siguiendo `INICIO.md`, el prompt universal y el BCR. Comprueba en `SeryMente/metodologia/main` el DUG y el GOW vigentes; después localiza el OCP, su núcleo/README, control de responsabilidad y pendientes. Emite el recibo de arranque con fuentes, versiones, SHA, titular/generación/folio, último resultado realmente persistido y bloqueos. Aplica ART-024 dentro de las capacidades disponibles. No supongas que la configuración está aplicada ni declares captura automática; identifica cualquier dato que no puedas verificar.

Considera esa prueba **aprobada solo si** el hilo independiente recupera y coteja los recursos canónicos actuales, identifica el frente antes de operar, respeta el control de responsabilidad, distingue lo verificado de lo pendiente y no inventa persistencia ni sincronización. Guarda los resultados; un PASS mecánico no cierra CONT-01/CONT-02.

## 6. IPZ exacta para copiar

```text
En cualquier FT/FDT, prevalece SeryMente/metodologia/main. Lee INICIO.md, DUG vigente y OCP/control del frente. Sin cotejo de main: METODOLOGÍA NO VERIFICADA.
DUG/Sam (última revisión observada v360 · NX-360m; coteja main): https://github.com/SeryMente/metodologia/blob/main/gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P001
Metacanon: https://github.com/SeryMente/metodologia/blob/main/gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#metacanon
GOW: https://github.com/SeryMente/metodologia/blob/main/gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#glosario
Prompt universal: https://github.com/SeryMente/metodologia/blob/main/PROMPT-UNIVERSAL-REINSTANTANCIACION.md
Aplica ART-024: conserva literalmente entradas/salidas visibles disponibles con procedencia; usa folio/UUIDv7 local cuando proceda; enlaza instrucciones pertinentes con resultados y estado de verificación. No afirmes captura automática, ID nativo ni sincronización no verificada.
Antes de escribir, identifica OCP/núcleo/README/control/pendientes y verifica titular/generación. Si hay otro titular, pregunta una vez; transfiere solo con autorización expresa, SHA/generación coincidentes y lectura de vuelta. Preserva rutas heredadas; no dupliques controles.
Distingue propuesto, autorizado, intentado, ejecutado, verificado y aceptado. Revisa GOW al inicio/cierre de cada ciclo. MCP normativo DESACTIVADO.
```

## 7. Estado de cierre

- **Titularidad de Metacanon:** TRANSFERIDA Y VERIFICADA, generación 6.
- **Arranque documental común:** IMPLEMENTADO Y LEÍDO DE VUELTA.
- **IPZ candidata:** ACTUALIZADA Y DENTRO DEL LÍMITE CONSERVADOR DE 1.500 CARACTERES.
- **IPZ nativa:** PENDIENTE DE PEGADO/GUARDADO Y CONFIRMACIÓN.
- **Prueba semántica en conversación realmente nueva:** PENDIENTE.
- **Gestión conversacional:** contrato normativo ART-024 y materialización inicial ya existentes; este ciclo los conecta a la nueva cadena de arranque.
- **AT:** sin cambio de estado normativo en este ciclo.
- **Regreso al trabajo de tareas:** después de guardar la IPZ y hacer la prueba independiente, cerrar o documentar sus fallos; luego continuar con Tareas.

No se afirma que todas las conversaciones futuras ya estén arrancando con el DUG actualizado hasta que la IPZ esté instalada y la prueba independiente dé evidencia suficiente.
