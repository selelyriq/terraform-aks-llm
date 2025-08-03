include {
  path = find_in_parent_folders()
}

dependency "bootstrap" {
  config_path = "../bootstrap"
}

terraform {
  source = "../../../modules/cluster-addons"
}

dependencies {
  paths = ["../core-cluster"]
}

dependency "core-cluster" {
  config_path = "../core-cluster"
}

inputs = {
  kube_config = dependency.core-cluster.outputs.kube_config
}
