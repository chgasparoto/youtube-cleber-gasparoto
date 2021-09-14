resource "aws_ssm_parameter" "dynamodb_table" {
  name  = "${local.namespaced_service_name}-dynamodb-table"
  type  = "String"
  value = aws_dynamodb_table.this.name
}
