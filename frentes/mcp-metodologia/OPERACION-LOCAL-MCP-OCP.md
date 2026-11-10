# Operación local · MCP-OCP

**Estado vigente al corte 2026-11-10:** núcleo documental MCP-OCP v0.1.28 en rama candidata; backlog v0.8; DUG actual de main Samantha v387/NX-387m (blob c8d37d92aed7ff9d4fe94e7a9541e76ba5c88a2c); objetivo de software MCP-OCP 1.0.0. El candidato Sink P004 por STDIO ya está escrito en la rama; build, ejecución de pruebas y paquete siguen pendientes. El panel de observabilidad permanece especificado pero no implementado. La candidata 0.1.0 que se describe aquí es evidencia histórica; la identidad/ruta del entorno temporal no se conserva y el paquete no está disponible en este repositorio.  
**Arquitectura:** proceso MCP stdio local; el cliente inicia y administra el proceso. No hay listener TCP/HTTP ni endpoint público.  
**Fuente de verdad documental:** [MCP-OCP · núcleo](MCP-METODOLOGIA.md) y [lista provisional de tareas](LISTA-TAREAS-PROVISIONAL.md).  
**Separación:** este servidor pertenece exclusivamente a MCP-OCP en Metodología. No es Khora MCP ni el bridge de Jules.

## 1. Artefacto local verificado

- ZIP: `ocp-mcp-0.1.0-win-x64.zip`.
- Ruta de generación: NO CONSERVADA; perteneció a un entorno temporal que no forma parte del estado actual.
- Tamaño: 39.713.025 bytes.
- SHA-256: `37b85444534e20fcc51eeb10688ed99577bdde020576783273723ebd93cdbe76`.
- Entry point: `OcpMcp.exe serve`.
- Commit y rama local de esa candidata: datos técnicos históricos sin ref remoto verificable para recuperarlos desde `main`; no asumir que el árbol local continúa disponible.
- SDK: .NET 10.0.403; publish self-contained `win-x64`; target `net10.0`.
- Manifiesto SHA-256: `ddc9967bf01afd5fc9c1f72cf836f0c5ad064daceaab07e9f99e91f003d348a8`.
- Manifiesto de fuentes SHA-256: `0980946c1c16d0f5b0cdb4f29dc0fc5d794015165878d3ccd3198616e07ab9ac`.
- Fuentes históricas: DUG v377 y núcleo MCP-OCP v0.1.20. Esos pins son obsoletos para el trabajo actual.

## 2. Pruebas observadas

- 50/50 pruebas unitarias PASS.
- 30/30 pruebas de integración/smoke stdio PASS.
- 200/200 componentes publicados cotejados tras extracción y hash.
- ZIP/manifest SHA-256 verificados.
- La prueba independiente del ejecutable empaquetado confirmó `initialize`, `tools/list` (10 tools), `get_health=READY`, `transport=stdio`, `MCP-NORMATIVO=DESACTIVADO` y cierre limpio.
- La prueba interactiva vía RDC envió JSON-RPC directamente al proceso local y recibió initialize, tools/list y get_health. Se hizo con `OCPMCP_TEST_MODE=1` y una base de prueba temporal, no con la base de producción/perfil del operador.
- Escaneo estático de fuentes C# sin referencias a `TcpListener`, `HttpListener`, `System.Net.Sockets`, `WebApplication`, `Kestrel` o `HttpClient`. Esto es una verificación estática acotada, no una auditoría exhaustiva de seguridad.

## 3. Extracción y configuración de un cliente MCP stdio

1. Extraer el ZIP en una ruta estable del perfil del usuario. No es necesario instalar un servicio Windows ni abrir firewall/puertos.
2. Confirmar el hash SHA-256 antes de utilizar el ejecutable.
3. En un cliente MCP que admita servidores locales stdio, registrar un servidor con el comando absoluto al ejecutable y argumento `serve`. Ejemplo genérico (sustituir la ruta por la elegida):

```json
{
  "mcpServers": {
    "ocp-metodologia": {
      "command": "C:\\OCP\\MCP-OCP\\0.1.0\\OcpMcp.exe",
      "args": ["serve"]
    }
  }
}
```

