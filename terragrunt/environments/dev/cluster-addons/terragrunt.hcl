include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/cluster-addons"
}

dependencies {
  paths = ["../core-cluster"]
}

dependency "core-cluster" {
  config_path = "../core-cluster"
  mock_outputs = {
    kube_config = {
      host                   = "https://mock-host"
      client_certificate     = "mock-cert"
      client_key             = "mock-key"
      cluster_ca_certificate = "mock-ca-cert"
    }
  }
}

inputs = {
  kube_config = dependency.core-cluster.outputs.kube_config
}
