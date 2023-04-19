data "aws_iam_policy_document" "this" {
  for_each = { for k, v in local.rotation_cfg : k => v if v["create_default_iam_policy_for_rotation"] }
  statement {
    sid = "AllowSecretsManager"
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecretVersionStage",
    ]
    resources = [each.value["is_lookup_by_name"] ? data.aws_secretsmanager_secret.lookup_by_name[each.key].id : data.aws_secretsmanager_secret.lookup_by_arn[each.key].id]
    effect    = "Allow"
  }

  statement {
    sid = "AllowRandomPassword"
    actions = [
      "secretsmanager:GetRandomPassword"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowEC2"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DetachNetworkInterface",
      "ec2:UnassignPrivateIpAddresses"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowCWLogs"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowRDS"
    actions = [
      "rds:DescribeGlobalClusters",
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:ModifyDBInstance",
      "rds:ModifyDBCluster"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowDocumentDB"
    actions = [
      "docdb:DescribeDBClusterParameters",
      "docdb:DescribeDBClusters",
      "docdb:ModifyDBCluster",
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowKMS"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "this" {
  for_each    = { for k, v in local.rotation_cfg : k => v if v["create_default_iam_policy_for_rotation"] }
  name        = "${each.key}-rotation-policy"
  description = "Secrets Manager Rotation Policy for ${each.key}"
  policy      = data.aws_iam_policy_document.this[each.key].json
}
