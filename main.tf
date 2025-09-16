# CloudWatch Log Group Example
# This template demonstrates how to create CloudWatch log groups with best practices

resource "aws_cloudwatch_log_group" "application_logs" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_days

  # Enable KMS encryption for sensitive log groups
  # This is required for log groups containing sensitive data
  kms_key_id = var.enable_kms_encryption ? var.kms_key_id : null

  tags = merge(
    {
      Name        = var.log_group_name
      Type        = "application"
      Component   = "logging"
      Purpose     = "centralized-logging"
    },
    var.additional_tags
  )
}

# Example of a Lambda function log group (follows AWS naming convention)
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.project_name}-function"
  retention_in_days = 30  # Lambda logs typically need shorter retention

  # Lambda logs are considered sensitive and should be encrypted
  kms_key_id = var.enable_kms_encryption ? var.kms_key_id : null

  tags = merge(
    {
      Name      = "/aws/lambda/${var.project_name}-function"
      Type      = "lambda"
      Component = "function-logs"
      Purpose   = "function-logging"
    },
    var.additional_tags
  )
}

# Example of an ECS service log group
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.project_name}/app"
  retention_in_days = 90  # Application logs typically need longer retention

  # Application logs may contain sensitive data
  kms_key_id = var.enable_kms_encryption ? var.kms_key_id : null

  tags = merge(
    {
      Name      = "/ecs/${var.project_name}/app"
      Type      = "ecs"
      Component = "container-logs"
      Purpose   = "container-logging"
    },
    var.additional_tags
  )
}

# Example of an API Gateway log group
resource "aws_cloudwatch_log_group" "api_gateway_logs" {
  name              = "/aws/apigateway/${var.project_name}-api"
  retention_in_days = 90

  # API logs may contain sensitive request data
  kms_key_id = var.enable_kms_encryption ? var.kms_key_id : null

  tags = merge(
    {
      Name      = "/aws/apigateway/${var.project_name}-api"
      Type      = "api-gateway"
      Component = "api-logs"
      Purpose   = "api-logging"
    },
    var.additional_tags
  )
}

# Optional: CloudWatch Log Stream (usually created automatically by services)
# Uncomment if you need to create log streams explicitly
/*
resource "aws_cloudwatch_log_stream" "example_stream" {
  name           = "example-stream"
  log_group_name = aws_cloudwatch_log_group.application_logs.name
}
*/