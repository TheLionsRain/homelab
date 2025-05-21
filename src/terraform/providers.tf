terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}

terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = var.deployment_subscription_id
  features {}
}
