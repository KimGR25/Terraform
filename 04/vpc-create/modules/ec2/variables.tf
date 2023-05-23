##### 1) Instance 변수 #####
variable "ec2_count" {
  description = "EC2 count"
  type        = number
}

variable "ami_id_AmazonLinux2023" {
  description = "(Seoul Region) AmazonLinux2023 AMI ID"
  type        = string
  default     = "ami-03f54df9441e9b380"
}

variable "instance_type" {
  description = "(Free tier) Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "instance_tag" {
  description = "Instance tags"
  type        = map(string)
  default = {
    Name = "Main"
  }
}