resource "aws_cloudwatch_log_group" "s3_trigger" {
  name              = "/aws/lamda/${aws_lambda_function.s3_trigger.function_name}"
  retention_in_days = 3
}
