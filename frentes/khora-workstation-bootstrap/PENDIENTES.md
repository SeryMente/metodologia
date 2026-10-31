# Pendientes · KHORA Workstation Bootstrap

Este listado depende del núcleo `KHORA-WORKSTATION-BOOTSTRAP.md`; no mantiene un segundo estado.

## Críticos

1. **Acceso GitHub efectivo y reautorización.** El lanzador no debe considerar suficiente que `gh auth status` sea exitoso. Debe verificar la lectura real del repositorio privado; si la cuenta/scope no bastan, iniciar `gh auth refresh --scopes repo` o el device flow correspondiente, reintentar una sola vez y detenerse con un diagnóstico inequívoco si persiste el fallo.
2. **Login GitHub desde estado limpio.** Probar el device flow en un entorno aislado sin credenciales previas, sin revocar ni alterar el acceso actual del operador. Confirmar código/URL, acción humana de autorización, scope repo y posterior lectura privada.
3. **Hand­shake RDC fresco.** Bajo autorización e intervención del operador, probar una única instancia `--no-persist-session`, dispositivo autorizado, Device ready, Online y bloque de handshake con SHA/read-back. No terminar instancias activas automáticamente.

## Altos

4. **Parser de handshake probado.** Extraer una función comprobable y exigir GUID válido, User, Device Name, Status Online, Device ready y Session persistence disabled. Añadir pruebas positivas/negativas.
5. **Revisar Vercel.** El requisito actual del operador enfatiza GitHub; Vercel/login se heredó de V5. Confirmar si sigue siendo necesario. No quitarlo silenciosamente; documentar la decisión.
6. **Revisar aperturas GUI.** Evaluar Chrome para GitHub/RDC y el login Vercel conforme a Metacanon §24. Preferir imprimir URL/código en terminal y esperar al operador; no manipular la GUI compartida.
7. **Versiones reproducibles.** Mantener Vercel 65.9.0 y Desktop Commander 0.3.1; fijar o definir explícitamente política de Node, Git y GitHub CLI, hoy resueltos por winget LTS/latest.

## Medios

8. Probar instalación limpia y disponibilidad/ausencia de winget, PATH, permisos, red, npm/npx y reintentos.
9. Pruebas negativas: 404, blob SHA incorrecto, SHA-256 incorrecto, repo privado no autorizado, timeout npm, Vercel no autenticado, RDC duplicado y handshake incompleto.
10. Confirmar que el lanzador no deja artefacto local permanente del script; permitir solo buffers en memoria, logs y cachés/configuración de herramientas necesarios para la operación.

## Criterio de aceptación

La aceptación requiere cobertura reproducible de GitHub device authorization → acceso privado → integridad del script → preparación CLI requerida → RDC no persistente y handshake verificado, junto con pruebas negativas y read-back del código y OCP en `main`. Mientras falten los ítems 1–3, el bootstrap permanece NO ACEPTADO.
