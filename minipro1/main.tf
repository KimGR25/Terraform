resource "aws_vpc" "bsc_vpc" {
  cidr_block       = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "bsc_public_subnet" {
  vpc_id     = aws_vpc.bsc_vpc.id
  cidr_block = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2b"

  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "bsc_ineternet_gateway" {
  vpc_id = aws_vpc.bsc_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "bsc_public_rt" {
  vpc_id = aws_vpc.bsc_vpc.id

  tags = {
    Name = "dev_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id            = aws_route_table.bsc_public_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.bsc_ineternet_gateway.id
}

resource "aws_route_table_association" "bsc_public_assoc" {
  subnet_id      = aws_subnet.bsc_public_subnet.id
  route_table_id = aws_route_table.bsc_public_rt.id
}

resource "aws_security_group" "bsc_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.bsc_vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev_sg"
  }
}

resource "aws_key_pair" "bsc_auth" {
  key_name   = "bsckey"
  public_key = file("~/.ssh/bsckey.pub")
}

resource "aws_instance" "dev-server" {
  ami           = data.aws_ami.server-ami.id
  instance_type = "t2.micro"

  key_name = aws_key_pair.bsc_auth.id

  vpc_security_group_ids = [aws_security_group.bsc_sg.id]

  subnet_id = aws_subnet.bsc_public_subnet.id

  user_data = file("userdata.tpl")
  user_data_replace_on_change = true

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "My Dev Server"
  }
}