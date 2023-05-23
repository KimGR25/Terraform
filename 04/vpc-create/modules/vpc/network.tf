##### 1) VPC 생성 #####
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  
  tags = var.vpc_tag
}

##### 2) Subnet 생성 ######
resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
  tags       = var.subnet_tag
}

output "subnet_id" {
  description = "Subnet ID"
  value = aws_subnet.main.id
}