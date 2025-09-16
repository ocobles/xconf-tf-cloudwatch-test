variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod"
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "cloudwatch-test"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "platform-team"
}

# CloudWatch Log Group Variables
variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = "/application/cloudwatch-test/app"

  validation {
    condition = can(regex("^/(aws|application|lambda|ecs|apigateway)/", var.log_group_name))
    error_message = "Log group name must start with one of: /aws/, /application/, /lambda/, /ecs/, /apigateway/"
  }
}

variable "log_retention_days" {
  description = "Number of days to retain log events"
  type        = number
  default     = 30

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.log_retention_days)
    error_message = "Log retention must be one of the allowed values: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653"
  }
}

variable "enable_kms_encryption" {
  description = "Whether to enable KMS encryption for the log group"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "KMS key ID for log group encryption (required if enable_kms_encryption is true)"
  type        = string
  default     = null
}

variable "additional_tags" {
  description = "Additional tags to apply to the log group"
  type        = map(string)
  default     = {}
}