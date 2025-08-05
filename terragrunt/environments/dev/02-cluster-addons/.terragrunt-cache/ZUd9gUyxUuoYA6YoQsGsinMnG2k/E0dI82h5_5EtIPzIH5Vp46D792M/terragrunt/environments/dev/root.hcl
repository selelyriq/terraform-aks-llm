remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "DefaultResourceGroup-EUS"
    storage_account_name = "lyriqseleterraform"
    container_name       = "backend"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

inputs = {
  environment = "dev"
}
