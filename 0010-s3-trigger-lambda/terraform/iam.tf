data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "s3_lambda" {
  name               = "${local.component_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "s3_lambda" {
  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*"]
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

  statement {
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.lambda.id}/*"]
    actions   = ["s3:GetObject"]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = ["rekognition:DetectFaces"]
  }
}

resource "aws_iam_policy" "s3_lambda" {
  name   = "${local.component_name}-policy"
  policy = data.aws_iam_policy_document.s3_lambda.json
}

resource "aws_iam_role_policy_attachment" "s3_trigger" {
  policy_arn = aws_iam_policy.s3_lambda.arn
  role       = aws_iam_role.s3_lambda.name
}
