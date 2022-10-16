resource "aws_s3_bucket" "lambda" {
  bucket = "${local.account_id}-${local.component_name}"
}

resource "aws_s3_bucket_acl" "lambda" {
  bucket = aws_s3_bucket.lambda.id
  acl    = "private"
}

resource "aws_s3_object" "readme" {
  bucket       = aws_s3_bucket.lambda.id
  key          = "input/images/${local.readme_file}"
  content_type = "text/markdown; charset=UTF-8"
  source       = local.readme_file_path
  etag         = filemd5(local.readme_file_path)
}

resource "aws_s3_bucket_notification" "s3_trigger" {
  bucket = aws_s3_bucket.lambda.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_trigger.arn
    events              = ["s3:ObjectCreated:*"]
  }
}
