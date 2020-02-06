{
  "rules": [
    {
      "rulePriority": 1,
      "description": "${description}",
      "selection": {
        "tagStatus": "${tag_status}",
        "countType": "imageCountMoreThan",
        "countNumber": ${count_number}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
