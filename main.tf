#my new files#

locals {
  # Works with either `region` or old `aws_region`
  effective_region = coalesce(var.region, var.aws_region, "us-east-2")
}

provider "aws" {
  region = local.effective_region
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = var.vpc_name
    Environment = var.environment
  }
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

