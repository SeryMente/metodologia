# C-MCP-JULES-016 · reconfiguración de backlog, ruta RDC vigente y separación MCP-OCP/Khora

**Fecha:** 2026-11-06.  
**OCP:** frentes/mcp-jules/.  
**Control:** generación 3; titular operativo conservado; no se reasigna ni modifica.  
**Folio:** PENDIENTE / NO ASIGNADO; FOL1 inactivo.  
**Fuente normativa:** Samantha v377 · NX-377m; Metacanon 1.28; GOW 2.17; DUG blob 54064c8fe00f872023a455f06596061ed69062ae. §ARR consultado y cascada revisada manualmente.

## 1. Instrucción y autorización

El operador autorizó expresamente a esta sesión, aunque no sea responsable ordinaria del frente MCP-Jules, a revisar y modificar sus tareas provisionales para alinearlas con la separación del servidor MCP de Metodología respecto de Khora y preparar el uso de Jules lo antes posible. También indicó que no utilizará el frente ni sus herramientas hasta que las tareas queden configuradas y que retomará allí después.

**Ámbito aplicado:** lista provisional, plan integral, matriz de aceptación, OCP y README dentro de la rama documental feat/metacanon-mcp-jules-20261025-c32f81 que respalda PR #19. Esta autorización no transfirió el frente, no cambió su control de generación 3, no habilitó el control Khora ni autorizó código/Production/secrets, merge o despliegue.

## 2. Inspección y corrección de estado

Se constató que el plan y la matriz de aceptación seguían describiendo el plugin MCP público como ruta objetivo para ChatGPT Free, mientras que la ruta implementada en Khora es el cliente local RDC/stdio con OAuth 2.1/PKCE.

Estado real de implementación:
- PR #345 integró las siete herramientas Jules y autorización por recurso en Khora main, merge commit 953e69484eabb4e8dc8221d1d8fc188373531bfa.
- PR #347 integró el cliente puente local RDC/stdio, OAuth 2.1 Authorization Code + PKCE, callback loopback, DPAPI CurrentUser y validación de siete herramientas, merge commit 4530e03a33c5e1743ab9646eb6c862b3c458c605.
- PR #344 y #338 son candidatas históricas supersedidas; PR #340 pertenece a Custodia.
- Los resultados 568/568 y 572/572, TypeScript, UI Review y build 78/78 proceden de pruebas históricas PC-14. No acreditan OAuth real, tools/list ni E2E en el perfil RDC actual.

**Decisión vigente:** ChatGPT Free se opera mediante RDC con un cliente MCP local stdio; ese cliente completa OAuth 2.1/PKCE contra Khora. No se requiere plugin público ni conexión MCP privada nativa con escritura desde ChatGPT Free. El propietario confirma consentimiento OAuth en el navegador. No hay Bearer manual. JULES_API_KEY permanece solo en Khora Production.

## 3. Lista provisional y tareas

Se creó LISTA-TAREAS-PROVISIONAL.md v0.1 con diez tareas P0/P1:
1. reconciliar arquitectura y estado;
2. preparar bridge en dispositivo RDC actual sin iniciar OAuth;
3. obtener consentimiento OAuth explícito;
4. smoke autenticado solo lectura;
5. verificar scopes, ACL y seguridad;
6. ejecutar E2E en sandbox tras confirmar el plan;
7. validar reintentos, interrupciones y residual T22;
8. probar coexistencia con MCP-OCP local;
9. completar aceptación operativa;
10. reconciliar documentación y promover PR #19 tras revisión.

La matriz de aceptación se actualizó de T01–T32 a T01–T38. Los criterios T15/T23/T24/T26/T28/T31/T32 sustituyen plugin público/directorio por bridge local RDC y OAuth. Se agregaron T33–T38 para separación de producto, seguridad del bridge, coexistencia de clientes, smoke de solo lectura, consentimiento OAuth real y ciclo sandbox.

El plan integral se actualizó a v1.1.0 y añade la decisión operativa §25. Se conserva el modelo de EXACTAMENTE DOS fases; Fase 1 sigue completa y Fase 2 sigue en curso. La ruta plugin público queda supersedida sin borrar su historia.

## 4. Relación con MCP-OCP

El servidor MCP de Metodología pertenece exclusivamente al OCP MCP-OCP en SeryMente/metodologia y se construye localmente, preferentemente stdio y administrado por RDC. No forma parte del producto Khora. Khora conserva su MCP único /api/mcp y el bridge Jules como cliente local separado. No se mueven código, secretos, endpoints, controles o titularidad entre frentes.

