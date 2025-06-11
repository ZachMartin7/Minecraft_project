#!/bin/bash

set -e

# Update package index
sudo yum update -y

sudo amazon-linux-extras install docker -y
sudo yum install -y docker

sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker ec2-user

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir -p ~/minecraft
cd ~/minecraft

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


sudo /usr/local/bin/docker-compose up -d

sudo docker ps --filter "ancestor=itzg/minecraft-server:java21"
