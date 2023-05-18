variable "tags" {
  default = {
    method = "mini"
  }
}

variable "environment" {
  default = "mini"
}

variable "subnet-group-ids" {}
variable "rds-security-group-ids" {}