# OCP provisional · KHORA Workstation Bootstrap

**Estado:** PROVISIONAL · AUDITORÍA ABIERTA · NO ACEPTADO.
**Núcleo único:** [KHORA-WORKSTATION-BOOTSTRAP.md](KHORA-WORKSTATION-BOOTSTRAP.md).
**Control:** [CONTROL-RESPONSABILIDAD.json](CONTROL-RESPONSABILIDAD.json).
**Pendientes:** [PENDIENTES.md](PENDIENTES.md).
**Originales:** [conversaciones/C-KHORA-WORKSTATION-BOOTSTRAP-01-dialogo.jsonl](conversaciones/C-KHORA-WORKSTATION-BOOTSTRAP-01-dialogo.jsonl).
**Crónica:** [cronica/C-KHORA-WORKSTATION-BOOTSTRAP-01.md](cronica/C-KHORA-WORKSTATION-BOOTSTRAP-01.md).
**Evidencia:** [evidencias/C-KHORA-WORKSTATION-BOOTSTRAP-01.json](evidencias/C-KHORA-WORKSTATION-BOOTSTRAP-01.json).

El único artefacto ejecutable fuente es `scripts/khora-workstation-bootstrap-v6.ps1`. Este OCP no contiene otra copia del script. El lanzador PowerShell recupera el archivo privado y lo ejecuta en memoria tras verificar su integridad. Este frente excluye expresamente Next.js y cualquier aplicación/servidor web.
