variable "env" {
  description = "This is Environment for my Infra" # do not mention default to dynamically set variable
  type = string
}

variable "bucket_name" {
  description = "This is infra bucket"
  type = string
}

variable "instance_count" {
    description = "This is count of instance count"
    type = number
}

variable "instance_type" {
  description = "This is Ec2 instance type"
  type = string
}

variable "image_id" {
  description = "This is image ID"
  type = string
}

variable "hash_key" {
  description = "This is hash Key"
}
