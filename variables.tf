variable "region" {
  type    = string
  default = null
}

variable "aws_region" {
  type        = string
  default     = null
  description = "Legacy variable name for compatibility with existing TFC workspaces"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_name" {
  type    = string
  default = "lab06-vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

