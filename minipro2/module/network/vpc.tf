resource "aws_vpc" "minipro2" {
  cidr_block = var.vpc-cidr-block

  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy     = "default"

  tags = var.vpc-name
}