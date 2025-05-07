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
