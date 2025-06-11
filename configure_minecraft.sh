#!/bin/bash

# Update package index
sudo apt update

# Install Docker and Docker Compose
sudo apt install -y docker.io docker-compose

# Enable and start Docker
sudo systemctl enable --now docker

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