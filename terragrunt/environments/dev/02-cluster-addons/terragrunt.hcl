include "root" {
  path = find_in_parent_folders("root.hcl")
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
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

terraform {
  source = "${get_repo_root()}//terragrunt/modules/cluster-addons"
}

inputs = {
  kube_config = try(
    dependency.infrastructure.outputs.kube_config,
    {
      host                   = "https://mock.azmk8s.io"
      client_certificate     = "mock"
      client_key             = "mock"
      cluster_ca_certificate = "mock"
    }
  )
}
