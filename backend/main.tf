terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"  
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
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.default.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.default.id
  acl    = "private"
}


resource "aws_dynamodb_table" "DiggerDynamoDBLockTable" {
  name             = "DiggerDynamoDBLockTable"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}
