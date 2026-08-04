terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Note: A senior setup uses an S3 backend here for remote state locking.
  # We will keep this commented out initially until we create the S3 bucket via CLI/code.
  # backend "s3" {
  #   bucket         = "coreops-3t-tfstate"
  #   key            = "state/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "coreops-3t-tflocks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "CoreOps-3T"
      ManagedBy = "Terraform"
    }
  }
}