module "scheduled_tasks" {
  source = "../scheduled_tasks"
  
  cluster_arn = var.cluster_arn

  create                = var.schedule_name != null ? true : false

  schedule_name         = var.schedule_name
  schedule_rule         = var.schedule_rule
  schedule_description  = var.schedule_description
  schedule_task_count   = var.schedule_task_count

  region              = var.region
  launch_type         = "FARGATE"
  task_family         = local.task_family
  task_definition_arn = var.custom_task_definition_version != null ? var.custom_task_definition_version : aws_ecs_task_definition.this.arn

  subnets          = var.subnets_ids_ecs
  security_groups  = var.custom_security_group != null ? var.custom_security_group : module.ecs_sg[0].security_group_id
  assign_public_ip = var.assign_public_ip

  iam_role_suffix = random_string.ecs_role_hash.result

  depends_on = [ aws_ecs_service.this ]
}
