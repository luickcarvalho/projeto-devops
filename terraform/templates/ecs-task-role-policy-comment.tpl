{
    "Version": "2012-10-17",
    "Statement": [
      {
          "Action": [
              "ssmmessages:OpenDataChannel",
              "ssmmessages:OpenControlChannel",
              "ssmmessages:CreateDataChannel",
              "ssmmessages:CreateControlChannel"
          ],
          "Effect": "Allow",
          "Resource": "*",
          "Sid": "AllowSsmExec"
      },
      {
            "Action": [
                "secretsmanager:ListSecrets",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "SecretsRead"
      }
    ]
}
