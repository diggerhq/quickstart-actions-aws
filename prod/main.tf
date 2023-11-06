terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
    backend "s3" {
    bucket = "digger-s3backend-quickstart-aws"              # Change if a different S3 bucket name was used for the backend 
    /* Un-comment to use DynamoDB state locking
    dynamodb_table = "digger-locktable-quickstart-aws"      # Change if a different DynamoDB table name was used for backend
    */
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
  availability_zone       = "us-east-1a"  
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-subnet"
  }
}

resource "aws_security_group" "security_group" {
  vpc_id      = aws_vpc.vpc_network.id
  name_prefix = "terraform-"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm_instance" {
  ami             = "ami-05c13eab67c5d8861"                   # us-east-1 Amazon Linux 2023 AMI 2023.2.20231030.1 x86_64 HVM kernel-6.1
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.vpc_subnet.id
  security_groups = [aws_security_group.security_group.id]
  tags = {
    Name = "terraform-instance"
  }
}
