locals {
  # default values
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}


module "ecr_comment" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 1.6.0"

  repository_name                 = var.ecr_comment.repo_name
  repository_image_tag_mutability = var.ecr_comment.image_tag_mutability
  repository_lifecycle_policy     = local.repository_lifecycle_policy

  tags = {
   Name = var.ecr_comment.repo_name
 }
}