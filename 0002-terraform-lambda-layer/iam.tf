data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cat_api_lambda" {
  name               = "cat-api-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "create_logs_cloudwatch" {
  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_policy" "create_logs_cloudwatch" {
  name   = "create-cw-logs-policy"
  policy = data.aws_iam_policy_document.create_logs_cloudwatch.json
}

resource "aws_iam_role_policy_attachment" "cat_api_cloudwatch" {
  policy_arn = aws_iam_policy.create_logs_cloudwatch.arn
  role       = aws_iam_role.cat_api_lambda.name
}
