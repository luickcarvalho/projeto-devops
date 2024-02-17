data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["my_vpc"]
  }
}

data "aws_subnet" "subnet-a" {
  filter {
    name   = "tag:Name"
    values = ["subnet-prd-a"]
  }
}

data "aws_subnet" "subnet-b" {
  filter {
    name   = "tag:Name"
    values = ["subnet-prd-b"]
  }
}

data "aws_subnet" "subnet-c" {
  filter {
    name   = "tag:Name"
    values = ["subnet-prd-c"]
  }
}

data "aws_subnet" "subnet-d" {
  filter {
    name   = "tag:Name"
    values = ["subnet-prd-d"]
  }
}