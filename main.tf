provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = var.vpc_name
    Environment = var.environment # no quotes around the var
    Terraform   = "true"
  }
}

resource "aws_subnet" "list_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.vpc_name}-subnet" }
}

locals {
  maximum = max(var.num_1, var.num_2, var.num_3)
  minimum = min(var.num_1, var.num_2, var.num_3, 44, 20)
}

resource "aws_security_group" "main" {
  name        = "${var.vpc_name}-sg"
  description = "Example SG"
  vpc_id      = aws_vpc.vpc.id

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "s3" {
  source  = "app.terraform.io/example-org-be54ee/s3-bucket/aws"
  version = "1.0.0"

  # adjust to your module’s expected inputs
  bucket = var.bucket_name # must be globally unique
  region = var.region
}

output "max_value" { value = local.maximum }
output "min_value" { value = local.minimum }
output "lab06" { value = upper("labby06") }

