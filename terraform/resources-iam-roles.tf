module "iam_ecs_service_task_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.33.0"

  create_role = true
  role_name = var.ecs_comment.task_role_name
  role_requires_mfa = false

  trusted_role_services = [ "ecs-tasks.amazonaws.com" ]
}

resource "aws_iam_user_policy_attachment" "iam_user_attachment-deploy-user" {
  user       = module.iam_user_deploy.iam_user_name
  policy_arn = module.iam_policy_user_deploy.arn
}

module "iam_policy_user_deploy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.9.2"

  name = var.policy.deploy_user_name
  policy = templatefile("templates/user_deploy.tpl", {
     region          = var.aws_region
 })

 tags = {
 Name = var.policy.deploy_user_name
 }
}
