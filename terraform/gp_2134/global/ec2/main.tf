terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
  backend "s3" {
    bucket         = "nsuslab-devops-terraform-state"
    key            = "digger/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = false
    dynamodb_table = "nsuslab-devops-lock-table"
    role_arn       = "arn:aws:iam::651482608654:role/assumable-cicd-role"
  }
}



provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "aws_vpc" "vpc_network2" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-network-np2"
  }
}