resource "aws_cloudwatch_log_group" "lg_blob_uploader_app" {
  name = "blob_uploader_app"
}

resource "aws_cloudwatch_log_group" "lg_blob_uploader_db" {
  name = "blob_uploader_db"
}
