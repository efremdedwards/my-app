variable "region" {
  type    = string
  default = "us-east-2"
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

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "num_1" {
  type    = number
  default = 10
}

variable "num_2" {
  type    = number
  default = 20
}

variable "num_3" {
  type    = number
  default = 30
}
variable "web_ingress" {
  description = "List of web ports to allow"
  type = list(object({
    port : number
    description : string
  }))
  default = [
    { port = 80, description = "HTTP" },
    { port = 443, description = "HTTPS" }
  ]
}

variable "bucket_name" {
  description = "Globally-unique S3 bucket name for the module"
  type        = string
  default     = "efrem-lab06-bucket-CHANGE-ME"
}

