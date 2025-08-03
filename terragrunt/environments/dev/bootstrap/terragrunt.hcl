terraform {
  source = "../../modules/bootstrap"
}

inputs = {
  resource_group_name    = "tfstate"
  location               = "East US"
  storage_account_name   = "tfstate${random_string.suffix.result}"
  storage_container_name = "tfstate"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}
