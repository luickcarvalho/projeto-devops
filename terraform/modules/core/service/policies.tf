data "aws_iam_policy_document" "allow_cloudwatch_logstream" {
  statement {
    sid = "AllowCloudWatchCreatLogStream"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream"
    ]

    resources = [
      "${aws_cloudwatch_log_group.this.arn}*"
    ]
  }

  depends_on = [ aws_cloudwatch_log_group.this ]
}

data "aws_iam_policy_document" "allow_cloudwatch_logevents" {
  statement {
    sid = "AllowCloudWatchPutLogEvents"
    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.this.arn}:log-stream:*"
    ]
  }

  depends_on = [ aws_cloudwatch_log_group.this ]
}

data "aws_iam_policy_document" "allow_ecr_repo" {
  count = var.ecr_repository_name != null || var.ecr_arn != null ? 1 : 0
  statement {
    sid = "AllowEcrRepo"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]

    resources = [
      local.repository_arn
    ]
  }

  depends_on = [ module.ecr ]
}

data "aws_iam_policy_document" "allow_ecr" {
  statement {
    sid = "AllowEcrToken"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [ "*" ]
  }

  depends_on = [ module.ecr ]
}

data "aws_iam_policy_document" "allow_ssm_exec" {
  statement {
    sid = "AllowSsmExec"
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]

    resources = [
      "*"
    ]
  }
}
