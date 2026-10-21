# C-METODOLOGIA-PERFIL-FILA4-13 — identidad de perfil y raíz prohibida

- **Corrección:** el operador rechazó la conclusión de Harmonia que asociaba el Escritorio de `CENTRAL\fila4` con `C:\Users\MantenimientoRCI\Desktop`.
- **Orden:** nunca utilizar `C:\Users\MantenimientoRCI\`; usar únicamente el sistema de archivos de fila4 y elevar la regla al Metaprompt de Samantha.
- **Contención:** Harmonia recibió bloqueo inmediato sobre la raíz incorrecta y obligación de resolver identidad por CLI sin GUI.
- **Evidencia CLI:** `Win32_UserProfile` + traducción SID→NTAccount en PC10RCIF4EI4 mostró `CENTRAL\fila4` / SID `...-5167` / `C:\Users\fila4` y, separadamente, `CENTRAL\MantenimientoRCI` / SID `...-2126` / `C:\Users\MantenimientoRCI`; ambos cargados.
- **Cambio de gobierno:** Metaprompt v334/NX-334m, P036. Metacanon 1.13, invariante §1.19, perfil §3 y regla §41.
- **Límite:** no se inspeccionaron ni movieron artefactos bajo la raíz prohibida; Harmonia debe inventariarlos bajo su propia responsabilidad y proponer reparación.
- **Checkpoint:** releer metaprompt, metacanon, original y revisión; confirmar huellas y respuesta de Harmonia.
