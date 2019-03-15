resource "aws_ecr_repository" "this" {
  name = "${var.name}"
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
      identifiers = ["${var.aws_accounts_allowed_to_pull}"]
    }
  }
}

resource "aws_ecr_repository_policy" "allow_account_pull" {
  repository = "${aws_ecr_repository.this.name}"

  policy = "${data.aws_iam_policy_document.allow_account_pull.json}"
}
