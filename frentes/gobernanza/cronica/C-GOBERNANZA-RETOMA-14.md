# C-GOBERNANZA-RETOMA-14 · Retoma y persistencia de fragmento · 2026-11-11

## Solicitud y alcance
El operador pidió conservar el fragmento conversacional suministrado y retomar el frente **Gobernanza** con continuidad. Se conserva el texto aportado literalmente; no se recibió un archivo de exportación integral, por lo que este asiento se clasifica como **fragmento aportado**, no como export completo.

## Contexto canónico adquirido
- Fuente normativa: `SeryMente/metodologia`, rama `main`.
- DUG: **Samantha v388 · NX-388m**; commit `3ba8e7373324c3dfbdf6d5d26f9da31e2418e71c`; blob `4db0ebadfd1e48b2bdec9236ba7f344921e4a865`.
- §ARR fue leído. Se reconoce como vocabulario de entrada, no como norma. Se revisó el GOW y la cascada del CNP pertinente.
- OCP: `frentes/gobernanza/`; su núcleo mantiene el sprint Sink local. No se modificaron el DUG, el GOW ni la IPZ nativa.
- El control de responsabilidad se leyó y la titularidad primaria pasó de generación 17 a 18. La corresponsable de generación 12 permanece; siguen siendo dos responsables activos como máximo. La escritura del control tuvo lectura de vuelta exacta.
- Sesión local: `SES-20261111-3B2EE800`; UUIDv7 local: `01a1cb34-fc9f-77c5-8bb7-e8933b2ee800`. Ciclo local: `C-GOBERNANZA-RETOMA-14-CY01`; UUIDv7 local del ciclo: `01a1cb34-fc9f-755b-b098-3daf07f9d800`. FOL1 continúa PREPARADO y NO ACTIVO; no se asignaron folios globales ni por OCP.

## Última salida visible del modelo en el fragmento fuente
> Se ha abierto Review a Device Call

Se conserva como salida visible literal aportada. Por sí sola no demuestra que se haya abierto la bóveda, que se haya leído una nota efímera ni que se haya ejecutado correctamente una operación RDC.

## Bóveda y variables B2
- La conversación fuente contiene un reporte previo de que `EP-Vault\\ep-env-vault.enc.json` existía y de que siete variables se habían detectado en una instancia anterior, pero no estaban cargadas en los ámbitos Process/User/Machine de la ejecución consultada. Es un antecedente, no una comprobación de esta retoma.
- En esta instancia, PC-8 aparece desconectado. No fue posible leer sus notas efímeras ni recuperar la contraseña de 12 caracteres.
- No se abrió la bóveda de Fila4 ni se intentó descifrarla. Las variables EP_B2_* y KHORA_B2_* siguen **NO VERIFICADAS** en esta instancia. No se expusieron secretos.

## Persistencia
- Fragmento aportado preservado bajo `documentos/originales/`.
- Diálogo A/B conservado en `conversaciones/`, con procedencia explícita para cada literal y sin folios FOL1.
- Esta crónica y su evidencia acompañan el registro. El manifiesto y README enlazan los artefactos.
- Estado del fragmento: **PERSISTIDO_Y_VERIFICADO** después de la lectura de vuelta exacta y cotejo de SHA.

## Siguiente acción atómica
Cuando PC-8 vuelva a estar en línea, recuperar la nota efímera por el canal autorizado sin mostrar la contraseña en el chat; después, con Fila4 conectado y perfil efectivo verificado, abrir la bóveda y comprobar la carga de variables sin imprimir sus valores. Hasta entonces, no declarar acceso B2.
