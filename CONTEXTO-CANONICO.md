# Objeto Canónico de Continuidad del Sistema

**Estado:** CANÓNICO
**Naturaleza:** objeto operativo de continuidad; no sustituye al SI ni a la Metodología.
**Función:** punto único de recuperación contextual entre conversaciones e instancias de ChatGPT.

## 1. Regla de autoridad

Este objeto no reemplaza ni redefine normas. Su función es señalar y encadenar las fuentes canónicas que deben recuperarse.

Precedencia:

1. SI-METACOGNITIVO.md
2. METODOLOGIA.md
3. ESTADO-RDC-ACTIVO.md
4. HISTORIAL-RDC.md, cuando exista y sea necesario para resolver cambios, sustituciones, conflictos o auditoría.
5. Este objeto, como índice de continuidad y contexto operativo.

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
3. leer ESTADO-RDC-ACTIVO.md;
4. determinar el estado de sesión y conectividad RDC del ciclo;
5. consultar HISTORIAL-RDC.md cuando exista cambio de identidad, sustitución, conflicto, excepción, recuperación o ambigüedad;
6. reaccionar conforme a la metodología y emitir el formato de salida obligatorio.

No se presume que el contexto del ciclo anterior siga vigente.

## 4. Continuidad entre conversaciones

Una conversación nueva debe reconstruir el contexto desde estas fuentes antes de pedir al usuario que vuelva a proporcionar una identidad RDC ya persistida.

El cambio de conversación no finaliza una sesión RDC.

Una nueva identidad RDC no se convierte en globalmente vigente hasta completar la validación, publicación y read-back definidos por la gobernanza vigente.

## 5. Estado de transición conocido

Al crear este objeto, existe evidencia local proporcionada por el usuario de una nueva sesión RDC:

- Cuenta: blacksheepsup@gmail.com
- Dispositivo: PC-7
- Device ID: 5165397f-3ccf-4c7d-939f-821526119101
- Estado observado: Device ready / Online / Channel subscribed
- Condición: **SUSTITUCIÓN PENDIENTE DE PUBLICACIÓN GLOBAL**

La identidad anterior registrada en ESTADO-RDC-ACTIVO.md no debe darse por sustituida hasta completar la transacción canónica y su read-back.

Este bloque es una fotografía operacional de transición; debe actualizarse o quedar obsoleto cuando el estado global sea reconciliado.

## 6. Regla de recuperación

Si este objeto no puede recuperarse, no se considera perdida la continuidad. Se vuelve directamente a las fuentes canónicas enumeradas en la sección 2.

Si una fuente operativa no está disponible:

- no se inventa el estado;
- no se usa memoria conversacional como sustituto;
- se conserva la última identidad persistente válida cuando corresponda;
- se bloquean únicamente las operaciones que dependan materialmente del dato no verificable.

## 7. Regla de salida

La continuidad recuperada debe reflejarse en el formato de salida canónico vigente de cada ciclo.

El objeto no añade campos visibles ni sustituye el HUD vigente.

## 8. Criterio de éxito

Una conversación independiente debe poder recuperar este objeto, seguir sus referencias, reconstruir el estado global y actuar correctamente sin depender de información proporcionada por una conversación anterior.
