data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "got" {
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

resource "aws_iam_role" "got" {
  name               = "got-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json

  tags = local.common_tags
}

resource "aws_iam_policy" "got" {
  name   = "${aws_lambda_function.got.function_name}-lambda-execute-policy"
  policy = data.aws_iam_policy_document.got.json
}

resource "aws_iam_role_policy_attachment" "got" {
  policy_arn = aws_iam_policy.got.arn
  role       = aws_iam_role.got.name
}
