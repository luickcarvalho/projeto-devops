resource "aws_appautoscaling_target" "app_scale_target" {
  count              = (var.min_tasks > 0 && var.max_tasks > 0) ? 1 : 0
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"

  max_capacity       = "${var.max_tasks}"
  min_capacity       = "${var.min_tasks}"

  depends_on = [ aws_ecs_service.this ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  count              = (var.min_tasks > 0 && var.max_tasks > 0) ? 1 : 0
  alarm_name          = "${var.service_name}-CPU-Utilization-High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.cpu_to_scale_up}"

  dimensions = {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.app_up[0].arn}"]

  depends_on = [ aws_ecs_service.this ]
}

resource "aws_appautoscaling_policy" "app_up" {
  count              = (var.min_tasks > 0 && var.max_tasks > 0) ? 1 : 0
  name               = "${var.service_name}-app-scale-up"
  service_namespace  = "${aws_appautoscaling_target.app_scale_target[0].service_namespace}"
  resource_id        = "${aws_appautoscaling_target.app_scale_target[0].resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.app_scale_target[0].scalable_dimension}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [ aws_ecs_service.this ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  count               = (var.min_tasks > 0 && var.max_tasks > 0) ? 1 : 0
  alarm_name          = "${var.service_name}-CPU-Utilization-Low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.cpu_to_scale_down}"

  dimensions = {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.app_down[0].arn}"]

  depends_on = [ aws_ecs_service.this ]
}


resource "aws_appautoscaling_policy" "app_down" {
  count              = (var.min_tasks > 0 && var.max_tasks > 0) ? 1 : 0
  name               = "${var.service_name}-scale-down"
  service_namespace  = "${aws_appautoscaling_target.app_scale_target[0].service_namespace}"
  resource_id        = "${aws_appautoscaling_target.app_scale_target[0].resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.app_scale_target[0].scalable_dimension}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [ aws_ecs_service.this ]
}
