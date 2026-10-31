# Crónica · C-KHORA-WORKSTATION-BOOTSTRAP-01

## Inicialización · 2026-10-30

### Intención del operador
El operador delimitó el producto como un único script PowerShell guardado en GitHub, sin copia persistente local, con capacidad de solicitar autenticación/autorización GitHub para acceder al repositorio privado. Solicitó auditoría del alcance y creación de un OCP provisional para continuar el trabajo con persistencia. Los originales literales se conservan en `conversaciones/C-KHORA-WORKSTATION-BOOTSTRAP-01-dialogo.jsonl`.

### Fuente y gobierno
- Repositorio: `SeryMente/metodologia`, rama `main`.
- DUG adquirido: v373 · NX-373m; Metacanon 1.26; GOW 2.14.
- DUG blob SHA en la lectura de inicio: `cac4525de77d4f47a8a59c25201968ecf2056b90`.
- V6 auditada: `scripts/khora-workstation-bootstrap-v6.ps1`, commit `aa45426ece7374e9812868e04e0ce5f783cebf4d`, blob `862e63bd00a84cdbe5c2d913794cc17de373356a`, SHA-256 `dd71b638fab3694e89ae58d7faf265941cd6a289ecbf9602bf0d434837635d7b`.

### Revisión y pruebas
- V6 se leyó desde el repositorio privado y el lanzador la verificó por tipo, encoding, tamaño, blob SHA y SHA-256 antes de ejecutarla desde memoria.
- PowerShell 5.1.26100.9711: parser con cero errores sintácticos y cero funciones duplicadas.
- Escaneo estático: no se encontraron referencias a Next.js.
- `-SelfTest`: PASS.
- `-PreflightOnly`: exit code 0; autenticación GitHub preexistente, Git HTTPS credential fill, Vercel 65.9.0 y `vercel whoami` verificados.
- Desktop Commander 0.3.1 `remote --help`: confirma disponibilidad de `--no-persist-session`.
- No se ejecutó el flujo GitHub device auth desde estado limpio; el equipo ya tenía autenticación.
- No se ejecutó handshake RDC fresco: se observaron tres procesos Desktop Commander activos y la protección contra duplicados evitó un nuevo arranque. Ninguno fue terminado.

### Incidente “Next”
El historial de RDC registra un proceso separado PID 22636, iniciado con el comando explícito `node_modules/next/dist/bin/next build --webpack` desde otro directorio. V6 no contiene referencias a Next ni lo invoca. La hora local reportada fue 2026-10-30 19:32:13; zona horaria no verificada. La atribución al bootstrap queda descartada con la evidencia disponible.

### Hallazgos abiertos
1. Un `gh auth status` exitoso no demuestra que el token corresponda a la cuenta autorizada ni que tenga acceso al repositorio privado; el lanzador actual no reautoriza si el API de contenidos falla.
2. Falta probar device flow GitHub desde perfil/entorno limpio.
3. Falta handshake RDC fresco.
4. El self-test actual solo verifica muestras de cadenas y SHA; falta prueba completa de extracción y validación de cada campo del handshake.
5. Vercel CLI/login es heredado de V5; la necesidad debe ratificarse.
6. El script abre Chrome automáticamente en rutas GitHub/RDC y puede abrir browser durante `vercel login`; revisar la restricción GUI de Metacanon §24.
7. Node/Git/GitHub CLI se resuelven mediante winget LTS/latest, no con versión exacta.
8. winget es dependencia del camino de instalación y no hay alternativa validada cuando falta.

### Dictamen
V6 está publicado y supera las pruebas mecánicas y preflight descritas, pero se mantiene **PROVISIONAL / NO ACEPTADO**. La aceptación exige resolver los hallazgos críticos y comprobar GitHub device auth y RDC handshake frescos, sin revocar ni interrumpir credenciales o sesiones existentes.
