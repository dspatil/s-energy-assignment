# s-energy-assignment
Repo for s-energy-assignment

# Terraform Module: Web Application Deployment

## Overview
This Terraform module deploys a web application infrastructure on AWS.

## Inputs
| Name          | Description           | Type   | Default |
|---------------|-----------------------|--------|---------|
| vpc_cidr_block | CIDR block for the VPC | string | -       |
| ...           |                       |        |         |

## Outputs
| Name               | Description               |
|--------------------|---------------------------|
| vpc_id             | ID of the created VPC     |
| public_subnet_id   | ID of the public subnet   |
| private_subnet_id  | ID of the private subnet  |

## Deployment
