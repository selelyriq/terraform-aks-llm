include {
  path = find_in_parent_folders()
}

dependency "infrastructure" {
  config_path = "../01-infrastructure"
  mock_outputs = {
    kube_config = {
      host                   = "https://mock.azmk8s.io"
      client_certificate     = "mock"
      client_key             = "mock"
      cluster_ca_certificate = "mock"
    }
  }
}

terraform {
  source = "../../../modules/cluster-addons"
}

inputs = {
  kube_config = dependency.infrastructure.outputs.kube_config
}
