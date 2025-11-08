#my new files in prod#
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "example-org-be54ee" # 👈 your org
    # workspace name comes from -backend-config file
  }
}

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
    Owner       = "efrem2"
  }
}
