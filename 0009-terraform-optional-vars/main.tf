module "website_s3_bucket" {
  source = "./modules/s3"

  bucket_name = "${random_pet.bucket_name.id}.com"
  #  bucket_name = random_pet.bucket_name.id

  files = {
    #    terraform_managed = false
    terraform_managed  = true
    www_path           = "${path.module}/blog"
    error_document_key = "index.html"
  }

  cors_rules = [
    {
      allowed_headers = ["*"],
      allowed_methods = ["PUT", "POST"],
      allowed_origins = ["https://test.example.com"],
      expose_headers  = ["ETag"],
      max_age_seconds = 3000
    },
    {
      allowed_methods = ["GET"],
      allowed_origins = ["*"]
    }
  ]
}
