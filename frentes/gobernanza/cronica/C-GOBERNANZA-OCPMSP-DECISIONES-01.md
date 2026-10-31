# C-GOBERNANZA-OCPMSP-DECISIONES-01 — Decisiones de Gobernanza para OCPMSP

**Fecha:** 2026-10-31. **Estado:** resolución de diseño aprobada; transferencia técnica pendiente.

## Adquisición y autoridad

Se leyó main en b0d22046b0e180f82f6c6219826841643c1a10f5. DUG Samantha v373 / NX-373m, blob cac4525de77d4f47a8a59c25201968ecf2056b90. El control Gobernanza estaba activo en generación 8 y el control MCP-METODOLOGIA estaba owned en generación 1, bajo un alias distinto. No se modificó el control MCP.

La fuente canónica confirma ART-027: inventario MDP de 43 principios, consulta obligatoria de norma desarrollada por Sink y telemetría de frecuencia. El texto desarrollado continúa dentro de gov-data; los aliases estáticos p001-p043 son diseño documental, no enlaces activos. La fuente estructurada no ofrece todos los metadatos formales de aplicabilidad/dependencias solicitados.

## Resolución

Se determina que OCPMSP es el motor/servicio del OCP MCP-METODOLOGIA existente, no un OCP independiente. Se aprueba el diseño de cifrado de la segunda capa dentro del mismo DUG, con clave exclusivamente local bajo DPAPI/ACL y sin exponerla al modelo. No se modifica el DUG.

Se aprueba que los metadatos de aplicabilidad, obligatoriedad, activación y dependencias sean explícitos, aprobados por Gobernanza y alojados en el DUG canónico; el servidor no los inferirá. El CNP P001/P004/P005/P038/P043 será incluido incondicionalmente. La clasificación deberá cubrir 43/43; los inciertos se incluyen; las dependencias cíclicas consistentes se agrupan y las contradicciones/no verificables que impidan cerrar selección bloquean la atestación.

Se aprueba como diseño objetivo el uso de 43 aliases por ciclo/intento con sufijo opaco no secreto. Requiere actualización posterior de ART-027 antes del despliegue. Se aprueba receptor HTTPS mínimo separado del núcleo, con verificación HMAC y sin acceso a contenido normativo; polling queda como alternativa degradada con telemetría parcial cuando aplique. El comprobante distingue completitud de atestación y cobertura Sink.

Se aprueba BLOCKED_OCPMSP fail-closed, integrado en ART-027 y adaptadores de clientes. Ningún cliente no integrado puede ejecutar operaciones protegidas. Se aprueba el contrato de estados, operaciones, controles criptográficos y pruebas descrito en la salida final.

EP recibe requisitos de alojamiento en <Escritorio real Windows>\SeryMente\OCP\OCPMSP, identidad de proceso, ciclo de vida, ACL, DPAPI, loopback/transporte, health, backup y actualización. EP no es responsable del motor. RDC no es transporte exclusivo.

## Titularidad y límites

El control MCP-METODOLOGIA permanece generación 1, estado owned, con titular diferente y alcance documental. Esta resolución no transfiere su titularidad ni amplía su alcance. Antes de autorizar especificación ejecutable, código, instalación, credenciales, pruebas e integración se requiere transferencia explícita, nueva generación, ampliación de alcance, compare-and-swap por SHA y lectura de retorno.

No se modificaron DUG, ART-027, ART-025, IPZ, controles MCP/EP, Sink, Cloudflare ni recursos externos. No se activó MCP-NORMATIVO. No se ejecutaron pruebas ni se declara implementación.

## Persistencia documental

Se recibió el original ChatGPT-GOBERNANZA-20261031-1043.md desde RDC y se copia sin transformación a documentos/originales. El manifiesto, la evidencia y el read-back se completan tras publicación y cotejo remoto.