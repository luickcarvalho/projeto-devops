#BUCKETS
s3 = {
 bucket_name_codebuild 	    = "s3-prd-comment-codebuild"
 block_public_acls          = true
 block_public_policy        = true
 ignore_public_acls         = true
 restrict_public_buckets    = true
 attach_policy              = false
 versioning                 = true
 control_object_ownership   = true
 object_ownership           = "BucketOwnerEnforced"

}

#SG
sg_alb_comment = {
  name            = "SG-PRD-ALB-PLATAFORMA-COMMENT"
  description     = "SG do ALB COMMENT"
}

sg_ecs_comment = {
  name            = "SG-PRD-ECS-PLATAFORMA-COMMENT"
  description     = "SG do ECS COMMENT"
}


#IAM
iam = {
 name = "user-prd-comment-deploy"
 create_iam_user_login_profile = false
 create_iam_access_key = false
}

#POLICIES
policy = {
  user_name               = "policy-prd-comment-user-s3"
  deploy_user_name        = "policy-prd-comment-deploy-user"
}

#ALB
alb_comment = {

 create           = true
 name             = "ALB-PRD-COMMENT-ECS"
 type             = "application"
 internal         = "false"
 ip_address_type  = "ipv4"
 port             = "80"
 protocol         = "HTTP"
 listener_ssl_policy_default = "ELBSecurityPolicy-TLS-1-2-2017-01"
 idle_timeout = "3000"

 tg_name           = "TG-PRD-COMMENT-ECS"
 tg_protocol       = "HTTP"
 tg_port       = "8000"
 tg_target_type = "ip"
 tg_deregistration_delay = "5"
 tg_interval = "30"
 tg_traffic  = "traffic-port"
 tg_healthy_threshold   = "3"
 tg_unhealthy_threshold = "2"
 tg_timeout = "10"
 tg_matcher = "200"
 tg_health_check = "/healthcheck"
}

#LOG_GROUP
log_group_comment = {
  cluster_name = "/ecs-cluster/prd/comment"
  cluster_retention = 5
}

#ECR
ecr_comment = {
 repo_name            = "ecr-prd-comment"
 image_tag_mutability = "MUTABLE"
 create 	      = "false"
}

#CODEBUILD
codebuild = {
  comment_name     = "codebuild-prd-comment"
  comment_zip      = "ecs-prd-comment.zip"
  s3_bucket_comment_codebuild = "s3-prd-comment-codebuild"
}

#CLUSTER ECS
cluster_comment = {

  cluster_name = "ecs-cluster-prd-comment"
  fargate_cap_providers = 0
  fargate_base = 0
  fargate_spot_cap_providers = 1
  fargate_spot_base = 1
}

#ECS
ecs_comment = {

  task_name             = "ecs-task-prd-comment"
  task_role_name        = "role-prd-ecs-task-comment"
  container_name        = "comment"
  service_name          = "ecs-service-prd-comment"
  definition_name       = "ecs-task-prd-comment"
  container_port        = "8000"
  container_protocol    = "HTTP"
  desired_tasks         = "0"
  desired_task_cpu      = "256"
  desired_task_memory   = "512"

  min_tasks             = "0"
  max_tasks             = "1"
  cpu_to_scale_up       = "75"
  cpu_to_scale_down     = "20"

  attach_default_tg     = "true"
  tg_name               = "TG-PRD-COMMENT-ECS"

  custom_security_group = "SG-PRD-ECS-PLATAFORMA-COMMENT"
  ecr_repository_name   = "ecr-prd-comment"

  log_group_name        = "/ecs/prd/comment"
  log_group_prefix      = "comment"
  retention_logs        = "5"

  task_envs             = {
    "AWS_REGION"        = "us-east-1"
  }
  managed_secrets          = [
  ]
}

rds = {
  name              = "rds-prd-comment"
  engine            = "aurora-mysql"
  engine_mode       = "provisioned"
  engine_version    = "8.0"
  storage_encrypted = true
  master_username   = "root"

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  min_capacity = 1
  max_capacity = 3
  instance_class = "db.serverless"
}