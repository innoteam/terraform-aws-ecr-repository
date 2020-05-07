# terraform-aws-ecr-repository

Terraform module that manages AWS ECR repositories

This module creates an AWS ECR repository resource and creates a repository policy that allow AWS accounts to read from it.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_accounts\_allowed\_to\_pull | The IDs of the AWS accounts that will be allowed   to pull images from this repository.   Specify '\*' to allow all AWS accounts. | `list(string)` | n/a | yes |
| images\_retention\_count | The number of images to keep before expiration | `number` | n/a | yes |
| images\_retention\_tag\_prefix\_list | Only used if you specified "tagStatus": "tagged". You must specify a comma-separated list of image tag prefixes on which to take action with your lifecycle policy. If you specify multiple tags, only the images with all specified tags are selected. | `list(string)` | `[]` | no |
| images\_retention\_tag\_status | Determines whether the lifecycle policy rule that you are adding specifies a tag for an image. Acceptable options are 'tagged' or 'any'. If you specify 'any', then all images have the rule applied to them. If you specify 'tagged', then you must also specify a tagPrefixList value. | `string` | `"any"` | no |
| name | The name of the ECR repository | `any` | n/a | yes |
| untagged\_images\_retention\_days | The number of days to keep untagged images before expiration | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of this repository |
| name | The name of this repository |
| url | The URL of this repository |

