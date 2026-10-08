# ANEXO-GOBERNANZA-VERCEL-CUOTA-Y-CONTINUIDAD-LOCAL

**Objeto:** Gobernanza operativa de Vercel para proyectos sujetos a la metodología  
**Estado:** CANÓNICO  
**Versión del objeto:** v1.2.0  
**Fecha de actualización del objeto:** 2026-10-08  
**Ámbito:** Todos los proyectos, conversaciones y operaciones sujetos a la metodología que utilicen Vercel, incluyendo KHORA.  
**Fuente factual primaria:** documentación oficial vigente de Vercel, especialmente Limits, CLI Build, CLI Deploy e Instant Rollback.  
**Naturaleza:** regla metodológica-operativa; no constituye un principio fundamental nuevo del SI.

## 0. Registro de versiones del objeto

| Versión | Fecha | Cambio |
|---|---|---|
| v1.0.0 | 2026-10-08 | Canonización inicial del cruce Cora × Vercel × cuota × continuidad local. |
| v1.0.1 | 2026-10-08 | Revisión de cierre y depuración de referencias heredadas; se conserva la misma arquitectura operativa. |
| v1.1.0 | 2026-10-08 | Endurecimiento del gate obligatorio: detección de limitaciones, determinación de dependencia real del caso de uso, decisión local/Vercel y bloqueo únicamente cuando ninguna vía suficiente alcance el objetivo. Se corrige además el límite vigente de builds por hora de Hobby. |
| v1.1.1 | 2026-10-08 | Endurecimiento final: activación por mera mención de Vercel en cualquier hilo de desarrollo, evaluación obligatoria de limitación y dependencia antes de ejecutar, y prioridad de continuidad local cuando sea suficiente. Se incorpora `vercel dev` como vía local documentada. |
| v1.2.0 | 2026-10-08 | Regla explícita de intención de publicación: una solicitud de publicar en Vercel obliga a intentar y resolver una publicación suficiente para el caso de uso del hilo, pero un fallo de publicación nunca convierte por sí solo el esfuerzo completo en bloqueado; la parte local debe continuar cuando sea suficiente para el objetivo. |

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
- https://vercel.com/docs/cli/dev
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
| Builds / hora (Hobby) | 100 / 3600 s | Una operación que cree o construya deployments puede encontrar una restricción horaria independiente de la ventana diaria. |
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

Cuando sea necesario validar específicamente el comportamiento del artefacto de build de Vercel, `vercel build` es una vía local apropiada porque produce `.vercel/output` sin crear por sí mismo el deployment remoto. `vercel dev` permite replicar localmente el entorno de deployment para probar Functions y Middleware sin desplegar cada cambio. La instrucción `vercel deploy` o `vercel deploy --prebuilt`, en cambio, sí crea un deployment y queda sujeta a las restricciones de Vercel.

## 7. Gate obligatorio Vercel

### 7.0 Regla de intención de publicación y suficiencia del caso de uso

Una solicitud explícita de **publicar en Vercel** se interpreta como una instrucción para llevar el resultado del esfuerzo a un entorno remoto suficiente para el caso de uso concreto del hilo. El modelo no debe rebajar esa solicitud a una mera validación local por defecto: debe identificar el destino adecuado (preview, production u otro entorno explícitamente requerido), verificar la capacidad real de Vercel y ejecutar la publicación cuando sea posible.

La palabra **suficiente** se refiere al objetivo real del esfuerzo, no a una réplica universal de toda la plataforma. Si el objetivo del ciclo es únicamente desarrollar, inspeccionar o ver una UI nueva y no se ha solicitado publicación remota, la instancia local es una vía plenamente válida. La imposibilidad de publicar en Vercel no puede bloquear ese trabajo local.

Cuando sí exista una solicitud de publicación y Vercel rechace o limite el deployment, el estado correcto es:

**publicación remota pendiente/limitada + continuidad local disponible**, cuando la parte local sea suficiente para el objetivo técnico restante.

El estado BLOQUEADO solo puede aplicarse a la ruta remota que materialmente requiera Vercel. No puede elevarse automáticamente a bloqueo global del hilo, ciclo o esfuerzo. En particular, nunca debe emitirse una conclusión equivalente a «no se puede continuar» solo porque no fue posible crear un deployment, si el usuario todavía puede obtener de forma suficiente el resultado que está buscando en local.

