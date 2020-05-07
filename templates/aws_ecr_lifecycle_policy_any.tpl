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
      "description": "${any_description}",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${any_retention_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
