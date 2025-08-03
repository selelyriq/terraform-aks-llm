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

# Data source to find the Network Security Group created by AKS
data "azurerm_resources" "aks_nsg" {
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
  type                = "Microsoft.Network/networkSecurityGroups"
}

# Add a rule to the AKS-created NSG to allow HTTPS traffic
resource "azurerm_network_security_rule" "allow_https_inbound" {
  name                        = "AllowHTTPSInboundFromInternet"
  priority                    = 101 # Lower number = higher priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_kubernetes_cluster.aks.node_resource_group
  network_security_group_name = data.azurerm_resources.aks_nsg.resources[0].name
}

# Add a rule to the AKS-created NSG to allow HTTP traffic
resource "azurerm_network_security_rule" "allow_http_inbound" {
  name                        = "AllowHTTPInboundFromInternet"
  priority                    = 102 # Runs after the HTTPS rule
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_kubernetes_cluster.aks.node_resource_group
  network_security_group_name = data.azurerm_resources.aks_nsg.resources[0].name
}

