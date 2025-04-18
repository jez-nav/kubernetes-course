# versions.tf
terraform {
  required_version = ">= 1.0" # Specify minimum Terraform version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16" # Or a newer compatible version
    }
  }
}

provider "aws" {
  region = var.aws_region
}
