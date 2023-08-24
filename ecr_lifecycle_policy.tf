# -------------------------------------------------------------------------------------------------
# ECR lifecycle policies to clean up old images
# -------------------------------------------------------------------------------------------------

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = (var.use_default_lifecycle_policy || var.lifecycle_policy != null) ? toset(var.ecr_repositories) : toset([])

  repository = aws_ecr_repository.this[each.value].name
  policy     = var.use_default_lifecycle_policy ? file("${path.module}/ecr_lifecycle_policy.json") : var.lifecycle_policy
}
