module "rds_comment" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "8.5.0"

  name                   = var.rds.name
  engine                 = var.rds.engine
  engine_mode            = var.rds.engine_mode
  engine_version         = var.rds.engine_version
  storage_encrypted      = var.rds.storage_encrypted
  master_username        = var.rds.master_username
  create_db_subnet_group = true
  create_security_group  = true
  publicly_accessible    = true

  vpc_id  = local.vpc_id
  subnets = local.subnets_prd
  security_group_rules = {
    ex1_ingress = {
      source_security_group_id = module.ecs_comment_security_group.security_group_id
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
  }

  tags = {
    Name = var.rds.name
  }
}