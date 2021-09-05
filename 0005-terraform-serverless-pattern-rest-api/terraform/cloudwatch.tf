resource "aws_cloudwatch_log_group" "this" {
  for_each = aws_lambda_function.todos

  name              = "/aws/lamda/${each.value["function_name"]}"
  retention_in_days = 3
}
