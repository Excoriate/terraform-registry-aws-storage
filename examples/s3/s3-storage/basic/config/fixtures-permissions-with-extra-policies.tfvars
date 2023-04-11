aws_region = "us-east-1"
is_enabled = true

bucket_config = [
  {
    name = "my-bucket"
  },
  {
    name = "with-permissions"
  }
]

bucket_permissions = [
  {
    name                          = "with-permissions"
    enable_encrypted_uploads_only = true
    enable_ssl_requests_only      = true
    iam_policy_documents_to_attach = [
      {
        name            = "extra-policy"
        policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "*"
      ]
    }
    ]
  }
EOF
      }
    ]
  }
]
