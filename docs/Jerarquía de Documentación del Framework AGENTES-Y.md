| Nivel Meta (Protocolo Cognitivo) | docs/manual-operativo.md | Configurar el comportamiento del modelo, definir restricciones operativas y estándares de respuesta antes de procesar código. | Al inicio de la sesión o dentro del System Prompt. | Brevedad en tokens, arquitectura de "Lazy Loading" y uso de orquestación para tareas extensas. | Protocolo de recuperación, modelo de orquestador/sub-agentes y ancla de la verdad contra alucinaciones. | Leer el manual para entender las restricciones y el estándar de respuesta ante instrucciones iniciales. | [1, 2] |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Nivel Contexto (Mapa del Territorio) | Agent.md | Situar al agente en el dominio específico del proyecto, proporcionando la arquitectura, estándares y mapa del repositorio. | Inmediatamente después del manual operativo, como contexto principal. | Máximo 500 líneas (idealmente entre 250 y 500) para mantener una alta densidad de señal/ruido. | Visión general, mapa del repositorio, índice de skills, flujos de trabajo y stack tecnológico. | Analizar para comprender la estructura del repositorio, objetivos actuales y ubicación de recursos. | [1-3] |
| Nivel Funcional (Activación bajo demanda) | skills/*.md | Cargar capacidades técnicas específicas de forma modular para optimizar el uso de la ventana de contexto. | Solo cuando se activa un disparador específico durante la ejecución de la tarea; nunca de forma proactiva. | Aislamiento de capacidades; si una skill supera las 500 líneas, debe refactorizarse y dividirse. | Trigger (activador), Scope (alcance), Tools (herramientas) y Resources (plantillas One-Shot). | Autoinvocación: buscar y leer la skill correspondiente cuando la solicitud del usuario coincide con el trigger. | [1-3] |

---

## Fuentes

[1] guia-orden-instrucciones.pdf
[2] manual-operativo.md
[3] Agent.md