{
  "rules": [
    {
      "rulePriority": 1,
      "description": "${description}",
      "selection": {
        "tagStatus": "${tag_status}",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": ${retention_days}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
