output "bucket" {
  value = {
    arn  = aws_s3_bucket.lambda.arn
    name = aws_s3_bucket.lambda.id
  }
}

output "lambda" {
  value = {
    arn        = aws_lambda_function.s3_trigger.arn
    name       = aws_lambda_function.s3_trigger.function_name
    invoke_arn = aws_lambda_function.s3_trigger.invoke_arn
  }
}
