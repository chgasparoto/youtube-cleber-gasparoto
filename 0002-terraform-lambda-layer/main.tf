terraform {
  required_version = "0.15.0"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
