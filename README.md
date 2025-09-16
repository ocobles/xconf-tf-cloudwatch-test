# AWS CloudWatch Log Group Terraform Template

This Terraform template provides a comprehensive example for deploying AWS CloudWatch log groups with best practices, security configurations, and proper tagging.

## Features

- **Multiple Log Group Types**: Application, Lambda, ECS, and API Gateway log groups
- **Security Best Practices**: KMS encryption support for sensitive log groups
- **Compliance**: Follows AWS and organizational tagging standards
- **Flexible Configuration**: Customizable retention periods and naming conventions
- **Validation**: Input validation for environment, retention, and naming standards

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate permissions
- AWS account with CloudWatch and KMS permissions (if using encryption)

## Quick Start

1. **Clone and navigate to the directory**:
   ```bash
   cd xconf-tf-cloudwatch-test
   ```

2. **Configure variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your values
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Review the plan**:
   ```bash
   terraform plan
   ```

5. **Apply the configuration**:
   ```bash
   terraform apply
   ```

## Configuration

### Required Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region for resources | `us-east-1` | No |
| `environment` | Environment (dev/staging/prod) | `dev` | No |
| `project_name` | Name of your project | `cloudwatch-test` | No |
| `owner` | Owner of the resources | `platform-team` | No |

### Log Group Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `log_group_name` | Name of the main log group | `/application/cloudwatch-test/app` | No |
| `log_retention_days` | Days to retain logs | `30` | No |
| `enable_kms_encryption` | Enable KMS encryption | `false` | No |
| `kms_key_id` | KMS key ID for encryption | `null` | Only if encryption enabled |

### Naming Conventions

Log groups follow AWS best practices with these prefixes:
- `/aws/` - AWS managed services (Lambda, API Gateway)
- `/application/` - Custom applications
- `/ecs/` - ECS container services
- `/lambda/` - Lambda functions

### Retention Policies

Supported retention periods (days):
- 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653

Recommended retention by log type:
- **Lambda**: 30 days
- **Application**: 90 days
- **Security/Audit**: 365 days
- **VPC Flow Logs**: 90 days

## Security Considerations

### KMS Encryption

Enable KMS encryption for sensitive log groups:
```hcl
enable_kms_encryption = true
kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
```

### Required Tags

All resources include these mandatory tags:
- `Environment`: dev/staging/prod
- `Project`: Your project name
- `Owner`: Resource owner
- `ManagedBy`: terraform

## Examples

### Basic Application Logs
```hcl
log_group_name = "/application/my-app/logs"
log_retention_days = 90
```

### Encrypted Security Logs
```hcl
log_group_name = "/application/security/audit"
log_retention_days = 365
enable_kms_encryption = true
kms_key_id = "arn:aws:kms:region:account:key/key-id"
```

### Lambda Function Logs
The template automatically creates a Lambda log group at:
`/aws/lambda/{project_name}-function`

## Outputs

The template provides these outputs:
- `application_log_group_name` - Main application log group name
- `application_log_group_arn` - Main application log group ARN
- `lambda_log_group_name` - Lambda function log group name
- `lambda_log_group_arn` - Lambda function log group ARN
- `ecs_log_group_name` - ECS service log group name
- `ecs_log_group_arn` - ECS service log group ARN
- `api_gateway_log_group_name` - API Gateway log group name
- `api_gateway_log_group_arn` - API Gateway log group ARN

## Cost Optimization

- Set appropriate retention periods to control storage costs
- Use shorter retention for development environments
- Consider log archiving to S3 for long-term storage
- Monitor CloudWatch costs using Cost Explorer

## Troubleshooting

### Common Issues

1. **KMS Key Permissions**: Ensure your IAM user/role has permissions to use the KMS key
2. **Log Group Already Exists**: Use a unique name or import existing log groups
3. **Retention Validation**: Use only supported retention values

### Validation Errors

The template includes validation for:
- Environment values (dev/staging/prod)
- Log retention periods (supported AWS values)
- Naming conventions (allowed prefixes)

## Contributing

1. Follow the established naming conventions
2. Include appropriate tags
3. Test with multiple environments
4. Update documentation for new features

## License

This template is provided as-is for educational and operational use.
