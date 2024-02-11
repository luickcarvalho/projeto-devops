provider "aws" {
  region = var.aws_region
  profile = "tf"

  default_tags {
    tags = {
    Env     = "PRD"
    Team    = "INFRA"
    Project = "Comment"
    }
  }
}

