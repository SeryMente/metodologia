# Changelog — MOD-EPVAULT

## 1.0.0 — 2026-11-09

- Primera materialización como módulo funcional independiente de EP.
- Núcleo compartido PowerShell, GUI WPF y CLI headless.
- Cifrado AES-256-CBC + HMAC-SHA256 y KDF PBKDF2-HMAC-SHA256 600.000 iteraciones para nuevas bóvedas.
- Compatibilidad de lectura de envelopes legacy 200.000 y migración autenticada con read-back.
- Sesión DPAPI CurrentUser compartida, TTL absoluto y revocación.
- Notas efímeras DPAPI CurrentUser y TTL.
- Acceso headless por allowlist/Job Object.
- Pruebas sintéticas del núcleo y procesos administrados; aceptación visual H10 pendiente.
