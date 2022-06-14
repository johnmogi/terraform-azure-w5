# Azure Provider source and version being used
terraform {
  required_version = ">=0.15.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.56.0"
    }
  }

  # We recommend using a remote backend like Azure storage 
  #    backend "azurerm" {
  #      storage_account_name = "" // existing storage account
  #      container_name       = "tfstate"
  #      key                  = "terraform.tfstate"
  #      resource_group_name  = "" // resource group where storage account exists
  #    }
  #
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}