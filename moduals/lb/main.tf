resource "aws_lb" "external_alb" {
  name               = "external-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id] 
}
resource "aws_lb_target_group" "apache_tg" {
  name     = "apache-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path     = "/"
    port     = "80"
    protocol = "HTTP"
  }
}
resource "aws_lb_target_group_attachment" "apache" {
  for_each = {
    apache1 = aws_instance.apache1.id
    apache2 = aws_instance.apache2.id
  }

  target_group_arn = aws_lb_target_group.apache_tg.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache_tg.arn
  }
}