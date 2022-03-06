terraform {
  #required_version = "~> 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.3.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = var.aws_profile
  region  = var.aws_region
}