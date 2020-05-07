variable "name" {
  description = "The name of the ECR repository"
}

variable "aws_accounts_allowed_to_pull" {
  type = list(string)

  description = <<EOF
  The IDs of the AWS accounts that will be allowed
  to pull images from this repository.
  Specify '*' to allow all AWS accounts.
  
EOF

}

variable "images_retention_count" {
  type        = number
  description = "The number of images to keep before expiration"
}

variable "images_retention_tag_status" {
  type        = string
  default     = "any"
  description = <<EOF
Determines whether the lifecycle policy rule that you are adding specifies a tag for an image.
Acceptable options are 'tagged' or 'any'.
If you specify 'any', then all images have the rule applied to them.
If you specify 'tagged', then you must also specify a tagPrefixList value.
EOF
}

variable "images_retention_tag_prefix_list" {
  type        = list(string)
  default     = []
  description = <<EOF
Only used if you specified "tagStatus": "tagged".
You must specify a comma-separated list of image tag prefixes on which to take action with your lifecycle policy.
If you specify multiple tags, only the images with all specified tags are selected.
  EOF
}

variable "untagged_images_retention_days" {
  type        = number
  default     = 30
  description = "The number of days to keep untagged images before expiration"
}
