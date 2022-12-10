variable "bucket-name" {
  type        = string
  default     = "tf-s3-bucket-backend-task"
  description = "The name of the backend-s3 bucket"
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The server-side encryption algorithm to use. `AES256` or `aws:kms`"
}

variable "backend_s3_key" {
  type        = string
  default     = "env/dev/tf-remote-backend.tfstate"
  description = "The Terraform state is written to the key"
}

variable "dynamodb_table" {
  type        = string
  default     = "tf-s3-app-lock"
  description = "To enable locking"
}
