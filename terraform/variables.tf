variable "sg_alb_comment" {
  type    = map(any)
  default = {}
}

variable "sg_ecs_comment" {
  type    = map(any)
  default = {}
}

variable "log_group" {
  type    = map(any)
  default = {}
}

variable "log_group_comment" {
  type    = map(any)
  default = {}
}

variable "iam" {
  type    = map(any)
  default = {}
}

variable "s3" { type = map(any) }

variable "alb_comment" {
  type    = map(any)
  default = {}
}

variable "policy" { type = map(any) }

variable "ecr_comment" {
  type    = map(any)
  default = {}
}

variable "cluster_comment" {
  type    = map(any)
  default = {}
}

variable "ecs_comment" {}

variable "rds" { type = map(any) }

variable "role" { type = map(any) }
variable "secrets" { type = map(any) }
