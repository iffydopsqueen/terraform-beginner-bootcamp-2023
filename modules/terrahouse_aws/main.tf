terraform {
  # Providers
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
# this is to get our AWS_ACCOUNT_ID from AWS
# "data" is used to fetch data from cloud resources 
data "aws_caller_identity" "current" {}