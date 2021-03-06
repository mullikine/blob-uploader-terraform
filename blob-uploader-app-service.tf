resource "aws_ecs_service" "blob_uploader_app_service" {
  name            = "blob_uploader_app_service"
  iam_role        = aws_iam_role.ecs-service-role.name
  cluster         = aws_ecs_cluster.blob_uploader_ecs_cluster.id
  task_definition = "${aws_ecs_task_definition.blob_uploader_app.family}:${max(aws_ecs_task_definition.blob_uploader_app.revision, data.aws_ecs_task_definition.blob_uploader_app.revision)}"
  depends_on      = [ aws_ecs_service.blob_uploader_db_service ]
  desired_count   = var.desired_capacity
  deployment_minimum_healthy_percent = "50"
  deployment_maximum_percent = "100"

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#ignoring-changes-to-desired-count

  lifecycle {
    # Create an ECS service with an initial count of running instances, then
    # ignore any changes to that count caused externally (e.g. Application
    # Autoscaling).
    ignore_changes = [task_definition,desired_count]
  }

  load_balancer {
    target_group_arn  = aws_alb_target_group.blob_uploader_app_target_group.arn
    container_port    = 3000
    container_name    = "blob_uploader_app"
  }
}
