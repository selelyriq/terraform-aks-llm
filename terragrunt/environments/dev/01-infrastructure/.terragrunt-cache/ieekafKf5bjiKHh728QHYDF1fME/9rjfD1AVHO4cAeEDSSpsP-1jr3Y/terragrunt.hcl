include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/core-cluster"
}

inputs = {
  resource_group_name = "DefaultResourceGroup-EUS"
  location            = "eastus" # Matching your resource group
}
