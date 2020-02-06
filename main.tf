resource "aws_ecr_repository" "this" {
  name = var.name
}

data "aws_iam_policy_document" "allow_account_pull" {
  statement {
    sid    = "AllowPull"
    effect = "Allow"

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]

    principals {
      type        = "AWS"
      identifiers = var.aws_accounts_allowed_to_pull
    }
  }
}

resource "aws_ecr_repository_policy" "allow_account_pull" {
  repository = aws_ecr_repository.this.name

  policy = data.aws_iam_policy_document.allow_account_pull.json
}

resource "aws_ecr_lifecycle_policy" "basic" {
  repository = aws_ecr_repository.this.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last ${var.images_retention_count} images with tag prefix ${replace(join(",", var.images_retention_tag_prefix_list), ",", " and ")}",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ${jsonencode(var.images_retention_tag_prefix_list)},
        "countType": "imageCountMoreThan",
        "countNumber": ${var.images_retention_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

