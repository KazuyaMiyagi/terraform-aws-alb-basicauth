data "archive_file" "main" {
  type        = "zip"
  source_file = "${path.module}/app.py"
  output_path = "${path.module}/app.py.zip"
}

resource "aws_lambda_function" "main" {
  function_name    = var.name
  filename         = data.archive_file.main.output_path
  role             = aws_iam_role.main.arn
  handler          = "app.lambda_handler"
  source_code_hash = data.archive_file.main.output_base64sha256
  runtime          = "python3.8"
}

resource "aws_lambda_permission" "main" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.main.arn
}
