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

