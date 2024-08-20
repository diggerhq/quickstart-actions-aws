provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-014d544cfef21b42d"
  instance_type = "t2.micro"

  tags = {
    Name = "Digger-Example"
  }
}
