module "rds_comment" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.0.0"

  name              = var.rds.name
  engine            = var.rds.engine
  engine_mode       = var.rds.engine_mode
  engine_version    = var.rds.engine_version
  storage_encrypted = var.rds.storage_encrypted
  master_username   = var.rds.master_username

  vpc_id               = local.vpc_id
  db_subnet_group_name = local.
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  }

  monitoring_interval = var.rds.monitoring_interval

  apply_immediately   = var.rds.apply_immediately
  skip_final_snapshot = var.rds.skip_final_snapshot

  serverlessv2_scaling_configuration = {
    min_capacity = var.rds.min_capacity
    max_capacity = var.rds.max_capacity
  }

  instance_class = var.rds.instance_class
  instances = {
    one = {}
    two = {}
  }

  tags = var.rds.name
}