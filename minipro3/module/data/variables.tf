variable "tags" {
  default = {
    method = "mini3"
  }
}

variable "environment" {
  default = "mini3"
}

variable "data_subnet_ids" {}
variable "data_security_group_ids" {}