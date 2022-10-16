data "archive_file" "s3_trigger" {
  type        = "zip"
  source_dir  = "${local.lambdas_path}/s3-trigger"
  output_path = "files/${local.component_name}-artefact.zip"
}

resource "aws_lambda_function" "s3_trigger" {
  function_name = local.component_name
  role          = aws_iam_role.s3_lambda.arn
  runtime       = "nodejs16.x"
  architectures = ["arm64"]
  handler       = "index.handler"

  filename         = data.archive_file.s3_trigger.output_path
  source_code_hash = data.archive_file.s3_trigger.output_base64sha256
}

resource "aws_lambda_permission" "s3" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_trigger.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.lambda.arn
}
