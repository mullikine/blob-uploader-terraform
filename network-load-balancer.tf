resource "aws_lb" "blob_uploader_nw_load_balancer" {
  name               = "blob-uploader-nw-load-balancer"
  internal           = true
  load_balancer_type = "network"
  subnets            = [aws_subnet.blob_uploader_public_sn_01.id, aws_subnet.film_ratings_public_sn_02.id]

  tags = {
    Name = "blob-uploader-nw-load-balancer"
  }

}

resource "aws_lb_target_group" "blob_uploader_db_target_group" {
  name                = "blob-uploader-db-target-group"
  port                = "5432"
  protocol            = "TCP"
  vpc_id              = aws_vpc.blob_uploader_vpc.id
  target_type         = "ip"

  health_check {
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    interval            = "10"
    port                = "traffic-port"
    protocol            = "TCP"
  }

  tags = {
    Name = "blob-uploader-db-target-group"
  }
}

resource "aws_lb_listener" "blob_uploader_nw_listener" {
  load_balancer_arn = aws_lb.blob_uploader_nw_load_balancer.arn
  port              = "5432"
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.blob_uploader_db_target_group.arn
    type             = "forward"
  }
}
