variable "vpc-cidr-block" {
  description = "vpc-cidr-block value"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc-name" {
  description = "VPC Name"
  type = map
  default = {
    Name = "mini-vpc"
  }
}

variable "subnet_cidr_block" {
  default = "10.0.x.0/24"
}

variable "tags" {
  default = {
    method = "mini"
  }
}

variable "environment" {
  default = "mini"
}