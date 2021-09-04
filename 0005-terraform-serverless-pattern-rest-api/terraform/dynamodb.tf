resource "aws_dynamodb_table" "this" {
  name         = var.service_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "N"
  }
}
