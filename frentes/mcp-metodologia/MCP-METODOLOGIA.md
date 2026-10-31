# MCP de Metodología · Objeto Canónico de Persistencia

## 1. Control e identidad

- **Nombre canónico:** MCP de Metodología.
- **Identidad:** MCP-METODOLOGIA.
- **Versión/sello:** MCP-METODOLOGIA-v0.1.0 · núcleo inaugural.
- **Repositorio propietario:** SeryMente/metodologia, rama main.
- **OCP canónico:** frentes/mcp-metodologia/.
- **Núcleo operativo único:** este archivo, MCP-METODOLOGIA.md.
- **Control autoritativo:** CONTROL-RESPONSABILIDAD.json.
- **Evento constitutivo:** C-MCP-METODOLOGIA-001. Es un identificador local de evento, no un folio global.
- **Sesión:** UUIDv7 local 01a192b3-1063-7916-be41-ebfa974ede73; alias operativo chatgpt-C-MCP-METODOLOGIA-001-01a192b3-1063-7916-be41-ebfa974ede73. No es un ID nativo de ChatGPT.
- **Titularidad inicial:** adjudicada a esta instancia por instrucción expresa de apertura; control generación 1.
- **Folio de conversación/ciclo/A/B:** PENDIENTE/NO ASIGNADO. FOL1 continúa PREPARADO_PENDIENTE_ACTIVACION_IPZ; no se fabrican secuencias ni asignaciones.
- **Estado de persistencia:** creación documental en main, condicionada a lectura de vuelta y cotejo de todos los archivos del evento.

## 2. LEER PRIMERO

Antes de cada ciclo sustantivo:

1. Adquirir desde SeryMente/metodologia/main el DUG único y vigente, el Metacanon integrado y el GOW; comprobar revisión, versión y huellas reales.
2. Aplicar manualmente la cascada de Sam y consultar los principios pertinentes. Considerar expresamente el CNP, sin sustituir el DUG completo.
3. Leer este núcleo y CONTROL-RESPONSABILIDAD.json. Mutar solo mientras la titularidad corresponda a la sesión/alias registrado y la generación observada siga vigente.
4. Mantener la distinción entre este **servidor MCP de Metodología** y el estado **MCP-NORMATIVO: DESACTIVADO** del DUG. La creación de este frente no activa verificación normativa automática, no modifica el DUG ni acredita una ejecución de ese mecanismo.
5. Mantener separado este OCP del frente Khora MCP en SeryMente/khora. No importar sus herramientas, datos, secretos, autorizaciones, infraestructura Vercel ni titularidad.
6. El destino arquitectónico dictado para el servicio es local: operación por localhost y/o mediante administración remota autorizada por RDC. RDC es una vía de administración del equipo, no una autorización automática ni una razón para exponer el servicio a Internet.
7. Registrar originales, crónica y evidencia por evento; releer la ruta canónica y cotejar antes de declarar persistencia.

## 3. Referencia metodológica

- **DUG:** Samantha v373 · NX-373m.
- **Metacanon:** 1.26, sello METACANON-OBJETOS-v1.26.
- **GOW:** 2.14.
- **Fuente normativa única:** gobernanza/METAPROMPT-CANONICO-SAMANTHA.html en main.
- **Blob del DUG adquirido:** cac4525de77d4f47a8a59c25201968ecf2056b90.
- **Commit main de referencia al crear:** f74082148d28b575c232e8fc291607bef8861794.
- **Registro maestro FOL1 leído:** ambitos/gestion-conversacional/REGISTRO-MAESTRO-FOLIACION.json, blob b93cbef77f2fa1a6e4290ae8177e957a1616e47b; estado PREPARADO_PENDIENTE_ACTIVACION_IPZ.
- **Método aplicado:** Metacanon §§2–7, 27–31, 39, 42, 46–48 y 51; principios Sam P001/P038/P004/P005/P037/P035/P041/P042/P043, entre otros pertinentes.
- La versión adquirida es una línea de base de creación, no garantía de vigencia futura. Revalidar main en cada ciclo.

## 4. Propósito y alcance

### Propósito original dictado por el operador (verbatim)

