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
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token   
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Fluffy Pancakes!"
  description = <<DESCRIPTION
Fluffy pancakes are thick, airy, and soft breakfast cakes made from a batter typically 
containing flour, eggs, milk, and leavening agents like baking powder. When cooked, 
they have a light and airy texture, making them a favorite breakfast option.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 2
}

