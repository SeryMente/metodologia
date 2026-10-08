# ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL

**Objeto:** Gobernanza operativa de Vercel para proyectos sujetos a la metodología  
**Estado:** CANÓNICO  
**Versión del objeto:** v1.0.1  
**Fecha de actualización del objeto:** 2026-10-08  
**Ámbito:** Todos los proyectos, conversaciones y operaciones sujetos a la metodología que utilicen Vercel, incluyendo KHORA.  
**Fuente factual primaria:** documentación oficial vigente de Vercel, especialmente Limits, CLI Build, CLI Deploy e Instant Rollback.  
**Naturaleza:** regla metodológica-operativa; no constituye un principio fundamental nuevo del SI.

## 0. Registro de versiones del objeto

| Versión | Fecha | Cambio |
|---|---|---|
| v1.0.0 | 2026-10-08 | Canonización inicial del cruce Cora × Vercel × cuota × continuidad local. |
| v1.0.1 | 2026-10-08 | Revisión de cierre y depuración de referencias heredadas; se conserva la misma arquitectura operativa. |

## 1. Propósito

Este objeto establece cómo debe razonar y actuar el modelo cuando una operación depende de Vercel. Su función es separar con precisión:

1. la disponibilidad del sistema ya desplegado;
2. la posibilidad de crear un nuevo deployment;
3. la capacidad de validar o ejecutar Cora localmente;
4. la autoridad del URL canónico;
5. las medidas de recuperación que no requieren generar código nuevo.

La cuota de Vercel limita la **creación de nuevos deployments**; no convierte automáticamente en indisponible todo el sistema Cora.

## 2. Fuente de verdad y frescura

Los límites no se consideran permanentes. Este objeto es un **snapshot normativo-operativo** que debe actualizarse cuando cambie la documentación oficial de Vercel o cuando cambie materialmente el plan, proyecto o flujo de publicación.

Fuentes consultadas para esta versión:

- https://vercel.com/docs/limits
- https://vercel.com/docs/cli/build
- https://vercel.com/docs/cli/deploy
- https://vercel.com/docs/instant-rollback
- https://vercel.com/docs/deployments/rollback-production-deployment

**Estado de la documentación consultada:** 2026-10-08.  
**Regla:** cuando la fuente oficial cambie, prevalece la fuente nueva después de su verificación y este objeto debe incrementarse y actualizarse.

No se utilizan memoria conversacional, cifras históricas ni supuestos sobre reset de cuota para declarar el estado actual de Vercel.

## 3. Snapshot de límites relevantes

Para el plan **Hobby**, la documentación oficial consultada establece:

| Restricción | Valor vigente de referencia | Implicación metodológica |
|---|---:|---|
| Deployments creados | 100 / 86400 s | La publicación remota de una nueva versión puede quedar temporalmente bloqueada. |
| Builds | 32 / 3600 s | La capacidad de generar builds también tiene una ventana independiente. |
| Builds concurrentes | 1 | No debe suponerse paralelismo ilimitado de builds. |
| Tiempo de build por deployment | 45 min | Un build que exceda este límite no puede completar el deployment. |
| Tamaño máximo de subida CLI | 100 MB | Una publicación desde CLI puede fallar si la fuente supera este tamaño. |
| Archivos fuente por CLI deployment | 15000 | Una publicación puede fallar por exceso de archivos fuente. |

La documentación oficial expresa el límite de deployments como **100 despliegues cada 86400 segundos**. El estado efectivo no debe calcularse a partir del número de commits, sino de las operaciones que Vercel contabilice como deployments.

Una respuesta de Vercel como `api-deployments-free-per-day`, `payment_required` o equivalente se trata como evidencia de que la creación de un deployment está limitada en ese momento; no se interpreta como fallo del código sin evidencia adicional.

## 4. Objeto Cora–Vercel

Para KHORA, el plano Vercel canónico de referencia es:

- **Proyecto:** `khora-web`
- **URL canónico:** `https://khora-web.vercel.app`
- **Plan observado:** Hobby
- **Regla de autoridad:** este proyecto/URL constituye el plano canónico de publicación; una ejecución local nunca se considera su sustituto automático.

La existencia de un deployment listo no implica que sea el `main` actual. Toda comparación de vigencia debe usar el commit/SHA correspondiente y la fuente canónica de código.

## 5. Matriz transversal de impacto

