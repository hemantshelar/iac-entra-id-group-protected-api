//asp-dev-tfdemo-aae

resource "azurerm_linux_web_app" "webappangular" {
  name                = "webspa-${var.github_environment}-${var.tla}-${var.location-suffix}"
  resource_group_name = "${var.rgname}"
  location            = "${var.rg-location}" 
  service_plan_id     = var.service_plan_id
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
      node_version = "20-lts"
    }
  }
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = "${var.instrumentation_key}"
    APPLICATIONINSIGHTS_CONNECTION_STRING = "${var.connection_string}"
  }
}