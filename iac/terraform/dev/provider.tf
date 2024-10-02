provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "jhtoigo-terraform-linuxtips"
    key    = "tf-intensivo/projeto-final/apps/node-pg-test"
    region = "us-east-1"
  }
}