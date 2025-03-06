# Purpose: Create a resource group in Azure
# Usage: rg-dev-tfdemo-aae

resource "azurerm_resource_group" "rg" {
  name =   "rg-${var.env}-${var.tla}-${var.location-suffix}"
  location = "${var.rg-location}"
  tags = {
        environment = "${var.environment}"
    }
}