> Ok, esa es una buena pregunta. El MSP de metodología es el MSP que va a absorber, por ejemplo, las tareas de desarrollo y que no forman parte del ámbito del alcance de la prótesis cognitiva. Es decir, Cora tiene su MSP, por ejemplo, para servirle a los modelos un acceso a los dictados, un acceso a los medios de persistencia en la nube, a descargar MP3, al grafo de relaciones, es decir, cosas que tienen que ver con Cora. Pero necesitamos un MSP de la metodología OCP para tareas de desarrollo, por ejemplo, verificación de gobernanza para los modelos sometidos bajo la metodología, etcétera, etcétera. Son dos ámbitos muy heterogéneos y conviene tenerlos por separado. Además, OCP necesita un MSP local que trabaje por localhost o por RDC y Cora está de cara al internet mediante Vercel, entonces por eso la separación.

**Procedencia:** mensaje directo U002 de C-MCP-METODOLOGIA-001, conservado literalmente en conversaciones/C-MCP-METODOLOGIA-001-dialogo.jsonl. El primer encargo U001 denominó al frente «OCP MCP». El dictado U002 conserva la forma «MSP»; la identidad canónica MCP de Metodología sigue la denominación del encargo inicial y no reescribe el original.

### Lectura operativa separada

El frente mantiene y desarrolla un servidor bajo Model Context Protocol (MCP) para apoyar tareas de desarrollo y gobernanza de los objetos, repositorios y modelos que trabajan bajo la Metodología de Ser y Mente. Su ámbito es distinto del servidor MCP de Khora, cuyo propósito se limita a ofrecer a los modelos capacidades propias de la prótesis cognitiva, por ejemplo dictados, medios de persistencia en la nube, descarga de MP3 y grafo de relaciones.

El destino de ejecución requerido para el MCP de Metodología es local, accesible mediante localhost y/o administrado a través de una conexión RDC autorizada. No se diseña como endpoint público Vercel por defecto. El protocolo de transporte local, el proceso anfitrión, el cliente MCP, la autenticación local y la gestión de permisos siguen pendientes de especificación y prueba.

El usuario empleó «Cora» en el original. La lectura operativa lo refiere a Khora por el contexto del repositorio y su denominación canónica; el original permanece intacto.

### De dónde viene

Surge de la instrucción expresa de inaugurar un OCP MCP en el repositorio de Metodología y del dictado constitutivo U002. La separación se fundamenta en dos dominios funcionales heterogéneos y en dos superficies de operación diferentes: desarrollo/gobernanza local de Metodología frente a capacidades de la prótesis cognitiva publicadas por Khora.

### Dónde está

Este OCP se materializa en SeryMente/metodologia/frentes/mcp-metodologia/. En la línea base consultada no existía esa ruta. El repositorio contenía frentes/mcp-jules/ con una crónica histórica aislada, sin núcleo operativo ni control; se conserva solo como antecedente no adjudicado, no como estado activo ni como autorización.

El frente Khora MCP existente permanece en SeryMente/khora/docs/frentes/observabilidad-mcp/, con núcleo propio y control de responsabilidad generación 4. Este OCP no lo duplica, no lo modifica ni asume su control.

### A dónde va

Concretar un servidor MCP local que proporcione capacidades reutilizables para tareas de desarrollo y gobernanza bajo la Metodología, con acceso controlado a las fuentes canónicas y evidencia recuperable. La forma de exposición local, el conjunto de herramientas, los scopes, los límites de escritura y el entorno de ejecución se decidirán y probarán antes de implementación.

### Qué cambió

El propósito quedó dictado y el frente pasó de propuesta bloqueada por §39 a OCP documental creado. Quedaron establecidas su identidad separada, su localización en el repositorio Metodología y la distinción respecto de Khora MCP. No se creó código, ejecutable local, servicio, puerto, integración cliente ni despliegue.

### Incluido

- Infraestructura MCP orientada a tareas de desarrollo que no pertenecen al ámbito funcional de la prótesis cognitiva Khora.
- Capacidades para consultar, inspeccionar y apoyar la verificación de gobernanza de los modelos sometidos a la Metodología, sujetas a especificación y a la autoridad vigente del DUG.
- Operación local mediante localhost y administración/operación del equipo por RDC autorizado cuando sea necesario y permitido.
- Descubrimiento y consulta de los objetos OCP, sus núcleos, registros y evidencia de gobernanza, bajo permisos y contratos específicos que quedan por definir.
- Diseño de herramientas, contratos, autenticación, autorización, registros, pruebas, versionado y continuidad del servicio local.

### Excluido

