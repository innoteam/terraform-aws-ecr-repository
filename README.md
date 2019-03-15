# terraform-aws-ecr-repository

Terraform module that manages AWS ECR repositories

This module creates an AWS ECR repository resource and 


## Input variables

* `name` (string): The name of the ECR repository.
* `aws_accounts_allowed_to_pull` (list): The IDs of the AWS accounts that will be allowed to pull images from this repository. Specify '*' to make the repository public.

## Outputs

* `arn` (string): The ARN of the ECR repository.