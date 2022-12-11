variable "bucket_name" {
  type        = string
  default     = "tf_s3_bucket_backend_task"
  description = "The name of the backend-s3 bucket"
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The server-side encryption algorithm to use. `AES256` or `aws:kms`"
}

variable "backend_s3_key" {
  type        = string
  default     = "env/dev/tf_remote_backend.tfstate"
  description = "The Terraform state is written to the key"
}

variable "dynamodb_table" {
  type        = string
  default     = "tf_s3_app_lock"
  description = "To enable locking"
}
