terraform {
  backend "s3" {
    bucket         = "bucketforelvis"
    key            = "backend/elvis_terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "presley"
  }
}