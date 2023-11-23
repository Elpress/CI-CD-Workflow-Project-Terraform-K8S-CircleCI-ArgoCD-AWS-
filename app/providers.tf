terraform {
  required_providers {
    source  = "hashicorp/aws"
    Version = "4.67.0"
  }
}

provider "aws" {
  region = var.REGION
}