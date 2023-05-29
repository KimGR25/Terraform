resource "aws_eip" "nat_eip" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "mini3_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.mini3_public_subnets.*.id[1]

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Nat Gateway"
    }
  )
}