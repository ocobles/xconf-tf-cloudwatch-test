terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/example"
  retention_in_days = 30

  tags = {
    Environment = "dev"
    Owner       = "team"
    Project     = "test"
    ManagedBy   = "terraform"
  }
}