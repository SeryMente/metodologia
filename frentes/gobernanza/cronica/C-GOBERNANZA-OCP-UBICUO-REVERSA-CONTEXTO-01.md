# Crónica · C-GOBERNANZA-OCP-UBICUO-REVERSA-CONTEXTO-01

**Fecha:** 2026-10-28 · America/Mexico_City  
**Frente:** Gobernanza · OCP: `frentes/gobernanza/`  
**Titular operativo:** `chatgpt-C-METODOLOGIA-PERSISTENCIA-DOCUMENTAL-20-SES-20261028-CPD20-1606` · generación 2 (alias operativo, no ID nativo)  
**Folio global de ciclo:** `C-20261028-E025C250`

## Solicitud y decisión

El operador ratificó que el término **Objeto Canónico de Persistencia (OCP)** se aplica de forma ubicua a cada unidad de la taxonomía: la Metodología, en sentido general y abstracto, es el OCP raíz; la organización SeryMente, cada repositorio, cada frente de trabajo y cada ámbito o subámbito son OCP de su propio nivel.

La regla distingue la identidad del objeto taxonómico de su materialización física. Ser OCP no implica crear una carpeta, repositorio físico, núcleo paralelo o sincronización exclusiva; la ruta, los permisos, la fuente de estado y la recuperabilidad deben declararse y verificarse por separado.

El operador canceló las consecuencias de la decisión del evento `C-GOBERNANZA-CONTEXTO-GESTION-CONVERSACIONAL-01`. Por tanto, **Contexto deja de ser un ámbito funcional independiente** y **Gestión conversacional deja de ser su hijo**. El registro, la crónica y la evidencia previos se preservan como historial, pero la decisión está marcada como revertida en el GOW y no debe retomarse como norma vigente.

## Taxonomía funcional vigente

Los únicos ámbitos funcionales definidos actualmente son los siguientes, ambos al mismo nivel:

1. **Persistencia documental.** Conservación y recuperación verificable de documentos, distinguiendo originales, derivados, manifiesto y evidencia. La estructura documental se especifica en ART-022 y el procedimiento en ART-014.
2. **Gestión conversacional.** Identificación, registro, organización y recuperación de conversaciones de trabajo, y facilitación de la continuidad a partir de registros disponibles. No implica captura automática, preservación íntegra de cada intercambio, sincronización continua o acceso futuro garantizado.

ART-020 mantiene su **nivel documental 2 como anexo hijo de ART-015**. Ese nivel de anexo no es el nivel funcional de los ámbitos. La taxonomía permite definir subámbitos de nivel 2 o N cuando una necesidad delimitada lo justifique; la posibilidad está habilitada, pero no se instancian subámbitos por defecto.

## GOW y proyección estructurada

- **DUG:** v357 · NX-357m.
- **Metacanon:** 1.23, sello `METACANON-OBJETOS-v1.23`.
- **GOW:** v2.7, 108 términos.
- **Taxonomía estructurada:** v1.2.
- **Conteos conservados:** 41 principios y 16 anexos.
- Se incorpora la entrada **Objeto Canónico de Persistencia (OCP)** y el campo estructurado `definition`, separado de aliases y equivalencias terminológicas.
- La definición de OCP establece la raíz metodológica abstracta y el carácter de OCP de cada unidad taxonómica. Las entradas de «Ámbito», «Ámbito de frente de trabajo» y «Ámbito de OCP» mantienen su equivalencia operativa cuando refieren al mismo alcance, pero sus definiciones ya no confunden ámbito con ubicación física.
- Se añade «Persistencia documental» como término del GOW en el mismo nivel que «Gestión conversacional», y se retira «Contexto» como término de ámbito vigente.
- La definición de Gestión conversacional se mantiene ligera, sin prometer captura o sincronización no verificadas.

## Fuente canónica y lectura de vuelta

- **Documento:** `gobernanza/METAPROMPT-CANONICO-SAMANTHA.html`
- **Commit DUG:** `1cf0f767a7771db52a48ac59dd8b51fc914d9620`
- **Blob DUG:** `87627e52a4cd5227b6a011cb4ba87a5289ce836d`
- **Metadatos GOW:** `gobernanza/GLOSARIO-WORKSPACE.fuente.json`, blob `a4945d56e210a8dc167eb95d4540184b1ca9ac22`, commit `a9bce8b244bc9b6bbf4da6b7ec7b15db0b7f459d`.
- **Punto de entrada:** `INICIO.md`, blob `7053edd354f7a1d63e10891b1fb1566eccb250ed`, commit `d42292355e0f51c5c5ad9508130b1eaa8d124253`.
- **README Metacanon:** blob `4b10d79404eb4be3d17d90e7097d07f8fa8e1795`, commit `1540f196652bbd84d1dcc19c67c0918d384e6163`.
- **README Gobernanza:** blob `255affc88a91b2dfaabac3fc696988c0f956b275`, commit `0094b4a9a5e61a2a30b54bc28419922c609feacd`.
- **Pendientes:** blob `98fc4b5f828211100a05439a8c708ae22c4318b6`, commit `225ceb78a89a7f0b8e1711a85b718ecabaf586a1`.
- **Núcleo operativo Gobernanza:** blob `d7597458b06dedca0eb7dd6013af0da82c01c099`, commit `ca9c7cc7e5cc9f09e9ff76763bcd6521ebd799d5`.
- **Control de responsabilidad:** blob `49d8cfa53043655f369c5ce21fdca0f94dfaa04d`, commit `3b41996b20646d65fd0717189bc94945cfb36a70`.

Los archivos auxiliares listados se escribieron secuencialmente y se leyeron de vuelta; los contenidos cotejaron exactamente con lo escrito.

## Validaciones y límites

- JSON embebido del DUG: **PASS**.
- JavaScript operativo extraído y compilado de forma aislada: **PASS · compilación sintáctica solamente**.
- Lectura de vuelta exacta del DUG: **PASS**.
- IDs duplicados detectados en HTML estático: **0**.
- Anclas duplicadas en el contenido inspeccionado: **0**.
- Entradas y anclas vigentes de los dos ámbitos actuales; ausencia del término/ancla vigente `gow-contexto`: **PASS**.
- Versiones, definiciones, puntos de entrada, metadatos y control de responsabilidad: **cotejados**.
- **No ejecutado:** renderizado del navegador ni auditoría dinámica completa de enlaces/retornos.
- **No actualizado ni releído:** espejo de Notion; no se afirma sincronización perpetua.
- **No escrito ni verificado:** campo nativo de Instrucciones Personalizadas de ChatGPT (IPZ).
- **Pendiente:** prueba E2E de persistencia documental con un adjunto original real y recuperación por otra instancia autorizada; no se fabricó material de prueba.
- GitHub Actions/workflows no se consultaron ni ejecutaron.

Esta crónica es un registro operativo del evento. La única fuente normativa sigue siendo el DUG HTML en `main`.
