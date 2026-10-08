# Gobernanza de Publicación Vercel por Cuenta Secundaria

**Estado:** CANÓNICO  
**Versión:** v1.0.0  
**Fecha:** 2026-10-08  
**Ámbito:** Proyectos sujetos a la Metodología que utilicen Vercel para publicación o inspección de avances.

## 1. Propósito

Establecer una ruta de continuidad para publicar una versión validada del sistema cuando la cuenta primaria de Vercel no esté disponible.

El objetivo del fallback es **continuidad de publicación y visualización del avance**, no bypass de validaciones ni sustitución permanente de la autoridad primaria.

## 2. Jerarquía de publicación

La secuencia canónica es:

`VERCEL PRIMARIO → VERCEL SECUNDARIO`

La cuenta y el proyecto primarios definidos por cada proyecto son la ruta normal y conservan la autoridad de producción.

La cuenta secundaria se activa únicamente cuando la ruta primaria no puede publicar por una causa verificable, por ejemplo:

- acceso o autenticación no disponible;
- cuota o límite operativo agotado;
- incidencia temporal del proyecto o cuenta;
- indisponibilidad del canal principal de publicación.

No se activa la cuenta secundaria simplemente por conveniencia si la ruta primaria está disponible y operativa.

## 3. Cuenta secundaria canónica

**Cuenta publicadora secundaria:** `blacksheepsup@gmail.com`

Esta identidad es una referencia operativa canónica. La credencial de acceso no forma parte de este repositorio y nunca debe persistirse aquí.

## 4. Condiciones de activación

Antes de activar el fallback, el ciclo debe:

1. identificar el commit candidato;
2. comprobar las validaciones requeridas del proyecto;
3. intentar la publicación primaria;
4. determinar y registrar la causa de indisponibilidad;
5. activar la cuenta secundaria únicamente como continuidad.

La indisponibilidad primaria no reduce el nivel de validación exigido al código.

## 5. Fuente de verdad del artefacto

El artefacto secundario debe proceder de un commit conocido del repositorio Git canónico.

No se permite publicar como sustituto:

- una copia manual de archivos;
- un árbol de trabajo sucio sin excepción explícita;
- una versión histórica elegida solo porque la cuenta secundaria la puede desplegar;
- un artefacto cuyo SHA no pueda reconstruirse.

Cuando el proyecto tenga una bóveda canónica de variables, esa bóveda es la fuente de verdad de configuración sensible. No se copian secretos desde `.env` o documentos hacia este anexo.

## 6. Trazabilidad obligatoria

Cada deployment secundario debe conservar, como mínimo:

`CUENTA`  
`PROYECTO / EQUIPO`  
`COMMIT SHA`  
`ESTADO DE VALIDACIÓN`  
`MOTIVO DE ACTIVACIÓN`  
`FECHA/HORA`  
`URL DEL DEPLOYMENT`

La trazabilidad debe permitir responder posteriormente qué cuenta publicó qué commit, por qué se utilizó el fallback y dónde quedó disponible.

## 7. Separación de autoridad

La publicación secundaria no convierte a la cuenta secundaria en autoridad productiva primaria.

En particular:

- el dominio productivo canónico permanece subordinado al proyecto primario;
- el fallback no autoriza cambios permanentes de propiedad o configuración;
- la cuenta secundaria se utiliza para continuidad e inspección del avance;
- cuando la cuenta primaria vuelva a estar disponible, la ruta canónica vuelve a ser la primaria.

## 8. Proyecto secundario

Cuando el proyecto requiera un destino separado para continuidad, el proyecto secundario debe mantener el vínculo trazable con el mismo repositorio Git y distinguirse explícitamente del proyecto productivo primario.

Para KHORA, el proyecto productivo primario actualmente canonizado es:

- **Proyecto:** `khora-web`
- **Repositorio:** `SeryMente/khora`

El proyecto secundario de la cuenta `blacksheepsup@gmail.com` deberá conservar una identificación propia y no debe reutilizar un nombre ambiguo que pueda confundirse con el proyecto productivo primario.

La creación efectiva de ese proyecto secundario requiere autorización de la cuenta secundaria en Vercel. El repositorio no contiene credenciales de esa cuenta.

## 9. Secuencia operativa

`VALIDAR → IDENTIFICAR SHA → INTENTAR PRIMARIO → DOCUMENTAR FALLA → AUTENTICAR SECUNDARIO → PUBLICAR SHA VALIDADO → LEER DEPLOYMENT → REGISTRAR TRAZABILIDAD`

La lectura del deployment no es opcional: debe comprobar que la URL resultante corresponde al artefacto que se pretendía publicar.

## 10. Recuperación de la ruta primaria

Cuando la cuenta primaria vuelva a estar disponible:

`VERIFICAR PRIMARIO → PUBLICAR EN PRIMARIO → COMPROBAR DEPLOYMENT → MANTENER SECUNDARIO SOLO COMO EVIDENCIA`

La cuenta secundaria no se convierte automáticamente en la ruta normal por haber sido utilizada durante una contingencia.

## 11. Prohibiciones

No registrar contraseñas, tokens, refresh tokens, cookies o secretos de Vercel en Git.

No publicar desde un SHA desconocido.

No usar la cuenta secundaria para eludir fallos de validación del código.

No tratar una URL secundaria como el dominio productivo primario sin una decisión explícita y trazable.

No borrar evidencia de un fallback ya utilizado.

## 12. Estado de implementación

La política y la identidad de la cuenta secundaria quedan canonizadas en la Metodología y el SI a partir de 2026-10-08.

La autenticación efectiva de `blacksheepsup@gmail.com` y la creación de su proyecto secundario de Vercel son acciones de cuenta externa y requieren que esa cuenta tenga acceso autorizado a Vercel.

