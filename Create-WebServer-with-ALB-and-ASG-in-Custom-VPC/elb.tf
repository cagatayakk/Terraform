resource "aws_lb" "my_elb" {
  name               = "myelb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-elb.id]
  subnets            = [aws_subnet.my_subnet_1.id, aws_subnet.my_subnet_2.id]

  enable_deletion_protection = false



  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "my_tg" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    port                = 80
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}