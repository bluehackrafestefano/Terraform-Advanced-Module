resource "random_string" "random" {
  length  = 10 # Required
  upper   = false
  special = false
}

resource "aws_s3_bucket" "tf_remote_state" {
  bucket = "${var.bucket_name}-${random_string.random.result}"
  # Normally force_destroy must be false. 
  # Because if we delete s3 mistakenly, we lost all of the states.
  # Change it on  prod!
  force_destroy = true
}


resource "aws_s3_bucket_server_side_encryption_configuration" "mybackend" {
  bucket = aws_s3_bucket.tf_remote_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}


resource "aws_s3_bucket_versioning" "versioning_backend_s3" {
  bucket = aws_s3_bucket.tf_remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}


# NoSQL db with min requirements for locking of tf
resource "aws_dynamodb_table" "tf_remote_state_lock" {
  hash_key = "LockID"
  name     = "tf_s3_app_lock-${random_string.random.result}"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
