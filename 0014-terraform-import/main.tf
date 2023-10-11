# https://developer.hashicorp.com/terraform/language/import
# https://developer.hashicorp.com/terraform/language/import/generating-configuration

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.19"
    }
  }
}

provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      "Video"     = "Terraform Import"
      "CreatedAt" = "2023-10-11"
      "ManagedBy" = "Terraform"
    }
  }
}
