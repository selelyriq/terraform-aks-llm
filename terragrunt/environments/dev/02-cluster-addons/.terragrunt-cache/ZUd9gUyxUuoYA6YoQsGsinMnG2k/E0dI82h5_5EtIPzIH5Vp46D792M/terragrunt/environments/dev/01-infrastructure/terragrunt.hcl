include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/core-cluster"
}

inputs = {
  resource_group_name = "DefaultResourceGroup-EUS"
  location            = "eastus" # Matching your resource group
}
