module "ecs_comment" {
  source = ".//modules/core/service"

  cluster_name = module.ecs_cluster_comment.cluster_name
  cluster_arn  = module.ecs_cluster_comment.cluster_arn

  task_name = var.ecs_comment.task_name
  task_role = module.iam_ecs_service_task_role.iam_role_arn

  container_name      = var.ecs_comment.container_name
  definition_name     = var.ecs_comment.definition_name
  service_name        = var.ecs_comment.service_name

  alb_default_tg_arn  = data.aws_lb_target_group.ecs_tg.arn
  attach_default_tg   = true

  container_port      = var.ecs_comment.container_port
  container_protocol  = var.ecs_comment.container_protocol
  desired_tasks       = var.ecs_comment.desired_tasks
  desired_task_cpu    = var.ecs_comment.desired_task_cpu
  desired_task_memory = var.ecs_comment.desired_task_memory
  min_tasks           = var.ecs_comment.min_tasks
  max_tasks           = var.ecs_comment.max_tasks
  cpu_to_scale_up     = var.ecs_comment.cpu_to_scale_up
  cpu_to_scale_down   = var.ecs_comment.cpu_to_scale_down
  custom_security_group = [module.ecs_comment_security_group.security_group_id]
  ecr_repository_name = var.ecs_comment.ecr_repository_name

  log_group_name   = var.ecs_comment.log_group_name
  log_group_prefix = var.ecs_comment.log_group_prefix
  retention_logs   = var.ecs_comment.retention_logs
  
  vpc_id          = local.vpc_id
  region          = var.aws_region
  subnets_ids_ecs = local.subnets_frontend

  task_envs       = var.ecs_comment.task_envs
  managed_secrets = var.ecs_comment.managed_secrets

  depends_on = [ module.alb_comment ]

}