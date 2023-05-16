resource "aws_route_table" "mini-public-route-table" {
  vpc_id = aws_vpc.minipro2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mini-igw.id
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-route-table-public"
    }
  )
}

resource "aws_route_table_association" "mini-public-route-table-assoc" {
  count          = 2
  subnet_id      = aws_subnet.mini-public_subnets.*.id[count.index]
  route_table_id = aws_route_table.mini-public-route-table.id
}

resource "aws_route_table" "mini-private-route-table" {
  vpc_id = aws_vpc.minipro2.id
  
  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-route-table-private"
    }
  )
}

resource "aws_route_table_association" "mini-private-route-table-assoc" {
  count          = 2
  subnet_id      = aws_subnet.mini-private_subnets.*.id[count.index]
  route_table_id = aws_route_table.mini-private-route-table.id
}