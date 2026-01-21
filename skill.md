# Skill: Skill Sync

## Metadata
*   **Trigger:** Activar cuando el usuario pida "sincronizar", "actualizar entorno", "regenerar symlinks" o después de añadir una nueva skill.
*   **Scope:** Raíz del proyecto.
*   **Tools:** Shell (Bash), File System.

## Propósito
Garantizar que la infraestructura del agente (symlinks y referencias) esté sincronizada con el estado actual del sistema de archivos, especialmente tras cambios estructurales.

## Resources (One-Shot)
### Rutina de Sincronización

1.  **Regenerar Symlinks:**
    Ejecutar el script de setup para asegurar que los contextos de IA (`claudem.md`, `gemini.md`) apunten al `Agent.md` correcto.
    ```bash
    ./setup.sh
    ```

2.  **Verificar Índices:**
    Si se han añadido nuevas carpetas en `/skills/`, verificar si `Agent.md` necesita ser actualizado en la sección "Mapa del Repositorio" para reflejar las nuevas capacidades disponibles.