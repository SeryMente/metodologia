# Registro conversacional · guía operativa v1.2

El contrato normativo reside en [ART-024 del DUG](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-024) y [P042](../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#P042). Esta guía concreta la materialización FOL1. El esquema v1.0 y los registros E/S se conservan como legado, sin sobrescritura.

## Estado

**FOL1 está PREPARADO, no ACTIVO.** El maestro conserva contadores en cero y ninguna asignación. No se emiten folios globales CV/CY/A/B antes del corte que seguirá a la preparación de la nueva IPZ. Esto no bloquea la continuidad: la conversación conserva su UUIDv7 local; la sesión de responsabilidad usa su folio operativo `SES-AAAAMMDD-XXXXXXXX`, independiente del CV global; cada ciclo pre-corte conserva el folio heredado `C-AAAAMMDD-XXXXXXXX` y sus registros físicos `-E/-S`, identificados semánticamente como A/B, con `foliation_generation=LEGACY` y `folio_status=LEGACY_PRE_CUTOVER`. No se renumera ni se finge FOL1.

## Fuentes

- [Registro maestro global y por OCP](REGISTRO-MAESTRO-FOLIACION.json): única fuente de contadores, catálogo de contextos y asignaciones.
- [Esquema del registro maestro](ESQUEMA-FOLIACION-MAESTRA-v1.0.json): contrato de datos del maestro.
- [Esquema de ciclo A/B](ESQUEMA-CICLO-CONVERSACIONAL-v1.1.json): un registro independiente para A o B; contempla registros FOL1 verificados y registros A/B de legado pre-corte.
- [Índice de conversaciones](REGISTRO-CONVERSACIONES.csv): localizador; no incrementa ni gobierna contadores.
- [Esquema y guía históricos E/S](ESQUEMA-CICLO-CONVERSACIONAL-v1.0.json) · [guía v1.0](REGISTRO-CONVERSACIONAL-v1.0.md): preservados como antecedente.

## Identidades y secuencias

- UUIDv7 local identifica de forma estable el registro de conversación. No es un folio ni un ID nativo de ChatGPT.
- La conversación tiene folio global CV-G######## y uno CV-OCP-<código>-######## por cada OCP que realmente aplique.
- Dentro de cada conversación, cycle_number es un natural consecutivo 1, 2, 3… El ciclo también recibe CY-G######## y un CY-OCP-<código>-######## por cada OCP aplicable.
- A conserva literalmente la entrada del operador; B conserva la salida visible final del modelo. Son registros separados. Tras el corte FOL1 reciben folios A-G######## / A-OCP-<código>-######## y B-G######## / B-OCP-<código>-########. Antes del corte, A/B son las etiquetas semánticas; se preserva el identificador heredado `C-...-E` / `C-...-S` y se declara `LEGACY_PRE_CUTOVER`. Su orden dentro del ciclo es A=1 y B=2 en ambas generaciones.
- Conversación, ciclo, A y B utilizan contadores independientes globales y contadores independientes por cada OCP. Un ciclo puede relacionarse con varios OCP; los OCP no pertinentes no reciben folio.

## Asignación controlada

1. Leer en main el registro maestro, identificar su blob SHA y comprobar que está ACTIVO.
2. Determinar los OCP aplicables mediante identidad/catálogo, no por inferencia de una ruta o nombre.
3. Consultar la clave de idempotencia. Una asignación ya verificada se reutiliza exactamente; nunca se duplica.
4. Incrementar el contador global y todos los contadores OCP aplicables en una sola actualización del maestro condicionada al SHA leído. No ejecutar escrituras paralelas.
5. Releer el maestro desde main y cotejar contadores, clave, folios y referencias. Solo emitir folios después de ese read-back.
6. Si una conversación ya tiene folio global y posteriormente se determina un OCP adicional que sí le aplica, conservar el folio global y todos los folios OCP previamente emitidos; añadir únicamente el folio local faltante en ese OCP mediante una asignación idempotente `clase + objeto + ocp_id`. Nunca crear un segundo folio global para la misma conversación, ciclo o lado A/B.
7. Ante conflicto, relectura o permiso fallido, no reutilizar ni improvisar números. Mostrar FOLIACIÓN NO ASIGNADA/NO VERIFICADA para el folio afectado y continuar el trabajo que no dependa de esa asignación. Con FOL1 PREPARADO usar el régimen legado, no PENDING FOL1.

El control por SHA es serialización cooperativa entre escritores que respetan el contrato; no es un bloqueo de servidor ni impide que un escritor lo eluda. La unicidad global queda limitada al catálogo y cobertura efectivamente accesibles/verificados.

## Catálogo y cobertura

El maestro contiene 26 contextos OCP conocidos, de los cuales 23 son elegibles para asignación y 3 permanecen pendientes: Blog personal (BLOG), EP (EP) y Tareas automáticas (TAU), por falta de control o conciliación de ruta/branch. Etica, el sprint GDP, la ruta de compatibilidad frentes/metodologia, Tareas dentro de Gobernanza y mcp-jules permanecen como contextos pendientes o excluidos, con motivo registrado.

El inventario central consultado cubre repositorios accesibles, no acredita que abarque todos los repositorios de la organización. Por tanto, KNOWN_INVENTORY_ONLY no equivale a exhaustividad. Antes de asignar en un contexto nuevo, incorporarlo al catálogo y releer el maestro; si su identidad no está resuelta, bloquear solo el folio OCP correspondiente y no inventarlo.

## Compatibilidad histórica y preservación

Los folios C-AAAAMMDD-XXXXXXXX con sufijos -E/-S permanecen como identificadores heredados. El esquema v1.1 separa la identidad de registro (`record_id`) del folio FOL1 (`record_folio_global`); no exige que el identificador legado se convierta en un folio FOL1. La lectura lógica del lado se expresa A/B, mientras el sufijo heredado se conserva físicamente (A↔E, B↔S); no se modifica el ID original. No se asigna FOL1 retroactivamente a conversaciones abiertas antes del corte. Los mensajes auxiliares visibles se guardan aparte; no se concatenan a B. No se registra razonamiento interno oculto ni se simula captura automática.

## Formato mínimo de salida tras el corte FOL1

Mostrar folio de conversación, número natural de ciclo, folio global y OCP del ciclo, y folios globales/OCP de A y B. En el metadato de gobernanza se muestran IPZ y DUG con versión y antigüedad d.h.m calculada desde el último commit de cada archivo fuente exacto, conforme a Metacanon §37.4. Ese valor no certifica la instalación nativa del campo IPZ.

**Criterio de cierre de foliación:** A y B están preservados literalmente; cuando FOL1 está ACTIVO, sus folios proceden del maestro, los OCP aplicables están representados con su estado de cobertura y el registro de asignación fue leído de vuelta. Si falla una condición, la foliación queda PENDING/NO ASIGNADA o parcial, según proceda; no se inventa el folio ni se bloquea la continuidad del trabajo independiente. El cierre operativo y el cierre de foliación se reportan por separado.
