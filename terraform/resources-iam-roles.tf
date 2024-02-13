module "iam_ecs_service_assumable_role_comment" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.9.2"

  create_role = true
  role_name = var.role.ecs_exec_role_comment
  role_requires_mfa = false

  trusted_role_services = [ "ecs-tasks.amazonaws.com" ]
  custom_role_policy_arns = [
    module.iam_ecs_service_policy_ecs_requirements.arn,
  ]
}

module "iam_ecs_service_policy_ecs_requirements" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.9.2"

  name = var.policy.ecs_requirements_name
  policy = file("files/ecs-service-execution-role-policy.json")
}


module "iam_ecs_task_assumable_role_comment" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.9.2"

  create_role = true
  role_name = var.role.task_role_comment
  role_requires_mfa = false

  trusted_role_services = [ "ecs-tasks.amazonaws.com" ]
  custom_role_policy_arns = [module.iam_ecs_task_role_comment.arn]
}

module "iam_ecs_task_role_comment" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.9.2"

  name 	      	     = var.policy.task_role_comment
  policy      	     = templatefile("templates/ecs-task-role-policy-comment.tpl", {
  })
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
