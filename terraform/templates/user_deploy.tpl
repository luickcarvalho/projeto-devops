{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
       "ecs:UpdateService",
       "ecs:RegisterTaskDefinition",
       "ecs:ListTaskDefinitions",
       "ecr:GetAuthorizationToken",
       "ecr:DescribeImages",
       "ecr:CompleteLayerUpload",
       "ecr:GetAuthorizationToken",
       "ecr:UploadLayerPart",
       "ecr:InitiateLayerUpload",
       "ecr:BatchCheckLayerAvailability",
       "ecr:PutImage",
       "ecr:DescribeRepositories",
       "ecs:DescribeTaskDefinition",
       "ecs:DescribeServices",
       "ecs:DeregisterTaskDefinition",
       "iam:Passrole",
       "ecs:TagResource"
    ],
      "Resource": "*"
    },
    {
    "Effect": "Allow",
    "Action": "secretsmanager:GetSecretValue",
    "Resource": "*"
    }
  ]
}
