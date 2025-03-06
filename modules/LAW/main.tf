
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.env}-${var.tla}-${var.location-suffix}"
  location            = "${var.rg-location}"
  resource_group_name = "${var.rgname}"
  sku                 = "PerGB2018"
  retention_in_days   = 30
}