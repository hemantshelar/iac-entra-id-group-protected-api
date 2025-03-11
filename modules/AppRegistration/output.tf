output "postmanPassword" {
    value = azuread_application_password.postmanPassword.value
}

output "clientid" {
    value = azuread_application.entraidapp.client_id
}