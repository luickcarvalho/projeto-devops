module "ecs_comment_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.16.2"

  name   = var.sg_ecs_comment.name
  description   = var.sg_ecs_comment.description
  vpc_id = local.vpc_id
  use_name_prefix = false

  # Ingress for HTTP
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_ipv6_cidr_blocks = ["::/0"]
  ingress_with_source_security_group_id = [
    {
      from_port                = 8000
      to_port                  = 8000
      protocol                 = 6
      description              = "alb to ecs"
      source_security_group_id = module.alb_comment_security_group.security_group_id
    },
  ]

  # Allow all egress
  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = ["::/0"]
  egress_rules            = ["all-all"]

tags = {
 Name = var.sg_ecs_comment.name
 }
}

module "alb_comment_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.16.2"

  name   = var.sg_alb_comment.name
  description   = var.sg_alb_comment.description
  vpc_id = local.vpc_id
  use_name_prefix = false

  # Ingress for HTTP
  ingress_cidr_blocks      = ["191.243.77.243/32"]
  ingress_ipv6_cidr_blocks = ["::/0"]
  ingress_rules            = [
                               "http-80-tcp"
                             ]

  # Allow all egress
  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = ["::/0"]
  egress_rules            = ["all-all"]

tags = {
 Name = var.sg_alb_comment.name
 }
}

module "rds_comment_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.16.2"

  name   = var.sg_rds_comment.name
  description   = var.sg_rds_comment.description
  vpc_id = local.vpc_id
  use_name_prefix = false

  # Ingress for HTTP
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_ipv6_cidr_blocks = ["::/0"]
  ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = 6
      description              = "ecs to rds"
      source_security_group_id = module.rds_comment_security_group.security_group_id
    },
  ]

  # Allow all egress
  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = ["::/0"]
  egress_rules            = ["all-all"]

tags = {
 Name = var.sg_rds_comment.name
 }
}