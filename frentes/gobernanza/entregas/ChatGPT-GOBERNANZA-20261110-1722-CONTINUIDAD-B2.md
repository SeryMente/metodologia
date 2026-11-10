# Registro provisional de continuidad · Gobernanza · 2026-11-10

**Fuente incorporada:** `ChatGPT-GOBERNANZA (1)-20261110-1722.txt`  
**Ubicación original:** `C:\Users\Fila4\Downloads\ChatGPT-GOBERNANZA (1)-20261110-1722.txt`  
**Metadatos de origen:** exportado el 10-11-2026 a las 17:22:26 (hora local reportada por el equipo); 98.367 bytes; 1.974 líneas.

> Este registro conserva las decisiones, secuencia y evidencia operacional relevantes. No publica la transcripción íntegra ni el enlace privado de conversación en el repositorio; el TXT original permanece en Downloads. La transcripción contiene contexto de sesión y datos locales que no deben exponerse en un repositorio público.

## 1. Decisiones de continuidad preservadas

- Alcance de OCP MCP: México; inspección de equipos bajo autorización del operador.
- Persistencia inicial: Backblaze B2 como destino principal; medio alternativo queda para una etapa posterior.
- Workspace completo por instancia; conversaciones y datos del proyecto cifrados.
- Vault: preservar el ciphertext; no exportar secretos en claro ni incluir contraseñas en el paquete.
- RDC: normalmente una sesión activa; una segunda solo como excepción controlada.
- Política de cierre: intentar checkpoint dentro de un límite, pero priorizar cierre y borrado criptográfico local cuando venza el dead-man.
- Lease aprobado: renovación cada 60 segundos mientras haya actividad; vencimiento a los 30 minutos; aviso previo; cierre por 10 minutos de inactividad; máximo de 8 horas.
- No se debe retrasar SINK:P004 por el panel WPF. El panel sigue siendo obligatorio para el release 1.0.0.

## 2. Secuencia general de hitos

| Hito | Alcance | Estado en este corte |
|---|---|---|
| H1 | SINK:P004 desde IPZ por RDC/STDIO, con respuesta íntegra y trazable | **Siguiente hito de producto; listo para reanudar desarrollo sintético, aún no aceptado** |
| H2 | Persistencia mínima y bóveda | **Parcialmente demostrado:** ciphertext y workspace en B2; restore aislado; descifrado de Vault pendiente |
| H3 | Workspace completo recuperable entre instancias | **Parcial:** restauración aislada en el mismo host; prueba cross-host pendiente |
| H4 | Identidad y telemetría | Pendiente |
| H5 | Lease y dead-man | Parámetros aprobados; ejecución y aceptación pendientes |
| H6 | Limpieza adaptativa y crypto-erasure | Pendiente |
| H7 | Continuidad, integración segura Vault/RDC y panel | Pendiente |
| H8 | Release MCP-OCP 1.0.0 y aceptación integral | Pendiente |
| H9 | Medio alternativo de persistencia | Diferido a post-release |

**Secuencia inmediata acordada para este sprint:** cerrar primero la persistencia B2 de EP; después reanudar H1 SINK:P004 sin reabrir tareas ya superadas ni repetir diagnósticos que no cambien una decisión.

## 3. Método mínimo de recuperación en un solo archivo

**Archivo principal:** `EP-Backup-Provisional-20261110-164004-R2.zip`  
**Destino:** bucket privado `OCP-MCP`, prefijo `ep-ocp/workspace/`  
**Tamaño:** 119.076.640 bytes.  
**Contenido inventariado:** raíz `SeryMente`; 3.289 archivos; 159.547.658 bytes originales.  
**Vault ciphertext incluido:** `SeryMente/EP/local-state/Khora/secrets/ep-env-vault.enc.json` (2.200 bytes).

### Restauración sencilla

