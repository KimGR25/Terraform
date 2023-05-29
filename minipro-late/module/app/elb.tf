resource "aws_lb" "mini3_web_alb" {
  name            = "mini3-web-alb"
  security_groups = var.web_alb_security_group_ids
  subnets         = var.public_subnets_ids2
  load_balancer_type = "application"
  idle_timeout    = 300

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} WEB ALB"
    }
  )
}

resource "aws_lb_target_group" "mini3_web_alb_tg" {
  name     = "mini3-web-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} WEB ALB TG"
    }
  )
}

resource "aws_lb_listener" "mini3_web_alb_listener" {
  load_balancer_arn = aws_lb.mini3_web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mini3_web_alb_tg.arn
  }

  tags = merge(
    var.tags,
    {
      "name" = "${var.environment} WEB ALB Listener"
    }
  )
}

resource "aws_lb" "mini3_was_nlb" {
  name            = "mini3-was-nlb"
  internal           = true
  security_groups = var.was_nlb_security_group_ids
  subnets         = var.private_subnets_ids
  load_balancer_type = "network"
  idle_timeout    = 300

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} WAS NLB"
    }
  )
}

resource "aws_lb_target_group" "mini3_was_nlb_tg" {
  name     = "mini3-was-nlb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} WAS NLB TG"
    }
  )
}

resource "aws_lb_listener" "mini3_was_nlb_listener" {
  load_balancer_arn = aws_lb.mini3_was_nlb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mini3_was_nlb_tg.arn
  }

  tags = merge(
    var.tags,
    {
      "name" = "${var.environment} WAS NLB Listener"
    }
  )
}