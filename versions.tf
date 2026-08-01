terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "cloud360-agent-statefile"
    key          = "terraform-generator/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
