output "test_output" {
  value = "Hello, World!"
}

output "webapp-tfdemo-identity" {
  #value = module.AppService.webapp-tfdemo-identity
  value = "test1"
}
output "webapp-tfdemo-identity-sami" {
  #value = module.AppService.webapp-tfdemo-identity[0].principal_id
  value = "test2"
}