import {
  to = module.s3.aws_s3_bucket.users
  id = local.imports.bucket_name
}

import {
  to = aws_s3_bucket_versioning.users
  id = local.imports.bucket_name
}

import {
  to = aws_s3_bucket_lifecycle_configuration.users
  id = local.imports.bucket_name
}

import {
  to = aws_dynamodb_table.users
  id = local.imports.dynamodb_table_name
}

module "s3" {
  source = "./s3"

  bucket_name = local.imports.bucket_name
}
