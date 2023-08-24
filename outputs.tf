output "ecr_repository" {
  value = aws_ecr_repository.this
}

output "ecr_lifecycle_policy" {
  value = aws_ecr_lifecycle_policy.this
}

output "ecr_repository_policy" {
  value = aws_ecr_repository_policy.this
}
