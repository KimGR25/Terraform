resource "aws_security_group" "mini-bastion-sg" {
  name = "minipro2_bastion_security_group"
  description = "allow SSH Traffic"
  vpc_id = aws_vpc.minipro2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minipro2_bastion_security_group"
  }
}

resource "aws_security_group" "mini-alb-sg" {
  name        = "minipro2-alb-sg"
  description = "allow HTTP traffic"
  vpc_id      = aws_vpc.minipro2.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "minipro2-alb-sg"
  }
}

resource "aws_security_group" "mini-app-sg" {
  name = "minipro2-app-sg"
  description = "Allow SSH, HTTP Traffic"
  vpc_id = aws_vpc.minipro2.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.mini-bastion-sg.id]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.mini-alb-sg.id]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.mini-alb-sg.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minipro2-app-sg"
  }
}

resource "aws_security_group" "mini-rbs-sg" {
  name = "minipro2-rbs-sg"
  description = "Allow Database Port Traffic"
  vpc_id = aws_vpc.minipro2.id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.mini-app-sg.id, aws_security_group.mini-bastion-sg.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
     Name = "minipro2-rbs-sg"
  }
}
