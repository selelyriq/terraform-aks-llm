include {
  path = find_in_parent_folders()
}

dependency "bootstrap" {
  config_path = "../bootstrap"

  mock_outputs = {
    resource_group_name    = "mock-rg"
    storage_account_name   = "mockstorage"
    storage_container_name = "mockcontainer"
  }
}

terraform {
  source = "../../../modules/core-cluster"
}
