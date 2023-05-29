variable "tags" {
  default = {
    method = "mini3"
  }
}

variable "environment" {
  default = "mini3"
}

variable "vpc_id" {}
variable "public_subnets_ids" {}
variable "public_subnets_ids2" {}
variable "private_subnets_ids" {}
variable "bastion_security_group_ids" {}
variable "jenkins_security_group_ids" {}
variable "web_security_group_ids" {}
variable "was_security_group_ids" {}
variable "web_alb_security_group_ids" {}
variable "was_nlb_security_group_ids" {}