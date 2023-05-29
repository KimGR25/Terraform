resource "aws_security_group" "mini3_bastion_sg" {
  name = "mini3_public_sg"
  description = "Allow SSH Traffic"
  vpc_id = aws_vpc.mini3_vpc.id
  
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

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Bastion SG"
    }
  )
}

resource "aws_security_group" "mini3_jenkins_sg" {
  name = "mini3_jenkins_sg"
  description = "Allow SSH, 9090 Traffic"
  vpc_id = aws_vpc.mini3_vpc.id
  
  ingress {
    from_port   = 22
    to_port     = 22
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

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Jenkins SG"
    }
  )
}

resource "aws_security_group" "mini3_web_alb_sg" {
  name = "mini3_web_alb_sg"
  description = "Allow HTTP Traffic"
  vpc_id = aws_vpc.mini3_vpc.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} EX ELB SG"
    }
  )
}

resource "aws_security_group" "mini3_web_sg" {
  name = "mini3_web_sg"
  description = "Allow HTTP, SSH Traffic"
  vpc_id = aws_vpc.mini3_vpc.id
 
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.mini3_bastion_sg.id]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} WEB SG"
    }
  )
}

resource "aws_security_group" "mini3_was_nlb_sg" {
  name = "mini3_was_nlb_sg"
  description = "Allow HTTP Traffic"
  vpc_id = aws_vpc.mini3_vpc.id
  
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.mini3_web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} In ELB SG"
    }
  )
}

resource "aws_security_group" "mini3_was_sg" {
  name = "mini3_was_sg"
  description = "Allow HTTP, SSH Traffic"
  vpc_id = aws_vpc.mini3_vpc.id
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.mini3_bastion_sg.id]
  }
  
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.mini3_was_nlb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} WAS SG"
    }
  )
}

resource "aws_security_group" "mini3_data_sg" {
  name = "mini3_data_sg"
  description = "Allow DataBase Traffic"
  vpc_id = aws_vpc.mini3_vpc.id
  
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.mini3_was_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} DataBase SG"
    }
  )
}