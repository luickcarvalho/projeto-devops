module "alb_comment" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.2.1"

  name = var.alb_comment.name

  load_balancer_type = var.alb_comment.type
  internal = var.alb_comment.internal

  vpc_id     = local.vpc_id
  subnets    = local.subnets_frontend
  security_groups    = [module.alb_comment_security_group.security_group_id]
  listener_ssl_policy_default = var.alb_comment.listener_ssl_policy_default
  idle_timeout = var.alb_comment.idle_timeout

  target_groups = [
    {
      name             = var.alb_comment.tg_name
      backend_protocol = var.alb_comment.tg_protocol
      backend_port     = var.alb_comment.tg_port
      target_type      = var.alb_comment.tg_target_type
      deregistration_delay = var.alb_comment.tg_deregistration_delay
       health_check = {
         enabled             = true
         interval            = var.alb_comment.tg_interval
         path                = var.alb_comment.tg_health_check
         port                = var.alb_comment.tg_traffic
         healthy_threshold   = var.alb_comment.tg_healthy_threshold
         unhealthy_threshold = var.alb_comment.tg_unhealthy_threshold
         timeout             = var.alb_comment.tg_timeout
         protocol            = var.alb_comment.tg_protocol
         matcher             = var.alb_comment.tg_matcher
       }

    }
]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
    }
]

  tags = {
    Environment = var.alb_comment.name
  }
}