En sentido inverso, cuando el usuario sí pide publicar, el modelo no debe utilizar la suficiencia local como excusa para omitir el intento remoto: debe intentar la publicación suficiente y, si falla, dejar constancia verificable del punto exacto de fallo y continuar con la parte local no dependiente de Vercel.

La mera mención de Vercel dentro de un hilo de desarrollo activa este gate. No se puede ejecutar una operación dependiente de Vercel sin resolverlo primero.

### 7.1 Paso A — Detectar la restricción

El modelo debe comprobar si existe una limitación de Vercel relevante para la operación. Debe distinguir al menos entre:

- cuota o rate limit de deployments/builds;
- concurrencia;
- tiempo de build;
- tamaño o cantidad de archivos;
- límites de rutas, funciones, variables de entorno, runtime o recursos;
- disponibilidad/estado del proyecto o deployment;
- cualquier otra restricción de Vercel que la operación concreta pueda activar.

La comprobación debe usar la documentación oficial vigente de Vercel y, cuando exista acceso al proyecto/cuenta, evidencia viva del estado de Vercel. No se deben inferir límites actuales desde memoria histórica. La existencia de una limitación debe registrarse como evidencia y no asumirse por el mero hecho de trabajar con Vercel.

### 7.2 Paso B — Determinar la necesidad real de Vercel

El modelo debe analizar el objetivo del caso de uso y determinar qué parte del objetivo depende materialmente de Vercel.

Debe establecer explícitamente:

- `OBJETIVO`: resultado que el esfuerzo debe producir.
- `DEPENDENCIA-VERCEL`: NO, PARCIAL o MATERIAL.
- `DEPLOY-REQUERIDO`: SI o NO.
- `SUFICIENCIA-LOCAL`: SI o NO.
- `MOTIVO`: qué requisito concreto exige o no exige el plano remoto.

`NO` significa que el objetivo puede alcanzarse sin la plataforma Vercel.

`PARCIAL` significa que la mayor parte del objetivo puede alcanzarse localmente y solo una parte posterior exige Vercel.

`MATERIAL` significa que el objetivo, por su propia definición, requiere una propiedad remota concreta que la instancia local no puede sustituir de forma suficiente; por ejemplo, el comportamiento efectivo del URL canónico, una integración/callback externo que dependa materialmente del endpoint público, o una propiedad específica del entorno remoto que sea objeto de validación.

La necesidad de Vercel no se deduce de la arquitectura histórica del proyecto: se deriva del objetivo actual del esfuerzo.

### 7.3 Paso C — Elegir la vía suficiente

La decisión obligatoria es:

`LIMITATION-SCAN → DEPENDENCIA-VERCEL → SUFICIENCIA-LOCAL → VÍA DE EJECUCIÓN`

- Si `SUFICIENCIA-LOCAL = SI`, se debe continuar por la instancia local y no consumir un deployment remoto solo para mantener una ruta histórica de trabajo.
- Si `DEPENDENCIA-VERCEL = PARCIAL`, se ejecuta localmente toda la parte que no requiera Vercel y se conserva para después únicamente la parte remota material.
- Si `SUFICIENCIA-LOCAL = NO`, se comprueba la capacidad real de Vercel antes de intentar publicar.
- Si el deployment es necesario y Vercel está limitado, solo la parte que requiere realmente Vercel queda pendiente/bloqueada. El resto del esfuerzo continúa por la vía local.

### 7.4 Paso D — Prohibición de bloqueo prematuro

Una limitación de Vercel nunca constituye por sí misma un bloqueo global del esfuerzo.

Antes de declarar `BLOQUEADO`, el modelo debe demostrar:

1. que el objetivo concreto requiere una propiedad que no puede obtenerse suficientemente en local;
2. que dicha propiedad necesita efectivamente una operación Vercel afectada por la limitación;
3. que no existe una operación ya disponible sobre un deployment existente que satisfaga el objetivo;
4. que no existe rollback u otra recuperación legítima cuando el caso sea de recuperación;
5. que la parte restante del objetivo tampoco puede separarse y continuar localmente.

Si cualquiera de estas condiciones no se demuestra, no corresponde declarar bloqueo global.

### 7.5 Efecto inmediato

Este gate tiene efecto desde su incorporación al repositorio canónico. Toda conversación o hilo posterior sujeto a esta metodología que entre en ámbito Vercel debe aplicar este procedimiento antes de ejecutar, aunque la solicitud no mencione explícitamente la cuota.


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
**Versión vigente del objeto:** v1.2.0.

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
