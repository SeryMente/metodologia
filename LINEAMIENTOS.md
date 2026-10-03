# Lineamientos transversales

## 1. Aplicación

Estos lineamientos son la referencia mínima para cualquier conversación secundaria o posterior que desarrolle o actualice un ámbito de la metodología, independientemente de su naturaleza.

## 2. Documentación de una actualización

Toda actualización debe dejar identificables, como mínimo:

- **Ámbito:** qué parte de la metodología se está trabajando.
- **Estado anterior:** qué existía antes del cambio.
- **Cambio:** qué se modifica, incorpora o elimina.
- **Motivo:** por qué se realiza el cambio.
- **Resultado:** cuál es el nuevo estado establecido.
- **Versión:** número de versión correspondiente cuando el cambio afecte al sistema versionado.

La documentación debe ser suficientemente clara para reconstruir la evolución del ámbito sin depender de la conversación en la que se originó.

## 3. Separación entre propuesta y decisión

Una idea discutida en una conversación no se considera automáticamente parte de la metodología. Solo las decisiones confirmadas pasan a formar parte del registro canónico.

## 4. Formato de salida de la sombrilla metodológica

Cuando corresponda mostrar la visión general, se utilizará este árbol como formato base:

```text
Metodología
│
├── Conversación general
│   └── Sombrilla metodológica
│       ├── principios generales
│       ├── relaciones entre sistemas
│       └── integración de lo desarrollado
│
└── Conversaciones especializadas
    ├── [ámbito especializado]
    │   └── desarrollo y actualización de ese ámbito
    │
    ├── [otro ámbito]
    │   └── desarrollo y actualización de ese ámbito
    │
    └── ...
```

Los nombres de los ámbitos se sustituyen por los ámbitos reales conforme se incorporen.

## 5. Actualización importante

Se considera **actualización importante** aquella que cambia de forma relevante la estructura, alcance, relación, regla general o estado consolidado de un ámbito, o que introduce un ámbito nuevo con impacto sobre la metodología común.

Una actualización importante es el desencadenante para mostrar oportunamente el árbol de la metodología general. Los cambios menores o puramente locales no lo requieren.

## 6. Sistema de versionado común

Todos los repositorios que operen bajo la metodología general utilizarán, como base, una nomenclatura numérica **MAJOR.MINOR.PATCH**.

La versión identifica un **estado reconocible del sistema** y no necesariamente una única sesión o ciclo de trabajo. Un mismo número de versión puede abarcar múltiples ciclos operativos. La jerarquía del desarrollo se expresa narrativamente y no necesita codificarse rígidamente dentro del número de versión.

Los criterios detallados para determinar cuándo corresponde incrementar **MAJOR**, **MINOR** o **PATCH** quedan pendientes de formalización posterior.

### 6.1 Identidad de la versión

Cada versión estará compuesta conceptualmente por tres elementos:

**valor cuantitativo + nombre + narrativa**

El **nombre** será una denominación breve, memorable y suficientemente distinta de las anteriores. Se decidirá mediante un criterio replicable y simple: identificar el cambio o estado más representativo de la versión y reducirlo a una denominación concreta, normalmente de una o dos palabras. No existirá por ahora una lista cerrada de nombres.

El nombre proporciona identidad verbal a la versión; no codifica su valor numérico ni sustituye su narrativa.

### 6.2 Narrativa de la versión

Cada número de versión deberá tener asociada una narrativa rica pero concisa. La narrativa seguirá un patrón semántico simple y universal:

**Antes → Cambio → Motivo → Resultado**

Debe contener información suficiente para que, leyendo las versiones sucesivamente, pueda reconstruirse cómo y por qué el sistema pasó de un estado al siguiente.

No se imponen por ahora vocabulario obligatorio, longitud, número de párrafos ni estructuras literarias adicionales. La finalidad es conservar una historia comprensible y reconstruible de la evolución del sistema sin introducir complejidad innecesaria.

## 7. Foliacion global de ciclos de conversacion

Todo ciclo de conversacion dentro de un proyecto sujeto a esta metodologia tendra un **folio global unico y secuencial**, independiente de la conversacion en la que ocurra. La conversacion es el contenedor/contexto; el ciclo es la unidad de secuencia y trazabilidad. La numeracion no se reinicia al cambiar de conversacion y puede intercalarse entre multiples conversaciones.

El formato canonico es:

`PROYECTO / CONV-XX / CXXX`

Donde `PROYECTO` identifica el proyecto, `CONV-XX` la conversacion y `CXXX` el folio global del ciclo. El folio `CXXX` es obligatorio en el formato de salida de **cada ciclo, sin excepcion**, para todos los proyectos bajo la metodologia.

## 8. Identificacion ubicua de la ultima version

En todo momento y en cualquier lugar donde se genere una conversacion al interior de un proyecto sujeto a esta metodologia, el modelo debe identificar la **version de la ultima actualizacion y el nombre de esa version**. Esta regla aplica a conversaciones nuevas, continuaciones y conversaciones especializadas de cualquier ambito.

El formato minimo es:

`Version: vX.Y.Z - Nombre de version`

## 9. Diagrama de arbol oportuno

El diagrama de arbol se mostrara **de manera oportuna** cuando el estado, estructura o naturaleza del trabajo haga pertinente presentar la vision jerarquica. No constituye un elemento obligatorio de todas las respuestas. Una actualizacion importante continua siendo el desencadenante establecido para mostrar oportunamente el arbol general de la metodologia.