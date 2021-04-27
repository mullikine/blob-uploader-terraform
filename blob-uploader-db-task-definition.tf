data "aws_ecs_task_definition" "blob_uploader_db" {
  task_definition = aws_ecs_task_definition.blob_uploader_db.family
  depends_on = ["aws_ecs_task_definition.blob_uploader_db"]
}

resource "aws_ecs_task_definition" "blob_uploader_db" {
  family                = "blob_uploader_db"
  volume {
    name = "filmdbvolume"
    host_path = "/mnt/efs/postgres"
  }
  network_mode = "awsvpc"
  container_definitions = <<DEFINITION
[
  {
    "name": "blob_uploader_db",
    "image": "postgres:alpine",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5432
      }
    ],
    "environment": [
      {
        "name": "POSTGRES_DB",
        "value": "filmdb"
      },
      {
        "name": "POSTGRES_USER",
        "value": "filmuser"
      },
      {
        "name": "POSTGRES_PASSWORD",
        "value": "${var.db_password}"
      }
    ],
    "mountPoints": [
        {
          "readOnly": null,
          "containerPath": "/var/lib/postgresql/data",
          "sourceVolume": "filmdbvolume"
        }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "blob_uploader_db",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "memory": 512,
    "cpu": 256
  }
]
DEFINITION
}
