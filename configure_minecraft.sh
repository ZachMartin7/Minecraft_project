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

# Install Docker Compose (standalone binary)
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

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
sudo /usr/local/bin/docker-compose up -d

# Print status of the Minecraft container
sudo docker ps --filter "ancestor=itzg/minecraft-server:java21"
