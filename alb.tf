resource "aws_security_group" "allow_80_port" {
  name = "allow_80_port"
  description = "Allow 80 port from all"
  vpc_id      = "${aws_vpc.task.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "allow_80_port"
  }
}

resource "aws_lb" "task-alb" {
  name               = "task-alb"
  internal           = false
  ip_address_type = "ipv4"
  security_groups    = ["${aws_security_group.allow_80_port.id}"]
  subnet_mapping {
    subnet_id     = "${aws_subnet.pub_a.id}"
  }
  subnet_mapping {
    subnet_id     = "${aws_subnet.pub_c.id}"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.task-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tg80.arn}"
  }
}

resource "aws_lb_target_group" "tg80" {
  name     = "tg80"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.task.id}"
}

resource "aws_lb_target_group_attachment" "tg_a" {
  target_group_arn = "${aws_lb_target_group.tg80.arn}"
  target_id        = "${aws_instance.prvi_a.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_c" {
  target_group_arn = "${aws_lb_target_group.tg80.arn}"
  target_id        = "${aws_instance.prvi_c.id}"
  port             = 80
}
