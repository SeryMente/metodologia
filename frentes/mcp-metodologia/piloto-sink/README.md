# Piloto local SINK:P004

Corte vertical mínimo de MCP-OCP. No es release generalizado ni instalación.

- Transporte MCP por STDIO.
- Protocolo 2025-11-25: initialize, notifications/initialized, tools/list, tools/call.
- Única herramienta: `sink_principle`, restringida a P004.
- DUG Samantha v388/NX-388m y pins en `SOURCE-PIN.json`.
- Hash Git blob verificado antes de parsear; respuesta con texto íntegro, procedencia y SHA-256.
- Fallo cerrado ante fuente ausente/alterada, metadatos incorrectos, IDs incompletos/duplicados o principio distinto.
- stdout reservado a JSON-RPC; diagnósticos/eventos minimizados por stderr.
- Cierre por EOF; no define `shutdown` ni `exit`.

## Requisitos
.NET SDK 10.0.403; ninguna dependencia NuGet externa; checkout completo que incluya el DUG canónico fijado.

## Comandos
Desde `frentes/mcp-metodologia/`:

```powershell
dotnet build .\src\OcpMcp\OcpMcp.csproj -c Release
dotnet build .\tests\OcpMcp.Pilot.Tests\OcpMcp.Pilot.Tests.csproj -c Release
dotnet run --project .\tests\OcpMcp.Pilot.Tests\OcpMcp.Pilot.Tests.csproj -c Release
```

Los comandos no son evidencia hasta que existan logs asociados al commit. El workflow CI está escrito; build/tests/smoke permanecen pendientes.

## Límites
Sin DB, root persistente, importación privada, secretos, operador, listener, instalación, panel WPF ni aceptación IPZ E2E. Fila 4 depende de EP-TASK-003/005.
