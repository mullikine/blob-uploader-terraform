# You may need to edit these variables to match your config
db_password= "password"
# I must create this cluster
ecs_cluster="blob_uploader_cluster"
ecs_key_pair_name="blob_uploader_key_pair"
region= "us-west-1"
blob_uploader_app_image= "mullikine/blob-uploader-app:latest"

# no need to change these unless you want to
blob_uploader_vpc = "blob_uploader_vpc"
blob_uploader_network_cidr = "210.0.0.0/16"
blob_uploader_public_01_cidr = "210.0.0.0/24"
blob_uploader_public_02_cidr = "210.0.10.0/24"
max_instance_size = 3
min_instance_size = 1
desired_capacity = 2
