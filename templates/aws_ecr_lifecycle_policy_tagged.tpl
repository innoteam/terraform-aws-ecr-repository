{
  "rules": [
    {
      "rulePriority": 1,
      "description": "${description}",
      "selection": {
        "tagStatus": "${tag_status}",
        "tagPrefixList": ${tag_prefix_list},
        "countType": "imageCountMoreThan",
        "countNumber": ${count_number}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
