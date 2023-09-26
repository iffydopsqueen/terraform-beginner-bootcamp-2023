terraform {
  # Terraform Cloud
  #cloud {
  #  organization = "terraform-bootcamp-23"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  
  # Providers
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}