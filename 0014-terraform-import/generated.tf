# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "users"
resource "aws_dynamodb_table" "users" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = false
  hash_key                    = "id"
  name                        = "users"
  range_key                   = null
  read_capacity               = 0
  restore_date_time           = null
  restore_source_name         = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = {}
  tags_all = {
    CreatedAt = "2023-10-11"
    Video     = "Terraform Import"
  }
  write_capacity = 0
  attribute {
    name = "id"
    type = "S"
  }
  point_in_time_recovery {
    enabled = false
  }
  ttl {
    attribute_name = ""
    enabled        = false
  }
}

# __generated__ by Terraform from "bucket-do-cleber-criado-no-console-da-aws"
resource "aws_s3_bucket_versioning" "users" {
  bucket                = "bucket-do-cleber-criado-no-console-da-aws"
  expected_bucket_owner = null
  mfa                   = null
  versioning_configuration {
    mfa_delete = null
    status     = "Enabled"
  }
}

# __generated__ by Terraform from "bucket-do-cleber-criado-no-console-da-aws"
resource "aws_s3_bucket_lifecycle_configuration" "users" {
  bucket                = "bucket-do-cleber-criado-no-console-da-aws"
  expected_bucket_owner = null
  rule {
    id     = "move-to-archive"
    status = "Enabled"
    filter {
      object_size_greater_than = null
      object_size_less_than    = null
      prefix                   = "logs"
    }
    transition {
      date          = null
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}