| Caso de uso de Cora | ¿Requiere deployment nuevo? | Impacto de la cuota | Continuidad local |
|---|---|---|---|
| Abrir y utilizar la versión actualmente servida en producción | No | **No bloqueado** por la cuota de creación | No necesaria |
| Ingreso: dictado, captura, archivo, revisión o ingesta usando el código ya desplegado | No, mientras los contratos actuales sigan siendo compatibles | **No bloqueado** por la cuota | Disponible para probar cambios |
| Volcados existentes y nuevas escrituras contra servicios ya desplegados | No, si el endpoint y persistencia ya existen | **No bloqueado** por la cuota | Disponible; usar datos sintéticos para aislamiento |
| Grafo y consulta/RAG contra backend existente | No, si el contrato de backend no cambia | **No bloqueado** por la cuota | Disponible |
| Verificación normativa que consuma dinámicamente el SI/metodología | No necesariamente | **Parcialmente independiente** de la cuota; depende de que el deployment vigente lea esas fuentes dinámicamente | Disponible para validar lógica nueva |
| Cambio de UI, ruta, API, MCP, autenticación, OIDC o lógica de aplicación | Sí para llevar el cambio al URL canónico | **Bloqueado** mientras no pueda crearse el deployment | **Sí**: desarrollar, ejecutar y probar localmente |
| Nueva preview de Vercel | Sí | **Bloqueado** mientras la cuota esté agotada | Sustituible por una instancia local para validación técnica |
| Nuevo production deployment | Sí | **Bloqueado** mientras la cuota esté agotada | Sustituible por validación local, no por el URL canónico |
| Depuración de build de Vercel | No necesariamente | `vercel build` local no crea por sí mismo un deployment remoto | **Sí** |
| Recuperación urgente del deployment productivo | No necesariamente | Un rollback puede evitar un build nuevo | **Sí**, para investigar el cambio después |
| Operación del MCP remoto de Cora ya desplegado | No | **No bloqueado** por la cuota mientras el deployment existente siga accesible | Local no sustituye automáticamente la URL remota para consumidores externos |
| Uso remoto desde ChatGPT de la URL canónica | No para consumir la versión existente | **No bloqueado** por la cuota si el deployment servido permanece sano | Una instancia local no es accesible desde ChatGPT por defecto |

## 6. Regla de continuidad local

Cuando una operación no necesite materialmente el URL canónico de Vercel, el modelo debe preferir una implementación local para evitar consumir la cuota de deployments.

La implementación local puede utilizar el código vigente del repositorio, por ejemplo mediante el flujo de desarrollo de Next.js del proyecto. Esa instancia:

- puede evolucionar independientemente de la cuota de Vercel;
- puede utilizarse para desarrollo, depuración y pruebas;
- no modifica `khora-web.vercel.app`;
- no debe declararse producción canónica;
- debe mantener separada la configuración de datos sintéticos y la configuración con datos reales.

Cuando sea necesario validar específicamente el comportamiento del artefacto de build de Vercel, `vercel build` es una vía local apropiada porque produce `.vercel/output` sin crear por sí mismo el deployment remoto. La instrucción `vercel deploy` o `vercel deploy --prebuilt`, en cambio, sí crea un deployment y queda sujeta a las restricciones de Vercel.

## 7. Regla de decisión para cualquier operación Vercel

Ante cualquier tarea que mencione, utilice o pretenda modificar Vercel:

1. Cargar este objeto en su versión vigente.
2. Determinar si la tarea es de **consumo**, **datos**, **desarrollo local**, **verificación de build**, **deployment preview**, **deployment production**, **rollback** o **administración de la plataforma**.
3. Determinar si la tarea necesita crear un deployment nuevo.
4. Si no lo necesita, no consumir cuota por un deployment innecesario.
5. Si lo necesita y la cuota está disponible, validar localmente tanto como resulte razonable antes de publicar.
6. Si lo necesita y la cuota está limitada, no insistir cíclicamente ni convertir el bloqueo de Vercel en bloqueo global de Cora.
7. Seleccionar la alternativa local cuando sea funcionalmente suficiente.
8. Mantener explícita la frontera entre la instancia local y el URL canónico.
9. Cuando vuelva a existir capacidad de deployment, publicar el commit exacto que haya sido validado y verificar posteriormente el URL canónico.

## 8. Regla sobre rollback y recuperación

La recuperación de una producción degradada debe distinguir entre:

- **rollback:** volver a servir un deployment existente;
- **fix:** modificar código;
- **redeploy:** crear un deployment nuevo.

La documentación de Vercel describe el rollback como una operación que apunta el tráfico a un deployment anterior sin reconstruirlo. En Hobby, la capacidad de rollback está limitada al deployment de producción inmediatamente anterior.

Por ello, cuando la producción esté defectuosa y la cuota de nuevos deployments esté agotada, el modelo debe evaluar primero si existe un rollback válido antes de asumir que necesita una publicación nueva.

