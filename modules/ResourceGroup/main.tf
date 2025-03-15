# Purpose: Create a resource group in Azure
# Usage: rg-dev-tfdemo-aae

resource "azurerm_resource_group" "rg" {
  name =   join("-", [var.resource_group_prefix, var.github_environment,var.tla,var.location_suffix])
  location = "${var.rg_location}"
  tags = {
        environment = "${var.github_environment}"
    }
}