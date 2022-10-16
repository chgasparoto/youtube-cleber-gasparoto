terraform {
  required_version = "~> 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project     = "Trigger Lamba with S3 Bucket"
      ManagedBy   = "Terraform"
      CreatedAt   = "October 2022"
      Environment = "dev"
    }
  }
}

data "aws_caller_identity" "current" {}
