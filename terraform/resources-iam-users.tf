module "iam_user_deploy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 5.9.2"

  name = var.iam.name
  create_iam_user_login_profile = var.iam.create_iam_user_login_profile
  create_iam_access_key         = var.iam.create_iam_access_key

  tags = {
   Name = var.iam.name
 }
}

