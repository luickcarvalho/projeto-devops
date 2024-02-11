locals {
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last ${var.ecr_lifecycle_count_images} images",
        selection = {
          tagStatus     = "any",
          countType     = "imageCountMoreThan",
          countNumber   = var.ecr_lifecycle_count_images
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}


module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.4.0"

  create = (var.ecr_repository_name == null) ? false : true

  repository_lifecycle_policy = var.ecr_repository_lifecycle_policy == null ? local.repository_lifecycle_policy : var.ecr_repository_lifecycle_policy
  repository_image_tag_mutability = var.ecr_image_tag_mutability

  repository_name = var.ecr_repository_name
}
