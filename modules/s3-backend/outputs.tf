output "s3_backend_name" {
  value = aws_s3_bucket.tf-remote-state.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.tf-remote-state-lock.name
}
