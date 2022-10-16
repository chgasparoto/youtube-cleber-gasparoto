locals {
  account_id     = data.aws_caller_identity.current.account_id
  component_name = "tf-s3-lambda"

  lambdas_path = "${path.module}/../lambdas"

  readme_file      = "README.md"
  readme_file_path = "${path.module}/../${local.readme_file}"
}
