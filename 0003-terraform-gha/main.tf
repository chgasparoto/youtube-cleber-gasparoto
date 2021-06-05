terraform {
  required_version = "0.15.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project   = "Terraform GHA setup"
      CreatedAt = "2021-06-05"
      ManagedBy = "Terraform"
      Owner     = "Cleber Gasparoto"
    }
  }
}
