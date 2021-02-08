module "this" {
  source = "../../"
}

variable "basicauth_username" {
  default = "user"
}

variable "basicauth_password" {
  default = "pass"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name = "default"
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "main" {
  name   = "example"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "main" {
  name               = "example"
  load_balancer_type = "application"
  internal           = false

  subnets = data.aws_subnet_ids.default.ids

  security_groups = [aws_security_group.main.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Bad request"
      status_code  = "400"
    }
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "It works"
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
      values = ["/secret*"]
    }
  }

  condition {
    http_header {
      http_header_name = "authorization"
      values           = ["Basic ${base64encode("${var.basicauth_username}:${var.basicauth_password}")}"]
    }
  }
}

resource "aws_lb_listener_rule" "basicauth" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = module.this.target_group.arn
  }

  condition {
    path_pattern {
      values = ["/secret*"]
    }
  }
}
