data "archive_file" "got" {
  type        = "zip"
  source_file = "${local.lambdas_path}/got/index.js"
  output_path = "files/got-artefact.zip"
}

resource "aws_lambda_function" "got" {
  function_name = "got"
  description   = "Gets a random cat image"

  handler = "index.handler"
  role    = aws_iam_role.got.arn
  runtime = "nodejs14.x"

  filename         = data.archive_file.got.output_path
  source_code_hash = data.archive_file.got.output_base64sha256

  layers = [aws_lambda_layer_version.got.arn]

  timeout     = 5
  memory_size = 128

  tags = local.common_tags
}
