# -------------------------------------------------------------------------------------------------
# ECR repositories to create
# -------------------------------------------------------------------------------------------------

resource "aws_ecr_repository" "this" {
  for_each = toset(var.ecr_repositories)

  name                 = each.value
  image_tag_mutability = var.image_tag_mutability
}
