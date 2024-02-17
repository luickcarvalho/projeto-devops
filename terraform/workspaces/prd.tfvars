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
  name            = "SG-PRD-ALB-COMMENT"
  description     = "SG do ALB COMMENT"
}

sg_ecs_comment = {
  name            = "SG-PRD-ECS-COMMENT"
  description     = "SG do ECS COMMENT"
}


#IAM
iam = {
 name = "user-prd-comment-deploy"
 create_iam_user_login_profile = false
 create_iam_access_key = false
}

#ROLE
role = {
  task_role_comment        = "role-prd-task-role-comment"
  ecs_exec_role_comment    = "role-prd-ecs-exec-role-comment"
}

#POLICIES
policy = {
  task_role_comment    = "policy-prd-claroradios-task-role-comment"
  ecs_requirements_name   = "policy-prd-ecs-requirements-comment"
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
  ecs_name = "/ecs/prd/comment"
  cluster_name = "/ecs-cluster/prd/comment"
  cluster_retention = 5
  ecs_retention = 5

}

#ECR
ecr_comment = {
 repo_name            = "ecr-prd-comment"
 image_tag_mutability = "MUTABLE"
 create 	      = "true"
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

  fargate_cap_providers = 0
  fargate_base = 0
  fargate_spot_cap_providers = 2
  fargate_spot_base = 1

  task_name = "ecs-task-prd-comment"
  service_name = "ecs-service-prd-comment"
  propagate_tags = "SERVICE"
  desired_cpu = "256"
  privileged = "true"
  desired_memory = "512"
  desired_tasks =  "1"
  container_port = "8000"
  container_name = "comment"
  task_def_name = "ecs-task-prd-comment"
  log_prefix = "comment"
  platform_version = "1.3.0"

  max_cpu_evaluation_period     = "2"
  max_cpu_period                = "60"
  max_cpu_threshold             = "50"
  min_cpu_evaluation_period     = "3"
  min_cpu_period                = "60"
  min_cpu_threshold             = "10"
  scale_target_max_capacity     = "3"
  scale_target_min_capacity     = "1"

}

rds = {
  name              = "rds-prd-comment"
  engine            = "aurora-mysql"
  engine_mode       = "provisioned"
  engine_version    = "8.0"
  storage_encrypted = true
  master_username   = "root"
  db_subnet_group_name = "db-subnet-group-comment"

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  min_capacity = 0.5
  max_capacity = 1
  instance_class = "db.serverless"
}

secrets = {
 name          = "prd/comment/mysql"
 description   = "MYSQL for Comment"
 type          = "TEXT"
 value         = null
}