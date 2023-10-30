terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.0.0"  # Use an appropriate version
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "random_string" "bucket_prefix" {
  length  = 8
  special = false
}

resource "aws_s3_bucket" "default" {
  bucket = "${random_string.bucket_prefix.result}-bucket-tfstate"
  acl    = "private"  # You can adjust the ACL as needed
  versioning {
    enabled = true
  }
}
