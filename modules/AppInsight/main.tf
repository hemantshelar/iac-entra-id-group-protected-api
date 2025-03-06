resource "azurerm_application_insights" "appinsight" {
  name                = "appinsight-${var.env}-${var.tla}-${var.location-suffix}"
  location            = "${var.rg-location}"
  resource_group_name = "${var.rgname}"
  application_type    = "web"
  workspace_id = var.law_id
}