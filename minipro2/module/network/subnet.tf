resource "aws_subnet" "mini-public_subnets" {
  count                   = 2
  cidr_block              = replace(var.subnet_cidr_block, "x", 1 + count.index)
  vpc_id                  = aws_vpc.minipro2.id
  availability_zone       = data.aws_availability_zones.availability_zones.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-public-subnet"
    }
  )
}

resource "aws_subnet" "mini-private_subnets" {
  count                   = 2
  cidr_block              = replace(var.subnet_cidr_block, "x", 11 + count.index)
  vpc_id                  = aws_vpc.minipro2.id
  availability_zone       = data.aws_availability_zones.availability_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-private-subnet"
    }
  )
}

resource "aws_subnet" "mini-subnet-data" {
  count                   = 2
  cidr_block              = replace(var.subnet_cidr_block, "x", 21 + count.index)
  vpc_id                  = aws_vpc.minipro2.id
  availability_zone       = data.aws_availability_zones.availability_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-subnet-data"
    }
  )
}

data "aws_availability_zones" "availability_zones" {
  state = "available"

  exclude_names = ["ap-northeast-2b", "ap-northeast-2d"]
}