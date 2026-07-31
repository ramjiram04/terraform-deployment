provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-00d2dbb426772b03a"
  instance_type = "t3.micro"

  tags = {
    Name = "Jenkins-Terraform-Demo-1"
  }
}