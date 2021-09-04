resource "aws_ssm_parameter" "dynamodb_table" {
  name  = "${var.service_name}-dynamodb-table"
  type  = "String"
  value = aws_dynamodb_table.this.name
}
