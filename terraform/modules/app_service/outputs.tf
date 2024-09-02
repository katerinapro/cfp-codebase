output "app_service_id" {
  value = azurerm_app_service.this.id
}
output "principal_id" {
  value = azurerm_app_service.this.identity[0].principal_id
}