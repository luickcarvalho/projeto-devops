variable "create_alb" {
  description = "Is ALB needed for this project?"
  type = bool
  default = true
}

variable "alb_name" {
  description = "ALB resource name"
}

variable "lb_internal" {
  description = "Is the LB Internal or Internet Facing?"
  default = false
  type = bool
}

variable "lb_type" {
  description = "Load Balancer Type"
  default = ["application"]
    validation {
    condition = contains(["application", "network", "gateway"], var.lb_type)
    error_message = "Valid value is one of the following: application, network, gateway."
  }
}

variable "lb_protocol" {
  description = "Load Balancer Protocol"
  default = ["HTTP"]
  validation {
    condition = contains(["HTTP", "HTTPS", "TLS", "TCP"], var.lb_protocol)
    error_message = "Valid value is one of the following: HTTP, HTTPS, TLS or TCP."
  }
}

variable "alb_enable_http" {
  type = bool
  default = true
}

variable "alb_enable_https" {
  type = bool
  default = false
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "subnets_ids_alb" {
  type        = list
  description = "The ALB Service Subnets to use"
}

variable "alb_sg_name" {
  description = "ALB Security Group"
}

variable "alb_sg_use_name_prefix" {
  description = "ALB Security Group Name use Prefix"
  default = false
}

variable "alb_sg_ingress_blocks" {
  type = list
  default = [ "0.0.0.0/0" ]
}

variable "alb_sg_ingress_rules" {
  type = list
  default = [ "http-80-tcp" ]
}

variable "alb_sg_egress_blocks" {
  type = list
  default = [ "0.0.0.0/0" ]
}

variable "alb_sg_egress_rules" {
  type = list
  default = [ "all-all" ]
}

variable "listener_port_http" {
  description = "Listener port"
  default = "80"
}

variable "listener_port_https" {
  description = "Listener port"
  default = "443"
}

variable "healthcheck_path" {
  description = "The healthcheck path from Target Group"
  default = "/"
}

variable "listener_path" {
  description = "The listener rule path to the resource"
  default = "/"
}

variable "listener_ssl_policy_default" {
  description = "ELB Security Policy"
  type = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "alb_redirect_http" {
  type = bool
  default = false
}

variable "health_check" {
  description = "The target group health check"
  type = map
  default = {}
}

variable "default_task_port" {
  description = "Default Task port"
}

variable "default_task_protocol" {
  description = "Defaul Task Protocol"
}

variable "alb_default_tg_name" {
  description = "TG resource name"
}

variable "certificate_arn" {
  description = "ARN from ACM certificate"
}
