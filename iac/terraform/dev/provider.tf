provider "aws" {
  region = "us-east-1"

}

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "jhtoigo-terraform-linuxtips"
    key    = "tf-intensivo/projeto-final/apps/node-pg-test"
    region = "us-east-1"
  }
}