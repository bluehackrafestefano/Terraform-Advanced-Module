module "s3_backend" {
  source  = "bluehackrafestefano/s3-backend/aws"
  version = "2.0.1"
}

output "s3_backend_bucket_name" {
  value = module.s3_backend.s3_backend_name
}

output "aws_dynamodb_table" {
  value = module.s3_backend.dynamodb_table
}
