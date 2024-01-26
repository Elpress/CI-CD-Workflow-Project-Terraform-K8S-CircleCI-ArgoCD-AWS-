terraform {
  backend "s3" {
    bucket         = "bucketforelvis"
    key            = ".terraform\terraform.tfstate"
    region         = "us-east-1"
#    dynamodb_table = "dynamoDB-state-locking"
  }
}