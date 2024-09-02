output "service_principal_id" {
  value = azuread_service_principal.this.id
}

output "service_principal_password" {
  value = azuread_service_principal_password.this.value
}
