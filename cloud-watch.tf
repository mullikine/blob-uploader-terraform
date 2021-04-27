resource "aws_cloudwatch_log_group" "film_rating_app" {
  name = "blob_uploader_app"
}

 resource "aws_cloudwatch_log_group" "film_rating_db" {
  name = "blob_uploader_db"
}
