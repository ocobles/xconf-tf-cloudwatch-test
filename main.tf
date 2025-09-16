provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/example/log-group"
  retention_in_days = 7
}
