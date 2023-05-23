####### 1) VPC 생성 ##########
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "instance_tenancy" {
  description = "Instance tenancy in VPC"
  type        = string
  default     = "default"
}

variable "vpc_tag" {
  description = "VPC tags"
  type        = map(string)
  default = {
    Name = "main"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
  description = "VPC ID"
}

####### 2) Subnet 생성 ##########
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR"
  type        = string
}

variable "subnet_tag" {
  description = "Subnet tags"
  type        = map(string)
  default = {
    Name = "Main"
  }
}