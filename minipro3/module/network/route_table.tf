  resource "aws_route_table" "mini3_public_route_table" {
    vpc_id = aws_vpc.mini3_vpc.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.mini3_igw.id
    }

    tags = merge(
      var.tags,
      {
        "Name" = "${var.environment} Public Route Table"
      }
    )
  }

  resource "aws_route_table_association" "mini3_public_route_table_assoc" {
    count          = 2
    subnet_id      = aws_subnet.mini3_public_subnets.*.id[count.index]
    route_table_id = aws_route_table.mini3_public_route_table.id
  }

  resource "aws_route_table" "mini3_private_route_table" {
    vpc_id = aws_vpc.mini3_vpc.id

    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id    = aws_nat_gateway.mini3_nat_gateway.id
    }
    
    tags = merge(
      var.tags,
      {
        "Name" = "${var.environment} Private Route Table"
      }
    )
  }

  resource "aws_route_table_association" "mini3_private_route_table_assoc" {
    count             = 2
    subnet_id         = aws_subnet.mini3_private_subnets.*.id[count.index]
    route_table_id    = aws_route_table.mini3_private_route_table.id
  }