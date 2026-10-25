# Inventario de repositorios, frentes y recursos · Ser y Mente

**Corte de revisión:** 2026-10-25. **Fuente de inventario:** árboles `main` leídos mediante la conexión GitHub disponible para el propietario `SeryMente`. **Cobertura:** nueve repositorios accesibles en esa consulta; no demuestra que sean todos los repositorios existentes en la organización GitHub. El inventario describe rutas observadas y no prueba por sí solo la integridad semántica de todos los archivos.

## Modelo operativo

La jerarquía es **organización → repositorio → frentes/OCP → materiales del frente**, con recursos auxiliares cuyo alcance puede ser de frente, de repositorio o compartido entre repositorios. El repositorio de metodología conserva el nombre `SeryMente/metodologia`; el nombre operativo de su frente central es **Metacanon**. No son la misma identidad.

Las rutas se registran por evidencia, no por uniformidad estética. Un OCP existente en una ruta heredada se conserva hasta una migración propia expresamente autorizada, coordinada y verificada. No se crean OCP ni carpetas compartidas vacíos por simetría.

## Inventario observado

| Repositorio | OCP/frentes observados | Recursos y notas de alcance |
| --- | --- | --- |
| [`SeryMente/metodologia`](https://github.com/SeryMente/metodologia) | `frentes/acceso/`; `frentes/blog-personal/`; `frentes/ep/`; `frentes/metacanon/` (nombre operativo vigente); `frentes/mcp-jules/` (nuevo frente MCP Jules, este corte). | `.github/` y `scripts/validate-canonical-bootstrap.py` son infraestructura de validación del repositorio. `gobernanza/` contiene cánones compartidos. `CIBERCAFE/` es un área operativa del repositorio. Los demás scripts raíz requieren identificación de invocadores antes de trasladarse o consolidarse. `frentes/metodologia/` queda como compatibilidad solo con punteros, sin un segundo control de responsabilidad. |
| [`SeryMente/khora`](https://github.com/SeryMente/khora) | `docs/frentes/dictado-voz/`; `docs/frentes/harmonia/`; `docs/frentes/tareas-automaticas/`. | Los OCP conservan la ruta heredada bajo `docs/frentes/`; no trasladar por normalización. Código de producto y automatizaciones permanecen en sus áreas propias. |
| [`SeryMente/signal-interpreter`](https://github.com/SeryMente/signal-interpreter) | `docs/frentes/signal-interpreter/`. | OCP histórico bajo `docs/frentes/`; preservar la ubicación declarada. La gran cantidad de archivos de datos no equivale a una gran cantidad de frentes. |
| [`SeryMente/personal`](https://github.com/SeryMente/personal) | `frentes/repertorio-canto-personal/`. | El OCP contiene scripts, originales, guías y evidencias específicas; no se mueve. |
| [`SeryMente/tercer-ambito`](https://github.com/SeryMente/tercer-ambito) | `etica/` contiene núcleo/documentación, manifiesto, fuentes, evidencia y originales; se registra como estructura de frente/dominio existente, con clasificación formal de OCP pendiente de revisar su control autoritativo. | Preservar la estructura; no se renombra ni migra por esta tarea. |
| [`SeryMente/serymente`](https://github.com/SeryMente/serymente) | No se detectó una carpeta `frentes/` o `docs/frentes/` en el árbol inspeccionado. | Repositorio de sitio/activos web según su árbol (`custom-code/` y configuración). No crear un OCP vacío; confirmar la necesidad si aparece un frente operativo con estado propio. |
| [`SeryMente/otrogranprograma`](https://github.com/SeryMente/otrogranprograma) | No se detectó una carpeta `frentes/` o `docs/frentes/` en el árbol inspeccionado. | `docs/`, `blog/` y código del proyecto se conservan como estructura del repositorio; la inspección estructural no declara que no existan tareas o frentes lógicos. |
| [`SeryMente/GDP`](https://github.com/SeryMente/GDP) | No se detectó un directorio OCP bajo `frentes/` o `docs/frentes/`. Su README sí identifica `docs/SPRINT-CONSAR-AFORE-NSS.md` como objeto canónico único del sprint GDP; es un archivo, no una carpeta OCP conforme a §46. | Registrar el frente lógico/sprint y su núcleo de archivo único como **estructura heredada pendiente de clasificación/migración OCP**. Conservar documentos, código y datos; no mover ni convertir el documento en carpeta hasta planificar dependencias, propósito y aceptación. |
| [`SeryMente/khora-effectif`](https://github.com/SeryMente/khora-effectif) | No se detectó una carpeta `frentes/` o `docs/frentes/` en el árbol inspeccionado. | Proyecto de extensión/worker según los archivos visibles; conservar la estructura local. Su punto de entrada está en `README.txt`. |

## Clasificación inicial de scripts de Metodología/Metacanon

| Ruta observada antes de esta taxonomía | Clasificación actual | Acción |
| --- | --- | --- |
| `scripts/validate-canonical-bootstrap.py` | Infraestructura del repositorio | Permanece en raíz. |
| `scripts/bootstrap-entorno-persistente.ps1` | Corte M26 en `main`: acepta `-ObserverOnly`, `-WorkRoot` y `-TerminalId`; genera `CIBERCAFE/<PC-N>/ESTADO.md` y eventos, copia el propio archivo desde `$PSCommandPath` a `<WorkRoot>\scripts\bootstrap-entorno-persistente.ps1`, y descarga/valida por commit `14756d289f1ddc4c74c6736f5aa021121158541c` + SHA-256 `19D254602AEAA17F08D9E4D09B20B665DC48588C46EB41F1C9E53F2EF62E0154` el `bootstrap-cibercafe-cli.ps1` que luego ejecuta con `-PrepareOnly`. El alcance observado es mixto EP/CIBERCAFE, no EP-only. | No mover ni consolidar; primero identificar invocadores externos y definir propietario contractual entre EP/CIBERCAFE. |
| `scripts/bootstrap-entorno-persistente-ep.ps1` | Corte M26 en `main`: variante funcionalmente distinta que acepta `-WorkRoot`, exige identidad elevada `MantenimientoRCI`, encuentra un perfil Fila4 único y restringe el `WorkRoot` a ese perfil (por defecto `Desktop\EP`); aísla configuración, cachés y TEMP. Invocador directo no verificado. | Conservar ruta y variante separadas; no consolidar con el bootstrap general sin rastrear consumidor y comparar contratos/pruebas. |
| `scripts/bootstrap-cibercafe-cli.ps1` | `CIBERCAFE/PC-4/ESTADO.md` lo declara script canónico y registra commit probado `14756d289f1ddc4c74c6736f5aa021121158541c` + SHA-256 `19D254602AEAA17F08D9E4D09B20B665DC48588C46EB41F1C9E53F2EF62E0154`. El código valida `Desktop\metodologia`, exige dentro del clon la ruta exacta `scripts\bootstrap-cibercafe-cli.ps1` y lee `SI-METACOGNITIVO.md`/`METODOLOGIA.md`. El bootstrap general de arriba ejecuta una descarga de este script fijada por commit/hash. | Mantener ruta raíz. Un traslado rompería la autocomprobación de ruta salvo que se diseñe y pruebe una compatibilidad explícita. |
| `scripts/clone-public-repo-to-desktop.ps1` | Utilidad candidata a compartida; número de consumidores sin verificar. | No mover hasta demostrar su alcance real. |
| `scripts/obs-chrome-camera-fix.ps1` | Utilidad de entorno; propietario/consumidores aún no confirmados. | No mover hasta identificar su alcance y punto de invocación. |


### Corte M26 · referencias y dependencias rápidas (2026-10-22)

La lectura directa de los tres scripts y de `CIBERCAFE/PC-4/ESTADO.md` confirma el vínculo interno entre el bootstrap general de Entorno Persistente y el CLI canónico de CIBERCAFE, además de dos contratos EP distintos. La búsqueda de código conectada no devolvió coincidencias para los nombres de archivo; como la indexación/cobertura de búsqueda no está demostrada, ese cero **no acredita ausencia de invocadores**. No se obtuvo una lista exhaustiva de consumidores externos. Los tres archivos se conservan en `scripts/`; no se ha movido ni consolidado código. No se consultaron ni ejecutaron workflows.

## Regla de mantenimiento

Actualizar este inventario en la misma migración que cree, mueva o retire un OCP/recurso. En cada repositorio, el README o punto de entrada local indica sus OCP conocidos y áreas auxiliares; este inventario central registra la visión entre repositorios. No es un segundo control de responsabilidad ni sustituye el estado vivo de ningún frente.

Para las reglas normativas vigentes, consultar [Metacanon](METACANON-OBJETOS-CANONICOS.md) §51. El inventario no implica sincronización automática entre repositorios, no certifica una enumeración completa de la organización y no autoriza movimientos adicionales.
