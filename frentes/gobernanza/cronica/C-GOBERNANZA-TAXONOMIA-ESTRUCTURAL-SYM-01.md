# Crónica · C-GOBERNANZA-TAXONOMIA-ESTRUCTURAL-SYM-01

**Fecha:** 2026-10-28 · America/Mexico_City  
**Frente:** Gobernanza · **OCP:** frentes/gobernanza/  
**Titular operativo:** chatgpt-C-METODOLOGIA-PERSISTENCIA-DOCUMENTAL-20-SES-20261028-CPD20-1606 (alias operativo, no ID nativo) · **Generación:** 2

## Autorización y fuente

El operador solicitó explícitamente incorporar al glosario operativo los términos “Ser y Mente”, “S y M” y “Taxonomía estructural de S y M” como equivalente de “Taxonomía estructural”, así como formalizar anexos jerárquicos para la taxonomía global de S y M, cuenta GitHub, organización, repositorio, FT/FDT, ámbito funcional, estructura interna de FT y persistencia documental.

Se leyó la rama main del repositorio SeryMente/metodologia. La fuente canónica anterior era DUG v353 · NX-353m, blob 16c93745311a5405166a31b583c2a648fda0d044. La modificación aprobada se publicó en el único documento normativo HTML; no se creó una segunda fuente canónica.

## Canonización y estructura

- **DUG:** v354 · NX-354m; blob de lectura de vuelta 695d83ea6913ab3962a87e49b008c366f512e34e; commit 012eba06f4cd729d9c989862f701a6842aa59a36.
- **Metacanon:** 1.22; se ampliaron §46 para explicar el alcance OCP como unidad de persistencia posible —no obligatoria en cada nivel— y §51 para separar la identidad conceptual S y M, la cadena de infraestructura verificada y los ámbitos funcionales transversales.
- **GOW:** v2.4; 102 términos. Se añadieron Ser y Mente, S y M y Taxonomía estructural de S y M; la última entrada declara expresamente equivalencia con Taxonomía estructural.
- **Anexos:** 16 en total. ART-015 es nivel 1; ART-016 a ART-022 son nivel 2 bajo ART-015; ART-014 se enlazó como nivel 3 bajo ART-022. ART-007 a ART-013 se preservaron como anexos raíz de nivel 1.
- **Anexos temáticos:** ART-016 cuenta/identidad titular; ART-017 organización; ART-018 repositorio; ART-019 frente de trabajo; ART-020 ámbito funcional; ART-021 taxonomía interna de FT; ART-022 ámbito funcional de persistencia documental, estructura de directorios, manifiesto y verificación.
- **Persistencia documental:** ART-022 diferencia originales, derivados, manifiesto, fuentes, evidencias y artefactos. Mantiene la regla de guardar los originales en el OCP autorizado del FT y no presupone un OCP transversal independiente.
- **Identidad GitHub:** SeryMente está verificado como entidad de tipo Organization por los metadatos del repositorio observado. Una cuenta individual o empresarial superior no se da por probada.

## Soporte estructural y puntos de entrada

El DUG ahora representa cada anexo mediante los campos level y parent_id. El índice de anexos se construye de manera recursiva, las tarjetas muestran el nivel y el auditor está preparado para detectar padre inexistente, nivel incompatible y raíces distintas de nivel 1. El JSON exportado incorpora el mapa derivado de taxonomía.

Se alinearon los puntos de entrada y registros: INICIO.md, README del OCP Metacanon, inventario multi-repositorio, control del frente Gobernanza, GOBERNANZA.md, PENDIENTES.md y GLOSARIO-WORKSPACE.fuente.json. El metadato del GOW apunta al blob canónico DUG v354.

## Verificaciones efectivamente realizadas

- Lectura de vuelta del DUG desde main: exacta.
- JSON embebido: parsea.
- Contadores comprobados: 41 principios, 16 anexos, 102 términos GOW; 16 marcadores de anexo en la vista humana.
- Relaciones de la jerarquía comprobadas en los datos: ART-015 nivel 1; ART-016 a ART-022 nivel 2 con padre ART-015; ART-014 nivel 3 con padre ART-022; ART-007 a ART-013 siguen como nivel 1.
- JavaScript operativo extraído del DUG: compilación sintáctica aislada aprobada con new Function.
- IDs estáticos duplicados: cero.
- Metadato GOW releído y alineado al blob canónico.
- Los archivos auxiliares modificados se leyeron de vuelta y se cotejaron con el contenido escrito.

Estas comprobaciones son mecánicas. **No se ejecutó el renderizador ni el auditor dinámico de enlaces/retornos dentro de un navegador**, por lo que no se declara aceptación funcional integral.

## Límites y pendientes preservados

- GOV-RDC-01: validación literal PowerShell permanece abierta; no se ejecutó el comando.
- GOV-IPZ-01: el archivo IPZ está preparado, pero el campo nativo de Instrucciones Personalizadas no se escribió ni verificó.
- GOV-LINK-02: auditoría de navegador, enlaces cruzados y retornos dinámicos no ejecutada.
- GOV-SPDF-E2E-01: no había un adjunto original disponible para una prueba real; no se fabricó un documento ni manifiesto. Captura, escritura, cotejo y recuperación por una segunda instancia permanecen pendientes.
- Notion: no se actualizó ni leyó de vuelta el espejo; no se afirma sincronización continua.
- No se consultaron ni ejecutaron workflows de GitHub Actions.

## Artefactos de referencia

- DUG canónico: gobernanza/METAPROMPT-CANONICO-SAMANTHA.html, blob 695d83ea6913ab3962a87e49b008c366f512e34e.
- Glosario/metadata: gobernanza/GLOSARIO-WORKSPACE.fuente.json, blob c6b9077637175302a72eec1c5e0a3222a2517dfd.
- Entrada: INICIO.md, blob 4d884580a3334dd62f53d0d229ee909d69006aa7.
- OCP Metacanon: frentes/metacanon/README.md, blob d1aac07f8a7ba33ac3f5eb77da0ead1fad0176a5.
- Inventario: INVENTARIO-REPOSITORIOS-Y-FRENTES.md, blob 726ff9abfc7822d55b4fb3132651513fc9ecf792.
- Control: frentes/gobernanza/CONTROL-RESPONSABILIDAD.json, blob ed6aecfd49eb8fda1f8795434009a903622f8305.
- Núcleo de Gobernanza: frentes/gobernanza/GOBERNANZA.md, blob b4c975be39b4a61b605f2517f78a194880c4c5e8.
- Pendientes: frentes/gobernanza/PENDIENTES.md, blob b36f14ffc6bc2ef91b978616eb9b1be8ba4213a7.
