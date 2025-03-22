output "postmanPassword" {
    value = azuread_application_password.postmanPassword.value
}

output "clientid" {
    value = azuread_application.entraidapp.client_id
}

output "tenantid" {
    #value = data.azurerm_client_config.current.tenant_id
    value = data.azuread_client_config.current.tenant_id
}
output "domain" {
    value = "NETORGFT17726763.onmicrosoft.com" #Find out through query.
}