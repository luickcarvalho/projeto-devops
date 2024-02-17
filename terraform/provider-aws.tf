provider "aws" {
  region  = var.aws_region
  profile = var.profile

  default_tags {
    tags = {
      Env     = "PRD"
      Team    = "INFRA"
      Project = "Comment"
    }
  }
}

