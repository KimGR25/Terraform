resource "aws_subnet" "mini3_public_subnets" {
  count                   = 2
  cidr_block              = replace(var.subnet_cidr_block, "x", 1 + count.index)
  vpc_id                  = aws_vpc.mini3_vpc.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Public Subnet${count.index + 1}"
    }
  )
}

resource "aws_subnet" "mini3_private_subnets" {
  count                   = 2
  cidr_block              = replace(var.subnet_cidr_block, "x", 11 + count.index)
  vpc_id                  = aws_vpc.mini3_vpc.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Private Subnet${count.index + 1}"
    }
  )
}

resource "aws_subnet" "mini3_data_subnets" {
  count                   = 2
  cidr_block              = replace(var.subnet_cidr_block, "x", 21 + count.index)
  vpc_id                  = aws_vpc.mini3_vpc.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Data Subnet${count.index + 1}"
    }
  )
}

data "aws_availability_zones" "azs" {
  state = "available"

  exclude_names = ["ap-northeast-2b", "ap-northeast-2d"]
}