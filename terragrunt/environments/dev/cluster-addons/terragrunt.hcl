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
