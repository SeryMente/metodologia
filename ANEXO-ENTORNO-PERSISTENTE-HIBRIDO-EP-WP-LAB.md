# Entorno Persistente Híbrido · Consolidación EP y EP-WP-LAB

**Estado:** PLAN CONSOLIDADO · EP físico NO CERTIFICADO  
**Fecha de corte:** 2026-10-09  
**Ámbito:** KHORA EP volátil, transición al EP cifrado y laboratorio WordPress local de Ser y Mente  
**Repositorio de continuidad:** `SeryMente/metodologia`

## 1. Decisión y objetivo

La continuidad del Entorno Persistente (EP), sus decisiones transversales, manifiestos no sensibles, evidencias, bloqueos y próximos pasos deben quedar consultables en `SeryMente/metodologia`, no depender de una conversación aislada.

La sesión de cómputo puede ser efímera. La persistencia del contenido debe resolverse por separado y demostrarse mediante un destino remoto autorizado, integridad verificable y recuperación probada. **No se llama persistente a una carpeta local por estar dentro de EP, ni se llama híbrido y recuperable al WordPress local mientras solo exista una copia de trabajo.**

Este documento consolida el estado y ordena la ejecución; no afirma que la integración física o la migración cifrada estén terminadas. La especificación técnica de KHORA sigue existiendo en `SeryMente/khora/ep-medio-architectura.md` y el contrato de integración en `SeryMente/khora/docs/ep-wp-lab-integration.md`. Como esos documentos declaran actualmente autoridad normativa desde KHORA, la siguiente fase debe reconciliar esa precedencia y dejarlos como contrato de implementación enlazado a este registro transversal, sin mantener dos normas divergentes.

## 2. Fuentes y commits verificados al corte

| Fuente | Ref/estado verificado | Uso |
|---|---|---|
| `SeryMente/metodologia` | `main` en `0f5810a5b6a0ddb19d98d1c6dcb6db9e8406735e` | Registro transversal de decisiones, estado, evidencias y continuidad EP |
| Metodología | `v0.14.9 — Bootstrap Anclado por Commit y Hash` | Versión vigente mostrada en el README actual de Metodología |
| SI | `v1.6.21 — Ordenamiento por Preponderancia y Categorías` | La identidad se obtiene siempre de la cabecera del snapshot vigente, no de este documento |
| `SeryMente/khora` | `main` en `b94e05f7a3f8e8bb3d48bf635054fd3b44702c4c` | Implementación EP y aplicación web KHORA |
| Arquitectura EP de KHORA | `ep-medio-architectura.md` declara v1.0.4 y Host KHORA 7.5.3 | Contrato técnico actual que debe reconciliarse con la gobernanza transversal |
| Validación EP de KHORA | `EP-VALIDATION.md` conserva encabezado v1.0.1 y Host KHORA 7.5.2 | Evidencia histórica; está desfasada respecto a la arquitectura y requiere actualización |
| Integración WP-LAB de KHORA | `docs/ep-wp-lab-integration.md` declara “preparada; activación física pendiente” | Contrato y estructura objetivo de EP-WP-LAB |
| `SeryMente/serymente` | `main` en `3603bf2afaff24b19215086beb08f51170b70193` | Fuente canónica de código reconstruido y bootstrap WP |
| Estado E2E WP-LAB | `E2E-STATE-2026-10-08.md`, actualizado antes de este diagnóstico | Evidencia histórica; no sustituye la revalidación física actual |
| KHORA producción | deployment `dpl_9wegjRrLbkVGiFcdQuKyp6R6tJgd` READY, commit `b94e05f7...` | Baseline actual; este plan no ordena crear un deployment nuevo |

Los SHA de esta tabla son anclas de corte. Deben volverse a leer desde `main` antes de cada cambio y no usarse como sustitutos de una verificación nueva.

## 3. Modelo canónico de persistencia

### 3.1 Plano de control y documentación

`SeryMente/metodologia` conservará decisiones, runbooks, estados por terminal, manifiestos saneados, hashes, IDs de snapshot, resultados de pruebas, bloqueos y continuidad entre sesiones. Las actualizaciones deben ser trazables y tener read-back.

Este repositorio es **público**. No se deben guardar aquí contraseñas, tokens, contenido privado de usuario, dumps de base de datos, snapshots completos de WordPress ni el ZIP propietario de Divi. Pueden quedar metadatos no sensibles y hashes que permitan verificar activos sin redistribuirlos.

