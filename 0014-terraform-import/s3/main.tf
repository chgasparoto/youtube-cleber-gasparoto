variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  default     = null
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "Invalid S3 bucket name"
  }
}

resource "aws_s3_bucket" "users" {
  bucket = var.bucket_name
}

output "name" {
  value = aws_s3_bucket.users.bucket
}

output "arn" {
  value = aws_s3_bucket.users.arn
}
