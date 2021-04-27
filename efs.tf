resource "aws_efs_file_system" "blobdbefs" {
  tags = {
    Name = "blobdbefs"
  }
}

locals {
  subnets = [aws_subnet.blob_uploader_public_sn_01.id, aws_subnet.blob_uploader_public_sn_02.id]
}

resource "aws_efs_mount_target" "blobdbefs-mnt" {
  count = "2"

  file_system_id = aws_efs_file_system.blobdbefs.id
  subnet_id = element(local.subnets, count.index)

  security_groups = [aws_security_group.blob_uploader_public_sg.id]

}
