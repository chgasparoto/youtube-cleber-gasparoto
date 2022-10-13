output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.website.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.website.id
}

output "domain" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket_website_configuration.website.website_domain
}

output "endpoint" {
  description = "Endpoint of the bucket"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}
