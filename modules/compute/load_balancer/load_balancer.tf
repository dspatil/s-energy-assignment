resource "aws_lb" "web" {
  name               = "web_lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [module.vpc.public_subnet_id]
  security_groups    = [aws_security_group.public_lb_sg.id]
}

resource "aws_lb_target_group" "web" {
  name     = "web_target_group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/health"
    interval            = 30  # Health check interval in seconds
    timeout             = 5   # Health check timeout in seconds
    healthy_threshold   = 2   # Number of consecutive successful health checks required to consider an instance healthy
    unhealthy_threshold = 2   # Number of consecutive failed health checks required to consider an instance unhealthy
    matcher             = "200-299"  # HTTP codes to consider a success
  }

}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 443
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

output "load_balancer_dns_name" {
  value = aws_lb.web.dns_name
}
