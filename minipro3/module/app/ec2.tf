# Bastion 서버 인스턴스 생성
resource "aws_instance" "mini3_bastion_intence" {
  ami           = "ami-073858dcf4e30e586"
  instance_type = "t2.micro"
  key_name      = "mykeypair"
  subnet_id     = var.public_subnets_ids
  vpc_security_group_ids = var.bastion_security_group_ids

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Bastion Instence"
    }
  )

}

# Jenkins 서버 인스턴스 생성
resource "aws_instance" "mini3_jenkins_intence" {
  ami           = "ami-073858dcf4e30e586"
  instance_type = "t3.small"
  key_name      = "mykeypair"
  subnet_id     = var.public_subnets_ids
  vpc_security_group_ids = var.jenkins_security_group_ids

  user_data = filebase64("./script/jenkins.sh")

  iam_instance_profile = aws_iam_instance_profile.mini3_jenkins_instance_profile.name

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Jenkins Instence"
    }
  )

}

# WEB 서버 런치템플릿
resource "aws_launch_template" "mini3_web_template" {
  name_prefix            = "web"
  instance_type          = "t2.micro"
  image_id               = "ami-073858dcf4e30e586"
  vpc_security_group_ids = var.web_security_group_ids
  key_name               = "mykeypair"

  user_data = base64encode(templatefile("./script/web.sh", {
  dns_address = aws_lb.mini3_was_nlb.dns_name
}))
  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} WEB Launch Template"
    }
  )
}

# WAS 서버 런치템플릿
resource "aws_launch_template" "mini3_was_template" {
  name_prefix            = "was"
  instance_type          = "t2.micro"
  image_id               = "ami-073858dcf4e30e586"
  vpc_security_group_ids = var.was_security_group_ids
  key_name               = "mykeypair"

  user_data = filebase64("./script/was.sh")

  iam_instance_profile {
      name = aws_iam_instance_profile.mini3_was_instance_profile.name
    }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} WAS Launch Template"
    }
  )
}

# 오토 스케일링 그룹 생성
# WEB 서버
resource "aws_autoscaling_group" "mini3_web_asg" {
  name                = "mini3_asg_web"
  vpc_zone_identifier = var.private_subnets_ids
  min_size            = 2
  max_size            = 4
  desired_capacity    = 2

  target_group_arns = tolist([aws_lb_target_group.mini3_web_alb_tg.arn])

  launch_template {
    id      = aws_launch_template.mini3_web_template.id
  }
}

resource "aws_autoscaling_attachment" "mini3_web_asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.mini3_web_asg.id
  lb_target_group_arn    = aws_lb_target_group.mini3_web_alb_tg.arn
}

# WAS 서버
resource "aws_autoscaling_group" "mini3_was_asg" {
  name                = "mini3_asg_was"
  vpc_zone_identifier = var.private_subnets_ids
  min_size            = 2
  max_size            = 4
  desired_capacity    = 2

  target_group_arns = tolist([aws_lb_target_group.mini3_was_nlb_tg.arn])

  launch_template {
    id      = aws_launch_template.mini3_was_template.id
  }
}

resource "aws_autoscaling_attachment" "mini3_was_asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.mini3_was_asg.id
  lb_target_group_arn    = aws_lb_target_group.mini3_was_nlb_tg.arn
}