variables {
  aws_region  = "us-east-1"
  bucket_name = "este-e-um-nome-de-balde-valido-1230987"
}

provider "aws" {
  region = var.aws_region
}

run "validate_inputs" {
  command = plan

  variables {
    aws_region  = "usa-east-1"
    bucket_name = "Nome Invalido"
  }

  expect_failures = [
    var.aws_region,
    var.bucket_name
  ]
}

run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "create_bucket" {
  variables {
    bucket_name = run.setup.bucket_prefix
  }

  assert {
    condition     = aws_s3_bucket.s3_bucket.bucket == var.bucket_name
    error_message = "Invalid bucket name"
  }

  assert {
    condition     = aws_s3_object.index.etag == filemd5("./www/index.html")
    error_message = "Invalid eTag for index.html"
  }

  assert {
    condition     = aws_s3_object.error.etag == filemd5("./www/error.html")
    error_message = "Invalid eTag for error.html"
  }
}

run "website_is_running" {
  command = plan

  module {
    source = "./tests/final"
  }

  variables {
    endpoint = run.create_bucket.website_endpoint
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}
