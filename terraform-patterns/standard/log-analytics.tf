# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
# Resource to create a Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "log-analytics-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}