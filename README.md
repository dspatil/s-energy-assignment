# s-energy-assignment
Repo for s-energy-assignment

# Terraform Module: Web Application Deployment

## Overview
This Terraform module deploys a web application infrastructure on AWS.

## Assumptions
The terraform code is run as a jenkins pipeline and Jenkins server/slave is running on a EC2 instance having instance profile/role attched to it and having all access granted via policy to luanch AWS infrastructure. 

## Inputs
| Name          | Description           | Type   | Default |
|---------------|-----------------------|--------|---------|
| vpc_cidr_block | CIDR block for the VPC | string | -       |
| public_subnet_cidr_block | CIDR block for the public subnet | string | -       |
| public_subnet_az | Public subnet AZ | string | -       |
| private_subnet_cidr_block | CIDR block for the private subnet | string | -       |
| private_subnet_az | Private subnet AZ | string | -       |
| company_network_cidr | CIDR block of company internal network | string | -       |
| ami_id | AMI id to use | string | -       |
| instance_type | Instance type to use | string | -       |
| ssh_keypair_name | SSH keypair name to use | string | -       |
| root_volume_size | Root volume size in GB | string | -       |
| additional_volume_size | Additional volume size in GB | string | -       |

## Outputs
| Name               | Description               |
|--------------------|---------------------------|
| vpc_id             | ID of the created VPC     |
| public_subnet_id   | ID of the public subnet   |
| private_subnet_id  | ID of the private subnet  |
| load_balancer_dns_name  | LB dns url  |


## Deployment

### Steps
1. Init
  `terraform init`

2. Plan
  `terraform plan`

3. apply
   `terraform apply`
