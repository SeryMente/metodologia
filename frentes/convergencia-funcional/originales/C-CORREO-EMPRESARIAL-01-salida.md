**La solución técnica es un nombre de dominio —o subdominio autorizado— para Khora y un buzón real que permita enviar y recibir. No hace falta esperar al `.com`.**

Una opción concreta para el buzón es **Zoho Mail Free**: publica correo con dominio propio, hasta cinco usuarios y acceso desde su web. **Solo está disponible en determinadas regiones/centros de datos**; debemos comprobar que nos ofrezca el plan gratuito, no confundirlo con una prueba temporal.[^https://www.zoho.com/mail/help/adminconsole/subscription.html]

Para ponerlo operativo, la secuencia sería:

1. **Obtener control legítimo de un dominio o subdominio sin coste**, por cesión autorizada o un proveedor gratuito. Zoho no regala ese registro. FreeDNS ofrece subdominios compartidos, pero dependen de un dominio de terceros; es una posibilidad por verificar, no una identidad empresarial estable ya resuelta.[^https://freedns.afraid.org/][^https://freedns.afraid.org/faq/]
2. **Verificar ese nombre en Zoho y configurar los registros de recepción y autenticación del correo.** Necesitamos permiso para modificar su configuración; no basta con inventar una dirección.[^https://www.zoho.com/mail/help/adminconsole/domain-verification.html]
3. **Crear el buzón y comprobar envío y recepción.** Solo entonces lo llamaríamos operativo.

**Hay dos verificaciones distintas:** que el correo funcione y que Notion acepte esa identidad de empresa. No tengo confirmada la aceptación de subdominios gratuitos por Notion, así que no te prometeré que esta combinación satisface automáticamente el requisito.

En concreto: **tenemos un candidato gratuito para el buzón; todavía falta validar un dominio/subdominio gratuito utilizable y su aceptación por Notion.** Ese es el hueco que debemos resolver, sin comprar el `.com` ahora ni usar un correo desechable para aparentar cumplimiento.

Ruta y límites guardados en el [objeto canónico · C-CORREO-EMPRESARIAL-01](https://github.com/SeryMente/metodologia/blob/docs/sprint-convergencia-funcional-20261017/frentes/convergencia-funcional/SPRINT.md). No creé cuentas ni cambié configuraciones.
