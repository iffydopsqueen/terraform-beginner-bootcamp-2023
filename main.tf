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
    # aws = {
    #   source = "hashicorp/aws"
    #   version = "5.16.2"
    # }

    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint = "http://localhost:4567"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1"  # mock data 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"    # mock data
}

# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }