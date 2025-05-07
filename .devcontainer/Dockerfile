FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias básicas
RUN apt-get update && \
    apt-get install -y curl gnupg net-tools iputils-ping traceroute && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g --unsafe-perm node-red && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo y copiar el flujo
WORKDIR /data
COPY ../data/ /data/

EXPOSE 1880

# Arrancar Node-RED
CMD ["node-red"]

