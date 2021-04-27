resource "aws_ecs_cluster" "blob_uploader_ecs_cluster" {
  name = var.ecs_cluster
}
