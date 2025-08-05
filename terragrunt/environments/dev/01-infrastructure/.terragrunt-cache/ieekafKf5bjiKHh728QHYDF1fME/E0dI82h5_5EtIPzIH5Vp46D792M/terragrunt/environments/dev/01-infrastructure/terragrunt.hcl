include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}//terragrunt/modules/core-cluster"
}

inputs = {
  resource_group_name = "DefaultResourceGroup-EUS"
  location            = "eastus" # Matching your resource group
}
