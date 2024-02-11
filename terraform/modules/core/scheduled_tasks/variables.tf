variable "cluster_arn" {
  description = "ECS cluster ARN"
  type = string
}

variable "create" {
  type = bool
  default = true
  description = "Enable / disable Schedule creation"
}

variable "schedule_name" {
  type = string
  description = "The Schedule name"
}

variable "schedule_rule" {
  type = string
  description = "The Schedule rule in a CRON format"
}

variable "schedule_description" {
  type = string
  description = "The Schedule description"
}

variable "schedule_task_count" {
  type = number
  default = 0
  description = "The number of Tasks to run"
}

variable "region" {
  type = string
  description = "The Region to create the resources"
}

variable "task_definition_arn" {
  type = string
  description = "The Task Definition arn"
}

variable "task_family" {
  type = string
  description = "The Task Definition family"
}

variable "launch_type" {
  type = string
  description = "The type of ECS to run"
    validation {
    condition = contains(["FARGATE", "EC2", ], var.launch_type)
    error_message = "Valid value is one of the following: FARGATE, EC2."
  }
}
variable "subnets" {
  type        = list
  description = "The ECS Service Subnets to use"
}

variable "security_groups" {
  type        = list
  description = "ECS Security Group"
}

variable "assign_public_ip" {
  type        = bool
  description = "Define if a Public IP should be assigned"
}

variable "iam_role_suffix" {
  type        = string
  description = "Define a suffix to be appended to the IAM Role"
}
