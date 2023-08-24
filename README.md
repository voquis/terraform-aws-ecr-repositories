# Terraform module to create ECR Repositories


## Examples
### Create multiple repositories
```terraform
module "ecr" {
  source  = "voquis/ecr-repositories/aws"
  version = "0.0.1"

  ecr_repositories = [
    "my-repo-1",
    "my-repo-2",
  ]
}
```

### Create repositories with default lifecycle policy
By setting `use_default_lifecycle_policy = true`, All repositories will be created with a policy that:
 - Expires all untagged images after a day
 - Expires all feature branch images after 14 days (tags prefixed with `feature-branch`)
 - Keeps 30 most recent images of tags starting with `main`

```terraform
module "ecr" {
  source  = "voquis/ecr-repositories/aws"
  version = "0.0.1"

  ecr_repositories = [
    "my-repo-1",
    "my-repo-2",
  ]

  use_default_lifecycle_policy = true
}
```

### Create repositories with custom lifecycle policies
To use a custom JSON lifecycle policy for all repositories, set the `lifecycle_policy` string.

```terraform
module "ecr" {
  source  = "voquis/ecr-repositories/aws"
  version = "0.0.1"

  ecr_repositories = [
    "my-repo-1",
    "my-repo-2",
  ]

  lifecycle_policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
```

### Allow other AWS accounts read-access to repositories
To create repository policies that allow other AWS accounts, e.g. for Lambda deployments to pull images, provide a list of AWS account IDs as `allowed_account_ids`:
```terraform
module "ecr" {
  source  = "voquis/ecr-repositories/aws"
  version = "0.0.1"

  ecr_repositories = [
    "my-repo-1",
    "my-repo-2",
  ]

  allowed_account_ids = [
    "12345678901",
    "23456789012",
  ]
}
```
