resource "aws_appautoscaling_target" "ecs_blobapp_target" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/blob_uploader_cluster/blob_uploader_app_service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  depends_on      = [ "aws_ecs_service.blob_uploader_app_service"]
}

# resource "aws_appautoscaling_policy" "ecs_policy" {
#   name               = "scale-down"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.ecs_blobapp_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_blobapp_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs_blobapp_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value = 75.0
#     scale_in_cooldown = 300
#     scale_out_cooldown = 300

#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }
#   }
# }
