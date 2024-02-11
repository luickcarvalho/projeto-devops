# ECS Cluster Security Group
module "ecs_sg" {
  source = "terraform-aws-modules/security-group/aws"
  count       = var.custom_security_group != null ? 0 : 1

  name        = var.ecs_sg_name
  description = "ECS Default Security Group"
  vpc_id      = var.vpc_id
  use_name_prefix = false

  number_of_computed_ingress_with_source_security_group_id = (var.alb_sg_id != null) ? 1 : 0
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = var.alb_sg_id
    }
  ]

  egress_cidr_blocks  = var.ecs_sg_egress_blocks
  egress_rules        = var.ecs_sg_egress_rules

  tags = {
    Name        = "${var.ecs_sg_name}"
  }
}
