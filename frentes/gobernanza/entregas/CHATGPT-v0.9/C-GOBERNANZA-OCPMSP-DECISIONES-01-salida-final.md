# C-GOBERNANZA-OCPMSP-DECISIONES-01 — Resolución normativa, titularidad y contrato de dos capas

**Fecha:** 2026-10-31  
**Frente decisor:** Gobernanza  
**Frente coordinado:** MCP de Metodología / OCPMSP  
**Estado:** decisiones de diseño aprobadas; transferencia del OCP MCP pendiente; implementación no autorizada.  
**Folio global de ciclo:** PENDIENTE/NO ASIGNADO. FOL1 continúa PREPARADO_PENDIENTE_ACTIVACION_IPZ.

## 1. Base canónica y límites

Se adquirió desde main el DUG Samantha v373, sello NX-373m, en gobernanza/METAPROMPT-CANONICO-SAMANTHA.html. Blob observado: cac4525de77d4f47a8a59c25201968ecf2056b90. Commit main observado: b0d22046b0e180f82f6c6219826841643c1a10f5. La fuente incluye 43 principios, 20 anexos y 43 MDP. ART-027 establece un inventario MDP y consulta obligatoria de la norma desarrollada mediante Sink, pero la telemetría actual solo mide frecuencia de acceso. El contenido desarrollado sigue embebido en gov-data en claro. La proyección estructurada actual no define de forma explícita todos los campos de aplicabilidad, activación, obligatoriedad y dependencias.

Esta resolución no modifica el DUG, IPZ, ART-025, ART-027, el control de MCP-METODOLOGIA, el control de EP, Sink ni recursos externos. No activa MCP-NORMATIVO.

## 2. Titularidad e identidad

Aprobado: OCPMSP es el motor/servicio local del OCP existente MCP-METODOLOGIA. No se crea un OCP separado ni una segunda carpeta de control. Se conservan frentes/mcp-metodologia/, MCP-METODOLOGIA.md y CONTROL-RESPONSABILIDAD.json. OCPMSP identifica funcionalmente el motor de autorización, sincronización, custodia y atestación.

Pendiente: el control MCP observado está en estado owned, generación 1, bajo un alias distinto, con alcance documental que no autoriza código, instalación, puertos, credenciales, acceso RDC a un equipo concreto ni despliegue. La titularidad no se transfiere por este encargo de Gobernanza. Antes de autorizar especificación ejecutable, código, instalación, credenciales, pruebas e integración se requiere transferencia explícita del control MCP, incremento de generación, ampliación expresa del alcance, compare-and-swap por SHA inmediatamente observado y lectura de retorno. No se modificó el control MCP.

## 3. Aislamiento de las dos capas

Aprobado para estudio y especificación: sustituir el texto desarrollado en claro de gov-data por un payload cifrado dentro del mismo DUG canónico. El DUG continúa siendo la única fuente normativa. La capa humana conserva 43 IDs, nombres canónicos y MDP; el payload contiene los 43 textos desarrollados y los metadatos normativos aprobados. El contenido cifrado no debe renderizarse como norma legible en clientes sin autorización.

Aprobado: la clave de descifrado reside exclusivamente en el servidor local, fuera de Git y del contexto del modelo. Custodia bajo identidad Windows autorizada, DPAPI, ACL restrictivas, rotación y recuperación documentadas; prohibido exponer la clave por MCP o escribir plaintext en logs, temporales o cachés no protegidas.

La lectura humana del DUG se mantiene mediante HTML legible, inventario MDP, metadatos de versión e integridad y documentación humana del mecanismo. Un lector sin clave puede comprender la estructura y pertinencia, no recuperar la norma desarrollada.

Límite: diseño autorizado; no se modificó el DUG.

## 4. Aplicabilidad, obligatoriedad y dependencias

La única fuente autorizada para definir obligatoriedad, activadores, aplicabilidad y dependencias es el DUG canónico, mediante metadatos explícitos aprobados por Gobernanza. El servidor no inferirá esos metadatos desde el texto, MDP, memoria o patrones históricos.

El esquema objetivo por principio deberá contemplar applicability, activation_conditions, mandatory, dependencies, exclusiones justificadas, versión de metadatos y referencia de aprobación. Los metadatos forman parte de la fuente normativa estructurada y se protegen en la segunda capa.

La clasificación de cada ciclo debe contener exactamente 43 IDs únicos, cada uno con APLICA, NO_APLICA o INCIERTO y justificación. La selección incluye APLICA, INCIERTO, los cinco CNP y el cierre transitivo de dependencias obligatorias. Los cinco CNP P001, P004, P005, P038 y P043 se incluyen incondicionalmente, incluso si uno aparece clasificado NO_APLICA; el servidor conserva la clasificación y registra la regla de inclusión obligatoria.

Dependencias cíclicas consistentes se agrupan en componentes fuertemente conexos y se tratan como unidad. Dependencias contradictorias, inexistentes o no verificables que impidan cerrar el conjunto bloquean la atestación; no se inventan precedencias ni se eliminan dependencias para forzar liberación.

## 5. Sink y telemetría

Aprobado como diseño objetivo: 43 aliases por ciclo/intento, conservando P001–P043 y usando sufijo aleatorio opaco no secreto, no reutilizable y sin folio, conversación o identidad personal. El formato conceptual es p001-<sufijo-opaco>. La decisión requiere alinear ART-027 antes de despliegue; el esquema actual p001-p043 no se considera sustituido en el DUG por esta resolución.

