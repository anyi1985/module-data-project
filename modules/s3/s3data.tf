data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "anyikey_policy" {
  statement {
    sid    = "allow root access to this key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

}
