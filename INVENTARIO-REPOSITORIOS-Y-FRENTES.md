# Inventario de repositorios, frentes y recursos · Ser y Mente

**Corte de revisión estructural completa:** 2026-10-22. **Actualización incremental verificada en main:** 2026-11-11 (alta de los FT MCP-OCP y Loop; se conserva la cobertura base y no implica una nueva auditoría estructural global). **Fuente de inventario base:** árboles `main` leídos mediante la conexión GitHub disponible para el propietario `SeryMente`. **Cobertura base:** nueve repositorios accesibles en la consulta estructural; una consulta posterior de lista expuso diez repositorios accesibles, incluido Filo Sangriento, sin inspeccionar estructuralmente los diez árboles. No se presume exhaustividad organizacional. El inventario describe rutas observadas y no prueba por sí solo la integridad semántica de todos los archivos.

## Modelo operativo

La taxonomía normativa se consulta en el [DUG, ART-015](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-015): identidad conceptual Ser y Mente (S y M) → cadena de infraestructura verificada (cuenta titular si aplica → organización GitHub → repositorios → FT/OCP → materiales), con ámbitos funcionales transversales que pueden cruzar frentes/repositorios. Los anexos ART-016 a ART-022 especifican los nodos; ART-014 define el procedimiento SPDF. La relación de una cuenta individual/empresarial superior a SeryMente no está verificada. El inventario tiene cobertura declarada y no presume exhaustividad global. El repositorio de metodología conserva el nombre `SeryMente/metodologia`; el nombre operativo de su frente central es **Metacanon**. No son la misma identidad.

Las rutas se registran por evidencia, no por uniformidad estética. Un OCP existente en una ruta heredada se conserva hasta una migración propia expresamente autorizada, coordinada y verificada. No se crean OCP ni carpetas compartidas vacíos por simetría.

## Inventario observado

