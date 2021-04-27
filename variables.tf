# main creds for AWS connection
variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}

variable "ecs_cluster" {
  description = "ECS cluster name"
}

variable "ecs_key_pair_name" {
  description = "ECS key pair name"
}

variable "region" {
  description = "AWS region"
}

variable "availability_zone" {
  description = "availability zone used for the film ratings, based on region"
  default = {
    eu-west-1 = "eu-west-1"
  }
}

variable "db_password" {
  description = "Database password"
}

variable "blob_uploader_app_image" {
  description = "Docker image for the film ratings application"
}

########################### Test VPC Config ################################

variable "blob_uploader_vpc" {
  description = "VPC for Film Ratings environment"
}

variable "blob_uploader_network_cidr" {
  description = "IP addressing for Film Ratings Network"
}

variable "blob_uploader_public_01_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}

variable "blob_uploader_public_02_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}

########################### Autoscale Config ################################

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
}
