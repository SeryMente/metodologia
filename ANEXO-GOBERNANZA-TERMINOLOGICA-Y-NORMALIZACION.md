# Anexo — Gobernanza terminológica y normalización

**Estado:** PROCEDIMIENTO DE APOYO · SUBORDINADO AL GOW  
**Versión:** v1.1 · Fuente preponderante: `SeryMente/metodologia/main`  
**Relación:** desarrolla el contrato de revisión/normalización del GOW, y complementa Sam P008 y Metacanon §§43–45.

## 1. Fuente única

El único glosario canónico es [Glosario Operativo del Workspace (GOW)](gobernanza/GLOSARIO-WORKSPACE.md). El archivo raíz `GLOSARIO-OPERATIVO.md` es un puntero de compatibilidad, no una autoridad paralela; su original v1.3.1 se conserva en `frentes/metodologia/antecedentes/GLOSARIO-OPERATIVO-v1.3.1.md`. Notion y otras copias son espejos subordinados.

## 2. Flujo de normalización

Entrada dictada/transcrita → identificar el posible término → consultar el GOW de `main` → clasificar el resultado → normalizar solo si el contexto y la entrada canónica lo autorizan → continuar el procesamiento → emitir la forma canónica. Conservar la entrada original y separar de ella la interpretación normalizada.

## 3. Tipos de entrada

- **CANÓNICO:** coincide con una entrada canónica vigente.
- **ALIAS:** variante expresamente asociada a un término canónico; se normaliza únicamente si el contexto confirma el referente.
- **DESCONOCIDO:** no hay asociación canónica suficiente; no inventarla.
- **AMBIGUO:** hay más de un referente plausible; explicitar la ambigüedad y preguntar una vez si afecta materialmente el resultado.

Registrar nuevas asociaciones solo cuando el operador lo solicite expresamente. Las ya aprobadas se aplican sin volver a preguntar cuando el referente es inequívoco. La normalización cambia la forma terminológica, no el sentido sustantivo de la intención.

## 4. Preponderancia y revisión

`SeryMente/metodologia/main` determina la revisión vigente. Ante diferencia entre este anexo, Notion, las instrucciones personalizadas o cualquier copia, prevalecen el GOW y las reglas verificadas del repositorio. Revisar el GOW al inicio y antes de cerrar cada ciclo, sin excepción. Si no puede consultarse `main`, declarar `GOW NO VERIFICADO`. La mención de un término o protocolo no activa por sí sola el protocolo ni generaliza un vocabulario local a todos los proyectos.

## 5. Correcciones conocidas

| Entrada probable de dictado | Forma canónica | Condición |
|---|---|---|
| CSEC | CECEQ | Cuando el contexto confirma la ubicación de trabajo correspondiente. |
| CSEQ | CECEQ | Cuando el contexto confirma la ubicación de trabajo correspondiente. |
| Cora / CORA / C-O-R-A | KHORA | Solo si el contexto confirma la prótesis/sistema Khora; conservar otra entidad llamada Cora/CORA. |
| SAM | Sam | Solo si el contexto confirma que se refiere al Metaprompt Canónico de Samantha. |
| «fuentes de trabajo» | frentes de trabajo | Solo si el contexto identifica inequívocamente ese objeto; conservar el dictado original. |

Estas asociaciones no se amplían a nuevos términos sin instrucción explícita del operador. Una forma de marca como «Khora» o «Khora OS» puede conservar su capitalización de producto en contextos de nombre comercial; la forma normalizada de identificador es KHORA cuando aplica.

## 6. Alcance

El GOW se consulta antes de emitir nombres de personas/sistemas, identificadores, ubicaciones, productos, repositorios y términos operativos canonizados. No normalizar automáticamente vocabulario libre sin entrada canónica. Un término de alcance particular se aplica solo dentro de su alcance registrado y su presencia en el GOW no lo convierte automáticamente en regla universal. No corregir retrospectivamente originales, citas o historial.