- Capacidades específicas de Khora como dictados, captura/transcripción, persistencia en nube de la prótesis, descarga de MP3 y grafo de relaciones.
- Sustituir, duplicar, migrar o modificar el OCP/control del frente Khora MCP.
- Exposición pública a Internet, despliegue en Vercel o apertura de puertos no-loopback sin una decisión y autorización posteriores específicas.
- Activar o afirmar el uso de MCP-NORMATIVO, actualmente DESACTIVADO en el DUG. Una posible capacidad futura de verificación no cambia por sí misma el estado normativo ni autoriza una enmienda a Sam.
- Lectura, escritura, gasto, instalación, credenciales, cambios de sistema o ejecución en un equipo real sin preflight, permisos y autorización aplicables.
- Heredar scopes, credenciales, endpoints o permisos del servidor Khora por semejanza nominal.

### Criterios de aceptación del frente

1. OCP, núcleo y control propios en SeryMente/metodologia, sin colisión con Khora MCP.
2. Servicio operativo en entorno local probado; la conexión por localhost queda limitada a loopback y/o el transporte stdio/local equivalente se especifica con evidencia.
3. RDC se usa solo mediante conector, cuenta, dispositivo, equipo, necesidad y autorización verificados; no se presupone conectado.
4. Herramientas de gobernanza recuperan la fuente canónica de main y distinguen revisión, evidencia, inferencia y estado no verificado.
5. Permisos mínimos, separación entre lectura/escritura y controles fail-closed probados; ningún secreto se guarda en Git.
6. El estado MCP-NORMATIVO permanece DESACTIVADO hasta que exista autorización normativa expresa y un cambio canónico verificable, si ese cambio resulta necesario.
7. Pruebas funcionales, negativas, de seguridad, de continuidad y de lectura de vuelta aprobadas; el cierre se documenta en este OCP.

## 5. Roles y colaboración

- **Operador:** propietario del propósito, prioridades y decisiones de alcance; concede autorizaciones materiales.
- **Titular operativo inicial:** la instancia identificada por el alias registrado en CONTROL-RESPONSABILIDAD.json, únicamente para la inicialización documental y continuidad autorizada del frente.
- **Asistente:** mantiene contexto, adquiere metodología, investiga, diseña, revisa evidencia y registra ciclos.
- **Constructor/desarrollador:** no se ha asignado una instancia ni persona. Ninguna herramienta externa o agente recibe permisos por inferencia.
- **Khora MCP:** frente independiente relacionado por separación de dominio, no subordinado ni fuente de titularidad de este OCP.

## 6. Autoridad

### Autorizado en la creación

La instrucción directa U001 autoriza inaugurar un frente OCP MCP en el repositorio de Metodología. El dictado U002 constituye el propósito y delimita la separación funcional y el requisito de ejecución local. Se autoriza crear la carpeta OCP, su núcleo único, el control inicial y los registros documentales necesarios, así como actualizar los índices del repositorio.

### No autorizado por esta creación

Esta inauguración no autoriza modificar el DUG, activar MCP-NORMATIVO, implementar código, instalar dependencias, iniciar un proceso local, abrir un puerto, configurar autenticación, provisionar secretos, modificar bases de datos, usar RDC en una máquina concreta, desplegar públicamente ni alterar recursos de Khora. Cada acción requiere su propio preflight, permisos y autorización según el caso.

Las autorizaciones futuras deberán quedar vinculadas a la operación concreta y registradas en este OCP. Las propuestas no equivalen a aprobaciones.

## 7. Perfil de entorno

- **Repositorio:** SeryMente/metodologia, privado, rama main.
- **Ruta del OCP:** frentes/mcp-metodologia/.
- **Entorno local de ejecución:** NO VERIFICADO; no se inspeccionó ninguna máquina local en este ciclo.
- **RDC:** no utilizado en esta creación. La disponibilidad de un conector, cuenta o equipo actual no fue comprobada.
- **Transporte local:** pendiente de elegir entre stdio/local y/o HTTP limitado a localhost, mediante diseño y prueba.
- **Exposición pública/Vercel:** no configurada ni autorizada por este evento.
- **Credenciales/secrets:** no creados, consultados ni materializados.
- **Khora:** OCP referenciado en SeryMente/khora; su control, credenciales y permisos permanecen fuera de este frente.

## 8. Estado vivo

**Acción en curso:** OCP MCP de Metodología inaugurado documentalmente.

**Siguiente paso:** elaborar la especificación funcional mínima del servidor local: actores/clientes, herramientas de desarrollo y gobernanza, fuentes OCP permitidas, límites lectura/escritura, transporte local, autenticación y estrategia de pruebas.

**Hechos verificados:** ruta OCP nueva ausente en la línea base; OCP Khora MCP existente identificado en otro repositorio; propósito U002 conservado; gobierno DUG v373 / Metacanon 1.26 / GOW 2.14 adquirido.