### 3.2 Código y ejecución

- `SeryMente/serymente`: código recuperado, módulos personalizados y scripts de rehidratación.
- `SeryMente/khora`: implementación de KHORA EP y sus contratos de integración.
- `EP-WP-LAB/site`: copia de ejecución del laboratorio, solo dentro de una ubicación físicamente verificada.
- `EP-WP-LAB/snapshots`: snapshots verificados, con identidad y manifiestos; su contenido binario debe mantenerse en almacenamiento autorizado privado.
- `EP-WP-LAB/tools`: referencias y herramientas de operación, sin duplicar runtimes innecesariamente.
- `EP-WP-LAB/manifests`: manifiestos de integridad, runtime y aceptación.

La estructura exacta debe adaptarse al workspace real definido por KHORA; no crear un segundo workspace ni una carpeta paralela fuera de la junction canónica.

### 3.3 Datos activos y almacenamiento remoto

PostgreSQL y Vercel Blob de KHORA son un plano de datos distinto del repositorio Metodología: PostgreSQL mantiene el contenido estructurado y Blob almacena artefactos binarios cubiertos por la aplicación. No debe presumirse que Blob ya guarda todo el contenido del usuario o los snapshots de WordPress.

Para que WP-LAB sobreviva a un Deadman Trigger hay que seleccionar y verificar un destino privado autorizado para sus snapshots y datos mutables, o demostrar un mecanismo equivalente de persistencia incremental. Una escritura local o un snapshot solo al cierre no bastan: el Deadman puede ejecutarse después de una caída sin dar oportunidad de exportar. El destino privado WP-LAB y su restauración E2E quedan **PENDIENTES DE DEFINICIÓN/VERIFICACIÓN**.

Render `serymente-wordpress-lab` es una superficie de validación desechable, no fuente de verdad de persistencia. El baseline documentado usa Divi 4.23.1; no equivale al laboratorio local con Divi 4.24.0.

## 4. Estado físico observado el 2026-10-09

### Comprobado en esta inspección

- El proveedor RDC mostró un dispositivo online llamado `PC-7`. La identidad persistente sigue siendo `CIBERCAFE + PC-7`; el ID del dispositivo RDC es identidad de la sesión y no sustituye la identidad de la terminal.
- En el proceso de inspección, `$env:USERPROFILE` resolvió a `C:\Users\PC 7`, pero `$env:COMPUTERNAME` llegó vacío. El procedimiento canónico de Metodología ya advierte que esta variable puede ser vacía; en el siguiente diagnóstico se debe determinar el hostname por DNS y `Win32_ComputerSystem.Name`.
- `C:\Users\PC 7\Desktop\EP` existe como directorio normal. El objeto consultado no mostró `LinkType` ni `Target`; por tanto, **no se ha demostrado que sea la junction NTFS canónica** hacia un workspace cifrado.
- En el perfil y rutas esperadas revisadas, `Studio\Ser-y-Mente-Lab`, su snapshot documentado, `Downloads\Divi-4.24.0.zip`, `Tools\node-v22.23.3-win-x64\node.exe`, `Studio\serymente-source` y la ruta esperada del CLI de WordPress Studio devolvieron `Test-Path = False`.
- No se obtuvieron resultados HTTP de las comprobaciones de rutas; quedan `NO VERIFICADAS`.

### No demostrado; no inferir pérdida

Los resultados anteriores solo acreditan que los elementos no aparecen en esas rutas dentro del contexto inspeccionado. No prueban que se hayan borrado ni excluyen otras ubicaciones, volúmenes, perfiles o una diferencia entre el contexto RDC y el escritorio interactivo real.

No se confirmó el montaje de un VHDX, ni BitLocker XTS-AES-256 al 100 %, ni la asociación de `Desktop\EP` con el directorio interno correcto. Por ello, la clasificación operativa actual es **EP_VOLATIL / UBICACIÓN FÍSICA NO CERTIFICADA** hasta completar ese preflight. No mover, renombrar, borrar ni rehidratar sobre la carpeta actual.

## 5. Auditoría del bootstrap WP-LAB

No ejecutar todavía `reconstruction/lab/bootstrap-ser-y-mente-lab.ps1`. La lectura estática de la versión en `main` detecta operaciones que deben corregirse o aislarse antes de repetirlo:

