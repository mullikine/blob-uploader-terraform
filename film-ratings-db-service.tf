resource "aws_ecs_service" "film_ratings_db_service" {
  name            = "film_ratings_db_service"
  cluster         = aws_ecs_cluster.film_ratings_ecs_cluster.id
  task_definition = "${aws_ecs_task_definition.film_ratings_db.family}:${max(aws_ecs_task_definition.film_ratings_db.revision, data.aws_ecs_task_definition.film_ratings_db.revision)}"
  desired_count   = 1
  depends_on      = [ "aws_lb.film_ratings_nw_load_balancer" ]

  load_balancer {
    target_group_arn  = aws_lb_target_group.film_ratings_db_target_group.arn
    container_port    = 5432
    container_name    = "film_ratings_db"
  }

  network_configuration {
    subnets           = [aws_subnet.film_ratings_public_sn_01.id, aws_subnet.film_ratings_public_sn_02.id]
    security_groups   = [aws_security_group.film_ratings_public_sg.id]
  }

}
