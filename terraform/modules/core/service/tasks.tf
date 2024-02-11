resource "aws_ecs_task_definition" "this" {
  family                = local.task_family

  container_definitions = templatefile(local.task_definition_template, {
    image_name          = local.image_uri
    container_name      = var.container_name
    container_port      = var.container_port
    log_group           = aws_cloudwatch_log_group.this.name
    log_prefix          = var.log_group_prefix
    desired_task_cpu    = var.desired_task_cpu
    desired_task_memory = var.desired_task_memory
    region		          = var.region
    environment         = jsonencode([for key, value in var.task_envs: { "name": "${key}", "value": "${value}" } ])
    secrets             = jsonencode([for secret in local.secrets: { "name": "${secret.env_name}", "valueFrom": "${secret.valueFrom}"  } ])
  })

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu                      = var.desired_task_cpu
  memory                   = var.desired_task_memory

  execution_role_arn = module.iam_ecs_task_assumable_role.iam_role_arn
  task_role_arn      = var.task_role

  depends_on = [ module.secrets_manager ]
}
