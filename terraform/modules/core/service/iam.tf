resource "random_string" "ecs_role_hash" {
  length  = 4
  special = false
  lower   = true
  upper   = false
}

# Cluster Execution Role
module "iam_ecs_task_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.5.2"

  create_role = true
  role_name = "iam_ecs_task_assumable_role-${random_string.ecs_role_hash.result}"
  role_requires_mfa = false

  trusted_role_services = [ "ecs-tasks.amazonaws.com" ]

# Cluster Execution Policies
  custom_role_policy_arns = concat(
    [
      module.iam_ecs_task_policies.arn
    ],
    var.ecs_custom_policies_arns
  )
}

locals {
  policy_ecr_repo_json        = var.ecr_repository_name != null || var.ecr_arn != null ? data.aws_iam_policy_document.allow_ecr_repo[0].json : ""
  policy_ssm_exec_json        = var.ecs_enable_ssm_exec != null ? data.aws_iam_policy_document.allow_ssm_exec.json : ""
  policy_secretsmanager_json = length(local.secrets) > 0 ? templatefile("${path.module}/templates/policy_secretsmanagement.json", {
    resources = jsonencode([for secret in local.secrets: "${secret.arn}"])
  }) : ""
}

data "aws_iam_policy_document" "ecs_policies" { 
  source_policy_documents = [
    data.aws_iam_policy_document.allow_cloudwatch_logstream.json,
    data.aws_iam_policy_document.allow_cloudwatch_logevents.json,
    local.policy_ssm_exec_json,
    local.policy_ecr_repo_json,
    local.policy_secretsmanager_json,
    data.aws_iam_policy_document.allow_ecr.json,
  ]
}

module "iam_ecs_task_policies" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.5.2"

  name = "iam_es_task_policies-${var.service_name}"
  policy = data.aws_iam_policy_document.ecs_policies.json
  path  = "/ecs/"
}
