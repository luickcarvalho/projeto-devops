resource "aws_ecs_service" "this" {
  name            = "${var.service_name}"
  task_definition = var.custom_task_definition_version != null ? var.custom_task_definition_version : aws_ecs_task_definition.this.arn

  cluster         = var.cluster_arn

  propagate_tags  = "SERVICE"
  force_new_deployment = true
  enable_execute_command = true 
  desired_count   = "${var.desired_tasks}"

  network_configuration {
    security_groups  = var.custom_security_group != null ? var.custom_security_group : module.ecs_sg[0].security_group_id
    subnets          = "${var.subnets_ids_ecs}"
    assign_public_ip = var.assign_public_ip
  }

  dynamic load_balancer {
    for_each = var.attach_default_tg == true ? [1] : []
    content {
      target_group_arn = var.alb_default_tg_arn
      container_name   = "${var.container_name}"
      container_port   = "${var.container_port}"
    }
  }

  dynamic load_balancer {
    for_each = (var.attach_default_tg == false && var.alb_tg_name != null) ? [1] : []
    content {
      target_group_arn = aws_alb_target_group.this[0].arn
      container_name   = "${var.container_name}"
      container_port   = "${var.container_port}"
    }
  }
  
  lifecycle {
    ignore_changes = [desired_count, capacity_provider_strategy]
  }  

  tags = {
    Name    = "${var.service_name}"
  }

  depends_on = [ module.iam_ecs_task_assumable_role, aws_ecs_task_definition.this ] 
}
