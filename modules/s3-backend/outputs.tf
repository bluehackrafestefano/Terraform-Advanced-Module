output "s3_backend_name" {
  value = aws_s3_bucket.tf_remote_state.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.tf_remote_state_lock.name
}
