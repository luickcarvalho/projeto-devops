data "template_file" "buildspec_comment" {
  template = file("templates/buildspec.yml")

  vars = {
    region         = "${var.aws_region}"
    cluster_name   = "${var.cluster_comment.cluster_name}"
    container_name = "${var.ecs_comment.task_name}"
  }
}

module "codebuild_comment" {
  source  = "cloudposse/codebuild/aws"
  version = "2.0.1"

  name               = var.codebuild.comment_name
  build_timeout      = "60"
  artifact_type      = "S3"
  artifact_location  = var.codebuild.s3_bucket_comment_codebuild
  source_type        = "S3"
  source_location    = "${var.codebuild.s3_bucket_comment_codebuild}/${var.codebuild.comment_zip}"
  build_compute_type = "BUILD_GENERAL1_SMALL"
  build_image        = "aws/codebuild/docker:17.09.0"
  build_type         = "LINUX_CONTAINER"
  privileged_mode    = true
  buildspec          = data.template_file.buildspec_comment.rendered
  iam_policy_path    = "/service-role/"
  extra_permissions = [
    "s3:GetBucketVersioning",
    "s3:GetObjectVersion",
    "s3:PutObject",
    "s3:GetObject",
    "s3:List*",
  "ecs:ServiceUpdate"]

  tags = {
    Name = var.codebuild.comment_name
  }
}
