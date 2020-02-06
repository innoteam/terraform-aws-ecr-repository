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

locals {
  lifecycle_policy_description_any    = "Keep last ${var.images_retention_count} images"
  lifecycle_policy_description_tagged = "${local.lifecycle_policy_description_any} with tag prefix ${replace(join(",", var.images_retention_tag_prefix_list), ",", " and ")}"
  lifecycle_policy_templates = {
    "any"    = data.template_file.aws_ecr_lifecycle_policy_any.rendered
    "tagged" = data.template_file.aws_ecr_lifecycle_policy_tagged.rendered
  }
}

data "template_file" "aws_ecr_lifecycle_policy_any" {
  template = "${file("${path.module}/templates/aws_ecr_lifecycle_policy_any.tpl")}"

  vars = {
    description  = local.lifecycle_policy_description_any
    tag_status   = "any"
    count_number = var.images_retention_count
  }
}

data "template_file" "aws_ecr_lifecycle_policy_tagged" {
  template = "${file("${path.module}/templates/aws_ecr_lifecycle_policy_tagged.tpl")}"

  vars = {
    description     = local.lifecycle_policy_description_tagged
    tag_status      = "tagged"
    tag_prefix_list = "${jsonencode(var.images_retention_tag_prefix_list)}"
    count_number    = var.images_retention_count
  }
}

resource "aws_ecr_lifecycle_policy" "basic" {
  repository = aws_ecr_repository.this.name

  policy = local.lifecycle_policy_templates[var.images_retention_tag_status]
}

