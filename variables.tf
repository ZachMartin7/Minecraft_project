variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of EC2 instance to use for the Minecraft server."
  type        = string
  default     = "t3.small"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the instance."
  type        = string
}

variable "minecraft_server_ami" {
  description = "The AMI ID for the Minecraft server."
  type        = string
}

variable "minecraft_server_port" {
  description = "The port on which the Minecraft server will run."
  type        = number
  default     = 25565
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}