1. Descargar únicamente `EP-Backup-Provisional-20261110-164004-R2.zip` desde el bucket/prefijo indicados.
2. Extraer el ZIP en el Escritorio del perfil de destino. El archivo contiene la carpeta raíz `SeryMente`; el resultado esperado es `%USERPROFILE%\Desktop\SeryMente`.
3. Abrir EP Vault con el mecanismo normal y la credencial maestra de recuperación. El ciphertext está dentro del paquete; la contraseña/clave maestra NO está incluida.
4. Reanudar desde el estado de workspace extraído. Los manifiestos y sidecars de SHA son auxiliares de auditoría; no son necesarios para la extracción manual simple.

Si ya existe una carpeta `SeryMente` en destino, no mezclar archivos en caliente: renombrar la carpeta actual o extraer en una ubicación vacía y cambiarla después de detener procesos.

## 4. Evidencia y límites

- Snapshot local R2: 3.289 entradas del ZIP verificadas; receipt reporta 119.076.640 bytes.
- B2: el cierre de ciclo reportó 4/4 objetos cargados y descargados con read-back, SHA-256 coincidente y SSE-B2/AES256.
- Restauración aislada: `C:\R2R`; 3.289/3.289 restaurados; cero fallos y cero archivos inesperados; el workspace original no se modificó.
- El ZIP contiene ciphertext de Vault. La restauración de archivos no equivale a descifrar Vault: `restoredFilesDecrypted=false`; la prueba de descifrado y la restauración cross-host siguen pendientes.
- La copia ZIP se subió sin cifrado del lado cliente por la urgencia del operador. Backblaze SSE-B2/AES256 confirma cifrado del lado del proveedor; no equivale a cifrado extremo a extremo ni a una garantía de confidencialidad frente al proveedor.
- Por ello, el método es **simple y con recuperación del archivo probada**, pero no puede calificarse como infalible ni como restauración completa de Vault en otra máquina. La clave de recuperación debe mantenerse independiente del ZIP.

## 5. Criterio de eficiencia

No repetir inventarios, hashes ni pruebas ya confirmadas cuando no cambien la decisión. Mantener solo los controles que prueban autorización, presencia del objeto, posibilidad de lectura/restauración y disponibilidad de la clave necesaria. El hash queda como evidencia disponible, pero no se exige al usuario para la extracción manual básica.

## 6. Próximo paso del sprint

Con la copia R2/B2 y la extracción aislada documentadas, Gobernanza puede habilitar la reanudación de desarrollo sintético H1 SINK:P004 en el ciclo MCP-OCP existente. No declarar H1 aceptado hasta demostrar el recorrido real IPZ → RDC/STDIO → SINK:P004 → salida visible y trazable al modelo.

**Estado:** registro provisional creado desde el TXT de origen; procedimiento de descarga/extracción documentado; descifrado cross-host de Vault NO_VERIFICADO.


## 7. Paquete R3 posterior · corte 17:21 local

Se encontró un segundo paquete más reciente, **solo local** en el corte de esta nota:

- Archivo: `Downloads/EP-Workspace-Recovery-R3-20261110.zip`.
- Creación: `2026-11-10T23:21:27Z` = `17:21:27 -06:00`.
- Tamaño: 107.014.352 bytes; 3.342 entradas ZIP; 3.339 archivos del workspace según su manifiesto.
- Incluye dos ciphertexts: `EP/local-state/Khora/secrets/ep-env-vault.enc.json` (2.200 bytes) y `EP-Vault/ep-env-vault.enc.json` (2.048 bytes).
- Añade `__EP_RECOVERY__/RESTORE-INSTRUCTIONS.txt` y `Restore-Workspace.ps1`. La guía indica extracción a `C:\R3R` y restauración a un destino vacío como `C:\SeryMente`; el script rechaza sobrescribir un destino existente.
- Excluye expresamente secretos en claro, claves privadas sueltas, reparse points y directorios regenerables. Mantiene la excepción de no tener cifrado cliente.

**Estado remoto de R3: NO_VERIFICADO / no usar como fuente remota confirmada.** En B2, la fuente remota con read-back demostrado sigue siendo R2. Para salir hoy, R2 es el archivo remoto de recuperación; R3 es una mejora local pendiente de carga y read-back cuando Vault/credenciales estén disponibles. No duplicar ni borrar R2.
