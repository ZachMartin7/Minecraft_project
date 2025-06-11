#!/bin/bash

set -e

# Update package index
sudo yum update -y

# Install Docker
sudo amazon-linux-extras install docker -y
sudo yum install -y docker

# Start and enable Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add ec2-user to docker group (optional, for non-root usage)
sudo usermod -aG docker ec2-user

# Install Docker Compose (v2 as plugin)
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Create a directory for Minecraft
mkdir -p ~/minecraft
cd ~/minecraft

# Create docker-compose.yml
cat <<EOL > docker-compose.yml
services:
  mc:
    image: itzg/minecraft-server:java21
    ports:
      - 25565:25565
    environment:
      EULA: "TRUE"
    tty: true
    stdin_open: true
    restart: unless-stopped
    volumes:
      - ./minecraft-data:/data
EOL

# Start the Minecraft server with Docker Compose
sudo docker compose up -d

# Print status of the Minecraft container
sudo docker ps --filter "ancestor=itzg/minecraft-server:java21"
