# -------------------------------------------------------------------------------------------------
# Required variables
# -------------------------------------------------------------------------------------------------

variable "ecr_repositories" {
  type        = list(string)
  description = "List of ECR repository names to create"
}

# -------------------------------------------------------------------------------------------------
# Optional variables
# -------------------------------------------------------------------------------------------------

variable "image_tag_mutability" {
  type        = string
  description = "Whether image tags can be changed (mutated) or not (immutable)"
  default     = "MUTABLE"
}

variable "allowed_account_ids" {
  type        = list(string)
  description = "List of AWS account IDs that should have permissions to pull images from ECR repositories in this account"
  default     = null
}

variable "use_default_lifecycle_policy" {
  type        = bool
  description = "Whether to use the default lifecycle policy for all repositories"
  default     = false
}

variable "lifecycle_policy" {
  type        = string
  description = "JSON ECR lifecycle policy"
  default     = null
}
