remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = dependency.bootstrap.outputs.resource_group_name
    storage_account_name = dependency.bootstrap.outputs.storage_account_name
    container_name       = dependency.bootstrap.outputs.storage_container_name
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

dependency "bootstrap" {
  config_path = "${get_parent_terragrunt_dir()}/bootstrap"
}

inputs = {
  environment = "dev"
}
