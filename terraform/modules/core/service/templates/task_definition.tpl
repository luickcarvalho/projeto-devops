[
  {
    "name": "${container_name}",
    "image": "${image_name}:latest",
    "cpu": ${desired_task_cpu},
    "memory": ${desired_task_memory},
    "memoryReservation": ${desired_task_memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${container_port}
      }
    ],
    "secrets": ${secrets},
    "environment": ${environment},
    "logConfiguration": {
      "logDriver": "awslogs",
      "Options": {
        "awslogs-region": "${region}",
        "awslogs-group": "${log_group}",
        "awslogs-stream-prefix": "${log_prefix}"
      }
    },
    "linuxParameters": {
      "initProcessEnabled": true
    }
  }
]
