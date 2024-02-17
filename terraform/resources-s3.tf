module "s3_bucket_comment_codebuild" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.15.2"

  force_destroy = false

  bucket = var.s3.bucket_name_codebuild

  block_public_acls        = var.s3.block_public_acls
  block_public_policy      = var.s3.block_public_policy
  ignore_public_acls       = var.s3.ignore_public_acls
  restrict_public_buckets  = var.s3.restrict_public_buckets
  attach_policy            = var.s3.attach_policy
  control_object_ownership = var.s3.control_object_ownership
  object_ownership         = var.s3.object_ownership

  lifecycle_rule = [
    {
      id      = "INTELLIGENT_TIERING"
      enabled = true
      prefix  = ""

      transition = [
        {
          days          = 0
          storage_class = "INTELLIGENT_TIERING"
        },
      ]
    }
  ]

  versioning = {
    enabled = var.s3.versioning
  }

  tags = {
    Name = var.s3.bucket_name_codebuild
  }
}

