include {
  path = find_in_parent_folders()
}

dependency "core-cluster" {
  config_path = "../core-cluster"
  mock_outputs = {
    kube_config = ""
  }
}

terraform {
  source = "../../../modules/cluster-addons"
}

inputs = {
  kube_config = dependency.core-cluster.outputs.kube_config
}
