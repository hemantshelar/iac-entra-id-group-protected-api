output "UserAssignedMI" {
  value = azurerm_user_assigned_identity.uami.id
}

output "uami_principal_id" {
  value = azurerm_user_assigned_identity.uami.principal_id
  
}