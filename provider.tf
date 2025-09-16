terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region

  # Optional: Configure default tags that will be applied to all resources
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      Owner       = var.owner
      ManagedBy   = "terraform"
    }
  }
}