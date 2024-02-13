module "fargate" {
  source = "../../core/service"

  name                         = var.name
  cluster                      = var.cluster
  container_definitions        = var.container_definitions
  desired_count                = var.desired_count
  ignore_desired_count_changes = var.ignore_desired_count_changes

  iam_daemon_role = var.iam_daemon_role
  iam_task_role   = var.iam_task_role
  iam_lb_role     = var.iam_lb_role

  task_cpu    = var.cpu
  task_memory = var.memory

  load_balancers = [for i in range(max(length(var.target_group_arns), length(var.elb_names))) : {
    elb_name         = try(var.elb_names[i], null)
    target_group_arn = try(var.target_group_arns[i], null)
    container_name   = var.container_name
    container_port   = var.container_port
  }]

  force_new_deployment                               = var.force_new_deployment
  deployment_minimum_healthy_percent                 = var.deployment_minimum_healthy_percent
  deployment_maximum_percent                         = var.deployment_maximum_percent
  enable_deployment_circuit_breaker_with_rollback    = var.enable_deployment_circuit_breaker_with_rollback
  enable_deployment_circuit_breaker_without_rollback = var.enable_deployment_circuit_breaker_without_rollback
  health_check_grace_period_seconds                  = var.health_check_grace_period_seconds

  enable_execute_command = var.enable_execute_command

  task_requires_compatibilites = ["FARGATE"]

  capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE_SPOT"
      weight            = var.fargate_spot_weight
      base              = var.fargate_spot_base
    },
    {
      capacity_provider = "FARGATE"
      weight            = var.fargate_weight
      base              = var.fargate_base
    }
  ]

  task_network_mode = "awsvpc"
  network_configuration = {
    subnets          = var.vpc_subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  task_volume_configurations = var.volume_configurations
  task_proxy_configuration   = var.proxy_configuration
  task_runtime_platform      = var.runtime_platform
  service_registry           = var.service_registry

  platform_version = var.platform_version

  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  propagate_tags          = var.propagate_tags

  wait_for_steady_state = var.wait_for_steady_state

  tags = var.tags
}
