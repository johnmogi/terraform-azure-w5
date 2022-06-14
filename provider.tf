# Azure Provider source and version being used
terraform {
  required_version = ">=0.15.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.56.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # subscription_id   = "${env.ARM_SUBSCRIPTION_ID}"
  # tenant_id         = "${env.ARM_TENANT_ID}"
  # client_id         = "${env.ARM_CLIENT_ID}"
  # client_secret     = "${env.ARM_CLIENT_SECRET}"

}