# Entorno Persistente — revisión conjunta A/B/local/C

**Estado:** propuesta técnica para revisión específica, no aplicada ni compilada. Adjunto temporal de esta entrega; no sustituye `frentes/ep/OEP.md`, no es otro objeto de estado ni otro validador.

**Complemento autorizado de esta entrega:** se preservó el original íntegro y se añadieron únicamente §3.5–§3.6, §4.4 y §6.1–§6.3 para completar los cuatro puntos solicitados. El inventario B/local y el contraste C no se reconstruyeron ni se consideran aprobados. El original tiene SHA-256 `5150c751848a11dd11346196d38e33acb3a254a3e7d0e96ec64daadd3914dd01` y fue vuelto a adjuntar sin cambio de bytes.

## 1. Objetivo y bases observadas

Cerrar la preparación integral de Entorno Persistente, incluida Khora local hermana de la web, continuidad de contenido y recuperación/cierre seguros. Vercel solo puede ser la única transacción diferida después de satisfacer todas las demás compuertas.

- Fuente viva: `SeryMente/metodologia`, rama `docs/metacanon-objetos-20261011`, commit `8ae0a831312d3dd74dfa0e9e5e266233e1e40555`; `frentes/ep/OEP.md` v0.3.5 / VCU-EP-v7, blob `8ef7cfdcad3d4a5835628f7ae7587f59417d3abc`.
- Metacanon: 1.4 / METACANON-OBJETOS-v1.4, blob `61bc98e0b3f5e149274238a5f6df39a8a4aba539`. Se adquiere gobierno; no se trabaja en construir el método.
- Gobierno superior: H1 = H2 = `6e0a416025594916016a34ae32e2b7e8af591320`; Sistema de Instrucciones v1.6.21, “Ordenamiento por Preponderancia y Categorías”, blob `151333921ca3214c0adee3996cc80d5f23adb2d5`. Metodología v0.14.14 y Bootstrap recuperados en ese snapshot.
- Contrato transversal: `CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md` v1.4.0, blob `0a27fa91c611499304ae994d52e9bf26dec4b01f`. Se usa esta ruta de GitHub; el enlace convertido en dominio del mensaje no es su fuente.
- Implementación principal: `SeryMente/khora`, `main` = `dbc73afada1ad29abf46f4599d22cc3158a9a986`.
- Base de inspección de las propuestas: cabecera de #292 = `6738c1f1aeffe5835a725531e0774d4420af13c5`. Solicitud abierta, borrador, no fusionada, `mergeable_state=dirty`.
- No hay árbol integrado exacto ni overlay recuperado que pueda acreditarse como candidata. Las referencias de validador e investigaciones anteriores se conservan; no se recertificó su cabecera ni se trasladaron sus pruebas.

