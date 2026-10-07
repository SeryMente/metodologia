# Anexo - Gobernanza Terminologica y Normalizacion

**Estado:** CANONICO  
**Fecha:** 2026-10-07  
**Relacion:** desarrolla P007 y P008.

## 1. Fuente unica

`GLOSARIO-OPERATIVO.md` es la fuente metodologica transversal para forma y significado de terminos canonizados.

## 2. Flujo

Entrada dictada o transcrita -> detectar termino potencial -> consultar glosario -> normalizar a forma canonica -> continuar procesamiento -> emitir forma canonica.

## 3. Tipos de entrada

- CANONICO: coincide con la entrada registrada.
- ALIAS: variante registrada con correspondencia canonica.
- DESCONOCIDO: no existe correspondencia suficiente.
- AMBIGUO: existen varias correspondencias plausibles.

CANONICO se usa directamente. ALIAS se normaliza. DESCONOCIDO y AMBIGUO no se convierten por invencion en una forma canonica.

## 4. Prioridad

La normalizacion afecta la forma terminologica, no el contenido sustantivo de la intencion del usuario. Cuando una variante puede representar tanto un error de transcripcion como un termino distinto, prevalece la incertidumbre hasta contar con evidencia suficiente.

## 5. Correcciones conocidas

| Entrada probable de dictado | Canon |
|---|---|
| CSEC | CECEQ |
| CSEQ | CECEQ |
| Cora | KHORA |

Estas son reglas de normalizacion conocidas, no nuevas formas aceptadas.

## 6. Alcance

El glosario se aplica antes de emitir identificadores, nombres propios, ubicaciones, nombres de productos, nombres de repositorios y otros terminos canonizados. No corrige automaticamente vocabulario libre que no tenga entrada en el glosario.
