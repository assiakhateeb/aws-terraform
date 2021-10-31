# create target group (TG)
resource "aws_lb_target_group" "TG" {
  name     = "tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default.id
}

# provides the ability to register instances and containers with a LB target group
resource "aws_lb_target_group_attachment" "first" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.web[0].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "second" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.web[1].id
  port             = 80
}

# provides details about a specific VPC subnet
data "aws_subnet_ids" "subnet" {
  vpc_id = aws_default_vpc.default.id
}

# provides a Load Balancer resource.
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_web.id]
  subnets            = data.aws_subnet_ids.subnet.ids

  enable_deletion_protection = true
  tags = {
    Name = "tf-load-balancer"
  }
}

# provides a Load Balancer Listener resource.
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}