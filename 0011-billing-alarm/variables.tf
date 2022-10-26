variable "aws_profile" {
  description = "AWS profile to run Terraform with"
  type        = string
  default     = "default"
}

variable "threshold" {
  description = "The threshold that will trigger the metric alarm"
  type        = string
}

variable "currency" {
  description = "Currency type (e.g. USD, CAD, EUR)"
  type        = string
  default     = "USD"
}

variable "email" {
  description = "The email to subscribe to the SNS topic"
  type        = string
}
