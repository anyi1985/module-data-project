resource "aws_s3_bucket" "mods3bucket" {
  bucket = var.s3modbucket
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = "Module-s3Bucket"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.anyikey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "mods3bucket" {
  bucket = aws_s3_bucket.mods3bucket.id

  block_public_policy = true
}


resource "aws_kms_key" "anyikey" {
  description             = "This key is used to encrypt bucket objects"
  enable_key_rotation     = true
  deletion_window_in_days = 30
  policy                  = data.aws_iam_policy_document.anyikey_policy.json
}