**No realizado:** código, instalación, proceso localhost, conexión RDC, conexión MCP cliente, herramientas activas, autenticación, pruebas, despliegue e integración.

**Folio:** conversación/ciclo/A/B globales y por OCP pendientes porque FOL1 no está activado.

## 9. Aceptación y viabilidad

La aceptación actual es exclusivamente documental: identidad, propósito, separación, gobierno, control y evidencia del OCP. El producto MCP local todavía no está construido ni aceptado.

El trabajo técnico es viable en principio, pero la forma concreta de transporte, host, cliente, acceso a fuentes, permisos y conjunto de herramientas no se ha especificado ni comprobado. La siguiente fase debe convertir las categorías generales dictadas por el operador en requisitos observables sin ampliar el propósito.

Los criterios terminales están definidos en el bloque 4. Ningún estado de aceptación se presume por la creación de esta carpeta o por la existencia del servidor Khora.

## 10. Formato de ciclo

Aplicar en cada ciclo los diez campos de Metacanon §4: identidad y gobierno; dónde estamos; actualización/delta; qué avanzó; qué falta; viabilidad; tiempo/ciclos; siguiente acción; continuación; persistencia.

Siempre declarar Sam, Metacanon y GOW adquiridos; revisión/commit; cascada revisada manualmente; MCP-NORMATIVO: DESACTIVADO; estado del control y generación; folio SES si y solo si existe asignación válida; y folios globales/OCP de conversación, ciclo, A y B cuando FOL1 esté activado.

Mientras FOL1 continúe PREPARADO_PENDIENTE_ACTIVACION_IPZ, la foliación se declara PENDIENTE/NO ASIGNADO. No usar C001 como folio global; es solo un ID de evento local.

## 11. Crónica y fuentes

- **Evento de creación:** C-MCP-METODOLOGIA-001.
- **Originales:** conversaciones/C-MCP-METODOLOGIA-001-dialogo.jsonl.
- **Crónica:** cronica/C-MCP-METODOLOGIA-001.md.
- **Evidencia:** evidencias/C-MCP-METODOLOGIA-001.json.
- **Fuente normativa:** ../../gobernanza/METAPROMPT-CANONICO-SAMANTHA.html.
- **Inventario multi-repositorio:** ../../INVENTARIO-REPOSITORIOS-Y-FRENTES.md.
- **Khora MCP independiente:** https://github.com/SeryMente/khora/blob/main/docs/frentes/observabilidad-mcp/OBJETO-CANONICO.md.
- **Control Khora MCP observado:** https://github.com/SeryMente/khora/blob/main/docs/frentes/observabilidad-mcp/CONTROL-RESPONSABILIDAD.json.
- **Antecedente metodológico mcp-jules:** frentes/mcp-jules/cronica/C-MCP-JULES-004.md; no es el núcleo ni control de este OCP.

Los archivos citados como fuentes no son control, núcleo ni estado vivo paralelos. Las conversaciones y crónicas aportan procedencia e historia; este archivo contiene el estado vigente.

## 12. Reinstanciación

Una instancia nueva debe leer INICIO.md, DUG, Metacanon y GOW desde main; después README.md, CONTROL-RESPONSABILIDAD.json y este núcleo. Aplicar preflight P037/Metacanon §42 y comprobar generación/titularidad antes de cualquier mutación. La titularidad actual solo se conserva mientras el control la identifique.

El primer ciclo de cada sesión debe recuperar la última salida visible del modelo efectivamente conservada en este OCP; si no existe, declararla NO DISPONIBLE/NO VERIFICADA sin reconstrucción. La reinstanciación no importa estado, credenciales ni permisos desde Khora.

No se asignó constructor ni segundo rol. No emitir dos prompts de roles que no existen.

## 13. Persistencia y revisión

Este OCP contiene un solo núcleo operativo y un solo CONTROL-RESPONSABILIDAD.json. README es índice; conversaciones conserva originales; crónica conserva narrativa; evidencia conserva recibos y huellas. Ninguna de esas materializaciones es un segundo estado vivo.

En cada ciclo sustantivo, conservar entradas directas y salidas visibles disponibles, crónica, evidencia y checkpoint; leer de vuelta el mismo archivo/revisión y cotejar. No registrar razonamiento interno, secretos o IDs nativos no expuestos.

La sincronización automática no se presume. La autoridad documental del frente reside en las rutas de este OCP en main; las copias locales y otras superficies son subordinadas.

**Revisión inaugural:** pendiente de verificación mediante lectura de vuelta del commit de creación.
