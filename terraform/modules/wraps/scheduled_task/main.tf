module "cluster" {
  source = "../../core/cluster"

  cluster_name          = var.cluster_name
  fargate_spot_weight   = var.fargate_spot_weight
  fargate_spot_base     = var.fargate_spot_base
  fargate_weight        = var.fargate_weight
  fargate_base          = var.fargate_base
}

module "service" {
  source = "../../core/service"

  for_each = var.ecs_services

  cluster_arn         = module.cluster.cluster_id
  cluster_name        = var.cluster_name

  task_name           = each.value.task_name
  task_role           = lookup(each.value, "task_role", null)

  ecr_repository_name = lookup(each.value, "ecr_repository_name", null)
  ecr_arn             = lookup(each.value, "ecr_arn", null)
  image_uri           = lookup(each.value, "image_uri", null)

  service_name        = each.value.service_name
  definition_name     = each.value.definition_name
  custom_task_definition_version = lookup(each.value, "custom_task_definition_version", null)

  log_group_name      = each.value.log_group_name
  log_group_prefix    = each.value.log_group_prefix
  retention_logs      = each.value.retention_logs

  task_definition_template = lookup(each.value, "task_definition_template", null)

  container_name      = each.value.container_name
  container_port      = each.value.container_port
  container_protocol  = each.value.container_protocol
  desired_task_cpu    = each.value.desired_task_cpu
  desired_task_memory = each.value.desired_task_memory
  task_envs           = lookup(each.value, "task_envs", [])
  external_secrets    = lookup(each.value, "external_secrets", [])
  managed_secrets     = lookup(each.value, "managed_secrets", [])

  assign_public_ip    = lookup(each.value, "assign_public_ip", false)

  desired_tasks       = 0
  min_tasks           = 0
  max_tasks           = 0

  ecs_sg_name         = each.value.ecs_sg_name

  vpc_id              = each.value.vpc_id
  subnets_ids_ecs     = each.value.subnets_ids_ecs

  schedule_name         = each.value.schedule_name
  schedule_rule         = each.value.schedule_rule
  schedule_description  = each.value.schedule_description
  schedule_task_count   = each.value.schedule_task_count
}
