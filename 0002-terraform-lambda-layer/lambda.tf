data "archive_file" "cat_api_artefact" {
  output_path = "files/cat-api-artefact.zip"
  type        = "zip"
  source_file = "${local.lambdas_path}/cat-api/index.js"
}

resource "aws_lambda_function" "cat_api" {
  function_name = "cat_api"
  handler       = "index.handler"
  description   = "Gets a random cat image"
  role          = aws_iam_role.cat_api_lambda.arn
  runtime       = "nodejs14.x"

  filename         = data.archive_file.cat_api_artefact.output_path
  source_code_hash = data.archive_file.cat_api_artefact.output_base64sha256

  timeout     = 5
  memory_size = 128

  layers = [aws_lambda_layer_version.got.arn]
}
