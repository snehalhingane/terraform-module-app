module "infra-dev" {
    source = "./Infra-app"
    env = "dev"
    bucket_name = "infra-my-bucket"
    instance_count = 1
    instance_type = "t2.micro"
    image_id = "ami-06c8f2ec674c67112"
    hash_key = "myID"
  
}

module "infra-prod" {
    source = "./Infra-app"
    env = "prod"
    bucket_name = "infra-my-bucket"
    instance_count = 2
    instance_type = "t2.micro"
    image_id = "ami-06c8f2ec674c67112"
    hash_key = "myID"
  
}

module "infra-stag" {
    source = "./Infra-app"
    env = "stag"
    bucket_name = "infra-my-bucket"
    instance_count = 1
    instance_type = "t2.micro"
    image_id = "ami-06c8f2ec674c67112"
    hash_key = "myID"
  
}