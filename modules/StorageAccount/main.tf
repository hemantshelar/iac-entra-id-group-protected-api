resource "azurerm_storage_account" "example" {
  name                     = "strg${var.github_environment}${var.tla}${var.location-suffix}"
  resource_group_name      = "${var.rgname}" 
  location                 = "${var.rg-location}" 
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "${var.github_environment}"
  }
}