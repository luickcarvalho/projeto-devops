[
    {
      "name": "${container_name}",
      "image": "${image}",
      "cpu": ${cpu},
      "memory": ${memory},
      "memoryReservation": ${memory},
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${port}
        }
      ],
      "environment": [

      ],
      "secrets": [

      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "Options": {
          "awslogs-region": "${region}",
          "awslogs-group": "${log_group}",
          "awslogs-stream-prefix": "${log_prefix}"
        }
      }
    }
  ]