Aprobado: receptor HTTPS mínimo separado del núcleo local, que verifica firma HMAC de Sink, aplica control temporal y deduplicación y almacena solo metadatos de eventos. No tiene acceso al contenido normativo, clave de descifrado, autoridad de ciclo ni capacidad de liberación. Sink no puede llamar directamente a localhost.

Aprobado como alternativa degradada: polling de analítica si no se despliega receptor HTTPS. Debe declararse su muestreo, ventana y posibilidad de pérdida. Polling no equivale a telemetría completa.

El comprobante diferencia integridad de atestación y cobertura Sink. El estado de telemetría será COMPLETE, PARTIAL o UNAVAILABLE. El comprobante firmado describe lo observado y las pérdidas. La entrega normativa y los recibos locales verificables son obligatorios; la recepción de todos los webhooks best-effort no es condición de liberación. Ningún clic prueba lectura consciente, comprensión o aplicación.

## 6. Bloqueo fail-closed

Se aprueba BLOCKED_OCPMSP como resultado obligatorio cuando el servidor no responde o no puede verificar autorización, snapshot, paquete o recibos. Debe integrarse en la futura revisión de ART-027 y en adaptadores/wrappers de clientes. La operación protegida no puede ejecutarse antes de obtener liberación verificable.

No son bypass válidos memoria, texto recordado, caché antigua, descarga directa desde Git, acceso al payload cifrado, servidor alternativo no autorizado ni declaración manual de éxito. Se permite diagnóstico no normativo, no la operación protegida.

Quedan sujetos todos los clientes que ejecuten operaciones sometidas a la Metodología: ChatGPT, Claude, Codex, clientes MCP, IDE, terminal y agentes futuros. Los no integrados se marcan no conformes/no integrados y no pueden ejecutar operaciones protegidas. Una instrucción conversacional sin enforcement técnico no satisface esta compuerta.

## 7. Contrato exigido al motor

Máquina principal: OPEN → SELECT_AND_AUTHORIZE → SYNC_BUNDLE → ATTEST_AND_RELEASE. Estados auxiliares: BLOCKED_OCPMSP, REJECTED, SYNC_FAILED, ATTESTATION_INCOMPLETE y RELEASED.

Operaciones lógicas mínimas: open_cycle, classify_principles, authorize_selection, build_snapshot, sync_bundle, attest_delivery, release_cycle, get_receipt y get_health.

Controles: HMAC-SHA-256, nonce aleatorio de un uso, vínculo con ciclo/intento, vencimiento, consumo atómico, inventario y snapshot calculados por servidor, paquete único e integral sin paginación ni rutas individuales, recibo de entrega y firma Ed25519 verificable del comprobante. La firma acredita integridad y procedencia, no comprensión interna del modelo.

Pruebas obligatorias: inventario 43/43; CNP incluso NO_APLICA; INCIERTO y cierre de dependencias; selección manipulada; snapshot de servidor; autorización vencida/repetida; concurrencia de un solo ganador; paquete integral; interrupción sin liberación; HMAC inválido y replay; pérdida webhook reflejada como parcial; firma verificable; desconexión produce BLOCKED_OCPMSP sin bypass. Ninguna prueba se declara ejecutada en esta resolución.

## 8. Interfaz normativa para EP

Ruta objetivo: <Escritorio real del usuario Windows>\SeryMente\OCP\OCPMSP. EP define y verifica la ruta real, identidad del proceso, ciclo de vida, ACL, custodia DPAPI, loopback/transporte, health checks, backups, recuperación y actualización. La identidad del proceso debe ser la única con acceso a la clave protegida. Preferir alcance DPAPI CurrentUser bajo identidad dedicada o equivalente mínimo; evitar LocalMachine amplio sin justificación. Documentar recuperación de claves y protección de backups.

El transporte debe limitarse a stdio/local o loopback autenticado según pruebas; no abrir escucha LAN ni exposición pública por defecto. Debe considerar token local por inicio, validación de origen/CSRF cuando aplique, ACL y aislamiento de procesos. EP no diseña ni asume la responsabilidad del motor OCPMSP. RDC es un mecanismo de administración disponible, no transporte único ni requisito arquitectónico.

## 9. Cambios autorizados y exclusiones

Autorizado ahora: diseño y especificación normativa de las decisiones anteriores; persistencia documental de este registro y del original de conversación.

No autorizado ahora: modificación del DUG/ART-027/IPZ/ART-025; cambio del control MCP o EP; código, instalación, puertos, secretos, credenciales, bases de datos, despliegue Sink/Cloudflare, receptor HTTPS productivo, activación MCP-NORMATIVO o pruebas en entornos reales. Esas acciones requieren titularidad y autorización específicas.

## 10. Estado

Decisiones de diseño aprobadas: A1-A2, B4-B6, C7-C10, D11-D14, E15-E17 y contrato de interfaz. Pendiente: transferencia del control MCP generación 1 y ampliación de alcance; diseño detallado y revisión; alineación normativa posterior de ART-027; coordinación formal con EP; especificación y pruebas. No se declara canonización normativa ni implementación.

**DUG observado:** Samantha v373 / NX-373m. **GOW:** 2.14 según el control del OCP MCP. **FOL1:** PREPARADO_PENDIENTE_ACTIVACION_IPZ. **Folio global:** PENDIENTE/NO ASIGNADO.