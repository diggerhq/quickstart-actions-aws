terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
    backend "s3" {
    bucket = "alexp-digger-s3backend-test"
    key    = "terraform/state"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"  # Replace with your desired AWS region
}

resource "aws_s3_bucket" "test" {
  bucket = "alexp-test-12345"
  acl    = "private"
}
