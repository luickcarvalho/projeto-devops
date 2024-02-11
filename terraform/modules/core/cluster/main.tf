resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster_name}"
}

resource "aws_ecs_cluster_capacity_providers" "capacity_providers" {
  capacity_providers = ["FARGATE_SPOT", "FARGATE"]
  cluster_name = aws_ecs_cluster.cluster.name

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight = "${var.fargate_spot_weight}"
    base = "${var.fargate_spot_base}"
  }
 
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight = "${var.fargate_weight}"
    base = "${var.fargate_base}"
  }
}
