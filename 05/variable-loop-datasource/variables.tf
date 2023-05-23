variable "region" {
  default = "ap-northeast-2"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "vsubnet_cidr" {
  default = [
    "10.0.1.0/24", 
    "10.0.2.0/24", 
    "10.0.3.0/24", 
    "10.0.4.0/24"
    ]
}

# variable "asz" {
#   type = list
#   default = [
#     "ap-northeast-2a", 
#     "ap-northeast-2b", 
#     "ap-northeast-2c", 
#     "ap-northeast-2d" 
#     ]
# }

data "aws_availability_zones" "azs" {}