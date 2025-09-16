terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = "/application/example/log-group"
}

variable "retention_in_days" {
  description = "Log retention in days"
  type        = number
  default     = 30
}

resource "aws_cloudwatch_log_group" "example" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days

  tags = {
    Environment = "dev"
    Owner       = "development-team"
    Project     = "aws-infrastructure"
    ManagedBy   = "terraform"
  }
}

output "log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.example.name
}

output "log_group_arn" {
  description = "The ARN of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.example.arn
}