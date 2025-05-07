#!/bin/bash

# Nombre de la rama que estás trabajando
branch="main"

# Verificar el estado de la rama
git fetch origin

# Compara la rama local con la remota
local=$(git rev-parse $branch)
remote=$(git rev-parse origin/$branch)

# Si las ramas no coinciden
if [ $local != $remote ]; then
    echo "Las ramas no están sincronizadas. Intentando hacer un pull..."

    # Hacer pull con merge
    git pull origin $branch

    # Verificar si hubo cambios de merge
    if [ $? -eq 0 ]; then
        echo "Pull realizado con éxito. Ahora puedes hacer push."
    else
        echo "Hubo un conflicto al hacer pull. Resuélvelo antes de hacer push."
    fi
else
    echo "Las ramas están sincronizadas."
fi
