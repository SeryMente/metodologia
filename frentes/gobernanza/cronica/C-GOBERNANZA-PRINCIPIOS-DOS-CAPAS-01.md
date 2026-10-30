# C-GOBERNANZA-PRINCIPIOS-DOS-CAPAS-01 · Estrategia de dos capas de consulta y telemetría de principios

**Fecha:** 2026-10-30. **Estado:** diseño documental materializado y verificado; infraestructura Sink pendiente de provisión y prueba.

## Autorización y control

El operador autorizó expresamente crear ART-027, incorporar un inventario compacto de los 43 principios y documentar la consulta individual mediante Sink, distinguiendo consideración, selección, consulta y aplicación. La autorización se añadió al control de responsabilidad del frente Gobernanza, preservando el titular operativo y generación 6. El control se releyó: titular `chatgpt-C-GOBERNANZA-RETOMA-05-SES-20261030-GV89CFA5D5`, instancia `chatgpt-gobernanza-retoma-2026-10-30-GV89CFA5D5`, generación 6, blob SHA `e0cc42a4c7f3ab351d733dc0689cbe355d3ec9f9`.

## Línea base y modificación canónica

- DUG anterior: v369 · NX-369m; blob previo observado `ea1eefd62a092079fa2cfdfa546cb739b63450eb`.
- DUG final: **v370 · NX-370m**, evento `C-GOBERNANZA-PRINCIPIOS-DOS-CAPAS-01`.
- Commit final de alineación visual y versión: `f91b0e6cc1c78730bcf642420c638afc802c0dac`.
- Blob final leído de vuelta: `c016e442be13ad0c28e6f4a467b1ea79ffb70574`.
- Representación estructurada parseada: 43 principios, 20 anexos, ART-027 presente; 43 entradas de catálogo y 43 aliases lógicos especificados; cero enlaces directos al ancla desde el catálogo.
- ART-027 quedó enlazado desde la sección humana con el ancla `#estrategia-dos-capas-principios` y el identificador `[[A:ART-027]]`.

## Diseño materializado

La primera capa contiene, para cada principio P001–P043, su identificador, nombre canónico y una abstracción general de una sola frase. No duplica el texto normativo desarrollado.

La segunda capa define un alias Sink determinista `p001`…`p043`, exclusivo por principio y asociado a su ancla canónica `#Pxxx`. Los aliases están definidos en ART-027, pero no son URLs activas; no se inventaron host ni redirecciones. El catálogo y el mapa no contienen enlaces directos alternativos a los anclajes Pxxx: la consulta individual contable debe comenzar por Sink.

El protocolo por ciclo exige adquirir el DUG completo, considerar el catálogo de 43, seleccionar el subconjunto contextual, acceder al alias Sink de cada principio seleccionado, recuperar su texto desarrollado desde una ruta autenticada del DUG, y registrar por separado los estados considerado/seleccionado/consultado/aplicado. Un clic no prueba aplicación. El conteo de aplicaciones procede del arreglo `applied[]` en los registros de ciclo de ART-024; Sink mide navegación/consulta y sus estadísticas pueden ser aproximadas o muestreadas.

## Dependencias identificadas

1. Fork de Sink bajo control del titular y repositorio conectado a Cloudflare Workers Builds.
2. Cloudflare Worker, D1 (`DB`), KV (`KV`) y Analytics Engine (`ANALYTICS`, recomendado).
3. Variables de despliegue `DEPLOY_D1_DATABASE_ID` y `DEPLOY_KV_NAMESPACE_ID`.
4. Secretos protegidos `NUXT_SITE_TOKEN` y `NUXT_CF_API_TOKEN`; variable `NUXT_CF_ACCOUNT_ID`. Ninguna credencial se incorpora a Git.
5. API REST de Sink autenticada con Bearer; alta idempotente y validación de 43 aliases.
6. Resolución privada del DUG: GitHub sigue privado; el redirect Sink no autentica por sí mismo en GitHub.
7. Prueba de que el modelo puede abrir el alias y recuperar el principio exacto; si el visor GitHub no ejecuta el renderizador de anclas, deberá construirse un resolvedor privado autenticado, limitado a lectura del DUG y a IDs Pxxx.
8. Integración del bloque `principle_usage` en el registro de ciclo de ART-024 y agregación separada de consultas y aplicaciones.
9. Pruebas E2E y negativas de redirección, privacidad, autenticación, cambio de revisión, duplicados, bots y read-back.

## Bloqueos observados en este ciclo

- No hay herramienta/conector Cloudflare disponible en esta sesión ni recursos de la cuenta Cloudflare inspeccionables.
- La búsqueda del directorio de plugins no encontró una integración Cloudflare utilizable.
- No se proporcionaron ni se verificaron los recursos D1/KV/Analytics Engine ni secretos necesarios.
- No existe herramienta GitHub disponible para crear el fork de Sink en esta sesión.
- No se desplegó Sink y no se crearon enlaces cortos reales.
- La privacidad del destino no está resuelta por el simple redirect; el repositorio no se hizo público.
- No se ejecutó un navegador con renderizado del DUG, ni pruebas de los anchors dinámicos P001–P043.
- No se creó aún un proceso de agregación sobre registros ART-024; la especificación del bloque de ciclo sí está documentada en ART-027.

## Verificación y límites

Se ejecutó lectura de vuelta del archivo canónico y se parseó `gov-data`. Se verificaron v370/NX-370m, 43 principios, 20 anexos, existencia de ART-027, 43 filas de abstracción y 43 aliases lógicos. La salida visible de título, indicador y footer coincide con v370.

No se declara aceptación funcional de la estrategia ni telemetría en vivo. Los enlaces Sink, el Worker, el acceso privado del modelo y las estadísticas reales permanecen PENDIENTES. FOL1 sigue `PREPARADO_PENDIENTE_ACTIVACION_IPZ`; no se asignaron folios globales ni por OCP a este evento. ART-025, IPZ candidata y campo nativo permanecen sin modificación.
