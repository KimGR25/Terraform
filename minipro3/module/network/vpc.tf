resource "aws_vpc" "mini3_vpc" {
  cidr_block = var.vpc_cidr_block

  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy     = "default"

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}_VPC"
    }
  )
}