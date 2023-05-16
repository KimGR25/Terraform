resource "aws_launch_template" "bastion" {
  name_prefix            = "bastion"
  instance_type          = "t2.micro"
  image_id               = "ami-03f54df9441e9b380"
  vpc_security_group_ids = var.bastion_security_group_ids

  tags = merge(
    var.tags,
    {
      "name" = "${var.environment}-bastion"
    }
  )
}

resource "aws_launch_template" "app" {
  name_prefix            = "app"
  instance_type          = "t2.micro"
  image_id               = "ami-03f54df9441e9b380"
  vpc_security_group_ids = var.app_security_group_ids

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-app"
    }
  )
}

resource "aws_autoscaling_group" "asg_bastion" {
  name                = "asg-bastion"
  vpc_zone_identifier = var.public_subnet_ids
  min_size            = 1
  max_size            = 1
  desired_capacity    = 1

  launch_template {
    id      = aws_launch_template.bastion.id
  }
}

resource "aws_autoscaling_group" "asg_app" {
  name                = "asg-app"
  vpc_zone_identifier = var.private_subnet_ids
  min_size            = 2
  max_size            = 10
  desired_capacity    = 2

  target_group_arns = tolist([aws_lb_target_group.alb-tg.arn])

  launch_template {
    id      = aws_launch_template.app.id
  }
}

resource "aws_autoscaling_attachment" "asg_app_attach" {
  autoscaling_group_name = aws_autoscaling_group.asg_app.id
  lb_target_group_arn    = aws_lb_target_group.alb-tg.arn
}