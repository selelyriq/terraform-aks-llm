terraform {
  required_version = "~> 1.12.2"
  backend "local" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "state" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.state.name
  location                 = azurerm_resource_group.state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "state" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"
}