1. Cuando ya existe `RepoRoot`, ejecuta `git reset --hard origin/main`; eso puede descartar modificaciones locales sin inventariarlas.
2. Borra `wp-content\sym-lab-source` antes de volver a copiarlo.
3. Elimina `wp-content\themes\Divi` antes de verificar una sustitución completa y funcional del tema.
4. Si falta `sym-local-lab.php`, usa como fallback `reconstruction/lab/ser-y-mente-lab.php`. Ese archivo se titula “Cloud Lab Reconstruction” y su raíz predeterminada es `/opt/serymente`; no está demostrado como plugin local compatible.
5. Copia `custom-code` y el módulo de Blog en ubicaciones distintas mientras el plugin plantilla resuelve el módulo de Blog mediante `SYM_LAB_SOURCE_ROOT`. Hay que reconciliar una sola ruta de carga y evitar plugins duplicados o archivos requeridos inexistentes.
6. No verifica por sí mismo el snapshot anterior ni crea una copia de seguridad antes de sobrescribir; el manifiesto que emite no demuestra la integridad de todo el sitio, la ubicación dentro del VHDX ni el resultado de las pruebas HTTP.

El nuevo bootstrap debe trabajar en staging, detenerse ante árbol local sucio/origin incorrecto, hacer backup antes de cualquier sustitución, verificar todo hash previo al cambio, reconciliar de forma atómica y conservar un rollback. Nunca debe restaurar un snapshot automáticamente encima de un sitio que funcione.

## 6. Plan de ejecución y gates

### Fase 1 — Reconciliar el canon de Metodología y KHORA

- Mantener en Metodología este registro transversal como referencia de continuidad EP.
- Actualizar la autoridad declarada en `SeryMente/khora/AGENTS.md`, `ep-medio-architectura.md` y `docs/ep-wp-lab-integration.md`, para que remitan a la fuente transversal de Metodología y no compitan con ella. El detalle que solo corresponde a código debe seguir identificado como contrato de implementación.
- Reconciliar `EP-VALIDATION.md` con las versiones y evidencias realmente actuales; no reetiquetar evidencia histórica como ejecución nueva.
- Registrar versiones y SHAs actuales antes de escribir; verificar cada publicación con fetch/read-back.

### Fase 2 — Encontrar y proteger los activos en PC-7

- Identificar host por DNS + `Win32_ComputerSystem`, usuario interactivo, Escritorio real, volúmenes, junction y VHDX montados.
- Localizar sin modificar el sitio, snapshot, ZIP de Divi, Node 22 portátil, WordPress Studio y checkout de `serymente`; leer `git status` antes de sincronizar cualquier clon.
- Si se encuentra el snapshot documentado, calcular SHA-256 y comparar con `B08FB9EED62CEE571F982C5D6EEB7043A41206E83449EF60060A8C74E791E767`. No restaurarlo automáticamente.
- Si se encuentra Divi 4.24.0, comprobar SHA-256 `BD665CE727CBE8B89EB305FB32C325B3255C0892AB3894815C4D51A5BA0CBF2D`. El binario con licencia no se sube a repositorios.
- Verificar el target de `Desktop\EP`, imagen VHDX asociada, BitLocker XTS-AES-256, protección activa y cifrado al 100 %. Si no pasa el gate, no afirmar migración cifrada.

### Fase 3 — Corregir y probar la rehidratación

- Mantener intacto el sitio original.
- Actualizar la fuente desde el commit vigente de `SeryMente/serymente` en un staging limpio; no hacer `reset --hard` sobre un checkout desconocido.
- Corregir el bootstrap para que nunca borre sourceRoot o Divi activos antes de validar y preparar su sustitución; un árbol sucio debe fallar cerrado.
- Utilizar WordPress Studio ya instalado cuando se demuestre compatible. Verificar Node 22.23.3 antes de elegir otra versión.
- La licencia/tema exacto es una dependencia externa si el ZIP no está disponible: bloquear solo las pruebas que dependan de Divi 4.24.0 y avanzar con tareas no dependientes sin inventar equivalencia.
- Tras crear una copia nueva bajo `EP-WP-LAB/site`, validar versiones reales, MU-plugins, dependencias y logs. El manifiesto no debe declarar versiones fijas si no las ha medido.

### Fase 4 — Aceptación funcional

En el host donde se ejecute el laboratorio, comprobar y guardar resultado por ruta:

- `/`
- `/psicologos/`
- `/blog/`
- `/comenzar/`
- `/para-terapeutas-psicologos/` (slug que aparece en el plugin versionado)

