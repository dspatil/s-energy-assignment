variable "aws_region" = "us-west-2"
variable "vpc_cidr_block" = "10.0.0.0/16"
variable "public_subnet_cidr_block" = "10.0.1.0/24"
variable "public_subnet_az" = "us-west-2a"
variable "private_subnet_cidr_block" = "10.0.2.0/24"
variable "private_subnet_az" = "us-west-2a"

variable "company_network_cidr" = "192.168.1.0/24"

variable "ami_id" = ""
variable "instance_type" = "t2.medium"
variable "ssh_keypair_name" = "mysshkeypair"
variable "root_volume_size" = "20"
variable "additional_volume_size" = "50"
