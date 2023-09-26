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
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "random" {
  # Configuration options
}