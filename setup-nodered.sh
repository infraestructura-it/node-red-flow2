#!/bin/bash

echo "🔧 Creando entorno para Node-RED en Codespaces..."

# Crear carpetas
mkdir -p .devcontainer
mkdir -p .github/workflows

# Crear devcontainer.json
cat > .devcontainer/devcontainer.json << 'EOF'
{
  "name": "Node-RED Dev",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "forwardPorts": [1880],
  "postCreateCommand": "node-red"
}
EOF

# Crear Dockerfile
cat > .devcontainer/Dockerfile << 'EOF'
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl gnupg iputils-ping net-tools traceroute && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g --unsafe-perm node-red && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /data
EXPOSE 1880
CMD ["node-red"]
EOF

# Crear workflow de GitHub Actions
cat > .github/workflows/main.yml << 'EOF'
name: CI - Node-RED

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Clonar repo
        uses: actions/checkout@v3

      - name: Construir imagen Docker
        run: docker build -t nodered-app .

      - name: Ejecutar contenedor
        run: docker run -d -p 1880:1880 --name nodered-app nodered-app

      - name: Verificar ejecución
        run: docker exec nodered-app node-red --version
EOF

# Crear README si no existe
if [ ! -f README.md ]; then
  echo "# node-red-flow2" > README.md
  echo "Proyecto Node-RED usando Codespaces con Dev Container." >> README.md
fi

echo "✅ Entorno creado. Haz commit y push al repo."
