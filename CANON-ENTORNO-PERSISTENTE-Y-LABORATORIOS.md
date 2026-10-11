# Canon transversal de Entorno Persistente, Continuidad de Ejecución y Laboratorios Locales

**ID documental:** METODOLOGIA-EP-CANON  
**Versión del documento:** v1.1.0  
**Nombre de versión:** Contrato Único de Actualización, Aceptación y Publicación EP  
**Estado:** CANON DOCUMENTAL TRANSVERSAL Y CONTRATO DE EJECUCIÓN; implementación, publicación del producto y certificación física NO acreditadas por esta edición.  
**Fecha de corte documental:** 2026-10-10 (America/Mexico_City); revisión documental autorizada el 2026-10-11 UTC.  
**Repositorio propietario y fuente normativa transversal:** [SeryMente/metodologia](https://github.com/SeryMente/metodologia)  
**Ruta canónica:** `CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md`

> **Regla de autoridad y autosuficiencia:** este archivo contiene el contrato técnico transversal de actualización, integración, aceptación, publicación y recuperación del Entorno Persistente (EP). Los anexos son procedencia histórica, no lecturas técnicas obligatorias para completar instrucciones faltantes. El Sistema de Instrucciones y la Metodología vigentes conservan su precedencia de gobierno: este canon no puede dispensar su adquisición ni una autorización humana exigida por ellos. Código, proveedores, host, secretos y activos licenciados son recursos de ejecución que deben observarse, no requisitos que se puedan inventar. Si una decisión material aún no está autorizada, la ejecución se bloquea con el requisito exacto; no se promete publicación incondicional.

**Lectura ejecutiva:** alcance y significado de un ciclo en §18; contratos concretos en §19–§22; pruebas y errores en §23; publicación/reversión en §24; evidencia, trazabilidad y autoauditoría en §25–§27. Las secciones §0–§17 conservan requisitos generales y evidencia histórica. En asuntos técnicos resueltos por esta revisión, el contrato específico de §18–§27 prevalece sobre una formulación general anterior, sin rebajar seguridad ni ampliar autorizaciones.

## 0. Recuperación y preflight de lectura

Para tareas de EP, terminales efímeras, continuidad, WordPress local, laboratorio visual o acceso/secretos de Khora:

1. Recuperar `SeryMente/metodologia/main`, registrar H1, leer este archivo y el Sistema de Instrucciones/Metodología en ese commit y volver a observar H2. H1 debe coincidir con H2; comparar cabeceras y blobs. Una carrera obliga a readquirir, no a mezclar instantáneas.
2. Leer este canon completo. No exigir anexos históricos para entender un requisito técnico: los contratos de ejecución están aquí. Si el gobierno superior vigente cambia una condición, registrar la discrepancia y bloquear únicamente lo afectado; no aplicar silenciosamente una norma congelada.
3. Resolver el perfil de entrega de §18, terminal, identidad efectiva, árbol de datos, recursos autorizados y versión activa. Consultar código/API/host en vivo mediante las rutas de §19; verificar sus identidades y fijar commits. Las referencias históricas no son HEAD ni producción actuales.
4. Completar el manifiesto de ejecución de §25. La autorización para modificar documentación no autoriza migraciones productivas, uso de credenciales reales, construcción de UX/UI/seguridad ni decisiones de arquitectura no aprobadas.
5. Aplicar pruebas y orden de publicación de §23–§24. Una lectura histórica, un commit o un deployment READY no son aceptación E2E.
6. Terminar el ciclo con PASS, BLOCKED o FAIL, alcance explícito y evidencia leída de vuelta. Solo el estado PUBLICADO VERIFICADO exige que el destino activo sirva la versión candidata y que sus pruebas reales hayan pasado.

Si el canon no es recuperable, la frescura no se puede comprobar o falta una autorización obligatoria, declarar NO VERIFICADO/BLOCKED; nunca suplirlo por memoria. El significado operativo de «único archivo» es único contrato técnico de la actualización, no ausencia de acceso a código, host, identidad, credenciales o gobierno superior.

## 1. Propósito, alcance y límites

El esfuerzo construye una capacidad de trabajo que sobrevive a sesiones y terminales efímeras, con laboratorios locales recuperables y flujos seguros de administración y publicación. Incluye:

- continuidad de trabajo y artefactos a través de reinicios, sesiones efímeras y cambios de terminal;
- identidad inequívoca de cada terminal y separación de esta respecto de ubicación, perfil Windows, sesión RDC y conversación;
- persistencia cifrada cuando corresponda, verificación de integridad, checkpoints y restauración;
- WordPress local y WP-LAB como laboratorio de contenido, experimentación y validación;
- capacidad complementaria de generación/edición de contenido para Otro Gran Programa (OGP), incluido contenido visual/IA cuando el hardware, los modelos y las licencias lo permitan;
- interfaces y flujos de Khora relacionados con autorización para comandos PowerShell y gestión segura de tokens GitHub;
- evidencias E2E que demuestren continuidad y recuperación, no solo la presencia de carpetas o código.

Este documento **no demuestra por sí mismo** que un volumen esté montado, que BitLocker esté activo, que un secreto esté guardado de forma segura, que WordPress pueda restaurarse ni que un comando privilegiado funcione. Es la fuente de requisitos y gobernanza; la certificación requiere evidencia reproducible del entorno concreto.

### 1.1 No objetivos

- No trasladar la propiedad metodológica a KHORA ni a Khora.
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
- **Interfaz web de Khora:** puerta EP, autenticación, emisión de sesión y administración de credenciales en `SeryMente/khora/khora-web`. «Cora» es un alias histórico de Khora, no un segundo producto ni un repositorio separado.
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

## 4. Procedencia documental y localizadores de código

Las siguientes fuentes son antecedentes/localizadores subordinados. No se requiere leerlas para reconstruir los requisitos técnicos de §18–§27. Sus afirmaciones fechadas no certifican el host ni reemplazan este canon:

1. [Anexo EP híbrido y EP-WP-LAB](ANEXO-ENTORNO-PERSISTENTE-HIBRIDO-EP-WP-LAB.md) — plan consolidado previo, decisiones y evidencia histórica.
2. [Anexo Cybernet, RDC, WP-LAB y OGP-Visual](ANEXO-EP-ARRANQUE-CYBERNET-WP-LAB-OGP-IA-20261009.md) — especificación extensa de arranque, telemetría y laboratorio; conservar como registro histórico de detalle, no como autoridad competidora.
3. [Contexto de ejecución y salida de ciclo](ANEXO-CONTEXTO-EJECUCION-Y-SALIDA-CICLO.md) — identidad, ciclo y formato de evidencia.
4. [Bootstrap de contexto global](BOOTSTRAP-CONTEXTO-GLOBAL.md) — reanudación y orden de lectura.
5. [Procedimiento de arranque CLI y clonado](ANEXO-PROCEDIMIENTO-ARRANQUE-CLI-WINDOWS-Y-CLONADO-REPOSITORIOS.md) — preparación de la sesión y repositorios.
6. [Formato de registro de verificación por ciclo](FORMATO-REGISTRO-VERIFICACION-CICLO.md) y su esquema JSON — estructura verificable de la evidencia.
7. [Especificación de evidencia normativa por ciclo](ESPECIFICACION-EVIDENCIA-NORMATIVA-POR-CICLO.md) — requisitos de prueba y trazabilidad.
8. [Estado RDC activo](ESTADO-RDC-ACTIVO.md) y registros por terminal bajo `CIBERCAFE/` — estado operativo específico por terminal; no confundir terminales entre sí.
9. En KHORA: `ep-medio-architectura.md`, `docs/ep-wp-lab-integration.md` y `EP-VALIDATION.md` — contratos técnicos y evidencia de implementación.
10. En `SeryMente/serymente`: `reconstruction/lab/bootstrap-ser-y-mente-lab.ps1`, `LOCAL-STUDIO-4.24.md` y `E2E-STATE-2026-10-08.md`; el bootstrap debe corregirse según §21 antes de operar sobre un sitio real.
11. En `SeryMente/khora`: los archivos concretos de UI, autenticación, API, bóveda y migración se enumeran en §19. No buscar un repositorio «Cora».

**Regla de referencias:** todo documento anterior que describa EP debe incluir al inicio un aviso de subordinación y un enlace a este archivo. Las referencias desde Khora deben decir que este es el canon transversal y que esos repositorios son contratos de implementación. No eliminar los documentos históricos hasta comprobar que toda evidencia única quedó preservada y enlazada.

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

## 9. Khora: interfaz de acceso administrativo, OIDC, PowerShell y token GitHub

Esta sección registra el alcance solicitado y fija requisitos de seguridad. La existencia de cada control en la versión actual de Khora debe comprobarse en su repositorio; no se presume implementado.

### 9.1 Contrato de autorización de la puerta EP

La semántica transversal documentada en el registro histórico es específica y no equivale a desactivar OIDC en toda Khora:

- La URL canónica existente de Khora permite entrar a la puerta EP con contraseña maestra sin iniciar Google OIDC para ese flujo EP limitado.
- Las páginas y APIs generales permanecen protegidas por OIDC. Ocultar pestañas en la interfaz nunca sustituye autorización del servidor.
- El primer alta/configuración y la recuperación o rotación de la contraseña maestra requieren una sesión OIDC autorizada.
- La contraseña maestra habilita una sesión breve, revocable y de mínimo privilegio, limitada a EP. No concede acceso general a Khora, no otorga privilegios Windows por sí misma y no autoriza la administración de la credencial GitHub.
- La carga, rotación y eliminación del PAT de GitHub requieren OIDC autorizado. La sesión maestra puede consultar estado redactado y utilizar la credencial en el flujo de bootstrap, pero no administrar el PAT.
- El flujo de contraseña maestra debe tener expiración, límites de intentos, protección contra fuerza bruta, comparación constante, revocación, auditoría saneada y pruebas negativas. Los fallos no revelan cuentas, estado de repositorios ni detalles de configuración.

Parámetros de aceptación recuperados de la implementación candidata: scrypt `N=32768, r=8, p=1, maxmem=64 MiB`, sal aleatoria de 32 bytes y verificador de 64 bytes; contraseña de 16–1024 caracteres; pepper HMAC-SHA256 separado por dominio; ocho intentos fallidos por origen durante 15 minutos; cookie firmada de 15 minutos limitada a EP. Deben verificarse y probarse en la candidata y en el destino; no se afirma que producción ya los implemente. Rotar la contraseña debe invalidar las sesiones maestras anteriores; si el código no lo hace, corregirlo y añadir una prueba antes de liberar.

No almacenar una contraseña maestra recuperable en texto claro ni incrustarla en código/configuración. La excepción de OIDC es de alcance estrecho, expirable, revocable y auditable; no debe ampliarse por conveniencia.

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

La interfaz web no debe mostrar, copiar ni persistir el PAT en DOM, almacenamiento de navegador o logs, ni recibirlo desde la bóveda. La única entrega de PAT descifrado permitida por este contrato es al launcher PowerShell autorizado por Bearer EP y scope específico (§19.3), sobre HTTPS; el endpoint de consumo no se usa desde la UI. La restricción no significa que un servidor pueda distinguir criptográficamente un navegador de PowerShell solo por User-Agent: la capacidad Bearer debe protegerse y el host cliente está dentro del límite de confianza. Las operaciones destructivas, de cifrado, administración de cuentas o modificación de repositorios requieren gates específicos y una estrategia de recuperación.

### 9.3 Entrada y almacenamiento de token GitHub

El contrato histórico identifica una bóveda de PAT administrable desde la UI de Khora y el consumo por el bootstrap PowerShell existente; no se debe crear un path canónico alternativo ni una GitHub App para resolver este requisito sin una decisión nueva.

Requisitos:
1. La UI permite cargar, validar, rotar y borrar el PAT; el campo de entrada es temporal y el valor no se vuelve a mostrar después de guardarlo.
2. El servidor valida la credencial y almacena únicamente ciphertext con AES-256-GCM. Metadatos permitidos: cuenta, últimos cuatro caracteres, repositorios/permisos observados y fecha; nunca el token.
3. La clave de cifrado se deriva con separación de dominio de `EP_BOOTSTRAP_JWT_SECRET`. Si se rota esa raíz, el procedimiento debe exigir volver a cargar el PAT y verificar que la bóveda vuelva a funcionar.
4. La sesión EP obtiene un JWT con scopes EP mínimos para sus operaciones; el consumo PAT exige específicamente `ep:github:token`; el PowerShell servido por KHORA recupera el secreto mediante `GET /api/ep/github-token` usando el `apiBase` existente. La respuesta debe tener controles de caché apropiados (incluido `no-store`) y autorización del servidor.
5. El secreto no forma parte del comando, URL, argumentos de proceso ni logs. El launcher lo mantiene en memoria y protege cualquier blob temporal con la API de Protección de Datos de Windows (DPAPI), control de acceso y BitLocker según §20. Los blobs DPAPI no son un backup portable: en otra terminal se emite una sesión EP nueva y se recupera otra vez el PAT desde la bóveda; no se copian ni se intenta descifrarlos allí.
6. La bóveda debe fallar cerrada ante errores de almacenamiento o descifrado. Solo puede recurrir al `GITHUB_TOKEN` legado cuando la bóveda responde correctamente y confirma que no hay credencial; no ante un error ambiguo.
7. La interfaz distingue entre credencial guardada, token validado, permisos suficientes y escritura real probada. El inventario de repositorios o los scopes declarados no demuestran por sí solos capacidad de push.
8. Preferir scopes mínimos y credenciales de vida corta cuando la integración lo permita; probar rotación y revocación sin revelar el valor.

No considerar un token “seguro” solo porque la UI lo enmascara. Deben verificarse almacenamiento, acceso del servidor, logs, copias de seguridad, ciclo de vida y permisos efectivos.

### 9.4 Pruebas obligatorias de Khora

- usuario no autenticado/no autorizado no puede ejecutar comandos;
- usuario autorizado sin privilegio específico tampoco puede ejecutarlos;
- OIDC sigue protegiendo Khora general; la única alternativa incluida es la sesión maestra limitada a EP de §19.3, no un break-glass general;
- contraseña incorrecta, agotamiento de intentos, sesión expirada y revocación fallan de forma cerrada;
- el PAT no aparece en HTML/DOM recuperable, almacenamiento de navegador, logs, respuestas de error, analytics o repositorio;
- token inválido/expirado no se presenta como conectado;
- rotación y revocación tienen efecto comprobado;
- inyección de comandos, argumentos maliciosos, rutas ambiguas y salidas con secretos se prueban;
- las operaciones administrativas se ejecutan bajo la identidad Windows prevista y se auditan;
- el flujo completo se prueba E2E en un entorno autorizado sin exponer credenciales.

Hasta obtener evidencia, cada punto permanece como requisito/pending; no como capacidad disponible.

### 9.5 Repositorios y roles: no confundir catálogo con bootstrap

La implementación candidata de la bóveda enumera seis repositorios de `SeryMente`: `CENSUS`, `GDP`, `metodologia`, `otrogranprograma`, `signal-interpreter` y `khora`. El bootstrap transversal histórico materializa cinco: los anteriores salvo `CENSUS`. Son listas con roles diferentes, no prueba de que CENSUS deba clonarse en toda sesión.

El contrato de esta revisión conserva la validación de seis repositorios de la bóveda candidata y los cinco del bootstrap de referencia; no añade CENSUS automáticamente a una selección de workspace ni elimina su validación de la bóveda. La selección multi-repositorio se toma del catálogo/selección firmados de la sesión. Antes de liberar, probar los seis nombres contra los remotes autorizados, la separación `runtime`/`workspace` y la materialización del conjunto seleccionado. Un rename real, acceso faltante o desacuerdo entre UI, servidor y launcher produce `BLOCKED_REPO_CONTRACT`; no se sustituye el nombre por aproximación ni se amplían permisos sin autorización.

El antecedente exige `Contents: Read and write` y `Metadata: Read` donde corresponda. La metadata no acredita escritura: realizar commit/push de un archivo inocuo en una rama de prueba autorizada, leer el mismo SHA remoto y conservar referencia de evidencia. No probar contra `main`, datos productivos o un repositorio ajeno; eliminar solo la rama creada por esta prueba si la autorización incluye su limpieza.

### 9.6 Estado histórico de implementación: no confundir con estado actual

El anexo histórico registró la UI/bóveda en la rama `feat/ep-github-token-vault-ui`, PR #292, con migración `017_ep_github_credential_vault.sql` pendiente de aplicar a producción. En ese corte se registraron fallos de CI, UI Quality, Khora Single Script Guard y `khora-ok / gate`; los logs no pudieron recuperarse por `BlobNotFound`. No se había cargado PAT/contraseña real, no se había aplicado la migración en producción y no se había probado el arranque real con Windows PowerShell 5.1. Por tanto, ese corte **no certificaba** la funcionalidad E2E.

Este dato es evidencia histórica, no estado actual de la rama ni de producción. Antes de declarar implementado/operativo/E2E, consultar el PR, la rama y el deployment actuales, revisar la migración y los checks, y ejecutar pruebas reales autorizadas. Si la evidencia actual no está disponible, el estado queda **NO VERIFICADO**.

### 9.7 Snapshot remoto de la consolidación original al 2026-10-10

La consolidación original registró los siguientes datos de PR. Se preservan como snapshot histórico, no como comprobación de HEAD/checks de una ejecución futura ni como certificación del producto:

- **PR #292 — Add EP master-password gate and encrypted GitHub token UI:** abierto, draft, sin merge; rama `feat/ep-github-token-vault-ui`; HEAD `6738c1f1aeffe5835a725531e0774d4420af13c5`. El cuerpo del PR reporta CI, UI Quality, `khora-ok / gate` y Khora Single Script Guard en FAILURE; los jobs terminan sin runner/steps visibles y los logs devuelven `BlobNotFound`. No se debe inferir que los tests llegaron a ejecutarse. Las pruebas locales anteriores al último commit no sustituyen ejecutar nuevamente typecheck, suites unitarias/UI y pruebas E2E después del patch. No se ha demostrado aquí el uso de secretos reales, migración productiva ni PowerShell 5.1 real.
- **PR #294 — EP CECEQ: separar identidad MantenimientoRCI y árbol de datos Fila4:** abierto, draft, sin merge; rama `fix/ep-ceceq-mantenimientorci-fila4-profile-v2`; HEAD `c62661c2c7be5f9763d9fb73ee52ac028fb8d2e4`. Es un frente distinto, relacionado con identidad efectiva y destino de datos. Su presencia no demuestra que el bootstrap EP ni el host CECEQ estén certificados.

En consecuencia, las funciones de puerta maestra/bóveda y la separación de identidad/destino permanecen **EN DESARROLLO / NO CERTIFICADAS E2E**. Volver a consultar los PR y sus checks antes de cada ciclo; no reutilizar estos SHA como si fueran el HEAD vigente en una fecha posterior.

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

## 12. Secuencia de ejecución y aceptación

Un solo ciclo de liberación tiene `release_id`, alcance congelado, candidato identificable y checkpoint remoto. Puede incluir varias sesiones, reinicio de un host de prueba o confirmaciones humanas; no significa una respuesta de chat, un comando monolítico ni una garantía de tiempo. La secuencia detallada se encuentra en §24.

| Fase | Acción y gate obligatorio | Si falla |
|---|---|---|
| A — Adquisición | Frescura, perfil de entrega, commits, versión activa, host/destino, permisos y dependencias resueltos (§18–§19, §25). | BLOCKED; ninguna mutación productiva. |
| B — Plan cerrado | Contratos, amenazas, autorizaciones de diseño/seguridad/arquitectura, respaldos, migraciones y reversión concretos aprobados. | No construir lo no autorizado; no convertir decisiones en defaults. |
| C — Implementación aislada | Extender componentes existentes en rama/staging, versiones y hashes fijados; proteger cambios locales y secretos. | Conservar baseline y diagnosticar causa. |
| D — Verificación candidata | Pruebas automáticas sobre el candidato exacto, logs/steps disponibles; host Windows PowerShell 5.1 real y gates del perfil (§23). | Sin merge ni publicación. Un check sin evidencia no es PASS. |
| E — Readiness | Matriz completa, revisión humana requerida, artefacto, migración ensayada, almacenamiento/read-back aplicables al perfil y rollback verificados; pruebas prepublicación completas. | `release_ready=false`; no promocionar. |
| F — Publicación controlada | Integrar individualmente, fijar SHA integrado, construir artefacto, aplicar migración autorizada y desplegarlo en el destino existente (§24). | Revertir según alcance; nunca borrar datos para forzar compatibilidad. |
| G — Verificación activa | Alias/destino sirve SHA/versiones previstos; pruebas positivas/negativas y arranque real contra el despliegue publicado. | No declarar publicado verificado; restaurar versión compatible. |
| H — Certificación y cierre | Evidencia leída de vuelta, matrices por componente/perfil, próximos pendientes y retención/limpieza confirmados. | Estado parcial exacto, sin elevarlo a certificación integral. |

EP v1.0 mínimo y EP integral tienen gates diferentes (§18.2). Una certificación parcial nunca se presenta como conclusión global. Las pruebas de caída/reinicio integral se hacen exclusivamente en un host de prueba autorizado; en CIBERCAFE rige presupuesto de reinicio cero.

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
| Canon transversal EP | Canon transversal publicado en la baseline documental; revisión ejecutable v1.1.0 pendiente de read-back de su propia escritura | Verificar publicación y referencias cruzadas en main |
| Identidad/volatilidad por terminal | Reglas y registros por terminal documentados | Lectura actual del host/terminal y pruebas por terminal |
| Persistencia remota/checkpoints | Diseño descrito | Read-back, SHA y prueba de restauración desde el destino real |
| VHDX/BitLocker | Requisitos y plan descritos en documentos previos | Estado real del volumen, cifrado, recuperación y claves protegidas |
| WordPress local/WP-LAB | Especificación e integración documentadas | Bootstrap limpio, pruebas funcionales, backup consistente y restore aislado |
| Laboratorio OGP | Alcance de generación/edición documentado | Flujo reproducible, licencias/procedencia, persistencia y recuperación de una entrega |
| Khora: contraseña maestra/OIDC/PowerShell | Requisito del usuario incorporado; implementación no verificada aquí | Verificar código candidato, conformidad con §19.3, aprobaciones de ejecución y pruebas de autorización/seguridad |
| Khora: token GitHub como secreto | Requisito de UI y seguridad incorporado; implementación no verificada aquí | Localizar almacenamiento/consumo reales, verificar ausencia de exposición, rotación/revocación |
| E2E entre sesiones/terminales | Procedimiento especificado | Simular pérdida de sesión, recuperar en sesión/terminal nueva y documentar resultado |
| Certificación global | **NO CERTIFICADA** | Todos los gates de la fase 12 completados y revisados |

**Estado global permitido:** ESPECIFICACIÓN CONSOLIDADA; EJECUCIÓN FÍSICA Y E2E PENDIENTES DE EVIDENCIA. No elevar a certificado por la creación de este documento.

## 15. Riesgos abiertos y decisiones que requieren evidencia

1. Identificar los destinos persistentes reales y confirmar que cada clase de artefacto está cubierta.
2. Comprobar si el volumen cifrado y el mecanismo de recuperación existen en la terminal objetivo.
3. Inspeccionar la rama vigente de KHORA y reconciliar los documentos de arquitectura y validación.
4. Inspeccionar y probar los archivos de Khora enumerados en §19; sus rutas son localizadores, no evidencia de producción.
5. Verificar la implementación del acceso maestro alternativo y limitado a EP definido en §9.1/§19.3; no es segundo factor global ni break-glass de toda Khora. Cualquier ampliación requiere decisión nueva.
6. Verificar la bóveda AES-256-GCM definida en §19, permisos efectivos, revocación y procedimiento autorizado de rotación; fijar responsables y referencias privadas, nunca valores secretos.
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
- todas las fases A–H y los gates del perfil EP-INTEGRAL tienen evidencia reproducible;
- EP persiste datos en destinos autorizados y supera read-back/restauración;
- la identidad de terminal y usuario se conserva y valida;
- WordPress local se reconstruye y restaura de forma completa;
- el laboratorio OGP conserva fuentes y entregables y permite retomarlos;
- Khora aplica autorización segura a PowerShell y gestiona tokens sin exposición;
- una sesión nueva/otra terminal recupera contexto y trabajo sin depender de la sesión anterior;
- todos los documentos y repositorios apuntan a esta fuente transversal sin contradicciones;
- un revisor independiente puede repetir los pasos y obtener resultados equivalentes;
- la publicación de producto, SHA/artefacto, alias activo, migraciones y pruebas pospublicación cumplen §24;
- `release_ready`, `published_verified` y `global_certified` son afirmaciones separadas sustentadas en §25.

Hasta entonces, el estado global seguirá siendo **PENDIENTE DE CERTIFICACIÓN E2E**.

## 18. Contrato de actualización y alcance congelado

### 18.1 Resultado exigible y límite de suficiencia

Esta revisión documenta una actualización coordinada del sistema existente, no una reescritura ni una nueva arquitectura. Antes de modificar código, el ejecutor produce un plan derivado de este archivo: componente, requisito, archivo real, cambio necesario, prueba, autorización y reversión. No necesita una conversación o anexo para descubrir qué se exige. Sí necesita acceso a repositorios, host, servicios, activos y autorizaciones: escribir una especificación no crea esos recursos.

La versión de este documento (`v1.1.0`), la Metodología, el Sistema de Instrucciones, el host/bootstrap y `khora-web/package.json` son identidades distintas. Ninguna se usa como versión de otra. El número exacto de publicación del producto se calcula desde su baseline real conforme a su política vigente y se congela antes del primer cambio; la baseline del corte no se presenta como vigente para siempre. Sin baseline inequívoca o política de versión verificable, `BLOCKED_VERSION_BASELINE`.

**Un ciclo:** desde adquisición hasta publicación verificada o salida bloqueada/fallida, con un único `release_id` y candidato congelado. Una corrección que modifica el candidato invalida las pruebas afectadas y genera una revisión del manifiesto dentro del mismo ciclo. No se preserva un PASS de un SHA anterior para otro candidato. Un bloqueo por credencial, licencia, host, decisión material, cuota o runner es una salida legítima, no permiso para simular el cierre.

### 18.2 Perfiles de entrega sin equivalencias falsas

| Perfil | Resultado obligatorio | Qué no acredita |
|---|---|---|
| `EP-V1-MINIMO` | Puerta EP limitada, gestión PAT por OIDC, bóveda/consumo seguro, migraciones, launcher actual con pin/hash, arranque Windows PowerShell 5.1 y publicación verificable. | No certifica cámara, editor, RDC completo, WordPress, IA visual ni recuperación global. |
| `EP-FUNDACIONAL` | EP-V1-MINIMO más workspace/exportaciones, Notepad++, OBS/Chrome, RDC/ficha, eventos y dos instanciaciones sin reinicio. | No certifica persistencia WP/IA ni recuperación integral. |
| `EP-INTEGRAL` | EP-FUNDACIONAL más persistencia, cifrado/limpieza, WP-LAB, pipeline local OGP, caída/restauración y pruebas activas completas. | No autoriza publicación editorial del sitio OGP, cambios de arquitectura ni acceso general por contraseña maestra. |

La entrega mínima v1.0 fue delimitada en el antecedente §22; se preserva y no se le agregan subsistemas por conveniencia. Cuando la orden sea «sistema completo de extremo a extremo», el perfil es `EP-INTEGRAL`: no se reduce al mínimo para declarar éxito. Una entrega parcial solo puede publicarse como parcial, con ese alcance autorizado; no satisface el objetivo integral. El número semántico final no se infiere del nombre del perfil.

### 18.3 Precondiciones materiales y autorizaciones

Antes de la construcción afectada deben existir: permisos sobre los repositorios seleccionados; revisión presencial del operador para UX/UI, seguridad y arquitectura cuando aplica; autorización de migración/configuración productiva y prueba de escritura; host Windows elegible; destinos privados; fuentes/activos licenciados; acceso al proveedor de publicación existente; pruebas con logs; y un responsable de rollback. La orden de editar este canon no satisface esas autorizaciones de ejecución.

Todo dato de entorno se obtiene con descubrimiento de solo lectura o del canal privado autorizado, se valida y se congela en el manifiesto. Una política de retención, un nuevo proveedor, coste, volumen a cifrar, cuenta autorizada o mecanismo de atestación no aprobado no se decide por un default del agente. `BLOCKED_DECISION` identifica exactamente el campo y su impacto. Las fases independientes pueden prepararse, pero no se promociona la candidata incompleta.

## 19. Baseline, localizadores e interfaces existentes

### 19.1 Inventario de fuentes y puntos de modificación

Estos localizadores son concretos; observarlos en la revisión elegida y registrar blob/commit. Si un archivo se movió, resolverlo mediante el árbol real y registrar el cambio de ruta; no inventar un sustituto.

| Repositorio | Archivos/puntos existentes | Responsabilidad de actualización |
|---|---|---|
| `SeryMente/metodologia` | Este canon; `SI-METACOGNITIVO.md`, `METODOLOGIA.md`, `README.md`; `scripts/bootstrap-entorno-persistente.ps1`, `scripts/bootstrap-cibercafe-cli.ps1`; `ESTADO-RDC-ACTIVO.md` y `CIBERCAFE/` | Gobierno, bootstrap transversal, registros saneados y referencias subordinadas. |
| `SeryMente/khora` | `scripts/khora/khora.ps1`, `khora.barrel.ps1`, `modules/`, `env-vault.ps1`, `tests/Test-Arranque.ps1`, `tests/validate_ep.py` | Gate único, launcher, workspace, cifrado, Guardian, cierre e integridad. |
| `SeryMente/khora` | `khora-web/lib/server/ep.ts`, `ep-master-password.ts`, `ep-github-credential.ts`, `ep-bootstrap-content.ts`; `lib/ep-master-session.ts` | Sesiones, autorización, verificador maestro, bóveda, descriptor y fuente servida. |
| `SeryMente/khora` | `khora-web/app/auth/ep/page.tsx`, `app/components/ep/EntornoPersistentePanel.tsx`, `app/sistema/seguridad/page.tsx`, `app/navigation/registry.ts`, `middleware.ts` | Puerta EP, UI, navegación, protección general. No crear otra puerta. |
| `SeryMente/khora` | `khora-web/app/api/ep/`; `db/migrations/016_ep_persistent_sessions.sql`, `017_ep_github_credential_vault.sql`; `scripts/migrate-ep.mjs`, `migrate-runtime.mjs` | Rutas API y cambios de esquema compatibles. |
| `SeryMente/khora` | `khora-web/package.json`, lockfile, `tests/unit/ep_security.test.ts`, workflows y `ep-integrity-manifest.sha256` | Comandos de prueba/build, checks e integridad publicados. |
| `SeryMente/serymente` | `reconstruction/lab/bootstrap-ser-y-mente-lab.ps1`, `custom-code`, módulos Blog, `reconstruction/lab/LOCAL-STUDIO-4.24.md` | Reconstrucción WordPress, plugins/rutas y bootstrap seguro. |
| `SeryMente/GDP`, `signal-interpreter`, `otrogranprograma`, `CENSUS` | Árbol real, rama por defecto, manifiestos/selección | Acceso y materialización según rol firmado; no modificar productos ajenos al alcance. |

El PR #292 es un punto de recuperación de código candidato, no una dependencia de autorización ni garantía de vigencia. PR #294 es un frente de identidad CECEQ que solo se integra si el perfil/host o los archivos realmente lo requieren. No mezclar ambos por su número. Resolver conflictos contra la baseline actual, revisar diff y probar el resultado integrado.

### 19.2 Identificación exacta de candidata y destino

Registrar por repositorio: URL/origin, visibilidad, rama por defecto observada, SHA base, SHA candidato, archivos cambiados, blob hashes y versión leída. Fijar una instantánea por repositorio; las consultas de código posteriores usan ese commit. Si main cambia antes de integrar o la selección cambia, reconciliar en staging y repetir el cono de pruebas afectado.

El destino de Khora es su proyecto/alias ya configurado; la URL histórica `https://khora-web.vercel.app/sistema` es un localizador, no autorización para publicar en otro proyecto. Obtener `apiBase` del descriptor autorizado y comprobar que es HTTPS, termina exactamente en `/api/ep`, carece de credenciales/query/fragmento y coincide con la audiencia firmada/configuración canónica. No deducirlo de la ventana activa ni emitir una URL nueva por comodidad.

### 19.3 Contrato de autorización por principal y operación

La contraseña maestra es **autenticación alternativa de alcance EP**, no segundo factor de Khora general ni break-glass universal. La alta, recuperación, rotación y administración de secretos siguen requiriendo OIDC autorizado. La llave de bóveda, la contraseña maestra, el JWT Khora y el PAT GitHub son credenciales diferentes; ninguna otorga por sí misma elevación Windows.

| Operación/ruta existente | Principal permitido | Resultado y restricciones |
|---|---|---|
| `/auth/ep`, `POST /api/ep/master-auth` | Usuario que presenta contraseña maestra válida | Sesión maestra breve EP; limitar intentos, verificar origen, cookie segura, no exposición de estado interno. |
| `/api/ep/master-password` | OIDC y cuenta permitida | Consultar/configurar/rotar según métodos implementados; nunca devolver contraseña/verificador. |
| `/api/ep/github-credential` | OIDC y cuenta permitida para mutaciones | Cargar/rotar/borrar PAT; salida redactada. Una sesión maestra solo obtiene estado no sensible si el contrato lo permite; nunca administra el PAT. |
| `POST /api/ep/token` | OIDC autorizado o sesión maestra EP vigente en el flujo limitado | Sesión `launchMode=normal`, descriptor actual, token y `apiBase`; scopes específicos. Rechazar `clean-host`. |
| `GET /api/ep/bootstrap` | Bearer con `ep:bootstrap` | Fuente PowerShell exacta, sin caché, correspondiente al candidato fijado. |
| `GET /api/ep/github-token` | Bearer vigente con `ep:github:token` | JSON con `token`, `purpose="ep-bootstrap"`, `sessionId` correspondiente al `sid`. Solo consumo del launcher, no UI. |
| `/api/ep/repos` | Sesión EP/alcance validado por servidor | Catálogo/selección autorizados; roles y commits trazables. |
| `POST /api/ep/events`, `GET /api/ep/logs` | Bearer `ep:logs:write` / `ep:logs:read` | Eventos y lectura solo del sujeto/sesión autorizados, saneados. |
| Páginas y APIs generales | OIDC según política existente | La sesión maestra no abre acceso general; ocultar pestañas no concede autorización. |

Para Bearer validar `alg=HS256`, `typ=JWT`, firma, `iss=khora-ep`, audiencia canónica, sujeto, `sid`, `jti`, scope, expiración y revocación. El servidor es la autoridad; validación de formato en PowerShell no reemplaza firma del servidor. La emisión/revocación y limitación de tasa deben ser transaccionales; reutilizar tablas/sesiones existentes. Una solicitud sin identidad, scope o sesión válida no entrega secretos.

Las respuestas de consumo PAT requieren `Cache-Control: no-store, max-age=0`, `Pragma: no-cache`, `Referrer-Policy: no-referrer`, `X-Content-Type-Options: nosniff`. Los errores son públicos estables y no contienen token, ciphertext, consulta SQL, stack interno ni cuenta. Una respuesta HTTP 200 con purpose/sesión inválidos se rechaza; no se acepta como conexión.

### 19.4 Bóveda, rotación y esquemas

Persistir el PAT exclusivamente como AES-256-GCM: IV aleatorio 12 bytes, tag 16 bytes, ciphertext y versión. La implementación candidata usa formato `v1.<iv-base64url>.<tag-base64url>.<ciphertext-base64url>` y clave HMAC-SHA256 de `EP_BOOTSTRAP_JWT_SECRET` con dominio `khora-ep-github-credential-v1`. No cambiar formato ni raíz sin migración y decisión de seguridad. Validar credencial contra `/user` y los repositorios exactos; prefijos compatibles `ghp_`, `github_pat_`, `gho_` no son prueba de permisos.

Si la raíz criptográfica rota: bloquear consumo, invalidar sesiones/artefactos dependientes según política, configurar la raíz por canal privado, reconfigurar verificador maestro dependiente del pepper, volver a cargar PAT mediante OIDC y verificar consumo/rotación antes de reabrir. Nunca guardar la raíz anterior para ocultar un fallo de descifrado ni caer a credencial legado por error. Revocación GitHub, borrado de bóveda y revocación de sesiones son operaciones distintas: probar el efecto real de cada una.

Configuración requerida sin valores: `EP_BOOTSTRAP_JWT_SECRET` (mínimo 32 caracteres), `EP_CANONICAL_URL`, `EP_ALLOWED_EMAIL`, `DATABASE_URL`, `AUTH_SECRET`, `OIDC_ISSUER_URL`, `OIDC_CLIENT_ID`, `OIDC_CLIENT_SECRET`; `VERCEL_TOKEN` solo donde el flujo autorizado de publicación lo requiera. Inventariar nombre, responsable, entorno, estado de presencia/validación y referencia privada; nunca copiar valores a este canon, evidencia pública o manifiesto.

Aplicar migraciones 016/017 con `npm run migrate:ep` desde `khora-web` únicamente después de verificar el código real del runner y ensayarlo en base aislada. Registrar hash de SQL, esquema antes/después, idempotencia, transacción donde sea aplicable y backup consistente privado. `migrate:runtime` no es sustituto supuesto; verificar su alcance antes de usarlo. No ejecutar una migración productiva como primera prueba.

## 20. Contrato Windows, launcher, cifrado y continuidad

### 20.1 Preflight y destinos efectivos

Requiere Windows compatible, Windows PowerShell 5.1 real, elevación administrativa para BitLocker/tareas, Escritorio local escribible y mínimo 6 GiB libres; calcular además el espacio requerido por datos/runtime/modelos y staging. Resolver host por DNS/`Win32_ComputerSystem` y usuario efectivo por `WindowsIdentity`; no depender de `COMPUTERNAME` vacío ni inferir perfil interactivo desde el proceso elevado.

En CECEQ: identidad efectiva elevada `central\MantenimientoRCI`, árbol de datos `C:\Users\fila4\...`. Redirigir rutas del proceso antes de la primera escritura, sin cambiar/suplantar identidad ni modificar perfiles persistentes. No escribir historial, credenciales, configuración, temporales o blobs en el perfil MantenimientoRCI. Resolver el perfil real de fila4 y rechazar ambigüedad/reparse points. Para blobs efímeros que crucen procesos en ese contrato se usa DPAPI de equipo con ACL restrictiva, en el árbol permitido y con eliminación explícita; el ámbito de equipo no sustituye autorización del archivo.

### 20.2 Cadena de integridad del comando

Un punto de entrada único: `scripts/khora/khora.ps1`. La UI usa el launcher existente y entrega un comando completo, de una línea física, sin secretos ni sustituciones manuales. El descriptor fija plataforma/shell, versión mínima, `apiBase`, revisión de fuente y SHA-256. La fuente embebida de `ep-bootstrap-content.ts`, decodificada, debe coincidir byte por byte con el `.ps1`, incluyendo BOM y saltos de línea; regenerar/validar después de cualquier cambio del gate.

Secuencia: adquirir token Khora por el flujo actual → validar formato y apiBase → leer/limpiar portapapeles si el flujo lo utiliza → descargar la fuente autorizada → validar tamaño/tipo, pin y SHA-256 → materializar `.ps1` con UTF-8 BOM en temporal único permitido → proteger credencial interproceso → invocar explícitamente Windows PowerShell 5.1 con `-File` y referencias a archivos protegidos, no secretos en argumentos → limpiar en `finally`.

No usar `ScriptBlock.Create`, `Invoke-Expression` o evaluación inline para el gate con `#requires`, `CmdletBinding` y `param`. Un hash entregado por la misma descarga sin un descriptor confiable no agrega autenticidad. No descargar/ejecutar una rama móvil como sustituto del commit fijado. El bootstrap histórico transversal que solicita PAT es referencia de compatibilidad, no la vía nueva que debe volver a pedirlo.

El launcher obtiene el PAT desde §19.3 sin mostrarlo, escribirlo al portapapeles ni pedirlo otra vez. Comprueba purpose y sessionId; elimina referencias/archivos en éxito y fallo. Puede seguir pidiendo la llave de bóveda por el flujo seguro existente: eliminar el prompt PAT no elimina factores distintos. Prueba mutex/anti-duplicación, errores, cancelación, elevación, limpieza y preservación de WIP.

### 20.3 Parámetros de volumen recuperados de la implementación

- Contenedor exterior: Escritorio efectivo más `KHORA-EP-<session-id>`; `session-id` real se genera por ejecución, no es texto para sustituir manualmente.
- Archivo `khora-ep-medio.vhdx`, dinámico, máximo lógico 65 536 MB; primera letra libre de Z a R; NTFS, etiqueta `KHORA_EP_V1`.
- BitLocker `XtsAes256`, `UsedSpaceOnly`, `ProtectionStatus=On`, `EncryptionPercentage=100`. No alternativa silenciosa EFS/carpeta sin cifrar.
- Protector de contraseña derivado de la llave de bóveda mediante PBKDF2-HMAC-SHA256, 200 000 iteraciones, sal `KHORA-EP-V1|` seguida del session-id, 32 bytes codificados Base64. Los materiales secretos no se escriben a disco/logs.
- Raíz interna `khora-ep`; workspace `EP`, runtime `repo`, `tools`, `session-state`, `logs`, `cache`, `tmp`, `venv` y perfil portátil. `Desktop/EP` es junction al workspace, no segundo almacén. Si ya existe una carpeta o junction ajena, conservarla y bloquear; no convertirla automáticamente.
- Redirigir TEMP/TMP, GH_CONFIG_DIR, GIT_CONFIG_GLOBAL, NPM_CONFIG_CACHE, PIP_CACHE_DIR, XDG_CONFIG_HOME/XDG_DATA_HOME y perfil/configuración a destinos permitidos.

El VHDX de sesión es cifrado y efímero: **no es por sí solo el destino duradero de recuperación**. Recuperar en otra terminal significa rehidratar código/perfil/datos desde remotes confirmados, emitir nuevas sesiones y obtener de nuevo secretos autorizados. No trasladar blobs DPAPI, ni asumir que un contenedor eliminado sobrevive a Deep Freeze.

### 20.4 Etapas estables y cierre

Preservar sin renumerar `EP-IN-010/015/020/030/040/050/060/070/075/080/090/100/110/120/130`, `EP-RUN-010/020/030` y `EP-OUT-010` a `100`. Su orden sigue dependencias reales: validar identidad → llave → volumen → junction/limpieza → GitHub/fuente exacta → selección/workspace → verificar publicación → VS Code/bóveda/dependencias → vigilancia/operativo. El identificador 015 no obliga a crear junction antes del volumen.

Registrar START remoto antes y OK/FAIL después de cada etapa crítica. La baseline del ledger usa hash encadenado `SHA-256(hash_anterior || evento_canónico)`, secuencia única por sesión y bloqueo transaccional. Tras tres intentos sin confirmación remota no continuar una etapa crítica. Esta bitácora no es backup de datos.

Guardian vigila terminal/supervisor, VS Code, `cleanup.request`, latido e inactividad (baseline 15 minutos). En salida: detener procesos → exportar perfil cifrado y hacer push WIP de rutas explícitas autorizadas → verificar SHA remoto → purgar secretos → quitar únicamente junction propia → bloquear → desmontar → eliminar contenedor propio → desregistrar tarea solo si no quedan residuos → cerrar registro remoto/purgar token. Nunca `git add -A` con archivos inesperados ni `reset --hard`, `git clean` o borrado de árboles ajenos.

La confidencialidad prevalece ante un fallo de cierre: el cierre de emergencia no se bloquea indefinidamente esperando un push; se sanea/purga/bloquea aunque haya pérdida de continuidad y esta se registra. Para datos recuperables deben existir checkpoints periódicos previos, no depender del cierre. Deadman no elimina remotes confirmados. La tarea AtStartup como SYSTEM permanece si hay residuos propios; probar que no borra un directorio distinto y que solo se desregistra tras verificar eliminación.

CIBERCAFE: `PRESUPUESTO-REINICIO=0`; no reiniciar/apagar PC-N ni forzar cierre de aplicaciones del usuario. Probar reinicio solo en máquina de prueba expresamente autorizada. No confundir dos instanciaciones sin reinicio con una prueba de recuperación tras pérdida física.

## 21. Workspace, fundación y WordPress reproducibles

### 21.1 Repositorios y exportaciones

Mantener una única raíz según el launcher real; no crear simultáneamente `Desktop/EP` y un workspace paralelo. Checkouts fuente y extensiones exportadas son objetos distintos. Los roles lógicos del bootstrap transversal son: `metodologia`, `otro-gran-programa`, `gestor-de-procesos` (export GDP), `signal-interpreter-source`, `signal-interpreter` (export `extension/`) y `khora`; resolver los paths existentes antes de materializarlos.

Antes de sincronizar: `.git`, origin exacto, rama prevista, árbol limpio, HEAD y permisos. Solo fast-forward cuando corresponda; para evaluar la candidata usar staging/worktree limpio del SHA, no forzar main local. Exportación requiere marcador de propiedad, commit fuente y hashes; comparar manifest JSON parseado y árbol con el origen. Si el destino no tiene marcador o fue modificado, bloquear en vez de sobrescribir. Preparar staging, comprobarlo y promoverlo con backup/rollback; no añadir una carpeta extra que oculte `manifest.json`.

### 21.2 Notepad++, OBS, Chrome y RDC

Reutilizar binarios oficiales verificados; instalar solo ausentes/incompatibles y registrar versión/origen/firma/hash. Para Notepad++ comprobar asociaciones `.txt`, `.log`, `.md`, `.json`, `.ps1` y los formatos fuente explícitamente acordados: resolver la aplicación predeterminada real. No fabricar hashes UserChoice ni alterar perfiles; si Windows requiere elección humana, `BLOCKED_DEFAULT_APP` hasta confirmación y read-back.

OBS: instalado → componente virtual registrado → proceso vivo → log reciente de salida Virtual Camera → PnP activo → escena/fuente legítima → prueba autorizada de imagen. Ninguna evidencia sustituye la siguiente. Chrome se verifica separadamente mediante enumeración/acceso normal autorizado; el bootstrap no abre/cierra/inspecciona/modifica Chrome ni sus perfiles/políticas/permisos. Si la prueba de navegador necesita acción humana, esperarla; no afirmar detección por el log OBS. No usar cámara para suplantar identidad/presencia ni eludir liveness.

RDC: iniciar cliente en primer plano al final del arranque útil; handshake humano real cuando lo requiera; observar dispositivo Online, nombre/ID/fecha de la sesión actual. Copiar ficha al portapapeles solo tras verificar campos: TERMINAL_ID, fuente de identidad, RDC_DEVICE_NAME/ID/STATUS/VERIFIED_AT, SESSION_RUN_ID, BOOTSTRAP_COMMIT/SHA256, estados cámara Windows/Chrome, NOTEPADPP_VERSION, REPOS_HEADS y LOG_PATH. Campos faltantes son NOT_VERIFIED; nunca copiar códigos de autorización, contraseñas o tokens. IDs/datos personales se guardan en registro privado, no en Git público.

Agente de desempeño y observador son componentes distintos; observador solo lee eventos en ventana hija con ruta/identidad pasadas explícitamente. Muestreo local de referencia 5–10 segundos, sin llamadas RDC por muestra; no duplicar procesos ni optimizadores. La fundación pasa con dos instanciaciones controladas consecutivas, todos sus gates PASS, sin reinstalar artefactos íntegros, destruir cambios ni reiniciar.

### 21.3 Inventario y reconstrucción WordPress

WordPress Studio es el runtime local de referencia; observar y fijar versiones reales de Studio, Node, PHP, core, motor/base de datos, tema/plugins y herramientas de exportación. Studio 1.23.0, WordPress 6.4.13, PHP 8.2, Node portátil 22.23.3 y localhost:8881 son datos históricos, no una instalación actual ni puertos que deban forzarse.

La última selección de tema del antecedente es Divi 4.23.1; no reemplazarla por 4.24.0 sin autorización. Resolver ZIP real, estructura sin path traversal, versión interna, SHA-256, procedencia y licencia. El hash histórico de Divi 4.24.0 no valida 4.23.1. Si falta activo autorizado, `BLOCKED_LICENSED_ASSET`: continuar preparación independiente, no certificar WordPress integral ni publicar binarios propietarios.

Unidad recuperable: DB/esquema, uploads, configuración permitida, plugins/tema autorizados, core/dependencias, código custom, referencias/licencias y manifiesto. Bajo workspace: `EP-WP-LAB/site`, `snapshots`, `tools`, `manifests`. Los snapshots completos van además al destino privado probado; Git solo conserva código y metadatos saneados. Render efímero no es backup.

Correcciones obligatorias del bootstrap histórico antes de ejecutarlo:
1. Eliminar sincronización destructiva con `reset --hard` y conservar todo checkout sucio.
2. Preparar sourceRoot, tema y módulos en staging; no borrar `sym-lab-source` o Divi activos antes de verificar reemplazo y backup completo.
3. No usar fallback cloud `/opt/serymente` como plugin local no validado; resolver una única ruta de carga de Blog y sus dependencias.
4. Exportar DB de forma consistente y asociarla con medios/configuración del mismo checkpoint; verificar hashes/tamaño y restaurar en aislamiento antes de promoción.
5. Medir las versiones del manifiesto, no escribir versiones supuestas; comprobar ubicación/cifrado y resultados funcionales.

Aceptación: en el host real y de nuevo después de restore, `/`, `/psicologos/`, `/blog/`, `/comenzar/`, `/para-terapeutas-psicologos/` responden correctamente con contenido esperado, sin fatales ni cabecera/pie/assets duplicados; medios accesibles, administración local autorizada y ausencia de paths absolutos accidentales. Un 200 de página vacía/login/redirect no basta. Conservar el sitio original hasta aceptación y recuperación. No restaurar encima de un sitio funcional por defecto.

## 22. Datos duraderos, IA visual y entrega OGP

### 22.1 Contrato de almacenamiento y políticas

No escoger un proveedor privado sin decisión material aprobada. El ejecutor debe resolver y registrar para cada clase: storage ID autorizado, objeto/namespace, región si aplica, acceso, cifrado, responsable, retención en días/número, frecuencia máxima de checkpoint, pérdida admisible y tiempo máximo de recuperación aprobados, coste/cuota y procedimiento de lectura/restore. Sin estos valores concretos, `BLOCKED_STORAGE_POLICY`; no usar cero, infinito o un default silencioso.

Mapa requerido: código→Git autorizado; evidencia pública→Metodología saneada; ledger EP→DB Khora; perfil cifrado→mecanismo `ep-state` remoto existente verificado; WP DB/medios/snapshots→almacén privado aprobado; fuentes/salidas OGP y pesos/runtime recuperables→destinos privados autorizados; secretos→bóveda/almacén aprobado. PostgreSQL/Blob no cubren una clase hasta demostrarlo. No ampliar Blob para backups sin decisión y pruebas.

Checkpoint: inventario y consistencia → empaquetado/cifrado según clasificación → manifiesto con objetos incluidos/excluidos y SHA-256/tamaño → escritura en staging remoto → lectura de vuelta y comparación → commit/promoción del checkpoint válido → registro duradero. No sobrescribir el último checkpoint válido con uno incompleto; GC/retención solo después de lectura de un sucesor válido y conforme a la política. Medir pérdida/tiempo contra límites aprobados; no afirmar continuidad sin periodicidad efectiva.

Probar interrupción de subida, corrupción, destino no legible, credencial expirada y restauración desde sesión limpia/host de prueba. El cifrado de disco local no cubre automáticamente el respaldo remoto ni su transporte. No trasladar datos personales, dumps, modelos o Divi a un repositorio público.

### 22.2 Pipeline local OGP seleccionado, sujeto a certificación

Ubicación autorizada: Cybernet/Luis Pasteur. Identificar terminal física, RDC, usuario y fingerprint por separado; hostname/IP/PC-N solos no atestan ubicación. Si la ubicación/atestación no está resuelta, bloquear inferencia. Mantener prohibición de inferencia OGP fuera del lugar autorizado en API, CLI y autostart; no crear un segundo resolver de terminal ni un bypass.

Candidato inicial autorizado: ComfyUI portable Windows con API local; Nunchaku/nodos; generación Z-Image-Turbo FP4 (candidato `svdq-fp4_r128-z-image-turbo.safetensors`); edición Qwen-Image-Edit-2509 compatible. Fuentes para aprovisionamiento: `https://github.com/Comfy-Org/ComfyUI`, `https://huggingface.co/nunchaku-ai/nunchaku-z-image-turbo`, `https://huggingface.co/nunchaku-ai/nunchaku-qwen-image-edit-2509`. No son un lockfile ni prueban compatibilidad/licencia.

Construir lock de capacidad a partir de pruebas en la GPU elegible: SO/build, GPU/VRAM/driver/compute capability, Python embebido, PyTorch/CUDA, ComfyUI/commit, binario Nunchaku/nodos, modelos/encoders/VAE/workflows, URLs/revisiones/hash/tamaño/licencias y comandos de instalación del componente real. Descargar solo después de elegibilidad, espacio, persistencia y licencia; reusar/reanudar artefactos íntegros. No fijar por semejanza de nombres ni hacer `latest` no verificado. Sin combinación certificable, `BLOCKED_RUNTIME_COMPATIBILITY`; una alternativa técnica/material requiere aprobación antes de sustituir backend/modelo. No cambiar a cloud/CPU ni contratar APIs para lograr PASS.

Pruebas obligatorias: importaciones íntegras; operación CUDA real sin fallback/warnings incompatibles; backend/nodos; carga de todos los modelos; generación de archivo válido; edición con referencia; recuperación nueva sesión sin descargas repetidas; rechazo de host/ubicación/GPU no autorizados sin procesos de inferencia; segunda instanciación idempotente. Solo habilitar capacidad cuando todas pasen. El espacio de trabajo y salidas se validan antes de iniciar inferencia.

### 22.3 TEST 01 y aprobación editorial

Una única imagen maestra horizontal 4:3, **UMBRAL / ENTRY AS TRANSFORMATION**. Umbral monumental abstracto de piedra/mineral/cerámica/estratos; apertura asimétrica y profundidad interior; transformación material/perceptiva, no puerta literal; luz física direccional, espacio negativo y trazas estructurales de azul profundo. Sin personas, texto ni logotipos. Lenguaje CARTOGRAFÍA DE LA TRANSFORMACIÓN; hipótesis Material Intelligence/Dark Field Cinema. Excluir cerebros azules, neuronas, nodos, circuitos, cyberpunk, futurismo genérico, partículas/explosiones decorativas, stock e ilustración corporativa.

Guardar maestro/fuentes fuera del repositorio OGP con brief, prompt, modelo, lock/runtime, parámetros, seed, tamaño/formato/hash, evidencia GPU y destino confirmado. Evaluación humana registrada: promedio mínimo 4.2/5 y ningún criterio crítico menor de 3/5. La rúbrica/criterios deben ser los aprobados por OGP, recuperados del responsable editorial y congelados en el manifiesto; no inventar una rúbrica para aprobar la imagen. Si falta, `BLOCKED_EDITORIAL_CRITERIA`.

Certificar la infraestructura no autoriza modificar `story-v3.js`, JSON canónicos, estructura visual o sitio publicado OGP. Esa integración/publicación editorial es un alcance separado con aprobación humana. EP-INTEGRAL entrega capacidad y maestro aprobado/recuperable; no atribuye publicación editorial no ejecutada.

## 23. Matriz falsable de aceptación y diagnóstico

Cada fila debe tener requisito, commit/artefacto/host, prueba ejecutada, resultado esperado, resultado observado, hora, log saneado y referencia duradera.

**Orden sin dependencia circular:** R01–R15, R17 y las filas adicionales del perfil se verifican sobre candidata/staging antes de promoción; R32 tiene una comprobación prepublicación (matriz y plan/evidencia coherentes) y otra de cierre (read-back final). R16 se ensaya en staging, pero su PASS de destino activo solo se obtiene después del deploy. `release_ready` no exige por adelantado ese PASS pospublicación: exige el ensayo y las pruebas previas, incluido R32-pre. `published_verified` exige R16 activo y R32-cierre, además de los PASS previos aún válidos. Toda prueba de recuperación/cierre se realiza sobre un host de ensayo de la candidata antes de integrar; tras publicar se comprueban los componentes realmente cambiados y el flujo activo. No cerrar esta distinción suponiendo que un ensayo es evidencia de producción. PASS solo tras comparación; FAIL significa prueba ejecutada negativa, NOT_VERIFIED significa sin evidencia, BLOCKED significa precondición externa faltante. SKIPPED solo con fila fuera del perfil o excepción expresamente aprobada; nunca para un gate obligatorio.

| ID | Perfil obligatorio | Prueba y resultado exigido |
|---|---|---|
| R01 | Todos | Frescura H1/H2, identidad de canon/SI/Metodología y commits coherentes. |
| R02 | Todos | Baseline/versión destino/alcance y autorizaciones materiales registrados; no expansión implícita. |
| R03 | Todos | OIDC general preservado; sesión maestra no accede a páginas/API generales ni administra PAT. |
| R04 | Todos | Contraseña incorrecta, fuerza bruta, expiración, rotación/revocación/origen no autorizado rechazados. |
| R05 | Todos | Guardado de PAT produce ciphertext GCM; UI solo estado redactado; DB/logs/DOM sin plaintext. |
| R06 | Todos | JWT sin firma/audiencia/scope/sid válido, expirado o revocado no obtiene bootstrap/PAT. |
| R07 | Todos | Respuesta PAT HTTPS/purpose/sid/caché correctos; launcher sin prompt PAT ni fuga de secreto. |
| R08 | Todos | Pin/hash/script embebido concuerdan byte a byte; hash alterado o fuente móvil bloquea ejecución. |
| R09 | Todos | PowerShell 5.1 sintaxis y arranque reales; `-File`, BOM, elevación, mutex y limpieza éxito/fallo. |
| R10 | Todos | Identidad/destino/reparse correctos; WIP/origin incorrecto protegidos; CECEQ si aplica sin escrituras prohibidas. |
| R11 | Todos | Antes de datos secretos: BitLocker 100%, XtsAes256/On, junction correcta, ACL/DPAPI adecuados. |
| R12 | Todos | Seis repos bóveda validados por rol; selección/materialización correcta; escritura autorizada y SHA remoto leído. |
| R13 | Todos | Migraciones 016/017 ensayadas/idempotentes; backup/compatibilidad y configuración por canal privado. |
| R14 | Todos | Tests/typecheck/build/UI/guard obligatorios PASS sobre candidata exacta con pasos/logs visibles. |
| R15 | Todos | Revisión UX/UI/seguridad/arquitectura y PR/checks resueltos antes de integrar; sin autoaprobación. |
| R16 | Todos | Alias/destino activo acredita SHA/artefacto; tests reales pospublicación y arranque frío contra él. |
| R17 | Todos | Ledger START/OK/FAIL confirmado, saneado; falta de ledger crítico impide seguir. |
| R18 | Fundacional/Integral | Checkouts y exports con manifests/hashes, una raíz y segunda ejecución sin destruir ni reinstalar. |
| R19 | Fundacional/Integral | Notepad++ resuelto como default para extensiones acordadas; no UserChoice forzado. |
| R20 | Fundacional/Integral | OBS cámara Windows/log/fuente y prueba Chrome independiente autorizada con imagen. |
| R21 | Fundacional/Integral | RDC fresco Online/handshake y ficha verdadera al portapapeles sin secretos. |
| R22 | Fundacional/Integral | Dos instanciaciones controladas PASS, observador/agente separados, presupuesto reinicio cero. |
| R23 | Integral | Destinos/políticas concretos aprobados; checkpoint read-back/hash; retención no elimina único válido. |
| R24 | Integral | WP bootstrap staging/backup/rollback; DB/medios/config consistentes y versiones reales. |
| R25 | Integral | Rutas WordPress/admin/medios esperados sin fatales, duplicados ni paths accidentales. |
| R26 | Integral | Restore WP desde remoto en aislamiento; hashes y funcionalidad coinciden; pérdida/tiempo admisibles. |
| R27 | Integral | Elegibilidad/ubicación GPU y lock IA completos; CUDA/backend/modelos/generación/edición reales. |
| R28 | Integral | Host/GPU/ubicación no autorizados bloquean API/CLI/autostart; no proceso ni fallback. |
| R29 | Integral | TEST 01 4:3, rúbrica/aprobación humana, maestro/fuentes/hash/restore; sin cambios editoriales no aprobados. |
| R30 | Integral | Caída abrupta/nueva sesión recuperan código/perfil/datos/modelos desde remotes, no copia local antigua. |
| R31 | Integral | Cierre/Guardian/Deadman/corte por etapa y reinicio en host de prueba: confidencialidad y residuos/tarea verificados. |
| R32 | Todos | Read-back de evidencia/documentación, manifest/versión y rollback coherentes; sin afirmar estado global parcial. |

Desde `khora-web`, los scripts observados de la candidata son: instalación por lockfile con `npm.cmd ci --no-audit --no-fund`; `npm run ui:contract`, `typecheck`, `ui-review:check`, `test:unit`, `build` y `e2e`. Verificar que siguen definidos y leer los workflows para reproducir los checks CI, UI Quality, khora-ok/gate y Khora Single Script Guard. No usar un `lint` que no existe/ya no es compatible como sustituto de otro check. Pruebas Playwright requieren configuración/fixtures del entorno aislado y nunca datos de producción como fixture. No inferir PASS de un código de salida capturado incorrectamente.

Checks sin runner/steps/logs (`BlobNotFound` incluido) son NOT_VERIFIED aunque el API acepte un reintento. Diagnosticar provisión/políticas/cuota con evidencia autorizada; no atribuir automáticamente el fallo al código, no fabricar checks ni deshabilitar protecciones. Un runner alternativo o sustitución de check requiere autorización explícita y evidencia equivalente; pruebas locales no levantan por sí solas branch protection.

Catálogo mínimo de bloqueos: `BLOCKED_AUTHORIZATION`, `BLOCKED_VERSION_BASELINE`, `BLOCKED_REPO_CONTRACT`, `BLOCKED_HOST_IDENTITY`, `BLOCKED_DESTINATION`, `BLOCKED_ADMIN`, `BLOCKED_DEFAULT_APP`, `BLOCKED_STORAGE_POLICY`, `BLOCKED_LICENSED_ASSET`, `BLOCKED_RUNTIME_COMPATIBILITY`, `BLOCKED_EDITORIAL_CRITERIA`, `BLOCKED_CI_EVIDENCE`, `BLOCKED_DEPLOY_QUOTA`, `BLOCKED_DECISION`. Error de hash, fuga de secreto o autorización rota es FAIL y detiene promoción. Registrar operación, síntoma exacto saneado, causa comprobada o desconocida, impacto, corrección, prueba causal y prevención antes de la siguiente cirugía. Repetir solo pruebas invalidadas y gate final; no guerras de sondas.

## 24. Runbook de publicación y reversión de extremo a extremo

### 24.1 Preparar una liberación, no desplegar en cada arranque

1. Adquirir baseline de cada repo y versión/alias activos; crear release_id y manifiesto privado/saneado según clasificación. Seleccionar perfil (§18); para terminación global EP-INTEGRAL.
2. Leer código de los localizadores de §19, comparar requisito→implementación→prueba y cerrar plan de cambios. Congelar decisiones autorizadas, políticas, activos, destino, versiones y orden de dependencias. Resolver todos los BLOCKED obligatorios antes de prometer publicación.
3. Preparar ramas/staging limpios; mantener baseline y respaldos verificables. Reutilizar componentes existentes; cualquier cambio de mapa/stack/perímetro, copy público, UX/UI o seguridad no revisado presencialmente queda bloqueado antes de construcción.
4. Implementar cambios y pruebas de §23; fijar commits, lockfiles, hashes de bootstrap/modelos/activos, manifiesto de integridad y plan de migración ensayado. El manifiesto de hashes no se incluye a sí mismo. No atribuir código de PR a main.
5. Ejecutar pruebas candidatas y matrices físicas del perfil, recuperar logs, revisar diff y obtener aprobaciones. `release_ready=true` solo si todas las pruebas prepublicación del perfil pasan, el ensayo R16 y R32-pre están completos, las revisiones requeridas están satisfechas y se ha probado reversión con esa candidata. R16 activo y R32-cierre quedan pendientes hasta después del deploy, no crean una compuerta circular.

`EP-IN-080` verifica que el runtime elegido y la producción autorizada corresponden. La regla histórica de desplegar main en cada instanciación queda subordinada a la gobernanza vigente de cuota/continuidad de Metodología: si el deployment activo ya sirve el SHA requerido, verificarlo y reutilizarlo; no crear otro. Si el cambio necesita publicación, se hace una vez mediante este runbook autorizado. Cuota agotada permite preparación/pruebas locales, no declarar producción nueva, publicar WIP, cambiar de cuenta/proyecto/alias ni simular el check. La excepción por cuota nunca quita autenticación/cifrado.

### 24.2 Promover el candidato exacto

6. Reconsultar main, PRs, checks, revisiones y candidato. Integrar PRs individualmente en orden de dependencia. Registrar SHA integrado de cada repo; si el merge/conflicto cambia el árbol probado, ejecutar pruebas afectadas y comprobar equivalencia del artefacto antes de promoción. No merge automático de #292/#294 por aparecer aquí.
7. Calcular versiones por política real y escribirlas en sus archivos propietarios junto con narrativa causal; actualizar manifiestos/fuentes generadas y comprobar enlaces subordinados. La versión documental no obliga a subir la Metodología global o SI como si fueran el producto; si el cambio afecta su política, se actualizan con autorización y coherencia en su propio flujo.
8. Construir un artefacto de producción reproducible desde el SHA integrado limpio de main, nunca desde ep-wip. Registrar SHA, lockfile, versión, ID/hash de build y destino. Usar el mecanismo Vercel/proveedor ya configurado; credenciales solo por canal privado, no argumentos/logs. Revalidar cuota, project ID, equipo, root directory y alias antes de escribir.
9. Aplicar cambios de esquema compatibles en el entorno autorizado con backup/restore ya ensayados y migraciones cuyos hashes coinciden. Una columna/tabla aditiva compatible puede preceder al deploy; una migración destructiva o incompatible exige decisión y plan específico, no se ejecuta por este runbook genérico. Verificar esquema y registrar read-back sin filas sensibles.
10. Desplegar/promover el artefacto fijado. No reintentar ciegamente si el proveedor devuelve estado ambiguo: recuperar deployment ID y comparar su SHA antes de otra creación. Mantener la versión activa anterior hasta readiness del destino; no publicar un artefacto distinto para ahorrar tiempo.
11. Verificar alias canónico y procedencia mediante `ep-main-live.json` existente y metadata autenticada del proveedor: SHA exacto, rama main, ID de build/deployment y versión coherentes. El archivo de procedencia público solo expone metadatos no sensibles; no abrir rutas de usuario para comprobarlo. READY sin alias/read-back no pasa R16.
12. Ejecutar pruebas positivas/negativas contra destino activo. Usar cuenta/credenciales de prueba y sesiones aisladas autorizadas; rotar/revocar credenciales productivas solo dentro de una ventana aprobada y con reemplazo/verificación disponibles, nunca como experimento destructivo. No publicar plaintext en capturas, logs de red o reportes. Cubrir: puerta EP/OIDC, scope/expiración/revocación, bóveda/consumo/rotación, comando/hash, arranque frío Windows PowerShell 5.1, limpieza y matriz del perfil. Confirmar que el launcher obtiene la misma fuente/runtime certificados, no HEAD móvil distinto. Un fallo pospublicación dispara §24.3.
13. Registrar PUBLICADO VERIFICADO solo tras R16/R32 y todos los gates obligatorios del perfil. Publicar evidencia saneada, etiquetas/versiones según política, commit y referencia de artefacto. Leer de vuelta los registros, mantener respaldo anterior durante la ventana aprobada y cerrar excepciones. Si el perfil es mínimo/fundacional, `global_certified=false` y roadmap integral persiste.

### 24.3 Rollback por componente

| Fallo | Acción reversible y gate posterior |
|---|---|
| Candidata falla antes de integración | Conservar baseline activa y staging diagnóstico; corregir solo causa observada, invalidar pruebas afectadas. |
| Check/merge introduce árbol distinto | No desplegar; reconstruir/probar el nuevo SHA o revertir commit autorizado sin force-push de main. |
| Deploy/alias incorrecto o pruebas activas fallan | Restaurar/promover deployment anterior identificado y compatible; verificar alias/SHA, OIDC y consumo autorizado; marcar candidata FAIL. |
| Migración incompatible | Detener promoción, retirar acceso afectado; restauración aislada/backup conforme al plan aprobado. No bajar esquema ni borrar tablas automáticamente. |
| Rotación raíz/PAT/verificador falla | Mantener endpoints afectados cerrados; reconfigurar por canal autorizado, revocar credenciales expuestas y verificar nuevas. No recuperar servicio con secretos viejos inseguros. |
| Promoción de WP/runtime/export falla | Conservar original; revertir puntero/promoción al respaldo íntegro; comprobar funcionalidad/hash y datos. No sobrescribir modificaciones posteriores a la baseline. |
| Caída o cierre de sesión | Rehidratar desde último checkpoint válido y nueva autenticación; registrar pérdida. Confidencialidad/cierre de emergencia según §20.4. |

El responsable operativo registra trigger, hora, artefacto anterior/nuevo, identidad, pasos ejecutados y resultado. Un rollback fallido es incidente abierto, no cierre exitoso. Reversión de aplicación y de datos son distintas: conservar una migración aditiva compatible suele ser más seguro que borrarla; decidirlo según el ensayo real, no una promesa genérica de reversibilidad.

## 25. Manifiesto de ejecución, evidencia y reanudación

### 25.1 Estructura obligatoria sin secretos

El ejecutor materializa el registro en el almacén autorizado existente; esta tabla es su contrato de campos, no una plantilla con valores ficticios. Campos obligatorios no observados permanecen `null` con BLOCKED/NOT_VERIFIED y no pasan readiness. No completar con cadenas de ejemplo.

| Grupo | Campos y validación |
|---|---|
| Identidad de release | `schema="ep-release/v1"`, release_id único, revisión entera creciente, fecha UTC, perfil enum, objetivo, responsable y referencia a autorización. |
| Gobierno | H1/H2 coincidentes, canon_commit/blob/versión, SI/Metodología versión/nombre/blob, restricciones vigentes y diferencias resueltas. |
| Baseline/candidata | Por repo: origin validado, base SHA, candidate/integrated SHA (40 hex), rama, versión anterior/objetivo, cambios, hashes y PR/checks. |
| Entorno | Terminal, fuente de identidad, host/fingerprint, Windows/PowerShell, identidad efectiva, árbol permitido, privilegios, RDC/reinicio permitido y clasificación EP. Datos sensibles solo privados. |
| Configuración | Nombres/referencias privadas/estado, nunca valores; OIDC, raíz, bóveda, API audience y destino/project/alias observados. |
| Políticas/activos | Mapa artefacto→almacén autorizado; retención, checkpoint interval, pérdida/tiempo admisibles aprobados; runtimes/licencias/hashes y lock IA si perfil integral. |
| Migraciones/rollback | SQL hashes, esquema antes/después, backup ID/hash privado, resultados ensayo, deployment/artefacto anterior y responsable/triggers. |
| Pruebas | Por R01–R32 aplicable: status enum, commit/host/artefacto, comando/acción saneada, exit code, expected/observed, log/evidence ref/hash y hora UTC. |
| Publicación | Artefacto/build/deployment IDs, SHA integrado, alias observado, prueba procedencia y resultados activos; no URL con secretos. |
| Continuidad | Checkpoint remoto de este registro, hash/revisión leídos de vuelta, último paso confirmado, siguiente paso atómico, gates pendientes y eventos abiertos. |
| Conclusión | release_ready, published_verified, global_certified booleanos derivados; estado PASS/BLOCKED/FAIL, limitaciones, no inferidos del texto. |

Invariantes: `release_ready` solo con gates prepublicación y ensayos aplicables PASS según §23; `published_verified` requiere también R16 activo y R32-cierre de §24, no mero ready; `global_certified` solo perfil EP-INTEGRAL y R01–R32 completos. Un documento publicado con especificaciones no cumple ninguno de estos booleanos de producto por ese hecho.

Máquina de estados: ADQUIRIDO → PLAN_VALIDADO → CANDIDATO → READY_PREPUBLICACIÓN → PROMOVIDO → PUBLICADO_VERIFICADO → CERRADO. Cualquier fase admite BLOCKED/FAIL con checkpoint y retorno controlado; PROMOVIDO no implica PUBLICADO_VERIFICADO. Una modificación del árbol o contrato invalida READY y sus pruebas afectadas. La transición CERRADO integral requiere además `global_certified=true`; un cierre parcial conserva `global_certified=false`.

### 25.2 Eventos e integridad de estado

Cada evento JSON Lines lleva timestamp UTC, run_id/release_id, terminal_id (privado donde aplique), stage, status, duration_ms medida, exit_code real, evidence_ref/hash, versiones/SHAs, error_code, resumen saneado y siguiente acción. Distinguir cero, no disponible, incompatible y obsoleto; no poner cero para una medición ausente. Aplicar límites/redacción de §20 al ledger existente.

Reanudar desde el último checkpoint remoto confirmado, no de la última frase de chat. Leer manifiesto, comparar revisión/hash y commits/destinos con estado vivo. START sin terminal se reconcilia por observación antes de repetir una operación; un deploy o migración ambiguos no se repiten ciegamente. Escritura con control de concurrencia: blob/revisión esperados, staging, write, read-back y comparación; una colisión se fusiona o bloquea, nunca overwrite silencioso.

Datos públicos: requisitos, decisiones saneadas, commits/hashes, resultados y bloqueos sin identificadores personales. Datos privados: logs completos saneados según necesidad, backups, fuentes/medios/modelos licenciados, IDs sensibles y objetos. Secretos: solo canal/almacén autorizado. No usar un mismo destino público para las tres clases.

## 26. Procedencia y narrativa de esta revisión

**Antes:** v1.0.0 organizaba gobierno y riesgos, pero exigía fuentes externas, omitía el alcance mínimo ya acordado y requisitos fundacionales/visuales, y no tenía contrato concreto de publicación/rollback.

**Cambio:** v1.1.0 consolida perfiles, localizadores, autorización por principal, parámetros del volumen y launcher, fundación, WordPress seguro, persistencia/IA/TEST 01, matriz R01–R32, manifiesto y runbook de promoción/reversión. Reconciliación explícita de Cora→Khora, secreto UI→launcher, DPAPI→rehidratación y despliegue por arranque→gobernanza de cuota.

**Motivo:** permitir que un ejecutor autorizado use un solo contrato técnico sin adivinar pasos ni certificar una entrega parcial como sistema completo.

**Resultado documental:** contratos y compuertas definidos; la publicación de esta edición no acredita construcción, autorización de decisiones pendientes, migración productiva, CI verde ni ejecución física. No se garantiza que una infraestructura incompleta permita cerrar EP-INTEGRAL en un único ciclo sin bloqueos.

Fuentes utilizadas para consolidar, no requisitos de lectura para ejecutar:
- Metodología/canon/SI/antecedentes: `SeryMente/metodologia` commit `bbaf41800c1300b25621a12411e5dc9f60418dcc`; SI blob `151333921ca3214c0adee3996cc80d5f23adb2d5`; canon anterior blob `b879a0c210edbcaf8d3c6db969fbac32c8f2e908`.
- Antecedente ampliado: `ANEXO-EP-ARRANQUE-CYBERNET-WP-LAB-OGP-IA-20261009.md`, en especial §4–§10, entrada visual §14, fundación §16, contrato bóveda §20 y mínimo §22.
- Arquitectura/integración de Khora recuperadas en commit `dbc73afada1ad29abf46f4599d22cc3158a9a986`; arquitectura blob `382e4a929a984a96926fd6f9080f80bedd109a0b`; integración WP blob `222b8a715df40ec1a2c6b9696b9fe8cfb1390bac`.
- Código candidato inspeccionado de PR #292: `6738c1f1aeffe5835a725531e0774d4420af13c5`; bóveda blob `db71cce59849540533069cae6466fbae5b1b8ed4`, master-password `6e8025df4d0a3691128c39f1772915052e6f7089`, ruta consumo `2e027dee5640342721e043de22f3d1f35cd5c005`, package `17e8c7ceb7c2dbfa7aa7a855de85ba820691ce53`. Inspección de código no equivale a pruebas ejecutadas.

Conservar anexos/evidencia histórica sin borrarlos ni reetiquetarlos como pruebas nuevas. La reconciliación de referencias y de las pretensiones de autoridad en otros repositorios forma parte del plan de publicación, no se afirma realizada por editar este archivo.

## 27. Gate de suficiencia y cierre honesto

Antes de declarar que este canon habilita una liberación concreta en un ciclo, verificar:
1. Un lector identifica perfil, baseline, versión objetivo, responsable y destino sin una conversación previa.
2. Cada requisito tiene implementación existente o cambio planificado, prueba falsable, autorización y rollback.
3. Recursos materiales, retención/recuperación, licencias, atestación/rúbrica y secretos requeridos están resueltos por evidencia/autorización, no inferencia.
4. No quedan decisiones críticas ni contradicciones entre este contrato, gobierno superior y candidata; nombres/rutas/roles son unívocos.
5. CI/Windows/host real y logs están disponibles; los gates no se sustituyen por estática o evidencia anterior.
6. El procedimiento llega a alias/versión activos, prueba real pospublicación y recuperación, no termina en un commit.
7. El registro permite reanudar sin repetir operaciones ambiguas ni perder integridad; la verificación de escritura es literal.
8. El estado final distingue revisión documental, publicación parcial, publicación integral y certificación global.

Si falta cualquiera de estas condiciones, el dictamen de la liberación es **BLOQUEADA POR PRECONDICIÓN IDENTIFICADA**, aunque el canon haya sido mejorado y publicado. «Perfecto», «completo» o «un solo ciclo» nunca se usan para ocultar una dependencia material, una decisión no autorizada o una prueba no ejecutada.