Fuentes: [OEP exacto](https://github.com/SeryMente/metodologia/blob/8ae0a831312d3dd74dfa0e9e5e266233e1e40555/frentes/ep/OEP.md), [metacanon exacto](https://github.com/SeryMente/metodologia/blob/8ae0a831312d3dd74dfa0e9e5e266233e1e40555/METACANON-OBJETOS-CANONICOS.md), [canon transversal](https://github.com/SeryMente/metodologia/blob/6e0a416025594916016a34ae32e2b7e8af591320/CANON-ENTORNO-PERSISTENTE-Y-LABORATORIOS.md), [solicitud #292](https://github.com/SeryMente/khora/pull/292).

El delta respecto de la conversación adjunta es de gobierno y recepción: se pasa de metacanon 1.2/OEP v0.3.3 a 1.4/v0.3.5, se conserva la propuesta recibida y se restringe el siguiente trabajo a cobertura B/local y procedencia/política/carreras C. Ninguna recepción constituye aprobación.

## 2. A — conservar la propuesta sin repetir investigación

**Base:** #292, revisión exacta anterior. **Recomendación:** mantener el diff ya recibido: pathname `/api/ep` exacto y sensible a mayúsculas; no normalizar barras finales; validación completa de credenciales, query, fragmento y esquema; `apiBase` idéntica a audiencia firmada; respuesta PAT con `purpose="ep-bootstrap"` y `sessionId` idéntico al `sid` verificado.

**Componentes:** `scripts/khora/khora.ps1`, sus validaciones `Assert-KhoraBootstrapInputs`/`Get-KhoraGitHubToken`, y `khora-web/lib/server/ep.ts::canonicalOrigin`. Preservar firma, emisor, sujeto, sesión, expiración, scopes y revocación del servidor. Decodificar un token en PowerShell no autentica.

**Consecuencia:** dejan de aceptarse silenciosamente barra final, capitalización distinta o respuesta PAT de otra sesión. No es bypass de autenticación.

**Aceptación preservada:** destino exacto positivo; variantes negativas; audiencia/firma/scopes/sesión incorrectos rechazados; `purpose`/`sessionId` incoherentes rechazados; fuente embebida y gate final byte-equivalentes. No se ejecutaron nuevamente esos casos.

**Decisión material A:** aprobar este cambio concreto de seguridad, separado del transporte y principal local de B. Sin despliegue, almacenamiento ni secretos reales.

## 3. B/local — inventario finito y frontera de permisos

### 3.1 Alcance de este inventario

Inventario de las familias de contenido que deben decidirse para la hermana local, apoyado en rutas y servicios recuperados de #292. No se confunde con un catálogo completo de todos los métodos de todos los repositorios.

La búsqueda del índice principal devolvió 78 archivos `route.ts`, sin truncación; se contrastó el delta de rutas de #292, que añade/modifica el plano EP. El índice sirve como localizador, no como prueba del comportamiento de cada ruta. Las decisiones siguientes se apoyan en lectura directa de los componentes citados. Una ruta o método fuera de la lista de concesiones queda denegado al principal local, aunque exista en el índice.

**Modos propuestos, aún no aprobados:**

- **Lectura confirmada:** contenido autorizado leído remotamente y cacheado dentro del perímetro cifrado, con revisión/hash y fecha de confirmación. Offline es copia conocida, no frescura remota.
- **Borrador pendiente:** captura/edición local cifrada; no modifica la autoridad remota, no cuenta como confirmación ni como aprobación.
- **Acción conectada explícita:** tras reconexión, identidad vigente, revisión base y gesto del operador cuando exista ratificación. No reproducir automáticamente decisiones humanas acumuladas offline.
- **Denegación:** secretos, administración, delegación de permisos y automatización productiva no pertenecen a la concesión local de contenido.

| Familia de operación existente | Rutas/componentes | Conectado, con concesión específica | Desconectado y recuperación | Conflicto, idempotencia y confirmación requeridos |
|---|---|---|---|---|
| Leer inventario, texto, versiones y estado de revisión | `GET /api/volcado`, `/api/volcado/[id]`, `/api/revision/[id]`; `volcados.ts`, `correcciones.ts`, `pipeline.ts` | Lectura limitada a recursos concedidos, no acceso global por estar en loopback | Última copia confirmada; conservar revisión/fecha; sin datos cacheados no fingir disponibilidad | Comprobar terna y hash; autorización por objeto antes de descifrar; GET puede llamar helpers DDL hoy: no ejecutarlo contra producción durante este ensayo |
| Guardar/recover checkpoint de dictado | `POST/GET /api/dictado/checkpoint` | Revisión esperada, dueño y receipt | Diario local de captura pendiente; recuperar desde último checkpoint remoto confirmado | Hoy el UPSERT por `sessionId` puede sobrescribir; rechazar otro dueño y base obsoleta; read-back de texto/hash |
| Archivar texto nuevo | `POST /api/volcado`; `archivarVolcado` | Una operación lógica crea un solo ID/folio | Borrador nuevo con operation ID estable; archivado remoto al reconectar | Hoy usa UUID nuevo por llamada: receipt durable antes de responder evita segundo volcado ante respuesta perdida |
| Capturar y cargar partes de audio | `POST /api/audio`; `registrarParteAudio` | Custodia de sujeto/sesión/índice/bytes/hash, lectura y vínculo | Bytes originales cifrados y pendientes; no etiquetar verificado remoto | Reusar control existente de mismo índice/huella; además deduplicar objeto Blob y resultado: sufijo aleatorio actual puede crear otra copia |
| Importar archivo de audio | `POST /api/audio/importar/token`, `/api/audio/importar/procesar`; `importedAudio.ts` | Ticket acotado, sesión/dueño, tamaño/formato, descifrado/verificación y vínculo | Archivo local cifrado pendiente; no subir ni procesar sin recurso autorizado | Reintento ligado al mismo operation ID y hash; no borrar staging antes de verificar objeto final y vínculo; no entregar credencial global Blob |
| Sellar/archivar sesión de dictado | `POST /api/dictado`; `guardarDictadoConSesion` | Conservar el lock de sesión y contraste de manifiesto | Captura pendiente, dependiente de todas las partes confirmadas | Existe control de mismo `sessionId`/texto/manifiesto: reutilizarlo; preservar conflicto si difieren. El camino sin sesión no tiene esa misma deduplicación |
| Transcribir audio | `POST /api/transcribir`; `transcribir.ts` | Proveedor/configuración autorizados; guardar resultado bajo operación y huella de entrada | Audio pendiente; no generar una transcripción ficticia ni sustituir proveedor | Reintento no debe repetir efecto/coste sin política; resultado completo/parcial/fallido distinguido; archivado es otra operación |
| Pulir texto | `POST /api/pulir`; `pulido.ts::pulir` | Llamada autorizada y guardián léxico existente | Editar borrador manual; pulido remoto no disponible | El resultado por sí solo no es versión persistida; receipt de resultado y revisión de entrada, sin overwrite automático |
| Generar/asignar título | `POST /api/dictado-archivo/titulo`; `titulos.ts` | Asignación condicionada al recurso/revisión | Título provisional local, no confirmación remota | Hoy ruta puede escribir título; comparar revisión y receipt; no repetir generación ante pérdida de respuesta |
| Guardar edición manual | `POST /api/edicion`; `guardarEdicion`/`crearVersion` | Edición compare-and-set sobre revisión base; nueva versión/auditoría en una transacción | Edición pendiente conserva base y ambas ramas si la web cambió | Hoy no exige base cliente y MAX(version)+1 no está protegido por un lock único de la operación; añadir lock, base y receipt, no “último escritor gana” |
| Proponer segmentación | `POST /api/segmentar/[id]`; `segmentarEnParrafos` | Derivado sobre terna exacta; conservar guardián de caracteres | Borrador de estructura, sin nueva propuesta remota falsa | No guardar resultado tardío sobre otra versión; receipt devuelve derivado ya creado |
| Ratificar estructura | `POST /api/segmentar/[id]/ratificar`; `ratificarEstructura` | Acto humano explícito sobre propuesta vigente | Guardar intención/borrador no equivale a ratificación; repetir revisión tras reconectar | Comparar versión/hash del derivado; operación repetida no cambia timestamp ni ratifica otra propuesta |
| Generar propuestas/hallazgos | `POST /api/revision/[id]/propuestas`; `generarYPersistirPropuestas`, `generarYPersistirHallazgos` | Resultado derivado ligado a terna; llamadas remotas solo con recurso autorizado | Reglas puras pueden preparar borrador, sin afirmar persistencia ni componente remoto disponible | Hallazgos tienen fingerprint; propuestas usan IDs aleatorios. Un receipt por generación evita duplicar corridas al reintentar |
| Aplicar lote de propuestas | `POST /api/revision/[id]/propuestas/aplicar`; `aplicarPropuestasCorreccion` | Gesto explícito, terna/span/solapamientos, actualización/versionado transaccionales | Selección pendiente, revalidada después; no autoaplicar al volver red | Preservar guardianes actuales y añadir lock/receipt; hoy varias escrituras del servicio no forman una única transacción |
| Resolver hallazgo | `POST /api/revision/[id]/hallazgos/[hId]/resolver` | Aceptar/rechazar explícitos; objeto, versión y offsets actuales | Intención pendiente; no declarar resuelto remotamente | Reutilizar locks presentes; mismo operation ID devuelve resolución anterior en vez de aplicar dos veces o responder falso conflicto |
| Resolver incidente | `POST /api/revision/[id]/incidentes/[incId]/resolver` | Evidencia/objeto autorizados, decisión explícita | No declarar recuperado sin lectura real de bytes/hash | Preservar pertenencia; `audio_recuperado` no se acredita únicamente por URL o bytes declarados; receipt y lectura real de recuperación |
| Iniciar/reabrir/aprobar revisión | `POST /api/revision/[id]/iniciar`, `/reabrir`, `/aprobar`; también `POST /api/revision/[id]` | Cambio de estado explícito y condicionado; aprobación por compuerta vigente | No reproducir aprobación antigua; revisión humana conectada | Hay dos rutas de aprobación: llevarlas al mismo servicio/gate. El POST directo hoy escribe aprobación sin invocar la compuerta de `/aprobar` |
| Generar/leer fragmentos anclados | `POST /api/fragmentos/generar`; `fragmentos.ts` | Derivado ligado a terna y cobertura exacta | Borrador determinista posible; no afirmar corrida remota persistida | ID determinista con INSERT simple hoy puede fallar en repetición; receipt del run, sin sobrescribir fragmento diferente ni crear sello nuevo para el mismo retry |
| Ingerir y consultar resultados/grafo/chat | `POST /api/ingesta`, `POST /api/chat`; `pipeline.ts`, rutas indexadas de consulta/grafo | Revisión aprobada, servicios vigentes y autorización propia; no sustituir credenciales por identidad local | Última proyección confirmada; ingesta/chat remotos no disponibles; borrador no se llama ingerido | Reusar terna y comprobaciones de concurrencia existentes; confirmar Kernel y grafo reales, no solo HTTP/`io_id`; resultado con efectos remotos se reconcilia antes de reintentar |
| Administrar seguridad, tokens, bóveda, automatización y plano de gobierno | Rutas EP administrativas, OAuth/MCP, Jules, board/orchestrator, security, norm-check y observaciones | No concedido por identidad local de contenido; conservar autenticación propia | No disponible ni encolado como mutación de contenido | Denegación por defecto; una futura concesión requiere decisión aparte. Observabilidad derivada no se convierte en otra fuente de contenido |

El espejo Notion de `/api/dictado` es secundario y posterior al archivado: un retry del archivado no debe programar de nuevo el espejo como si fuera una creación distinta. Su éxito tampoco sustituye la fuente DB.

### 3.2 Recomendación única B/local

**Misma aplicación, artefacto y contratos; autoridad remota existente; estado local efímero cifrado; concesión de contenido explícita e independiente de la cookie maestra EP.**

La hermana local ejecuta el mismo `khora-web`, identificado por commit, artefacto/hash y versión de contratos. No crea otro launcher ni base autoritativa. El contenido conectado se lee/escribe mediante la autoridad existente; offline conserva únicamente snapshot confirmado y diario de operaciones/borradores dentro del volumen cifrado.

**Identidad propuesta para revisión:**

1. El servidor debe verificar una concesión previa de contenido, explícita y administrada por el principal autorizado mediante OpenID Connect; no se deriva automáticamente de poseer la llave de bóveda, contraseña maestra, token EP ni un proceso loopback.
2. El supervisor de la sesión EP presenta su identidad válida y prueba la concesión local vigente. Solo entonces recibe una capacidad de contenido acotada por sujeto, sesión, origen local exacto, revisión de contratos y operaciones.
3. Esa capacidad es distinta de la cookie maestra y de los scopes EP de bootstrap/PAT/logs. El navegador local no recibe claves DB, raíz criptográfica servidor, PAT ni credencial global Blob. Usa una sesión local aleatoria de 256 bits en cookie HttpOnly, SameSite estricto, ligada al supervisor; el servidor local conserva la capacidad remota solo en memoria/protección de sesión autorizada.
4. Escucha exclusivamente en loopback; puerto/origen de la sesión se fijan en el descriptor y se comprueban en peticiones. También validar Host/origen y bloquear peticiones de orígenes ajenos. No usar flags Playwright para iniciar la instancia.
5. Propuesta de lease offline: máximo 5 minutos desde última comprobación remota de concesión y sesión, limitada además por la expiración original. No renovar sin red. Tras vencer, bloquear lectura privada y edición hasta revalidar; preservar pendientes cifrados según la política de cierre. Este límite es una decisión de seguridad pendiente, no una política heredada.
6. Revocación remota se aplica inmediatamente en servidor; un host desconectado no puede conocerla instantáneamente. La ventana residual local queda limitada por el lease aprobado y por hombre muerto/presencia. Nunca prometer revocación offline instantánea.

**Entrada material aún necesaria:** aprobar el mecanismo y custodia de esa concesión previa. Ninguna concesión, cuenta, secreto, host o recurso existe por escribir esta propuesta. Si se necesita persistencia/configuración que no esté cubierta por el esquema actual, presentar su diff y obtener aprobación antes de crearla. No habilitar automáticamente un nuevo método POST en `/api/ep/workspace`: hoy ese GET solo materializa selección de repositorios, no contenido ni concesiones.

### 3.3 Diff funcional concreto de B/local

| Archivo/componente | Cambio propuesto respecto de la base inspeccionada |
|---|---|
| `13-session.ps1::Start-Sesion`, EP-IN-080 | Seleccionar perfil `prepare-only` del descriptor de candidata; verificar SHA/hash/contratos/entorno de ensayo; no importar `VERCEL_TOKEN`, no llamar `Deploy-Production`. No exigir que producción sirva ya la candidata |
| Importación de bóveda del supervisor | Aplicar lista de credenciales del perfil; excluir `VERCEL_TOKEN` también de importación posterior. Ningún secreto real se obtiene en esta revisión |
| `07-git-wip.ps1`, `16-oep-workspace.ps1` | Árbol aislado exacto, sin reset destructivo/checkout del workspace existente; recuperación por identidad de checkpoint, no fecha global. Sin push del ensayo que active publicación |
| `auth.ts`, `middleware.ts` y rutas de contenido concedidas | Mantener OpenID Connect remoto; añadir resolución explícita de principal local y validación servidor por operación/objeto. Sustituir `auth()` por resolver compartido solo donde la concesión revisada aplique; rutas administrativas y otras permanecen excluidas. No confiar únicamente en middleware, en una pestaña oculta o en una excepción `/api/ep/*` |
| `/api/edicion`, `correcciones.ts`, `propuestasCorreccion.ts`, `volcados.ts` | Entrada incluye operation ID y revisión esperada. Usar el mismo cliente SQL para lock, relectura de base, nueva versión, estado/auditoría y receipt. `crearVersion` admite cliente transaccional, no abre otra escritura independiente. Conflicto → 409 conservando ambas ramas |
| `/api/dictado/checkpoint` | Verificar dueño/session y base; UPSERT no cambia dueño ni pisa versión reciente. Receipt y checkpoint en misma transacción; read-back por identidad exacta, no únicamente “último” |
| `eventos.ts`, esquema 021 existente | Reutilizar `eventos_sistema.idempotency_key` único, `detalle`, referencias de recurso/version/hash y `eventos_outbox` donde aplique. Añadir camino estricto con cliente transaccional y contraste de request digest; no usar el actual “duplicate” sin comparar payload como garantía de contenido |
| Audio/importación/Blob | Receipt/etapas del mismo operation ID; objeto cifrado verificado y vínculo antes de confirmación. Ante upload exitoso/respuesta perdida, recuperar objeto de ese intento; no repetir a ciegas `put` con sufijo aleatorio. Compatibilidad exacta de escritura condicional/SDK se valida al construir, no se inventa |
| Segmentación, títulos, propuestas, hallazgos y fragmentos | Generación sobre base exacta; resultado tardío no se aplica a base cambiada. Receipt de corrida preserva IDs/sello de una repetición. Ratificación/aprobación requieren revalidación humana conectada |
| `POST /api/revision/[id]` y `/aprobar` | Delegar ambas entradas en servicio/gate único y mismo control de versión/hash/estado; no dejar ruta alternativa con aprobación más débil |
| `/api/dictado` y espejo | Reintento confirmado retorna el resultado previo; no repite efecto Notion. Efectos externos no se consideran atómicos con SQL: usar estado pendiente/confirmación/reconciliación del outbox existente, sin repetir efectos no idempotentes |
| `12-handoff.ps1`, `10-guardian.ps1`, `11-cleanup.ps1` | Checkpoint real leído de vuelta; server/perfil local y diario incorporados a cierre. Invalidar acceso, detener procesos propios, persistencia acotada, purga/bloqueo/desmontaje/limpieza y comprobación de residuos. Desarmar tarea solo si ya no queda residuo |
| `ep-medio-architectura.md`, `ep-integrity-manifest.sha256` | En el mismo cambio autorizado, reflejar prepare-only, local/grants/leases, autoridad de contenido, receipts/cierre y hashes reales. AGENTS/arquitectura histórica de publicación en cada arranque no conceden permiso de deploy |

**Contrato de sincronización a implementar solo después de revisión:**

- Identidad lógica de retry: sujeto autorizado + método/ruta canónica + operation ID. No depender del session ID nuevo para deduplicar una operación restaurada.
- Digest de solicitud canónica: cubre payload, base, tipo de operación y dependencias. Mismo ID/digest → mismo resultado; mismo ID/digest diferente → 409.
- Revisión base no es solo texto: comprende versión/hash, estado, aprobaciones y derivados/manifest pertinentes. Releer bajo lock; no inferir igualdad de títulos, incidentes o approvals porque el texto tenga el mismo hash.
- Receipt durable contiene digest y referencias, no plaintext privado ni secretos en telemetría. Consultarlo después de autenticar sujeto/recurso. Falta de receipt o fallo de escritura estricta no se transforma en éxito por timeout/outbox.
- Reutilizar schema 021 observado, no autorizar una migración nueva por comodidad. Presencia efectiva, permisos y retención del esquema son admisión pendiente. No borrar receipts que todavía hacen falta para recuperación/replay.
- Operaciones con Blob/Kernel/Notion no son una transacción distribuida: registrar intento/resultado parcial, releer el efecto externo y reconciliar antes de reintentar. Un timeout no demuestra que el proveedor no ejecutó.
- Orden de replay: partes verificadas → archivado → edición/derivados; aprobaciones e ingesta no se ejecutan automáticamente por reconectar.
- Confirmación: respuesta + lectura remota autorizada de recurso exacto + revisión/hash. “Pendiente”, “confirmado”, “conflicto” y “resultado externo incierto” son distintos.
- Recuperación: rehidratar snapshot/checkpoint remoto confirmado, verificar hashes/contratos, consultar receipts y restaurar únicamente pendientes realmente respaldados. No recuperar bytes que jamás salieron del volumen.

**Consecuencia:** offline no promete igualdad instantánea, procesamiento remoto, aprobaciones retroactivas ni durabilidad de todo borrador. Si esta frontera no satisface la medida seleccionada, el operador debe corregirla antes de construir; no declarar alcance integral satisfecho.

**Decisión material B/local:** aprobar principal/concesión previa y custodia, lista de operaciones, lease offline de 5 minutos, política de conflicto/replay/confirmación y pérdida permitida al cerrar. Aprobar también el reemplazo prepare-only de la publicación obligatoria en el arranque de ensayo. No habilita almacenamiento, cuentas, cifrado, secretos, migraciones ni publicación.

### 3.4 Aceptación B/local

Sobre la candidata exacta: dos instanciaciones finitas; cero uso de `VERCEL_TOKEN`, deploy/promoción/alias/dispatch productivo/reset/cambio de rama del trabajo existente. Misma revisión y contratos local/web; versión incompatible rechazada. Principal local positivo/negativo; cookie maestra no accede a contenido general; otro origen/sujeto/sesión/objeto y capacidad vencida rechazados.

Por cada operación concedida: respuesta perdida, dos solicitudes concurrentes, mismo ID con payload distinto, base web modificada mientras local está offline, reautenticación/reanudación y read-back. Un solo resultado lógico y cero overwrite silencioso. Para audio/servicios externos: interrupción entre upload, verificación, vínculo y respuesta; ninguna copia/efecto extra por retry; cuarentena/reconciliación sin borrar el único original.

Probar expiración offline, ausencia de red sin falsa confirmación, revocación conectada, cierre manual/muerte de supervisor/terminal/inactividad, detención del servidor y ausencia de procesos/config/cachés/residuos privados fuera del perímetro. Reinicio solo en host de ensayo autorizado conforme a perfil; nunca en equipo público por inferencia.

### 3.5 Correspondencia con ENTORNO PERSISTENTE INTEGRAL — no aprobar exclusiones

El inventario §3.1 clasifica operaciones de contenido de Khora; no es la lista completa de capacidades del frente. §61 del OEP y §18.2/§18.4/§28.7 del canon conservan el perfil integral. La ausencia de red o la denegación al principal local de contenido no elimina un requisito: distingue un recurso faltante, una autorización distinta y una capacidad pendiente de implementación.

| Capacidad necesaria del objetivo integral | Correspondencia con §3.1 y mecanismo existente | Dependencia real frente a reducción de alcance |
|---|---|---|
| Khora local hermana, misma revisión/contratos, acceso autorizado sin login web | Instancia de `khora-web`, descriptor/gate único, identidad §3.2 y lecturas/ediciones de §3.1 | Ejecutar UI/código local no exige publicar ni abrir un login web. La concesión previa propuesta exige autoridad de identidad: su uso/renovación conectado es dependencia del diseño, no permiso para omitir la hermana local |
| Captura, edición y continuidad de contenido | Texto/audio/checkpoint/versiones/derivados, fuente DB actual y diario cifrado propuesto | Capture/edición de borrador y reglas puras pueden trabajar localmente. La confirmación en DB/Blob remotos requiere red. Llamar “confirmado” al borrador o eliminar la captura offline sería una falsa equivalencia/reducción |
| Transcripción, pulido y generación editorial de Khora | Servicios `transcribir.ts`/`pulido.ts`, Groq y propuestas existentes | El código inspeccionado invoca Groq: esa llamada requiere red. No se aprueba suprimir la función ni cambiarla por otro proveedor/modelo. Si el objetivo del operador exige esa función también sin red, el mecanismo local faltante debe revisarse y construirse; no se declara esa capacidad resuelta por ponerla en cola |
| Kernel, ingesta y grafo | `/api/ingesta`, Kernel configurable —incluido default loopback—, PostgreSQL/Neo4j y proyecciones | No asumir que todo Kernel es remoto: puede ser proceso local. Certificar requiere verificar el runtime y sus almacenes efectivos. Una proyección cacheada no sustituye ingesta/consistencia del grafo. La disponibilidad offline de la cadena completa sigue sin demostrarse; no queda excluida por analogía con Groq |
| Workspace, código/perfil, repos y herramientas fundacionales | Gate/módulos Git, perfil `ep-state`, seis roles de repos/exportaciones, editor y asociaciones | Herramientas ya hidratadas pueden operar sin red; adquisición, push y confirmación remota requieren red. No excluir Notepad++, OBS/Chrome, observador, dos instanciaciones ni las verificaciones del perfil |
| WordPress local y WP-LAB | Studio y unidad recuperable DB/medios/config/tema/plugins/manifiesto, §21.3 | Runtime y edición del sitio local no dependen del login Khora ni de publicar web. Backups/restore desde destino remoto requieren red y activo/licencia autorizados. El estado de contenido Khora no es el backup de WordPress |
| Generación/edición visual local exigida | ComfyUI/Nunchaku/modelos, GPU/ubicación elegibles, TEST 01 y aceptación humana, §22.2–§22.3 | Con runtimes/modelos íntegros ya presentes, inferencia local no tiene una dependencia inherente del login web o de Groq. Descarga/restauración inicial sí puede requerir red. No usar la fila “servicios remotos no disponibles offline” de §3.1 para excluir esta capacidad local |
| Persistencia/recuperación integral | Git/perfil existente, ledger DB, Blob privado aprobado para clases previstas, manifiestos/checkpoints | El checkpoint durable externo requiere conectividad. La política D02 pierde su garantía si no se confirma a tiempo; se declara el incumplimiento sin borrar ni llamar duradero al estado local. No reemplazar restore remoto por copia local antigua |
| Seguridad, Guardian/hombre muerto y residuos | Volumen/junction/tarea/supervisor/limpieza, §20.4 y §4.4 de esta revisión | Bloqueo/detención/limpieza deben funcionar localmente aun sin red o con token revocado. Registro y persistencia remotos pueden estar bloqueados; eso no justifica éxito falso ni pérdida silenciosa |
| Administración, tokens y automatización | Plano de seguridad y rutas con autenticación propia, no concesión de contenido | Denegado a ese principal no significa retirado del producto. Sigue accesible a su principal autorizado y sujeto a sus gates. Nunca ampliar la cookie maestra ni conceder administración para conseguir paridad local |

La revisión no establece que “misma aplicación” implique automáticamente la misma capacidad efectiva en todo estado de conectividad. Debe demostrarse revisión/contratos/capacidades, y documentar qué operación está disponible, pendiente de recurso o bloqueada por autorización. Una indisponibilidad necesaria se explica; una exclusión de capacidad exigida requiere decisión material explícita y no satisface el objetivo original sin esa decisión.

**Decisión pendiente:** confirmar la suficiencia de la operación offline propuesta para el trabajo del operador —captura/edición/lectura de última copia confirmada, con operaciones dependientes de proveedores en estado pendiente—. No se presume que el operador haya aceptado suspender esas capacidades. Si requiere continuidad local más amplia o prolongada, la propuesta B debe corregirse antes de construcción, manteniendo el perfil integral.

### 3.6 Concesión local de cinco minutos — fundamento y consecuencias separados de checkpoints

**Cinco minutos NO es parámetro aprobado ni deriva de D02.** La política de checkpoint mide edad de trabajo no confirmado y restaurabilidad; la concesión mide cuánto tiempo puede usarse una autorización local sin volver a consultar revocación. Son relojes, eventos y objetivos distintos. El plazo de inactividad de Guardian y su heartbeat tampoco fijan esa concesión.

Fundamento de la hipótesis: acotar exposición de una capacidad local todavía utilizable tras revocación remota o pérdida de comunicación, sin exigir login web para cada acción. Con cinco minutos, la ventana residual offline sería como máximo el remanente de ese lease, no cinco minutos adicionales desde que se detecta la caída. **No hay datos de latencia, frecuencia de cortes, amenaza/uso del host ni tolerancia del operador que demuestren que el número cinco sea óptimo o aceptable.** Se mantiene solo como candidato de seguridad para decisión humana, no como recomendación cuantitativa validada.

Renovación propuesta: el supervisor solicita renovación antes del vencimiento, con margen derivado de latencia/timeouts medidos. La autoridad comprueba sesión EP vigente, concesión/revisión de permisos, sujeto y capacidad, y devuelve expiración autenticada. Renovar no emite por defecto otro token EP de arranque ni revoca la sesión por la regla de nueva emisión. No se extiende el plazo por un retry fallido, reloj local retrasado, copia de fichero, actividad de teclado o estar en loopback. No se solicita otro login web para cada renovación; si la concesión/identidad original ya no permite renovar, se requiere el mecanismo de reautorización aprobado.

Uso local: medir expiración con deadline local monotónico, limitado por expiración firmada y por vida de la sesión original; cambios de reloj no extienden acceso. Comprobar además la presencia/estado del supervisor por el mecanismo existente; una concesión vigente no desarma hombre muerto.

Sin red:
- detener de inmediato operaciones que necesiten autoridad/confirmación remota; no fingir persistencia;
- permitir únicamente las operaciones locales aprobadas mientras el lease restante siga vigente;
- al expirar, congelar operaciones privadas y ocultar/bloquear la superficie; conservar los pendientes ya materializados dentro del perímetro cifrado, sin simular que un búfer no escrito fue guardado;
- la pérdida de red por sí sola no ordena borrado/desmontaje ni equivale a abandono del operador. Guardian/cierre siguen sus propios disparadores y prioridad de confidencialidad;
- al reconectar, revalidar identidad/concesión antes de volver a exponer contenido y reconciliar pendientes por revisión/receipt; no ejecutar automáticamente ratificaciones.

Consecuencia para el operador: un corte de más de cinco minutos puede impedir incluso continuar lectura/edición privada local aunque siga presente. Esto puede ser incompatible con la continuidad que necesita. No se impone por defecto ni se llama “sin dependencia de login web” a una sesión que obliga a iniciar login al vencer. Al bloqueo se muestra estado legible de qué quedó local, qué fue confirmado y qué no puede recuperarse si posteriormente hay cierre de emergencia.

**Decisión exacta:** aprobar o corregir duración y conducta de bloqueo/renovación offline sobre este riesgo y esta carga de trabajo. Duración y método de concesión son decisiones separadas; no aprobar cinco minutos por coincidir con el checkpoint. Hasta recibirla no se programa timer, no se corta una sesión ni se modifica Guardian.

## 4. C — cookie, token de arranque y OpenID Connect separados

### 4.1 Comportamiento observado

`ep-master-session.ts` verifica firma, sujeto, origen y expiración de 15 minutos, pero su payload no contiene generación del verificador. `setEpMasterPassword` cambia sal/verificador y luego borra intentos con dos consultas independientes. La cookie anterior no consulta la sal vigente.

`createEpSessionToken` recibe únicamente email/origen/mode/repos; construye token antes de su transacción. Bajo advisory lock del usuario cuenta emisiones, revoca TODOS los tokens EP activos del usuario y supersede sesiones antes de insertar el token nuevo. `resolveEpUserEmail` reduce la procedencia OpenID Connect/maestra a una cadena, perdiendo esa distinción para emisión.

Schema 016 guarda hash de jti/sesión/usuario/expiración/revocación; schema 017 tiene sal/verificador. Ninguno contiene un discriminador de procedencia por token. No deducirlo de `updated_by`, fecha, nombre de sesión o email compartido.

### 4.2 Recomendación única

1. **Cookie maestra:** generación opaca derivada por HMAC de la sal vigente, con dominio separado de contraseña/cookie/PAT. Auth devuelve la generación de la fila efectivamente verificada; cookie firma esa generación. Cada autorización efectiva compara contra autoridad servidor vigente sin caché permisiva. Cookie sin generación o generación vieja se rechaza.
2. **Nueva emisión EP:** conservar revocación TOTAL de tokens EP anteriores del usuario, sea la procedencia OpenID Connect o maestra. No introducir selectividad.
3. **Rotación maestra — política propuesta, NO aprobada:** revocar también TODOS los tokens EP activos del usuario en la misma transacción de rotación. Es una elección nueva de seguridad: elimina la necesidad de seleccionar tokens por procedencia y de una migración para esa selección. No revoca la sesión general OpenID Connect, el PAT GitHub ni la raíz criptográfica.
4. **Procedencia de nuevas emisiones:** principal discriminado `{kind: oidc|ep-master, subject, masterGeneration?}` obtenido y verificado por servidor; claims firmadas de procedencia/generación en token EP. Mantener hash de jti y vínculo DB existente. No inferir procedencia de tokens viejos sin claims; corte de compatibilidad mediante revocación/reemisión revisada, no etiquetado retrospectivo.

### 4.3 Diff concreto por componente

| Componente | Cambio propuesto |
|---|---|
| `ep-master-password.ts::authenticateEpMasterPassword` | De string `accepted` a resultado discriminado accepted con generación; derivarla antes de limpiar sal, desde la fila que validó. Mantener coste scrypt y límites existentes |
| `ep-master-session.ts` | Añadir generación firmada; lector criptográfico devuelve principal/payload, no autorización final por sí sola. Crear cookie con generación retornada por autenticación, nunca con una lectura posterior independiente |
| `ep.ts::resolveEpUserEmail` | Mantener adaptador compatible donde haga falta; añadir resolución de principal con procedencia y validación de vigencia servidor. No convertir email cliente en tipo de autenticación |
| `POST /api/ep/master-auth` | Consumir resultado accepted/generación exacta; firma/origen/expiración conservados. Una carrera posterior de rotación deja cookie inválida, nunca promovida a generación nueva |
| `POST /api/ep/token`, `createEpSessionToken` | Recibir principal verificado; bajo mismo advisory lock `[subject]`, revalidar cookie/generación/vencimiento y permitido; contar, revocar todas anteriores, insertar sesión/token y commit. Firmar/devolver solo el payload de esa transacción |
| `setEpMasterPassword`, `PUT /api/ep/master-password` | Transacción con el mismo lock del usuario permitido; cambiar sal/verificador, limpiar intentos y, SOLO si la política es aprobada, revocar todos los tokens EP activos; commit antes de responder OK |
| `authenticateEpBearer` | Exigir claims coherentes en tokens nuevos y registry vigente. Tokens revocados rechazados cualquiera que sea su origen. Mantener firma/audiencia/scopes/sid y errores públicos |
| Middleware y panel Seguridad | Firma es prefiltrado; ningún dato/operación depende solo de una cookie verificada criptográficamente. Gate efectivo Node/server comprueba generación. No importar cliente PostgreSQL Node al middleware Edge |

**Orden de carrera emisión/rotación, mismo lock:**

- Si emisión maestra gana primero: revalida generación, crea token; rotación siguiente cambia sal y revoca ese token.
- Si rotación gana primero: la emisión con cookie vieja falla; no puede crear token vigente después de validar una generación antigua.
- Si emisión OpenID Connect ocurre después de rotación: sigue permitida por esa identidad; como toda nueva emisión, revoca todas las anteriores.
- Dos emisiones concurrentes: solo la última en el orden serial permanece vigente. Una respuesta entregada tarde puede contener token ya supersedido; el cliente debe verificar vigencia, no asumir que el último HTTP recibido es el token actual.
- Cookie autenticada antes pero entregada después de rotación contiene generación antigua y es inválida; jamás se recodifica con la sal nueva.
- Indisponibilidad de autoridad: no emite ni acepta identidad maestra. Fallo transaccional revierte contraseña/limpieza/revocación juntas.

No se promete cancelar retroactivamente una petición ya autorizada antes del commit de rotación. La revocación del registry debe revalidarse en operaciones críticas conforme al perímetro aprobado.

**Consecuencias materiales:** la rotación propuesta corta bootstrap, consumo PAT y bitácora de TODAS las sesiones EP activas, incluidas las emitidas por OpenID Connect. La sesión web OpenID Connect sigue viva. Guardian/cierre local deben limpiar aunque no puedan escribir el ledger con un token revocado; la pérdida de confirmación remota se registra como no verificada, sin excepción secreta ni ampliación automática de scopes.

La revocación de la sesión padre también afecta la continuidad conectada del principal local; su residuo offline queda limitado por el lease B aprobado. No confundir bloqueo de acceso con borrado físico o restauración.

**Decisión material C:** aprobar por separado (C1) generación/gate de cookies; (C2) rotación que revoca TODOS los tokens EP del usuario, con el efecto indicado sobre sesiones/cierre; (C3) procedencia firmada y corte de tokens antiguos. No se solicita revocación selectiva ni migración de procedencia. Ninguna rotación real ni migración se ejecuta ahora.

**Aceptación C:** cookie vieja rechazada/nueva aceptada; clave anterior rechazada; origen/expiración/firma mantenidos; carreras descritas; emisiones concurrentes; autoridad inaccesible; rollback ante fallo; token viejo EP rechazado por registry, emisión nueva revoca todos los anteriores, sesión general OpenID Connect no revocada. Probar cierre con token invalidado y comprobar residuos, no solo códigos HTTP.

### 4.4 Alcance de rotación y orden seguro — propuesta pendiente, sin pérdida silenciosa

**Alcance exacto de la propuesta C2:** usuario lógico configurado y permitido, no todas las cuentas ni todas las personas. En la implementación observada hay un verificador maestro singleton: cambiar su sal invalida toda cookie de la generación anterior de ese verificador. Para tokens EP, el predicado es `usuario=subject_autorizado`, `revocado_en IS NULL` y `expira_en>NOW()`: afecta todos los `sid` activos de ese usuario, no solamente la sesión del navegador que rotó, ni solamente tokens emitidos por contraseña maestra. No afecta otro `usuario`, la sesión general OpenID Connect, PAT GitHub, llave de bóveda, raíz criptográfica o contenido remoto confirmado. No etiquetar el dispositivo como eliminado ni la sesión como físicamente limpia porque el registry revoque un token.

La regla ya vigente de **nueva emisión** se conserva: revoca todas las anteriores de ese usuario bajo su lock, sin selectividad. **Añadir la misma revocación en rotación de contraseña es una política nueva y sigue pendiente.** La procedencia firmada propuesta no concede permiso para filtrar por origen ni para migrar tablas.

Hay dos situaciones que no se mezclan:

1. **Rotación ordinaria planificada con operador presente:** preflight de Guardian armado, perímetro protegido y capacidad de cierre; suspender nuevas mutaciones y finalizar/confirmar un checkpoint de los cambios que deban conservarse, con lectura de vuelta; registrar el estado de preparación mientras la identidad todavía es válida; solo después ejecutar la transacción de rotación autorizada. Si no puede confirmarse persistencia, no declarar que rotar conservará los pendientes ni aprobar automáticamente pérdida: bloquear la rotación ordinaria y presentar ese estado al operador. No introducir una espera ilimitada ni una gracia oculta de tokens.
2. **Revocación de emergencia por riesgo de credencial:** no se aplaza para salvar cambios. Transacción autorizada invalida cookie/tokens inmediatamente en la autoridad; el cierre local empieza cuando el supervisor/Guardian detecta pérdida verificable de autorización, y offline queda sujeto al lease revisado. No se promete notificación instantánea al host desconectado. Revocación no equivale a cierre terminado.

**Orden remoto/local a revisar y probar:**

- Autoridad servidor: mismo lock de usuario para emisión/rotación; sal/verificador, revocación y constancia duradera saneada se realizan en la transacción aplicable. La constancia solo dice revocación/solicitud de cierre y último checkpoint realmente confirmado; no falsifica `EP-OUT-100 OK` ni limpieza del host.
- Supervisor/Guardian: autenticar pérdida/revocación por el mecanismo aprobado; un error genérico de red no se convierte en prueba de rotación. Bloquear nuevas operaciones de la sesión e iniciar las etapas existentes de salida. No ampliar scopes ni crear token de contingencia por inferencia.
- Persistencia: en cierre ordinario confirmado, read-back precede a invalidación planificada. Tras revocación de emergencia no reutilizar el Bearer revocado para subir/loguear; solo usar otro canal si ya está expresamente autorizado. Exportar una copia cifrada local no equivale a respaldo remoto. No emitir automáticamente otra sesión EP para evadir la revocación.
- Bitácora: mientras esté disponible, START/OK/FAIL con las etapas actuales y confirmación real. Después de revocar, la constancia remota servidor acredita únicamente lo que hizo el servidor; el resultado físico sigue pendiente de comprobación independiente. Logs locales saneados permanecen protegidos mientras exista el volumen, no se promete que sobrevivan su eliminación.
- Limpieza: detener procesos propios → exportación/persistencia acotadas cuando estén autorizadas → purga de secretos → quitar junction propia → bloquear BitLocker → desmontar → eliminar contenedor propio → comprobar residuos → desarmar tarea únicamente si no quedan. Guardian no espera indefinidamente a subir. Conservar tarea armada si hay residuos.
- Pérdida: antes de cerrar ordinariamente, mostrar qué operaciones quedaron confirmadas y cuáles pendientes, desde el estado/receipts reales. En emergencia, declarar pérdida posible de los pendientes no persistidos y dejar en la evidencia durable el estado desconocido/último checkpoint comprobado cuando sea posible. Nunca convertir “cerrado seguro” en “todo guardado”; no asignar conteos inventados a datos perdidos.

**Pruebas adicionales de C2/B-cierre en matriz existente:** rotar desde otra sesión del mismo usuario; dos `sid` activos; otro usuario no alcanzado; caída de red antes del checkpoint/antes del commit/después del commit; muerte del supervisor durante salida; token revocado impide ledger/PAT pero Guardian limpia; comprobar último checkpoint recuperable, pendientes y residuos por separado. El caso “solo invalidar cookies” no cuenta como prueba de la política total propuesta.

**Decisión material adicional, inseparable del efecto de C2:** aprobar la rotación total y distinguir procedimiento ordinario con checkpoint previo de emergencia con revocación inmediata/pérdida posible; aprobar el orden de pérdida de acceso local y su relación con la concesión. Sin elección explícita no se rota, no se crea canal de cierre alternativo ni se rebaja recuperación.

## 5. Paquete causal y acceso remoto

Se listaron las carpetas canónicas `artefactos` y `evidencias`. Contienen entrega histórica v0.2.0 y su restaurador, e inventario documental; este último continúa marcando como NO RECUPERADOS el ZIP causal, `overlay-index.json`, recibo del validador y evidencia de rotación. No se descargó ni ejecutó el ZIP histórico, no se confundió con el causal.

Herramientas expuestas en este canal: Notion y GitHub; no hay herramientas de Remote Desktop Commander expuestas. El operador aún no ha entregado vínculo actual de sesión/host. No se importaron cuentas/dispositivos históricos, no hubo exploración ni reemparejamiento.

**Instrucción posterior vigente:** Remote Desktop Commander permanece deshabilitado por defecto para el constructor. Solo la asistencia decide y autoriza una operación específica con ahorro concreto; disponer de conexión no concede autorización general. El eventual pendiente útil es recuperar archivos causales identificados no accesibles en repo/sandbox. El ahorro sería evitar reenvío manual/reconstrucción de correcciones; no hay minutos medidos. Alcance mínimo, solo tras esa decisión: identidad/vínculo/ping, nombres pertinentes en ruta real autorizada, hashes/índice/recibos y copia a destino privado/protegido autorizado; cero ejecución del ZIP, instalaciones, cambios de volúmenes, secretos o procesos ajenos. No se utilizó RDC en esta continuación.

## 6. Aceptación integral y ruta crítica

| Requisito terminal | Viabilidad y estado en esta revisión |
|---|---|
| Gobierno/fuentes/baseline | Lecturas logradas y H1/H2 coincidentes. No equivalen al PASS completo R01/R02 ni aprobación de producto |
| A/B/local/C | Propuesta consolidada; revisión humana y construcción pendientes |
| Local mismo código/contratos/contenido | Diseño sobre aplicación existente; grants/lease/sync deben aprobarse y probarse |
| Paquete causal | Bloqueado por acceso actual al artefacto; identidad ZIP/hash/base no verificados |
| Candidata integrada/conflictos/manifiestos | Pendiente después de revisión y paquete; #292 sigue dirty. No se ejecutaron merges/checkouts |
| Cifrado/persistencia/restore/cierre | Host/recurso/credenciales autorizados no observados; pruebas Windows no ejecutadas |
| Fundación/WP-LAB/visual | Obligatorios en perfil integral; no inspeccionados de nuevo ni acreditados por esta revisión de B/C |
| Migraciones/rollback/CI | Esquemas leídos, ninguna migración ejecutada; ensayos, checks útiles y rollback de candidata pendientes |
| Matriz R01–R32/local-web | Conservada; no se inventan PASS por lecturas o pruebas históricas |
| Vercel | Fuera del alcance de ejecución. No es todavía el único pendiente |

Políticas aprobadas del canon: checkpoint/pérdida máxima de 5 minutos, recuperación máxima 60 minutos, 3 checkpoints y 7 respaldos diarios válidos con dependencias. Son objetivos a medir; esta revisión no demuestra que el destino privado exista, tenga cuota/capacidad ni cumpla restauración.

Ruta crítica de aceptación: revisiones materiales y recursos de las partes afectadas → candidata integrada exacta/manifiestos → pruebas causales/regresiones/migraciones/rollback y ensayos integrales aplicables → revisión/aceptación y read-back final. La recuperación del paquete causal bloquea su incorporación/cotejo, no las preparaciones independientes desde código disponible. Almacenamiento, fundación, WordPress y visual tienen sus propios recursos/compuertas; pueden prepararse sin esperar el ZIP donde no consuman sus correcciones, pero no recibir PASS por esa independencia. Dos instanciaciones/local-web/cierre se ensayan sobre candidata exacta y host autorizado. No sumar como secuenciales partes realmente paralelas ni rebajar el perfil integral.

**Pronóstico:** esta revisión concreta se entrega ahora. El siguiente hito es la decisión humana específica y recuperación del paquete causal; esperas sin plazo, sin duración inventada. El cierre integral no es estimable con fundamento hasta disponer del paquete, recurso/host y decisiones de identidad/offline. No hay muestras actuales de ensayos para derivar tiempos. Cada incidencia nueva solo invalida pruebas de archivos/supuestos afectados más el gate final.

**Persistencia:** no se modificó OEP, prompts ni repositorios. Este archivo es una propuesta temporal entregada en el chat. No se incrementan sellos por un adjunto ni se atribuye su persistencia al recibo anterior. Escritura documental futura: autorización y privacidad/integraciones comprobadas, HEAD/blob reread, fusión mínima sin pisar a Claudia, prompts sincronizados y lectura de vuelta.

**Checkpoint exacto:** revisión sobre #292 `6738c1f1aeffe5835a725531e0774d4420af13c5` y main `dbc73afada1ad29abf46f4599d22cc3158a9a986`; OEP `8ae0a831312d3dd74dfa0e9e5e266233e1e40555`, blob `8ef7cfdcad3d4a5835628f7ae7587f59417d3abc`. Reanudar por decisiones A, B/local y C1/C2/C3 y por paquete causal, sin recapitulación ni auditoría general.

### 6.1 Requisitos restantes sobre la matriz existente — no otro plan/validador

Estas son anotaciones de admisión/ejecución de R01–R32 del canon, no renumeración ni nueva matriz normativa. Se conserva además el contrato local-web explícito.

| Filas existentes | Requisito aún necesario y dependencia | Trabajo independiente autorizado/evidencia aprovechable |
|---|---|---|
| R01–R02 | Fuente/baseline/versionado del producto y autorizaciones precisas | Esta continuación reconfirmó ramas OEP/main Khora, SI por H1→SI@H1→H2 y su blob. Sirve como lectura de gobierno, no aprobación de seguridad ni versión final del producto |
| R03–R08 | A/C aprobados; cookie/token/PAT/launcher íntegros y pruebas negativas reales | Conservar propuesta y código fijado. Se pueden preparar entradas exactas del ensayo; no implementar mecanismos nuevos ni acreditar casos históricos sin cotejo |
| R09–R12 | PowerShell/host/identidad/destino/BitLocker/junction/tarea/repos válidos | Preflights de solo lectura/contratos desde repositorio no dependen del ZIP. Ejecución física requiere host y permisos actuales, no sandbox Linux como sustituto |
| R13–R15 | Esquema aislado, instalación por lock, compilación/suites/UI/guards y revisiones/checks útiles sobre árbol exacto | Runner/migraciones/scripts/lock recuperados y contrastados en §6.3. Ejecutar migraciones o suites queda sujeto al entorno aislado autorizado y a no repetir evidencia válida de otro antecedente |
| R16 | Ensayo staging antes de readiness; alias/procedencia/smoke activos solo en transacción posterior | No ejecutar workflow productivo ni exigir Vercel en host prepare-only. La prueba staging no se omite; el diferimiento de publicación no incluye migraciones/configuración/revisión pendientes |
| R17 | Ledger transaccional, saneado y observado; fallos de autoridad no simulados | Preparar cortes/expectativas por etapa existente; C2 obliga distinguir revocación servidor de final de cierre físico |
| R18–R22 | Workspace/exportaciones, Notepad++, OBS/Chrome, ficha/acceso RDC aplicable, observador y dos instanciaciones | Contratos y fuentes pueden prepararse independientemente. La restricción actual de acceso RDC del constructor no elimina R21: asistencia resuelve operación específica cuando corresponda; no se autoautoriza |
| R23–R26 | Store privado cifrado/capacidad/política, WP-LAB reproducible y restauración DB/medios/config | D01/D02 ya aprobadas documentalmente; no elegir otro proveedor. Preparación desde fuentes/licencias disponibles no requiere ZIP. Store/activo/licencia/host privados reales siguen pendientes |
| R27–R29 | GPU/ubicación elegibles, lock/modelos/backend local compatibles, TEST 01 y evaluación humana | Contrato/criterios D03 reutilizables. No inferir GPU ni descargar pesos/ejecutar inferencia sin elegibilidad/recursos; esta revisión no genera ni acepta la imagen |
| R30–R32 | Caída/restore/cierre/residuos, documentación/rollback coherentes y read-back final | Conservar todos los originales y evidencia válida por revisión/config/host. El manifiesto de la cabecera inspeccionada no basta: §6.3 muestra una divergencia concreta. No preparar readiness con conflictos/manifiesto incompleto |
| Contrato local-web, sin nuevo ID R | Igualdad de revisión/contratos/capacidad y contenido, identidad/lease/sync, recepción perdida, conflicto/restore | Correspondencia §3.5 y decisiones §3.6/§4.4 ahora explícitas. Propuesta no es implementación ni aprobación ni prueba |

### 6.2 Qué depende del ZIP y qué no; evidencia reutilizable

**Depende de los bytes causales:** verificar `overlay-index.json`, base y nueve archivos; determinar solapamientos y equivalencia con #292/main; recuperar recibos y atribuir las 18/11 pruebas al código/configuración reales; incorporar esas correcciones y regenerar manifiesto de la candidata resultante. La identidad reportada `041d203…` sigue sin ser hash demostrado del ZIP. No reconstruir esas correcciones para ocultar falta de acceso.

**No depende del ZIP:** revisar integridad de fuentes disponibles, comandos/lock/runners y efectos de workflows; preparar límites de migración y de ensayo aislado; completar correspondencia de capacidades y decisiones materiales; anotar recursos/pruebas del perfil en R01–R32; proteger contra publicación accidental. Ese trabajo se ejecutó en lo indicado en §6.3. Falta del ZIP no es un veto sobre todo Khora, fundación, WordPress o visual; sus propios permisos/activos sí pueden bloquear la ejecución afectada.

**Reutilización:** las fuentes normativas y bases exactas, propuestas ya recibidas y esquemas/código recuperados se conservan sin reiniciar lectura de contenido. Las pruebas históricas 18/11 siguen reportadas, no certificadas para la candidata: recuperar recibo/bytes y comparar revisión/configuración/entorno/supuestos antes de trasladar PASS. No repetirlas por rutina ni llamarlas inválidas solo por ser antiguas. La comprobación de hash de tres archivos realizada aquí es nueva evidencia estática acotada; no prueba el resto del árbol ni el producto.

**Después de revisión:** puede prepararse en aislamiento la parte disponible aprobada del árbol sin sobrescribir trabajo existente. La integración definitiva del overlay espera cotejo causal; cambios arquitectónicos/seguridad de A/B/C/local esperan revisión específica. Resolver conflictos y manifiestos no autoriza push/merge o publicación. Si el operador acepta una candidata alternativa sin esas correcciones recuperables, debe ser decisión explícita y pruebas propias, nunca una equivalencia declarada por Samantha.

### 6.3 Avance independiente efectivamente realizado y pronóstico actualizado

Trabajo de esta continuación, sin construir nuevos mecanismos:

1. Original de 38 048 bytes vuelto a adjuntar y preservado byte a byte con SHA-256 `5150c751848a11dd11346196d38e33acb3a254a3e7d0e96ec64daadd3914dd01`; mismo archivo completado solo en las secciones indicadas.
2. Reconfirmación del frente `8ae0a831…`, Khora main `dbc73af…`, y frescura SI con H1=H2=`6e0a416…`, blob `151333921…`. Se releyó el propósito integral; no se reabrió la auditoría B/C.
3. Lectura exacta de `package.json`, lockfile, runners de migración/unitarios/prebuild, manifiesto y workflows pertinentes. Se verificó Git blob de los bytes recuperados antes de comparar SHA-256: no se normalizó LF/CRLF para fingir concordancia.

| Fuente de #292 `6738c1f…` | Resultado estático observado |
|---|---|
| `khora-web/package.json` | SHA-256 real `8fd94d780ead37ff7dca776448cb604f72229b552bb9525f29f388d495abd698`; manifiesto declara `e1363c3511b6415fe6a8c6a8db5976fdbfb44ace6187e18c084e8cbd4bb3f069`: **MISMATCH** |
| `khora-web/scripts/migrate-ep.mjs` | SHA-256 `fee00e5a55adcc4d811faa478e25caebf2f592808b72174f3e7be363bcd29d53`: **MATCH** con manifiesto |
| `khora-web/scripts/run_unit_tests.mjs` | SHA-256 `c7274ea8ccd15c68f732568cb2013a8bd3f178f4682831bf3288063493f0b5ad`: **sin entrada** en manifiesto leído |

Esta divergencia impide usar el manifiesto actual como prueba de integridad completa. No se recalcularon hashes remotos para taparla: regeneración pertenece a la candidata integrada final autorizada. No se extendió la comprobación a todo el árbol ni se declaró corrupto todo el repositorio.

Dependencias raíz de `package.json` y lockfile coinciden en dependencies/devDependencies; bytes del lockfile coinciden con blob Git `a679e322b83cc1ce6e538c657c46401ac14672ef`. Versiones efectivas leídas: `@vercel/blob 2.6.1`, `next 16.4.0`, `next-auth 5.0.0-beta.32`, `pg 8.22.0`, `typescript 5.9.3`, `tsx 4.23.13`, `@playwright/test 1.61.1`, `adm-zip 0.5.18`, con integrity entries. No se confunde una restricción semver del package con la versión resuelta.

Compuertas preparadas desde esos scripts reales:
- `dev` contiene `next dev -p 3000 -H 0.0.0.0`: no usarlo como arranque seguro de la hermana loopback. El descriptor/invocación local aprobados deben fijar host/origen, sin abrir todas las interfaces por costumbre.
- `prebuild` ejecuta `build-extension.mjs`, que borra ZIP Harmonia previos bajo `public/downloads` antes de producir otro. Un build de ensayo se hace únicamente en el árbol propio aislado, no en trabajo existente ni en Descargas del operador; no se ejecutó el hook.
- `migrate:ep` aplica solo `016_ep_persistent_sessions.sql` y `017_ep_github_credential_vault.sql`, en una transacción. No instala schema 021 ni prueba su disponibilidad.
- `migrate:runtime` aplica 016/017 y 023–028; tampoco schema 021, y sus consultas no forman la misma transacción global que migrate:ep. No sustituir runners por nombre ni usar producción para comprobarlo.
- El runner unitario lee únicamente `tests/unit/*.test.ts`, usa TSX local y propaga status/signal; no demuestra que las pruebas de `lib/server/*.test.ts` estén incluidas. La cobertura causal/regresión se selecciona en el sistema existente, no se crea un nuevo validador.
- `deploy-production.yml` en main responde a push main/dispatch y aplica migración productiva además de build/deploy. `auto-merge-on-open.yml` puede fusionar tras `khora-ok / gate` exitoso, pero omite draft/no-main. Mantener draft ayuda a evitar ese auto-merge observado; no demuestra ausencia de otras integraciones ni autoriza push. No se disparó ningún workflow.

Fuentes de estas comprobaciones: [package](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/package.json), [lock](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/package-lock.json), [manifiesto](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/ep-integrity-manifest.sha256), [migrate-ep](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/scripts/migrate-ep.mjs), [migrate-runtime](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/scripts/migrate-runtime.mjs), [runner unitario](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/scripts/run_unit_tests.mjs), [prebuild](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/scripts/build-extension.mjs), [deploy](https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/.github/workflows/deploy-production.yml), [auto-merge](https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/.github/workflows/auto-merge-on-open.yml).

**Pronóstico recalibrado:** la entrega anterior cerraba una consolidación, no la preparación integral. Esta continuación cierra los cuatro huecos de explicación y las verificaciones independientes descritas; no reduce por ello la duración de implementación o restore. Revisión: una respuesta material agrupada puede resolver las políticas si no exige cambio de diseño; duración humana sin plazo. Construcción: depende de aprobación/candidata y cotejo causal, con posibilidad de preparar partes aprobadas disponibles en paralelo; tiempo todavía no estimable con respaldo. Pruebas/aceptación: ruta crítica pasa por host/recursos, suites útiles, dos instanciaciones y restore integral medido; no hay muestra actual para prometer horas o número cerrado de ciclos. Esperas por ZIP, identidad/host, store/licencias/GPU/runner y revisión se declaran por separado, no como tiempo técnico ficticio.

No hubo instalación, ejecución de suite/build, migración, arranque, cambios de seguridad, uso RDC, escritura en repositorio, publicación, reset ni borrado de trabajo existente. Esta preparación estática no se denomina candidata integrada ni aceptación. Permanecen diferenciados **propuesta / implementación / prueba / aceptación**.

## 7. Localizadores de evidencia de código

Todos los siguientes se recuperaron en la base exacta #292 indicada; son evidencia estática, no prueba de ejecución:

- [EP/emisión/registry](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/ep.ts)
- [Cookie maestra](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/ep-master-session.ts)
- [Verificador/rotación](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/ep-master-password.ts)
- [Checkpoint](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/app/api/dictado/checkpoint/route.ts)
- [Edición/versionado](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/correcciones.ts)
- [Dictado y custodia](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/dictado.ts)
- [Audio/subida](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/app/api/audio/route.ts)
- [Propuestas/aplicación](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/propuestasCorreccion.ts)
- [Segmentación/ratificación](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/pulido.ts)
- [Fragmentos](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/fragmentos.ts)
- [Aprobación directa alternativa](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/app/api/revision/%5Bid%5D/route.ts)
- [Aprobación con compuerta](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/app/api/revision/%5Bid%5D/aprobar/route.ts)
- [Eventos/idempotencia/outbox](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/eventos.ts)
- [Schema 021](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/db/migrations/021_eventos_durables.sql)
- [Schema 016](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/db/migrations/016_ep_persistent_sessions.sql)
- [Schema 017 EP](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/db/migrations/017_ep_github_credential_vault.sql)

## 8. Retiro técnico de pendientes de integración — entrega parcial comprobada

Este suplemento responde al hito de retirar pendientes técnicos; no sustituye §§1–7 ni el inventario/contraste recibidos. La revisión ampliada anterior se conserva íntegra: 65 358 bytes, SHA-256 `ac16204a8b1cfa3241941c9b6f161cd5716d42e2dd15770211f8003f99016bd3`. El original previo de 38 048 bytes también se conserva. Esta entrega es temporal y recuperable; OEP en Metodología continúa siendo el único estado vivo. No hubo escritura Git remota ni modificación de sus prompts.

### 8.1 Base, frescura y procedencia de la corrección

- Khora `main` recotejado: `dbc73afada1ad29abf46f4599d22cc3158a9a986`.
- Pieza de producto: `6738c1f1aeffe5835a725531e0774d4420af13c5`, solicitud de integración #292 abierta/en borrador/no fusionada, con estado remoto `dirty` observado. Su estado global no queda resuelto por esta entrega.
- Pieza de validación recuperada y cabecera recotejada: `test/ep-single-cycle-readiness-20261011` = `93cbcb2845239274f6ee03fe149b526e4a624238`. Se incorporan sus archivos de validación al árbol parcial contra main; NO se crea un validador ni suite paralelos.
- Gobierno superior: Sistema de Instrucciones v1.6.21 leído en `main` exacto `6e0a416025594916016a34ae32e2b7e8af591320`; primera y segunda lectura de main coinciden. Metacanon 1.4 conserva blob `61bc98e0b3f5e149274238a5f6df39a8a4aba539`.
- El frente avanzó durante esta ejecución: OEP v0.3.7 / Versión de Contexto Universal (VCU)-EP-v9, commit `9969494dc459954dbb44639bd6e94db3780ab086`, blob `3f433f2376a6547e68080f41efb64224a9f87dc4`. Delta adquirido sin reiniciar auditoría: hitos EP-H01–EP-H06, provisión cifrada a cargo de asistencia, antecedente visual separado de WordPress y suspensión del ingreso de llave olvidada. Solo se bloquea la provisión dependiente; no se ejecuta reset. La identificación de la credencial y recuperación no destructiva corresponden al checkpoint humano ya abierto por asistencia.

**Procedencia intencional de package/runner:** `package.json` es byte-idéntico en main y en la pieza #292 (blob `17e8c7ceb7c2dbfa7aa7a855de85ba820691ce53`). El historial recuperado atribuye el comando `test:unit` y el ejecutor a `cc0442689107d00c6463a1fed1d31d42de6d5b23`; la retirada de dependencias directas firebase/nodemailer a `019d7ab396534148db111b7860697ec7c8029d81`; la versión 0.3.7 al hito de custodia `caf5ba5c638a628013aaf55007e4bee33048931b`; y 0.3.8 a `5a956f1f1916ba03b937e33c266ae29874735451`. No son nuevas políticas A/B/local/C. No atribuyo el hash obsoleto `e136…` a una versión histórica concreta sin cotejo de esos bytes.

El runner también es byte-idéntico main/#292: blob `c1d578b85003b9288619b42045be51996a5d87a4`. Conserva descubrimiento ordenado, soporte de nombres con espacios y propagación de fallo. No se modificó su comportamiento. El lockfile de main fue recuperado y cotejado contra blob `a679e322b83cc1ce6e538c657c46401ac14672ef`; dependencias, dependencias de desarrollo y versión raíz coinciden con package.json.

### 8.2 Cambio mínimo implementado y probado en el árbol aislado

**Pendiente retirado, con alcance acotado:** corrección de la expectativa SHA-256 de package.json y cobertura del runner; integración de esa comprobación en `tests/validate_ep.py` de la rama vigente y regresión en `tests/test_ep_release_readiness.py`, conservando el helper `ep_release_readiness.py` byte a byte. Sus comprobaciones estáticas previas se cotejaron por árbol sintáctico y permanecen intactas. Ninguna bandera nueva permite omitirlas. No se toca la autenticación, interfaz, cifrado, Guardian ni publicación del producto.

Cambios del parche contra main:

1. `ep-integrity-manifest.sha256`: reemplaza solo la expectativa revisada de package.json y huellas de los archivos de validación incorporados/editados; añade cobertura explícita del runner y helper/suite/documentación existentes. Las demás entradas se conservan, no se recalculan indiscriminadamente.
2. `tests/validate_ep.py`: incorpora la versión de la pieza vigente y comprueba hashes/cobertura antes de sus checks estáticos; falla cerrado por bytes alterados, archivo ausente, duplicación/autorreferencia, ruta insegura o cobertura requerida ausente. No regenera hashes.
3. `tests/ep_release_readiness.py`: incorpora el helper existente sin alterar sus bytes ni su política de recibos.
4. `tests/test_ep_release_readiness.py`: conserva sus diez métodos y añade nueve regresiones causales de integridad en LA MISMA suite.
5. `tests/README-EP-READINESS.md`: sincroniza referencia del contrato y describe el alcance de la comprobación; no añade otro estado de producto.

`package.json` y `run_unit_tests.mjs` no cambian de contenido. No se ejecutó `generar_manifiesto_integridad.sh`: su comportamiento de omitir archivos ausentes/recalcular todo no acredita procedencia y habría invalidado el alcance sobre un árbol parcial.

**Árbol parcial identificado:** huella SHA-256 de nombres y bytes, excluyendo caché Python: `db4042805e5be0014be56ad761198891ffc3206495f71702f0fac21dda73e18a`. NO es SHA de commit Git ni candidato liberable. Parche `integrity-existing-validator.patch`, SHA-256 `1fb5764a0595d934d4d46a848910744ef3a5e76648ad00072a3b572fd718f96b`, aplicado en preparación aislada y con `git apply --check` satisfecho contra los archivos exactos recuperados de main. No hubo checkout/reset sobre trabajo existente.

| Comprobación realmente ejecutada | Resultado | Límite |
|---|---|---|
| Blobs Git de fuentes utilizadas | Coinciden con bytes recuperados | No todos los archivos del repositorio fueron recuperados |
| Regresión del validador/suite vigentes | 19 métodos PASS, 9 nuevos de integridad | Datos sintéticos; no certifica ningún requisito físico ni recibo operacional |
| Negativa: archivo alterado sin rehash | Rechazado | Guardado en la suite existente |
| Negativa: runner sin cobertura | Rechazado | No basta que el archivo exista |
| Negativas adicionales | Runner ausente, entrada duplicada/malformada, traversal, manifiesto ausente, lectura no mutante | Comprobación focal, no auditoría del sistema |
| Manifiesto global sobre árbol parcial | BLOCKED: 593 archivos todavía ausentes; cero discrepancias en archivos presentes | Nunca PASS global; no habilita publicación |
| Python AST y Node `--check` | PASS en archivos recuperados/modificados indicados | No sustituye typecheck/build/sintaxis PowerShell |
| Contraste por rutas de manifests de producto y validador contra main | 22 y 6 entradas delta; cero solapamientos con expectativas diferentes | No equivale a merge completo de sus árboles; #292 sigue pendiente |
| Regeneración indiscriminada / nueva suite paralela | NO ejecutada / NO entregada | El intento exploratorio previo sobre el antecedente de main fue descartado para entrega; no se promueve |

### 8.3 Dependencias y pruebas de producto independientes

Se ejecutó `npm ci --ignore-scripts --no-audit --no-fund` en directorio nuevo aislado, con package/lock exactos, entorno sin secretos y caché propia: salida cero, 558 paquetes instalados. Las huellas de ambos archivos se conservaron. No se ejecutaron hooks de instalación, prebuild, Next build ni servidor; no se descargaron Divi ni pesos/modelos del perfil.

En otro alcance claramente identificado —subconjunto recuperado del código exacto #292, no la candidata integrada— se ejecutó el runner ORIGINAL con el setup ORIGINAL y únicamente estos tres archivos existentes:

- `audio_custodia.test.ts`: cinco casos; partes contiguas, hueco, verificación pendiente, SHA inválido y bytes vacíos.
- `ep_token.test.ts`: cuatro casos; conservación de campos y rechazo de firma/algoritmo/expiración/formato. No prueba la revocación real en base de datos ni políticas C pendientes.
- `runtime_state_migration.test.ts`: un caso de contrato textual de la migración 023. No ejecuta SQL ni demuestra idempotencia en PostgreSQL.

Resultado: 10 pruebas PASS, cero fallos/omitidas, salida del runner cero. La suite unitaria completa del catálogo no se declara ejecutada: este directorio es un subconjunto. El setup existente simula identidad para pruebas unitarias; no se modificó para abrir producto ni se usa como evidencia de acceso local autorizado. No hubo claves reales, login de operador, petición productiva ni bypass nuevo.

Análisis estricto de tipos con TypeScript instalado desde el lockfile: PASS para `lib/server/jwt.ts` y `lib/audio/custodia.ts`, sin emisión. No es typecheck global de la aplicación.

La prueba previa de tres escenarios sintéticos del runner —vacío, nombre con espacios, propagación de fallo— también pasó. Usó TSX preinstalado 4.23.15, distinto del lock de app 4.23.13: queda como ensayo estructural del runner, no evidencia intercambiable del producto. La ejecución posterior de diez pruebas sí usó las dependencias del lock instalado.

### 8.4 Alcance cerrado de preparación del ensayo de migraciones, ejecución todavía bloqueada

| Archivo recuperado | SHA-256 de bytes exactos |
|---|---|
| `016_ep_persistent_sessions.sql` | `7ef779de599d0dd02cf7caf62dd2ce5d85096856881e8351470be3ef0b988c51` |
| `017_ep_github_credential_vault.sql` | `112f55a592be420c5fcc95f1d3852d4f3b22821a26eee1f3dbf14705965c2c7c` |
| `021_eventos_durables.sql` | `e92a70f954498d932b74ab8a868a156c5dc9033661082be0a903cc87771131ed` |
| `022_reparacion_registro_eventos.sql` | `03a1ddfadd3b2fe6fe712d1bc5ba9b48b31e6b6118c3c43ecf4849819ae18f6e` |

- **016_ep_persistent_sessions.sql:** requerido por sesiones, tokens y libro EP. Verificar `ep_sessions`, `ep_bootstrap_tokens`, `ep_events`, tipos/nulabilidad, claves primarias, vínculo de sesión y unicidades `(session_id,secuencia)` / `(session_id,event_hash)` antes/después.
- **017_ep_github_credential_vault.sql:** dependencia de los mecanismos YA presentes en #292, no una migración creada para C. Verificar tablas de bóveda/verificador/intentos, singleton, tamaños/checks y los índices publicados. No confundirlo con el otro archivo 017 de segmentación ni aplicar por número suelto.
- **021_eventos_durables.sql:** dependencia del mecanismo existente de eventos/idempotency_key/outbox usado por continuidad B/local. Verificar `eventos_sistema` y sus columnas ampliadas, índice único parcial de idempotencia, `event_uuid`, `eventos_outbox`, estados y sus índices. No presenta las políticas B como aprobadas ni implementadas.
- **Prerrequisito real:** 021 altera `eventos_sistema`; no crea su base. Debe partir de copia aislada con esquema base compatible. Si falta la tabla, bloquear esa variante, no improvisar un esquema o ejecutar DDL durante una petición HTTP. El mecanismo existente 022 de reparación fue recuperado como alternativa condicionada a la admisión exacta; tiene transacción propia y no se envuelve suponiendo que sus COMMIT conservarán un rollback exterior.

**Secuencia finita de ensayo:** identificar base PostgreSQL aislada/propietario/autorización y ausencia de destino productivo; comprobar backup restaurable y catálogo inicial; aplicar 016/017 mediante `migrate-ep.mjs` existente de #292 (un cliente, BEGIN, dos archivos, COMMIT y ROLLBACK ante error); aplicar 021 con cliente PostgreSQL existente y parada por error dentro de su propia transacción, después de comprobar la tabla base; obtener catálogo de columnas/tipos/nulabilidad, constraints e índices; repetir exactamente 016/017/021 y cotejar definición normalizada y filas centinela sintéticas; probar fallo inducido en transacción aislada y verificar catálogo/filas anteriores; restaurar el backup en otra sesión/base aislada autorizada y cotejar contenido/huellas. Un reintento idempotente no equivale a restauración.

**Rollback:** ensayo real separado de reversión de aplicación y datos. No borrar tablas/columnas productivas ni convertir una migración aditiva en pérdida de datos. Validar rollback transaccional para fallo precommit y restauración de copia consistente para el corte posterior, con filas sintéticas preservadas y aplicación anterior compatible. No declarar backup/restore sin lectura de vuelta. El catálogo y las verificaciones de base restante del perfil siguen siendo requisitos R13/R30/R32.

**Límite observado:** no había psql/postgres/docker ni base aislada PostgreSQL admitida en este entorno; la instalación de dependencias Node no crea una base. Por tanto SQL aplicado, idempotencia real y rollback/restauración = NO EJECUTADOS. No se creó almacenamiento, no se usó DATABASE_URL real. La asistencia prepara el recurso cifrado en PC-14 por su propia autorización, actualmente condicionado al evento de llave; no asumí que ese recurso ya exista ni que habilite una base de datos.

### 8.5 Arranque local: diff preparado, no aplicado ni demostrado

El cambio mínimo preparado contra el package observado sustituye únicamente `next dev -p 3000 -H 0.0.0.0` por `next dev -p 3000 -H 127.0.0.1`. Se conserva aparte como `dev-loopback-PENDIENTE.patch`; NO modifica package en el árbol probado ni sus huellas. No basta para acceso local, aislamiento, política de Host/Origin o autenticación. Selección de IPv4/IPv6/hostname, orígenes y principal local siguen sujetos a la revisión B/local.

**Prueba de aceptación preparada sobre mecanismos existentes, solo después de aprobación:** arrancar la revisión exacta con dependencias fijadas y supervisor aprobado; identificar proceso/puerto real; cotejar listener por proceso y probar que solo escucha en direcciones loopback aprobadas, nunca comodín ni interfaces LAN; comprobar conectividad desde loopback autorizado y rechazo desde interfaz remota; contra conexión loopback intentar Host ajeno, Origin ajeno, petición sin principal vigente y cookie/token de otro origen/sesión; verificar rechazo sin contenido privado ni mutación; probar origen/principal aprobados y compatibilidad de contratos local-web; terminar el proceso/Guardian y verificar puerto y residuos cerrados. Un GET de login público no demuestra acceso anónimo al contenido privado.

El Playwright existente `playwright.config.ts` define `PLAYWRIGHT_TEST_BYPASS=true`, identidad/base de pruebas y servidor con `next start`; ese harness puede servir a regresiones de interfaz, pero NO acredita acceso local real ni listener de `dev`. No se lanzó. El ensayo de aceptación debe carecer de bypass de pruebas y usar la configuración específicamente aprobada, sin heredar cookies/logins reales por inferencia. No se añadió otro launcher o harness para eludir esa revisión.

### 8.6 Estado por los hitos existentes, siguiente compuerta y pronóstico

- **EP-H01:** la revisión y consecuencias están recuperables; sigue pendiente aceptación específica A/B/local/C. Las decisiones exactas ya están en §§3.5–3.6/4.4: capacidades que deben funcionar sin red; principal/alcance/renovación/custodia y duración de concesión; invalidación de cookies y tokens por usuario/sesiones y orden ordinario/emergencia. No aplicar cinco minutos por analogía con checkpoints ni revocación selectiva por inferencia.
- **EP-H02:** preflight del host reportado por asistencia; volumen y admisión integral NO demostrados por el constructor. El nuevo checkpoint de recuperación de llave suspende solo provisión dependiente; no hago otra pregunta duplicada ni reset.
- **EP-H03:** retirada la brecha concreta package/runner, integración parcial de la pieza de validación sobre main y dependencias/pruebas focales verificadas. Árbol completo, integración de #292 y nueve correcciones del ZIP causal, manifiesto de todos los bytes, compilación/suites/CI útiles y migración/restore reales siguen pendientes. Los hashes de manifests recuperados no sustituyen los archivos restantes.
- **EP-H04:** local hermana continúa propuesta pendiente de revisión específica y ensayo real; no se acredita por los tests unitarios aquí realizados.
- **EP-H05:** continuidad/backup/restore/cierre fundacional, WordPress y visual no certificados. Divi 4.23.1 sigue como antecedente transversal; 4.24.0 conserva su procedencia histórica distinta hasta instrucciones posteriores comprobadas. No hubo descarga/install de activos ni cambios a OGP/WordPress. El nuevo adjunto OGP referido por el objeto no cambia WordPress; lugar/GPU actuales no se heredan de PC-7.
- **EP-H06:** no ready, no aceptación integral, no “solo falta Vercel”. Publicación Vercel permanece fuera de esta ejecución.

**Trabajo desbloqueado completado sin esperar host/ZIP:** proveniencia de package/runner; recuperación de pieza vigente; parche aplicado y pruebas causales en suite existente; coherencia package-lock; instalación aislada sin hooks/secretos; subconjunto unitario recuperado y typecheck focal; secuencia de migraciones y diff/listener/origen preparados, sin aplicar políticas sensibles.

**Dependencias que no se sustituyen:** ZIP causal e índice/recibos para cotejar sus nueve correcciones; fuentes restantes para checkout completo; decisión específica para construir A/B/local/C; base de ensayo admitida para SQL; recuperación/host protegido y destinos reales para pruebas físicas y continuidad. La ausencia del ZIP no fue bloqueo universal. Las pruebas históricas de 18 métodos/11 casos no se atribuyen a este árbol ni se vuelven a ejecutar de memoria.

**Pronóstico por ruta crítica:** la corrección de huellas/validador y comprobaciones independientes descritas se cerraron en esta ejecución. El próximo hito completo EP-H03 requiere integración de fuentes/overlay y pruebas del árbol entero; EP-H04 además la revisión específica de mecanismos. Construcción y regresión pueden prepararse sin la provisión, pero aceptación física/SQL/restore no. No hay duración observada comparable para esos ensayos ni plazo medido de la recuperación de llave: cierre total NO ESTIMABLE con fundamento. El presupuesto subjetivo histórico de 12–24 horas queda explícitamente fuera de la evidencia. Esperas separadas: decisiones humanas, credencial/recuperación, paquete causal, base/destinos/host y activos/ubicación elegible. El tiempo de npm ci y estas pruebas focales no se extrapola al cierre integral.

**Checkpoint exacto:** preservar original, ampliación, parche contra main y recibos; asistencia coteja recepción de la ampliación y resuelve su checkpoint de credencial sin pérdida; revisar específicamente §§3.5–3.6/4.4 antes de construir lo afectado; cotejar bytes del causal cuando estén disponibles y admitir entorno/base de ensayo antes de SQL/host. No reiniciar inventarios ni sustituir un paquete no adquirido. No se promete continuación automática después de terminar esta invocación.

**Fuentes primarias del delta:**

- [Frente OEP v0.3.7](https://github.com/SeryMente/metodologia/blob/9969494dc459954dbb44639bd6e94db3780ab086/frentes/ep/OEP.md)
- [Validador existente](https://github.com/SeryMente/khora/blob/93cbcb2845239274f6ee03fe149b526e4a624238/tests/validate_ep.py)
- [Suite existente](https://github.com/SeryMente/khora/blob/93cbcb2845239274f6ee03fe149b526e4a624238/tests/test_ep_release_readiness.py)
- [Package baseline](https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/khora-web/package.json)
- [Runner baseline](https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/khora-web/scripts/run_unit_tests.mjs)
- [Migrador existente #292](https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/scripts/migrate-ep.mjs)
- [Harness Playwright existente](https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/khora-web/playwright.config.ts)

### 8.7 Lectura de vuelta y recibos de ejecución

El código del helper de readiness conserva sus bytes originales. Las nueve regresiones nuevas están en la suite existente; no se entrega el archivo exploratorio `test_ep_integrity.py`. Las salidas que siguen son recibos del alcance declarado, no evidencia operacional R01–R32.

**Regresión focal final del validador existente (datos sintéticos):**

```text
test_deleted_runner_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_deleted_runner_is_rejected) ... ok
test_duplicate_entry_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_duplicate_entry_is_rejected) ... ok
test_malformed_digest_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_malformed_digest_is_rejected) ... ok
test_missing_manifest_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_missing_manifest_is_rejected) ... ok
test_modified_file_is_rejected_without_rehash (test_ep_release_readiness.EpIntegrityTests.test_modified_file_is_rejected_without_rehash) ... ok
test_repeated_validation_is_read_only (test_ep_release_readiness.EpIntegrityTests.test_repeated_validation_is_read_only) ... ok
test_runner_without_coverage_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_runner_without_coverage_is_rejected) ... ok
test_traversal_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_traversal_is_rejected) ... ok
test_valid_reviewed_fixture (test_ep_release_readiness.EpIntegrityTests.test_valid_reviewed_fixture) ... ok
test_all_profiles_enforce_authorized_scope (test_ep_release_readiness.PreparationGateTests.test_all_profiles_enforce_authorized_scope) ... ok
test_each_missing_gate_blocks (test_ep_release_readiness.PreparationGateTests.test_each_missing_gate_blocks) ... ok
test_each_nonpass_gate_blocks (test_ep_release_readiness.PreparationGateTests.test_each_nonpass_gate_blocks) ... ok
test_empty_and_nonobject_manifest_fail_closed (test_ep_release_readiness.PreparationGateTests.test_empty_and_nonobject_manifest_fail_closed) ... ok
test_invalid_json_duplicate_keys_and_constants_rejected (test_ep_release_readiness.PreparationGateTests.test_invalid_json_duplicate_keys_and_constants_rejected) ... ok
test_manifest_changes_do_not_retain_readiness (test_ep_release_readiness.PreparationGateTests.test_manifest_changes_do_not_retain_readiness) ... ok
test_missing_file_hash_mismatch_and_tamper_block (test_ep_release_readiness.PreparationGateTests.test_missing_file_hash_mismatch_and_tamper_block) ... ok
test_path_escape_absolute_and_symlink_block (test_ep_release_readiness.PreparationGateTests.test_path_escape_absolute_and_symlink_block) ... ok
test_receipt_approvals_identity_and_timestamps (test_ep_release_readiness.PreparationGateTests.test_receipt_approvals_identity_and_timestamps) ... ok
test_structurally_complete_fixture_is_prepared_not_published (test_ep_release_readiness.PreparationGateTests.test_structurally_complete_fixture_is_prepared_not_published) ... ok

----------------------------------------------------------------------
Ran 19 tests in 0.577s

OK
```

**Subconjunto de pruebas existentes de producto:**

```text
✔ custodia: acepta partes contiguas, no vacías y verificadas (1.492481ms)
✔ custodia: rechaza un hueco de índice (0.260562ms)
✔ custodia: rechaza parte no verificada (0.263178ms)
✔ custodia: rechaza SHA-256 inválido (0.142094ms)
✔ custodia: rechaza bytes vacíos (0.17444ms)
✔ EP token conserva audience, session y scopes (1.542589ms)
✔ JWT rechaza firma alterada en tiempo constante (0.962998ms)
✔ JWT rechaza algoritmo distinto aun con firma valida (0.260844ms)
✔ JWT rechaza expiracion exacta y formatos no canonicos (0.26073ms)
✔ 023_runtime_state define almacenamiento idempotente del snapshot vivo (1.269476ms)
ℹ tests 10
ℹ suites 0
ℹ pass 10
ℹ fail 0
ℹ cancelled 0
ℹ skipped 0
ℹ todo 0
ℹ duration_ms 537.946598
[unit-runner] status=0 signal=null
```


## 9. Paquete de integración reproducible parcial — continuación sin esperar bóveda

**Naturaleza:** entrega temporal del trabajo existente; no otro producto, launcher, tablero, validador ni fuente de estado. Conserva íntegros §§1–8 e inventarios recibidos. Esta sección actualiza solo el artefacto de integración y su evidencia; el parche/hash y los 19 métodos de §8 son la entrega anterior, no el parche final de este paquete. No sumar ejecuciones como avance integral.

**Revisiones recotejadas:** main Khora `dbc73afada1ad29abf46f4599d22cc3158a9a986`; rama de validador `93cbcb2845239274f6ee03fe149b526e4a624238`; fuente de producto `6738c1f1aeffe5835a725531e0774d4420af13c5`. Fuente documental adquirida: OEP v0.3.8 / Versión de Contexto Universal (VCU)-EP-v10, commit `dd67536862adeb64c3f554570b7c73e5f3bafbf7`, blob `f8519c8144e096311f1d207a1e08b16823dd9765`. El operador comunica después de ese checkpoint que su llave anterior no autenticó la copia cifrada de Git probada. Es un resultado reportado sobre ESA copia, no prueba de ausencia de otros respaldos recuperables. Identidad de la credencial: bóveda central de variables; no repetir la pregunta ya resuelta. Asistencia conserva exclusivamente recuperación/provisión del host; constructor no ejecutó reset, rotación ni Remote Desktop Commander.

### 9.1 Diferencia puntual adicional del lockfile y corrección mínima

La comprobación dirigida de package/lock/runner —no otra auditoría— encontró que la expectativa de lockfile en el manifiesto base era `106e4e042083b978174befa8b497b252acc2ebbebae6582c5f4bc33b521c4b77`, mientras los bytes Git de main y #292, idénticos, producen `2cfeef074f3daf84e3369aa2bcecab5fb2e4f7b9b4c7a45df108a8666d5cf4bd`. Blob comprobado `a679e322b83cc1ce6e538c657c46401ac14672ef`, 335937 bytes. La instalación previa no había demostrado que esa expectativa del manifiesto fuese correcta; ese pendiente se retira ahora, sin atribuirle un PASS anterior.

Procedencia del cambio intencional: historial exacto del lockfile conserva `e2d89dbdc7aa0f537cea94188abdecb5e99215a3` (alineación 0.3.8), `caf5ba5c638a628013aaf55007e4bee33048931b` (custodia/0.3.7), `019d7ab396534148db111b7860697ec7c8029d81` (retirada de superficie/dependencias; parche de lockfile comprobado) y `559a61ce0d52fa600eb9d4b6d8c3f00d8073a1c1` (dependencia de codificador MP3). No se inventa qué copia histórica produjo la expectativa obsoleta.

**Contenido fuente de package.json, package-lock.json y runner: sin cambios.** Se corrigen sus expectativas/cobertura sobre bytes fijados por blob. El validador y la suite EXISTENTES incluyen ahora lockfile en cobertura obligatoria y dos negativas adicionales: modificación sin rehash y ausencia de cobertura. Se mantienen el helper original y los checks estáticos previos. No se recalculan las otras huellas del repositorio indiscriminadamente.

Parche final contra main: `patches/integrity-existing-validator.patch`, SHA-256 `cba800ba48a81d30037c55a3b0f327e2195f63c900398bc065690dcdd9a55e91`. Huella de nombres/bytes del árbol parcial preparado, excluyendo caché: `e55cb366e36400994e889f7dcd9e04b9509d58bde50407c5c2e8c37766e39d0d`. Es una huella de contenido, NO SHA de commit ni candidata integrada. La comprobación global sigue bloqueada: faltan 592 archivos, cero discrepancias/coberturas requeridas ausentes entre los presentes.

### 9.2 Qué contiene y cómo se reconstruye

`EP-H03-integracion-reproducible-parcial-20261011.zip` contiene:

- `docs/Revision-conjunta-ABC-local-prepare-only.md`: este documento completo, incluyendo los inventarios anteriores.
- `base/`: archivos base exactos suficientes para aplicar el diff; no se presenta como checkout completo ni incluye .git.
- `patches/`: diff final contra main y diff de loopback pendiente SEPARADO; el segundo nunca se aplica por la reproducción.
- `prepared/`: resultado parcial esperado, para cotejo byte a byte; no un segundo producto activo.
- `unit-subset/`: únicamente fuentes exactas del subconjunto ya probado y su runner/setup originales, sin node_modules, credenciales ni nueva lógica.
- `migrations/`: SQL exacto 016/017 de bóveda/021 y 022 como referencia condicional; no runner nuevo ni ejecución de SQL.
- `evidence/`: resultados con su ámbito/revisión, no recibos operacionales falsos de R01–R32.
- `SOURCE-MAP.json` y `SHA256SUMS`: procedencia e integridad de entrega, no otro estado vivo o validador.

Restauración: extraer únicamente a una carpeta nueva controlada en un entorno autorizado, nunca sobre trabajo existente ni sobre un disco no protegido con material privado; verificar SHA256SUMS con utilidades existentes; copiar base a un staging nuevo; comprobar y aplicar SOLO el parche de integridad con git apply; cotejar cada archivo resultante contra prepared; ejecutar la suite existente para el alcance sintético indicado. No requiere conexión Git, llaves, login ni recursos reales. Los archivos unit-subset pueden reutilizar dependencias solo si el lockfile/configuración coinciden; en otro entorno se instalan desde ese lock y se vuelven a probar. No trasladar el resultado anterior a otro host por copiar su recibo.

No se entrega script de arranque, runner ni validador nuevo. Las instrucciones de restauración no autorizan lanzamiento de EP, aplicación del diff local, migration, acceso a servicios, publicación, cambios de permiso ni pruebas sobre PC-14. El paquete NUEVO no es ni reemplaza `KHORA-EP-hito-causal-041d203ae726.zip`; sus nueve correcciones siguen sin cotejarse contra sus bytes.

### 9.3 Migraciones y límites de reversión

La secuencia y aceptación preparadas en §8.4 permanecen vigentes. 016 es persistencia de sesiones/tokens/bitácora; 017_ep_github_credential_vault es la pieza existente de #292 (no el otro 017 ni un esquema nuevo aprobado); 021 depende de tabla base compatible y habilita las columnas/index/outbox existentes, sin aprobar por sí misma la propuesta B/local. Copiar SQL al paquete NO autoriza aplicarlo.

Reversión del ensayo: rollback transaccional antes del commit y restauración comprobada de copia aislada después del commit son pruebas distintas; no DROP de tablas/columnas por defecto. 022 tiene transacción propia y queda como referencia de reparación condicionada, no se aplica ni se anida suponiendo rollback exterior. No se usaron DATABASE_URL, secretos ni recursos reales, y no se creó base de datos. Schema/idempotencia SQL/restore/rollback físicos permanecen NO EJECUTADOS.

### 9.4 Pruebas y evidencia, sin transferencia indebida

- 21 métodos del validador vigente PASS en esta continuación; diez originales y once de integridad en LA MISMA suite. Se repite esa regresión por el cambio causal de cobertura/manifest, no una auditoría general.
- Aplicabilidad del parche sobre los archivos base exactos: PASS. Reconstrucción desde base + parche y cotejo de salida se comprueban durante el empaquetado, sobre una carpeta nueva aislada.
- Sintaxis y preservación de checks/helper: comprobadas en el árbol preparado. El manifiesto global rechaza el árbol incompleto, nunca habilita readiness.
- Las diez pruebas unitarias de producto y dos typechecks de §8.3 siguen adscritos al subconjunto `6738…` y configuración de su ejecución anterior; no se vuelven a atribuir a prepared. Sus fuentes se cotejan por huellas al incorporarlas al paquete. La instalación previa sin hooks, con lock exacto, tampoco demuestra build ni compatibilidad en otro host.
- Archivo ZIP generado con orden, permisos y timestamps fijos; SHA-256 reproducible entre dos generaciones. Al reabrirlo se comprueban rutas/bytes y la reconstrucción parcial, sin secretos ni recursos externos. No se ejecuta ningún ZIP histórico no adquirido.

### 9.5 Coordinación, recepción y siguiente paso

El estado oficial permanece en frentes/ep/OEP.md de SeryMente/metodologia. No escribo directamente en paralelo al delta de recuperación mantenido por asistencia. El delta técnico y archivos se coordinan con la sesión existente de asistencia; hasta lectura de vuelta en repositorio, su incorporación canónica se considera PENDIENTE, no guardada. No se crea otro objeto vivo ni se habilita una publicación documental sin revisión de efectos.

**Descargas de PC-14:** archivos recuperables entregables por esta conversación; depósito/lectura en Descargas NO VERIFICADOS por constructor. Aunque existe conexión Remote Desktop Commander en la sesión, permanece deshabilitada por orden; no se usa ni se hereda una ruta/dispositivo para satisfacer entrega. La asistencia no recibe otra tarea de host que desplace su recuperación. La falta de una transferencia específicamente autorizada no impidió crear/probar el paquete.

**Siguiente paso constructivo:** cotejar las piezas todavía no recuperadas/overlay causal y completar el árbol íntegro contra baseline vigente, incorporando solo lo autorizado; mantener fuera el diff loopback y las políticas A/B/local/C hasta revisión específica. Para SQL real y pruebas físicas se necesita entorno/base/host admitidos; no esperar bóveda para recuperación de fuentes y preparación independiente. Paquete parcial y pruebas acotadas no cierran EP-H03/EP-H04/EP-H05/EP-H06.

**Pronóstico:** paquete reproducible parcial completado en esta ejecución; tiempo de revisión de políticas, recuperación causal, base/host protegido y aceptación integral no medidos. No se extrapolan tiempos de pruebas pequeñas ni el presupuesto histórico de 12–24 horas. La espera de llave es de asistencia y bloquea solo su provisión. NO candidata integrada, NO preparación completa, NO “solo Vercel”.

**Fuentes puntuales:** [Frente adquirido](https://github.com/SeryMente/metodologia/blob/dd67536862adeb64c3f554570b7c73e5f3bafbf7/frentes/ep/OEP.md); [lockfile baseline](https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/khora-web/package-lock.json); [alineación de lock](https://github.com/SeryMente/khora/commit/e2d89dbdc7aa0f537cea94188abdecb5e99215a3).

**Regresión afectada de esta continuación:**

```text
test_deleted_runner_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_deleted_runner_is_rejected) ... ok
test_duplicate_entry_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_duplicate_entry_is_rejected) ... ok
test_lockfile_without_coverage_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_lockfile_without_coverage_is_rejected) ... ok
test_malformed_digest_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_malformed_digest_is_rejected) ... ok
test_missing_manifest_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_missing_manifest_is_rejected) ... ok
test_modified_file_is_rejected_without_rehash (test_ep_release_readiness.EpIntegrityTests.test_modified_file_is_rejected_without_rehash) ... ok
test_modified_lockfile_is_rejected_without_rehash (test_ep_release_readiness.EpIntegrityTests.test_modified_lockfile_is_rejected_without_rehash) ... ok
test_repeated_validation_is_read_only (test_ep_release_readiness.EpIntegrityTests.test_repeated_validation_is_read_only) ... ok
test_runner_without_coverage_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_runner_without_coverage_is_rejected) ... ok
test_traversal_is_rejected (test_ep_release_readiness.EpIntegrityTests.test_traversal_is_rejected) ... ok
test_valid_reviewed_fixture (test_ep_release_readiness.EpIntegrityTests.test_valid_reviewed_fixture) ... ok
test_all_profiles_enforce_authorized_scope (test_ep_release_readiness.PreparationGateTests.test_all_profiles_enforce_authorized_scope) ... ok
test_each_missing_gate_blocks (test_ep_release_readiness.PreparationGateTests.test_each_missing_gate_blocks) ... ok
test_each_nonpass_gate_blocks (test_ep_release_readiness.PreparationGateTests.test_each_nonpass_gate_blocks) ... ok
test_empty_and_nonobject_manifest_fail_closed (test_ep_release_readiness.PreparationGateTests.test_empty_and_nonobject_manifest_fail_closed) ... ok
test_invalid_json_duplicate_keys_and_constants_rejected (test_ep_release_readiness.PreparationGateTests.test_invalid_json_duplicate_keys_and_constants_rejected) ... ok
test_manifest_changes_do_not_retain_readiness (test_ep_release_readiness.PreparationGateTests.test_manifest_changes_do_not_retain_readiness) ... ok
test_missing_file_hash_mismatch_and_tamper_block (test_ep_release_readiness.PreparationGateTests.test_missing_file_hash_mismatch_and_tamper_block) ... ok
test_path_escape_absolute_and_symlink_block (test_ep_release_readiness.PreparationGateTests.test_path_escape_absolute_and_symlink_block) ... ok
test_receipt_approvals_identity_and_timestamps (test_ep_release_readiness.PreparationGateTests.test_receipt_approvals_identity_and_timestamps) ... ok
test_structurally_complete_fixture_is_prepared_not_published (test_ep_release_readiness.PreparationGateTests.test_structurally_complete_fixture_is_prepared_not_published) ... ok

----------------------------------------------------------------------
Ran 21 tests in 0.619s

OK
```


## 10. Fuentes fijadas y reconciliación aislada parcial — nuevo checkpoint

### 10.1 Continuidad y custodia

Se conservan íntegros los 102043 bytes de §§1–9 (SHA-256 e199c50dfceff2d383f4a5f5e2f26da214ea06576417e38a76ebd7123f6f7667). El ZIP de §9 no se regeneró ni ejecutó y las 21 regresiones de su validador no se repitieron. La asistencia verificó posteriormente su recepción física; el NOT_VERIFIED original de transferencia conserva su contexto histórico.

Objeto canónico adquirido: OEP v0.3.10 / VCU-EP-v12, metodologia docs/metacanon-objetos-20261011, commit 16913e74ac8078b6cf77d49391dde6feb7beb91b, blob df1ccf65acee1b2854e55b5468441b6ef89ecfd6. Su §81 registra recuperación histórica reportada por operador y preparación sintética del helper; no demuestra autenticación de la copia Git actual, vigencia de proveedores, nueva llave custodiada, activación ni volumen. Constructor no tomó intervención de host/bóveda; Remote Desktop Commander continuó deshabilitado. Claudia conserva escritura de OEP.

### 10.2 Adquisición sin credenciales nuevas

Main comprobado: dbc73afada1ad29abf46f4599d22cc3158a9a986. Fuentes conservadas: producto #292 en 6738c1f1aeffe5835a725531e0774d4420af13c5 y validador en 93cbcb2845239274f6ee03fe149b526e4a624238. Se descargaron exclusivamente URL por archivo entregadas por el conector, fijadas a esas revisiones. Se verificó tamaño, Git blob SHA-1 sobre bytes crudos y SHA-256; subárboles compartidos solo se reutilizaron con igualdad de Git tree SHA en el mismo path. No se extrajeron tokens para otros destinos, no hubo login/secretos nuevos y los recibos saneados no contienen URL firmadas.

Git directo sin credencial abortó con terminal prompts disabled y el tarball anónimo devolvió 404. Esto no se presenta como bloqueo universal: la adquisición por conector funcionó. URL iniciales caducadas devolvieron 404; refrescar exactamente el listado de origen resolvió los errores de archivos conocidos. No se confundió caducidad de URL con ausencia de fuente.

Checkpoint de adquisición: main 381 archivos verificados, #292 114 y validador 364; cifras por revisión, no suma de archivos únicos. Los listados conocidos no están completos: quedan 79 directorios frontera no enumerados en main/validador y 41 en #292; recursión puede descubrir más hijos. No se declara clon completo ni modos Git reconstruidos. Se difirieron logs, diagnósticos y datos/bóveda potencialmente privados, sin descargarlos por inferencia. El inventario exacto pendiente acompaña el recibo, no sustituye OEP.

### 10.3 Diff autorizado aplicado sobre copia aislada

Copia congelada parcial desde main, 380 archivos de fuente, fingerprint SHA-256 4b0f905e24153a62daf6b58fb695d3341a457fb3378362d80cf07f74118b36de. Regla de huella: SHA-256 del JSON compacto ordenado path→SHA-256 de cada archivo; excluye node_modules y cachés. No es un Git tree SHA ni el hash de un ZIP. Cuatro archivos adquiridos después de congelar esta copia no se atribuyen a ella.

El patch conservado pasó apply-check y se aplicó; cambió exactamente cinco rutas: ep-integrity-manifest.sha256, tests/validate_ep.py, tests/ep_release_readiness.py, tests/test_ep_release_readiness.py y tests/README-EP-READINESS.md. package.json, package-lock.json y ejecutor unitario permanecen byte-identical a sus blobs. No se aplicaron #292 completo, las nueve correcciones causales ausentes ni A/B/local/C.

Un primer apply-check rechazó tres destinos de altas que la preparación había precopiado. No se aplicó el patch allí. Se registró la causa, se conservó esa copia y se corrigió en directorio único nuevo: preflight exige que los destinos /dev/null estén ausentes. Apply-check/aplicación posterior PASS. No hubo borrado, reset, cambio de rama ni mutación remota.

**Integridad global: BLOCKED.** La copia congelada registra 335 rutas manifestadas ausentes y 47 divergencias de hash presentes; cobertura obligatoria sin faltantes. Este resultado sustituye únicamente la medida de esta nueva copia, no reescribe el recibo histórico de 592 ausentes. Todas las 47 divergencias presentes coinciden con Git blobs de main fijado: no son daños de descarga. El manifiesto vigente se modificó por última vez en 7afe575cc48532ce039a3ff40b368dc755f46795 (2026-10-07), mientras fuentes del host y ep.ts tienen cambios posteriores comprobados. Tabla exacta contiene hash esperado, blob observado, SHA-256 y tamaño por ruta. No se actualizaron esas 47 entradas para forzar PASS, ni se tocaron hashes de los 335 faltantes. La procedencia byte a byte no sustituye revisión de intención/alcance ni cobertura completa.

### 10.4 Comprobaciones nuevas, separadas de aceptación

- 69 pruebas existentes PASS en 13 archivos sobre contratos/funciones adquiridos; ejecución con dependencias fijadas y defaults sintéticos del setup existente. Fuentes de ese ensayo no cambiaron durante ejecución. No es prueba de identidad local ni red/host reales.
- 12 pruebas existentes PASS sobre edición in situ y aserciones estáticas de SQL normativo/scopes, en la copia aislada. No se aplicó SQL ni se ensayó rollback/restauración. No se repitieron las tres pruebas de producto ya entregadas ni las 21 regresiones del validador.
- Sintaxis de 219 archivos TypeScript/JavaScript con TypeScript 5.9.3: sin errores de transpilación sintáctica. No es typecheck semántico, build completo ni ejecución de aplicación.
- Parseo AST de 26 archivos Python adquiridos: sin errores; no acredita módulos que faltan ni ejecución de host.
- Validador existente conserva compuerta global; no se llamó a las comprobaciones estáticas internas saltando el rechazo de integridad. No hubo Vercel, workflows productivos, push ni merge.

### 10.5 Pendientes y siguiente acción por ruta crítica

Trabajo independiente todavía abierto: completar adquisición finita por listados/árboles fijados (reutilizando blobs y sin repetir pruebas vigentes), contrastar intención de divergencias del manifiesto con cambios exactos, preparar únicamente reconciliación autorizada y repetir solo compuertas afectadas sobre nueva copia identificada. Este checkpoint no acredita agotamiento de todo trabajo independiente.

Compuertas humanas/materiales siguen siendo las existentes de §§3.5–3.6, 4.4 y 8.6: aprobación específica de identidad/capacidades/custodia/concesión offline; cookies y revocación total por usuario con cierre ordinario/emergencia; alcance técnico prepare-only del arranque; admisión de host/cifrado/recursos y base PostgreSQL aislada para 016/017/021; recuperación del ZIP causal para cotejar sus nueve correcciones; instrucciones/versiones/licencias del laboratorio WordPress. No se solicita revocación selectiva, migración por defecto ni exclusiones de capacidades.

Pronóstico: próximo hito técnico = adquisición completa admitida y reconciliación de manifiesto sobre una copia exacta, antes de build/regresiones afectadas. No hay duración medida fiable para la recursión pendiente; no asignar minutos ficticios. Revisión humana, host/custodia y recuperación causal son esperas separadas. Cierre integral permanece sin fecha defendible hasta esas admisiones y los ensayos de persistencia/restauración/residuos; no solo queda Vercel.

El archivo completo actualizado se adjunta recuperable. La presencia de esta versión §10 en Descargas PC-14 queda PENDIENTE de cotejo por asistencia; no se atribuye a la recepción ya comprobada de §9. El paquete/recibo históricos permanecen completos y separados.

## §11 · Continuación GitHub: manifiesto causal y recuperación acotada de bóveda

### 11.1 Alcance y custodia

Conservados íntegramente §1–§10 y los paquetes anteriores. Constructor: código/copia aislada; asistencia: objeto canónico de persistencia de entorno, host y bóveda. Remote Desktop Commander continúa deshabilitado. Sin push, merge, publicación, SQL real, acceso a PC-14, importación de secretos ni aplicación de políticas A/B/local/C. El silencio solicitado al operador no significa vigilancia permanente ni ejecución indefinida.

Base técnica fijada: main `dbc73afada1ad29abf46f4599d22cc3158a9a986`; PR292 `6738c1f1aeffe5835a725531e0774d4420af13c5`; fuente de validador `93cbcb2845239274f6ee03fe149b526e4a624238`. El código y los recibos de §10 no se sustituyen con evidencia de esta copia ampliada.

### 11.2 Pendiente técnico retirado

Copia ampliada congelada: 540 archivos, huella anterior al delta `8c5e32cdbf5b5ffc92677cdd75b4113a34ce385c9205916062e8a030539fbf67`. Aplicación de patch autorizado de cinco rutas: check/apply conformes. Antes de nueva conciliación, el validador existente rechaza 202 archivos faltantes y 59 divergencias: no se suman ni comparan como aceptación con los 335/47 de §10.

Conciliadas exclusivamente cinco líneas de `ep-integrity-manifest.sha256`, sin cambiar sus fuentes:

| Fuente retenida | Último cambio de ruta comprobado | Intención del cambio existente |
| --- | --- | --- |
| scripts/khora/khora.ps1 | 8c7a8b5a6c74e00a1c57a5d001855c7361228407 | rutas de trabajo Fila4 sin suplantación de identidad |
| scripts/khora/modules/00-config.ps1 | 5dc82b536525c546542509db9694293f6da1885c | endurecimiento BitLocker y reutilización de credenciales de host |
| scripts/khora/modules/08-deps.ps1 | 5dc82b536525c546542509db9694293f6da1885c | mismo cambio existente |
| khora-web/lib/server/ep-bootstrap-content.ts | 5dc82b536525c546542509db9694293f6da1885c | bootstrap sincronizado en ese cambio existente |
| ep-medio-architectura.md | 5dc82b536525c546542509db9694293f6da1885c | referencia documental de ese cambio existente |

Cada fuente coincide en tamaño, Git blob y SHA-256 con main fijado; el recibo conserva huellas esperadas anteriores y nuevas. No se rehashó globalmente ni se rellenaron faltantes. Esta conciliación no ejecuta BitLocker, no activa las rutas históricas ni aprueba políticas nuevas.

Resultado: quedan 202 faltantes y 54 divergencias. Huella de la copia después de la corrección: `ebecc937c2f8a6eaf32f5aea1fae48d3e7c026e263e4d25adf05d31bd6019335`, SHA-256 del mapa JSON ordenado ruta→SHA-256 de archivos, excluyendo caché; no es un Git tree ni hash de ZIP.

Pruebas causales con el validador EXISTENTE: manipulación sintética de 00-config rechazada y bytes restaurados; eliminación de cobertura de `khora-web/scripts/run_unit_tests.mjs` rechazada, manifiesto restaurado y cotejado. La primera prueba no se repitió al corregir el nombre supuesto del runner. Error de ruta registrado: la prueba inicial se detuvo antes de ensayar cobertura, nunca se reportó como PASS global. No se repitieron las 21 regresiones anteriores.

### 11.3 Fuentes pendientes: no confundir conectividad con integridad

Adquisición por conector y descargas exactas emitidas por él, sin extraer/reutilizar tokens para otro destino. Índice sanitizado y cola de directorios conservados por revisión. Un HTTP 404 con URL temporal envejecida no demuestra archivo ausente: renovar el listado contrato recuperó ocho archivos y comprobó sus blobs. Los otros enlaces vencidos requieren renovación acotada, no reconstrucción del contenido ni otra auditoría.

`kernel/src/khora_kernel/data/personalqa.json` quedó explícitamente diferido sin descargar sus bytes; asimismo secretos, datos operativos y logs excluidos. No rebajar el perfil para quitar esos faltantes: adquirir material privado requiere destino protegido/admisión que no se infiere de acceso GitHub.

Trabajo todavía automatizable: completar directorios admitidos, verificar cada blob, adquirir intenciones de divergencias restantes, conciliar únicamente lo justificado y ejecutar compuertas afectadas. No afirmar agotamiento del trabajo independiente ni candidata íntegra por esta entrega.

### 11.4 Recuperación por correo: objetos distintos

| Objeto | Mecanismo observado | Lo que NO demuestra |
| --- | --- | --- |
| Archivo env-vault | PBKDF2-HMAC-SHA256, 200000 iteraciones, claves de contenido derivadas directamente de llave; AES-CBC/PKCS7 + HMAC; rotación existente necesita llave anterior | recuperar ciphertext por reset de hash o por conocer el email |
| Agente local de bóveda | custodia temporal/local de llave con protección Windows DPAPI del perfil | recuperación independiente del perfil/máquina/volumen, o envío seguro de llave por correo |
| Bóveda del navegador lib/crypto.ts | clave de datos aleatoria con envolturas AES-GCM por PIN y código aleatorio de recuperación; resetPINWithRecoveryCode conserva la clave de datos | compatibilidad con archivo env-vault, correo integrado o persistencia fuera de localStorage |
| Contraseña maestra EP propuesta en PR292 | verificador scrypt; cambio autorizado por sesión OpenID Connect y email permitido | descifrado o recuperación de env-vault; tampoco prueba autenticación reciente/multifactor del proveedor |
| PIN servidor/api boveda | hash PIN/sello y reset autorizado por sesión/email | recuperación de ciphertext del archivo ni prueba de email_verified/autenticación multifactor reciente |

Fuentes exactas: env-vault blob `46efce0ff43c400bccdee11f02de5bc2ddd21e4c`; crypto navegador `c9fc91d08c95685c7223fdbeeb7044324a9018ba`; agente `b03f1edfaf3243ed9545b687fea11490f23178f7`; verificador EP `6e8025df4d0a3691128c39f1772915052e6f7089` y ruta de cambio `5975baefdb297003b7e2a1b211f2484e4a6ade75`. Primeros tres de main fijado; dos últimos de PR292 fijado, no aceptados/integrados por inferencia.

La recuperación real de nueve entradas recifradas es evidencia REPORTADA y custodiada por asistencia, no reejecutada aquí. No autentica proveedores ni configura todo el runtime. Asistencia contrastó cinco nombres requeridos —AUTH_SECRET, OIDC_ISSUER_URL, OIDC_CLIENT_ID, OIDC_CLIENT_SECRET, DATABASE_URL— ausentes de ese inventario histórico; ello no prueba ausencia en otros almacenes autorizados. Plantilla SMTP no acredita recuperación criptográfica. El defecto UTC/local observado correspondía al helper de metadata/cleanup; Import-KhoraTemporaryVaultAccess ya usa RoundtripKind.

### 11.5 Recomendación única condicionada: reutilizar custodia existente antes de migrar formato

Recomiendo verificar y, SOLO tras aprobación específica, reutilizar un custodio cifrado existente e independiente del entorno a recuperar para conservar el material de recuperación del archivo. Conservar de entrada el codec y la rotación existentes; no construir servicio email ni migrar formato ahora.

LastPass figura únicamente como antecedente en la doctrina de entorno con llave física; no se verificó cuenta actual, relación con `the.willfreeman@gmail.com`, plan, controles o recuperación habilitada. Es candidato a cotejo, NO proveedor seleccionado/configurado. La documentación oficial distingue verificación por email de recuperación automática disponible para combinaciones de dispositivo/navegador previamente admitidas; reset de cuenta vacía el contenido. No prometer recuperación por email desde cualquier host basándose en ese antecedente.

Email = canal de autenticación/verificación o notificación; nunca enviar llave, código de recuperación, contraseña maestra ni secretos por email. La custodia y su propia recuperación deben funcionar fuera de PC-14, del perfil EP, de la bóveda y del volumen cuya pérdida se ensaya. Evitar circularidad: correo o gestor accesibles únicamente con un secreto dentro de la misma bóveda; llave de BitLocker solamente dentro del gestor que requiere el volumen; material únicamente en localStorage/DPAPI del host perdido.

Con codec actual, “sin conocer la llave anterior” significa que el operador la olvidó pero un custodio previamente admitido conserva material capaz de descifrar. No significa recuperar matemáticamente una llave que no existe en ningún lugar. Si se exige que nadie conserve la llave anterior, habría que aprobar una envoltura de clave de datos por material independiente y la migración correspondiente; el patrón del navegador no se adapta al archivo silenciosamente.

Alternativa si no se admite custodio: segundo secreto de recuperación independiente, de alta entropía y con conservación fuera del entorno; no es recuperación basada únicamente en email. Ninguna alternativa está implementada o aceptada.

**Decisión material exacta:** ¿admitir custodia criptográfica independiente con acceso/recuperación mediante la cuenta de correo especificada y controles verificados, aceptando el riesgo del custodio y del correo, o exigir un segundo secreto independiente? Después debe aprobarse el proveedor/cuenta, controles, material custodiado y prueba concreta; no ampliar permisos o costos por defecto. No se solicita respuesta mientras el operador está ausente.

### 11.6 Aceptación futura, todavía no ejecutada

1. Fixture sintética y copia recuperable intacta: enrolar material de recuperación antes de olvidar la llave; proteger archivo, backups, envolturas y custodia según alcance aprobado.
2. Retirar la llave anterior del conocimiento/input del operador y simular pérdida del host/perfil; autenticar recuperación por ruta admitida, sin transmitir material secreto por email.
3. Descifrar contenido anterior con material recuperado, comparar íntegramente valores en memoria, rotar/reproteger con nueva llave, verificar todas las entradas y apertura posterior. Un reset que produce bóveda vacía no satisface aceptación.
4. Rechazar identidad incorrecta, material incorrecto, replay/expiración aplicables y ciphertext alterado. Probar interrupción antes/después de reemplazo: original y copia conservados, rollback utilizable; comprobar residuos y limpieza sin pérdida silenciosa.
5. Ensayar revocación de acceso de recuperación y sustitución del material conforme a política aprobada. Una copia offline vieja no deja de ser descifrable por revocar acceso online: declarar ese límite, retención y rotación de credenciales de proveedor por separado. No atribuir efecto retroactivo a eliminación local o reset PIN.
6. No borrar/activar la única copia recuperada hasta sustituta funcional comprobada, admisión del host/recursos y target exacto autorizado. Borrado local no reescribe Git, backups ni invalida claves de proveedores.

### 11.7 Continuidad integral

Mantener el alcance de migraciones 016/017/021 delimitado en las secciones anteriores: secuencia, esquema/idempotencia/rollback pendientes del ensayo aislado admitido; las pruebas de texto SQL no son ejecución ni reversión demostradas. Paquete causal aún faltante bloquea cotejar sus nueve correcciones, no adquirir fuentes públicas/admitidas. Contratos local-web y seguridad A/B/local/C, listener/origen, cifrado/persistencia/restauración/cierre, host protegido, WordPress/activos licenciados y aceptación de perfil mantienen sus compuertas.

Ruta crítica técnica inmediata: adquisición permitida → intención por divergencia → copia identificada reconciliada → comprobaciones afectadas; separada de revisión humana de custodia/políticas, host, recursos aislados, paquete causal y activos. Sin plazo medido defendible de cierre integral; no estimar tiempos de espera humana ni afirmar “solo falta Vercel”.

### 11.8 Comprobación independiente adicional

Ejecutados siete archivos existentes de contratos puros/mock del kernel: constructor de apps, gestor de tareas, ingesta de archivos, memoria organizada, modelo de lenguaje, contrato de propuesta y transcripción. **21 casos PASS**, exit 0, fuentes sin cambio, 0.741 s medidos de proceso. Son OTROS 21 casos: no las 21 regresiones históricas del validador ni repetición de las 69+12 pruebas de §10. Fixtures Neo4j no solicitadas, sin conexión a base ni secretos en entorno del proceso. Dependencias públicas de ensayo instaladas en entorno temporal separado, freeze conservado; no prueba del host, cifrado, proveedores o integración integral.

Fuentes de las distinciones criptográficas: codec/rotación existente del archivo[^https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/scripts/khora/env-vault.ps1], envolturas separadas de clave del navegador[^https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/khora-web/lib/crypto.ts], custodia local del agente[^https://github.com/SeryMente/khora/blob/dbc73afada1ad29abf46f4599d22cc3158a9a986/tools/vault-agent/vault_agent.py], verificador y ruta maestra de PR292[^https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/lib/server/ep-master-password.ts][^https://github.com/SeryMente/khora/blob/6738c1f1aeffe5835a725531e0774d4420af13c5/khora-web/app/api/ep/master-password/route.ts].

LastPass: antecedente histórico únicamente en <mention url="https://app.notion.com/p/0c0a4187824183a68e1601753d250065">Doctrina del entorno persistente con llave física</mention>[^https://app.notion.com/p/0c0a4187824183a68e1601753d250065]. Recuperación oficial condicionada a capacidades existentes del dispositivo/navegador y controles de cuenta; reset vacío no conserva el contenido[^https://support.lastpass.com/s/document-item?language=en_US&bundleId=lastpass&topicId=LastPass%2Frecover-master-password.html]. No se verificó ni configuró una cuenta real.


## §12 · Representación Git canónica, procedencia y cierre acotado de cobertura

### Resultado probado, sin aceptación integral
Se preserva íntegro el prefijo §1–§11: 123312 bytes, SHA-256 a66e276104d40d33eeb9bd8b454c1242350e3dd2e3089a1cc08253a6a3c0aace. Los árboles y pruebas congelados anteriores no se sustituyen ni se transfieren a esta copia. No se regeneró un ZIP.

Sobre main dbc73afada1ad29abf46f4599d22cc3158a9a986 se preparó otra copia aislada de 603 archivos (600 fuentes admitidas al corte y tres adiciones del parche autorizado). Aplicación del parche original: apply-check y apply conformes; sintaxis Python de 137 archivos conforme. Árbol bruto previo: 8b4dc90764ea0fb7f0fa28668521c02760ddbde7d7ff220cab41305a64bd23b1; rechazo global: 144 ausentes y 67 divergencias.

### Causa concreta: blob Git no equivale a bytes de checkout
La .gitattributes existente prescribe scripts/khora/**/*.ps1 text eol=crlf. Quince aparentes divergencias del manifiesto coinciden exactamente con su conversión CRLF, sin diferencias de contenido. Se verificaron los blobs brutos y se materializaron 23 archivos PowerShell conforme a esos atributos; los blobs originales permanecen separados. El Git auxiliar solo consultó atributos: no es un clon, no acredita HEAD, permisos, modos ni host.

Las cinco correcciones de huellas previamente justificadas se expresan ahora sobre los bytes de checkout: tres PowerShell necesitan CRLF; el archivo TypeScript y el documento conservan sus bytes. La §11 sigue describiendo su copia bruta; no se debe trasladar su compatibilidad a un checkout de Windows. Copia tras esta reconciliación: 113b8a6a6913db6901dd445cbfcf9e87ff1c0f37f26a1cbba9449bd1336b2e50. Rechazo: 144 ausentes y 47 divergencias. Alteración sintética de 00-config y eliminación de cobertura del ejecutor run_unit_tests.mjs detectadas; bytes restaurados y rechazo base idéntico.

### Cuatro divergencias intencionales probadas y dependencia antes sin cobertura
Se recuperaron versiones anteriores de cuatro archivos y cotejaron sus blobs; las cuatro huellas antiguas del manifiesto coinciden exactamente con los bytes CRLF históricos. Producto #292 y main contienen los mismos bytes actuales de esas cuatro rutas.
- 07-git-wip.ps1: commit 1f46b5e627c66e9de4b197e54d8de68f53265369; ruta de repositorio explícita y continuidad de repositorios seleccionados.
- 13-session.ps1: mismo commit; selección y materialización de repositorios, etapa EP-IN-075 y registro de selección en manifiesto de sesión.
- khora.barrel.ps1: mismo commit; carga explícita del módulo existente 16-oep-workspace.ps1.
- 11-cleanup.ps1: commit 97f9f66695452d9b9f365cadcfd5d6128101f83a; retirar enlace Desktop/EP antes de desmontar.
Las versiones anteriores cotejadas son 2c192a5aaf0e8c4812fc68c6700f5c65e251a83b para los tres módulos y 155c9629928c74527f0a4cb3e0272cc3e70757ec para el barril. No se infirió intención del mensaje de un commit que no hubiera cambiado esa ruta.

En una copia separada se actualizaron únicamente esas cuatro huellas, se añadió cobertura del módulo 16 ya cargado por el barril y se extendió la lista requerida del verificador existente a esa dependencia. Se actualizó la huella del propio verificador por su diff exacto. No se escribió código de ejecución PowerShell ni nuevas políticas de identidad, revocación, custodia o arquitectura. El parche mínimo pasa apply-check sobre la copia base preservada. Pruebas negativas: retirar módulo 16 o ejecutor unitario del manifiesto produce INTEGRITY_COVERAGE_MISSING; restauración cotejada. Sintaxis del verificador Python conforme.

Copia identificada: 24151e74756609482a58080939bb0eaca56f9027b05f509ca42f0bee1b07acee, 603 archivos; rechazo global conserva 144 ausentes y 43 divergencias. NO candidata integrada, NO preparación integral. Es huella SHA-256 del mapa ordenado ruta→SHA-256, no Git tree ni hash ZIP. El arranque histórico conserva una etapa productiva EP-IN-080: no se ejecutó ni se presenta como prepare-only admisible; su aislamiento sigue condicionado a las compuertas existentes.

### Adquisición posterior separada y comprobaciones incrementales
Índice posterior al corte: main 609 fuentes verificadas/618 conocidas; producto #292 409/418; validador 592/601. Fronteras todavía abiertas: 55/64/56 directorios, incluyendo áreas diferidas; no equivalen a pendientes totalmente admitidos. Errores de descarga actuales: cero. No se traslada este avance a las copias congeladas.
Los dos pending del recibo histórico se identificaron, sin descargar su contenido: kernel/src/khora_kernel/data/personalqa.json en producto y validador, blob 0d1bef003c6360c1818bc66f6d19000f90bfd0c8, 60761 bytes. Se clasificaron deferred-private-review, no aparecen en caché ni árboles adquiridos. Ahora existen nueve diferidos por revisión; se preserva el recibo histórico con ocho diferidos más uno pendiente donde correspondía.

Sobre las fuentes main posteriores: TypeScript 5.9.3 comprobó sintaxis de 62 entradas adicionales, cero errores; 219 entradas iguales por SHA-256 reutilizadas, no reejecutadas. Sintaxis no acredita tipado semántico, build, servicios ni aceptación. No se repitieron las 21 regresiones históricas ni los 21 contratos kernel.

### Gobierno, límites y checkpoint
Fuente documental actual adquirida: OEP v0.3.16 / VCU-EP-v18, commit c30eabea7c33e661a302c58c62dfdbed43bcdc4d, blob 7dd72806824c9abbe58a5d42d3d81729a7500501, 211501 bytes cotejados. Asistencia sigue única escritora de OEP/host/bóveda. El error de opción --no-index se registró y corrigió; el read-back del registro refleja pruebas y estado residual.

Siguiente trabajo: consumir directorios admitidos de la cola fresca por blobs exactos, explicar las 43 divergencias restantes antes de corregir huellas, incorporar únicamente fuentes admitidas a una copia nueva identificada y comprobar solo cambios causales. Las 144 ausencias incluyen material no admitido: no borrar entradas para forzar PASS. El causal sigue bloqueando el cotejo de sus correcciones, no toda adquisición.
Persisten decisiones de A/B/local/C, recuperación/custodia por correo, admisión de host y recursos, pruebas reales de migración 016/017/021 y su rollback, cifrado/restauración/cierre, WordPress/activos y aceptación integral. Ningún ensayo SQL real, operación de host, secreto, push, merge, publicación o Remote Desktop Commander. Próximo hito defendible: retirar fuentes admitidas e intenciones pendientes; no hay duración medida para el cierre integral ni agotamiento del trabajo independiente. Informes al operador suspendidos hasta su retorno.
