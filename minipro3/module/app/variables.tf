variable "tags" {
  default = {
    method = "mini3"
  }
}

variable "environment" {
  default = "mini3"
}

variable "container_name" {
  default = "mini3-service"
}

variable "vpc_id" {}
variable "public_subnets_ids" {}
variable "public_subnets_ids2" {}
variable "private_subnets_ids" {}
variable "bastion_security_group_ids" {}
variable "alb_security_group_ids" {}
variable "code_commit_url" {}
