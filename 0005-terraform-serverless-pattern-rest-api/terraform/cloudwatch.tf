resource "aws_cloudwatch_log_group" "lambdas" {
  for_each = aws_lambda_function.todos

  name              = "/aws/lambda/${each.value["function_name"]}"
  retention_in_days = 3
}
