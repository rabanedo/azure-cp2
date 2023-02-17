####################################################### main.tf #######################################################

# INFO: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.43.0"
    }
  }
  required_version = ">= 1.1.0"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # Configuration options
  features {
    prevent_deletion_if_contains_resources = true
  }
}
