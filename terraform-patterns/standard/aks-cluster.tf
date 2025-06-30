# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# Resource to create an Azure Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.project_name}-${var.environment}-cluster"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-${var.project_name}-${var.environment}"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "aks-${var.project_name}-${var.environment}-node-rg"

  # Identity Configuration
  identity {
    type = "SystemAssigned"
  }

  # Microsoft Defender Configuration
  microsoft_defender {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"

  }
}

