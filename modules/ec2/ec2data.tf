data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    sid     = "grantaccesstoec2"
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ec2-s3-DyDB-role-policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListBucket",
      "s3:PutObject"
    ]
    sid    = "ec2s3rolepolicy"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::arn:aws:s3:::terraform-creds",
      "arn:aws:s3:::var.arn:aws:s3:::terraform-creds/*"
    ]
  }
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:ListTables",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable"
    ]
    sid    = "ec2dydbrolepolicy"
    effect = "Allow"
    resources = [
      "arn:aws:dynamodb:*:${data.aws_caller_identity.current.account_id}:table/terraform-dynamoDB"
    ]
  }

}