| Repositorio | OCP/frentes observados | Recursos y notas de alcance |
| --- | --- | --- |
| [`SeryMente/metodologia`](https://github.com/SeryMente/metodologia) | `frentes/acceso/`; `frentes/blog-personal/`; `frentes/ep/`; `frentes/metacanon/` (nombre operativo vigente); `frentes/khora-workstation-bootstrap/` (OCP provisional, 2026-10-30); `frentes/radar-profesional/` (núcleo RADAR-PROFESIONAL-v1.0); `frentes/mcp-metodologia/` (núcleo MCP-METODOLOGIA-v0.1.30); `frentes/ocp-2-0/` (FT **OCP2.0**, renombrado desde `frentes/loop/` el 2026-11-11; núcleo OCP2.0-v0.1.0; generación 1; sin folio FOL1; motor de desarrollo recurrente todavía no implementado; IDs históricos C-LOOP-* conservados). | `.github/` y `scripts/validate-canonical-bootstrap.py` son infraestructura de validación del repositorio. `gobernanza/` contiene cánones compartidos. `CIBERCAFE/` es un área operativa del repositorio. Los demás scripts raíz requieren identificación de invocadores antes de trasladarse o consolidarse. `frentes/metodologia/` queda como compatibilidad solo con punteros, sin un segundo control de responsabilidad. |
| [`SeryMente/khora`](https://github.com/SeryMente/khora) | `docs/frentes/dictado-voz/`; `docs/frentes/observabilidad-mcp/`; `docs/frentes/harmonia/`; `docs/frentes/tareas-automaticas/`; `frentes/custodia/`. | Dictado queda limitado a pantalla/captura/transcripción/edición/continuidad; Observabilidad MCP es un FT independiente con OCP/control propios (control inicial `unassigned`); Harmonia y Tareas conservan sus OCP. Custodia transversal mantiene su ruta propia. Las rutas heredadas bajo `docs/frentes/` se conservan; no trasladar por normalización. PR #342/#343 son candidatos de Observabilidad MCP, aún abiertos/draft; PR #335 es un cambio amplio de Ingreso, no atribuible íntegramente a Dictado. |
| [`SeryMente/signal-interpreter`](https://github.com/SeryMente/signal-interpreter) | `docs/frentes/signal-interpreter/`. | OCP histórico bajo `docs/frentes/`; preservar la ubicación declarada. La gran cantidad de archivos de datos no equivale a una gran cantidad de frentes. |
| [`SeryMente/personal`](https://github.com/SeryMente/personal) | `frentes/repertorio-canto-personal/`. | El OCP contiene scripts, originales, guías y evidencias específicas; no se mueve. |
| [`SeryMente/tercer-ambito`](https://github.com/SeryMente/tercer-ambito) | `etica/` contiene núcleo/documentación, manifiesto, fuentes, evidencia y originales; se registra como estructura de frente/dominio existente, con clasificación formal de OCP pendiente de revisar su control autoritativo. | Preservar la estructura; no se renombra ni migra por esta tarea. |
| [`SeryMente/serymente`](https://github.com/SeryMente/serymente) | No se detectó una carpeta `frentes/` o `docs/frentes/` en el árbol inspeccionado. | Repositorio de sitio/activos web según su árbol (`custom-code/` y configuración). No crear un OCP vacío; confirmar la necesidad si aparece un frente operativo con estado propio. |
| [`SeryMente/otrogranprograma`](https://github.com/SeryMente/otrogranprograma) | No se detectó una carpeta `frentes/` o `docs/frentes/` en el árbol inspeccionado. | `docs/`, `blog/` y código del proyecto se conservan como estructura del repositorio; la inspección estructural no declara que no existan tareas o frentes lógicos. |
| [`SeryMente/GDP`](https://github.com/SeryMente/GDP) | No se detectó un directorio OCP bajo `frentes/` o `docs/frentes/`. Su README sí identifica `docs/SPRINT-CONSAR-AFORE-NSS.md` como objeto canónico único del sprint GDP; es un archivo, no una carpeta OCP conforme a §46. | Registrar el frente lógico/sprint y su núcleo de archivo único como **estructura heredada pendiente de clasificación/migración OCP**. Conservar documentos, código y datos; no mover ni convertir el documento en carpeta hasta planificar dependencias, propósito y aceptación. |
| [`SeryMente/khora-effectif`](https://github.com/SeryMente/khora-effectif) | No se detectó una carpeta `frentes/` o `docs/frentes/` en el árbol inspeccionado. | Proyecto de extensión/worker según los archivos visibles; conservar la estructura local. Su punto de entrada está en `README.txt`. |
| [`SeryMente/filo-sangriento`](https://github.com/SeryMente/filo-sangriento) | `frentes/filo-sangriento/` (FT, 2026-10-30; núcleo `FILO-SANGRIENTO-v0.1.3`; control assigned, generación 1, sin folio por FOL1 pendiente); `frentes/huggingface/` (nuevo FT, 2026-10-30; núcleo `HUGGINGFACE-v0.1.2`; OCP `ocp-front-huggingface` / `HF`; control `unassigned`, generación 0; sin folios). |

## Clasificación inicial de scripts de Metodología/Metacanon

| Ruta observada antes de esta taxonomía | Clasificación actual | Acción |
| --- | --- | --- |
| `scripts/validate-canonical-bootstrap.py` | Infraestructura del repositorio | Permanece en raíz. |
| `scripts/bootstrap-entorno-persistente.ps1` | Corte M26 en `main`: acepta `-ObserverOnly`, `-WorkRoot` y `-TerminalId`; genera `CIBERCAFE/<PC-N>/ESTADO.md` y eventos, copia el propio archivo desde `$PSCommandPath` a `<WorkRoot>\scripts\bootstrap-entorno-persistente.ps1`, y descarga/valida por commit `14756d289f1ddc4c74c6736f5aa021121158541c` + SHA-256 `19D254602AEAA17F08D9E4D09B20B665DC48588C46EB41F1C9E53F2EF62E0154` el `bootstrap-cibercafe-cli.ps1` que luego ejecuta con `-PrepareOnly`. El alcance observado es mixto EP/CIBERCAFE, no EP-only. | No mover ni consolidar; primero identificar invocadores externos y definir propietario contractual entre EP/CIBERCAFE. |
| `scripts/bootstrap-entorno-persistente-ep.ps1` | Corte M26 en `main`: variante funcionalmente distinta que acepta `-WorkRoot`, exige identidad elevada `MantenimientoRCI`, encuentra un perfil Fila4 único y restringe el `WorkRoot` a ese perfil (por defecto `Desktop\EP`); aísla configuración, cachés y TEMP. Invocador directo no verificado. | Conservar ruta y variante separadas; no consolidar con el bootstrap general sin rastrear consumidor y comparar contratos/pruebas. |
| `scripts/bootstrap-cibercafe-cli.ps1` | `CIBERCAFE/PC-4/ESTADO.md` lo declara script canónico y registra commit probado `14756d289f1ddc4c74c6736f5aa021121158541c` + SHA-256 `19D254602AEAA17F08D9E4D09B20B665DC48588C46EB41F1C9E53F2EF62E0154`. El código valida `Desktop\metodologia`, exige dentro del clon la ruta exacta `scripts\bootstrap-cibercafe-cli.ps1` y lee `SI-METACOGNITIVO.md`/`METODOLOGIA.md`. El bootstrap general de arriba ejecuta una descarga de este script fijada por commit/hash. | Mantener ruta raíz. Un traslado rompería la autocomprobación de ruta salvo que se diseñe y pruebe una compatibilidad explícita. |
| `scripts/clone-public-repo-to-desktop.ps1` | Utilidad candidata a compartida; número de consumidores sin verificar. | No mover hasta demostrar su alcance real. |
| `scripts/obs-chrome-camera-fix.ps1` | Utilidad de entorno; propietario/consumidores aún no confirmados. | No mover hasta identificar su alcance y punto de invocación. |
| `scripts/khora-workstation-bootstrap-v5.ps1` | Bootstrap V5 de estación Windows: Node.js LTS, Git, GitHub CLI, credenciales HTTPS, Vercel CLI y arranque RDC con `--no-persist-session`. Artefacto histórico superado por V6; conservar solo como antecedente, no como comando vigente. Requiere GitHub CLI instalado en `C:\Program Files\GitHub CLI\gh.exe` y autenticado; el script verifica autenticación de GitHub/Vercel y solicita `vercel login` si falta. | Mantener separado de los bootstraps EP/CIBERCAFE; no fusionar sin identificar y probar consumidores. |
| `scripts/khora-workstation-bootstrap-v6.ps1` | Bootstrap endurecido: versiones fijadas (Vercel 65.9.0 y Desktop Commander 0.3.1), validación de Node/npm, reintentos acotados, preflight de GitHub/Git HTTPS/Vercel, bloqueo fail-closed de instancia RDC duplicada y timeout de handshake de 5 minutos. V6 publicado en commit `aa45426ece7374e9812868e04e0ce5f783cebf4d`; blob SHA `862e63bd00a84cdbe5c2d913794cc17de373356a`; SHA-256 `dd71b638fab3694e89ae58d7faf265941cd6a289ecbf9602bf0d434837635d7b`. Autoprueba y preflight remoto superados en PC-14 el 2026-10-30; arranque RDC real en sesión fresca sigue pendiente por la protección contra procesos duplicados. | Mantener separado de los bootstraps EP/CIBERCAFE; no fusionar sin identificar y probar consumidores. |




**Comando definitivo · PowerShell 5.1 · ejecución desde memoria, sin copia local:**

```powershell
& {
    param([switch]$SelfTest,[switch]$PreflightOnly)
    $ErrorActionPreference = 'Stop'
    $ghCommand = Get-Command gh.exe -ErrorAction SilentlyContinue | Where-Object {$_.CommandType -eq 'Application'} | Select-Object -First 1
    $gh = $null
    if ($ghCommand) { $gh = $ghCommand.Source }
    if (-not $gh) {
        foreach ($candidate in @('C:\Program Files\GitHub CLI\gh.exe',(Join-Path $env:LOCALAPPDATA 'Programs\GitHub CLI\gh.exe'))) {
            if (Test-Path -LiteralPath $candidate -PathType Leaf) { $gh = $candidate; break }
        }
    }
    if (-not $gh) {
        $winget = Join-Path $env:LOCALAPPDATA 'Microsoft\WindowsApps\winget.exe'
        if (-not (Test-Path -LiteralPath $winget -PathType Leaf)) { throw 'GitHub CLI y winget no están disponibles.' }
        & $winget install --id GitHub.cli --exact --silent --accept-package-agreements --accept-source-agreements --disable-interactivity 2>&1 | ForEach-Object { Write-Host $_ }
        $installExit = $LASTEXITCODE
        if ($installExit -ne 0 -and $installExit -ne -1978335189) { throw ('No se pudo instalar GitHub CLI; exit=' + $installExit) }
        $gh = 'C:\Program Files\GitHub CLI\gh.exe'
    }
    if (-not (Test-Path -LiteralPath $gh -PathType Leaf)) { throw 'No se encontró gh.exe después de la instalación.' }

    $authOutput = @(& $gh auth status --hostname github.com 2>&1)
    $authExit = $LASTEXITCODE
    if ($authExit -ne 0) {
        Write-Host 'No hay una sesión GitHub válida. Iniciando autorización web/device flow con scope repo.' -ForegroundColor Yellow
        & $gh auth login --hostname github.com --git-protocol https --web --scopes repo --skip-ssh-key 2>&1 | ForEach-Object { Write-Host $_ }
        $loginExit = $LASTEXITCODE
        if ($loginExit -ne 0) { throw ('La autenticación web de GitHub no terminó; exit=' + $loginExit) }
    }

    $authOutput = @(& $gh auth status --hostname github.com 2>&1)
    $authExit = $LASTEXITCODE
    if ($authExit -ne 0) { throw 'La autenticación GitHub no quedó verificada; no se consultó el repositorio privado.' }

    $apiPath = 'repos/SeryMente/metodologia/contents/scripts/khora-workstation-bootstrap-v6.ps1?ref=aa45426ece7374e9812868e04e0ce5f783cebf4d'
    $response = @(& $gh api $apiPath 2>&1)
    $apiExit = $LASTEXITCODE
    if ($apiExit -ne 0) {
        Write-Host 'La sesión existe, pero no pudo leer el archivo privado. Se solicitará reautorización del scope repo.' -ForegroundColor Yellow
        & $gh auth refresh --hostname github.com --scopes repo 2>&1 | ForEach-Object { Write-Host $_ }
        $refreshExit = $LASTEXITCODE
        if ($refreshExit -ne 0) { throw ('La reautorización de GitHub no terminó; exit=' + $refreshExit + '. No se descargó ni ejecutó el bootstrap.') }
        $authOutput = @(& $gh auth status --hostname github.com 2>&1)
        $authExit = $LASTEXITCODE
        if ($authExit -ne 0) { throw 'La sesión GitHub no pasó la verificación después de reautorizar.' }
        $response = @(& $gh api $apiPath 2>&1)
        $apiExit = $LASTEXITCODE
        if ($apiExit -ne 0) { throw 'La cuenta activa sigue sin acceso de lectura al repositorio privado. Selecciona la cuenta autorizada con gh auth switch --hostname github.com y vuelve a ejecutar. No se descargó ni ejecutó el bootstrap.' }
    }

    $doc = ($response -join [Environment]::NewLine | ConvertFrom-Json)
    if ($doc.type -ne 'file' -or $doc.encoding -ne 'base64' -or $doc.sha -ne '862e63bd00a84cdbe5c2d913794cc17de373356a') { throw 'Git blob SHA, tipo o codificación inesperados.' }
    $bytes = [Convert]::FromBase64String(($doc.content -replace '\s',''))
    if ([int]$doc.size -ne $bytes.Length) { throw 'Tamaño del bootstrap descargado no coincide.' }
    $sha = [Security.Cryptography.SHA256]::Create()
    try { $actual = [BitConverter]::ToString($sha.ComputeHash($bytes)).Replace('-','').ToLowerInvariant() } finally { $sha.Dispose() }
    if ($actual -ne 'dd71b638fab3694e89ae58d7faf265941cd6a289ecbf9602bf0d434837635d7b') { throw 'SHA-256 del bootstrap no coincide.' }
    $source = [Text.Encoding]::UTF8.GetString($bytes)
    if (-not $source.StartsWith('[CmdletBinding()]') -or $source -notmatch '--no-persist-session') { throw 'La estructura del bootstrap no pasó la validación.' }
    $scriptBlock = [scriptblock]::Create($source)
    & $scriptBlock -SelfTest:$SelfTest -PreflightOnly:$PreflightOnly
}
```

El lanzador captura `stderr` de GitHub CLI como salida ordinaria para que `$ErrorActionPreference='Stop'` no interrumpa el manejo de códigos de salida. Si falta sesión, inicia `gh auth login` con device/web flow y scope `repo`; después prueba la lectura privada real. Si la sesión existe pero el archivo privado no es accesible, solicita `gh auth refresh --scopes repo` y reintenta una sola vez. Si la cuenta activa sigue sin acceso, se detiene sin descargar ni ejecutar el bootstrap y pide seleccionar la cuenta autorizada. Solo tras leer el archivo verifica tipo, tamaño, blob SHA y SHA-256 y lo ejecuta en memoria. `-SelfTest` ejecuta solo autopruebas; `-PreflightOnly` valida dependencias/autenticación sin abrir otro RDC. No crea una copia local persistente del `.ps1`.

### Corte M26 · referencias y dependencias rápidas (2026-10-22)

La lectura directa de los tres scripts y de `CIBERCAFE/PC-4/ESTADO.md` confirma el vínculo interno entre el bootstrap general de Entorno Persistente y el CLI canónico de CIBERCAFE, además de dos contratos EP distintos. La búsqueda de código conectada no devolvió coincidencias para los nombres de archivo; como la indexación/cobertura de búsqueda no está demostrada, ese cero **no acredita ausencia de invocadores**. No se obtuvo una lista exhaustiva de consumidores externos. Los tres archivos se conservan en `scripts/`; no se ha movido ni consolidado código. No se consultaron ni ejecutaron workflows.

## Regla de mantenimiento

Actualizar este inventario en la misma migración que cree, mueva o retire un OCP/recurso. En cada repositorio, el README o punto de entrada local indica sus OCP conocidos y áreas auxiliares; este inventario central registra la visión entre repositorios. No es un segundo control de responsabilidad ni sustituye el estado vivo de ningún frente.

Para las reglas normativas vigentes, consultar [DUG](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#metacanon) §51 y la entrada global [ART-015](gobernanza/METAPROMPT-CANONICO-SAMANTHA.html#ART-015). El inventario no implica sincronización automática entre repositorios, no certifica una enumeración completa de la organización y no autoriza movimientos adicionales.
