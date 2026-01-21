#!/bin/bash

# setup.sh
# Script de inicialización para el framework AGENTES-Y-SKILLS.
# Crea enlaces simbólicos para que diferentes LLMs (Claude, Gemini, GPT)
# reconozcan el contexto maestro 'Agent.md'.

# Archivo fuente de contexto maestro
SOURCE="Agent.md"

# Archivos objetivo para diferentes plataformas (según manual operativo)
TARGETS=("claudem.md" "gemini.md" "gpt.md")

# Verificar si existe el archivo fuente
if [ ! -f "$SOURCE" ]; then
    echo "Error: No se encuentra '$SOURCE' en el directorio actual."
    echo "Asegúrate de ejecutar este script desde la raíz del proyecto."
    exit 1
fi

echo "Configurando entorno de Agentes..."

for target in "${TARGETS[@]}"; do
    # Crear o actualizar enlace simbólico (-s: simbólico, -f: forzar si existe)
    ln -sf "$SOURCE" "$target"
    echo "Enlace creado/actualizado: $target -> $SOURCE"
done

echo "Configuración completada. El entorno es agnóstico al modelo."