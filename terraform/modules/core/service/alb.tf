resource "aws_alb_target_group" "this" {
  count       = (var.attach_default_tg == false && var.alb_tg_name != null) ? 1 : 0
  name        = var.alb_tg_name
  port        = var.container_port
  protocol    = var.container_protocol
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
     port                = lookup(var.health_check, "port", var.container_port)
     protocol            = lookup(var.health_check, "protocol", var.container_protocol)
     unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold", 3)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_listener_rule" "this" {
  count       = (var.attach_default_tg == false && var.alb_tg_name != null) ? 1 : 0
  listener_arn  = length(var.alb_listener_https) > 0 ? var.alb_listener_https[0] : var.alb_listener_http[0]

  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.this[0].arn
  }

  dynamic "condition" {
    for_each = length(var.condition_path_patterns) > 0 ? [1] : []
    content {
	    path_pattern {
	      values =  var.condition_path_patterns
	    }
    }
  }

  dynamic "condition" {
    for_each = length(var.condition_host_headers) > 0 ? [1] : []
    content {
      host_header {
        values =  var.condition_host_headers
      }
    }
  }
}
