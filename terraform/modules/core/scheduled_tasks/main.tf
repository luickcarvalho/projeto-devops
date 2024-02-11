data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id

  task_arn = "arn:aws:ecs:${var.region}:${local.account_id}:task-definition/${var.task_family}"
}

resource "aws_cloudwatch_event_rule" "rule" {
  count               = var.create == true ? 1 : 0

  name                = var.schedule_name
  description         = var.schedule_description
  schedule_expression = var.schedule_rule
}

resource "aws_cloudwatch_event_target" "target" {
  count    = var.create == true ? 1 : 0

  rule     = aws_cloudwatch_event_rule.rule[0].name
  arn      = var.cluster_arn
  role_arn = module.iam_cw_schedule_role[0].iam_role_arn

  ecs_target {
    task_count          = var.schedule_task_count
    task_definition_arn = var.task_definition_arn
    launch_type         = var.launch_type

    dynamic "network_configuration" {
      for_each = var.launch_type == "FARGATE" ? [1] : []
      content {
        subnets          = var.subnets
        security_groups  = var.security_groups
        assign_public_ip = var.assign_public_ip
      }
    }
  }

  depends_on = [ aws_cloudwatch_event_rule.rule ]
}
