terraform {
  backend "s3" {
    bucket         = "elvis_bucket"
    key            = "backend/elvis_terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamoDB-state-locking"
  }
}