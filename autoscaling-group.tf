resource "aws_autoscaling_group" "blob-uploader-autoscaling-group" {
    name                        = "blob-uploader-autoscaling-group"
    max_size                    = var.max_instance_size
    min_size                    = var.min_instance_size
    desired_capacity            = var.desired_capacity
    vpc_zone_identifier         = [aws_subnet.blob_uploader_public_sn_01.id, aws_subnet.blob_uploader_public_sn_02.id]
    launch_configuration        = aws_launch_configuration.ecs-launch-configuration.name
    health_check_type           = "ELB"
}
