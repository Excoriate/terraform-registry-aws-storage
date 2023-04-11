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
    // Custom policy passed.
    iam_policy_documents_to_attach = [
      {
        sid     = "TestAtttachedStatement"
        effect  = "Allow"
        actions = ["s3:PutObject"]
        principals = [
          {
            type        = "Service"
            identifiers = ["ecs.amazonaws.com"]
          }
        ]
        conditions = [
          {
            test     = "StringEquals"
            variable = "s3:x-amz-server-side-encryption"
            values   = ["AES256"]
          }
        ]
      }
    ]
  }
]
