locals {
  image_uri       = var.ecr_repository_name != null ? module.ecr.repository_url : var.image_uri
  repository_arn  = var.ecr_repository_name != null ? module.ecr.repository_arn : var.ecr_arn

  task_definition_template = var.task_definition_template != null ? var.task_definition_template : "${path.module}/templates/task_definition.tpl"

  managed_secrets = [
    for secret in var.managed_secrets:
    {
      name      = secret.name
      env_name  = secret.env_name
      arn       = module.secrets_manager[secret.name].arn
      valueFrom = module.secrets_manager[secret.name].arn #external secrets may have a different valueFrom
    }
  ]

  secrets = concat(local.managed_secrets, var.external_secrets)

  task_family = coalesce(var.task_name, "${var.service_name}-task")
}
