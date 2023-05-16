resource "aws_internet_gateway" "mini-igw" {
  vpc_id = aws_vpc.minipro2.id

  tags = {
    Name = "mini-igw"
  }
}