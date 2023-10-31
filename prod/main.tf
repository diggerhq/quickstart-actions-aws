terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.0.0"  # Use an appropriate version
    }
  }
    backend "s3" {
    bucket = "8046b8f4c208f5bb-bucket-tfstate"
    key    = "terraform/state"
    region = "us-east-1"
  }

}

provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "aws_vpc" "vpc_network" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-network"
  }
}

resource "aws_subnet" "vpc_subnet" {
  vpc_id                  = aws_vpc.vpc_network.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"  
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-subnet"
  }
}

resource "aws_security_group" "security_group" {
  name_prefix = "terraform-"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm_instance" {
  ami             = "ami-0b17ac7207aae009f"  #Debian 11 (bullsey AMI provided by the Debian Project https://wiki.debian.org/Cloud/AmazonEC2Image/Bullseye)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.vpc_subnet.id
  security_groups = [aws_security_group.security_group.name]
  tags = {
    Name = "terraform-instance"
  }
}
