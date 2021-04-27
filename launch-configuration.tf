resource "aws_launch_configuration" "ecs-launch-configuration" {
  name                        = "ecs-launch-configuration"
  image_id                    = data.aws_ami.latest_ubuntu.id
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.ecs-instance-profile.id

  root_block_device {
    volume_type = "standard"
    volume_size = 100
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  security_groups             = [aws_security_group.blob_uploader_public_sg.id]
  associate_public_ip_address = "true"
  key_name                    = var.ecs_key_pair_name
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-install.html
  # [[egr:ubuntu terraform ECS_CLUSTER]]
  # [[egr:"launch-configuration.tf" ubuntu 20]]
  # [[egr:aws_launch_configuration ubuntu 20]]

  # This has not been confirmed yet to be running
  user_data                   = <<EOF
                                  #!/bin/bash
                                  sudo mkdir -m 777 -p /etc/ecs; sudo chown $USER:$USER /etc/ecs
                                  echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
                                  sudo mkdir -p /mnt/efs/postgres; sudo chown $USER:$USER /mnt/efs/postgres
                                  cd /mnt
                                  # sudo yum install -y amazon-efs-utils
                                  (
                                  sudo apt-get update
                                  sudo apt-get -y install git binutils
                                  sudo chmod 777 /mnt
                                  git clone https://github.com/aws/efs-utils
                                  cd efs-utils
                                  ./build-deb.sh
                                  sudo apt-get -y install ./build/amazon-efs-utils*deb
                                  )

                                  sudo mount -t efs ${aws_efs_mount_target.blobdbefs-mnt.0.dns_name}:/ efs
                                  EOF
}