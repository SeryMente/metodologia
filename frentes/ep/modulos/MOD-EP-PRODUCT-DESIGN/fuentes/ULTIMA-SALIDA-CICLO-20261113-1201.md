Hay una precisión importante para el diseño de la versión 1.0: **CIS tiene seis agentes individuales**, además de configuraciones de colaboración como *Creative Squad* y *Design Pair*\.

| Agente | Especialidad |
|--------|--------|
| Carson | Brainstorming e ideación |
| Maya | Design Thinking y diseño centrado en las personas |
| Dr. Quinn | Diagnóstico creativo y resolución de problemas |
| Victor | Innovación y estrategia |
| Sophia | Storytelling y construcción narrativa |
| Caravaggio | Presentaciones, pitches y comunicación visual |

No todas las capacidades tienen el mismo grado de disponibilidad: Carson, Maya, Dr. Quinn, Victor y Sophia tienen workflows documentados; **Caravaggio ya existe como agente, pero sus workflows de presentaciones aparecen todavía en desarrollo**\. La interfaz debe distinguir entre agente disponible y workflow disponible, sin ocultar ninguno. Fuentes: [github.com](https://github.com/bmad-code-org/bmad-module-creative-intelligence-suite/blob/main/README.md?utm_source=chatgpt.com) y [github.com](https://github.com/bmad-code-org/bmad-module-creative-intelligence-suite/blob/main/docs/reference/agents.md?utm_source=chatgpt.com)\.

Esto establece el catálogo de agentes que debe explorarse uno por uno en la V1.0, sin reducirlo a Carson.

El portal de Product Design ya está abierto en Chrome en el entorno persistente. También quedó conservado en el repositorio junto con el diseño acumulado y el inventario de fuentes visoespaciales.

## 1\. Interfaz local disponible

(Abierto y verificado)

**Portal Product Design · CIS**

# [127.0.0.1](http://127.0.0.1:8766/?utm_source=chatgpt.com)

Catálogo local de agentes, fases y configuraciones colaborativas.

---

**BMAD Brain Selector original**

## [127.0.0.1](http://127.0.0.1:8765/brain-selector.html?utm_source=chatgpt.com)

108 técnicas, 13 categorías y tres modalidades. Se sirve directamente desde BMAD 6.12.4, sin modificar su archivo original.

El portal nuevo presenta los seis agentes oficiales\:

| Agente | Área |
|--------|--------|
| Carson | Brainstorming |
| Maya | Design Thinking |
| Dr. Quinn | Creative Problem Solving |
| Victor | Innovation Strategy |
| Sophia | Storytelling |
| Caravaggio | Comunicación visual y presentaciones |

También incluye Creative Squad, Design Pair y las cinco áreas de trabajo para ampliar posteriormente la navegación por fases.

**Importante: son dos productos distintos.**

- Brain Selector es un recurso HTML existente de BMAD.
- El portal CIS es una interfaz local que construí para reunir el catálogo de agentes y abrir los recursos adecuados.
- Brainstorm HTML Keepsake es un documento que BMAD genera al finalizar una sesión, no otra aplicación preinstalada.

La integración completa de CIS todavía no está instalada. Por ahora, Carson enlaza con el selector funcional y las opciones de los demás agentes producen invocaciones para ChatGPT. No voy a presentarlas como workflows que ya se ejecutan localmente.

El lanzador reproducible quedó en\:

`MOD-EP-PRODUCT-DESIGN\launchers\Start-BMAD-BrainSelector-EP.ps1`

Se comprobó nuevamente el 13 de noviembre a las 12:01, con HTTP 200 en ambos servidores, bajo `CENTRAL\fila4` y el perfil persistente de Chrome EP.

## 2\. Capacidades visoespaciales recuperadas

La categoría paraguas propuesta es\:

**Cognición visoespacial y proyección visual**

El inventario localizado en el GOW contiene estas once operaciones\:

1. Contenencia.
2. Orden y gradación.
3. Proximidad y semejanza.
4. Jerarquía y composición.
5. Flujo y causalidad.
6. Tensión y trade-off.
7. Centro y periferia.
8. Magnitud y peso.
9. Evolución temporal.
10. Correspondencia y analogía.
11. Hueco y ausencia: el espacio negativo.

Además, el documento propone tratar la transición animada entre representaciones como una operación propia: conservar la identidad de los elementos mientras cambia su disposición.

Encontré también los tres componentes de la TCV\:

**Tríada de Proyección Visual**

**1\. GRP persistente**

El sustrato de información y relaciones.

**2\. Selector semántico**

El modelo determina qué proyección resulta pertinente, sin convertirse en el dibujante de la interfaz.

**3\. Renderizador reactivo**

Aplica la gramática visoespacial y preserva la identidad de los nodos entre representaciones.

También quedó separado **D-PROY / VIS-COG-01**, previsto históricamente fuera de Khora 0.9 y 0.9.1, y el PVE (Protocolo de Variación Eidética), que no debe confundirse con proyección visual.

IAR queda fuera de esta implementación. Se conserva únicamente como referencia relacionada, porque su función es otra: ideación dispersa recuperable a lo largo del tiempo.

(Etapa posterior) La categoría visoespacial queda ubicada después de los componentes esenciales del Frente Product Design. No le asigné un número de secuencia ni desplacé las prioridades inmediatas.

## 3\. Persistencia en el repositorio

(Read-back verificado)

Se añadieron dos documentos\:

- [github.com](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/DISENO-ACUMULADO-BMAD-PRODUCT-DESIGN.md?utm_source=chatgpt.com)
- [github.com](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/FUENTES-CAPACIDADES-VISOESPACIALES.md?utm_source=chatgpt.com)

Y quedaron versionados\:

- [github.com](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/app/index.html?utm_source=chatgpt.com)
- [github.com](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/launchers/Start-BMAD-BrainSelector-EP.ps1?utm_source=chatgpt.com)
- [github.com](https://github.com/SeryMente/metodologia/blob/main/frentes/ep/modulos/MOD-EP-PRODUCT-DESIGN/README.md?utm_source=chatgpt.com)

main · HEAD verificado: ac81415702b967216b88039c2ebf43a00cad2e85

## 4\. Límites de la revisión de Notion

La recuperación fue amplia y permitió leer las fuentes primarias, documentos de planeación, comparativas y antecedentes relacionados. También excluí falsos positivos, como el lienzo de la arena adversarial de RAP-MMD.

Pero no voy a declarar que se revisó literalmente el 100% del workspace: el conector no proporcionó una enumeración completa y una exportación integral de cada página y bloque. El documento de fuentes registra expresamente esa limitación. La categoría está persistida, pero su cobertura documental total permanece pendiente de certificación.

## 5\. Estado del trabajo

**Persistido y verificado\:** portal local, lanzador, diseño acumulado, inventario visoespacial y corrección de nomenclatura en el README.

**Pendiente\:** instalación de todos los agentes CIS, alineación de versiones BMAD 6.12.4/6.13.0, integración de sus workflows y automatización del disparador ChatGPT → RDC.

No creé tareas provisionales, no modifiqué Notion y no cambié el estado de EP-TASK-008. La corrección de «vMAT» quedó registrada en la documentación activa; los nombres históricos de archivos y carpetas se mantienen hasta una migración documental separada.

---

**IPZ\:** v0.7 · 2026-11-13 · d.h.m NO VERIFICADO
**DUG\:** versión, firma y antigüedad NO VERIFICADAS
**CONV / OCP\:** NO ASIGNADOS
**CICLO / OCP\:** NO ASIGNADOS
**A\:** dictado del operador de este turno; origen conversacional.
**B\:** portal, lanzador y documentos versionados; read-back verificado.
**Folios\:** NO ASIGNADOS.
