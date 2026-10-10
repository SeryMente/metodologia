# Canon canónico de Entorno Persistente, Continuidad de Ejecución y Laboratorios Locales

**ID documental:** METODOLOGIA-EP-CANON  
**Versión del documento:** v1.0.0  
**Nombre de versión:** Canon Transversal EP, WP-LAB, OGP y Accesos Seguros  
**Estado:** CANON DOCUMENTAL TRANSVERSAL; certificación física y E2E pendientes según la matriz de evidencia de este documento.  
**Fecha de corte documental:** 2026-10-10  
**Repositorio propietario y fuente normativa transversal:** [SeryMente/metodologia](https://github.com/SeryMente/metodologia)  
**Ruta canónica:** `CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md`

> **Regla de autoridad:** este archivo es la única fuente canónica transversal para requisitos, decisiones, contratos de integración, estados, criterios de aceptación y secuencia de ejecución del esfuerzo de Entorno Persistente (EP) y sus laboratorios. Los documentos previos se conservan como antecedentes/evidencia histórica y deben enlazar aquí; no pueden establecer una norma transversal contradictoria. Los repositorios de producto conservan sus detalles de implementación, sujetos a este canon.

## 0. Instrucción de recuperación para cualquier agente o modelo

Si una tarea menciona Entorno Persistente, EP, EP híbrido, EP cifrado, sesión volátil, Cybernet/cibercafé, RDC, identidad de terminal, VHDX, BitLocker, junction, Deadman, WordPress local, WP-LAB, OGP, generación o edición de contenido visual, autenticación de Cora, OIDC, contraseña maestra, PowerShell administrativo o token de GitHub como secreto:

1. Leer este documento completo desde la rama activa de `main` de `SeryMente/metodologia`.
2. Leer el estado actual del Sistema de Instrucciones y de la Metodología desde `main`, aplicando el procedimiento de frescura definido por el repositorio. No confiar en versiones copiadas dentro de anexos antiguos.
3. Leer el registro vigente de contexto/terminal y los registros de verificación por ciclo aplicables.
4. Leer las especificaciones de implementación citadas en la sección 4 desde sus repositorios y ramas actuales.
5. Separar explícitamente requisitos, decisiones, implementación observada, pruebas ejecutadas, evidencia y pendientes.
6. No iniciar acciones destructivas, de autenticación, cifrado, credenciales o persistencia si no se cumplen los gates de identidad, autorización, destino y recuperación aplicables.
7. Al terminar cada ciclo, actualizar evidencia y pendientes; no declarar éxito por haber escrito documentación o código solamente.

Si este archivo no se puede recuperar o su frescura no puede comprobarse, declarar el contexto como no verificado y no sustituirlo por memoria conversacional.

## 1. Propósito, alcance y límites

El esfuerzo construye una capacidad de trabajo que sobrevive a sesiones y terminales efímeras, con laboratorios locales recuperables y flujos seguros de administración y publicación. Incluye:

- continuidad de trabajo y artefactos a través de reinicios, sesiones efímeras y cambios de terminal;
- identidad inequívoca de cada terminal y separación de esta respecto de ubicación, perfil Windows, sesión RDC y conversación;
- persistencia cifrada cuando corresponda, verificación de integridad, checkpoints y restauración;
- WordPress local y WP-LAB como laboratorio de contenido, experimentación y validación;
- capacidad complementaria de generación/edición de contenido para Otro Gran Programa (OGP), incluido contenido visual/IA cuando el hardware, los modelos y las licencias lo permitan;
- interfaces y flujos de Cora relacionados con autorización para comandos PowerShell y gestión segura de tokens GitHub;
- evidencias E2E que demuestren continuidad y recuperación, no solo la presencia de carpetas o código.

Este documento **no demuestra por sí mismo** que un volumen esté montado, que BitLocker esté activo, que un secreto esté guardado de forma segura, que WordPress pueda restaurarse ni que un comando privilegiado funcione. Es la fuente de requisitos y gobernanza; la certificación requiere evidencia reproducible del entorno concreto.

### 1.1 No objetivos

- No trasladar la propiedad metodológica a KHORA ni a Cora.
- No convertir la carpeta local de una sesión en fuente duradera por su nombre.
- No almacenar contraseñas, PAT, claves privadas, recovery keys, cookies, sesiones ni valores de secretos en este repositorio documental.
- No declarar que un mecanismo de autenticación se puede omitir sin un análisis de autorización y amenazas.
- No asumir que una base de datos, blob store o repositorio remoto ya guarda backups de WordPress, imágenes, pesos de modelos o volúmenes cifrados.
- No considerar una prueba de código aislada como prueba de recuperación física E2E.

## 2. Vocabulario normativo

- **EP:** conjunto de mecanismos de continuidad, persistencia, recuperación, contexto y controles para trabajar sobre entornos posiblemente efímeros.
- **EP volátil:** sesión de cómputo que puede desaparecer sin aviso; el sistema debe asumir que los datos locales no sobreviven.
- **EP híbrido:** combinación explícita de ejecución local/efímera con almacenamiento duradero autorizado y recuperación demostrada. No basta con tener una copia local y una remota sin verificar.
- **EP cifrado:** volumen o contenedor cuya protección criptográfica y ciclo de desbloqueo están comprobados mediante evidencia actual.
- **Terminal:** computadora física o instancia identificable de ejecución. La terminal conserva su identidad lógica aunque cambie el usuario, la conversación o la sesión RDC.
- **Sesión RDC:** canal de control remoto. No es la identidad de la terminal ni la identidad Windows efectiva.
- **Checkpoint:** punto de recuperación incremental, identificado y verificable; debe registrar cuándo se creó, qué cubre, destino, integridad y resultado de lectura de comprobación.
- **Deadman:** mecanismo de protección/recuperación ante pérdida de continuidad definido por la implementación. No se presume activo por estar documentado.
- **WP-LAB / EP-WP-LAB:** laboratorio WordPress local cuya configuración, contenido, medios, base de datos, plugins/temas permitidos y procedimiento de restauración se especifican y prueban.
- **OGP:** Otro Gran Programa, cuyo instrumento de comunicación puede requerir contenido complementario textual, visual o multimedia generado y validado en el laboratorio.
- **Secreto:** credencial o material confidencial que no debe quedar en código, documentación pública, logs, salida de consola, prompts persistentes ni commits.
- **Break-glass:** ruta excepcional de acceso de emergencia, limitada, auditable, revocable y sujeta a política explícita. No equivale a eliminar autenticación o autorización.

Las palabras **DEBE**, **NO DEBE**, **DEBERÍA** y **PUEDE** expresan requisitos normativos. Una excepción debe documentarse con motivo, alcance, responsable y vencimiento.

## 3. Modelo de arquitectura y límites de responsabilidad

### 3.1 Plano de gobierno y registro

`SeryMente/metodologia` es propietario de este canon y conserva:
- decisiones transversales, requisitos y contratos;
- runbooks y criterios de aceptación;
- estados saneados por terminal;
- evidencias no sensibles, hashes, identificadores de snapshots y resultados de restauración;
- bloqueos, riesgos, excepciones, versiones y próximos pasos.

No debe almacenar material secreto ni copias completas de clientes o bases de datos. Los manifiestos deben describir dónde reside un artefacto, cómo verificarlo y cómo recuperarlo sin incluir el secreto mismo.

### 3.2 Plano de implementación

- **KHORA:** implementación de bootstrap, entorno de ejecución, persistencia, cifrado, rutas, contexto y mecanismos EP que pertenezcan a KHORA. KHORA no es propietario de la metodología transversal.
- **Cora:** interfaz y lógica de producto para los flujos de acceso/administración que realmente pertenezcan a Cora. Su implementación debe seguir este canon, sin convertir el repositorio Cora en autoridad de EP.
- **Repositorio Ser y Mente / WordPress:** fuente de los componentes de sitio, configuración declarativa, temas/plugins autorizados y procedimientos de reconstrucción WP-LAB.
- **Proveedor de almacenamiento o repositorio remoto:** destino concreto autorizado para datos persistentes, artefactos y backups. Cada capacidad se verifica por separado.

Los nombres de repositorio, rutas, ramas, versiones y SHA cambian; se deben recuperar en tiempo de ejecución. Las referencias de esta sección son puntos de entrada y no reemplazan comprobar el estado vigente.

### 3.3 Planos de datos y control

Separar conceptualmente:
1. plano de control: decisiones, estado, inventarios y referencias;
2. plano de ejecución: procesos y herramientas activas;
3. plano de datos: archivos, bases de datos, medios, modelos y artefactos;
4. plano de identidad/autorización: usuarios, terminal, sesión, roles y credenciales;
5. plano de evidencia: logs saneados, hashes, checkpoints, resultados de pruebas y restauraciones.

Una ruta local de ejecución no se considera plano de datos persistente sin un destino duradero validado.

## 4. Fuentes documentales subordinadas y contratos de implementación

Las siguientes fuentes se consultan desde sus ramas actuales y se mantienen subordinadas a este canon en todo asunto transversal:

1. [Anexo EP híbrido y EP-WP-LAB](ANEXO-ENTORNO-PERSISTENTE-HIBRIDO-EP-WP-LAB.md) — plan consolidado previo, decisiones y evidencia histórica.
2. [Anexo Cybernet, RDC, WP-LAB y OGP-Visual](ANEXO-EP-ARRANQUE-CYBERNET-WP-LAB-OGP-IA-20261009.md) — especificación extensa de arranque, telemetría y laboratorio; conservar como registro histórico de detalle, no como autoridad competidora.
3. [Contexto de ejecución y salida de ciclo](ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md) — identidad, ciclo y formato de evidencia.
4. [Bootstrap de contexto global](BOOTSTRAP-CONTEXTO-GLOBAL.md) — reanudación y orden de lectura.
5. [Procedimiento de arranque CLI y clonado](ANEXO-PROCEDIMIENTO-ARRANQUE-CLI-WINDOWS-Y-CLONADO-REPOSITORIOS.md) — preparación de la sesión y repositorios.
6. [Formato de registro de verificación por ciclo](FORMATO-REGISTRO-VERIFICACION-CICLO.md) y su esquema JSON — estructura verificable de la evidencia.
7. [Especificación de evidencia normativa por ciclo](ESPECIFICACION-EVIDENCIA-NORMATIVA-POR-CICLO.md) — requisitos de prueba y trazabilidad.
8. [Estado RDC activo](ESTADO-RDC-ACTIVO.md) y registros por terminal bajo `CIBERCAFE/` — estado operativo específico por terminal; no confundir terminales entre sí.
9. En KHORA: `ep-medio-architectura.md`, `docs/ep-wp-lab-integration.md` y `EP-VALIDATION.md` — contratos técnicos y evidencia de implementación.
10. En el repositorio de WordPress/Ser y Mente: documentos E2E y bootstrap de WP-LAB vigentes.
11. En Cora: especificación real de UI, OIDC, comando PowerShell y gestión de secretos, una vez localizadas sus rutas vigentes.

**Regla de referencias:** todo documento anterior que describa EP debe incluir al inicio un aviso de subordinación y un enlace a este archivo. Las referencias desde KHORA/Cora deben decir que este es el canon transversal y que esos repositorios son contratos de implementación. No eliminar los documentos históricos hasta comprobar que toda evidencia única quedó preservada y enlazada.

## 5. Identidad, volatilidad y contexto de ejecución

### 5.1 Identidad separada por dimensiones

Cada ciclo debe distinguir, sin inferencias:
- ubicación física declarada;
- ID de terminal física, por ejemplo `CIBERCAFE/PC-4` o `CIBERCAFE/PC-7`;
- dispositivo/canal RDC y su estado observado;
- usuario Windows efectivo y nivel de privilegio;
- perfil/rutas de datos autorizadas;
- sesión de ejecución y procesos hijos;
- repositorio, rama y commit de cada cambio;
- destino persistente y evidencia de lectura/restauración.

No inferir la terminal a partir de la ubicación. Un cibercafé puede tener varias terminales con estados y capacidades diferentes. Una conversación no identifica al host. Un dispositivo RDC no sustituye el ID físico de terminal.

### 5.2 Premisa de volatilidad

Escritorio, Descargas, perfil Windows, temporales, procesos, PATH y archivos de la sesión se consideran volátiles hasta que una prueba concreta demuestre lo contrario. Reinicio, cierre de sesión, Deep Freeze, pérdida de conexión o fallo del proceso pueden impedir una sincronización final; por tanto:

- los checkpoints deben ser incrementales y periódicos;
- el cierre ordenado es una optimización, nunca la única garantía;
- una sesión nueva debe reconstruir el contexto desde fuentes canónicas y no desde una copia local antigua;
- el estado debe identificar terminal, commit, artefacto, destino, hash y última lectura de comprobación.

### 5.3 Gate de identidad y destino

Antes de escribir, instalar, montar, cifrar o eliminar:
1. observar la identidad efectiva del proceso;
2. resolver la ruta absoluta de destino;
3. comprobar que la ruta pertenece al árbol autorizado para ese perfil/terminal;
4. detectar enlaces/reparse points y rutas que escapen del destino permitido;
5. comprobar permisos y espacio;
6. registrar el plan de escritura y el mecanismo de reversión.

Si la identidad o el destino son ambiguos, la operación falla de forma cerrada. No cambiar silenciosamente de usuario ni presentar un usuario como otro. Las reglas especiales por entorno, como CECEQ, deben aplicarse desde la versión vigente de `METODOLOGIA.md`; este canon no las reemplaza.

## 6. Persistencia, cifrado y recuperación

### 6.1 Destinos

Cada clase de artefacto debe tener un destino declarado y comprobado:
- código fuente y configuración no secreta: repositorio Git autorizado;
- estado y evidencia operativa saneada: Metodología u otro registro canónico aprobado;
- backups WordPress: almacenamiento autorizado con política de retención;
- base de datos y medios de WordPress: destinos respaldados y recuperables por separado;
- volúmenes/VHDX: destino duradero autorizado, más manifiesto de montaje, cifrado y recuperación;
- modelos/pesos de IA: almacenamiento explícito con licencia, tamaño, hash e inventario;
- secretos: gestor de secretos o almacén cifrado con control de acceso; nunca este repositorio.

No asumir que Git, PostgreSQL, Vercel Blob u otro servicio guarda automáticamente todas estas clases de datos. La relación entre artefacto y destino debe demostrarse mediante lectura de comprobación.

### 6.2 Checkpoint transaccional

Cada checkpoint registrará como mínimo:
- ID único y timestamp UTC;
- terminal y sesión de origen;
- tipo y alcance de los datos incluidos/excluidos;
- commit de código o versión de configuración asociada;
- destino y objeto remoto exacto;
- tamaño y SHA-256 del artefacto o manifiesto;
- resultado de escritura y lectura posterior;
- política de retención y checkpoint anterior;
- resultado de restauración cuando aplique;
- clasificación de confidencialidad y sanitización de logs.

Secuencia mínima: preparar manifiesto → escribir a destino autorizado → leer desde ese destino → verificar hash/tamaño → registrar el resultado. Si cualquiera falla, no marcar el checkpoint como válido.

### 6.3 VHDX y BitLocker

La documentación de VHDX/BitLocker debe definir creación, tamaño, formato, montaje, punto de montaje, política de bloqueo, clave de recuperación, copia/rotación de la clave, desmontaje y recuperación ante fallo. Las claves y recovery keys no se guardan en Git, logs o esta especificación. La evidencia debe demostrar el estado real del volumen y no limitarse a la existencia del archivo VHDX.

No automatizar el desbloqueo usando una contraseña escrita en scripts, argumentos de proceso, variables expuestas o logs. La identidad y el destino deben validarse antes de cualquier operación de cifrado o montaje.

### 6.4 Restauración

Una recuperación no se considera demostrada hasta que:
1. se obtiene el artefacto desde el destino remoto autorizado;
2. se verifica su integridad;
3. se restaura en un destino aislado;
4. se valida la estructura y la aplicación;
5. se registra duración, errores y límites;
6. se confirma que no se sobrescribió el origen ni se filtraron secretos.

## 7. WordPress local y WP-LAB

### 7.1 Objetivo

WP-LAB es el laboratorio local para construir, probar y validar sitios/contenido sin confundir el estado de la copia de trabajo con un estado persistente o publicado. Debe poder reconstruirse después de perder una sesión de Windows o cambiar de terminal.

### 7.2 Inventario que debe ser explícito

Registrar versión de PHP, runtime, servidor web, motor y versión de base de datos, WordPress core, plugins, temas, configuración, dependencias, variables requeridas (nunca sus valores secretos), directorios de medios, fixtures, scripts de bootstrap, migraciones y herramientas de exportación/importación. Separar componentes reproducibles de componentes que necesitan backup.

La configuración versionada debe excluir contraseñas, tokens, salts, datos personales y volcados de producción. Para plugins/temas comerciales, registrar fuente autorizada y condiciones de licencia; no publicar paquetes propietarios sin autorización.

### 7.3 Persistencia WordPress

La unidad recuperable incluye, según el diseño del sitio:
- base de datos y su esquema;
- uploads y medios;
- temas/plugins/configuración permitidos;
- versión de core y dependencias;
- instrucciones de bootstrap;
- datos de prueba y migraciones;
- referencias a activos externos y licencias.

Un backup de archivos sin base de datos, o una base de datos sin medios, no es un backup E2E suficiente. La exportación debe ser consistente y el procedimiento de restauración debe validarse en entorno aislado.

### 7.4 Criterios E2E WP-LAB

- bootstrap desde una sesión limpia;
- instalación de dependencias con versiones registradas;
- importación/restauración desde el destino persistente;
- acceso administrativo local funcional;
- páginas, plugins, temas y medios esperados disponibles;
- pruebas funcionales mínimas definidas por el proyecto;
- exportación de un nuevo checkpoint, lectura y hash correctos;
- restauración en un directorio/base aislados;
- evidencia sin secretos y con commit/terminal identificados.

Hasta que se ejecuten estas pruebas en la máquina/terminal objetivo, el estado máximo permitido es **PREPARADO, NO VERIFICADO**.

## 8. Laboratorio de contenido complementario para OGP

### 8.1 Propósito y separación

El laboratorio OGP produce contenido complementario para el instrumento de comunicación del programa: borradores, piezas visuales, variantes, recursos de apoyo y materiales derivados autorizados. La definición editorial del instrumento, sus aprobaciones y su fuente oficial pertenecen al programa correspondiente; EP/WP-LAB aporta continuidad y herramientas, no autoridad editorial.

### 8.2 Flujo de producción

1. recibir un brief identificado y autorizado;
2. registrar fuente, propósito, audiencia, restricciones, idioma, formato y criterios de aceptación;
3. generar o editar contenido mediante herramientas autorizadas;
4. registrar herramienta/modelo y versión, parámetros relevantes no sensibles, licencias y procedencia de activos;
5. revisar exactitud, derechos, privacidad, accesibilidad, tono y compatibilidad con el instrumento;
6. obtener aprobación humana cuando corresponda;
7. almacenar el artefacto final y sus fuentes autorizadas en destinos persistentes;
8. crear checkpoint, hash y registro de publicación/entrega;
9. probar recuperación del contenido y de los metadatos necesarios para editarlo.

### 8.3 IA visual y recursos grandes

La disponibilidad de GPU, runtimes, modelos, pesos, memoria y licencias debe inventariarse por terminal. No asumir que un modelo local existe o puede ejecutarse en cada cibercafé. Si el trabajo depende de un servicio externo, registrar la dependencia, el estado de acceso y una alternativa viable. No guardar pesos de modelos o datasets voluminosos en Git sin justificación técnica.

### 8.4 Pruebas de aceptación

Una pieza se considera entregable cuando tiene brief rastreable, archivos fuente necesarios, salida final, formato comprobado, derechos/procedencia registrados, aprobación pertinente, destino duradero, hash y restauración/lectura de comprobación. La mera generación de una imagen o la vista previa local no acredita entrega persistente.

## 9. Cora: interfaz de acceso administrativo, OIDC, PowerShell y token GitHub

Esta sección registra el alcance solicitado y fija requisitos de seguridad. La existencia de cada control en la versión actual de Cora debe comprobarse en su repositorio; no se presume implementado.

### 9.1 Principio de autorización

La autenticación identifica al actor; la autorización determina qué acciones puede ejecutar. La contraseña maestra no debe funcionar como un bypass opaco que neutralice OIDC, políticas de acceso, auditoría o autorización del sistema operativo. Si se necesita una ruta alternativa o break-glass, debe diseñarse explícitamente como un flujo separado, con:
- motivo de negocio y amenaza que resuelve;
- actores/roles autorizados;
- factor(es) de autenticación y política de intentos;
- duración y alcance limitados;
- consentimiento/confirmación visible para acciones privilegiadas;
- registro de auditoría saneado;
- revocación y respuesta a compromiso;
- pruebas negativas de acceso no autorizado.

No afirmar que introducir una contraseña maestra “da vuelta” a OIDC hasta especificar si significa un segundo factor, un modo de emergencia, autenticación local o una excepción de política. El requisito de producto necesita esa semántica inequívoca. No se debe almacenar una contraseña maestra recuperable en texto claro ni incrustarla en código/configuración. Preferir verificación con hash robusto y sal, protección contra fuerza bruta y almacenamiento de secretos apropiado; la elección final debe ajustarse al modelo de identidad real.

### 9.2 Interfaz para ejecutar comandos PowerShell

La interfaz debe:
- distinguir vista previa, solicitud de autorización, ejecución y resultado;
- mostrar el comando/operación y su alcance antes de ejecutar;
- aplicar allowlist de operaciones cuando sea viable, validar parámetros y evitar interpolación de shell insegura;
- ejecutar con mínimo privilegio y mantener identidad efectiva verificable;
- no permitir que un token de GitHub o una contraseña de UI equivalgan por sí solos a privilegios Windows;
- limitar tiempo, salida, cancelación y tamaño de logs;
- sanear secretos de stdout/stderr y errores;
- registrar actor, acción, resultado, terminal, timestamp y referencia de correlación;
- rechazar solicitudes ambiguas o fuera de política;
- impedir ejecución arbitraria a partir de entrada no confiable sin controles específicos.

La interfaz no debe mostrar, copiar o persistir credenciales en logs ni devolver secretos al cliente. Las operaciones destructivas, de cifrado, administración de cuentas o modificación de repositorios requieren gates específicos y una estrategia de recuperación.

### 9.3 Entrada y almacenamiento de token GitHub

El flujo de UI para ingresar un token debe:
1. aceptar el valor solo sobre canal autenticado y protegido;
2. no volver a mostrarlo tras la entrada;
3. evitar query strings, telemetría, analytics, excepciones y logs;
4. almacenarlo mediante el gestor de secretos aprobado para el entorno, no en texto claro en base de datos, localStorage, repositorio o archivo de configuración versionado;
5. restringir su acceso a la función/servicio que realmente lo necesita;
6. pedir scopes mínimos y preferir credenciales de vida corta cuando la integración lo permita;
7. ofrecer reemplazo, rotación, revocación y prueba de conectividad sin revelar el valor;
8. distinguir entre “guardado”, “permiso suficiente”, “conectividad comprobada” y “operación GitHub completada”;
9. evitar persistir el token en prompts o documentación pública;
10. definir el comportamiento cuando el secreto no existe, expiró o fue revocado.

No considerar un token “seguro” solo porque la UI lo enmascara. El almacenamiento, el acceso del servidor, los logs, las copias de seguridad, el ciclo de vida y el alcance de permisos deben comprobarse.

### 9.4 Pruebas obligatorias de Cora

- usuario no autenticado/no autorizado no puede ejecutar comandos;
- usuario autorizado sin privilegio específico tampoco puede ejecutarlos;
- OIDC activo sigue aplicando según la política salvo excepción break-glass aprobada y explícita;
- contraseña incorrecta, agotamiento de intentos, sesión expirada y revocación fallan de forma cerrada;
- el token no aparece en HTML/DOM recuperable, almacenamiento de cliente, logs, respuestas de error, analytics o repositorio;
- token inválido/expirado no se presenta como conectado;
- rotación y revocación tienen efecto comprobado;
- inyección de comandos, argumentos maliciosos, rutas ambiguas y salidas con secretos se prueban;
- las operaciones administrativas se ejecutan bajo la identidad Windows prevista y se auditan;
- el flujo completo se prueba E2E en un entorno autorizado sin exponer credenciales.

Hasta obtener evidencia, cada punto permanece como requisito/pending; no como capacidad disponible.

## 10. Seguridad, privacidad y amenazas

Amenazas mínimas:
- pérdida súbita de sesión por reinicio/Deep Freeze;
- escritura al perfil/terminal equivocados;
- checkpoint incompleto o remoto no legible;
- corrupción o restauración no probada;
- exposición de token, contraseña maestra, recovery key o datos personales;
- privilegios excesivos en el proceso PowerShell;
- inyección de comandos o rutas;
- dependencia externa caída o cuota agotada;
- mezcla de artefactos entre terminales;
- desalineación entre documentación y código;
- uso de snapshots, cachés o versiones obsoletas.

Controles mínimos:
- mínimo privilegio y fail-closed;
- validación de identidad y rutas antes de operar;
- secretos fuera de Git y logs;
- scopes mínimos, rotación y revocación;
- checkpoints incrementales y lectura de comprobación;
- restauración aislada;
- pruebas de fallo y recuperación;
- versionado y SHA de código/documentación;
- inventario por terminal;
- evidencias sanitizadas y revisión de discrepancias.

Si se sospecha exposición de credenciales, detener su uso, revocarlas/rotarlas mediante el canal autorizado, revisar logs y accesos, registrar el incidente sin copiar el secreto y comprobar que el valor comprometido ya no permite acceso.

## 11. Estados y lenguaje de certificación

Usar estados independientes para cada componente:
- **NO DOCUMENTADO:** no existe especificación suficiente.
- **ESPECIFICADO:** requisitos y diseño escritos.
- **IMPLEMENTADO:** código/configuración existe en una revisión identificada.
- **INSTALADO:** artefactos instalados en una terminal/entorno identificado.
- **OPERATIVO:** comprobación funcional directa en ese entorno.
- **E2E VERIFICADO:** flujo completo ejecutado con evidencia reproducible.
- **RECUPERACIÓN VERIFICADA:** restauración desde el destino persistente probada en aislamiento.
- **CERTIFICADO:** criterios formales completos, evidencia revisada y alcance/fecha identificados.
- **PUBLICADO:** versión desplegada o entregada en el destino previsto.

No colapsar estados ni inferir uno del otro. “Preparado” no significa “operativo”. “READY” de un proveedor no demuestra que WP-LAB se restaure. Un test unitario no demuestra continuidad física.

## 12. Plan de ejecución E2E y gates de aceptación

Ejecutar secuencialmente; cada fase debe conservar evidencia y un resultado de paso/fallo.

### Fase A — Baseline e inventario
- adquirir el estado vigente de Metodología, SI, repositorios y ramas;
- identificar terminal y sesión RDC actuales;
- inventariar código, dependencias, rutas, servicios, artefactos y destinos;
- registrar qué se sabe por declaración y qué fue medido.
**Gate:** identidad, alcance y fuentes verificadas; no quedan referencias ambiguas a “esta máquina” o “el entorno”.

### Fase B — Diseño y amenazas
- mapear flujos de datos, secretos, identidades y límites de confianza;
- confirmar la semántica del acceso maestro/OIDC/break-glass con la política de producto;
- elegir destinos autorizados y política de retención;
- documentar estrategia de reversión.
**Gate:** no quedan decisiones críticas de autenticación o persistencia implícitas.

### Fase C — Persistencia mínima
- configurar destino duradero;
- crear primer checkpoint de prueba;
- leer desde el destino y verificar SHA-256;
- registrar ID, alcance, tamaño, terminal y resultado.
**Gate:** escritura y read-back correctos; no basta una respuesta HTTP exitosa.

### Fase D — EP/cifrado/identidad
- comprobar rutas, identidad efectiva y comportamiento fail-closed;
- validar VHDX/BitLocker solo en el entorno autorizado;
- demostrar montaje, bloqueo/desbloqueo, recuperación y protección de claves según política;
- verificar que los datos van al árbol autorizado.
**Gate:** pruebas de identidad/ruta y recuperación pasan; no hay secretos en artefactos o logs.

### Fase E — WP-LAB y OGP
- reconstruir WordPress desde una sesión limpia;
- restaurar base de datos, medios y configuración;
- generar/editar una pieza OGP con procedencia y aprobación;
- exportar checkpoint y restaurarlo en aislamiento.
**Gate:** funcionalidad, integridad y recuperación completas.

### Fase F — Cora y secretos
- inspeccionar la implementación real de OIDC, UI, PowerShell y secreto GitHub;
- ejecutar las pruebas de autorización y negativas de la sección 9;
- demostrar que el secreto se almacena y consume sin exposición;
- verificar rotación y revocación.
**Gate:** acceso autorizado y auditado; ninguna credencial expuesta; operaciones no autorizadas rechazadas.

### Fase G — Caída y recuperación
- simular cierre abrupto/reinicio en un entorno de prueba;
- abrir una sesión nueva, posiblemente en otra terminal;
- recuperar el estado desde Metodología y los destinos duraderos;
- restaurar WP-LAB y retomar la tarea a partir del último checkpoint;
- comparar hashes y documentar pérdida de datos/tiempo de recuperación.
**Gate:** recuperación desde fuentes duraderas sin depender de la sesión anterior.

### Fase H — Certificación y cierre
- consolidar resultados, logs saneados, hashes, commits, versiones y limitaciones;
- comprobar los enlaces y referencias cruzadas;
- actualizar el estado canónico y dejar un siguiente paso único y accionable si queda algún gate pendiente.
**Gate:** un revisor independiente puede repetir la verificación.

## 13. Registro mínimo de evidencia por ciclo

Cada ciclo de trabajo relacionado con EP debe registrar:
- fecha/hora UTC;
- terminal física e identidad RDC observadas;
- identidad efectiva de Windows y nivel de privilegio;
- repositorio, rama, commit antes/después;
- comando/acción ejecutada y resultado;
- archivos/servicios afectados;
- checkpoint ID, destino, tamaño y SHA-256 cuando aplique;
- lectura de comprobación y/o resultado de restauración;
- pruebas ejecutadas y salidas saneadas;
- clasificación de cada afirmación: declarada, observada, inferida o pendiente;
- bloqueos, riesgos, rollback y próximo paso;
- versión y nombre de Metodología y del SI recuperados al inicio del ciclo.

La evidencia debe permitir repetir la operación, no solo narrar que “funcionó”. No incluir valores secretos ni volcados sensibles.

## 14. Matriz de estado al corte documental

La matriz refleja únicamente lo respaldado por el material documental inspeccionado para esta consolidación; no sustituye una prueba actual de host ni una revisión completa de todos los repositorios de implementación.

| Dominio | Estado documental al corte | Evidencia que falta para elevar estado |
|---|---|---|
| Canon transversal EP | Este documento establece la autoridad documental propuesta; el cambio de referencias requiere confirmación de commit | Verificar publicación y referencias cruzadas en main |
| Identidad/volatilidad por terminal | Reglas y registros por terminal documentados | Lectura actual del host/terminal y pruebas por terminal |
| Persistencia remota/checkpoints | Diseño descrito | Read-back, SHA y prueba de restauración desde el destino real |
| VHDX/BitLocker | Requisitos y plan descritos en documentos previos | Estado real del volumen, cifrado, recuperación y claves protegidas |
| WordPress local/WP-LAB | Especificación e integración documentadas | Bootstrap limpio, pruebas funcionales, backup consistente y restore aislado |
| Laboratorio OGP | Alcance de generación/edición documentado | Flujo reproducible, licencias/procedencia, persistencia y recuperación de una entrega |
| Cora: contraseña maestra/OIDC/PowerShell | Requisito del usuario incorporado; implementación no verificada aquí | Localizar código vigente, aprobar semántica y ejecutar pruebas de autorización/seguridad |
| Cora: token GitHub como secreto | Requisito de UI y seguridad incorporado; implementación no verificada aquí | Localizar almacenamiento/consumo reales, verificar ausencia de exposición, rotación/revocación |
| E2E entre sesiones/terminales | Procedimiento especificado | Simular pérdida de sesión, recuperar en sesión/terminal nueva y documentar resultado |
| Certificación global | **NO CERTIFICADA** | Todos los gates de la fase 12 completados y revisados |

**Estado global permitido:** ESPECIFICACIÓN CONSOLIDADA; EJECUCIÓN FÍSICA Y E2E PENDIENTES DE EVIDENCIA. No elevar a certificado por la creación de este documento.

## 15. Riesgos abiertos y decisiones que requieren evidencia

1. Identificar los destinos persistentes reales y confirmar que cada clase de artefacto está cubierta.
2. Comprobar si el volumen cifrado y el mecanismo de recuperación existen en la terminal objetivo.
3. Inspeccionar la rama vigente de KHORA y reconciliar los documentos de arquitectura y validación.
4. Localizar el flujo de Cora que maneja OIDC, contraseña maestra, PowerShell y token GitHub; no inferirlo por el nombre del producto.
5. Definir formalmente si la contraseña maestra es un segundo factor, un modo break-glass o un proveedor de autenticación alternativo. No implementar un bypass ambiguo.
6. Definir gestor de secretos, scopes mínimos, ciclo de rotación y responsables.
7. Determinar la configuración/licencias/recursos de IA disponibles por terminal para OGP.
8. Ejecutar una restauración aislada de WordPress que incluya base de datos y medios.
9. Ejecutar prueba de pérdida abrupta de sesión y recuperación desde otra sesión/terminal.
10. Revisar enlaces cruzados y registrar los commits concretos que implementan este canon en todos los repositorios pertinentes.

Cada riesgo se cierra con evidencia, responsable/actor operativo identificado y fecha; no basta con editar su redacción.

## 16. Protocolo de cambio del canon

- Cambios transversales se hacen en `SeryMente/metodologia`.
- Antes de editar, recuperar SI, Metodología y documento desde la rama activa; comprobar frescura según el README.
- Mantener versión MAJOR.MINOR.PATCH y narrativa causal conforme a la metodología vigente. La versión del documento y la versión global de Metodología son identificadores distintos.
- Las decisiones no verificadas se rotulan como propuestas, hipótesis o pendientes.
- Actualizar primero el canon y después las referencias subordinadas en una secuencia que no deje enlaces rotos; verificar cada escritura por lectura posterior.
- No eliminar anexos históricos mientras contengan evidencia única, resultados, hashes o contexto que no se haya preservado.
- En cada cierre, reportar commit, archivos cambiados, verificaciones realizadas, limitaciones y próximo paso accionable.

## 17. Criterio de finalización global

El esfuerzo solo se declara terminado cuando:
- todas las fases A–H tienen evidencia reproducible;
- EP persiste datos en destinos autorizados y supera read-back/restauración;
- la identidad de terminal y usuario se conserva y valida;
- WordPress local se reconstruye y restaura de forma completa;
- el laboratorio OGP conserva fuentes y entregables y permite retomarlos;
- Cora aplica autorización segura a PowerShell y gestiona tokens sin exposición;
- una sesión nueva/otra terminal recupera contexto y trabajo sin depender de la sesión anterior;
- todos los documentos y repositorios apuntan a esta fuente transversal sin contradicciones;
- un revisor independiente puede repetir los pasos y obtener resultados equivalentes.

Hasta entonces, el estado global seguirá siendo **PENDIENTE DE CERTIFICACIÓN E2E**.
