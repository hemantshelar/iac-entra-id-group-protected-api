#https://learn.microsoft.com/en-us/azure/key-vault/keys/quick-create-terraform?tabs=azure-cli
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.env}-${var.tla}-${var.location-suffix}"
  location                    = "${var.rg-location}" 
  resource_group_name         = "${var.rgname}"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization = true
  
  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = ["List", "Create", "Delete", "Get", "Purge", "Recover", "Update", "GetRotationPolicy", "SetRotationPolicy"]
    secret_permissions = ["Set"]
  }
}

resource "azurerm_role_assignment" "kvra" {
    scope                = azurerm_key_vault.kv.id
    role_definition_name = "Key Vault Secrets Officer"
    principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "kvsecret" {
  name         = "example-secret"
  value        = "example-value"
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [ azurerm_role_assignment.kvra ]
}

resource "azurerm_role_assignment" "uami_kv_access" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.uami_principal_id
}