Verificar contenido recuperado, ausencia de errores fatales, cabecera/pie no duplicados, estilos/scripts sin duplicación y ausencia de dependencias accidentales de rutas absolutas del equipo original. Los HTTP 200 históricos del 2026-10-08 no satisfacen esta aceptación nueva.

Crear un snapshot completo posterior a la rehidratación, calcular su SHA-256, verificar el tamaño y practicar la restauración en staging aislado. Solo después de esos controles se permite sustituir la ruta de ejecución, nunca destruir la copia original por conveniencia.

### Fase 5 — Persistencia y Deadman

- Persistir incrementalmente el estado mutable del sitio en el destino privado aprobado; una tarea de cierre final no es suficiente frente a muerte abrupta.
- Verificar lectura de vuelta del artefacto, SHA, metadatos de snapshot y restauración desde un entorno nuevo antes de declarar continuidad cloud.
- El Deadman detiene procesos y elimina la copia efímera local, pero no elimina las copias remotas confirmadas.
- En el perfil CIBERCAFE de PC-7 rige `PRESUPUESTO-REINICIO = 0`: no hacer pruebas que reinicien o apaguen esa terminal. Las pruebas de reinicio se realizan en un host de prueba autorizado con una ventana expresamente prevista.

### Fase 6 — Manifiesto y cierre real

El manifiesto deberá registrar, sin secretos ni contenido privado:

- terminal persistente (por ejemplo `CIBERCAFE + PC-7`) y sesión de ejecución;
- clasificación `EP_VOLATIL` o `EP_CIFRADO`;
- almacenamiento físico y target verificados (sin declarar cifrado no comprobado);
- repositorio/commit de código y hashes de activos autorizados;
- versiones observadas de WordPress, PHP, Studio, Node y Divi;
- snapshot ID/fecha/SHA y localización del respaldo privado;
- pruebas por ruta con hora y código HTTP, logs/fatales y resultado de restauración;
- resultado de la prueba de persistencia remota y conducta de Deadman;
- dependencias ausentes, bloqueos y siguiente acción.

La migración definitiva se declara completada solo si se demuestra la ubicación física del sitio dentro del VHDX cifrado, el target correcto de `Desktop\EP`, BitLocker en el estado requerido y la recuperación independiente de la sesión efímera.

## 7. Condiciones para declarar estado

- **COMPLETADO Y VERIFICADO:** evidencia nueva, observable y reproducible de todas las pruebas aplicables; manifest/read-back coherentes.
- **PREPARADO, NO VERIFICADO:** documentación/código disponible, pero el host, la ruta, la persistencia o la prueba real aún no están demostrados.
- **BLOQUEADO POR REQUISITO EXTERNO:** activo propietario, permisos, almacén privado o acceso físico imprescindible que no está disponible.
- **PENDIENTE DE EP CIFRADO DEFINITIVO:** el laboratorio opera en staging/EP_VOLATIL, sin prueba física de VHDX + BitLocker + junction.
- **NO VERIFICADO:** nunca se transforma en PASS por existencia de una carpeta, proceso iniciado o resultado histórico.

## 8. Referencias canónicas

- [Arquitectura EP de KHORA](https://github.com/SeryMente/khora/blob/main/ep-medio-architectura.md)
- [Contrato EP-WP-LAB de KHORA](https://github.com/SeryMente/khora/blob/main/docs/ep-wp-lab-integration.md)
- [Estado E2E de Ser y Mente](https://github.com/SeryMente/serymente/blob/main/reconstruction/lab/E2E-STATE-2026-10-08.md)
- [Laboratorio local WordPress Studio](https://github.com/SeryMente/serymente/blob/main/reconstruction/lab/LOCAL-STUDIO-4.24.md)
- [Bootstrap local WP-LAB (NO ejecutar sin las correcciones de Fase 3)](https://github.com/SeryMente/serymente/blob/main/reconstruction/lab/bootstrap-ser-y-mente-lab.ps1)
- [Manifiesto del activo licenciado Divi 4.24.0](https://github.com/SeryMente/serymente/blob/main/reconstruction/vendor/Divi-4.24.0.asset.md)

## 9. Siguiente operación

La siguiente acción es una **búsqueda de solo lectura en PC-7** para reconciliar identidad de host y localizar los activos fuera de las rutas esperadas. No ejecutar el bootstrap, no mover el sitio, no restaurar el snapshot y no cambiar la ruta activa hasta que esa inspección produzca paths, hashes y estado de almacenamiento verificables.
