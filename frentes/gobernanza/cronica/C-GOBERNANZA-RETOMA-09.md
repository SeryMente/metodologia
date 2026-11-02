# C-GOBERNANZA-RETOMA-09 · Retoma de titularidad y continuidad DTC

**Fecha:** 2026-11-01
**Frente/OCP:** frentes/gobernanza/ · SeryMente/metodologia · main
**Estado:** TRANSFERENCIA_VERIFICADA_READBACK · PERSISTENCIA_DEL_EXPORT_PENDIENTE · DTC_EN_CURSO

## 1. Instrucción y autorización

El operador solicitó incorporar el export ChatGPT-GOBERNANZA-1-20261101-1717.md a la persistencia documental de Gobernanza y retomar la responsabilidad del frente. La solicitud autoriza el relevo de titularidad en el OCP de Gobernanza; se conserva intacto el asiento corresponsable vigente. No autoriza cambios normativos al DUG, IPZ nativa, FOL1, ni mutaciones a controles/código/hosts de EP o MCP-OCP.

## 2. Transferencia de titularidad

- Control anterior observado: generación 12, blob 8ac857342d5a01a8f4bb160f1cbdb2298f9cbc41.
- Titular anterior: SES-20261101-GV8A19904, generación 11; queda supersedido.
- Nuevo titular: Gobernanza 1, SES-20261101-GVCD93ADD7, generación 13.
- Alias: chatgpt-C-GOBERNANZA-1-20261101-1717-SES-20261101-GVCD93ADD7.
- Instancia: chatgpt-gobernanza-1-2026-11-01-CD93ADD7.
- UUIDv7 local: 01a199c3-a374-7e1f-8191-1ff6cd93add7; no es un ID nativo de ChatGPT.
- Corresponsable conservada: SES-20261101-GV8E89D1FF, generación 12.
- Roster final: dos responsables activos, máximo dos.
- Commit de transferencia: 57ca88a8f19908d1dc110428249116403a85ef61.
- Commit de confirmación/read-back: 404c49cede3a19afcc0df28a5a58e2f404dbf1fb.
- Blob final de CONTROL-RESPONSABILIDAD.json: 960fefdca26c841c3a2d06ebb57a2e836b6f8d73.
- Verificación: generación 13, folio/alias/UUID y corresponsable preservada; read-back PASS.

El folio de sesión es local. No se asignó folio global de conversación, ciclo, A o B porque FOL1 sigue inactivo.

## 3. Captura documental solicitada

Archivo: ChatGPT-GOBERNANZA-1-20261101-1717.md.

- Fuente RDC observada: PC-8, Downloads.
- Tamaño informado por el sistema de archivos: 93.402 bytes.
- Última modificación/exportación del archivo: 2026-11-01 17:17:53 (hora local mostrada por el host).
- SHA-256 calculado en PC-8: 703542FC7CB57785AA352A2020D940037C1C47CA2C2C37C13B26B9BA7F71D8C8.
- ID de conversación citado en el enlace del export: 6ae7acb7-95a8-83e8-a417-64a48c91ce65; se registra solo como metadato del export.
- Lectura RDC inicial: se recuperaron dos fragmentos que cubren 1.852 líneas; la identidad/fecha del export y el SHA de origen fueron observados.
- Persistencia en Git: PENDIENTE. PC-8 pasó a Offline antes de recuperar/cotejar el contenido íntegro y escribir el original.
- El archivo no se añadió a documentos/originales ni al MANIFIESTO-DOCUMENTAL.json. No se declara adjuntado ni persistido.

## 4. DTC y backlog integrado

### EP

EP dejó una petición material en el objeto DTC del ciclo local C-EP-MOD-SCRIPTPWS-20261101-03: ampliar la persistencia para incluir el estado/datasets operativos del propio MCP-OCP, no solo documentos versionados. La petición se respondió en el mismo objeto, sin abrir otro canal.

- Blob de EP leído antes de responder: ce7e80aef47224f83c7e82892c44473b30bdf9db.
- Commit de respuesta de Gobernanza: 51614cc6ea37fa828726ae51b584e1a61f994041.
- Blob de respuesta con read-back: 0db054c79abebe40d7a6a686744e2adcd566b69b.
- Estado: RESPUESTA_INICIAL_REGISTRADA; EP-03 sigue abierto, pendiente de cierre/read-back por EP. EP-TASK-002 permanece en_curso.

