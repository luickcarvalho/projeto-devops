terraform {
  required_version = "~> 1.7.3"

  backend "s3" {
    bucket         = "s3-prd-infra-lk-terraform-state"
    region         = "us-east-1"
    encrypt        = true
    profile = "default"
  }
}