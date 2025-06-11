provider "aws" {
  region = "us-west-2"  
}

resource "aws_vpc" "minecraft_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "minecraft_subnet" {
  vpc_id            = aws_vpc.minecraft_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"  
}

resource "aws_internet_gateway" "minecraft_igw" {
  vpc_id = aws_vpc.minecraft_vpc.id
}

resource "aws_route_table" "minecraft_route_table" {
  vpc_id = aws_vpc.minecraft_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_igw.id
  }
}

resource "aws_route_table_association" "minecraft_route_table_association" {
  subnet_id      = aws_subnet.minecraft_subnet.id
  route_table_id = aws_route_table.minecraft_route_table.id
}

resource "aws_security_group" "minecraft_sg" {
  vpc_id = aws_vpc.minecraft_vpc.id

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft_server" {
  ami                         = "ami-0af0429ede3441933"  
  instance_type               = "t3.small"  
  subnet_id                   = aws_subnet.minecraft_subnet.id
  vpc_security_group_ids      = [aws_security_group.minecraft_sg.id]
  associate_public_ip_address = true   
  key_name = var.key_name

  tags = {
    Name = "MinecraftServer"
  }
}