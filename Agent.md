# Agent.md: Contexto Maestro - AGENTES-Y-SKILLS

## 1. Visión General del Proyecto
Este repositorio aloja el framework "AGENTES-Y-SKILLS", una arquitectura diseñada para optimizar el rendimiento de LLMs en ingeniería de software. El objetivo es superar las limitaciones de ventana de contexto mediante la modularización del conocimiento (Skills) y la jerarquización del contexto.

## 2. Arquitectura del Sistema
El sistema se basa en tres pilares fundamentales:
1.  **Contexto Jerárquico:** Uso de `Agent.md` en la raíz y en subdirectorios de features para mantener el contexto relevante y ligero (< 500 líneas).
2.  **Carga Dinámica (Lazy Loading):** Las capacidades específicas se aíslan en "Skills" y solo se cargan mediante *Triggers* específicos.
3.  **Abstracción de Infraestructura:** Scripts de sincronización (`setup.sh`) para compatibilidad multiplataforma (Claude, Gemini, GPT).

## 3. Mapa del Repositorio
*   `/`: Raíz del proyecto. Contiene configuración global y este `Agent.md`.
*   `/skills`: Directorio de habilidades modulares.
    *   `skill-creator`: Habilidad para generar nuevas skills.
    *   `skill-sync`: Habilidad para sincronizar referencias y symlinks.
*   `/docs`: Documentación humana y manuales operativos (ej. `manual-operativo.md`).
*   `setup.sh`: Script de inicialización de entorno para agentes.

## 4. Estándares Operativos (Protocolo)
### Gestión de Contexto
*   **Densidad:** Mantener archivos `Agent.md` con alta relación señal/ruido. Eliminar redundancias.
*   **Límites:** Máximo 500 líneas por archivo de contexto.
*   **Orquestación:** Para tareas que excedan el scope de un archivo o requieran iteración masiva, delegar en sub-agentes y solicitar un resumen final.

### Definición de Skills
Toda nueva funcionalidad debe encapsularse como una Skill en `/skills/<nombre-skill>/skill.md` conteniendo:
*   **Trigger:** Cuándo activar.
*   **Scope:** Dónde es válido.
*   **Tools:** Herramientas permitidas.
*   **Resources:** Templates One-Shot para ejecución precisa.

## 5. Flujos de Trabajo Comunes
1.  **Inicialización:** Ejecutar `./setup.sh` para crear enlaces simbólicos (`claudem.md`, `gemini.md` -> `Agent.md`).
2.  **Creación de Skills:** Invocar la skill `skill-creator` siguiendo el template estándar.
3.  **Mantenimiento:** Usar `skill-sync` tras añadir skills para actualizar índices.

## 6. Stack Tecnológico
*   **Core:** Markdown (Documentación como Código), Bash.
*   **Target:** LLMs con soporte de contexto largo (Claude 3, Gemini 1.5, GPT-4).