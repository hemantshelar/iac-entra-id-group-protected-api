//asp-dev-tfdemo-aae
resource "azurerm_service_plan" "spdefault" {
  name                = "asp-${var.env}-${var.tla}-${var.location-suffix}"
  resource_group_name = "${var.rgname}"
  location            = "${var.rg-location}"
  os_type             = "Linux"
  sku_name            = "F1"
}

//webapp-dev-tfdemo-aae

resource "azurerm_linux_web_app" "webapp" {
  name                = "web-${var.env}-${var.tla}-${var.location-suffix}"
  resource_group_name = "${var.rgname}"
  location            = "${var.rg-location}" 
  service_plan_id     = azurerm_service_plan.spdefault.id
  key_vault_reference_identity_id = var.uami_principal_id

  identity {
    type = "UserAssigned"
    identity_ids = [var.uami_principal_id] 
  }

    connection_string {
        name  = "Database"
        type  = "MySql"
        value = "Server=myServerAddress;Database=myDataBase;Uid=myUsername;Pwd=myPassword;"
    }
  site_config {
    always_on = false 
    application_stack {
        dotnet_version = "8.0"
    }
  }
}