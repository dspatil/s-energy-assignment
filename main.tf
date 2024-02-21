terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = "~> 0.15"  # Specify the required Terraform version
}

provider "aws" {
  region = var.aws_region  # Change to your desired region
}

# get latest ami always
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]  # Filter to select Amazon Linux 2 AMIs
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  owners = ["amazon"]
}


module "vpc" {
  source = "./modules/compute/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  public_subnet_az = var.public_subnet_az  # Change to desired availability zone
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_subnet_az = var.private_subnet_az  # Change to desired availability zone
}

module "security_groups" {
  source = "./modules/compute/security_groups"
  company_network_cidr = var.company_network_cidr
}

module "load_balancer" {
  source = "./modules/compute/load_balancer"
}

module "autoscaling" {
  source = "./modules/compute/asg"
  ami_id = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  ssh_keypair_name = var.ssh_keypair_name
  root_volume_size = var.root_volume_size
  additional_volume_size = var.additional_volume_size
}

module "dns" {
  source = "./modules/dns"
  private_subnet_ids = [module.vpc.private_subnet_id]
}

module "tls_cert" {
  source = "./modules/tls_cert"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}
