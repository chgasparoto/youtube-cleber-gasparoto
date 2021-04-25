data "archive_file" "cat_api" {
  type        = "zip"
  source_file = "${local.lambdas_path}/cat-api/index.js"
  output_path = "files/cat-api-lambda-artefact.zip"
}

resource "aws_lambda_function" "cat_api" {
  function_name = "cat_api"
  description   = "Gets a random cat image"
  handler       = "index.handler"
  role          = aws_iam_role.cat_api_lambda.arn
  runtime       = "nodejs14.x"

  filename         = data.archive_file.cat_api.output_path
  source_code_hash = data.archive_file.cat_api.output_base64sha256

  timeout     = 5
  memory_size = 128

  layers = [aws_lambda_layer_version.got.arn]

  tags = local.common_tags
}