**Delta intraciclo posterior:** EP registró una incidencia HTTP 409 por SHA obsoleto en el mismo objeto. Gobernanza la leyó desde blob `387d7525ae89cc359bcedf55d57659989d40eaf4` y respondió dentro del mismo EP-03, sin reintentar la revisión vieja ni sobrescribir cambios concurrentes.

- Commit de la segunda respuesta de Gobernanza: `73278104f3454bc7239fbfb89059aa5a0006dd65`.
- Blob de read-back de la segunda respuesta: `18574c5437cd8d6023dec9c05a09117e65247ed4`.
- El conflicto se clasificó como guardia efectiva; EP debe recuperar el SHA actual y reconstruir únicamente el delta después de comprobar que no fue incorporado ya.
- EP-03 sigue abierto. La última respuesta de Gobernanza no equivale a cierre/read-back final ejecutado por EP.

### GOV-TASK-014

La ficha se amplió para separar dos planos (artefactos versionados y datasets/estado operativo MCP-OCP) y tres resultados independientes (backup local, persistencia remota B2 y restauración cross-host). La evidencia recibida indica SQLite/WAL, SQLite Online Backup API, quick_check, SHA-256, paquetes AES-256-GCM y envoltura DPAPI CurrentUser; la portabilidad entre usuarios/equipos no está acreditada. Se exige manifiesto portable, estrategia autorizada de recuperación/re-enveloping de clave y validación funcional por MCP-OCP.

- Commit de la ficha: a844eb8f1d94fff99f9d197c06f8e0bf9641d1bd.
- Blob de ficha verificada: a4cb7e053392695b61c9c4265d0e6967f48fea42.
- Commit del índice de tareas: 2ff1ec20a13ec5e1abd16872a6e4e5a99d9921a2.
- Blob del índice verificado: 5f33b70070c8af4fcdb125cf33561178b52261ad.

### MCP-OCP

El ciclo local 06 está cerrado y verificado en §29.7; no se reabre. Gobernanza publicó una nueva solicitud en §30 del objeto de coordinación existente para que MCP-OCP defina inventario de datasets, consistencia de captura, backup nativo, portabilidad de manifiestos/claves, restore cross-host y prueba funcional.

- Control MCP-OCP observado: owned, generación 3, blob 3e6f96e919c33c3015478b7fd0f262b1bee47b0c; no modificado.
- Commit de §30: a9467aa34f3d19f6c8d178cbe3060547d73329ec.
- Blob con read-back: 3ea63f4c18de6f185430617add5bd2df67f15258.
- Estado: PUBLICADO; recepción/respuesta del titular MCP-OCP pendiente.

**DTC global:** EN_CURSO_RECURRENT. No hay monitoreo en segundo plano; la verificación se ejecuta al abrir cada ciclo real.

## 5. Fuente normativa y límites

DUG vigente observado en main: Samantha v377 · NX-377m · Metacanon 1.28 · GOW 2.17 · 43 principios · 22 anexos · blob 54064c8fe00f872023a455f06596061ed69062ae. No se modificó el DUG, GOW, ART-025/027 ni la IPZ nativa.

FOL1 permanece PREPARADO_PENDIENTE_ACTIVACION_IPZ. CV/CY/A/B globales y por OCP siguen PENDIENTE / NO ASIGNADO. MCP-NORMATIVO permanece DESACTIVADO. No se ejecutó operación B2 ni restauración remota; no se integró/instaló/aceptó la candidata MCP-OCP.

## 6. Siguiente acción

Cuando PC-8 vuelva a estar Online, recuperar el archivo fuente íntegro, verificar tamaño y SHA-256 contra el valor aquí registrado, crear el original en documentos/originales, leerlo de vuelta byte a byte y actualizar MANIFIESTO-DOCUMENTAL.json. Después actualizar las fotografías operativas del núcleo y PENDIENTES si siguen pendientes. Procesar la respuesta de EP-03 y la respuesta de MCP-OCP en sus objetos DTC actuales, sin duplicar ciclos ni canales.

---
