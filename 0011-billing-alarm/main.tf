terraform {
  required_version = "~> 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = var.aws_profile

  default_tags {
    tags = {
      Project     = "Cloudwatch Billing Alarm"
      ManagedBy   = "Terraform"
      CreatedAt   = "October 2022"
      Environment = "dev"
    }
  }
}
