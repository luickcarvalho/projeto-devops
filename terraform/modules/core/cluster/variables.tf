#### Cluser variables ####
variable "cluster_name" {
  description = "The cluster name"
  type = string
}

variable "fargate_spot_weight" {
  description = "The ratio for fargate spot cluster capacity"
  default = "4"
}

variable "fargate_spot_base" {
  description = "The base for fargate spot cluster capacity"
  default = "1"
}

variable "fargate_weight" {
  description = "The ratio for fargate cluster capacity"
  default = "1"
}

variable "fargate_base" {
  description = "The base for fargate spot cluster capacity"
  default = "0"
}