Un rollback no revierte automáticamente las escrituras de base de datos, variables de entorno u otros efectos externos; esos cambios deben analizarse por separado.

## 9. Regla de lectura dinámica de datos

La cuota de deployment no debe confundirse con la disponibilidad de datos.

Si un deployment existente ya contiene el código necesario y sus endpoints consultan una persistencia externa o fuentes canónicas dinámicas, los datos pueden continuar cambiando sin que cada cambio exija una nueva publicación.

Por tanto:

`cambio de datos ≠ deployment automático`

pero:

`cambio de contrato/código/UI → requiere nueva versión desplegada`

La clasificación debe hacerse por dependencia técnica real, no por intuición.

## 10. Regla para el URL canónico

`https://khora-web.vercel.app` representa el estado que Vercel sirve como producción canónica.

Una implementación local, una preview histórica o cualquier otro entorno no puede presentarse como equivalente al URL canónico salvo que una decisión posterior y verificable cambie explícitamente la arquitectura canónica.

Cuando la cuota bloquee una nueva publicación, el estado correcto es:

**código canónico actualizado + URL canónico aún en versión anterior + ejecución local disponible**, cuando esa combinación describa la realidad.

No debe afirmarse que el URL canónico refleja el `main` actual sin una publicación verificable.

## 11. Regla de no evasión de límites

La continuidad de Vercel no puede utilizar identidades, equipos, proyectos, automatizaciones o configuraciones creadas o utilizadas con el propósito de eludir una restricción del proveedor.

La continuidad prevista por esta metodología se resuelve mediante **reutilización del deployment existente, rollback cuando proceda, desarrollo/ejecución local y posterior publicación legítima cuando la capacidad vuelva a estar disponible**.

## 12. Observabilidad del estado de cuota

Cuando una operación de publicación sea relevante, el modelo debe distinguir al menos entre:

- `NO-REQUERIDA`: la tarea no necesita crear deployment;
- `DISPONIBLE`: no existe evidencia actual de bloqueo para crear el deployment requerido;
- `LIMITADA`: Vercel ha rechazado o restringido la creación del deployment;
- `NO-VERIFICADA`: no se ha obtenido evidencia suficiente.

Nunca se infiere el instante exacto de liberación a partir de una fecha de calendario fija. La restricción se documenta como una ventana temporal del proveedor y se vuelve a verificar antes de intentar publicar.

## 13. Protocolo de actualización de este objeto

Este documento se actualiza cuando ocurra cualquiera de estas condiciones:

1. Vercel modifica sus límites, reglas de despliegue, rollback, builds o planes.
2. KHORA cambia de plan, proyecto, URL canónico o mecanismo de publicación.
3. La arquitectura de Cora cambia de forma que altere la frontera local/Vercel.
4. Una ejecución real aporte evidencia de que una regla de este objeto ya no describe correctamente la plataforma.

Cada actualización debe conservar:

- versión del objeto;
- fecha de actualización;
- fuentes oficiales consultadas;
- resumen Antes → Cambio → Motivo → Resultado;
- revisión de la matriz de casos de uso;
- revisión explícita de la regla de continuidad local;
- búsqueda de restos de reglas obsoletas.

## 14. Estado de esta canonización

**CANONIZADO:** 2026-10-08.

La versión v1.0.0 establece por primera vez un objeto estable para gobernar el cruce **Cora × Vercel × cuota × ejecución local**.

Las rutas de continuidad que evadan las restricciones del proveedor no forman parte de este objeto ni de la metodología vigente.

## 15. Control de calidad de canonización

### Revisión 1 — coherencia estructural

- Cuota de Vercel separada de disponibilidad total de Cora: **OK**
- Deployment remoto separado de ejecución local: **OK**
- URL canónico separado de entornos locales/preview: **OK**
- Datos persistentes separados de publicación de código: **OK**
- Rollback separado de fix/redeploy: **OK**
- Evasión de cuota excluida: **OK**

### Revisión 2 — consistencia con la metodología

- No introduce un nuevo principio fundamental del SI: **OK**
- Se mantiene como regla metodológica-operativa: **OK**
- Permite actualización futura mediante versión + fecha + fuentes: **OK**
- Cubre operaciones de uso, datos, desarrollo, build, preview, production, rollback y acceso remoto: **OK**
- Evita que una limitación de Vercel bloquee indebidamente las capacidades locales: **OK**
- No presenta una implementación local como sustituto automático del URL canónico: **OK**
- No utiliza mecanismos de evasión de cuota: **OK**

**Conclusión:** el objeto es coherente y apto para ser la referencia transversal de cualquier operación de Vercel bajo esta metodología.
