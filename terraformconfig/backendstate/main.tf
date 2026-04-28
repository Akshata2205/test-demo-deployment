provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "backend_state_bucket"{
  bucket="demo-application-backend-state-123"
  lifecycle{
    prevent_destroy=true
  }
}

resource "aws_s3_bucket_versioning" "backend_state_bucket_versioning" {
  bucket = aws_s3_bucket.backend_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend_state_bucket_encryption" {
  bucket = aws_s3_bucket.backend_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "backend_locks"{
  name="demo_application_lock"
  billing_mode="PAY_PER_REQUEST"
  hash_key="LockID"
  attribute{
    name="LockID"
    type= "S"
  }
}
