include {
  path = find_in_parent_folders()
}

dependency "bootstrap" {
  config_path = "../bootstrap"
}

terraform {
  source = "../../../modules/core-cluster"
}
