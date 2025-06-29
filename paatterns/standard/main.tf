# Terraform version management
terraform {
  required_version = "~> 1.12.2"
  # Terraform provider version management
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.12.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# AzureRM provider configuration
provider "azurerm" {
  features {}
}

# # Terraform backend configuration
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "terraform-state"
#     storage_account_name = "terraformstate"
#     container_name       = "terraform-state"
#     key                  = "terraform.tfstate"
#   }
# }

