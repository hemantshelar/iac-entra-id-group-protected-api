
output "webapp-tfdemo-identity" {
  value = azurerm_linux_web_app.webapp.identity
}

output "service_plan_id" {
  value = azurerm_service_plan.spdefault.id 
}