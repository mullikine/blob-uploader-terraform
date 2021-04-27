output "region" {
  value = var.region
}

output "blob_uploader_vpc_id" {
  value = aws_vpc.blob_uploader_vpc.id
}

output "blob_uploader_public_sn_01_id" {
  value = aws_subnet.blob_uploader_public_sn_01.id
}

output "blob_uploader_public_sn_02_id" {
  value = aws_subnet.blob_uploader_public_sn_02.id
}

output "blob_uploader_public_sg_id" {
  value = aws_security_group.blob_uploader_public_sg.id
}

output "ecs-service-role-arn" {
  value = aws_iam_role.ecs-service-role.arn
}

output "ecs-instance-role-name" {
  value = aws_iam_role.ecs-instance-role.name
}

output "app-alb-load-balancer-name" {
  value = aws_alb.blob_uploader_alb_load_balancer.name
}

output "app-alb-load-balancer-dns-name" {
  value = aws_alb.blob_uploader_alb_load_balancer.dns_name
}

output "nw-lb-load-balancer-dns-name" {
  value = aws_lb.blob_uploader_nw_load_balancer.dns_name
}

output "nw-lb-load-balancer-name" {
  value = aws_lb.blob_uploader_nw_load_balancer.name
}

output "blob-uploader-app-target-group-arn" {
  value = aws_alb_target_group.blob_uploader_app_target_group.arn
}

output "blob-uploader-db-target-group-arn" {
  value = aws_lb_target_group.blob_uploader_db_target_group.arn
}

output "mount-target-dns" {
  description = "Address of the mount target provisioned"
  value = aws_efs_mount_target.blobdbefs-mnt.0.dns_name
}
