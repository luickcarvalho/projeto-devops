module "ecs_cluster_comment" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 4.1.2"

  cluster_name = var.cluster_comment.cluster_name
  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = module.log_group_cluster_comment.cloudwatch_log_group_name
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = var.cluster_comment.fargate_cap_providers
        base   = var.cluster_comment.fargate_base
      }
    }

    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = var.cluster_comment.fargate_spot_cap_providers
        base   = var.cluster_comment.fargate_spot_base
      }
    }
  }

  tags = {
   Name = var.cluster_comment.cluster_name
 }

}

module "log_group_cluster_comment" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 4.0.0"

  name              = var.log_group_comment.cluster_name
  retention_in_days = var.log_group_comment.cluster_retention

 tags = {
  Name = var.log_group_comment.cluster_name 
 }
}
