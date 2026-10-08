# Objeto Canónico de Continuidad del Sistema

**Estado:** CANÓNICO
**Naturaleza:** objeto operativo de continuidad; no sustituye al SI ni a la Metodología.
**Versión del objeto:** v1.0.1
**Función:** índice único de recuperación contextual entre conversaciones e instancias de ChatGPT.

## 1. Regla de autoridad

Este objeto no reemplaza ni redefine normas. Su función es señalar y encadenar las fuentes canónicas que deben recuperarse.

Precedencia:

1. SI-METACOGNITIVO.md
2. METODOLOGIA.md
3. ESTADO-RDC-ACTIVO.md
4. HISTORIAL-RDC.md, cuando exista y sea necesario para resolver cambios, sustituciones, conflictos o auditoría.
5. Este objeto, únicamente como índice de continuidad y contexto operativo.

La memoria conversacional nunca sustituye estas fuentes.

## 2. Fuentes canónicas

- SI: https://raw.githubusercontent.com/SeryMente/metodologia/main/SI-METACOGNITIVO.md
- Metodología: https://github.com/SeryMente/metodologia/blob/main/METODOLOGIA.md
- Estado RDC: https://github.com/SeryMente/metodologia/blob/main/ESTADO-RDC-ACTIVO.md
- Histórico RDC: https://github.com/SeryMente/metodologia/blob/main/HISTORIAL-RDC.md
- Repositorio: https://github.com/SeryMente/metodologia
- KHORA: https://github.com/SeryMente/khora

## 3. Bootstrap obligatorio por ciclo

Todo ciclo sujeto al sistema debe:

1. recuperar y verificar el SI canónico vigente;
2. recuperar y verificar la Metodología vigente;
3. recuperar este objeto de continuidad como índice;
4. leer ESTADO-RDC-ACTIVO.md y tratarlo como única fuente del estado global vigente;
5. determinar el estado de sesión y conectividad RDC del ciclo;
6. consultar HISTORIAL-RDC.md cuando exista cambio de identidad, sustitución, conflicto, excepción, recuperación o ambigüedad;
7. reaccionar conforme a la metodología y emitir el formato de salida obligatorio.

Este objeto no contiene ni autoriza un estado RDC actual propio. Los valores de sesión, conectividad, cuenta, dispositivo, ubicación y uso deben derivarse de las fuentes operativas correspondientes.

No se presume que el contexto del ciclo anterior siga vigente.

## 4. Continuidad entre conversaciones

Una conversación nueva debe reconstruir el contexto desde estas fuentes antes de pedir al usuario que vuelva a proporcionar una identidad RDC ya persistida.

El cambio de conversación no finaliza una sesión RDC.

Una nueva identidad RDC no se convierte en globalmente vigente hasta completar la validación, publicación y read-back definidos por la gobernanza vigente.

## 5. Invariante de estado actual

La identidad y el estado RDC actuales no se almacenan en este objeto.

La fuente única del estado global vigente es ESTADO-RDC-ACTIVO.md. Una observación local, un handshake recibido en otra conversación o un dato que aparezca en este índice no puede sustituir esa fuente.

HISTORIAL-RDC.md, cuando exista, aporta contexto de ciclo de vida y no sustituye el estado global vigente.

Una nueva identidad RDC solo adquiere vigencia transversal después de completar la validación, publicación condicionada y read-back definidos por la gobernanza vigente.

## 6. Regla de recuperación

Si este objeto no puede recuperarse, no se considera perdida la continuidad. Se vuelve directamente a las fuentes canónicas enumeradas en la sección 2.

Si ESTADO-RDC-ACTIVO.md puede recuperarse, ese estado conserva precedencia aunque este objeto esté ausente.

Si HISTORIAL-RDC.md no existe o no está disponible, no se inventa historial: se opera con el estado global vigente y se declara la limitación solo cuando afecte la decisión.

Si una fuente operativa no está disponible:

- no se inventa el estado;
- no se usa memoria conversacional como sustituto;
- se conserva la última identidad persistente válida cuando corresponda;
- se bloquean únicamente las operaciones que dependan materialmente del dato no verificable.

## 7. Regla de salida

La continuidad recuperada debe reflejarse en el formato de salida canónico vigente de cada ciclo.

El objeto no añade campos visibles ni sustituye el HUD vigente.

## 8. Integridad de continuidad

Este objeto debe tratarse como un índice, no como una caché de estado.

Una conversación solo puede declarar contexto RDC resuelto cuando:
- el SI y la Metodología vigentes fueron adquiridos;
- ESTADO-RDC-ACTIVO.md fue leído;
- la sesión global fue identificada desde esa fuente;
- la conectividad fue determinada conforme al gate aplicable;
- cualquier discrepancia material fue resuelta o clasificada sin inferencia.

Una fuente más antigua, una copia en otra conversación o una versión almacenada localmente no puede tener precedencia sobre una fuente canónica más reciente.

## 9. Criterio de éxito

Una conversación independiente debe poder recuperar este objeto, seguir sus referencias, reconstruir el estado global y actuar correctamente sin depender de información proporcionada por una conversación anterior.

La recuperación exitosa significa reconstrucción desde fuentes; no significa que el objeto por sí mismo demuestre que el modelo ejecutó el protocolo.
