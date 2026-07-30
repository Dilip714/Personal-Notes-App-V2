resource "aws_s3_bucket" "assets" {
  bucket = "${var.project_name}-static-assets-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-static-assets"
  }
}

data "aws_caller_identity" "current" {}

# Versioning lets you upload new CSS/JS/images without losing the ability
# to roll back to a previous version.
resource "aws_s3_bucket_versioning" "assets" {
  bucket = aws_s3_bucket.assets.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "assets" {
  bucket                  = aws_s3_bucket.assets.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
