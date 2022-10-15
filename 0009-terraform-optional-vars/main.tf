module "website_s3_bucket" {
  source = "./modules/s3-hosting-static-website"

  bucket_name = "${random_pet.bucket_name.id}.com"

  files = {
    terraform_managed  = true
    error_document_key = "index.html"
    www_path           = "${path.module}/blog"
  }

  cors_rules = [
    {
      allowed_headers  = ["*"],
      allowed_methods  = ["PUT", "POST"],
      allowed_origins  = ["http:localhost:3000"],
      exposed_headers  = ["Etag"],
      max_aged_seconds = 3000
    },
    {
      allowed_origins = ["*"],
      allowed_methods = ["GET"],
    }
  ]
}
