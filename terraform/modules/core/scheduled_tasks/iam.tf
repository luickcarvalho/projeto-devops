module "iam_cw_schedule_role" {
  count   = var.create == true ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.5.2"

  create_role = true
  role_name = "iam_cw_schedule_assumable_role-${var.iam_role_suffix}"
  role_requires_mfa = false

  trusted_role_services = [ "events.amazonaws.com" ]
  custom_role_policy_arns = [ module.iam_cw_schedule_policie[0].arn ]
}

module "iam_cw_schedule_policie" {
  count   = var.create == true ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.5.2"

  name = "iam_cw_task_policies-${var.schedule_name}"
  policy = templatefile("${path.module}/templates/policy_cloudwatch.json", {"task_arn": local.task_arn}) 
  path  = "/ecs/"
}
