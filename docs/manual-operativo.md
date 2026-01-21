# Manual Operativo: Sistema de Arquitectura de Agentes y Skills

Como inteligencia artificial, tu objetivo es operar de manera eficiente dentro de un repositorio de software utilizando una estructura diseñada para **optimizar tu ventana de contexto** y maximizar la precisión de tus respuestas,.

## 1. El Archivo `Agent.md` (Tu Contexto Maestro)

El archivo `Agent.md` es el equivalente al `README.md` humano, pero optimizado exclusivamente para agentes de IA,. 

*   **Propósito:** Proporcionarte el contexto técnico y "cultural" de un proyecto (arquitectura, estándares de código, flujos de trabajo),.
*   **Restricción de Eficiencia:** Para evitar "alucinaciones" y procesamiento ineficiente, este archivo debe mantenerse entre las **250 y 500 líneas** de texto máximo,.
*   **Jerarquía de Contexto:**
    *   **Agent Root:** En la raíz del proyecto, actúa como un mapa que te indica dónde encontrar información más específica,.
    *   **Agents por Feature:** En proyectos grandes o monorepos, existen archivos `Agent.md` locales (ej. en carpetas `/ui` o `/api`) para reducir la carga de información irrelevante a la tarea actual,,.

## 2. El Sistema de Skills (Habilidades)

Las **Skills** son unidades modulares de conocimiento que debes cargar solo cuando sea estrictamente necesario para **reducir el contexto** activo en tu memoria operativa,,.

### Estructura de una Skill (`skill.md`)
Cada habilidad se organiza en una carpeta con un archivo de metadatos que incluye:
*   **Trigger (Activador):** Instrucción específica que te indica cuándo autoinvocarte (ej. "cuando trabajes con Next.js o Server Actions"),.
*   **Scope (Alcance):** Define el área del proyecto donde la skill es aplicable (UI, API, Root),.
*   **Tools:** Lista de herramientas que puedes utilizar al ejecutar esta habilidad (lectura, escritura, búsquedas en internet),.
*   **Resources (One-Shot):** Incluye **templates** y ejemplos detallados para que logres el resultado correcto en el primer intento,.

## 3. Modelo Operativo: Orquestador y Sub-agentes

Cuando te enfrentas a tareas complejas o masivas, debes operar bajo el modelo de **Orquestador**,.

1.  **Delegación:** No ejecutes tareas repetitivas o extensas (como editar 500 archivos) directamente en tu contexto principal. En su lugar, genera **sub-agentes** independientes,.
2.  **Contexto Independiente:** Cada sub-agente tiene su propia burbuja de contexto, lo que evita "ensuciar" tu memoria principal,.
3.  **Resumen de Ejecución:** Una vez finalizada la tarea, el sub-agente solo debe devolverte un **resumen detallado** de lo realizado para que lo integres a tu flujo de trabajo,.

## 4. Implementación Multimodelo y Sincronización

Debido a que diferentes plataformas de IA requieren nombres de archivo específicos, el sistema utiliza un script de configuración (`setup.sh`) para crear **enlaces simbólicos (symlinks)**,. Esto asegura que las mismas habilidades estén disponibles para ti, sin importar si estás operando como Claude (`claudem.md`), Gemini (`gemini.md`) o GPT,,.

### Instrucciones para el Agente:
*   **Autoinvocación:** Revisa siempre los metadatos de las skills. Si detectas que una solicitud del usuario coincide con un *trigger*, carga la skill correspondiente de forma automática,.
*   **Mantenimiento:** Puedes ser requerido para utilizar la skill `skill-creator` para generar nuevas habilidades siguiendo un template predefinido, o `skill-sync` para actualizar las referencias en todos los archivos de configuración del proyecto,.