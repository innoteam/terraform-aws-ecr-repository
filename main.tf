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

# -------------------------------------------------------------------------------
# The policy is composed of these rules:
# - Keep x images with:
# - - 'any' tag
# - - (or) with tags that have a 'specified' list of prefixes
# - Keep for x days images without tags
# -------------------------------------------------------------------------------

locals {
  lifecycle_policy_rule_any_description      = "Keep last ${var.images_retention_count} images"
  lifecycle_policy_rule_tagged_description   = "${local.lifecycle_policy_rule_any_description} with tag prefix ${replace(join(",", var.images_retention_tag_prefix_list), ",", " and ")}"
  lifecycle_policy_rule_untagged_description = "Keep untagged images for ${var.untagged_images_retention_days} days"
  lifecycle_policy_templates = {
    "any"    = data.template_file.aws_ecr_lifecycle_policy_any.rendered
    "tagged" = data.template_file.aws_ecr_lifecycle_policy_tagged.rendered
  }
}

data "template_file" "aws_ecr_lifecycle_policy_any" {
  template = "${file("${path.module}/templates/aws_ecr_lifecycle_policy_any.tpl")}"

  vars = {
    any_description         = local.lifecycle_policy_rule_any_description
    any_retention_count     = var.images_retention_count
    untagged_description    = local.lifecycle_policy_rule_untagged_description
    untagged_retention_days = var.untagged_images_retention_days
  }
}

data "template_file" "aws_ecr_lifecycle_policy_tagged" {
  template = "${file("${path.module}/templates/aws_ecr_lifecycle_policy_tagged.tpl")}"

  vars = {
    tagged_description      = local.lifecycle_policy_rule_tagged_description
    tagged_tag_prefix_list  = "${jsonencode(var.images_retention_tag_prefix_list)}"
    tagged_retention_count  = var.images_retention_count
    untagged_description    = local.lifecycle_policy_rule_untagged_description
    untagged_retention_days = var.untagged_images_retention_days
  }
}

resource "aws_ecr_lifecycle_policy" "basic" {
  repository = aws_ecr_repository.this.name

  policy = local.lifecycle_policy_templates[var.images_retention_tag_status]
}
