# ANEXO-GOBERNANZA-PUBLICACION-VERCEL-SECUNDARIA

## Estado

- **Estado:** CANÓNICO
- **Ámbito:** KHORA y cualquier proyecto sujeto a esta metodología que utilice Vercel como plataforma de publicación.
- **Cuenta secundaria designada:** `blacksheepsup@gmail.com`

## 1. Propósito

Garantizar continuidad de publicación y observabilidad cuando la cuenta Vercel primaria no esté disponible, evitando que una contingencia de la plataforma de publicación altere innecesariamente el sistema canónico o sus datos persistentes.

## 2. Jerarquía de publicación

### 2.1 Cuenta primaria

La cuenta Vercel primaria conserva la autoridad sobre:

- el proyecto canónico de producción;
- el dominio canónico;
- la configuración de producción;
- la asignación de dominios;
- la promoción a producción.

En KHORA, el dominio canónico permanece `khora-web.vercel.app`.

### 2.2 Cuenta secundaria

La cuenta Vercel secundaria es:

`blacksheepsup@gmail.com`

Su función es exclusivamente garantizar **continuidad de publicación y visibilidad de avances** cuando la cuenta primaria no esté disponible, esté bloqueada o no pueda publicar oportunamente.

La cuenta secundaria no adquiere autoridad automática sobre producción.

## 3. Regla de publicación secundaria

Cuando la cuenta primaria no pueda publicar la versión vigente:

`MAIN VIGENTE → CUENTA SECUNDARIA → DEPLOYMENT DE OBSERVACIÓN`

La publicación secundaria debe utilizar:

- el mismo repositorio canónico;
- el commit exacto que represente la versión que se desea observar;
- un proyecto/dominio secundario no canónico;
- configuración explícita y trazable;
- sin modificar el dominio canónico de producción.

El objetivo primario de esta ruta es que el equipo pueda **ver y probar el avance vigente** mientras la cuenta primaria recupera su capacidad operativa.

## 4. Protección de datos y persistencia

Una publicación secundaria no puede:

- crear una base de datos paralela y declararla como sustituta de la canónica;
- ejecutar migraciones destructivas sobre la persistencia canónica;
- cambiar variables de producción de la cuenta primaria;
- reasignar silenciosamente el dominio canónico;
- promoverse automáticamente a producción.

Un rollback, promote o cambio de deployment de Vercel modifica el tráfico y la versión servida; no constituye una reversión de escrituras de base de datos. La recuperación de datos persistentes debe tratarse por separado.

Cuando una versión secundaria necesite acceder a datos reales para validación funcional, la conexión y el nivel de permisos deben ser explícitos y documentados. Para observación visual basta preferentemente con un entorno de datos de prueba o acceso de solo lectura.

## 5. Regla de promoción

La secundaria puede convertirse en publicación productiva únicamente mediante una decisión explícita y verificable.

Secuencia:

`CERTIFICAR COMMIT → VERIFICAR DATOS/ENV → CREAR O CONFIRMAR DEPLOYMENT → PROMOVER EXPLÍCITAMENTE → VERIFICAR DOMINIO CANÓNICO`

Nunca se debe inferir autorización de promoción solo porque la cuenta primaria esté indisponible.

## 6. Recuperación de la cuenta primaria

Cuando la cuenta primaria vuelva a estar disponible:

1. verificar el estado de `main`;
2. determinar cuál deployment representa la versión canónica vigente;
3. preservar la producción estable;
4. decidir explícitamente si la versión secundaria debe promoverse o descartarse;
5. devolver la autoridad operativa a la cuenta primaria;
6. registrar la transición.

## 7. Evidencia mínima

Toda publicación secundaria debe poder reconstruirse a partir de:

- repositorio;
- commit SHA;
- cuenta utilizada;
- proyecto Vercel secundario;
- deployment ID/URL;
- instante de publicación;
- estado de datos/persistencia;
- decisión posterior de promoción, descarte o rollback.

## 8. Relación con SI

Esta regla pertenece al nivel metodológico y operativo. No añade un principio fundamental al SI.

El SI únicamente exige continuidad, fidelidad, trazabilidad y separación entre mecanismo y norma. Los detalles de Vercel, cuentas y deployments permanecen aquí para poder sustituirse sin modificar los principios fundamentales.
