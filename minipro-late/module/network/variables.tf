variable "vpc_cidr_block" {
  description = "vpc_cidr_block"
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.0.x.0/24"
}

variable "tags" {
  default = {
    method = "mini3"
  }
}

variable "environment" {
  default = "mini3"
}