La integración/coexistencia de ambos clientes se prueba en una tarea posterior, después de que MCP-OCP tenga su candidato local renovado y MCP-Jules haya completado los gates OAuth y read-only.

## 5. Evidencia de persistencia

| Artefacto | Commit | Blob | Read-back |
|---|---|---|---|
| Lista provisional MCP-Jules v0.1 | 56ba05c39038cb9e208dc248a94e8915c6f91b87 | 2ba091b369e9900f34f835a3b3815792e5d346ca | MATCHED |
| Plan integral v1.1.0 | 3259223206cc873298350e3319c499a22cb20a91 | 4cfeaecdf5fbe0a64ef575ee39bad39f1cb60fcf5 | MATCHED |
| Plan de aceptación v1.9.0, T01–T38 | 51668e89f36174504ffdb5fa236fb59e61a52d2c | 48686f551634fff942cd49b2af39dfb9fe9650f4 | MATCHED |
| OCP MCP-Jules v0.1.13 | a8dab070ccea14d19fb446b51281227fc0c8a017 | 656888bc333c643bab46114a033fb77aa6ce0e27 | MATCHED |
| README MCP-Jules | 260a7d71c8c1c1d550cd7f557641d4530342f646 | aed715c35797cfb564e640f611e7c8682f486bd0 | MATCHED |

La crónica C-MCP-JULES-015 y su original documental no se modificaron. CONTROL-RESPONSABILIDAD.json conserva generación 3, blob 113bf1930638843d52fe68441e76b2e0879e83f5.

## 6. No ejecutado y bloqueo deliberado

- No se inició el bridge, no se abrió navegador OAuth y no se concedió consentimiento.
- No se ejecutó tools/list ni llamadas reales de lectura/escritura Jules.
- No se creó sesión Jules, no se envió mensaje, no se aprobó plan.
- No se cambió código Khora, permisos, credenciales, base de datos, Production o Vercel.
- No se tocó EP ni el servidor local MCP-OCP.
- No se fusionó la PR documental #19.

La pausa de Jules se conserva. Al retomar, el primer paso operativo es preparar bridge local y, cuando el operador esté listo, completar consentimiento OAuth; después ejecutar solo lectura. El E2E sandbox requiere confirmación explícita de un plan concreto. T22 conserva su limitación: la API Jules no proporciona aprobación condicional atómica por plan digest.

## 7. Estado final

- **Configuración documental:** COMPLETADA en la rama de PR #19; read-back MATCHED de los cinco artefactos.
- **MCP-Jules Fase 1:** COMPLETA como línea base histórica.
- **MCP-Jules Fase 2:** EN CURSO.
- **OAuth real / tools/list / lectura Jules / E2E:** NO VERIFICADOS.
- **Uso Jules:** PAUSADO hasta que el operador reanude.
- **Titularidad:** generación 3 sin cambios.
- **PR #19:** OPEN / DRAFT / NOT MERGED. La integración a Metodología main requiere revisión/permiso de merge por separado.


## 8. Lecturas finales de navegación y corrección de destino

La última actualización de este OCP incorporó los enlaces a crónica y evidencia: commit `4b18b69982ed5bf668f9ded58fb27a95fbe14fce`, blob final `ca944ba79c96433812c72ee49396bd7b991b7bdb`, read-back MATCHED. El README incorporó la entrada de evidencia C016: commit `1b305fd13a645404358b14b04f3cbb3a0f99b9df`, blob final `d4a3d088ab13db002f56cb11cee73073222b61ad`, read-back MATCHED.

**Corrección de destino documental:** la primera llamada de creación de esta crónica omitió indicar la rama y creó temporalmente el mismo contenido en Metodología main. Antes de continuar, se leyó el blob `09b88b77ea56e57d50217a8e72bdbcab47125e01`, se creó el archivo en la rama correcta con contenido idéntico y read-back MATCHED (commit `c469ba05f846df7f2124613d550e95dbd688fb08`, mismo blob), se eliminó la copia de main con compare-and-swap por ese SHA (commit `5995c20922ec4e9d16aa0a88465bf507cea73df4`) y se confirmó NOT_FOUND en main. No quedó una crónica de MCP-Jules en main; la persistencia vigente está solo en la rama del PR #19.

La evidencia estructurada C016 se creó en la rama correcta: commit `58e75160d3ba1c7407a420e5b071c1b20b0c84c9`, blob inicial `ece2a6caa7fd0385e7804d467a2fa76ee0eb4410`, read-back MATCHED. Se actualizará el recibo solo para añadir las últimas revisiones de OCP/README; no se incluirán secretos ni datos de sesión.
