terraform {
  # Terraform Cloud
  cloud {
   organization = "terraform-bootcamp-23"
   workspaces {
     name = "terra-house-1"
   }
  }
  
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

module "home_pancake_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.pancake.public_path
  content_version = var.pancake.content_version
}

resource "terratowns_home" "home" {
  name = "Fluffy Pancakes!"
  description = <<DESCRIPTION
Fluffy pancakes are thick, airy, and soft breakfast cakes made from a batter typically 
containing flour, eggs, milk, and leavening agents like baking powder. When cooked, 
they have a light and airy texture, making them a favorite breakfast option.
DESCRIPTION
  domain_name = module.home_pancake_hosting.domain_name
  town = "missingo"
  content_version = var.pancake.content_version
}

module "home_jollof_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.jollof.public_path
  content_version = var.jollof.content_version
}

resource "terratowns_home" "home_jollof" {
  name = "Jollof Rice"
  description = <<DESCRIPTION
Jollof rice is a beloved Nigerian dish often served at special occasions. 
This classic recipe embodies richness, flavor, and elegance, 
with rice simmered in a vibrant blend of peppers, broth, seasoning, and spices all in one pot. 
Pair this delightful dish with your preferred protein for a satisfying meal.
DESCRIPTION
  domain_name = module.home_jollof_hosting.domain_name
  town = "missingo"
  content_version = var.jollof.content_version
}
