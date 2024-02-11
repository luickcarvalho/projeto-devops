module "cluster" {
  source = "../../core/cluster"

  cluster_name          = var.cluster_name
  fargate_spot_weight   = var.fargate_spot_weight
  fargate_spot_base     = var.fargate_spot_base
  fargate_weight        = var.fargate_weight
  fargate_base          = var.fargate_base
}

module "alb" {
  source = "../../core/alb"

  create_alb          = var.alb.create_alb
  alb_name            = var.alb.alb_name
  alb_default_tg_name = var.alb.alb_default_tg_name

  default_task_port   = lookup(var.alb, "default_task_port", 8080)
  default_task_protocol = lookup(var.alb, "default_task_protocol", "HTTP")

  lb_internal         = lookup(var.alb, "lb_internal", null)
  lb_type             = var.alb.lb_type

  alb_enable_http     = lookup(var.alb, "alb_enable_http", true)
  alb_enable_https    = lookup(var.alb, "alb_enable_https", false)

  alb_sg_name             = var.alb.alb_sg_name
  alb_sg_ingress_blocks   = lookup(var.alb, "alb_sg_ingress_blocks",  ["0.0.0.0/0"])
  alb_sg_ingress_rules    = lookup(var.alb, "alb_sg_ingress_rules",   ["http-80-tcp"])
  alb_sg_egress_blocks    = lookup(var.alb, "alb_sg_egress_blocks",   ["0.0.0.0/0"])
  alb_sg_egress_rules     = lookup(var.alb, "alb_sg_egress_rules",    ["all-all"])
  alb_sg_use_name_prefix  = lookup(var.alb, "alb_sg_use_name_prefix", false)

  lb_protocol         = var.alb.lb_protocol
  healthcheck_path    = var.alb.healthcheck_path
  listener_path       = var.alb.listener_path

  certificate_arn     = var.alb.certificate_arn

  vpc_id              = var.alb.vpc_id
  subnets_ids_alb     = var.alb.subnets_ids_alb
}

module "service" {
  source = "../../core/service"

  for_each = var.ecs_services

  region              = lookup(each.value, "region", null)

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
  desired_tasks       = each.value.desired_tasks
  desired_task_cpu    = each.value.desired_task_cpu
  desired_task_memory = each.value.desired_task_memory
  task_envs           = lookup(each.value, "task_envs", [])
  external_secrets    = lookup(each.value, "external_secrets", [])
  managed_secrets     = lookup(each.value, "managed_secrets", [])

  min_tasks           = each.value.min_tasks
  max_tasks           = each.value.max_tasks
  cpu_to_scale_up     = each.value.cpu_to_scale_up
  cpu_to_scale_down   = each.value.cpu_to_scale_down

  assign_public_ip    = lookup(each.value, "assign_public_ip", false)

  ecs_sg_name         = each.value.ecs_sg_name

  vpc_id              = each.value.vpc_id
  subnets_ids_ecs     = each.value.subnets_ids_ecs

  alb_sg_id           = module.alb.alb_sg_id
  alb_default_tg_arn  = module.alb.alb_tg_arn
  attach_default_tg   = lookup(each.value, "attach_default_tg", false)

  alb_listener_http   = module.alb.alb_listener_http
  alb_listener_https  = module.alb.alb_listener_https

  condition_path_patterns = lookup(each.value, "condition_path_patterns", [])
  condition_host_headers  = lookup(each.value, "condition_host_headers", [])

  alb_tg_name         = lookup(each.value, "alb_tg_name", null)
  lb_type             = lookup(each.value, "lb_type", "application")
}
