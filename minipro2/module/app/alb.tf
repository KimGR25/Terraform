resource "aws_lb" "alb" {
  name            = "alb"
  security_groups = var.alb_security_group_ids
  subnets         = var.public_subnet_ids
  load_balancer_type = "application"
  idle_timeout    = 400

  depends_on = [
    aws_autoscaling_group.asg_app
  ]

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-alb"
    }
  )
}

resource "aws_lb_target_group" "alb-tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-lb-tg"
    }
  )
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }

  tags = merge(
    var.tags,
    {
      "name" = "${var.environment}-lb-listener"
    }
  )
}