module "s3-backend" {
  source  = "bluehackrafestefano/s3-backend/aws"
  version = "1.0.0"
}

output "s3_backend_bucket_name" {
  value = module.s3-backend.s3_backend_name
}

output "aws_dynamodb_table" {
  value = module.s3-backend.dynamodb_table
}
