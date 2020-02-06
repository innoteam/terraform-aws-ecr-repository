# terraform-aws-ecr-repository

Terraform module that manages AWS ECR repositories

This module creates an AWS ECR repository resource and creates a repository policy that allow AWS accounts to read from it.


## Input variables

* `name` (string): The name of the ECR repository.
* `aws_accounts_allowed_to_pull` (list): The IDs of the AWS accounts that will be allowed to pull images from this repository. Specify '*' to make the repository public.

## Outputs

* `arn` (string): The ARN of the ECR repository.## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_accounts\_allowed\_to\_pull | The IDs of the AWS accounts that will be allowed   to pull images from this repository.   Specify '\*' to allow all AWS accounts. | `list(string)` | n/a | yes |
| name | The name of the ECR repository | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of this repository |
| name | The name of this repository |
| url | The URL of this repository |

