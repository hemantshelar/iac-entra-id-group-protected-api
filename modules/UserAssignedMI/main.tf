resource "azurerm_user_assigned_identity" "uami" {
  location            = "${var.rg-location}" 
  name                = "uami-${var.env}-${var.tla}-${var.location-suffix}"
  resource_group_name = "${var.rgname}"
}