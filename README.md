# terraform-aws-ecr-repository

Terraform module that manages AWS ECR repositories

This module creates an AWS ECR repository resource and creates a repository policy that allow AWS accounts to read from it.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_accounts\_allowed\_to\_pull | The IDs of the AWS accounts that will be allowed   to pull images from this repository.   Specify '\*' to allow all AWS accounts. | `list(string)` | n/a | yes |
| images\_retention\_count | The number of images to keep before expiration | `number` | n/a | yes |
| images\_retention\_tag\_prefix\_list | The number of images to keep before expiration | `list(string)` | `[]` | no |
| name | The name of the ECR repository | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of this repository |
| name | The name of this repository |
| url | The URL of this repository |

