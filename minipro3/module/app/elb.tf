resource "aws_lb" "mini3_alb" {
  name            = "mini3-alb"
  security_groups = var.alb_security_group_ids
  subnets         = var.public_subnets_ids2
  load_balancer_type = "application"
  idle_timeout    = 300

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} ALB"
    }
  )
}

resource "aws_lb_target_group" "mini3_alb_tg" {
  name     = "mini3-alb-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} ALB TG"
    }
  )
}

resource "aws_lb_listener" "mini3_web_alb_listener" {
  load_balancer_arn = aws_lb.mini3_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mini3_alb_tg.arn
  }

  tags = merge(
    var.tags,
    {
      "name" = "${var.environment} ALB Listener"
    }
  )
}