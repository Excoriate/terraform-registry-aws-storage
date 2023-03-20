module "main_module" {
  source     = "../../../modules/secrets-manager-permissions"
  is_enabled = var.is_enabled
  aws_region = var.aws_region
  secret_permissions = [
    {
      name         = "test1"
      secret_name  = "test/terraform"
      permissions  = ["GetSecretValue"]
      allow        = true
      iam_role_arn = aws_iam_role.fake_role.arn
    }
  ]
}

resource "aws_iam_role" "fake_role" {
  name               = "test_role"
  assume_role_policy = data.aws_iam_policy_document.fake_assume_role_policy.json
}

data "aws_iam_policy_document" "fake_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
