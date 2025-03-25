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

resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webappangular.id
  repo_url           = "https://github.com/hemantshelar/entra-id-group-protected-spa-client"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false
  depends_on = [ azurerm_linux_web_app.webappangular ]
}