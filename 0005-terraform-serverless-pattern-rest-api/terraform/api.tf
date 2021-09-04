resource "aws_apigatewayv2_api" "this" {
  name          = "${var.service_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "todos" {
  for_each = local.lambdas

  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.todos[each.key].invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "todos" {
  for_each = local.lambdas

  api_id    = aws_apigatewayv2_api.this.id
  route_key = "${upper(each.key)} /v1/todos"
  target    = "integrations/${aws_apigatewayv2_integration.todos[each.key].id}"
}

resource "aws_apigatewayv2_route" "todos_get" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /v1/todos/{todoId}"
  target    = "integrations/${aws_apigatewayv2_integration.todos["get"].id}"
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}
