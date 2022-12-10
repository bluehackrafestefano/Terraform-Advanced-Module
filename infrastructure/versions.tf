terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.45.0"
    }
  }
  backend "s3" {
    bucket         = "tf-s3-bucket-backend-task-mx21i8l204"
    key            = "env/dev/tf-remote-backend.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-s3-app-lock-mx21i8l204"
    encrypt        = true
  }
}
