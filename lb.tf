resource "aws_lb_target_group" "main" {
  name        = var.name
  target_type = "lambda"
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 35
    matcher             = "200"
    path                = "/"
    timeout             = 30
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_lambda_function.main.arn
  depends_on       = [aws_lambda_permission.main]
}