El cliente debe lanzar el proceso y mantener sus pipes stdin/stdout. El servidor escribe JSON-RPC en stdout y diagnósticos en stderr; no debe envolverse con scripts que escriban banners, progreso o transcript en stdout.

La configuración anterior es un ejemplo de contrato stdio genérico, no una configuración ya instalada en una aplicación concreta. No acredita conexión MCP nativa de ChatGPT Free. En el perfil RDC actual se comprobó el transporte enviando JSON-RPC mediante la sesión terminal de RDC; no se declaró un conector nativo adicional de ChatGPT.

## 4. Primera inicialización de datos y fuentes

La build 1.0.0 debe aceptar un root de datos explícito configurado por EP y validarlo antes de crear DB, claves, fuentes, logs o backups. La candidata histórica usaba `%LOCALAPPDATA%\SeryMente\OCP MCP`; ese default no se hereda como configuración de release. El root real debe quedar fuera del checkout y dentro de un volumen con protección efectiva verificada por EP. La ubicación y el proveedor concretos se fijan al implementar MCP-OCP-02/05; no se inventa una ruta de host.

La primera inicialización debe hacerse sobre el perfil Windows que será titular local. Para importar las fuentes canónicas del manifiesto, ejecutar desde consola visible:

```powershell
OcpMcp.exe import-sources --repo-root "C:\\RUTA\\AL\\CLON\\SeryMente\\metodologia"
```

El clon debe contener los commits/blobs fijados en el manifiesto y una referencia `origin/main` actualizada. El importador valida commit, Git blob SHA-1 y SHA-256 del contenido antes de cifrar fuentes mediante AES-256-GCM y DPAPI CurrentUser. No se conecta a un endpoint público para importar fuentes.

El orden recomendado es: importar fuentes; configurar el cliente MCP stdio; iniciar `serve`; verificar `get_health`, `list_canonical_sources` y `get_principle_catalog`.

## 5. Compuerta de operador y escrituras protegidas

**No ejecutar automáticamente la provisión de operador.** Requiere una consola interactiva y una confirmación escrita de forma explícita. Cuando el propietario decida activar el trust root local, ejecutar:

```powershell
OcpMcp.exe provision-operator
```

El programa muestra la cuenta/SID actual y solicita escribir exactamente `REGISTER <SID>`. Esto crea la raíz de autorización local, una clave HMAC y una clave Ed25519; las claves privadas se protegen con DPAPI CurrentUser. No se ha realizado esa operación en el ciclo de build.

El release 1.0.0 no expone herramientas MCP de escritura ni botones de autorización en el panel. La UI es solo de observación. La única provisión local de identidad que pudiera requerir el bootstrap se mantiene interactiva: el operador presente revisa el perfil y confirma explícitamente `REGISTER <SID>` en consola. No automatizar ni inyectar esa confirmación por pipes, variables de entorno o scripts desatendidos.

## 6. Estado normativo

- `MCP-NORMATIVO: DESACTIVADO`.
- El catálogo expone los 43 identificadores y MDP, pero cuatro grupos de metadatos de aplicabilidad siguen sin fuente canónica completa; la selección normativa permanece fail-closed.
- El texto normativo completo no se expone por el catálogo sin una selección/liberación gobernada.
- Sink local está autorizado directamente por el operador, pero aún no está implementado ni desplegado.
- Un health status READY acredita base/backup operativo, no significa que las fuentes estén importadas, el operador esté provisionado ni que la evaluación normativa esté habilitada. Verificar por separado `operator_provisioned`, `principle_selection_readiness` y `normative_engine`.

## 7. Relación con Khora y Jules

- MCP-OCP: este proceso local, exclusivo del OCP de Metodología.
- Khora MCP: servidor central independiente `/api/mcp`.
- Jules: cliente bridge RDC/stdio en Khora, autenticado con OAuth 2.1/PKCE tras consentimiento explícito. `JULES_API_KEY` permanece exclusivamente en Khora Production.
- No se comparte proceso, endpoint, clave, token, ACL ni control entre los productos.
- Las tareas documentales del OCP MCP-Jules se configuraron en su rama PR #19; el operador indicó pausar su uso hasta reanudar. No se creó sesión Jules ni se hizo OAuth real en esta validación.
- La coexistencia end-to-end MCP-OCP + bridge Jules no se declara probada.

