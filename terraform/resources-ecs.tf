module "ecs_comment" {
  source = ".//modules/simple/fargate"

  name          = var.ecs_comment.service_name
  cluster       = module.ecs_cluster_comment.cluster_name
  cpu           = var.ecs_comment.desired_cpu
  memory        = var.ecs_comment.desired_memory
  desired_count = var.ecs_comment.desired_tasks
  ignore_desired_count_changes = false
  enable_execute_command       = true

  enable_deployment_circuit_breaker_with_rollback = true

  fargate_spot_weight = var.ecs_comment.fargate_spot_cap_providers
  fargate_spot_base   = var.ecs_comment.fargate_spot_base
  fargate_weight      = var.ecs_comment.fargate_cap_providers
  fargate_base        = var.ecs_comment.fargate_base

  propagate_tags  = var.ecs_comment.propagate_tags
  iam_task_role   = module.iam_ecs_task_assumable_role_comment.iam_role_arn
  iam_daemon_role = module.iam_ecs_service_assumable_role_comment.iam_role_arn

  security_groups  = [module.ecs_comment_security_group.security_group_id]
  vpc_subnets      = local.subnets_prd
  assign_public_ip = true

  target_group_arns = [
    module.alb_comment.target_group_arns[0]
  ]

  # container_name must be the same with the name defined in container_definitions!
  container_name = var.ecs_comment.container_name
  container_port = var.ecs_comment.container_port

  container_definitions = templatefile("templates/container_definitions_comment.tpl", {
    container_name = var.ecs_comment.container_name
    cpu            = var.ecs_comment.desired_cpu
    memory         = var.ecs_comment.desired_memory
    log_group      = module.log_group_ecs_comment.cloudwatch_log_group_name
    log_prefix     = var.ecs_comment.log_prefix
    region         = var.aws_region
    image          = "${module.ecr_comment.repository_url}:latest"
    port           = var.ecs_comment.container_port
  })

  tags = {
    Name = var.ecs_comment.service_name
  }
}

module "ecs_comment_autoscaling" {
  source                    = "cn-terraform/ecs-service-autoscaling/aws"
  version                   = "~> 1.0.6"
  ecs_service_name          = module.ecs_comment.name
  ecs_cluster_name          = module.ecs_cluster_comment.cluster_name
  name_prefix               = module.ecs_comment.name
  max_cpu_evaluation_period = var.ecs_comment.max_cpu_evaluation_period
  max_cpu_period            = var.ecs_comment.max_cpu_period
  max_cpu_threshold         = var.ecs_comment.max_cpu_threshold
  min_cpu_evaluation_period = var.ecs_comment.min_cpu_evaluation_period
  min_cpu_period            = var.ecs_comment.min_cpu_period
  min_cpu_threshold         = var.ecs_comment.min_cpu_threshold
  scale_target_max_capacity = var.ecs_comment.scale_target_max_capacity
  scale_target_min_capacity = var.ecs_comment.scale_target_min_capacity


  tags = {
    Name = module.ecs_comment.name
  }

}

module "log_group_ecs_comment" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 4.0.0"

  name              = var.log_group_comment.ecs_name
  retention_in_days = var.log_group_comment.ecs_retention

  tags = {
    Name = var.log_group_comment.ecs_name
  }
}