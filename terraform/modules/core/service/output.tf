output "repository_url" {
  value = "${module.ecr.repository_url}"
}

output "service_name" {
  value = "${var.service_name}"
}

output "ecs_sg_id" {
  value = module.ecs_sg[*].security_group_id
}
