variable "tags" {
  default = {
    method = "mini"
  }
}

variable "environment" {
  default = "mini"
}

variable "vpc_id" {}
variable "bastion_security_group_ids" {}
variable "app_security_group_ids" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}
variable "alb_security_group_ids" {}
variable "rds_endpoint" {}