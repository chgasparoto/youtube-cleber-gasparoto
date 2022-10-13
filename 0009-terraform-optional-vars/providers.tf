provider "aws" {
  region  = "eu-central-1"
  profile = "mac_cgasparoto"

  default_tags {
    tags = {
      Project     = "Terraform Module Object Attributes"
      ManagedBy   = "Terraform"
      CreatedAt   = "October 2022"
      Environment = "dev"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "random_pet" "bucket_name" {
  prefix = data.aws_caller_identity.current.account_id
  length = 2
}
