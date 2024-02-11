# ALB Security Group
module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  count = var.create_alb == true ? 1 : 0

  name                = var.alb_sg_name
  use_name_prefix     = var.alb_sg_use_name_prefix
  description         = "ALB Default Security Group"
  vpc_id              = var.vpc_id

  ingress_cidr_blocks = var.alb_sg_ingress_blocks
  ingress_rules       = var.alb_sg_ingress_rules

  egress_cidr_blocks  = var.alb_sg_egress_blocks
  egress_rules        = var.alb_sg_egress_rules

  tags = {
    Name = "${var.alb_sg_name}"
  }
}

resource "aws_alb" "this" {
  count               = var.create_alb == true ? 1 : 0
  name                = "${var.alb_name}"
  subnets             = var.subnets_ids_alb
  internal	          = "${var.lb_internal}"
  load_balancer_type  = "${var.lb_type}"
  security_groups = var.lb_type == "application" ? [module.alb_sg[0].security_group_id] : null

  tags = {
    Name        = "${var.alb_name}"
  }
}

resource "aws_alb_target_group" "this" {
  name        = var.alb_default_tg_name
  port        = var.default_task_port
  protocol    = var.default_task_protocol
  vpc_id      = var.vpc_id
  target_type = "ip"

  dynamic health_check {
  for_each = var.lb_type == "application" ? [1] : [] 
  content {
     enabled             = lookup(var.health_check, "enabled", true)
     path                = lookup(var.health_check, "path", "/")
     healthy_threshold   = lookup(var.health_check, "healthy_threshold", 3)
     interval            = lookup(var.health_check, "interval", 6)
     timeout             = lookup(var.health_check, "timeout", 5)
     port                = lookup(var.health_check, "port", var.default_task_port)
     protocol            = lookup(var.health_check, "protocol", var.default_task_protocol)
     unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold", 3)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on        = [aws_alb.this]
}

resource "aws_alb_listener" "https" {
  count               = var.create_alb == true && var.alb_enable_https ? 1 : 0
  
  load_balancer_arn = aws_alb.this[0].arn

  depends_on        = [aws_alb_target_group.this]
  
  certificate_arn   = var.certificate_arn

  protocol          = var.lb_type == "application" ? "HTTPS" : "TLS"
  port              = var.listener_port_https
  ssl_policy        = var.listener_ssl_policy_default
  
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}

resource "aws_alb_listener" "http" {
  count               = var.create_alb == true && var.alb_enable_http ? 1 : 0
  
  load_balancer_arn = aws_alb.this[0].arn

  port              = var.listener_port_http
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.this]
  
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}

resource "aws_alb_listener" "http_redirect" {
  count             = var.create_alb == true && var.alb_redirect_http && var.alb_enable_https ? 1 : 0
  
  load_balancer_arn = aws_alb.this[0].arn

  port              = var.listener_port_http
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.this]
  
  default_action {
    type            = "redirect"

    redirect {
      port          = var.listener_port_https
      protocol      = "HTTPS"
      status_code   = "HTTP_302"
    }
  }
}
