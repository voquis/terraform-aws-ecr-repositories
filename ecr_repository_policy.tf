# This policy allows ECR read-only access from other AWS accounts
# https://aws.amazon.com/blogs/compute/introducing-cross-account-amazon-ecr-access-for-aws-lambda/
#
# Note that the role deploying the lambda (e.g. GitHub Actions) also needs pull permissions

resource "aws_ecr_repository_policy" "this" {
  for_each = var.allowed_account_ids != null ? toset(var.ecr_repositories) : toset([])

  repository = aws_ecr_repository.this[each.value].name
  policy     = data.aws_iam_policy_document.ecr_repository_policy["k"].json
}

data "aws_iam_policy_document" "ecr_repository_policy" {
  for_each = var.allowed_account_ids != null ? toset(["k"]) : toset([])

  statement {
    principals {
      type        = "AWS"
      identifiers = [for a in var.allowed_account_ids : "arn:aws:iam::${a}:root"]
    }

    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
    ]
  }

  statement {
    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com"
      ]
    }

    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
    ]

    condition {
      test     = "StringLike"
      variable = "aws:sourceArn"

      values = [for a in var.allowed_account_ids : "arn:aws:lambda:eu-west-2:${a}:function:*"]
    }
  }
}
