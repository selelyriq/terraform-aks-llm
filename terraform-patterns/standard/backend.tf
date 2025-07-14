terraform {
    backend "azurerm" {
        resource_group_name = "DefaultResourceGroup-EUS"
        storage_account_name = "lyriqseleterraform"
        container_name = "backend"
        key = "terraform.tfstate"
    }
}