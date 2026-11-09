# Operación local · MCP-OCP

**Estado vigente:** MCP-OCP v0.1.22. Sink local por stdio está autorizado directamente por el operador, pero su implementación y paquete vigente todavía no están construidos. La candidata 0.1.0 que se describe aquí es evidencia histórica; la identidad/ruta del entorno temporal no se conserva y el paquete no está disponible en este repositorio.  
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

El servidor usa el directorio de datos del usuario actual:

- Base SQLite: `%LOCALAPPDATA%\SeryMente\OCP MCP\data\ocp-mcp.sqlite`.
- Respaldos locales: subdirectorio `backups` bajo el root de datos.

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

Las herramientas MCP de escritura separan preparación y ejecución:
1. `prepare_operation` crea una solicitud pendiente, no ejecuta ni autoriza.
2. El operador inspecciona el request y, si decide autorizarlo, ejecuta `OcpMcp.exe authorize --request-id <id>` en consola visible. Se presenta el payload y se exige confirmar su hash corto.
3. `execute_operation` solo funciona con un grant local, válido y no consumido.

No se automatiza aprobación. No se deben pasar confirmaciones por pipes, variables de entorno ni scripts desatendidos.

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

DUG: Samantha v386/NX-386m (blob `22dca684830a36dff019b47811d9b800cc9bea0a`). Núcleo documental: MCP-OCP v0.1.25; backlog v0.6; release de software objetivo: 1.0.0. Sink local por stdio: AUTORIZADO, no implementado ni desplegado. Acceso GitHub privado: conector autenticado de la conversación; `gh auth login` local no es requisito para operaciones del repositorio mediante conector. No se fijan hostname, Device ID, perfil Windows ni ruta de una sesión efímera. MCP-NORMATIVO permanece DESACTIVADO.


## 10. Instalación del release 1.0.0 dentro del checkout de Metodología · 2026-11-09

El ejecutable MCP-OCP 1.0.0 no se instala solo en LocalAppData. Se instala dentro del checkout local:

- Checkout: `SeryMente/Repositorios/Metodologia/metodologia/`.
- Carpeta: `frentes/mcp-metodologia/instalacion-local/`.

La carpeta contiene ejecutable, runtime/dependencias, launcher, configuración de ejemplo y manifiesto/hash; queda excluida de Git. DB SQLite, DPAPI, fuentes sensibles, logs operativos y backups quedan fuera del checkout en un root independiente protegido. No asumir protección de LocalAppData ni de un volumen con BitLocker suspendido.

Flujo: sincronizar checkout → verificar ZIP/manifest/SHA → extraer en esa carpeta → comprobar archivos/hash/read-back → establecer root protegido → importar fuentes DUG v386 y comprobar 43 IDs/MDP → verificar readiness real → solicitar consentimiento presente para `provision-operator` / `REGISTER <SID>` → configurar el cliente MCP STDIO/RDC → ejecutar pruebas de uso y cierre.

La entrega del paquete no prueba instalación. Un proceso activo o health READY de test no prueba fuentes importadas ni operador provisionado. La etiqueta `INSTALLED_AND_READBACK_VERIFIED` requiere ruta, versión, commit/blob, SHA del paquete y extracción cotejada. No abrir listeners/endpoints públicos; `MCP-NORMATIVO` sigue DESACTIVADO.
