# xconf-tf-cloudwatch-test

This repository contains a Terraform template to deploy a single AWS CloudWatch log group.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (version ~> 1.0)
- AWS credentials configured (e.g., via AWS CLI or environment variables)

## Usage

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd xconf-tf-cloudwatch-test
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the plan:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

5. To destroy the resources:
   ```bash
   terraform destroy
   ```

## Configuration

You can customize the deployment by modifying the variables in `main.tf`:

- `region`: AWS region (default: us-east-1)
- `log_group_name`: Name of the log group (default: /application/example/log-group)
- `retention_in_days`: Log retention period in days (default: 30)

## Outputs

After deployment, the following outputs will be available:

- `log_group_name`: The name of the created log group
- `log_group_arn`: The ARN of the created log group
