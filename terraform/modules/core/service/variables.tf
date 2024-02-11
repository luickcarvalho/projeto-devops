#### Cluser variables ####
variable "cluster_name" {
  description = "The cluster name"
  type = string
}

variable "cluster_arn" {
  description = "ECS cluster ARN"
  type = string
}

#### Service variables ####
variable "task_name" {
  description = "The task name"
  default = null
}

variable "task_role" {
  description = "IAM Task Role to assign to the Container"
  default     = null
  type        = string
}

variable "container_name" {
  description = "Container name"
}

variable "image_uri" {
  description = "Define an image uri. Needed if ECR repository isn't created"
  default = null
}

variable "definition_name" {
  description = "Task Definition name"
}

variable "service_name" {
  description = "ECS service name"
}

variable "log_group_name" {
  description = "CloudWatch Log Group name"
}

variable "log_group_prefix" {
  description = "CloudWatch Log Group prefix"
}

variable "retention_logs" {
  description = "CloudWatch Log Group Retention in Days"
  default = "30"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "region" {
  description = "The Region to create the resources"
  default = "us-east-1"
}

variable "subnets_ids_ecs" {
  type        = list
  description = "The ECS Service Subnets to use"
}

variable "ecr_lifecycle_count_images" {
  type        = number
  description = "Count number of images to keep in repository until expires"
  default = "30"
}

variable "ecr_arn" {
  description = "External ECR ARN"
  default = null
  type = string
}

variable "alb_default_tg_arn" {
  type = string
  default = null
  description = "ALB default external ARN"
}

variable "alb_sg_id" {
  type = string
  default = null
  description = "ALB SG id"
}

variable "attach_default_tg" {
  description = "Is your ECS service acessible through LB?"
  type = bool
  default = false
}

variable "container_port" {
  description = "Container target port"
}

variable "container_protocol" {
  description = "Container Protocol"
}

variable "desired_tasks" {
  description = "Number of containers desired to run the application task"
  default = "1"
}

variable "desired_task_cpu" {
  description = "Task CPU Limit"
}

variable "desired_task_memory" {
  description = "Task Memory Limit"
}

variable "min_tasks" {
  description = "Minimum"
  default = "1"
}

variable "max_tasks" {
  description = "Maximum"
  default = "1"
}

variable "cpu_to_scale_up" {
  description = "CPU % to Scale Up the number of containers"
  default = "75"
}

variable "cpu_to_scale_down" {
  description = "CPU % to Scale Down the number of containers"
  default = "20"
}

variable "ecs_sg_name" {
  description = "ECS Security Group"
  default = null
}

variable "custom_security_group" {
  description = "ECS Custom Security Group"
  type    = list
  default = null
}

variable "ecr_repository_name" {
  description = "The repository name"
  type = string
  default = null
}

variable "ecr_repository_lifecycle_policy" {
  type = string
  default = null
}

variable "ecr_image_tag_mutability" {
  type = string
  default = "MUTABLE"
}

variable "ecs_custom_policies_arns" {
  type = list
  default = []
  description = "A list of policies ARNs"
}

variable "ip_address_type" {
  type = string
  default = "ipv4"
  description = "IP version"
}

variable "assign_public_ip" {
  type = bool
  default = false
  description = "Define if a Public IP should be assigned"
}

variable "ecs_sg_egress_blocks" {
  type = list
  default = [ "0.0.0.0/0" ]
}

variable "ecs_sg_egress_rules" {
  type = list
  default = [ "all-all" ]
}

variable "ecs_enable_ssm_exec" {
  type = bool
  default = true
}

variable "task_envs" {
  type = map
  default = {}
  description = "A key/value map with Env Vars"
}

variable "managed_secrets" {
  default = []
  description = "A list with maps of Secrets to be created"
}

variable "external_secrets" {
  default = []
  description = "A list with external Secrets"
}

variable "task_definition_template" {
  type = string
  default = null
  description = "Definie a custom Task Definition template"
}

variable "alb_listener_http" {
  default = {}
  description = "The ALB HTTP Listener object"
}

variable "alb_listener_https" {
  default = {}
  description = "The ALB HTTPS Listener object"
}

variable "condition_path_patterns" {
  default = []
  type = list
}

variable "condition_host_headers" {
  default = []
  type = list
}

variable "alb_tg_name" {
  type = string
  default = null
  description = "TG resource name"
}

variable "lb_type" {
  description = "Load Balancer Type"
  default = "application"
    validation {
    condition = contains(["application", "network", "gateway"], var.lb_type)
    error_message = "Valid value is one of the following: application, network, gateway."
  }
}

variable "health_check" {
  description = "The target group health check"
  type = map
  default = {}
}

variable "custom_task_definition_version" {
  description = "Set a custom task definition family:version"
  type = string
  default = null
}

variable "schedule_name" {
  type = string
  default = null
  description = "The Schedule name"
}

variable "schedule_rule" {
  type = string
  default = null
  description = "The Schedule rule in a CRON format"
}

variable "schedule_description" {
  type = string
  default = null
  description = "The Schedule description"
}

variable "schedule_task_count" {
  type = number
  default = 0
  description = "The number of Tasks to run"
}
