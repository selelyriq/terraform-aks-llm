# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool
# Resource to create a Linux Node Pool
resource "azurerm_kubernetes_cluster_node_pool" "linux_node_pool" {
  name                  = "linuxpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  zones = ["1", "2", "3"]

  enable_auto_scaling = true
  min_count           = 1
  max_count           = 3

  node_labels = {
    "nodepool-type" = "linux"
  }

  orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version

  vm_size         = "Standard_D2s_v3"
  node_count      = 3
  os_disk_size_gb = 30
  os_disk_type    = "Managed"
  os_sku          = "Ubuntu"
  os_type         = "Linux"

  priority = "Regular"
  mode = "User"
  node_taints = []

  tags = {
    environment = var.environment
  }
}