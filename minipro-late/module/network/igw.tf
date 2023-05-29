resource "aws_internet_gateway" "mini3_igw" {
  vpc_id = aws_vpc.mini3_vpc.id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Internet Gateway"
    }
  )
}