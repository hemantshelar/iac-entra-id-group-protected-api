//asp-dev-tfdemo-aae
resource "azurerm_service_plan" "spdefault" {
  name                = "asp-${var.github_environment}-${var.tla}-${var.location-suffix}"
  resource_group_name = "${var.rgname}"
  location            = "${var.rg-location}"
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "web-${var.github_environment}-${var.tla}-${var.location-suffix}"
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
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = "${var.instrumentation_key}"
    APPLICATIONINSIGHTS_CONNECTION_STRING = "${var.connection_string}"
  }
}

resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  repo_url           = "https://github.com/hemantshelar/entra-id-group-protected-api"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false
}