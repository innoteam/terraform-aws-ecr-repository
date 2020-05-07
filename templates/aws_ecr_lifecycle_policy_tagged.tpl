{
  "rules": [
    {
      "rulePriority": 1,
      "description": "${untagged_description}",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": ${untagged_retention_days}
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "${tagged_description}",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ${tagged_tag_prefix_list},
        "countType": "imageCountMoreThan",
        "countNumber": ${tagged_retention_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
