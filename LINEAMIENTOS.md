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
