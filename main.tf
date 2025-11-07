provider "aws" {
  region = "us-east-2" # 👈 stays in one region
}

# Minimal VPC for lab
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = upper("lab06-vpc")
   Environment = "var.environment"
   Terraform = "true"
  }
}

# Single subnet (no each.value, no undefined var)
resource "aws_subnet" "list_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24" # 👈 just pick one CIDR
  availability_zone = "us-east-2a"  # �� one AZ in your region

  tags = {
    Name = "efrem-lab06-subnet"
  }
}
locals {
  maximum = max(var.num_1, var.num_2, var.num_3)
  minimum = min(var.num_1, var.num_2, var.num_3, 44, 20)
}



resource "aws_security_group" "main" {
  name   = "core-sg"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.web_ingress

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

module "s3" {
  source  = "app.terraform.io/example-org-be54ee/s3-bucket/aws"
  version = "1.0.0"

  bucket = "my-lab-bucket"
  region      = "us-east-2"
}

output "max_value" {
  value = local.maximum
}

output "min_value" {
  value = local.minimum
}

output "lab06" {
  value = upper("labby06")
}
