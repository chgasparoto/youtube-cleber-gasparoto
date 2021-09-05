resource "aws_dynamodb_table" "this" {
  name         = local.namespaced_service_name
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "N"
  }
}

resource "aws_dynamodb_table_item" "this" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = <<ITEM
{
  "id": {"N": "1"},
  "task": {"S": "dar like no video"},
  "done": {"S": "false"}
}
ITEM
}
