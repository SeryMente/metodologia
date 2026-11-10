# Piloto local SINK:P004

Primer corte vertical MCP-OCP. No es el producto generalizado ni una instalación local.

## Alcance
- Transporte MCP por STDIO, servidor proceso hijo.
- Protocolo MCP 2025-11-25: initialize, notifications/initialized, tools/list y tools/call.
- Única herramienta `sink_principle`, restringida a P004.
- Fuente fija DUG v388/NX-388m, commit y blob definidos en `SOURCE-PIN.json`.
- Validación fail-closed de blob y metadatos; respuesta con texto íntegro, pin y SHA-256.
- Eventos minimizados por stderr; stdout reservado al protocolo.
- Cierre por EOF; no define métodos inventados shutdown/exit.

## Requisitos
- .NET SDK 10.0.403.
- Ninguna dependencia NuGet externa.
- Checkout completo que contenga el DUG canónico fijado.

## Validación
Desde `frentes/mcp-metodologia/`:

```powershell
dotnet build .\src\OcpMcp\OcpMcp.csproj -c Release
dotnet build .\tests\OcpMcp.Pilot.Tests\OcpMcp.Pilot.Tests.csproj -c Release
dotnet run --project .\tests\OcpMcp.Pilot.Tests\OcpMcp.Pilot.Tests.csproj -c Release
```

Los comandos no constituyen evidencia hasta tener logs asociados al commit. Los estados de CI sin jobs/logs no demuestran build ni fallo del código.

## Límites
Sin DB, root persistente, importación privada, secretos, operador, listeners, instalación, panel WPF ni aceptación IPZ E2E. Fila 4 y ciclo de vida de sesión corresponden a EP-TASK-003/005.
