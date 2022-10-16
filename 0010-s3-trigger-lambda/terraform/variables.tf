variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "aws_profile" {
  description = "AWS profile to run Terraform with"
  type        = string
  default     = "default"
}
