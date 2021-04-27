resource "aws_ecs_service" "blob_uploader_db_service" {
  name            = "blob_uploader_db_service"
  cluster         = aws_ecs_cluster.blob_uploader_ecs_cluster.id
  task_definition = "${aws_ecs_task_definition.blob_uploader_db.family}:${max(aws_ecs_task_definition.blob_uploader_db.revision, data.aws_ecs_task_definition.blob_uploader_db.revision)}"
  desired_count   = 1
  depends_on      = [ "aws_lb.blob_uploader_nw_load_balancer" ]

  load_balancer {
    target_group_arn  = aws_lb_target_group.blob_uploader_db_target_group.arn
    container_port    = 5432
    container_name    = "blob_uploader_db"
  }

  network_configuration {
    subnets           = [aws_subnet.blob_uploader_public_sn_01.id, aws_subnet.blob_uploader_public_sn_02.id]
    security_groups   = [aws_security_group.blob_uploader_public_sg.id]
  }

}
