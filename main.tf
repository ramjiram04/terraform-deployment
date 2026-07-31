provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-02b64aa047cb5edf5"
  instance_type = "t2.micro"

  tags = {
    Name = "Jenkins-Terraform-Demo"
  }
}