#my new variables file#
variable "region" {
  type    = string
  default = null
}

# Keep for old workspaces; safe to remove later
variable "aws_region" {
  type        = string
  default     = null
  description = "Legacy var name; prefer 'region'"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "vpc_name" {
  type    = string
  default = "lab07-vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