## 8. Límites actuales

- **Construido/probado históricamente:** sí, en un entorno temporal y con base de prueba aislada.
- **Paquete anterior:** fue generado según el recibo histórico, pero su ubicación temporal no se conserva y no se puede recuperar de este repositorio.
- **Instalación en el perfil real del operador:** no ejecutada.
- **Provisión del operador / importación de fuentes en su base real:** no ejecutadas.
- **ChatGPT Free como cliente MCP nativo:** no verificado; se comprobó uso local de stdio a través de RDC.
- **Integración con Jules E2E:** pendiente y pausada.
- **Instalación en EP:** no ejecutada; depende del OEP/autoridad del host.
- **Restore PPR cross-host real:** no verificado; las 50 pruebas unitarias incluyen fixtures sintéticos.
- **PR/merge/release remoto:** no se ha realizado en este ciclo.

Próxima ejecución: recuperar o reconstruir el código con fuentes y pins actuales; implementar Sink; compilar, probar y empaquetar un artefacto nuevo. La instalación persistente y la provisión interactiva del operador son fases posteriores, no requisitos para el trabajo de código.


## 9. Estado actual · 2026-11-09

DUG: Samantha v386/NX-386m (blob `22dca684830a36dff019b47811d9b800cc9bea0a`). Núcleo documental: MCP-OCP v0.1.27; backlog v0.8; release de software objetivo: 1.0.0 (servidor + panel). Sink local por stdio y panel: AUTORIZADOS, no implementados ni desplegados. Acceso GitHub privado: conector autenticado de la conversación; `gh auth login` local no es requisito para operaciones del repositorio mediante conector. Destino de trabajo e instalación: terminal Fila 4, última referencia técnica Device ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`, perfil `CENTRAL\\fila4`/SessionId 4; no revalidado en vivo. La ubicación física y las rutas efectivas se resuelven en preflight. MCP-NORMATIVO permanece DESACTIVADO.


## 10. Instalación del release 1.0.0 dentro del checkout de Metodología · 2026-11-09

El ejecutable MCP-OCP 1.0.0 no se instala solo en LocalAppData. Se instala dentro del checkout local:

- Checkout: `SeryMente/Repositorios/Metodologia/metodologia/`.
- Carpeta: `frentes/mcp-metodologia/instalacion-local/`.

La carpeta contiene ejecutable MCP, runtime/dependencias, launcher, configuración de ejemplo, manifiesto/hash y subcarpeta `panel/OcpMcp.Panel.exe`; queda excluida de Git. DB SQLite, DPAPI, fuentes sensibles, logs operativos y backups quedan fuera del checkout en un root independiente protegido. No asumir protección de LocalAppData ni de un volumen con BitLocker suspendido.

Flujo: sincronizar checkout → verificar ZIP/manifest/SHA → extraer en esa carpeta → comprobar archivos/hash/read-back → establecer root protegido → importar fuentes DUG v386 y comprobar 43 IDs/MDP → verificar readiness real → solicitar consentimiento presente para `provision-operator` / `REGISTER <SID>` → configurar el cliente MCP STDIO/RDC → ejecutar pruebas de uso y cierre.

La entrega del paquete no prueba instalación. Un proceso activo o health READY de test no prueba fuentes importadas ni operador provisionado. La etiqueta `INSTALLED_AND_READBACK_VERIFIED` requiere ruta, versión, commit/blob, SHA del paquete y extracción cotejada. No abrir listeners/endpoints públicos; `MCP-NORMATIVO` sigue DESACTIVADO.


## 11. Panel local de observabilidad · release 1.0.0

Especificación funcional y visual: [PANEL-OBSERVABILIDAD.md](PANEL-OBSERVABILIDAD.md). Tarea de implementación: MCP-OCP-13.

El panel es una app de escritorio Windows WPF/C#, ligera y de solo lectura; no es otro cliente ni servidor MCP. No interviene en las pipes STDIO, no abre HTTP/TCP/localhost, no incorpora WebView2/Node/DB nueva ni herramientas de escritura. Su contrato de datos usa `monitor/session.json` (EP: sesión + atestación de protección con timestamp), `monitor/state.json` y `monitor/events.jsonl` (MCP-OCP: proceso, protocolo, fuentes y actividad), todos bajo el root protegido configurado por EP. El panel los lee; no recibe payloads ni contenidos de fuentes.

EP-TASK-005 escribe y coteja `session.json`, y abre la ventana como proceso hijo al confirmar que la sesión persistente está `ACTIVE`, y la cierra al finalizar esa sesión. Si el servidor todavía no está iniciado, la ventana permanece visible con “Sesión activa · esperando servidor”. Si el proceso MCP se detiene y EP sigue vigente, muestra “Servidor detenido/desconectado”; no intenta reiniciar ni controlar el proceso. Esta integración no modifica EP-TASK-003 ni añade heartbeat, polling o vigilancia general al dead-man.

**Vista principal:** estado global dominante; recorrido visual sesión → proceso → STDIO → fuentes → readiness; tarjetas de salud de proceso/protocolo/DUG/fuentes/operador/root; actividad actual y eventos recientes; una sola atención prioritaria. La vista debe ser clara en pocos segundos, con icono+texto+color, sin parpadeos, audio ni movimiento constante. No mostrar métricas sin datos reales.

**Estados no intercambiables:** proceso vivo, protocolo inicializado, fuentes importadas/íntegras/vigentes, operador provisionado, root protegido y readiness agregado. “Listo” solo cuando los gates requeridos están verificados. Payloads, texto de documentos, argumentos, resultados, tokens, claves y SID quedan fuera de la telemetría.

**Apertura y cierre son responsabilidad EP.** MCP-OCP construye el panel y entrega contrato, binario, schema, hashes y prueba; no instala ni opera procesos persistentes del host.

## 12. Rectificación del destino y piloto IPZ/SINK prioritario · 2026-11-10

La instalación de MCP-OCP deja de tener como destino PC 7. El operador designó **Fila 4**, el dispositivo correspondiente a la única sesión RDC disponible. No usar PC 7 como alternativa ni reutilizar su perfil/volúmenes. Últimos datos técnicos documentados (no revalidados en vivo): Device ID `d0bbb2a3-d7b4-45e1-8870-652c2c3844fc`, sesión interactiva `CENTRAL\\fila4`, SessionId 4. Confirmar identidad, SID, `USERPROFILE`, permisos y conexión antes de escribir. La ubicación física de Fila 4 no se infiere; EP decide CECEQ u otra ubicación y el dead-man aplicable.

**Rutas:**
- Checkout: `%USERPROFILE%\\Desktop\\SeryMente\\Repositorios\\Metodologia\\metodologia\\`.
- Piloto SINK:P004: `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\piloto-sink\\`.
- Release final 1.0.0 (servidor + panel): `<checkout>\\frentes\\mcp-metodologia\\instalacion-local\\`.
- Datos/DB/DPAPI/fuentes/logs/backups: `%USERPROFILE%\\Desktop\\SeryMente\\Datos\\Metodologia\\MCP-OCP\\`, fuera del checkout y dentro del volumen protegido verificado por EP.

**Preflight previo al uso real de fuentes:** la última lectura histórica de Fila 4 informó C: `FullyEncrypted/100 %`, `ProtectionStatus=Off`, `XtsAes128`; no acredita protección efectiva. Repetir en vivo y establecer workspace VHDX XTS-AES256/Protection On/100 %, protector recuperable en EP Vault, checkout completo y SHA/read-back. No importar DUG/MDP privadas, generar DB con fuentes, provisionar operador ni dejar runtime persistente antes de que EP valide checkout/root. El dead-man se implementa si Fila 4 está fuera de CECEQ; la ubicación debe comprobarse y no presumirse. No reutilizar W:/VHDX/DPAPI/RecoveryPassword de PC-14 ni de otros perfiles.

### Hito A — piloto de uso SINK:P004 con IPZ

1. MCP-OCP-02 crea rama nueva desde main y porta selectivamente los módulos reutilizables.
2. MCP-OCP-05 implementa el corte mínimo GOW:ARR → DUG → SINK:P004, con texto íntegro, ID/título, DUG v386/NX-386m, commit/blob y SHA-256.
3. MCP-OCP-03/04 prueban initialize, tools/list, tools/call:P004, errores/fuente no verificada y cierre limpio en STDIO/RDC.
4. EP-TASK-003/005 preparan Fila 4, checkout y root protegido; extraen el piloto solo después del gate y cotejan manifest/SHA.
5. GOV-TASK-007 prepara un candidato IPZ de menos de 1.500 caracteres y salvaguardas completas con secuencia GOW:ARR → DUG → MDP → SINK:Pxxx; primer caso P004.
6. La aceptación exige demostrar la invocación desde el contexto IPZ por la ruta RDC/STDIO y que la respuesta visible al modelo incluya pin/hash. Un smoke JSON-RPC desde consola no acredita ese E2E. La escritura/read-back nativos de IPZ son una acción separada; no se declara realizada aquí.

### Hito B — release 1.0.0

Tras el piloto P004, generalizar a P001–P043, lotes ordenados, integridad, telemetría y negativos. Construir MCP-OCP-13 WPF contra schema congelado, en paralelo con la generalización; sigue siendo obligatorio en el paquete final 1.0.0, pero no bloquea el piloto. Cerrar manifest/build/ZIP único servidor+panel, extracción/read-back, bootstrap y aceptación EP/Gobernanza.

**Estado:** ajuste documental verificado; no se ejecutó preflight, clon, instalación, importación, REGISTER, piloto ni E2E IPZ.



## 13. Ejecución del Hito A · candidato SINK:P004 · 2026-11-10

- **Main base de la rama candidata:** 73a42bc687f1fa3dd60b44af9cd93f797eba3920; compare main...branch confirmó ahead-only, sin commits detrás al corte.
- **Rama:** feat/mcp-ocp-p004-pilot-20261110-cycle02.
- **DUG:** Samantha v387/NX-387m; archivo fijado en commit 17a4da1d3906e2397ab4682ff46cc9a9f116f34d, blob c8d37d92aed7ff9d4fe94e7a9541e76ba5c88a2c. La referencia v386 en la sección 12 es antecedente y no se presenta como vigente.
- **Código candidato:** src/OcpMcp/OcpMcp.csproj, Program.cs, SourcePin.cs, DugSourceReader.cs y McpServer.cs. Implementa handshake clásico MCP `2025-11-25`, `notifications/initialized`, `tools/list`, `tools/call` y cierre MCP shutdown/exit más EOF; no implementa el protocolo stateless `2026-07-28`.
- **Pruebas:** tests/OcpMcp.Pilot.Tests; 12 escenarios escritos, aún no ejecutados.
- **Portabilidad:** las ramas integration/ocp-mcp-0.1.0-selective-20261101 y build/ocp-mcp-mvp-0.1.0 se inspeccionaron solo en lectura. Están divergentes respecto de main (592/911 commits detrás respectivamente al corte); no se fusionaron. Clasificación REUSE/ADAPT/REWRITE/DROP en piloto-sink/PORTABILITY-DECISIONS.md.
- **Ejecución:** `dotnet` no está disponible en el contenedor ni en el dispositivo RDC sondeado (`DOTNET=NOT_FOUND`). En el dispositivo RDC la sesión de proceso es `MantenimientoRCI`, no el perfil de operador Fila 4; no se escribieron archivos allí. No se ejecutó build, prueba ni instalación.
- **Resultado:** código y pruebas persistidos en rama; build/test/STDIO real pendientes. Sin paquete, sin instalación, sin DB, sin REGISTER, sin IPZ nativa, sin E2E, sin merge a main. MCP-NORMATIVO permanece DESACTIVADO.

