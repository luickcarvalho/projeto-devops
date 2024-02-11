data "aws_caller_identity" "current" {}

data "aws_lb_target_group" "ecs_tg" {
  name = var.ecs_comment.tg_name
}