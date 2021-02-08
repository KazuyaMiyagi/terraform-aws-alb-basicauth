resource "aws_iam_role" "main" {
  name               = "${title(var.name)}-Role"
  path               = "/service-role/"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "main" {
  name   = "${title(var.name)}-Policy"
  role   = aws_iam_role.main.id
  policy = <<-EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "",
              "Effect": "Allow",
              "Action": [
                  "logs:PutLogEvents",
                  "logs:CreateLogStream",
                  "logs:CreateLogGroup"
              ],
              "Resource": "${aws_cloudwatch_log_group.main.arn}:*"
          }
      ]
  }
  EOF
}
