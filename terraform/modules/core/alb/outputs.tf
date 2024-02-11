output "alb" {
  value = aws_alb.this[*].dns_name
}

output "alb_arn" {
  value = aws_alb.this.*.arn
}

output "alb_sg_id" {
  value = module.alb_sg[0].security_group_id
}

output "alb_tg_arn" {
  value = aws_alb_target_group.this.arn
}

output "alb_listener_http" {
  value = aws_alb_listener.http[*].arn 
}

output "alb_listener_https" {
  value = aws_alb_listener.https[*].arn 
}
