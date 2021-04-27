data "aws_ecs_task_definition" "blob_uploader_app" {
  task_definition = aws_ecs_task_definition.blob_uploader_app.family
  depends_on = ["aws_ecs_task_definition.blob_uploader_app"]
}

resource "aws_ecs_task_definition" "blob_uploader_app" {
  family                = "blob_uploader_app"
  container_definitions = <<DEFINITION
[
  {
    "name": "blob_uploader_app",
    "image": "${var.blob_uploader_app_image}",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ],
    "environment": [
      {
        "name": "DB_HOST",
        "value": "${aws_lb.blob_uploader_nw_load_balancer.dns_name}"
      },
      {
        "name": "DB_PASSWORD",
        "value": "${var.db_password}"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "blob_uploader_app",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "memory": 1024,
    "cpu": 256
  }
]
DEFINITION
}
